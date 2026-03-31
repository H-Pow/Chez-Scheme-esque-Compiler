#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
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

(check-by-interp '(module 173))
(check-by-interp '(module 239))
(check-by-interp
 '(module
    (letrec ((fun/error8447.4 (lambda () (error 233))))
      (unsafe-procedure-call fun/error8447.4))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8450.4 (lambda () 36)))
      (unsafe-procedure-call fun/fixnum8450.4))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.7
              (lambda (len.8 i.10 vec.9)
                (if (eq? len.8 i.10)
                  vec.9
                  (begin
                    (unsafe-vector-set! vec.9 i.10 0)
                    (unsafe-procedure-call
                     vector-init-loop.7
                     len.8
                     (unsafe-fx+ i.10 1)
                     vec.9)))))
             (make-init-vector.1
              (lambda (tmp.5)
                (let ((tmp.6 (unsafe-make-vector tmp.5)))
                  (unsafe-procedure-call vector-init-loop.7 tmp.5 0 tmp.6))))
             (make-vector.57
              (lambda (tmp.33)
                (if (fixnum? tmp.33)
                  (unsafe-procedure-call make-init-vector.1 tmp.33)
                  (error 8))))
             (fun/vector8453.4
              (lambda () (unsafe-procedure-call make-vector.57 8))))
      (unsafe-procedure-call fun/vector8453.4))))
(check-by-interp
 '(module
    (letrec ((fun/error8456.4 (lambda () (error 240))))
      (unsafe-procedure-call fun/error8456.4))))
