#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../implement-safe-call.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unsafe-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unsafe-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-unsafe-data-lang-v9 p)
  (interp-exprs-unsafe-lang-v9 (fail-if-invalid (implement-safe-call p)))))

(check-by-interp '(module 173))
(check-by-interp '(module 239))
(check-by-interp
 '(module
    (define fun/error8447.4 (lambda () (error 233)))
    (call fun/error8447.4)))
(check-by-interp
 '(module (define fun/fixnum8450.4 (lambda () 36)) (call fun/fixnum8450.4)))
(check-by-interp
 '(module
    (define vector-init-loop.7
      (lambda (len.8 i.10 vec.9)
        (if (eq? len.8 i.10)
          vec.9
          (begin
            (unsafe-vector-set! vec.9 i.10 0)
            (call vector-init-loop.7 len.8 (unsafe-fx+ i.10 1) vec.9)))))
    (define make-init-vector.1
      (lambda (tmp.5)
        (let ((tmp.6 (unsafe-make-vector tmp.5)))
          (call vector-init-loop.7 tmp.5 0 tmp.6))))
    (define make-vector.57
      (lambda (tmp.33)
        (if (fixnum? tmp.33) (call make-init-vector.1 tmp.33) (error 8))))
    (define fun/vector8453.4 (lambda () (call make-vector.57 8)))
    (call fun/vector8453.4)))
(check-by-interp
 '(module
    (define fun/error8456.4 (lambda () (error 240)))
    (call fun/error8456.4)))
(check-by-interp '(module (if #t (error 111) (error 246))))
(check-by-interp
 '(module
    (define vector-init-loop.11
      (lambda (len.12 i.14 vec.13)
        (if (eq? len.12 i.14)
          vec.13
          (begin
            (unsafe-vector-set! vec.13 i.14 0)
            (call vector-init-loop.11 len.12 (unsafe-fx+ i.14 1) vec.13)))))
    (define make-init-vector.1
      (lambda (tmp.9)
        (let ((tmp.10 (unsafe-make-vector tmp.9)))
          (call vector-init-loop.11 tmp.9 0 tmp.10))))
    (define make-vector.61
      (lambda (tmp.37)
        (if (fixnum? tmp.37) (call make-init-vector.1 tmp.37) (error 8))))
    (define fun/error8470.4 (lambda (oprand0.6) (call fun/error8471.5)))
    (define fun/error8471.5 (lambda () (error 217)))
    (call
     fun/error8470.4
     (let ((fixnum0.8 250) (vector1.7 (call make-vector.61 8))) 136))))
