#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
         "../convert-closures.rkt")
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
  (interp-lam-free-lang-v9 p)
  (interp-closure-lang-v9 (fail-if-invalid (convert-closures p)))))

(check-by-interp '(module empty))
(check-by-interp
 '(module
    (letrec ((fun/empty8472.4 (lambda ((free ())) () empty)))
      (unsafe-procedure-call fun/empty8472.4))))
(check-by-interp
 '(module
    (letrec ((fun/void8475.4 (lambda ((free ())) () (void))))
      (unsafe-procedure-call fun/void8475.4))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8478.4 (lambda ((free ())) () #\o)))
      (unsafe-procedure-call fun/ascii-char8478.4))))
(check-by-interp
 '(module
    (letrec ((*.56
              (lambda ((free ()))
                (tmp.18 tmp.19)
                (if (fixnum? tmp.19)
                  (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
                  (error 1)))))
      (unsafe-procedure-call *.56 152 188))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8483.4 (lambda ((free ())) (oprand0.6) #\O))
             (fun/void8484.5 (lambda ((free ())) (oprand0.7) (void))))
      (unsafe-procedure-call
       fun/ascii-char8483.4
       (unsafe-procedure-call fun/void8484.5 (error 109))))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.6
              (lambda ((free (vector-init-loop.6)))
                (len.7 i.9 vec.8)
                (if (eq? len.7 i.9)
                  vec.8
                  (begin
                    (unsafe-vector-set! vec.8 i.9 0)
                    (unsafe-procedure-call
                     vector-init-loop.6
                     len.7
                     (unsafe-fx+ i.9 1)
                     vec.8)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.6)))
                (tmp.4)
                (let ((tmp.5 (unsafe-make-vector tmp.4)))
                  (unsafe-procedure-call vector-init-loop.6 tmp.4 0 tmp.5))))
             (make-vector.56
              (lambda ((free (make-init-vector.1)))
                (tmp.32)
                (if (fixnum? tmp.32)
                  (unsafe-procedure-call make-init-vector.1 tmp.32)
                  (error 8)))))
      (if #f
        (unsafe-procedure-call make-vector.56 8)
        (unsafe-procedure-call make-vector.56 8)))))