(check-by-interp '(module (if #t (error 111) (error 246))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.11
              (lambda (len.12 i.14 vec.13)
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
              (lambda (tmp.9)
                (let ((tmp.10 (unsafe-make-vector tmp.9)))
                  (unsafe-procedure-call vector-init-loop.11 tmp.9 0 tmp.10))))
             (make-vector.61
              (lambda (tmp.37)
                (if (fixnum? tmp.37)
                  (unsafe-procedure-call make-init-vector.1 tmp.37)
                  (error 8))))
             (fun/error8470.4
              (lambda (oprand0.6) (unsafe-procedure-call fun/error8471.5)))
             (fun/error8471.5 (lambda () (error 217))))
      (unsafe-procedure-call
       fun/error8470.4
       (let ((fixnum0.8 250)
             (vector1.7 (unsafe-procedure-call make-vector.61 8)))
         136)))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8474.4 (lambda (oprand0.6) #\V))
             (fun/void8475.5 (lambda (oprand0.7) (void))))
      (unsafe-procedure-call
       fun/ascii-char8474.4
       (unsafe-procedure-call fun/void8475.5 #t)))))
(check-by-interp
 '(module
    (letrec ((fun/empty8478.4 (lambda (oprand0.5) empty)))
      (unsafe-procedure-call
       fun/empty8478.4
       (let ((error0.7 (error 53)) (error1.6 (error 196))) empty)))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8481.4 (lambda (oprand0.5) #\\)))
      (unsafe-procedure-call fun/ascii-char8481.4 (if #f empty empty)))))
(check-by-interp
 '(module
    (letrec ((ascii-char?.65 (lambda (tmp.52) (ascii-char? tmp.52)))
             (*.64
              (lambda (tmp.25 tmp.26)
                (if (fixnum? tmp.26)
                  (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
                  (error 1))))
             (cons.63 (lambda (tmp.58 tmp.59) (cons tmp.58 tmp.59)))
             (fun/pair8495.4
              (lambda (oprand0.7 oprand1.6)
                (unsafe-procedure-call fun/pair8496.5)))
             (fun/pair8496.5
              (lambda () (unsafe-procedure-call cons.63 33 428))))
      (unsafe-procedure-call
       fun/pair8495.4
       (unsafe-procedure-call
        *.64
        (unsafe-procedure-call *.64 120 100)
        (let ((ascii-char0.10 #\M) (boolean1.9 #t) (boolean2.8 #t)) 196))
       (unsafe-procedure-call ascii-char?.65 (if #t #\^ (void)))))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.23
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.49)
                  (error 8))))
             (cons.73 (lambda (tmp.68 tmp.69) (cons tmp.68 tmp.69)))
             (fun/pair8508.4
              (lambda (oprand0.11 oprand1.10)
                (unsafe-procedure-call fun/pair8509.5)))
             (fun/pair8509.5
              (lambda () (unsafe-procedure-call cons.73 105 344)))
             (fun/empty8511.6 (lambda (oprand0.13 oprand1.12) empty))
             (fun/void8507.7 (lambda () (void)))
             (fun/error8510.8 (lambda (oprand0.15 oprand1.14) (error 153)))
             (fun/void8506.9
              (lambda (oprand0.17 oprand1.16)
                (unsafe-procedure-call fun/void8507.7))))
      (unsafe-procedure-call
       fun/void8506.9
       (let ((ascii-char0.20 #\j)
             (vector1.19 (unsafe-procedure-call make-vector.74 8))
             (boolean2.18 #t))
         (error 147))
       (unsafe-procedure-call
        fun/pair8508.4
        (unsafe-procedure-call fun/error8510.8 (void) (void))
        (unsafe-procedure-call fun/empty8511.6 (error 142) #\C))))))
(check-by-interp
 '(module
    (letrec ((boolean?.64 (lambda (tmp.48) (boolean? tmp.48)))
             (cons.63 (lambda (tmp.57 tmp.58) (cons tmp.57 tmp.58)))
             (vector-init-loop.12
              (lambda (len.13 i.15 vec.14)
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
              (lambda (tmp.10)
                (let ((tmp.11 (unsafe-make-vector tmp.10)))
                  (unsafe-procedure-call
                   vector-init-loop.12
                   tmp.10
                   0
                   tmp.11))))
             (make-vector.62
              (lambda (tmp.38)
                (if (fixnum? tmp.38)
                  (unsafe-procedure-call make-init-vector.1 tmp.38)
                  (error 8))))
             (fun/empty8535.4 (lambda () empty))
             (fun/empty8537.5 (lambda () empty))
             (fun/vector8536.6
              (lambda () (unsafe-procedure-call make-vector.62 8))))
      (let ((empty0.9 (unsafe-procedure-call fun/empty8535.4))
            (boolean1.8
             (unsafe-procedure-call
              boolean?.64
              (unsafe-procedure-call cons.63 80 414)))
            (vector2.7 (unsafe-procedure-call fun/vector8536.6)))
        (unsafe-procedure-call fun/empty8537.5)))))
(check-by-interp
 '(module
    (letrec ((cons.67 (lambda (tmp.62 tmp.63) (cons tmp.62 tmp.63)))
             (fun/pair8561.4
              (lambda () (unsafe-procedure-call cons.67 251 399)))
             (fun/ascii-char8562.5
              (lambda (oprand0.10 oprand1.9)
                (unsafe-procedure-call fun/ascii-char8563.7)))
             (fun/pair8560.6
              (lambda (oprand0.12 oprand1.11)
                (unsafe-procedure-call fun/pair8561.4)))
             (fun/ascii-char8563.7 (lambda () #\s))
             (fun/empty8564.8 (lambda (oprand0.14 oprand1.13) empty)))
      (unsafe-procedure-call
       fun/pair8560.6
       (if #f 61 74)
       (unsafe-procedure-call
        fun/ascii-char8562.5
        (unsafe-procedure-call fun/empty8564.8 empty #\r)
        (if #t #t #f))))))
(check-by-interp
 '(module
    (letrec ((|+.67|
              (lambda (tmp.28 tmp.29)
                (if (fixnum? tmp.29)
                  (if (fixnum? tmp.28) (unsafe-fx+ tmp.28 tmp.29) (error 2))
                  (error 2))))
             (|-.66|
              (lambda (tmp.30 tmp.31)
                (if (fixnum? tmp.31)
                  (if (fixnum? tmp.30) (unsafe-fx- tmp.30 tmp.31) (error 3))
                  (error 3))))
             (*.65
              (lambda (tmp.26 tmp.27)
                (if (fixnum? tmp.27)
                  (if (fixnum? tmp.26) (unsafe-fx* tmp.26 tmp.27) (error 1))
                  (error 1))))
             (vector-init-loop.14
              (lambda (len.15 i.17 vec.16)
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
              (lambda (tmp.12)
                (let ((tmp.13 (unsafe-make-vector tmp.12)))
                  (unsafe-procedure-call
                   vector-init-loop.14
                   tmp.12
                   0
                   tmp.13))))
             (make-vector.64
              (lambda (tmp.40)
                (if (fixnum? tmp.40)
                  (unsafe-procedure-call make-init-vector.1 tmp.40)
                  (error 8))))
             (fun/ascii-char8613.4 (lambda () #\B))
             (fun/vector8612.5
              (lambda () (unsafe-procedure-call make-vector.64 8)))
             (fun/ascii-char8614.6 (lambda () #\S))
             (fun/void8611.7 (lambda () (void))))
      (let ((fixnum0.11
             (unsafe-procedure-call
              |+.67|
              (unsafe-procedure-call *.65 77 201)
              (unsafe-procedure-call |-.66| 53 40)))
            (void1.10 (unsafe-procedure-call fun/void8611.7))
            (vector2.9 (unsafe-procedure-call fun/vector8612.5))
            (ascii-char3.8 (unsafe-procedure-call fun/ascii-char8613.4)))
        (unsafe-procedure-call fun/ascii-char8614.6)))))
(check-by-interp
 '(module
    (letrec ((|-.66|
              (lambda (tmp.29 tmp.30)
                (if (fixnum? tmp.30)
                  (if (fixnum? tmp.29) (unsafe-fx- tmp.29 tmp.30) (error 3))
                  (error 3))))
             (*.65
              (lambda (tmp.25 tmp.26)
                (if (fixnum? tmp.26)
                  (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
                  (error 1))))
             (|+.64|
              (lambda (tmp.27 tmp.28)
                (if (fixnum? tmp.28)
                  (if (fixnum? tmp.27) (unsafe-fx+ tmp.27 tmp.28) (error 2))
                  (error 2))))
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.39)
                  (error 8))))
             (fun/ascii-char8617.4 (lambda () #\X))
             (fun/vector8619.5
              (lambda () (unsafe-procedure-call make-vector.63 8)))
             (fun/void8618.6 (lambda () (void))))
      (let ((fixnum0.10
             (unsafe-procedure-call
              *.65
              (unsafe-procedure-call |+.64| 178 122)
              (unsafe-procedure-call |+.64| 57 87)))
            (ascii-char1.9 (unsafe-procedure-call fun/ascii-char8617.4))
            (fixnum2.8
             (unsafe-procedure-call
              |+.64|
              (unsafe-procedure-call |-.66| 27 2)
              (unsafe-procedure-call *.65 32 157)))
            (void3.7 (unsafe-procedure-call fun/void8618.6)))
        (unsafe-procedure-call fun/vector8619.5)))))
(check-by-interp
 '(module
    (letrec ((vector?.67 (lambda (tmp.57) (vector? tmp.57)))
             (error?.66 (lambda (tmp.55) (error? tmp.55)))
             (vector-init-loop.15
              (lambda (len.16 i.18 vec.17)
                (if (eq? len.16 i.18)
                  vec.17
                  (begin
                    (unsafe-vector-set! vec.17 i.18 0)
                    (unsafe-procedure-call
                     vector-init-loop.15
                     len.16
                     (unsafe-fx+ i.18 1)
                     vec.17)))))
             (make-init-vector.1
              (lambda (tmp.13)
                (let ((tmp.14 (unsafe-make-vector tmp.13)))
                  (unsafe-procedure-call
                   vector-init-loop.15
                   tmp.13
                   0
                   tmp.14))))
             (make-vector.65
              (lambda (tmp.41)
                (if (fixnum? tmp.41)
                  (unsafe-procedure-call make-init-vector.1 tmp.41)
                  (error 8))))
             (fun/any8771.4
              (lambda () (unsafe-procedure-call make-vector.65 8)))
             (fun/empty8774.5 (lambda () empty))
             (fun/void8770.6 (lambda () (void)))
             (fun/any8773.7 (lambda () empty))
             (fun/vector8772.8
              (lambda () (unsafe-procedure-call make-vector.65 8))))
      (let ((void0.12 (unsafe-procedure-call fun/void8770.6))
            (boolean1.11
             (unsafe-procedure-call
              error?.66
              (unsafe-procedure-call fun/any8771.4)))
            (vector2.10 (unsafe-procedure-call fun/vector8772.8))
            (procedure3.9
             (lambda ()
               (unsafe-procedure-call
                vector?.67
                (unsafe-procedure-call fun/any8773.7)))))
        (unsafe-procedure-call fun/empty8774.5)))))
(check-by-interp
 '(module
    (letrec ((|+.75|
              (lambda (tmp.35 tmp.36)
                (if (fixnum? tmp.36)
                  (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
                  (error 2))))
             (|-.74|
              (lambda (tmp.37 tmp.38)
                (if (fixnum? tmp.38)
                  (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
                  (error 3))))
             (*.73
              (lambda (tmp.33 tmp.34)
                (if (fixnum? tmp.34)
                  (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
                  (error 1))))
             (cons.72 (lambda (tmp.66 tmp.67) (cons tmp.66 tmp.67)))
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.47)
                  (error 8))))
             (fun/void9398.4
              (lambda () (unsafe-procedure-call fun/void9399.9)))
             (fun/empty9407.5 (lambda () empty))
             (fun/ascii-char9403.6 (lambda () #\d))
             (fun/pair9400.7
              (lambda () (unsafe-procedure-call fun/pair9401.12)))
             (fun/vector9404.8
              (lambda () (unsafe-procedure-call fun/vector9405.11)))
             (fun/void9399.9 (lambda () (void)))
             (fun/empty9406.10
              (lambda () (unsafe-procedure-call fun/empty9407.5)))
             (fun/vector9405.11
              (lambda () (unsafe-procedure-call make-vector.71 8)))
             (fun/pair9401.12
              (lambda () (unsafe-procedure-call cons.72 242 377)))
             (fun/ascii-char9402.13
              (lambda () (unsafe-procedure-call fun/ascii-char9403.6))))
      (let ((void0.18 (unsafe-procedure-call fun/void9398.4))
            (fixnum1.17
             (unsafe-procedure-call
              |-.74|
              (unsafe-procedure-call
               *.73
               (unsafe-procedure-call *.73 245 94)
               (unsafe-procedure-call |-.74| 94 201))
              (unsafe-procedure-call
               |+.75|
               (unsafe-procedure-call |-.74| 225 16)
               (unsafe-procedure-call |+.75| 46 174))))
            (procedure2.16 (lambda () (unsafe-procedure-call fun/pair9400.7)))
            (ascii-char3.15 (unsafe-procedure-call fun/ascii-char9402.13))
            (procedure4.14
             (lambda () (unsafe-procedure-call fun/vector9404.8))))
        (unsafe-procedure-call fun/empty9406.10)))))
(check-by-interp
 '(module
    (letrec ((|-.77|
              (lambda (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (*.76
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|+.75|
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (cons.74 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
             (fun/empty13316.4
              (lambda () (unsafe-procedure-call fun/empty13317.11)))
             (fun/ascii-char13315.5 (lambda () #\d))
             (fun/error13313.6 (lambda () (error 61)))
             (fun/error13308.7
              (lambda () (unsafe-procedure-call fun/error13309.12)))
             (fun/error13312.8
              (lambda () (unsafe-procedure-call fun/error13313.6)))
             (fun/pair13319.9
              (lambda () (unsafe-procedure-call cons.74 243 439)))
             (fun/void13310.10
              (lambda () (unsafe-procedure-call fun/void13311.14)))
             (fun/empty13317.11 (lambda () empty))
             (fun/error13309.12 (lambda () (error 248)))
             (fun/ascii-char13314.13
              (lambda () (unsafe-procedure-call fun/ascii-char13315.5)))
             (fun/void13311.14 (lambda () (void)))
             (fun/pair13318.15
              (lambda () (unsafe-procedure-call fun/pair13319.9))))
      (let ((error0.21 (unsafe-procedure-call fun/error13308.7))
            (void1.20 (unsafe-procedure-call fun/void13310.10))
            (error2.19 (unsafe-procedure-call fun/error13312.8))
            (fixnum3.18
             (unsafe-procedure-call
              |-.77|
              (unsafe-procedure-call
               |-.77|
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call |+.75| 109 250)
                (unsafe-procedure-call *.76 227 148))
               (unsafe-procedure-call
                *.76
                (unsafe-procedure-call |-.77| 215 130)
                (unsafe-procedure-call *.76 223 30)))
              (unsafe-procedure-call
               *.76
               (unsafe-procedure-call
                |-.77|
                (unsafe-procedure-call *.76 247 1)
                (unsafe-procedure-call *.76 63 60))
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call *.76 208 208)
                (unsafe-procedure-call |-.77| 184 128)))))
            (ascii-char4.17 (unsafe-procedure-call fun/ascii-char13314.13))
            (empty5.16 (unsafe-procedure-call fun/empty13316.4)))
        (unsafe-procedure-call fun/pair13318.15)))))
(check-by-interp
 '(module
    (letrec ((|-.73|
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                  (error 3))))
             (|+.72|
              (lambda (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                  (error 2))))
             (*.71
              (lambda (tmp.32 tmp.33)
                (if (fixnum? tmp.33)
                  (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                  (error 1))))
             (vector-init-loop.20
              (lambda (len.21 i.23 vec.22)
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
              (lambda (tmp.18)
                (let ((tmp.19 (unsafe-make-vector tmp.18)))
                  (unsafe-procedure-call
                   vector-init-loop.20
                   tmp.18
                   0
                   tmp.19))))
             (make-vector.70
              (lambda (tmp.46)
                (if (fixnum? tmp.46)
                  (unsafe-procedure-call make-init-vector.1 tmp.46)
                  (error 8))))
             (fun/error13358.4
              (lambda () (unsafe-procedure-call fun/error13359.10)))
             (fun/vector13357.5
              (lambda () (unsafe-procedure-call make-vector.70 8)))
             (fun/vector13355.6
              (lambda () (unsafe-procedure-call make-vector.70 8)))
             (fun/ascii-char13352.7
              (lambda () (unsafe-procedure-call fun/ascii-char13353.11)))
             (fun/vector13354.8
              (lambda () (unsafe-procedure-call fun/vector13355.6)))
             (fun/vector13356.9
              (lambda () (unsafe-procedure-call fun/vector13357.5)))
             (fun/error13359.10 (lambda () (error 4)))
             (fun/ascii-char13353.11 (lambda () #\H)))
      (let ((fixnum0.17
             (unsafe-procedure-call
              *.71
              (unsafe-procedure-call
               |+.72|
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call *.71 61 201)
                (unsafe-procedure-call *.71 11 18))
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call |-.73| 92 27)
                (unsafe-procedure-call |+.72| 99 227)))
              (unsafe-procedure-call
               |+.72|
               (unsafe-procedure-call
                *.71
                (unsafe-procedure-call |-.73| 78 219)
                (unsafe-procedure-call |+.72| 231 79))
               (unsafe-procedure-call
                |+.72|
                (unsafe-procedure-call |-.73| 40 93)
                (unsafe-procedure-call *.71 114 8)))))
            (ascii-char1.16 (unsafe-procedure-call fun/ascii-char13352.7))
            (procedure2.15
             (lambda () (unsafe-procedure-call fun/vector13354.8)))
            (fixnum3.14
             (unsafe-procedure-call
              |-.73|
              (unsafe-procedure-call
               *.71
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call |-.73| 184 187)
                (unsafe-procedure-call |-.73| 249 83))
               (unsafe-procedure-call
                |-.73|
                (unsafe-procedure-call *.71 248 208)
                (unsafe-procedure-call |+.72| 199 131)))
              (unsafe-procedure-call
               |-.73|
               (unsafe-procedure-call
                *.71
                (unsafe-procedure-call *.71 16 237)
                (unsafe-procedure-call *.71 184 137))
               (unsafe-procedure-call
                *.71
                (unsafe-procedure-call |-.73| 76 191)
                (unsafe-procedure-call |-.73| 185 90)))))
            (vector4.13 (unsafe-procedure-call fun/vector13356.9))
            (error5.12 (unsafe-procedure-call fun/error13358.4)))
        (if (procedure? procedure2.15)
          (if (eq? (unsafe-procedure-arity procedure2.15) 0)
            (unsafe-procedure-call procedure2.15)
            (error 42))
          (error 43))))))
(check-by-interp
 '(module
    (letrec ((*.74
              (lambda (tmp.34 tmp.35)
                (if (fixnum? tmp.35)
                  (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
                  (error 1))))
             (|+.73|
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
                  (error 2))))
             (|-.72|
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
                  (error 3))))
             (fun/void14593.4 (lambda () (void)))
             (fun/void14591.5 (lambda () (void)))
             (fun/void14590.6
              (lambda () (unsafe-procedure-call fun/void14591.5)))
             (fun/ascii-char14586.7
              (lambda () (unsafe-procedure-call fun/ascii-char14587.10)))
             (fun/void14588.8
              (lambda () (unsafe-procedure-call fun/void14589.12)))
             (fun/void14592.9
              (lambda () (unsafe-procedure-call fun/void14593.4)))
             (fun/ascii-char14587.10 (lambda () #\T))
             (fun/empty14585.11 (lambda () empty))
             (fun/void14589.12 (lambda () (void)))
             (fun/empty14584.13
              (lambda () (unsafe-procedure-call fun/empty14585.11))))
      (let ((empty0.19 (unsafe-procedure-call fun/empty14584.13))
            (ascii-char1.18 (unsafe-procedure-call fun/ascii-char14586.7))
            (void2.17 (unsafe-procedure-call fun/void14588.8))
            (fixnum3.16
             (unsafe-procedure-call
              |+.73|
              (unsafe-procedure-call
               |+.73|
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call |-.72| 194 113)
                (unsafe-procedure-call |-.72| 185 241))
               (unsafe-procedure-call
                *.74
                (unsafe-procedure-call |+.73| 162 91)
                (unsafe-procedure-call |-.72| 164 197)))
              (unsafe-procedure-call
               |+.73|
               (unsafe-procedure-call
                *.74
                (unsafe-procedure-call |-.72| 249 224)
                (unsafe-procedure-call |-.72| 250 187))
               (unsafe-procedure-call
                *.74
                (unsafe-procedure-call *.74 214 94)
                (unsafe-procedure-call *.74 206 191)))))
            (void4.15 (unsafe-procedure-call fun/void14590.6))
            (fixnum5.14
             (unsafe-procedure-call
              |+.73|
              (unsafe-procedure-call
               |-.72|
               (unsafe-procedure-call
                |+.73|
                (unsafe-procedure-call |-.72| 148 37)
                (unsafe-procedure-call *.74 110 11))
               (unsafe-procedure-call
                *.74
                (unsafe-procedure-call *.74 5 77)
                (unsafe-procedure-call |-.72| 53 223)))
              (unsafe-procedure-call
               |+.73|
               (unsafe-procedure-call
                |-.72|
                (unsafe-procedure-call *.74 64 86)
                (unsafe-procedure-call |-.72| 202 121))
               (unsafe-procedure-call
                *.74
                (unsafe-procedure-call *.74 76 26)
                (unsafe-procedure-call *.74 37 229))))))
        (unsafe-procedure-call fun/void14592.9)))))
(check-by-interp
 '(module
    (letrec ((empty?.79 (lambda (tmp.61) (empty? tmp.61)))
             (*.78
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|+.77|
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (|-.76|
              (lambda (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (cons.75 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/empty15140.4 (lambda () empty))
             (fun/void15145.5
              (lambda () (unsafe-procedure-call fun/void15146.12)))
             (fun/vector15138.6
              (lambda () (unsafe-procedure-call make-vector.74 8)))
             (fun/ascii-char15135.7
              (lambda () (unsafe-procedure-call fun/ascii-char15136.15)))
             (fun/void15142.8 (lambda () (void)))
             (fun/any15144.9
              (lambda () (unsafe-procedure-call cons.75 90 455)))
             (fun/any15143.10
              (lambda () (unsafe-procedure-call fun/any15144.9)))
             (fun/vector15137.11
              (lambda () (unsafe-procedure-call fun/vector15138.6)))
             (fun/void15146.12 (lambda () (void)))
             (fun/empty15139.13
              (lambda () (unsafe-procedure-call fun/empty15140.4)))
             (fun/void15141.14
              (lambda () (unsafe-procedure-call fun/void15142.8)))
             (fun/ascii-char15136.15 (lambda () #\N)))
      (let ((ascii-char0.21 (unsafe-procedure-call fun/ascii-char15135.7))
            (vector1.20 (unsafe-procedure-call fun/vector15137.11))
            (empty2.19 (unsafe-procedure-call fun/empty15139.13))
            (fixnum3.18
             (unsafe-procedure-call
              |+.77|
              (unsafe-procedure-call
               |-.76|
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call |-.76| 172 24)
                (unsafe-procedure-call |-.76| 248 201))
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call |+.77| 37 230)
                (unsafe-procedure-call |-.76| 61 215)))
              (unsafe-procedure-call
               |-.76|
               (unsafe-procedure-call
                |+.77|
                (unsafe-procedure-call *.78 171 97)
                (unsafe-procedure-call |-.76| 108 8))
               (unsafe-procedure-call
                |-.76|
                (unsafe-procedure-call |-.76| 49 73)
                (unsafe-procedure-call |+.77| 180 234)))))
            (void4.17 (unsafe-procedure-call fun/void15141.14))
            (boolean5.16
             (unsafe-procedure-call
              empty?.79
              (unsafe-procedure-call fun/any15143.10))))
        (unsafe-procedure-call fun/void15145.5)))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.26
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.52)
                  (error 8))))
             (fun/vector15770.4
              (lambda () (unsafe-procedure-call fun/vector15771.9)))
             (fun/empty15765.5 (lambda () empty))
             (fun/void15774.6
              (lambda () (unsafe-procedure-call fun/void15775.15)))
             (fun/error15773.7 (lambda () (error 17)))
             (fun/error15772.8
              (lambda () (unsafe-procedure-call fun/error15773.7)))
             (fun/vector15771.9
              (lambda () (unsafe-procedure-call make-vector.76 8)))
             (fun/ascii-char15769.10 (lambda () #\_))
             (fun/empty15767.11 (lambda () empty))
             (fun/ascii-char15776.12
              (lambda () (unsafe-procedure-call fun/ascii-char15777.16)))
             (fun/empty15766.13
              (lambda () (unsafe-procedure-call fun/empty15767.11)))
             (fun/empty15764.14
              (lambda () (unsafe-procedure-call fun/empty15765.5)))
             (fun/void15775.15 (lambda () (void)))
             (fun/ascii-char15777.16 (lambda () #\L))
             (fun/ascii-char15768.17
              (lambda () (unsafe-procedure-call fun/ascii-char15769.10))))
      (let ((procedure0.23
             (lambda () (unsafe-procedure-call fun/empty15764.14)))
            (empty1.22 (unsafe-procedure-call fun/empty15766.13))
            (ascii-char2.21 (unsafe-procedure-call fun/ascii-char15768.17))
            (vector3.20 (unsafe-procedure-call fun/vector15770.4))
            (error4.19 (unsafe-procedure-call fun/error15772.8))
            (void5.18 (unsafe-procedure-call fun/void15774.6)))
        (unsafe-procedure-call fun/ascii-char15776.12)))))
(check-by-interp
 '(module
    (letrec ((|+.78|
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (*.77
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|-.76|
              (lambda (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (cons.75 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/void21848.4 (lambda () (void)))
             (fun/ascii-char21854.5 (lambda () #\h))
             (fun/vector21856.6
              (lambda () (unsafe-procedure-call make-vector.74 8)))
             (fun/pair21851.7
              (lambda () (unsafe-procedure-call fun/pair21852.12)))
             (fun/vector21849.8
              (lambda () (unsafe-procedure-call fun/vector21850.9)))
             (fun/vector21850.9
              (lambda () (unsafe-procedure-call make-vector.74 8)))
             (fun/error21846.10 (lambda () (error 231)))
             (fun/vector21855.11
              (lambda () (unsafe-procedure-call fun/vector21856.6)))
             (fun/pair21852.12
              (lambda () (unsafe-procedure-call cons.75 78 279)))
             (fun/error21845.13
              (lambda () (unsafe-procedure-call fun/error21846.10)))
             (fun/ascii-char21853.14
              (lambda () (unsafe-procedure-call fun/ascii-char21854.5)))
             (fun/void21847.15
              (lambda () (unsafe-procedure-call fun/void21848.4))))
      (let ((error0.21 (unsafe-procedure-call fun/error21845.13))
            (void1.20 (unsafe-procedure-call fun/void21847.15))
            (vector2.19 (unsafe-procedure-call fun/vector21849.8))
            (procedure3.18 (lambda () (unsafe-procedure-call fun/pair21851.7)))
            (ascii-char4.17 (unsafe-procedure-call fun/ascii-char21853.14))
            (fixnum5.16
             (unsafe-procedure-call
              *.77
              (unsafe-procedure-call
               *.77
               (unsafe-procedure-call
                *.77
                (unsafe-procedure-call |-.76| 82 66)
                (unsafe-procedure-call |-.76| 146 83))
               (unsafe-procedure-call
                |+.78|
                (unsafe-procedure-call |+.78| 80 86)
                (unsafe-procedure-call |-.76| 83 43)))
              (unsafe-procedure-call
               *.77
               (unsafe-procedure-call
                |-.76|
                (unsafe-procedure-call *.77 176 39)
                (unsafe-procedure-call |-.76| 237 12))
               (unsafe-procedure-call
                |-.76|
                (unsafe-procedure-call *.77 137 222)
                (unsafe-procedure-call |-.76| 128 107))))))
        (unsafe-procedure-call fun/vector21855.11)))))
(check-by-interp
 '(module
    (letrec ((vector-init-loop.24
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
             (make-init-vector.1
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
                  (unsafe-procedure-call make-init-vector.1 tmp.50)
                  (error 8))))
             (fun/empty10026.4
              (lambda () (unsafe-procedure-call fun/empty10027.11)))
             (fun/void10033.5 (lambda () (void)))
             (fun/vector10030.6
              (lambda () (unsafe-procedure-call fun/vector10031.9)))
             (fun/empty10023.7 (lambda () empty))
             (fun/void10029.8 (lambda () (void)))
             (fun/vector10031.9
              (lambda () (unsafe-procedure-call make-vector.74 8)))
             (fun/void10028.10
              (lambda () (unsafe-procedure-call fun/void10029.8)))
             (fun/empty10027.11 (lambda () empty))
             (fun/vector10025.12
              (lambda () (unsafe-procedure-call make-vector.74 8)))
             (fun/empty10022.13
              (lambda () (unsafe-procedure-call fun/empty10023.7)))
             (fun/vector10024.14
              (lambda () (unsafe-procedure-call fun/vector10025.12)))
             (fun/void10032.15
              (lambda () (unsafe-procedure-call fun/void10033.5))))
      (let ((empty0.21 (unsafe-procedure-call fun/empty10022.13))
            (procedure1.20
             (lambda () (unsafe-procedure-call fun/vector10024.14)))
            (empty2.19 (unsafe-procedure-call fun/empty10026.4))
            (void3.18 (unsafe-procedure-call fun/void10028.10))
            (vector4.17 (unsafe-procedure-call fun/vector10030.6))
            (void5.16 (unsafe-procedure-call fun/void10032.15)))
        (if (procedure? procedure1.20)
          (if (eq? (unsafe-procedure-arity procedure1.20) 0)
            (unsafe-procedure-call procedure1.20)
            (error 42))
          (error 43))))))
(check-by-interp
 '(module
    (letrec ((fixnum?.77 (lambda (tmp.59) (fixnum? tmp.59)))
             (*.76
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                  (error 1))))
             (|+.75|
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                  (error 2))))
             (|-.74|
              (lambda (tmp.40 tmp.41)
                (if (fixnum? tmp.41)
                  (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                  (error 3))))
             (fun/any12092.4
              (lambda () (unsafe-procedure-call fun/any12093.9)))
             (fun/empty12090.5
              (lambda () (unsafe-procedure-call fun/empty12091.8)))
             (fun/error12095.6 (lambda () (error 45)))
             (fun/empty12096.7
              (lambda () (unsafe-procedure-call fun/empty12097.12)))
             (fun/empty12091.8 (lambda () empty))
             (fun/any12093.9 (lambda () (void)))
             (fun/void12099.10 (lambda () (void)))
             (fun/error12088.11
              (lambda () (unsafe-procedure-call fun/error12089.13)))
             (fun/empty12097.12 (lambda () empty))
             (fun/error12089.13 (lambda () (error 114)))
             (fun/error12094.14
              (lambda () (unsafe-procedure-call fun/error12095.6)))
             (fun/void12098.15
              (lambda () (unsafe-procedure-call fun/void12099.10))))
      (let ((procedure0.21
             (lambda () (unsafe-procedure-call fun/error12088.11)))
            (fixnum1.20
             (unsafe-procedure-call
              |-.74|
              (unsafe-procedure-call
               *.76
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call |-.74| 54 166)
                (unsafe-procedure-call |+.75| 146 119))
               (unsafe-procedure-call
                |-.74|
                (unsafe-procedure-call |-.74| 184 21)
                (unsafe-procedure-call *.76 8 253)))
              (unsafe-procedure-call
               |-.74|
               (unsafe-procedure-call
                |+.75|
                (unsafe-procedure-call |-.74| 209 95)
                (unsafe-procedure-call |+.75| 30 246))
               (unsafe-procedure-call
                *.76
                (unsafe-procedure-call |+.75| 68 87)
                (unsafe-procedure-call |-.74| 191 238)))))
            (empty2.19 (unsafe-procedure-call fun/empty12090.5))
            (boolean3.18
             (unsafe-procedure-call
              fixnum?.77
              (unsafe-procedure-call fun/any12092.4)))
            (error4.17 (unsafe-procedure-call fun/error12094.14))
            (empty5.16 (unsafe-procedure-call fun/empty12096.7)))
        (unsafe-procedure-call fun/void12098.15)))))