(check-by-interp
 '(module
    (define fun/ascii-char8474.4 (lambda (oprand0.6) #\V))
    (define fun/void8475.5 (lambda (oprand0.7) (void)))
    (call fun/ascii-char8474.4 (call fun/void8475.5 #t))))
(check-by-interp
 '(module
    (define fun/empty8478.4 (lambda (oprand0.5) empty))
    (call
     fun/empty8478.4
     (let ((error0.7 (error 53)) (error1.6 (error 196))) empty))))
(check-by-interp
 '(module
    (define fun/ascii-char8481.4 (lambda (oprand0.5) #\\))
    (call fun/ascii-char8481.4 (if #f empty empty))))
(check-by-interp
 '(module
    (define ascii-char?.65 (lambda (tmp.52) (ascii-char? tmp.52)))
    (define *.64
      (lambda (tmp.25 tmp.26)
        (if (fixnum? tmp.26)
          (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
          (error 1))))
    (define cons.63 (lambda (tmp.58 tmp.59) (cons tmp.58 tmp.59)))
    (define fun/pair8495.4
      (lambda (oprand0.7 oprand1.6) (call fun/pair8496.5)))
    (define fun/pair8496.5 (lambda () (call cons.63 33 428)))
    (call
     fun/pair8495.4
     (call
      *.64
      (call *.64 120 100)
      (let ((ascii-char0.10 #\M) (boolean1.9 #t) (boolean2.8 #t)) 196))
     (call ascii-char?.65 (if #t #\^ (void))))))
(check-by-interp
 '(module
    (define vector-init-loop.23
      (lambda (len.24 i.26 vec.25)
        (if (eq? len.24 i.26)
          vec.25
          (begin
            (unsafe-vector-set! vec.25 i.26 0)
            (call vector-init-loop.23 len.24 (unsafe-fx+ i.26 1) vec.25)))))
    (define make-init-vector.1
      (lambda (tmp.21)
        (let ((tmp.22 (unsafe-make-vector tmp.21)))
          (call vector-init-loop.23 tmp.21 0 tmp.22))))
    (define make-vector.74
      (lambda (tmp.49)
        (if (fixnum? tmp.49) (call make-init-vector.1 tmp.49) (error 8))))
    (define cons.73 (lambda (tmp.68 tmp.69) (cons tmp.68 tmp.69)))
    (define fun/pair8508.4
      (lambda (oprand0.11 oprand1.10) (call fun/pair8509.5)))
    (define fun/pair8509.5 (lambda () (call cons.73 105 344)))
    (define fun/empty8511.6 (lambda (oprand0.13 oprand1.12) empty))
    (define fun/void8507.7 (lambda () (void)))
    (define fun/error8510.8 (lambda (oprand0.15 oprand1.14) (error 153)))
    (define fun/void8506.9
      (lambda (oprand0.17 oprand1.16) (call fun/void8507.7)))
    (call
     fun/void8506.9
     (let ((ascii-char0.20 #\j)
           (vector1.19 (call make-vector.74 8))
           (boolean2.18 #t))
       (error 147))
     (call
      fun/pair8508.4
      (call fun/error8510.8 (void) (void))
      (call fun/empty8511.6 (error 142) #\C)))))
(check-by-interp
 '(module
    (define boolean?.64 (lambda (tmp.48) (boolean? tmp.48)))
    (define cons.63 (lambda (tmp.57 tmp.58) (cons tmp.57 tmp.58)))
    (define vector-init-loop.12
      (lambda (len.13 i.15 vec.14)
        (if (eq? len.13 i.15)
          vec.14
          (begin
            (unsafe-vector-set! vec.14 i.15 0)
            (call vector-init-loop.12 len.13 (unsafe-fx+ i.15 1) vec.14)))))
    (define make-init-vector.1
      (lambda (tmp.10)
        (let ((tmp.11 (unsafe-make-vector tmp.10)))
          (call vector-init-loop.12 tmp.10 0 tmp.11))))
    (define make-vector.62
      (lambda (tmp.38)
        (if (fixnum? tmp.38) (call make-init-vector.1 tmp.38) (error 8))))
    (define fun/empty8535.4 (lambda () empty))
    (define fun/empty8537.5 (lambda () empty))
    (define fun/vector8536.6 (lambda () (call make-vector.62 8)))
    (let ((empty0.9 (call fun/empty8535.4))
          (boolean1.8 (call boolean?.64 (call cons.63 80 414)))
          (vector2.7 (call fun/vector8536.6)))
      (call fun/empty8537.5))))
(check-by-interp
 '(module
    (define cons.67 (lambda (tmp.62 tmp.63) (cons tmp.62 tmp.63)))
    (define fun/pair8561.4 (lambda () (call cons.67 251 399)))
    (define fun/ascii-char8562.5
      (lambda (oprand0.10 oprand1.9) (call fun/ascii-char8563.7)))
    (define fun/pair8560.6
      (lambda (oprand0.12 oprand1.11) (call fun/pair8561.4)))
    (define fun/ascii-char8563.7 (lambda () #\s))
    (define fun/empty8564.8 (lambda (oprand0.14 oprand1.13) empty))
    (call
     fun/pair8560.6
     (if #f 61 74)
     (call
      fun/ascii-char8562.5
      (call fun/empty8564.8 empty #\r)
      (if #t #t #f)))))
(check-by-interp
 '(module
    (define |+.67|
      (lambda (tmp.28 tmp.29)
        (if (fixnum? tmp.29)
          (if (fixnum? tmp.28) (unsafe-fx+ tmp.28 tmp.29) (error 2))
          (error 2))))
    (define |-.66|
      (lambda (tmp.30 tmp.31)
        (if (fixnum? tmp.31)
          (if (fixnum? tmp.30) (unsafe-fx- tmp.30 tmp.31) (error 3))
          (error 3))))
    (define *.65
      (lambda (tmp.26 tmp.27)
        (if (fixnum? tmp.27)
          (if (fixnum? tmp.26) (unsafe-fx* tmp.26 tmp.27) (error 1))
          (error 1))))
    (define vector-init-loop.14
      (lambda (len.15 i.17 vec.16)
        (if (eq? len.15 i.17)
          vec.16
          (begin
            (unsafe-vector-set! vec.16 i.17 0)
            (call vector-init-loop.14 len.15 (unsafe-fx+ i.17 1) vec.16)))))
    (define make-init-vector.1
      (lambda (tmp.12)
        (let ((tmp.13 (unsafe-make-vector tmp.12)))
          (call vector-init-loop.14 tmp.12 0 tmp.13))))
    (define make-vector.64
      (lambda (tmp.40)
        (if (fixnum? tmp.40) (call make-init-vector.1 tmp.40) (error 8))))
    (define fun/ascii-char8613.4 (lambda () #\B))
    (define fun/vector8612.5 (lambda () (call make-vector.64 8)))
    (define fun/ascii-char8614.6 (lambda () #\S))
    (define fun/void8611.7 (lambda () (void)))
    (let ((fixnum0.11 (call |+.67| (call *.65 77 201) (call |-.66| 53 40)))
          (void1.10 (call fun/void8611.7))
          (vector2.9 (call fun/vector8612.5))
          (ascii-char3.8 (call fun/ascii-char8613.4)))
      (call fun/ascii-char8614.6))))
(check-by-interp
 '(module
    (define |-.66|
      (lambda (tmp.29 tmp.30)
        (if (fixnum? tmp.30)
          (if (fixnum? tmp.29) (unsafe-fx- tmp.29 tmp.30) (error 3))
          (error 3))))
    (define *.65
      (lambda (tmp.25 tmp.26)
        (if (fixnum? tmp.26)
          (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
          (error 1))))
    (define |+.64|
      (lambda (tmp.27 tmp.28)
        (if (fixnum? tmp.28)
          (if (fixnum? tmp.27) (unsafe-fx+ tmp.27 tmp.28) (error 2))
          (error 2))))
    (define vector-init-loop.13
      (lambda (len.14 i.16 vec.15)
        (if (eq? len.14 i.16)
          vec.15
          (begin
            (unsafe-vector-set! vec.15 i.16 0)
            (call vector-init-loop.13 len.14 (unsafe-fx+ i.16 1) vec.15)))))
    (define make-init-vector.1
      (lambda (tmp.11)
        (let ((tmp.12 (unsafe-make-vector tmp.11)))
          (call vector-init-loop.13 tmp.11 0 tmp.12))))
    (define make-vector.63
      (lambda (tmp.39)
        (if (fixnum? tmp.39) (call make-init-vector.1 tmp.39) (error 8))))
    (define fun/ascii-char8617.4 (lambda () #\X))
    (define fun/vector8619.5 (lambda () (call make-vector.63 8)))
    (define fun/void8618.6 (lambda () (void)))
    (let ((fixnum0.10 (call *.65 (call |+.64| 178 122) (call |+.64| 57 87)))
          (ascii-char1.9 (call fun/ascii-char8617.4))
          (fixnum2.8 (call |+.64| (call |-.66| 27 2) (call *.65 32 157)))
          (void3.7 (call fun/void8618.6)))
      (call fun/vector8619.5))))
(check-by-interp
 '(module
    (define vector?.67 (lambda (tmp.57) (vector? tmp.57)))
    (define error?.66 (lambda (tmp.55) (error? tmp.55)))
    (define vector-init-loop.15
      (lambda (len.16 i.18 vec.17)
        (if (eq? len.16 i.18)
          vec.17
          (begin
            (unsafe-vector-set! vec.17 i.18 0)
            (call vector-init-loop.15 len.16 (unsafe-fx+ i.18 1) vec.17)))))
    (define make-init-vector.1
      (lambda (tmp.13)
        (let ((tmp.14 (unsafe-make-vector tmp.13)))
          (call vector-init-loop.15 tmp.13 0 tmp.14))))
    (define make-vector.65
      (lambda (tmp.41)
        (if (fixnum? tmp.41) (call make-init-vector.1 tmp.41) (error 8))))
    (define fun/any8771.4 (lambda () (call make-vector.65 8)))
    (define fun/empty8774.5 (lambda () empty))
    (define fun/void8770.6 (lambda () (void)))
    (define fun/any8773.7 (lambda () empty))
    (define fun/vector8772.8 (lambda () (call make-vector.65 8)))
    (let ((void0.12 (call fun/void8770.6))
          (boolean1.11 (call error?.66 (call fun/any8771.4)))
          (vector2.10 (call fun/vector8772.8))
          (procedure3.9 (lambda () (call vector?.67 (call fun/any8773.7)))))
      (call fun/empty8774.5))))
(check-by-interp
 '(module
    (define |+.75|
      (lambda (tmp.35 tmp.36)
        (if (fixnum? tmp.36)
          (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
          (error 2))))
    (define |-.74|
      (lambda (tmp.37 tmp.38)
        (if (fixnum? tmp.38)
          (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
          (error 3))))
    (define *.73
      (lambda (tmp.33 tmp.34)
        (if (fixnum? tmp.34)
          (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
          (error 1))))
    (define cons.72 (lambda (tmp.66 tmp.67) (cons tmp.66 tmp.67)))
    (define vector-init-loop.21
      (lambda (len.22 i.24 vec.23)
        (if (eq? len.22 i.24)
          vec.23
          (begin
            (unsafe-vector-set! vec.23 i.24 0)
            (call vector-init-loop.21 len.22 (unsafe-fx+ i.24 1) vec.23)))))
    (define make-init-vector.1
      (lambda (tmp.19)
        (let ((tmp.20 (unsafe-make-vector tmp.19)))
          (call vector-init-loop.21 tmp.19 0 tmp.20))))
    (define make-vector.71
      (lambda (tmp.47)
        (if (fixnum? tmp.47) (call make-init-vector.1 tmp.47) (error 8))))
    (define fun/void9398.4 (lambda () (call fun/void9399.9)))
    (define fun/empty9407.5 (lambda () empty))
    (define fun/ascii-char9403.6 (lambda () #\d))
    (define fun/pair9400.7 (lambda () (call fun/pair9401.12)))
    (define fun/vector9404.8 (lambda () (call fun/vector9405.11)))
    (define fun/void9399.9 (lambda () (void)))
    (define fun/empty9406.10 (lambda () (call fun/empty9407.5)))
    (define fun/vector9405.11 (lambda () (call make-vector.71 8)))
    (define fun/pair9401.12 (lambda () (call cons.72 242 377)))
    (define fun/ascii-char9402.13 (lambda () (call fun/ascii-char9403.6)))
    (let ((void0.18 (call fun/void9398.4))
          (fixnum1.17
           (call
            |-.74|
            (call *.73 (call *.73 245 94) (call |-.74| 94 201))
            (call |+.75| (call |-.74| 225 16) (call |+.75| 46 174))))
          (procedure2.16 (lambda () (call fun/pair9400.7)))
          (ascii-char3.15 (call fun/ascii-char9402.13))
          (procedure4.14 (lambda () (call fun/vector9404.8))))
      (call fun/empty9406.10))))
(check-by-interp
 '(module
    (define |-.77|
      (lambda (tmp.40 tmp.41)
        (if (fixnum? tmp.41)
          (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
          (error 3))))
    (define *.76
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
          (error 1))))
    (define |+.75|
      (lambda (tmp.38 tmp.39)
        (if (fixnum? tmp.39)
          (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
          (error 2))))
    (define cons.74 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
    (define fun/empty13316.4 (lambda () (call fun/empty13317.11)))
    (define fun/ascii-char13315.5 (lambda () #\d))
    (define fun/error13313.6 (lambda () (error 61)))
    (define fun/error13308.7 (lambda () (call fun/error13309.12)))
    (define fun/error13312.8 (lambda () (call fun/error13313.6)))
    (define fun/pair13319.9 (lambda () (call cons.74 243 439)))
    (define fun/void13310.10 (lambda () (call fun/void13311.14)))
    (define fun/empty13317.11 (lambda () empty))
    (define fun/error13309.12 (lambda () (error 248)))
    (define fun/ascii-char13314.13 (lambda () (call fun/ascii-char13315.5)))
    (define fun/void13311.14 (lambda () (void)))
    (define fun/pair13318.15 (lambda () (call fun/pair13319.9)))
    (let ((error0.21 (call fun/error13308.7))
          (void1.20 (call fun/void13310.10))
          (error2.19 (call fun/error13312.8))
          (fixnum3.18
           (call
            |-.77|
            (call
             |-.77|
             (call |+.75| (call |+.75| 109 250) (call *.76 227 148))
             (call *.76 (call |-.77| 215 130) (call *.76 223 30)))
            (call
             *.76
             (call |-.77| (call *.76 247 1) (call *.76 63 60))
             (call |+.75| (call *.76 208 208) (call |-.77| 184 128)))))
          (ascii-char4.17 (call fun/ascii-char13314.13))
          (empty5.16 (call fun/empty13316.4)))
      (call fun/pair13318.15))))
(check-by-interp
 '(module
    (define |-.73|
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
          (error 3))))
    (define |+.72|
      (lambda (tmp.34 tmp.35)
        (if (fixnum? tmp.35)
          (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
          (error 2))))
    (define *.71
      (lambda (tmp.32 tmp.33)
        (if (fixnum? tmp.33)
          (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
          (error 1))))
    (define vector-init-loop.20
      (lambda (len.21 i.23 vec.22)
        (if (eq? len.21 i.23)
          vec.22
          (begin
            (unsafe-vector-set! vec.22 i.23 0)
            (call vector-init-loop.20 len.21 (unsafe-fx+ i.23 1) vec.22)))))
    (define make-init-vector.1
      (lambda (tmp.18)
        (let ((tmp.19 (unsafe-make-vector tmp.18)))
          (call vector-init-loop.20 tmp.18 0 tmp.19))))
    (define make-vector.70
      (lambda (tmp.46)
        (if (fixnum? tmp.46) (call make-init-vector.1 tmp.46) (error 8))))
    (define fun/error13358.4 (lambda () (call fun/error13359.10)))
    (define fun/vector13357.5 (lambda () (call make-vector.70 8)))
    (define fun/vector13355.6 (lambda () (call make-vector.70 8)))
    (define fun/ascii-char13352.7 (lambda () (call fun/ascii-char13353.11)))
    (define fun/vector13354.8 (lambda () (call fun/vector13355.6)))
    (define fun/vector13356.9 (lambda () (call fun/vector13357.5)))
    (define fun/error13359.10 (lambda () (error 4)))
    (define fun/ascii-char13353.11 (lambda () #\H))
    (let ((fixnum0.17
           (call
            *.71
            (call
             |+.72|
             (call |+.72| (call *.71 61 201) (call *.71 11 18))
             (call |+.72| (call |-.73| 92 27) (call |+.72| 99 227)))
            (call
             |+.72|
             (call *.71 (call |-.73| 78 219) (call |+.72| 231 79))
             (call |+.72| (call |-.73| 40 93) (call *.71 114 8)))))
          (ascii-char1.16 (call fun/ascii-char13352.7))
          (procedure2.15 (lambda () (call fun/vector13354.8)))
          (fixnum3.14
           (call
            |-.73|
            (call
             *.71
             (call |-.73| (call |-.73| 184 187) (call |-.73| 249 83))
             (call |-.73| (call *.71 248 208) (call |+.72| 199 131)))
            (call
             |-.73|
             (call *.71 (call *.71 16 237) (call *.71 184 137))
             (call *.71 (call |-.73| 76 191) (call |-.73| 185 90)))))
          (vector4.13 (call fun/vector13356.9))
          (error5.12 (call fun/error13358.4)))
      (call procedure2.15))))
(check-by-interp
 '(module
    (define *.74
      (lambda (tmp.34 tmp.35)
        (if (fixnum? tmp.35)
          (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
          (error 1))))
    (define |+.73|
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
          (error 2))))
    (define |-.72|
      (lambda (tmp.38 tmp.39)
        (if (fixnum? tmp.39)
          (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
          (error 3))))
    (define fun/void14593.4 (lambda () (void)))
    (define fun/void14591.5 (lambda () (void)))
    (define fun/void14590.6 (lambda () (call fun/void14591.5)))
    (define fun/ascii-char14586.7 (lambda () (call fun/ascii-char14587.10)))
    (define fun/void14588.8 (lambda () (call fun/void14589.12)))
    (define fun/void14592.9 (lambda () (call fun/void14593.4)))
    (define fun/ascii-char14587.10 (lambda () #\T))
    (define fun/empty14585.11 (lambda () empty))
    (define fun/void14589.12 (lambda () (void)))
    (define fun/empty14584.13 (lambda () (call fun/empty14585.11)))
    (let ((empty0.19 (call fun/empty14584.13))
          (ascii-char1.18 (call fun/ascii-char14586.7))
          (void2.17 (call fun/void14588.8))
          (fixnum3.16
           (call
            |+.73|
            (call
             |+.73|
             (call |-.72| (call |-.72| 194 113) (call |-.72| 185 241))
             (call *.74 (call |+.73| 162 91) (call |-.72| 164 197)))
            (call
             |+.73|
             (call *.74 (call |-.72| 249 224) (call |-.72| 250 187))
             (call *.74 (call *.74 214 94) (call *.74 206 191)))))
          (void4.15 (call fun/void14590.6))
          (fixnum5.14
           (call
            |+.73|
            (call
             |-.72|
             (call |+.73| (call |-.72| 148 37) (call *.74 110 11))
             (call *.74 (call *.74 5 77) (call |-.72| 53 223)))
            (call
             |+.73|
             (call |-.72| (call *.74 64 86) (call |-.72| 202 121))
             (call *.74 (call *.74 76 26) (call *.74 37 229))))))
      (call fun/void14592.9))))
(check-by-interp
 '(module
    (define empty?.79 (lambda (tmp.61) (empty? tmp.61)))
    (define *.78
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
          (error 1))))
    (define |+.77|
      (lambda (tmp.38 tmp.39)
        (if (fixnum? tmp.39)
          (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
          (error 2))))
    (define |-.76|
      (lambda (tmp.40 tmp.41)
        (if (fixnum? tmp.41)
          (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
          (error 3))))
    (define cons.75 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
    (define vector-init-loop.24
      (lambda (len.25 i.27 vec.26)
        (if (eq? len.25 i.27)
          vec.26
          (begin
            (unsafe-vector-set! vec.26 i.27 0)
            (call vector-init-loop.24 len.25 (unsafe-fx+ i.27 1) vec.26)))))
    (define make-init-vector.1
      (lambda (tmp.22)
        (let ((tmp.23 (unsafe-make-vector tmp.22)))
          (call vector-init-loop.24 tmp.22 0 tmp.23))))
    (define make-vector.74
      (lambda (tmp.50)
        (if (fixnum? tmp.50) (call make-init-vector.1 tmp.50) (error 8))))
    (define fun/empty15140.4 (lambda () empty))
    (define fun/void15145.5 (lambda () (call fun/void15146.12)))
    (define fun/vector15138.6 (lambda () (call make-vector.74 8)))
    (define fun/ascii-char15135.7 (lambda () (call fun/ascii-char15136.15)))
    (define fun/void15142.8 (lambda () (void)))
    (define fun/any15144.9 (lambda () (call cons.75 90 455)))
    (define fun/any15143.10 (lambda () (call fun/any15144.9)))
    (define fun/vector15137.11 (lambda () (call fun/vector15138.6)))
    (define fun/void15146.12 (lambda () (void)))
    (define fun/empty15139.13 (lambda () (call fun/empty15140.4)))
    (define fun/void15141.14 (lambda () (call fun/void15142.8)))
    (define fun/ascii-char15136.15 (lambda () #\N))
    (let ((ascii-char0.21 (call fun/ascii-char15135.7))
          (vector1.20 (call fun/vector15137.11))
          (empty2.19 (call fun/empty15139.13))
          (fixnum3.18
           (call
            |+.77|
            (call
             |-.76|
             (call |+.77| (call |-.76| 172 24) (call |-.76| 248 201))
             (call |+.77| (call |+.77| 37 230) (call |-.76| 61 215)))
            (call
             |-.76|
             (call |+.77| (call *.78 171 97) (call |-.76| 108 8))
             (call |-.76| (call |-.76| 49 73) (call |+.77| 180 234)))))
          (void4.17 (call fun/void15141.14))
          (boolean5.16 (call empty?.79 (call fun/any15143.10))))
      (call fun/void15145.5))))
(check-by-interp
 '(module
    (define vector-init-loop.26
      (lambda (len.27 i.29 vec.28)
        (if (eq? len.27 i.29)
          vec.28
          (begin
            (unsafe-vector-set! vec.28 i.29 0)
            (call vector-init-loop.26 len.27 (unsafe-fx+ i.29 1) vec.28)))))
    (define make-init-vector.1
      (lambda (tmp.24)
        (let ((tmp.25 (unsafe-make-vector tmp.24)))
          (call vector-init-loop.26 tmp.24 0 tmp.25))))
    (define make-vector.76
      (lambda (tmp.52)
        (if (fixnum? tmp.52) (call make-init-vector.1 tmp.52) (error 8))))
    (define fun/vector15770.4 (lambda () (call fun/vector15771.9)))
    (define fun/empty15765.5 (lambda () empty))
    (define fun/void15774.6 (lambda () (call fun/void15775.15)))
    (define fun/error15773.7 (lambda () (error 17)))
    (define fun/error15772.8 (lambda () (call fun/error15773.7)))
    (define fun/vector15771.9 (lambda () (call make-vector.76 8)))
    (define fun/ascii-char15769.10 (lambda () #\_))
    (define fun/empty15767.11 (lambda () empty))
    (define fun/ascii-char15776.12 (lambda () (call fun/ascii-char15777.16)))
    (define fun/empty15766.13 (lambda () (call fun/empty15767.11)))
    (define fun/empty15764.14 (lambda () (call fun/empty15765.5)))
    (define fun/void15775.15 (lambda () (void)))
    (define fun/ascii-char15777.16 (lambda () #\L))
    (define fun/ascii-char15768.17 (lambda () (call fun/ascii-char15769.10)))
    (let ((procedure0.23 (lambda () (call fun/empty15764.14)))
          (empty1.22 (call fun/empty15766.13))
          (ascii-char2.21 (call fun/ascii-char15768.17))
          (vector3.20 (call fun/vector15770.4))
          (error4.19 (call fun/error15772.8))
          (void5.18 (call fun/void15774.6)))
      (call fun/ascii-char15776.12))))
(check-by-interp
 '(module
    (define |+.78|
      (lambda (tmp.38 tmp.39)
        (if (fixnum? tmp.39)
          (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
          (error 2))))
    (define *.77
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
          (error 1))))
    (define |-.76|
      (lambda (tmp.40 tmp.41)
        (if (fixnum? tmp.41)
          (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
          (error 3))))
    (define cons.75 (lambda (tmp.69 tmp.70) (cons tmp.69 tmp.70)))
    (define vector-init-loop.24
      (lambda (len.25 i.27 vec.26)
        (if (eq? len.25 i.27)
          vec.26
          (begin
            (unsafe-vector-set! vec.26 i.27 0)
            (call vector-init-loop.24 len.25 (unsafe-fx+ i.27 1) vec.26)))))
    (define make-init-vector.1
      (lambda (tmp.22)
        (let ((tmp.23 (unsafe-make-vector tmp.22)))
          (call vector-init-loop.24 tmp.22 0 tmp.23))))
    (define make-vector.74
      (lambda (tmp.50)
        (if (fixnum? tmp.50) (call make-init-vector.1 tmp.50) (error 8))))
    (define fun/void21848.4 (lambda () (void)))
    (define fun/ascii-char21854.5 (lambda () #\h))
    (define fun/vector21856.6 (lambda () (call make-vector.74 8)))
    (define fun/pair21851.7 (lambda () (call fun/pair21852.12)))
    (define fun/vector21849.8 (lambda () (call fun/vector21850.9)))
    (define fun/vector21850.9 (lambda () (call make-vector.74 8)))
    (define fun/error21846.10 (lambda () (error 231)))
    (define fun/vector21855.11 (lambda () (call fun/vector21856.6)))
    (define fun/pair21852.12 (lambda () (call cons.75 78 279)))
    (define fun/error21845.13 (lambda () (call fun/error21846.10)))
    (define fun/ascii-char21853.14 (lambda () (call fun/ascii-char21854.5)))
    (define fun/void21847.15 (lambda () (call fun/void21848.4)))
    (let ((error0.21 (call fun/error21845.13))
          (void1.20 (call fun/void21847.15))
          (vector2.19 (call fun/vector21849.8))
          (procedure3.18 (lambda () (call fun/pair21851.7)))
          (ascii-char4.17 (call fun/ascii-char21853.14))
          (fixnum5.16
           (call
            *.77
            (call
             *.77
             (call *.77 (call |-.76| 82 66) (call |-.76| 146 83))
             (call |+.78| (call |+.78| 80 86) (call |-.76| 83 43)))
            (call
             *.77
             (call |-.76| (call *.77 176 39) (call |-.76| 237 12))
             (call |-.76| (call *.77 137 222) (call |-.76| 128 107))))))
      (call fun/vector21855.11))))
(check-by-interp
 '(module
    (define vector-init-loop.24
      (lambda (len.25 i.27 vec.26)
        (if (eq? len.25 i.27)
          vec.26
          (begin
            (unsafe-vector-set! vec.26 i.27 0)
            (call vector-init-loop.24 len.25 (unsafe-fx+ i.27 1) vec.26)))))
    (define make-init-vector.1
      (lambda (tmp.22)
        (let ((tmp.23 (unsafe-make-vector tmp.22)))
          (call vector-init-loop.24 tmp.22 0 tmp.23))))
    (define make-vector.74
      (lambda (tmp.50)
        (if (fixnum? tmp.50) (call make-init-vector.1 tmp.50) (error 8))))
    (define fun/empty10026.4 (lambda () (call fun/empty10027.11)))
    (define fun/void10033.5 (lambda () (void)))
    (define fun/vector10030.6 (lambda () (call fun/vector10031.9)))
    (define fun/empty10023.7 (lambda () empty))
    (define fun/void10029.8 (lambda () (void)))
    (define fun/vector10031.9 (lambda () (call make-vector.74 8)))
    (define fun/void10028.10 (lambda () (call fun/void10029.8)))
    (define fun/empty10027.11 (lambda () empty))
    (define fun/vector10025.12 (lambda () (call make-vector.74 8)))
    (define fun/empty10022.13 (lambda () (call fun/empty10023.7)))
    (define fun/vector10024.14 (lambda () (call fun/vector10025.12)))
    (define fun/void10032.15 (lambda () (call fun/void10033.5)))
    (let ((empty0.21 (call fun/empty10022.13))
          (procedure1.20 (lambda () (call fun/vector10024.14)))
          (empty2.19 (call fun/empty10026.4))
          (void3.18 (call fun/void10028.10))
          (vector4.17 (call fun/vector10030.6))
          (void5.16 (call fun/void10032.15)))
      (call procedure1.20))))
(check-by-interp
 '(module
    (define fixnum?.77 (lambda (tmp.59) (fixnum? tmp.59)))
    (define *.76
      (lambda (tmp.36 tmp.37)
        (if (fixnum? tmp.37)
          (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
          (error 1))))
    (define |+.75|
      (lambda (tmp.38 tmp.39)
        (if (fixnum? tmp.39)
          (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
          (error 2))))
    (define |-.74|
      (lambda (tmp.40 tmp.41)
        (if (fixnum? tmp.41)
          (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
          (error 3))))
    (define fun/any12092.4 (lambda () (call fun/any12093.9)))
    (define fun/empty12090.5 (lambda () (call fun/empty12091.8)))
    (define fun/error12095.6 (lambda () (error 45)))
    (define fun/empty12096.7 (lambda () (call fun/empty12097.12)))
    (define fun/empty12091.8 (lambda () empty))
    (define fun/any12093.9 (lambda () (void)))
    (define fun/void12099.10 (lambda () (void)))
    (define fun/error12088.11 (lambda () (call fun/error12089.13)))
    (define fun/empty12097.12 (lambda () empty))
    (define fun/error12089.13 (lambda () (error 114)))
    (define fun/error12094.14 (lambda () (call fun/error12095.6)))
    (define fun/void12098.15 (lambda () (call fun/void12099.10)))
    (let ((procedure0.21 (lambda () (call fun/error12088.11)))
          (fixnum1.20
           (call
            |-.74|
            (call
             *.76
             (call |-.74| (call |-.74| 54 166) (call |+.75| 146 119))
             (call |-.74| (call |-.74| 184 21) (call *.76 8 253)))
            (call
             |-.74|
             (call |+.75| (call |-.74| 209 95) (call |+.75| 30 246))
             (call *.76 (call |+.75| 68 87) (call |-.74| 191 238)))))
          (empty2.19 (call fun/empty12090.5))
          (boolean3.18 (call fixnum?.77 (call fun/any12092.4)))
          (error4.17 (call fun/error12094.14))
          (empty5.16 (call fun/empty12096.7)))
      (call fun/void12098.15))))