(check-by-interp
 '(module
    (letrec ((cons.61
              (lambda ((free ())) (tmp.56 tmp.57) (cons tmp.56 tmp.57)))
             (fun/ascii-char8490.4 (lambda ((free ())) () #\w))
             (fun/error8491.5 (lambda ((free ())) (oprand0.7) (error 215)))
             (fun/ascii-char8489.6
              (lambda ((free (fun/ascii-char8490.4)))
                (oprand0.8)
                (unsafe-procedure-call fun/ascii-char8490.4))))
      (unsafe-procedure-call
       fun/ascii-char8489.6
       (unsafe-procedure-call
        fun/error8491.5
        (unsafe-procedure-call cons.61 139 270))))))
(check-by-interp '(module (if #t #t #t)))
(check-by-interp '(module (if #t (void) (void))))
(check-by-interp
 '(module
    (letrec ((cons.62
              (lambda ((free ())) (tmp.56 tmp.57) (cons tmp.56 tmp.57)))
             (vector-init-loop.11
              (lambda ((free (vector-init-loop.11)))
                (len.12 i.14 vec.13)
                (if (eq? len.12 i.14)
                  vec.13
                  (begin
                    (unsafe-vector-set! vec.13 i.14 0)
                    (unsafe-procedure-call
                     vector-init-loop.11
                     len.12
                     (unsafe-fx+ i.14 1)
                     vec.13)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.11)))
                (tmp.9)
                (let ((tmp.10 (unsafe-make-vector tmp.9)))
                  (unsafe-procedure-call vector-init-loop.11 tmp.9 0 tmp.10))))
             (make-vector.61
              (lambda ((free (make-init-vector.1)))
                (tmp.37)
                (if (fixnum? tmp.37)
                  (unsafe-procedure-call make-init-vector.1 tmp.37)
                  (error 8))))
             (fun/void8503.4 (lambda ((free ())) () (void)))
             (fun/void8502.5
              (lambda ((free (fun/void8503.4)))
                (oprand0.6)
                (unsafe-procedure-call fun/void8503.4))))
      (unsafe-procedure-call
       fun/void8502.5
       (let ((vector0.8 (unsafe-procedure-call make-vector.61 8))
             (void1.7 (void)))
         (unsafe-procedure-call cons.62 155 282))))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8507.4
              (lambda ((free ())) (oprand0.7 oprand1.6) oprand0.7))
             (fun/ascii-char8506.5
              (lambda ((free ())) (oprand0.9 oprand1.8) #\y)))
      (if (if #f #f #f)
        (unsafe-procedure-call fun/ascii-char8506.5 (error 196) (error 147))
        (unsafe-procedure-call fun/ascii-char8507.4 #\Y empty)))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.12
              (lambda ((free (vector-init-loop.12)))
                (len.13 i.15 vec.14)
                (if (eq? len.13 i.15)
                  vec.14
                  (begin
                    (unsafe-vector-set! vec.14 i.15 0)
                    (unsafe-procedure-call
                     vector-init-loop.12
                     len.13
                     (unsafe-fx+ i.15 1)
                     vec.14)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.12)))
                (tmp.10)
                (let ((tmp.11 (unsafe-make-vector tmp.10)))
                  (unsafe-procedure-call
                   vector-init-loop.12
                   tmp.10
                   0
                   tmp.11))))
             (make-vector.62
              (lambda ((free (make-init-vector.1)))
                (tmp.38)
                (if (fixnum? tmp.38)
                  (unsafe-procedure-call make-init-vector.1 tmp.38)
                  (error 8))))
             (fun/ascii-char8510.4
              (lambda ((free ())) (oprand0.6 oprand1.5) #\L)))
      (if (if #t #t #f)
        (let ((boolean0.9 #f) (ascii-char1.8 #\X) (error2.7 (error 47))) #\C)
        (unsafe-procedure-call
         fun/ascii-char8510.4
         (unsafe-procedure-call make-vector.62 8)
         (unsafe-procedure-call make-vector.62 8))))))
(check-by-interp
 '(module
    (letrec ((|+.62|
              (lambda ((free ()))
                (tmp.25 tmp.26)
                (if (fixnum? tmp.26)
                  (if (fixnum? tmp.25) (unsafe-fx+ tmp.25 tmp.26) (error 2))
                  (error 2))))
             (fixnum?.61 (lambda ((free ())) (tmp.46) (fixnum? tmp.46)))
             (fun/empty8524.4 (lambda ((free ())) () empty))
             (fun/empty8523.5 (lambda ((free ())) () empty)))
      (let ((boolean0.8 (unsafe-procedure-call fixnum?.61 #\]))
            (procedure1.7
             (letrec ((lam.63
                       (lambda ((free (|+.62|)))
                         ()
                         (unsafe-procedure-call |+.62| 63 160))))
               lam.63))
            (empty2.6 (unsafe-procedure-call fun/empty8523.5)))
        (unsafe-procedure-call fun/empty8524.4)))))
(check-by-interp
 '(module
    (letrec ((fun/error8530.4 (lambda ((free ())) () (error 140)))
             (fun/ascii-char8528.5 (lambda ((free ())) () #\C))
             (fun/void8529.6 (lambda ((free ())) () (void)))
             (fun/void8527.7 (lambda ((free ())) () (void))))
      (let ((void0.10 (unsafe-procedure-call fun/void8527.7))
            (ascii-char1.9 (unsafe-procedure-call fun/ascii-char8528.5))
            (void2.8 (unsafe-procedure-call fun/void8529.6)))
        (unsafe-procedure-call fun/error8530.4)))))
(check-by-interp
 '(module
    (letrec ((>.63
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx> tmp.34 tmp.35) (error 6))
                  (error 6))))
             (vector-init-loop.12
              (lambda ((free (vector-init-loop.12)))
                (len.13 i.15 vec.14)
                (if (eq? len.13 i.15)
                  vec.14
                  (begin
                    (unsafe-vector-set! vec.14 i.15 0)
                    (unsafe-procedure-call
                     vector-init-loop.12
                     len.13
                     (unsafe-fx+ i.15 1)
                     vec.14)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.12)))
                (tmp.10)
                (let ((tmp.11 (unsafe-make-vector tmp.10)))
                  (unsafe-procedure-call
                   vector-init-loop.12
                   tmp.10
                   0
                   tmp.11))))
             (make-vector.62
              (lambda ((free (make-init-vector.1)))
                (tmp.38)
                (if (fixnum? tmp.38)
                  (unsafe-procedure-call make-init-vector.1 tmp.38)
                  (error 8))))
             (fun/vector8533.4
              (lambda ((free (make-vector.62)))
                ()
                (unsafe-procedure-call make-vector.62 8)))
             (fun/error8534.5 (lambda ((free ())) () (error 165)))
             (fun/vector8535.6
              (lambda ((free (make-vector.62)))
                ()
                (unsafe-procedure-call make-vector.62 8))))
      (let ((vector0.9 (unsafe-procedure-call fun/vector8533.4))
            (error1.8 (unsafe-procedure-call fun/error8534.5))
            (boolean2.7 (unsafe-procedure-call >.63 166 150)))
        (unsafe-procedure-call fun/vector8535.6)))))
(check-by-interp
 '(module
    (letrec ((ascii-char?.60
              (lambda ((free ())) (tmp.48) (ascii-char? tmp.48)))
             (vector-init-loop.9
              (lambda ((free (vector-init-loop.9)))
                (len.10 i.12 vec.11)
                (if (eq? len.10 i.12)
                  vec.11
                  (begin
                    (unsafe-vector-set! vec.11 i.12 0)
                    (unsafe-procedure-call
                     vector-init-loop.9
                     len.10
                     (unsafe-fx+ i.12 1)
                     vec.11)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.9)))
                (tmp.7)
                (let ((tmp.8 (unsafe-make-vector tmp.7)))
                  (unsafe-procedure-call vector-init-loop.9 tmp.7 0 tmp.8))))
             (make-vector.59
              (lambda ((free (make-init-vector.1)))
                (tmp.35)
                (if (fixnum? tmp.35)
                  (unsafe-procedure-call make-init-vector.1 tmp.35)
                  (error 8))))
             (fun/vector8538.4
              (lambda ((free (make-vector.59)))
                (oprand0.6 oprand1.5)
                (unsafe-procedure-call make-vector.59 8))))
      (if (unsafe-procedure-call ascii-char?.60 214)
        (unsafe-procedure-call fun/vector8538.4 (error 247) (error 206))
        (if #t
          (unsafe-procedure-call make-vector.59 8)
          (unsafe-procedure-call make-vector.59 8))))))
(check-by-interp
 '(module
    (letrec ((|+.63|
              (lambda ((free ()))
                (tmp.24 tmp.25)
                (if (fixnum? tmp.25)
                  (if (fixnum? tmp.24) (unsafe-fx+ tmp.24 tmp.25) (error 2))
                  (error 2))))
             (procedure?.62 (lambda ((free ())) (tmp.54) (procedure? tmp.54)))
             (fixnum?.61 (lambda ((free ())) (tmp.45) (fixnum? tmp.45)))
             (vector-init-loop.10
              (lambda ((free (vector-init-loop.10)))
                (len.11 i.13 vec.12)
                (if (eq? len.11 i.13)
                  vec.12
                  (begin
                    (unsafe-vector-set! vec.12 i.13 0)
                    (unsafe-procedure-call
                     vector-init-loop.10
                     len.11
                     (unsafe-fx+ i.13 1)
                     vec.12)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.10)))
                (tmp.8)
                (let ((tmp.9 (unsafe-make-vector tmp.8)))
                  (unsafe-procedure-call vector-init-loop.10 tmp.8 0 tmp.9))))
             (make-vector.60
              (lambda ((free (make-init-vector.1)))
                (tmp.36)
                (if (fixnum? tmp.36)
                  (unsafe-procedure-call make-init-vector.1 tmp.36)
                  (error 8))))
             (fun/ascii-char8541.4 (lambda ((free ())) () #\k)))
      (let ((boolean0.7
             (unsafe-procedure-call
              fixnum?.61
              (unsafe-procedure-call make-vector.60 8)))
            (boolean1.6
             (unsafe-procedure-call
              procedure?.62
              (unsafe-procedure-call make-vector.60 8)))
            (ascii-char2.5 (unsafe-procedure-call fun/ascii-char8541.4)))
        (unsafe-procedure-call |+.63| 5 215)))))
(check-by-interp
 '(module
    (letrec ((|-.62|
              (lambda ((free ()))
                (tmp.28 tmp.29)
                (if (fixnum? tmp.29)
                  (if (fixnum? tmp.28) (unsafe-fx- tmp.28 tmp.29) (error 3))
                  (error 3))))
             (fun/void8550.4 (lambda ((free ())) () (void)))
             (fun/error8549.5 (lambda ((free ())) () (error 46)))
             (fun/empty8551.6 (lambda ((free ())) () empty)))
      (let ((error0.9 (unsafe-procedure-call fun/error8549.5))
            (void1.8 (unsafe-procedure-call fun/void8550.4))
            (empty2.7 (unsafe-procedure-call fun/empty8551.6)))
        (unsafe-procedure-call |-.62| 236 4)))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8568.4 (lambda ((free ())) () #\D))
             (fun/error8571.5
              (lambda ((free ())) (oprand0.10 oprand1.9) (error 128)))
             (fun/ascii-char8567.6
              (lambda ((free (fun/ascii-char8568.4)))
                (oprand0.12 oprand1.11)
                (unsafe-procedure-call fun/ascii-char8568.4)))
             (fun/empty8569.7
              (lambda ((free (fun/empty8570.8)))
                (oprand0.14 oprand1.13)
                (unsafe-procedure-call fun/empty8570.8)))
             (fun/empty8570.8 (lambda ((free ())) () empty)))
      (unsafe-procedure-call
       fun/ascii-char8567.6
       (if #t #f #f)
       (unsafe-procedure-call
        fun/empty8569.7
        (unsafe-procedure-call fun/error8571.5 #\S empty)
        (let ((error0.17 (error 54)) (error1.16 (error 231)) (fixnum2.15 57))
          107))))))
(check-by-interp
 '(module
    (letrec ((fun/error8579.4
              (lambda ((free (fun/error8580.5)))
                (oprand0.7 oprand1.6)
                (unsafe-procedure-call fun/error8580.5)))
             (fun/error8580.5 (lambda ((free ())) () (error 226))))
      (unsafe-procedure-call
       fun/error8579.4
       (let ((boolean0.10 #f)
             (error1.9 (error 167))
             (procedure2.8
              (letrec ((lam.63 (lambda ((free ())) () #\z))) lam.63)))
         68)
       (if #t #\l #\s)))))
(check-by-interp
 '(module
    (letrec ((|+.66|
              (lambda ((free ()))
                (tmp.28 tmp.29)
                (if (fixnum? tmp.29)
                  (if (fixnum? tmp.28) (unsafe-fx+ tmp.28 tmp.29) (error 2))
                  (error 2))))
             (*.65
              (lambda ((free ()))
                (tmp.26 tmp.27)
                (if (fixnum? tmp.27)
                  (if (fixnum? tmp.26) (unsafe-fx* tmp.26 tmp.27) (error 1))
                  (error 1))))
             (vector-init-loop.14
              (lambda ((free (vector-init-loop.14)))
                (len.15 i.17 vec.16)
                (if (eq? len.15 i.17)
                  vec.16
                  (begin
                    (unsafe-vector-set! vec.16 i.17 0)
                    (unsafe-procedure-call
                     vector-init-loop.14
                     len.15
                     (unsafe-fx+ i.17 1)
                     vec.16)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.14)))
                (tmp.12)
                (let ((tmp.13 (unsafe-make-vector tmp.12)))
                  (unsafe-procedure-call
                   vector-init-loop.14
                   tmp.12
                   0
                   tmp.13))))
             (make-vector.64
              (lambda ((free (make-init-vector.1)))
                (tmp.40)
                (if (fixnum? tmp.40)
                  (unsafe-procedure-call make-init-vector.1 tmp.40)
                  (error 8))))
             (fun/void8627.4 (lambda ((free ())) () (void)))
             (fun/void8626.5 (lambda ((free ())) () (void)))
             (fun/vector8629.6
              (lambda ((free (make-vector.64)))
                ()
                (unsafe-procedure-call make-vector.64 8)))
             (fun/ascii-char8628.7 (lambda ((free ())) () #\_)))
      (let ((fixnum0.11
             (unsafe-procedure-call
              |+.66|
              (unsafe-procedure-call *.65 92 34)
              (unsafe-procedure-call |+.66| 156 176)))
            (void1.10 (unsafe-procedure-call fun/void8626.5))
            (void2.9 (unsafe-procedure-call fun/void8627.4))
            (procedure3.8
             (letrec ((lam.67
                       (lambda ((free (fun/ascii-char8628.7)))
                         ()
                         (unsafe-procedure-call fun/ascii-char8628.7))))
               lam.67)))
        (unsafe-procedure-call fun/vector8629.6)))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.10
              (lambda ((free (vector-init-loop.10)))
                (len.11 i.13 vec.12)
                (if (eq? len.11 i.13)
                  vec.12
                  (begin
                    (unsafe-vector-set! vec.12 i.13 0)
                    (unsafe-procedure-call
                     vector-init-loop.10
                     len.11
                     (unsafe-fx+ i.13 1)
                     vec.12)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.10)))
                (tmp.8)
                (let ((tmp.9 (unsafe-make-vector tmp.8)))
                  (unsafe-procedure-call vector-init-loop.10 tmp.8 0 tmp.9))))
             (make-vector.60
              (lambda ((free (make-init-vector.1)))
                (tmp.36)
                (if (fixnum? tmp.36)
                  (unsafe-procedure-call make-init-vector.1 tmp.36)
                  (error 8)))))
      (if (if #f #t #t)
        (if #t #\E #\l)
        (let ((vector0.7 (unsafe-procedure-call make-vector.60 8))
              (error1.6 (error 47))
              (fixnum2.5 170)
              (boolean3.4 #t))
          #\t)))))
(check-by-interp
 '(module
    (letrec ((error?.65 (lambda ((free ())) (tmp.53) (error? tmp.53)))
             (*.64
              (lambda ((free ()))
                (tmp.25 tmp.26)
                (if (fixnum? tmp.26)
                  (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
                  (error 1))))
             (|+.63|
              (lambda ((free ()))
                (tmp.27 tmp.28)
                (if (fixnum? tmp.28)
                  (if (fixnum? tmp.27) (unsafe-fx+ tmp.27 tmp.28) (error 2))
                  (error 2))))
             (fun/error8729.4 (lambda ((free ())) () (error 190)))
             (fun/any8730.5 (lambda ((free ())) () #\k))
             (fun/empty8731.6 (lambda ((free ())) () empty)))
      (let ((fixnum0.10
             (unsafe-procedure-call
              |+.63|
              (unsafe-procedure-call |+.63| 150 145)
              (unsafe-procedure-call *.64 40 41)))
            (error1.9 (unsafe-procedure-call fun/error8729.4))
            (boolean2.8
             (unsafe-procedure-call
              error?.65
              (unsafe-procedure-call fun/any8730.5)))
            (fixnum3.7
             (unsafe-procedure-call
              *.64
              (unsafe-procedure-call |+.63| 128 64)
              (unsafe-procedure-call *.64 9 223))))
        (unsafe-procedure-call fun/empty8731.6)))))
(check-by-interp
 '(module
    (letrec ((|-.66|
              (lambda ((free ()))
                (tmp.30 tmp.31)
                (if (fixnum? tmp.31)
                  (if (fixnum? tmp.30) (unsafe-fx- tmp.30 tmp.31) (error 3))
                  (error 3))))
             (*.65
              (lambda ((free ()))
                (tmp.26 tmp.27)
                (if (fixnum? tmp.27)
                  (if (fixnum? tmp.26) (unsafe-fx* tmp.26 tmp.27) (error 1))
                  (error 1))))
             (vector-init-loop.14
              (lambda ((free (vector-init-loop.14)))
                (len.15 i.17 vec.16)
                (if (eq? len.15 i.17)
                  vec.16
                  (begin
                    (unsafe-vector-set! vec.16 i.17 0)
                    (unsafe-procedure-call
                     vector-init-loop.14
                     len.15
                     (unsafe-fx+ i.17 1)
                     vec.16)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.14)))
                (tmp.12)
                (let ((tmp.13 (unsafe-make-vector tmp.12)))
                  (unsafe-procedure-call
                   vector-init-loop.14
                   tmp.12
                   0
                   tmp.13))))
             (make-vector.64
              (lambda ((free (make-init-vector.1)))
                (tmp.40)
                (if (fixnum? tmp.40)
                  (unsafe-procedure-call make-init-vector.1 tmp.40)
                  (error 8))))
             (fun/boolean8743.4
              (lambda ((free ())) (oprand0.8 oprand1.7 oprand2.6) #t))
             (fun/boolean8744.5
              (lambda ((free ())) (oprand0.11 oprand1.10 oprand2.9) #f)))
      (unsafe-procedure-call
       |-.66|
       (if (unsafe-procedure-call fun/boolean8743.4 (void) #\V empty)
         (if #f 175 13)
         (if #t 173 224))
       (if (unsafe-procedure-call
            fun/boolean8744.5
            (unsafe-procedure-call make-vector.64 8)
            #f
            (error 119))
         (unsafe-procedure-call *.65 30 183)
         (if #f 167 117))))))
(check-by-interp
 '(module
    (letrec ((|+.102|
              (lambda ((free ()))
                (tmp.64 tmp.65)
                (if (fixnum? tmp.65)
                  (if (fixnum? tmp.64) (unsafe-fx+ tmp.64 tmp.65) (error 2))
                  (error 2))))
             (vector-init-loop.50
              (lambda ((free (vector-init-loop.50)))
                (len.51 i.53 vec.52)
                (if (eq? len.51 i.53)
                  vec.52
                  (begin
                    (unsafe-vector-set! vec.52 i.53 0)
                    (unsafe-procedure-call
                     vector-init-loop.50
                     len.51
                     (unsafe-fx+ i.53 1)
                     vec.52)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.50)))
                (tmp.48)
                (let ((tmp.49 (unsafe-make-vector tmp.48)))
                  (unsafe-procedure-call
                   vector-init-loop.50
                   tmp.48
                   0
                   tmp.49))))
             (make-vector.101
              (lambda ((free (make-init-vector.1)))
                (tmp.76)
                (if (fixnum? tmp.76)
                  (unsafe-procedure-call make-init-vector.1 tmp.76)
                  (error 8))))
             (cons.100
              (lambda ((free ())) (tmp.95 tmp.96) (cons tmp.95 tmp.96)))
             (fun/ascii-char8828.4 (lambda ((free ())) () #\n))
             (fun/empty8824.5
              (lambda ((free ()))
                (oprand0.17 oprand1.16 oprand2.15)
                oprand0.17))
             (fun/empty8819.6
              (lambda ((free ()))
                (oprand0.20 oprand1.19 oprand2.18)
                oprand2.18))
             (fun/empty8823.7
              (lambda ((free ())) (oprand0.23 oprand1.22 oprand2.21) empty))
             (fun/pair8820.8
              (lambda ((free (cons.100)))
                ()
                (unsafe-procedure-call cons.100 43 274)))
             (fun/vector8821.9
              (lambda ((free (make-vector.101)))
                ()
                (unsafe-procedure-call make-vector.101 8)))
             (fun/vector8826.10
              (lambda ((free (make-vector.101)))
                (oprand0.26 oprand1.25 oprand2.24)
                (unsafe-procedure-call make-vector.101 8)))
             (fun/void8829.11
              (lambda ((free ())) (oprand0.29 oprand1.28 oprand2.27) (void)))
             (fun/ascii-char8827.12
              (lambda ((free (fun/ascii-char8828.4)))
                (oprand0.32 oprand1.31 oprand2.30)
                (unsafe-procedure-call fun/ascii-char8828.4)))
             (fun/empty8825.13
              (lambda ((free ()))
                (oprand0.35 oprand1.34 oprand2.33)
                oprand0.35))
             (fun/ascii-char8822.14 (lambda ((free ())) () #\E)))
      (unsafe-procedure-call
       fun/empty8819.6
       (let ((procedure0.39
              (letrec ((lam.103
                        (lambda ((free (fun/pair8820.8)))
                          ()
                          (unsafe-procedure-call fun/pair8820.8))))
                lam.103))
             (vector1.38 (unsafe-procedure-call fun/vector8821.9))
             (fixnum2.37 (unsafe-procedure-call |+.102| 30 96))
             (empty3.36
              (unsafe-procedure-call fun/empty8819.6 #\_ empty empty)))
         (unsafe-procedure-call fun/ascii-char8822.14))
       (if (if #f #f #f)
         (unsafe-procedure-call
          fun/empty8823.7
          44
          (unsafe-procedure-call cons.100 7 410)
          (void))
         (unsafe-procedure-call fun/empty8819.6 #\w empty empty))
       (unsafe-procedure-call
        fun/empty8824.5
        (unsafe-procedure-call
         fun/empty8825.13
         (unsafe-procedure-call
          fun/empty8825.13
          empty
          empty
          (unsafe-procedure-call make-vector.101 8))
         (if #t empty empty)
         (unsafe-procedure-call fun/vector8826.10 (error 92) #t empty))
        (unsafe-procedure-call
         fun/ascii-char8827.12
         (let ((void0.43 (void))
               (procedure1.42
                (letrec ((lam.104 (lambda ((free ())) () #\l))) lam.104))
               (fixnum2.41 223)
               (vector3.40 (unsafe-procedure-call make-vector.101 8)))
           (unsafe-procedure-call make-vector.101 8))
         (let ((ascii-char0.47 #\^)
               (boolean1.46 #t)
               (boolean2.45 #f)
               (void3.44 (void)))
           (void))
         (unsafe-procedure-call
          fun/void8829.11
          #\M
          (unsafe-procedure-call cons.100 79 323)
          empty))
        (if #t #\I #\d))))))
(check-by-interp
 '(module
    (letrec ((fun/empty8843.4 (lambda ((free ())) () empty))
             (fun/ascii-char8842.5 (lambda ((free ())) () #\R))
             (fun/ascii-char8839.6 (lambda ((free ())) () #\a))
             (fun/ascii-char8841.7 (lambda ((free ())) () #\^))
             (fun/void8840.8 (lambda ((free ())) () (void))))
      (let ((ascii-char0.12 (unsafe-procedure-call fun/ascii-char8839.6))
            (void1.11 (unsafe-procedure-call fun/void8840.8))
            (ascii-char2.10 (unsafe-procedure-call fun/ascii-char8841.7))
            (ascii-char3.9 (unsafe-procedure-call fun/ascii-char8842.5)))
        (unsafe-procedure-call fun/empty8843.4)))))
(check-by-interp
 '(module
    (letrec ((>=.75
              (lambda ((free ()))
                (tmp.45 tmp.46)
                (if (fixnum? tmp.46)
                  (if (fixnum? tmp.45) (unsafe-fx>= tmp.45 tmp.46) (error 7))
                  (error 7))))
             (|+.74|
              (lambda ((free ()))
                (tmp.35 tmp.36)
                (if (fixnum? tmp.36)
                  (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
                  (error 2))))
             (*.73
              (lambda ((free ()))
                (tmp.33 tmp.34)
                (if (fixnum? tmp.34)
                  (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
                  (error 1))))
             (|-.72|
              (lambda ((free ()))
                (tmp.37 tmp.38)
                (if (fixnum? tmp.38)
                  (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
                  (error 3))))
             (vector-init-loop.21
              (lambda ((free (vector-init-loop.21)))
                (len.22 i.24 vec.23)
                (if (eq? len.22 i.24)
                  vec.23
                  (begin
                    (unsafe-vector-set! vec.23 i.24 0)
                    (unsafe-procedure-call
                     vector-init-loop.21
                     len.22
                     (unsafe-fx+ i.24 1)
                     vec.23)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.21)))
                (tmp.19)
                (let ((tmp.20 (unsafe-make-vector tmp.19)))
                  (unsafe-procedure-call
                   vector-init-loop.21
                   tmp.19
                   0
                   tmp.20))))
             (make-vector.71
              (lambda ((free (make-init-vector.1)))
                (tmp.47)
                (if (fixnum? tmp.47)
                  (unsafe-procedure-call make-init-vector.1 tmp.47)
                  (error 8))))
             (fun/vector9717.4
              (lambda ((free (fun/vector9718.6)))
                ()
                (unsafe-procedure-call fun/vector9718.6)))
             (fun/ascii-char9712.5 (lambda ((free ())) () #\G))
             (fun/vector9718.6
              (lambda ((free (make-vector.71)))
                ()
                (unsafe-procedure-call make-vector.71 8)))
             (fun/error9714.7 (lambda ((free ())) () (error 116)))
             (fun/ascii-char9711.8
              (lambda ((free (fun/ascii-char9712.5)))
                ()
                (unsafe-procedure-call fun/ascii-char9712.5)))
             (fun/error9713.9
              (lambda ((free (fun/error9714.7)))
                ()
                (unsafe-procedure-call fun/error9714.7)))
             (fun/empty9715.10
              (lambda ((free (fun/empty9716.13)))
                ()
                (unsafe-procedure-call fun/empty9716.13)))
             (fun/error9720.11 (lambda ((free ())) () (error 190)))
             (fun/error9719.12
              (lambda ((free (fun/error9720.11)))
                ()
                (unsafe-procedure-call fun/error9720.11)))
             (fun/empty9716.13 (lambda ((free ())) () empty)))
      (let ((boolean0.18
             (unsafe-procedure-call
              >=.75
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call |-.72| 152 162)
               (unsafe-procedure-call *.73 68 251))
              (unsafe-procedure-call
               |-.72|
               (unsafe-procedure-call |-.72| 145 4)
               (unsafe-procedure-call |+.74| 67 54))))
            (ascii-char1.17 (unsafe-procedure-call fun/ascii-char9711.8))
            (error2.16 (unsafe-procedure-call fun/error9713.9))
            (empty3.15 (unsafe-procedure-call fun/empty9715.10))
            (procedure4.14
             (letrec ((lam.76
                       (lambda ((free (fun/vector9717.4)))
                         ()
                         (unsafe-procedure-call fun/vector9717.4))))
               lam.76)))
        (unsafe-procedure-call fun/error9719.12)))))
(check-by-interp
 '(module
    (letrec ((fixnum?.74 (lambda ((free ())) (tmp.54) (fixnum? tmp.54)))
             (void?.73 (lambda ((free ())) (tmp.57) (void? tmp.57)))
             (|+.72|
              (lambda ((free ()))
                (tmp.33 tmp.34)
                (if (fixnum? tmp.34)
                  (if (fixnum? tmp.33) (unsafe-fx+ tmp.33 tmp.34) (error 2))
                  (error 2))))
             (*.71
              (lambda ((free ()))
                (tmp.31 tmp.32)
                (if (fixnum? tmp.32)
                  (if (fixnum? tmp.31) (unsafe-fx* tmp.31 tmp.32) (error 1))
                  (error 1))))
             (|-.70|
              (lambda ((free ()))
                (tmp.35 tmp.36)
                (if (fixnum? tmp.36)
                  (if (fixnum? tmp.35) (unsafe-fx- tmp.35 tmp.36) (error 3))
                  (error 3))))
             (vector-init-loop.19
              (lambda ((free (vector-init-loop.19)))
                (len.20 i.22 vec.21)
                (if (eq? len.20 i.22)
                  vec.21
                  (begin
                    (unsafe-vector-set! vec.21 i.22 0)
                    (unsafe-procedure-call
                     vector-init-loop.19
                     len.20
                     (unsafe-fx+ i.22 1)
                     vec.21)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.19)))
                (tmp.17)
                (let ((tmp.18 (unsafe-make-vector tmp.17)))
                  (unsafe-procedure-call
                   vector-init-loop.19
                   tmp.17
                   0
                   tmp.18))))
             (make-vector.69
              (lambda ((free (make-init-vector.1)))
                (tmp.45)
                (if (fixnum? tmp.45)
                  (unsafe-procedure-call make-init-vector.1 tmp.45)
                  (error 8))))
             (fun/error10084.4
              (lambda ((free (fun/error10085.9)))
                ()
                (unsafe-procedure-call fun/error10085.9)))
             (fun/empty10089.5
              (lambda ((free (fun/empty10090.11)))
                ()
                (unsafe-procedure-call fun/empty10090.11)))
             (fun/any10088.6 (lambda ((free ())) () #f))
             (fun/vector10086.7
              (lambda ((free (fun/vector10087.10)))
                ()
                (unsafe-procedure-call fun/vector10087.10)))
             (fun/any10091.8 (lambda ((free ())) () 199))
             (fun/error10085.9 (lambda ((free ())) () (error 36)))
             (fun/vector10087.10
              (lambda ((free (make-vector.69)))
                ()
                (unsafe-procedure-call make-vector.69 8)))
             (fun/empty10090.11 (lambda ((free ())) () empty)))
      (let ((error0.16 (unsafe-procedure-call fun/error10084.4))
            (vector1.15 (unsafe-procedure-call fun/vector10086.7))
            (procedure2.14
             (letrec ((lam.75
                       (lambda ((free (*.71 |-.70| |+.72|)))
                         ()
                         (unsafe-procedure-call
                          |+.72|
                          (unsafe-procedure-call
                           |+.72|
                           (unsafe-procedure-call |-.70| 201 23)
                           (unsafe-procedure-call *.71 254 63))
                          (unsafe-procedure-call
                           |+.72|
                           (unsafe-procedure-call |+.72| 77 65)
                           (unsafe-procedure-call |-.70| 89 34))))))
               lam.75))
            (boolean3.13
             (unsafe-procedure-call
              void?.73
              (unsafe-procedure-call fun/any10088.6)))
            (empty4.12 (unsafe-procedure-call fun/empty10089.5)))
        (unsafe-procedure-call
         fixnum?.74
         (unsafe-procedure-call fun/any10091.8))))))
(check-by-interp
 '(module
    (letrec ((|+.77|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (*.76
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|-.75|
              (lambda ((free ()))
                (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (procedure?.74 (lambda ((free ())) (tmp.68) (procedure? tmp.68)))
             (fun/empty13977.4
              (lambda ((free (fun/empty13978.11)))
                ()
                (unsafe-procedure-call fun/empty13978.11)))
             (fun/ascii-char13971.5
              (lambda ((free (fun/ascii-char13972.10)))
                ()
                (unsafe-procedure-call fun/ascii-char13972.10)))
             (fun/void13976.6 (lambda ((free ())) () (void)))
             (fun/void13975.7
              (lambda ((free (fun/void13976.6)))
                ()
                (unsafe-procedure-call fun/void13976.6)))
             (fun/error13981.8
              (lambda ((free (fun/error13982.9)))
                ()
                (unsafe-procedure-call fun/error13982.9)))
             (fun/error13982.9 (lambda ((free ())) () (error 207)))
             (fun/ascii-char13972.10 (lambda ((free ())) () #\n))
             (fun/empty13978.11 (lambda ((free ())) () empty))
             (fun/any13980.12 (lambda ((free ())) () (error 41)))
             (fun/empty13974.13 (lambda ((free ())) () empty))
             (fun/any13979.14
              (lambda ((free (fun/any13980.12)))
                ()
                (unsafe-procedure-call fun/any13980.12)))
             (fun/empty13973.15
              (lambda ((free (fun/empty13974.13)))
                ()
                (unsafe-procedure-call fun/empty13974.13))))
      (let ((ascii-char0.21 (unsafe-procedure-call fun/ascii-char13971.5))
            (empty1.20 (unsafe-procedure-call fun/empty13973.15))
            (void2.19 (unsafe-procedure-call fun/void13975.7))
            (empty3.18 (unsafe-procedure-call fun/empty13977.4))
            (boolean4.17
             (unsafe-procedure-call
              procedure?.74
              (unsafe-procedure-call fun/any13979.14)))
            (procedure5.16
             (letrec ((lam.78
                       (lambda ((free (*.76 |+.77| |-.75|)))
                         ()
                         (unsafe-procedure-call
                          |-.75|
                          (unsafe-procedure-call
                           |+.77|
                           (unsafe-procedure-call
                            |+.77|
                            (unsafe-procedure-call |-.75| 110 184)
                            (unsafe-procedure-call *.76 234 172))
                           (unsafe-procedure-call
                            *.76
                            (unsafe-procedure-call |+.77| 39 80)
                            (unsafe-procedure-call |-.75| 145 224)))
                          (unsafe-procedure-call
                           |-.75|
                           (unsafe-procedure-call
                            |-.75|
                            (unsafe-procedure-call |+.77| 4 228)
                            (unsafe-procedure-call |-.75| 246 90))
                           (unsafe-procedure-call
                            |-.75|
                            (unsafe-procedure-call |-.75| 31 82)
                            (unsafe-procedure-call *.76 174 71)))))))
               lam.78)))
        (unsafe-procedure-call fun/error13981.8)))))
(check-by-interp
 '(module
    (letrec ((*.73
              (lambda ((free ()))
                (tmp.32 tmp.33)
                (if (fixnum? tmp.33)
                  (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                  (error 1))))
             (|-.72|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                  (error 3))))
             (|+.71|
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                  (error 2))))
             (cons.70
              (lambda ((free ())) (tmp.65 tmp.66) (cons tmp.65 tmp.66)))
             (fun/empty15996.4
              (lambda ((free (fun/empty15997.11)))
                ()
                (unsafe-procedure-call fun/empty15997.11)))
             (fun/ascii-char15998.5
              (lambda ((free (fun/ascii-char15999.7)))
                ()
                (unsafe-procedure-call fun/ascii-char15999.7)))
             (fun/void16001.6 (lambda ((free ())) () (void)))
             (fun/ascii-char15999.7 (lambda ((free ())) () #\S))
             (fun/pair15994.8
              (lambda ((free (fun/pair15995.9)))
                ()
                (unsafe-procedure-call fun/pair15995.9)))
             (fun/pair15995.9
              (lambda ((free (cons.70)))
                ()
                (unsafe-procedure-call cons.70 241 457)))
             (fun/void16000.10
              (lambda ((free (fun/void16001.6)))
                ()
                (unsafe-procedure-call fun/void16001.6)))
             (fun/empty15997.11 (lambda ((free ())) () empty)))
      (let ((procedure0.17
             (letrec ((lam.74
                       (lambda ((free (fun/pair15994.8)))
                         ()
                         (unsafe-procedure-call fun/pair15994.8))))
               lam.74))
            (fixnum1.16
             (unsafe-procedure-call
              |-.72|
              (unsafe-procedure-call
               |+.71|
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |+.71| 222 93)
                (unsafe-procedure-call |-.72| 189 130))
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call |-.72| 245 113)
                (unsafe-procedure-call |+.71| 137 54)))
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call *.73 13 100)
                (unsafe-procedure-call |+.71| 222 123))
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call *.73 131 70)
                (unsafe-procedure-call *.73 47 131)))))
            (empty2.15 (unsafe-procedure-call fun/empty15996.4))
            (ascii-char3.14 (unsafe-procedure-call fun/ascii-char15998.5))
            (procedure4.13
             (letrec ((lam.75
                       (lambda ((free (|+.71| *.73 |-.72|)))
                         ()
                         (unsafe-procedure-call
                          |-.72|
                          (unsafe-procedure-call
                           *.73
                           (unsafe-procedure-call
                            |-.72|
                            (unsafe-procedure-call |+.71| 213 166)
                            (unsafe-procedure-call |-.72| 152 182))
                           (unsafe-procedure-call
                            |+.71|
                            (unsafe-procedure-call *.73 221 59)
                            (unsafe-procedure-call |+.71| 73 248)))
                          (unsafe-procedure-call
                           *.73
                           (unsafe-procedure-call
                            |-.72|
                            (unsafe-procedure-call |+.71| 192 74)
                            (unsafe-procedure-call |-.72| 58 25))
                           (unsafe-procedure-call
                            |+.71|
                            (unsafe-procedure-call |-.72| 89 159)
                            (unsafe-procedure-call *.73 60 247)))))))
               lam.75))
            (void5.12 (unsafe-procedure-call fun/void16000.10)))
        (if (procedure? procedure4.13)
          (if (eq? (unsafe-procedure-arity procedure4.13) 0)
            (unsafe-procedure-call procedure4.13)
            (error 42))
          (error 43))))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char16662.4 (lambda ((free ())) () #\x))
             (fun/empty16658.5 (lambda ((free ())) () empty))
             (fun/ascii-char16664.6 (lambda ((free ())) () #\V))
             (fun/ascii-char16661.7
              (lambda ((free (fun/ascii-char16662.4)))
                ()
                (unsafe-procedure-call fun/ascii-char16662.4)))
             (fun/empty16657.8
              (lambda ((free (fun/empty16658.5)))
                ()
                (unsafe-procedure-call fun/empty16658.5)))
             (fun/ascii-char16663.9
              (lambda ((free (fun/ascii-char16664.6)))
                ()
                (unsafe-procedure-call fun/ascii-char16664.6)))
             (fun/empty16659.10
              (lambda ((free (fun/empty16660.12)))
                ()
                (unsafe-procedure-call fun/empty16660.12)))
             (fun/error16656.11 (lambda ((free ())) () (error 11)))
             (fun/empty16660.12 (lambda ((free ())) () empty))
             (fun/error16665.13
              (lambda ((free (fun/error16666.15)))
                ()
                (unsafe-procedure-call fun/error16666.15)))
             (fun/error16655.14
              (lambda ((free (fun/error16656.11)))
                ()
                (unsafe-procedure-call fun/error16656.11)))
             (fun/error16666.15 (lambda ((free ())) () (error 232)))
             (fun/ascii-char16653.16
              (lambda ((free (fun/ascii-char16654.17)))
                ()
                (unsafe-procedure-call fun/ascii-char16654.17)))
             (fun/ascii-char16654.17 (lambda ((free ())) () #\s)))
      (let ((ascii-char0.23 (unsafe-procedure-call fun/ascii-char16653.16))
            (error1.22 (unsafe-procedure-call fun/error16655.14))
            (empty2.21 (unsafe-procedure-call fun/empty16657.8))
            (empty3.20 (unsafe-procedure-call fun/empty16659.10))
            (ascii-char4.19 (unsafe-procedure-call fun/ascii-char16661.7))
            (ascii-char5.18 (unsafe-procedure-call fun/ascii-char16663.9)))
        (unsafe-procedure-call fun/error16665.13)))))
(check-by-interp
 '(module
    (letrec ((<.74
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx< tmp.38 tmp.39) (error 4))
                  (error 4))))
             (*.73
              (lambda ((free ()))
                (tmp.32 tmp.33)
                (if (fixnum? tmp.33)
                  (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                  (error 1))))
             (|+.72|
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                  (error 2))))
             (|-.71|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                  (error 3))))
             (vector-init-loop.20
              (lambda ((free (vector-init-loop.20)))
                (len.21 i.23 vec.22)
                (if (eq? len.21 i.23)
                  vec.22
                  (begin
                    (unsafe-vector-set! vec.22 i.23 0)
                    (unsafe-procedure-call
                     vector-init-loop.20
                     len.21
                     (unsafe-fx+ i.23 1)
                     vec.22)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.20)))
                (tmp.18)
                (let ((tmp.19 (unsafe-make-vector tmp.18)))
                  (unsafe-procedure-call
                   vector-init-loop.20
                   tmp.18
                   0
                   tmp.19))))
             (make-vector.70
              (lambda ((free (make-init-vector.1)))
                (tmp.46)
                (if (fixnum? tmp.46)
                  (unsafe-procedure-call make-init-vector.1 tmp.46)
                  (error 8))))
             (fun/void17673.4 (lambda ((free ())) () (void)))
             (fun/vector17671.5
              (lambda ((free (make-vector.70)))
                ()
                (unsafe-procedure-call make-vector.70 8)))
             (fun/void17669.6 (lambda ((free ())) () (void)))
             (fun/void17672.7
              (lambda ((free (fun/void17673.4)))
                ()
                (unsafe-procedure-call fun/void17673.4)))
             (fun/vector17670.8
              (lambda ((free (fun/vector17671.5)))
                ()
                (unsafe-procedure-call fun/vector17671.5)))
             (fun/vector17674.9
              (lambda ((free (fun/vector17675.11)))
                ()
                (unsafe-procedure-call fun/vector17675.11)))
             (fun/void17668.10
              (lambda ((free (fun/void17669.6)))
                ()
                (unsafe-procedure-call fun/void17669.6)))
             (fun/vector17675.11
              (lambda ((free (make-vector.70)))
                ()
                (unsafe-procedure-call make-vector.70 8))))
      (let ((fixnum0.17
             (unsafe-procedure-call
              |+.72|
              (unsafe-procedure-call
               |-.71|
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |-.71| 64 143)
                (unsafe-procedure-call |+.72| 112 227))
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call *.73 196 178)
                (unsafe-procedure-call |-.71| 171 205)))
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call |-.71| 105 136)
                (unsafe-procedure-call *.73 204 178))
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call |+.72| 65 84)
                (unsafe-procedure-call |+.72| 239 76)))))
            (void1.16 (unsafe-procedure-call fun/void17668.10))
            (vector2.15 (unsafe-procedure-call fun/vector17670.8))
            (fixnum3.14
             (unsafe-procedure-call
              |-.71|
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call *.73 77 137)
                (unsafe-procedure-call |+.72| 196 151))
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call |+.72| 65 103)
                (unsafe-procedure-call |-.71| 58 131)))
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |+.72| 111 199)
                (unsafe-procedure-call |+.72| 108 136))
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call |+.72| 222 218)
                (unsafe-procedure-call |-.71| 37 107)))))
            (boolean4.13
             (unsafe-procedure-call
              <.74
              (unsafe-procedure-call
               |-.71|
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call *.73 222 119)
                (unsafe-procedure-call *.73 147 147))
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call *.73 201 116)
                (unsafe-procedure-call |-.71| 53 244)))
              (unsafe-procedure-call
               |+.72|
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call |-.71| 47 29)
                (unsafe-procedure-call |+.72| 125 244))
               (unsafe-procedure-call
                |-.71|
                (unsafe-procedure-call *.73 114 147)
                (unsafe-procedure-call |+.72| 158 144)))))
            (void5.12 (unsafe-procedure-call fun/void17672.7)))
        (unsafe-procedure-call fun/vector17674.9)))))
(check-by-interp
 '(module
    (letrec ((fun/void18984.4
              (lambda ((free (fun/void18985.6)))
                ()
                (unsafe-procedure-call fun/void18985.6)))
             (fun/ascii-char18991.5 (lambda ((free ())) () #\D))
             (fun/void18985.6 (lambda ((free ())) () (void)))
             (fun/ascii-char18990.7
              (lambda ((free (fun/ascii-char18991.5)))
                ()
                (unsafe-procedure-call fun/ascii-char18991.5)))
             (fun/empty18987.8 (lambda ((free ())) () empty))
             (fun/ascii-char18982.9
              (lambda ((free (fun/ascii-char18983.10)))
                ()
                (unsafe-procedure-call fun/ascii-char18983.10)))
             (fun/ascii-char18983.10 (lambda ((free ())) () #\o))
             (fun/error18993.11 (lambda ((free ())) () (error 181)))
             (fun/empty18986.12
              (lambda ((free (fun/empty18987.8)))
                ()
                (unsafe-procedure-call fun/empty18987.8)))
             (fun/error18992.13
              (lambda ((free (fun/error18993.11)))
                ()
                (unsafe-procedure-call fun/error18993.11)))
             (fun/ascii-char18981.14 (lambda ((free ())) () #\g))
             (fun/empty18988.15
              (lambda ((free (fun/empty18989.16)))
                ()
                (unsafe-procedure-call fun/empty18989.16)))
             (fun/empty18989.16 (lambda ((free ())) () empty))
             (fun/ascii-char18980.17
              (lambda ((free (fun/ascii-char18981.14)))
                ()
                (unsafe-procedure-call fun/ascii-char18981.14))))
      (let ((procedure0.23
             (letrec ((lam.76
                       (lambda ((free (fun/ascii-char18980.17)))
                         ()
                         (unsafe-procedure-call fun/ascii-char18980.17))))
               lam.76))
            (ascii-char1.22 (unsafe-procedure-call fun/ascii-char18982.9))
            (void2.21 (unsafe-procedure-call fun/void18984.4))
            (empty3.20 (unsafe-procedure-call fun/empty18986.12))
            (procedure4.19
             (letrec ((lam.77
                       (lambda ((free (fun/empty18988.15)))
                         ()
                         (unsafe-procedure-call fun/empty18988.15))))
               lam.77))
            (ascii-char5.18 (unsafe-procedure-call fun/ascii-char18990.7)))
        (unsafe-procedure-call fun/error18992.13)))))
(check-by-interp
 '(module
    (letrec ((|+.77|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (|-.76|
              (lambda ((free ()))
                (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (*.75
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (vector-init-loop.24
              (lambda ((free (vector-init-loop.24)))
                (len.25 i.27 vec.26)
                (if (eq? len.25 i.27)
                  vec.26
                  (begin
                    (unsafe-vector-set! vec.26 i.27 0)
                    (unsafe-procedure-call
                     vector-init-loop.24
                     len.25
                     (unsafe-fx+ i.27 1)
                     vec.26)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.24)))
                (tmp.22)
                (let ((tmp.23 (unsafe-make-vector tmp.22)))
                  (unsafe-procedure-call
                   vector-init-loop.24
                   tmp.22
                   0
                   tmp.23))))
             (make-vector.74
              (lambda ((free (make-init-vector.1)))
                (tmp.50)
                (if (fixnum? tmp.50)
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/error19723.4
              (lambda ((free (fun/error19724.13)))
                ()
                (unsafe-procedure-call fun/error19724.13)))
             (fun/error19716.5 (lambda ((free ())) () (error 8)))
             (fun/void19722.6 (lambda ((free ())) () (void)))
             (fun/error19715.7
              (lambda ((free (fun/error19716.5)))
                ()
                (unsafe-procedure-call fun/error19716.5)))
             (fun/void19721.8
              (lambda ((free (fun/void19722.6)))
                ()
                (unsafe-procedure-call fun/void19722.6)))
             (fun/vector19717.9
              (lambda ((free (fun/vector19718.15)))
                ()
                (unsafe-procedure-call fun/vector19718.15)))
             (fun/empty19725.10
              (lambda ((free (fun/empty19726.12)))
                ()
                (unsafe-procedure-call fun/empty19726.12)))
             (fun/vector19720.11
              (lambda ((free (make-vector.74)))
                ()
                (unsafe-procedure-call make-vector.74 8)))
             (fun/empty19726.12 (lambda ((free ())) () empty))
             (fun/error19724.13 (lambda ((free ())) () (error 64)))
             (fun/vector19719.14
              (lambda ((free (fun/vector19720.11)))
                ()
                (unsafe-procedure-call fun/vector19720.11)))
             (fun/vector19718.15
              (lambda ((free (make-vector.74)))
                ()
                (unsafe-procedure-call make-vector.74 8))))
      (let ((error0.21 (unsafe-procedure-call fun/error19715.7))
            (vector1.20 (unsafe-procedure-call fun/vector19717.9))
            (vector2.19 (unsafe-procedure-call fun/vector19719.14))
            (void3.18 (unsafe-procedure-call fun/void19721.8))
            (fixnum4.17
             (unsafe-procedure-call
              *.75
              (unsafe-procedure-call
               *.75
               (unsafe-procedure-call
                |-.76|
                (unsafe-procedure-call *.75 82 53)
                (unsafe-procedure-call *.75 210 20))
               (unsafe-procedure-call
                |-.76|
                (unsafe-procedure-call *.75 68 251)
                (unsafe-procedure-call |+.77| 207 84)))
              (unsafe-procedure-call
               |-.76|
               (unsafe-procedure-call
                *.75
                (unsafe-procedure-call |+.77| 144 155)
                (unsafe-procedure-call |-.76| 159 71))
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call |-.76| 127 139)
                (unsafe-procedure-call |-.76| 53 160)))))
            (error5.16 (unsafe-procedure-call fun/error19723.4)))
        (unsafe-procedure-call fun/empty19725.10)))))
(check-by-interp
 '(module
    (letrec ((<=.74
              (lambda ((free ()))
                (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx<= tmp.40 tmp.41) (error 5))
                  (error 5))))
             (>=.73
              (lambda ((free ()))
                (tmp.44 tmp.45)
                (if (fixnum? tmp.45)
                  (if (fixnum? tmp.44) (unsafe-fx>= tmp.44 tmp.45) (error 7))
                  (error 7))))
             (|-.72|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                  (error 3))))
             (|+.71|
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                  (error 2))))
             (*.70
              (lambda ((free ()))
                (tmp.32 tmp.33)
                (if (fixnum? tmp.33)
                  (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                  (error 1))))
             (fun/void20368.4 (lambda ((free ())) () (void)))
             (fun/empty20371.5
              (lambda ((free (fun/empty20372.9)))
                ()
                (unsafe-procedure-call fun/empty20372.9)))
             (fun/error20366.6 (lambda ((free ())) () (error 126)))
             (fun/void20367.7
              (lambda ((free (fun/void20368.4)))
                ()
                (unsafe-procedure-call fun/void20368.4)))
             (fun/empty20370.8 (lambda ((free ())) () empty))
             (fun/empty20372.9 (lambda ((free ())) () empty))
             (fun/empty20369.10
              (lambda ((free (fun/empty20370.8)))
                ()
                (unsafe-procedure-call fun/empty20370.8)))
             (fun/error20365.11
              (lambda ((free (fun/error20366.6)))
                ()
                (unsafe-procedure-call fun/error20366.6))))
      (let ((boolean0.17
             (unsafe-procedure-call
              >=.73
              (unsafe-procedure-call
               |-.72|
               (unsafe-procedure-call
                *.70
                (unsafe-procedure-call *.70 23 154)
                (unsafe-procedure-call *.70 227 186))
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call *.70 223 223)
                (unsafe-procedure-call *.70 74 134)))
              (unsafe-procedure-call
               |-.72|
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call *.70 206 244)
                (unsafe-procedure-call *.70 124 41))
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call |-.72| 182 142)
                (unsafe-procedure-call |+.71| 160 100)))))
            (fixnum1.16
             (unsafe-procedure-call
              *.70
              (unsafe-procedure-call
               |+.71|
               (unsafe-procedure-call
                *.70
                (unsafe-procedure-call |-.72| 166 188)
                (unsafe-procedure-call *.70 47 10))
               (unsafe-procedure-call
                *.70
                (unsafe-procedure-call |+.71| 43 251)
                (unsafe-procedure-call *.70 203 163)))
              (unsafe-procedure-call
               *.70
               (unsafe-procedure-call
                *.70
                (unsafe-procedure-call |+.71| 155 222)
                (unsafe-procedure-call |-.72| 27 165))
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call |-.72| 154 93)
                (unsafe-procedure-call |-.72| 11 26)))))
            (procedure2.15
             (letrec ((lam.75
                       (lambda ((free (fun/error20365.11)))
                         ()
                         (unsafe-procedure-call fun/error20365.11))))
               lam.75))
            (void3.14 (unsafe-procedure-call fun/void20367.7))
            (procedure4.13
             (letrec ((lam.76
                       (lambda ((free (|-.72| *.70 |+.71| <=.74)))
                         ()
                         (unsafe-procedure-call
                          <=.74
                          (unsafe-procedure-call
                           |+.71|
                           (unsafe-procedure-call
                            |+.71|
                            (unsafe-procedure-call *.70 176 220)
                            (unsafe-procedure-call |-.72| 237 16))
                           (unsafe-procedure-call
                            |+.71|
                            (unsafe-procedure-call *.70 76 192)
                            (unsafe-procedure-call *.70 4 43)))
                          (unsafe-procedure-call
                           |-.72|
                           (unsafe-procedure-call
                            |-.72|
                            (unsafe-procedure-call *.70 191 94)
                            (unsafe-procedure-call |+.71| 247 183))
                           (unsafe-procedure-call
                            *.70
                            (unsafe-procedure-call |+.71| 159 217)
                            (unsafe-procedure-call *.70 50 42)))))))
               lam.76))
            (empty5.12 (unsafe-procedure-call fun/empty20369.10)))
        (unsafe-procedure-call fun/empty20371.5)))))
(check-by-interp
 '(module
    (letrec ((>=.75
              (lambda ((free ()))
                (tmp.44 tmp.45)
                (if (fixnum? tmp.45)
                  (if (fixnum? tmp.44) (unsafe-fx>= tmp.44 tmp.45) (error 7))
                  (error 7))))
             (ascii-char?.74
              (lambda ((free ())) (tmp.59) (ascii-char? tmp.59)))
             (*.73
              (lambda ((free ()))
                (tmp.32 tmp.33)
                (if (fixnum? tmp.33)
                  (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                  (error 1))))
             (|-.72|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                  (error 3))))
             (|+.71|
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                  (error 2))))
             (vector-init-loop.20
              (lambda ((free (vector-init-loop.20)))
                (len.21 i.23 vec.22)
                (if (eq? len.21 i.23)
                  vec.22
                  (begin
                    (unsafe-vector-set! vec.22 i.23 0)
                    (unsafe-procedure-call
                     vector-init-loop.20
                     len.21
                     (unsafe-fx+ i.23 1)
                     vec.22)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.20)))
                (tmp.18)
                (let ((tmp.19 (unsafe-make-vector tmp.18)))
                  (unsafe-procedure-call
                   vector-init-loop.20
                   tmp.18
                   0
                   tmp.19))))
             (make-vector.70
              (lambda ((free (make-init-vector.1)))
                (tmp.46)
                (if (fixnum? tmp.46)
                  (unsafe-procedure-call make-init-vector.1 tmp.46)
                  (error 8))))
             (fun/any20528.4
              (lambda ((free (fun/any20529.6)))
                ()
                (unsafe-procedure-call fun/any20529.6)))
             (fun/error20532.5
              (lambda ((free (fun/error20533.10)))
                ()
                (unsafe-procedure-call fun/error20533.10)))
             (fun/any20529.6
              (lambda ((free (make-vector.70)))
                ()
                (unsafe-procedure-call make-vector.70 8)))
             (fun/error20531.7 (lambda ((free ())) () (error 193)))
             (fun/ascii-char20526.8
              (lambda ((free (fun/ascii-char20527.11)))
                ()
                (unsafe-procedure-call fun/ascii-char20527.11)))
             (fun/error20530.9
              (lambda ((free (fun/error20531.7)))
                ()
                (unsafe-procedure-call fun/error20531.7)))
             (fun/error20533.10 (lambda ((free ())) () (error 85)))
             (fun/ascii-char20527.11 (lambda ((free ())) () #\T)))
      (let ((procedure0.17
             (letrec ((lam.76
                       (lambda ((free (fun/ascii-char20526.8)))
                         ()
                         (unsafe-procedure-call fun/ascii-char20526.8))))
               lam.76))
            (fixnum1.16
             (unsafe-procedure-call
              |-.72|
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call |+.71| 248 112)
                (unsafe-procedure-call |+.71| 97 102))
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |-.72| 68 117)
                (unsafe-procedure-call |+.71| 103 18)))
              (unsafe-procedure-call
               |+.71|
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call |-.72| 52 243)
                (unsafe-procedure-call *.73 209 145))
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call *.73 33 37)
                (unsafe-procedure-call *.73 247 248)))))
            (boolean2.15
             (unsafe-procedure-call
              ascii-char?.74
              (unsafe-procedure-call fun/any20528.4)))
            (boolean3.14
             (unsafe-procedure-call
              >=.75
              (unsafe-procedure-call
               |+.71|
               (unsafe-procedure-call
                |+.71|
                (unsafe-procedure-call |-.72| 26 59)
                (unsafe-procedure-call |-.72| 123 228))
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call *.73 67 82)
                (unsafe-procedure-call |-.72| 51 247)))
              (unsafe-procedure-call
               |-.72|
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call |-.72| 179 191)
                (unsafe-procedure-call |-.72| 76 171))
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call *.73 102 39)
                (unsafe-procedure-call |-.72| 216 154)))))
            (procedure4.13
             (letrec ((lam.77
                       (lambda ((free (fun/error20530.9)))
                         ()
                         (unsafe-procedure-call fun/error20530.9))))
               lam.77))
            (procedure5.12
             (letrec ((lam.78
                       (lambda ((free (fun/error20532.5)))
                         ()
                         (unsafe-procedure-call fun/error20532.5))))
               lam.78)))
        (unsafe-procedure-call
         |-.72|
         (unsafe-procedure-call
          *.73
          (unsafe-procedure-call
           |+.71|
           (unsafe-procedure-call |-.72| 49 134)
           (unsafe-procedure-call |+.71| 17 191))
          (unsafe-procedure-call
           |+.71|
           (unsafe-procedure-call |+.71| 38 251)
           (unsafe-procedure-call |-.72| 54 141)))
         (unsafe-procedure-call
          |-.72|
          (unsafe-procedure-call
           *.73
           (unsafe-procedure-call |-.72| 30 94)
           (unsafe-procedure-call *.73 2 203))
          (unsafe-procedure-call
           |-.72|
           (unsafe-procedure-call |+.71| 73 172)
           (unsafe-procedure-call |-.72| 120 106))))))))
(check-by-interp
 '(module
    (letrec ((|+.77|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (*.76
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|-.75|
              (lambda ((free ()))
                (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (vector-init-loop.24
              (lambda ((free (vector-init-loop.24)))
                (len.25 i.27 vec.26)
                (if (eq? len.25 i.27)
                  vec.26
                  (begin
                    (unsafe-vector-set! vec.26 i.27 0)
                    (unsafe-procedure-call
                     vector-init-loop.24
                     len.25
                     (unsafe-fx+ i.27 1)
                     vec.26)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.24)))
                (tmp.22)
                (let ((tmp.23 (unsafe-make-vector tmp.22)))
                  (unsafe-procedure-call
                   vector-init-loop.24
                   tmp.22
                   0
                   tmp.23))))
             (make-vector.74
              (lambda ((free (make-init-vector.1)))
                (tmp.50)
                (if (fixnum? tmp.50)
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/empty20841.4
              (lambda ((free (fun/empty20842.7)))
                ()
                (unsafe-procedure-call fun/empty20842.7)))
             (fun/ascii-char20840.5 (lambda ((free ())) () #\E))
             (fun/error20843.6
              (lambda ((free (fun/error20844.8)))
                ()
                (unsafe-procedure-call fun/error20844.8)))
             (fun/empty20842.7 (lambda ((free ())) () empty))
             (fun/error20844.8 (lambda ((free ())) () (error 10)))
             (fun/vector20838.9
              (lambda ((free (make-vector.74)))
                ()
                (unsafe-procedure-call make-vector.74 8)))
             (fun/void20835.10
              (lambda ((free (fun/void20836.11)))
                ()
                (unsafe-procedure-call fun/void20836.11)))
             (fun/void20836.11 (lambda ((free ())) () (void)))
             (fun/ascii-char20839.12
              (lambda ((free (fun/ascii-char20840.5)))
                ()
                (unsafe-procedure-call fun/ascii-char20840.5)))
             (fun/vector20837.13
              (lambda ((free (fun/vector20838.9)))
                ()
                (unsafe-procedure-call fun/vector20838.9)))
             (fun/error20833.14
              (lambda ((free (fun/error20834.15)))
                ()
                (unsafe-procedure-call fun/error20834.15)))
             (fun/error20834.15 (lambda ((free ())) () (error 194))))
      (let ((error0.21 (unsafe-procedure-call fun/error20833.14))
            (void1.20 (unsafe-procedure-call fun/void20835.10))
            (procedure2.19
             (letrec ((lam.78
                       (lambda ((free (fun/vector20837.13)))
                         ()
                         (unsafe-procedure-call fun/vector20837.13))))
               lam.78))
            (ascii-char3.18 (unsafe-procedure-call fun/ascii-char20839.12))
            (procedure4.17
             (letrec ((lam.79
                       (lambda ((free (fun/empty20841.4)))
                         ()
                         (unsafe-procedure-call fun/empty20841.4))))
               lam.79))
            (fixnum5.16
             (unsafe-procedure-call
              |-.75|
              (unsafe-procedure-call
               |+.77|
               (unsafe-procedure-call
                |-.75|
                (unsafe-procedure-call |-.75| 153 202)
                (unsafe-procedure-call *.76 141 144))
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call |-.75| 150 207)
                (unsafe-procedure-call *.76 0 139)))
              (unsafe-procedure-call
               |-.75|
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call |+.77| 165 197)
                (unsafe-procedure-call |-.75| 202 36))
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call *.76 215 235)
                (unsafe-procedure-call |-.75| 196 6))))))
        (unsafe-procedure-call fun/error20843.6)))))
(check-by-interp
 '(module
    (letrec ((|+.75|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
                  (error 2))))
             (|-.74|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
                  (error 3))))
             (*.73
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
                  (error 1))))
             (vector-init-loop.22
              (lambda ((free (vector-init-loop.22)))
                (len.23 i.25 vec.24)
                (if (eq? len.23 i.25)
                  vec.24
                  (begin
                    (unsafe-vector-set! vec.24 i.25 0)
                    (unsafe-procedure-call
                     vector-init-loop.22
                     len.23
                     (unsafe-fx+ i.25 1)
                     vec.24)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.22)))
                (tmp.20)
                (let ((tmp.21 (unsafe-make-vector tmp.20)))
                  (unsafe-procedure-call
                   vector-init-loop.22
                   tmp.20
                   0
                   tmp.21))))
             (make-vector.72
              (lambda ((free (make-init-vector.1)))
                (tmp.48)
                (if (fixnum? tmp.48)
                  (unsafe-procedure-call make-init-vector.1 tmp.48)
                  (error 8))))
             (fun/vector20853.4
              (lambda ((free (fun/vector20854.6)))
                ()
                (unsafe-procedure-call fun/vector20854.6)))
             (fun/ascii-char20855.5
              (lambda ((free (fun/ascii-char20856.11)))
                ()
                (unsafe-procedure-call fun/ascii-char20856.11)))
             (fun/vector20854.6
              (lambda ((free (make-vector.72)))
                ()
                (unsafe-procedure-call make-vector.72 8)))
             (fun/void20849.7
              (lambda ((free (fun/void20850.13)))
                ()
                (unsafe-procedure-call fun/void20850.13)))
             (fun/error20847.8
              (lambda ((free (fun/error20848.9)))
                ()
                (unsafe-procedure-call fun/error20848.9)))
             (fun/error20848.9 (lambda ((free ())) () (error 201)))
             (fun/vector20852.10
              (lambda ((free (make-vector.72)))
                ()
                (unsafe-procedure-call make-vector.72 8)))
             (fun/ascii-char20856.11 (lambda ((free ())) () #\Y))
             (fun/vector20851.12
              (lambda ((free (fun/vector20852.10)))
                ()
                (unsafe-procedure-call fun/vector20852.10)))
             (fun/void20850.13 (lambda ((free ())) () (void))))
      (let ((fixnum0.19
             (unsafe-procedure-call
              |+.75|
              (unsafe-procedure-call
               |+.75|
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call *.73 103 76)
                (unsafe-procedure-call |-.74| 84 49))
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |+.75| 49 237)
                (unsafe-procedure-call |-.74| 166 144)))
              (unsafe-procedure-call
               |-.74|
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call |-.74| 47 223)
                (unsafe-procedure-call |-.74| 26 22))
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call *.73 41 151)
                (unsafe-procedure-call *.73 147 87)))))
            (fixnum1.18
             (unsafe-procedure-call
              |+.75|
              (unsafe-procedure-call
               |+.75|
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call |-.74| 236 231)
                (unsafe-procedure-call |+.75| 21 169))
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call |+.75| 38 17)
                (unsafe-procedure-call |-.74| 192 91)))
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call |-.74| 3 213)
                (unsafe-procedure-call *.73 83 86))
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call |-.74| 131 120)
                (unsafe-procedure-call |+.75| 154 12)))))
            (error2.17 (unsafe-procedure-call fun/error20847.8))
            (void3.16 (unsafe-procedure-call fun/void20849.7))
            (vector4.15 (unsafe-procedure-call fun/vector20851.12))
            (vector5.14 (unsafe-procedure-call fun/vector20853.4)))
        (unsafe-procedure-call fun/ascii-char20855.5)))))
(check-by-interp
 '(module
    (letrec ((|+.78|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (|-.77|
              (lambda ((free ()))
                (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (*.76
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (empty?.75 (lambda ((free ())) (tmp.61) (empty? tmp.61)))
             (vector-init-loop.24
              (lambda ((free (vector-init-loop.24)))
                (len.25 i.27 vec.26)
                (if (eq? len.25 i.27)
                  vec.26
                  (begin
                    (unsafe-vector-set! vec.26 i.27 0)
                    (unsafe-procedure-call
                     vector-init-loop.24
                     len.25
                     (unsafe-fx+ i.27 1)
                     vec.26)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.24)))
                (tmp.22)
                (let ((tmp.23 (unsafe-make-vector tmp.22)))
                  (unsafe-procedure-call
                   vector-init-loop.24
                   tmp.22
                   0
                   tmp.23))))
             (make-vector.74
              (lambda ((free (make-init-vector.1)))
                (tmp.50)
                (if (fixnum? tmp.50)
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/vector21810.4
              (lambda ((free (make-vector.74)))
                ()
                (unsafe-procedure-call make-vector.74 8)))
             (fun/void21801.5
              (lambda ((free (fun/void21802.7)))
                ()
                (unsafe-procedure-call fun/void21802.7)))
             (fun/ascii-char21800.6 (lambda ((free ())) () #\o))
             (fun/void21802.7 (lambda ((free ())) () (void)))
             (fun/ascii-char21799.8
              (lambda ((free (fun/ascii-char21800.6)))
                ()
                (unsafe-procedure-call fun/ascii-char21800.6)))
             (fun/any21806.9 (lambda ((free ())) () empty))
             (fun/error21804.10 (lambda ((free ())) () (error 240)))
             (fun/void21808.11 (lambda ((free ())) () (void)))
             (fun/vector21809.12
              (lambda ((free (fun/vector21810.4)))
                ()
                (unsafe-procedure-call fun/vector21810.4)))
             (fun/void21807.13
              (lambda ((free (fun/void21808.11)))
                ()
                (unsafe-procedure-call fun/void21808.11)))
             (fun/any21805.14
              (lambda ((free (fun/any21806.9)))
                ()
                (unsafe-procedure-call fun/any21806.9)))
             (fun/error21803.15
              (lambda ((free (fun/error21804.10)))
                ()
                (unsafe-procedure-call fun/error21804.10))))
      (let ((ascii-char0.21 (unsafe-procedure-call fun/ascii-char21799.8))
            (procedure1.20
             (letrec ((lam.79
                       (lambda ((free (fun/void21801.5)))
                         ()
                         (unsafe-procedure-call fun/void21801.5))))
               lam.79))
            (error2.19 (unsafe-procedure-call fun/error21803.15))
            (boolean3.18
             (unsafe-procedure-call
              empty?.75
              (unsafe-procedure-call fun/any21805.14)))
            (void4.17 (unsafe-procedure-call fun/void21807.13))
            (fixnum5.16
             (unsafe-procedure-call
              *.76
              (unsafe-procedure-call
               |+.78|
               (unsafe-procedure-call
                |+.78|
                (unsafe-procedure-call *.76 134 121)
                (unsafe-procedure-call |-.77| 61 154))
               (unsafe-procedure-call
                |-.77|
                (unsafe-procedure-call *.76 235 180)
                (unsafe-procedure-call |+.78| 44 23)))
              (unsafe-procedure-call
               |-.77|
               (unsafe-procedure-call
                |-.77|
                (unsafe-procedure-call |-.77| 85 11)
                (unsafe-procedure-call |-.77| 71 242))
               (unsafe-procedure-call
                *.76
                (unsafe-procedure-call |+.78| 194 18)
                (unsafe-procedure-call *.76 83 158))))))
        (unsafe-procedure-call fun/vector21809.12)))))
(check-by-interp
 '(module
    (letrec ((|+.75|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
                  (error 2))))
             (|-.74|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
                  (error 3))))
             (*.73
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
                  (error 1))))
             (cons.72
              (lambda ((free ())) (tmp.67 tmp.68) (cons tmp.67 tmp.68)))
             (fun/void24924.4
              (lambda ((free (fun/void24925.6)))
                ()
                (unsafe-procedure-call fun/void24925.6)))
             (fun/pair24923.5
              (lambda ((free (cons.72)))
                ()
                (unsafe-procedure-call cons.72 43 418)))
             (fun/void24925.6 (lambda ((free ())) () (void)))
             (fun/void24918.7
              (lambda ((free (fun/void24919.10)))
                ()
                (unsafe-procedure-call fun/void24919.10)))
             (fun/empty24921.8 (lambda ((free ())) () empty))
             (fun/empty24920.9
              (lambda ((free (fun/empty24921.8)))
                ()
                (unsafe-procedure-call fun/empty24921.8)))
             (fun/void24919.10 (lambda ((free ())) () (void)))
             (fun/pair24922.11
              (lambda ((free (fun/pair24923.5)))
                ()
                (unsafe-procedure-call fun/pair24923.5)))
             (fun/void24916.12
              (lambda ((free (fun/void24917.13)))
                ()
                (unsafe-procedure-call fun/void24917.13)))
             (fun/void24917.13 (lambda ((free ())) () (void))))
      (let ((void0.19 (unsafe-procedure-call fun/void24916.12))
            (fixnum1.18
             (unsafe-procedure-call
              *.73
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call *.73 157 40)
                (unsafe-procedure-call |-.74| 203 116))
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call |+.75| 97 53)
                (unsafe-procedure-call |-.74| 18 142)))
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |+.75| 151 180)
                (unsafe-procedure-call *.73 234 224))
               (unsafe-procedure-call
                *.73
                (unsafe-procedure-call |-.74| 54 95)
                (unsafe-procedure-call |+.75| 40 41)))))
            (void2.17 (unsafe-procedure-call fun/void24918.7))
            (empty3.16 (unsafe-procedure-call fun/empty24920.9))
            (procedure4.15
             (letrec ((lam.76
                       (lambda ((free (fun/pair24922.11)))
                         ()
                         (unsafe-procedure-call fun/pair24922.11))))
               lam.76))
            (void5.14 (unsafe-procedure-call fun/void24924.4)))
        (unsafe-procedure-call
         |+.75|
         (unsafe-procedure-call
          |+.75|
          (unsafe-procedure-call
           |-.74|
           (unsafe-procedure-call *.73 120 164)
           (unsafe-procedure-call |-.74| 218 214))
          (unsafe-procedure-call
           |-.74|
           (unsafe-procedure-call *.73 58 183)
           (unsafe-procedure-call *.73 132 4)))
         (unsafe-procedure-call
          |+.75|
          (unsafe-procedure-call
           *.73
           (unsafe-procedure-call |-.74| 181 79)
           (unsafe-procedure-call *.73 243 218))
          (unsafe-procedure-call
           |-.74|
           (unsafe-procedure-call |+.75| 114 128)
           (unsafe-procedure-call |-.74| 165 46))))))))
(check-by-interp
 '(module
    (letrec ((*.75
              (lambda ((free ()))
                (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
                  (error 1))))
             (|+.74|
              (lambda ((free ()))
                (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
                  (error 2))))
             (|-.73|
              (lambda ((free ()))
                (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
                  (error 3))))
             (vector-init-loop.22
              (lambda ((free (vector-init-loop.22)))
                (len.23 i.25 vec.24)
                (if (eq? len.23 i.25)
                  vec.24
                  (begin
                    (unsafe-vector-set! vec.24 i.25 0)
                    (unsafe-procedure-call
                     vector-init-loop.22
                     len.23
                     (unsafe-fx+ i.25 1)
                     vec.24)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.22)))
                (tmp.20)
                (let ((tmp.21 (unsafe-make-vector tmp.20)))
                  (unsafe-procedure-call
                   vector-init-loop.22
                   tmp.20
                   0
                   tmp.21))))
             (make-vector.72
              (lambda ((free (make-init-vector.1)))
                (tmp.48)
                (if (fixnum? tmp.48)
                  (unsafe-procedure-call make-init-vector.1 tmp.48)
                  (error 8))))
             (fun/empty26323.4
              (lambda ((free (fun/empty26324.7)))
                ()
                (unsafe-procedure-call fun/empty26324.7)))
             (fun/error26327.5
              (lambda ((free (fun/error26328.8)))
                ()
                (unsafe-procedure-call fun/error26328.8)))
             (fun/vector26322.6
              (lambda ((free (make-vector.72)))
                ()
                (unsafe-procedure-call make-vector.72 8)))
             (fun/empty26324.7 (lambda ((free ())) () empty))
             (fun/error26328.8 (lambda ((free ())) () (error 170)))
             (fun/void26320.9 (lambda ((free ())) () (void)))
             (fun/empty26325.10
              (lambda ((free (fun/empty26326.12)))
                ()
                (unsafe-procedure-call fun/empty26326.12)))
             (fun/void26319.11
              (lambda ((free (fun/void26320.9)))
                ()
                (unsafe-procedure-call fun/void26320.9)))
             (fun/empty26326.12 (lambda ((free ())) () empty))
             (fun/vector26321.13
              (lambda ((free (fun/vector26322.6)))
                ()
                (unsafe-procedure-call fun/vector26322.6))))
      (let ((fixnum0.19
             (unsafe-procedure-call
              |-.73|
              (unsafe-procedure-call
               *.75
               (unsafe-procedure-call
                |+.74|
                (unsafe-procedure-call |-.73| 111 202)
                (unsafe-procedure-call |+.74| 142 215))
               (unsafe-procedure-call
                |+.74|
                (unsafe-procedure-call |-.73| 84 210)
                (unsafe-procedure-call *.75 44 138)))
              (unsafe-procedure-call
               |-.73|
               (unsafe-procedure-call
                *.75
                (unsafe-procedure-call |-.73| 215 33)
                (unsafe-procedure-call |+.74| 138 215))
               (unsafe-procedure-call
                *.75
                (unsafe-procedure-call |+.74| 107 245)
                (unsafe-procedure-call |-.73| 133 25)))))
            (void1.18 (unsafe-procedure-call fun/void26319.11))
            (fixnum2.17
             (unsafe-procedure-call
              *.75
              (unsafe-procedure-call
               |-.73|
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call |+.74| 114 55)
                (unsafe-procedure-call *.75 68 21))
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call |-.73| 138 2)
                (unsafe-procedure-call |+.74| 79 198)))
              (unsafe-procedure-call
               |+.74|
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call |+.74| 103 114)
                (unsafe-procedure-call |+.74| 224 216))
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call |-.73| 82 46)
                (unsafe-procedure-call |+.74| 57 8)))))
            (vector3.16 (unsafe-procedure-call fun/vector26321.13))
            (empty4.15 (unsafe-procedure-call fun/empty26323.4))
            (empty5.14 (unsafe-procedure-call fun/empty26325.10)))
        (unsafe-procedure-call fun/error26327.5)))))
(check-by-interp
 '(module
    (letrec ((error?.78 (lambda ((free ())) (tmp.66) (error? tmp.66)))
             (cons.77
              (lambda ((free ())) (tmp.71 tmp.72) (cons tmp.71 tmp.72)))
             (vector-init-loop.26
              (lambda ((free (vector-init-loop.26)))
                (len.27 i.29 vec.28)
                (if (eq? len.27 i.29)
                  vec.28
                  (begin
                    (unsafe-vector-set! vec.28 i.29 0)
                    (unsafe-procedure-call
                     vector-init-loop.26
                     len.27
                     (unsafe-fx+ i.29 1)
                     vec.28)))))
             (make-init-vector.1
              (lambda ((free (vector-init-loop.26)))
                (tmp.24)
                (let ((tmp.25 (unsafe-make-vector tmp.24)))
                  (unsafe-procedure-call
                   vector-init-loop.26
                   tmp.24
                   0
                   tmp.25))))
             (make-vector.76
              (lambda ((free (make-init-vector.1)))
                (tmp.52)
                (if (fixnum? tmp.52)
                  (unsafe-procedure-call make-init-vector.1 tmp.52)
                  (error 8))))
             (fun/any26744.4 (lambda ((free ())) () #f))
             (fun/vector26736.5
              (lambda ((free (make-vector.76)))
                ()
                (unsafe-procedure-call make-vector.76 8)))
             (fun/ascii-char26733.6
              (lambda ((free (fun/ascii-char26734.16)))
                ()
                (unsafe-procedure-call fun/ascii-char26734.16)))
             (fun/vector26735.7
              (lambda ((free (fun/vector26736.5)))
                ()
                (unsafe-procedure-call fun/vector26736.5)))
             (fun/pair26746.8
              (lambda ((free (cons.77)))
                ()
                (unsafe-procedure-call cons.77 112 397)))
             (fun/pair26745.9
              (lambda ((free (fun/pair26746.8)))
                ()
                (unsafe-procedure-call fun/pair26746.8)))
             (fun/error26742.10 (lambda ((free ())) () (error 166)))
             (fun/vector26737.11
              (lambda ((free (fun/vector26738.17)))
                ()
                (unsafe-procedure-call fun/vector26738.17)))
             (fun/error26741.12
              (lambda ((free (fun/error26742.10)))
                ()
                (unsafe-procedure-call fun/error26742.10)))
             (fun/error26739.13
              (lambda ((free (fun/error26740.15)))
                ()
                (unsafe-procedure-call fun/error26740.15)))
             (fun/any26743.14
              (lambda ((free (fun/any26744.4)))
                ()
                (unsafe-procedure-call fun/any26744.4)))
             (fun/error26740.15 (lambda ((free ())) () (error 226)))
             (fun/ascii-char26734.16 (lambda ((free ())) () #\h))
             (fun/vector26738.17
              (lambda ((free (make-vector.76)))
                ()
                (unsafe-procedure-call make-vector.76 8))))
      (let ((ascii-char0.23 (unsafe-procedure-call fun/ascii-char26733.6))
            (vector1.22 (unsafe-procedure-call fun/vector26735.7))
            (vector2.21 (unsafe-procedure-call fun/vector26737.11))
            (error3.20 (unsafe-procedure-call fun/error26739.13))
            (error4.19 (unsafe-procedure-call fun/error26741.12))
            (boolean5.18
             (unsafe-procedure-call
              error?.78
              (unsafe-procedure-call fun/any26743.14))))
        (unsafe-procedure-call fun/pair26745.9)))))
