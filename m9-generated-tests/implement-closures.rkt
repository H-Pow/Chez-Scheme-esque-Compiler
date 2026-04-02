#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../implement-closures.rkt")
(define (fail-if-invalid p)
  (when (not (proc-exposed-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "proc-exposed-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-hoisted-lang-v9 p)
  (interp-proc-exposed-lang-v9 (fail-if-invalid (implement-closures p)))))

(check-by-interp '(module 173))
(check-by-interp '(module 239))
(check-by-interp
 '(module
    (define L.fun/error8447.4.7 (lambda (c.57) (let () (error 233))))
    (cletrec
     ((fun/error8447.4 (make-closure L.fun/error8447.4.7 0)))
     (call L.fun/error8447.4.7 fun/error8447.4))))
(check-by-interp
 '(module
    (define L.fun/fixnum8450.4.7 (lambda (c.57) (let () 36)))
    (cletrec
     ((fun/fixnum8450.4 (make-closure L.fun/fixnum8450.4.7 0)))
     (call L.fun/fixnum8450.4.7 fun/fixnum8450.4))))
(check-by-interp
 '(module
    (define L.fun/vector8453.4.10
      (lambda (c.61)
        (let ((make-vector.57 (closure-ref c.61 0)))
          (call L.make-vector.57.9 make-vector.57 8))))
    (define L.make-vector.57.9
      (lambda (c.60 tmp.33)
        (let ((make-init-vector.1 (closure-ref c.60 0)))
          (if (fixnum? tmp.33)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.33)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.59 tmp.5)
        (let ((vector-init-loop.7 (closure-ref c.59 0)))
          (let ((tmp.6 (unsafe-make-vector tmp.5)))
            (call L.vector-init-loop.7.7 vector-init-loop.7 tmp.5 0 tmp.6)))))
    (define L.vector-init-loop.7.7
      (lambda (c.58 len.8 i.10 vec.9)
        (let ((vector-init-loop.7 (closure-ref c.58 0)))
          (if (eq? len.8 i.10)
            vec.9
            (begin
              (unsafe-vector-set! vec.9 i.10 0)
              (call
               L.vector-init-loop.7.7
               vector-init-loop.7
               len.8
               (unsafe-fx+ i.10 1)
               vec.9))))))
    (cletrec
     ((vector-init-loop.7
       (make-closure L.vector-init-loop.7.7 3 vector-init-loop.7))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.7))
      (make-vector.57 (make-closure L.make-vector.57.9 1 make-init-vector.1))
      (fun/vector8453.4 (make-closure L.fun/vector8453.4.10 0 make-vector.57)))
     (call L.fun/vector8453.4.10 fun/vector8453.4))))
(check-by-interp
 '(module
    (define L.fun/error8456.4.7 (lambda (c.57) (let () (error 240))))
    (cletrec
     ((fun/error8456.4 (make-closure L.fun/error8456.4.7 0)))
     (call L.fun/error8456.4.7 fun/error8456.4))))
(check-by-interp '(module (if #t (error 111) (error 246))))
(check-by-interp
 '(module
    (define L.fun/error8471.5.11 (lambda (c.66) (let () (error 217))))
    (define L.fun/error8470.4.10
      (lambda (c.65 oprand0.6)
        (let ((fun/error8471.5 (closure-ref c.65 0)))
          (call L.fun/error8471.5.11 fun/error8471.5))))
    (define L.make-vector.61.9
      (lambda (c.64 tmp.37)
        (let ((make-init-vector.1 (closure-ref c.64 0)))
          (if (fixnum? tmp.37)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.37)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.63 tmp.9)
        (let ((vector-init-loop.11 (closure-ref c.63 0)))
          (let ((tmp.10 (unsafe-make-vector tmp.9)))
            (call
             L.vector-init-loop.11.7
             vector-init-loop.11
             tmp.9
             0
             tmp.10)))))
    (define L.vector-init-loop.11.7
      (lambda (c.62 len.12 i.14 vec.13)
        (let ((vector-init-loop.11 (closure-ref c.62 0)))
          (if (eq? len.12 i.14)
            vec.13
            (begin
              (unsafe-vector-set! vec.13 i.14 0)
              (call
               L.vector-init-loop.11.7
               vector-init-loop.11
               len.12
               (unsafe-fx+ i.14 1)
               vec.13))))))
    (cletrec
     ((vector-init-loop.11
       (make-closure L.vector-init-loop.11.7 3 vector-init-loop.11))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.11))
      (make-vector.61 (make-closure L.make-vector.61.9 1 make-init-vector.1))
      (fun/error8470.4 (make-closure L.fun/error8470.4.10 1 fun/error8471.5))
      (fun/error8471.5 (make-closure L.fun/error8471.5.11 0)))
     (call
      L.fun/error8470.4.10
      fun/error8470.4
      (let ((fixnum0.8 250)
            (vector1.7 (call L.make-vector.61.9 make-vector.61 8)))
        136)))))
(check-by-interp
 '(module
    (define L.fun/void8475.5.8 (lambda (c.61 oprand0.7) (let () (void))))
    (define L.fun/ascii-char8474.4.7 (lambda (c.60 oprand0.6) (let () #\V)))
    (cletrec
     ((fun/ascii-char8474.4 (make-closure L.fun/ascii-char8474.4.7 1))
      (fun/void8475.5 (make-closure L.fun/void8475.5.8 1)))
     (call
      L.fun/ascii-char8474.4.7
      fun/ascii-char8474.4
      (call L.fun/void8475.5.8 fun/void8475.5 #t)))))
(check-by-interp
 '(module
    (define L.fun/empty8478.4.7 (lambda (c.60 oprand0.5) (let () empty)))
    (cletrec
     ((fun/empty8478.4 (make-closure L.fun/empty8478.4.7 1)))
     (call
      L.fun/empty8478.4.7
      fun/empty8478.4
      (let ((error0.7 (error 53)) (error1.6 (error 196))) empty)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8481.4.7 (lambda (c.58 oprand0.5) (let () #\\)))
    (cletrec
     ((fun/ascii-char8481.4 (make-closure L.fun/ascii-char8481.4.7 1)))
     (call
      L.fun/ascii-char8481.4.7
      fun/ascii-char8481.4
      (if #f empty empty)))))
(check-by-interp
 '(module
    (define L.fun/pair8496.5.11
      (lambda (c.70)
        (let ((cons.63 (closure-ref c.70 0)))
          (call L.cons.63.9 cons.63 33 428))))
    (define L.fun/pair8495.4.10
      (lambda (c.69 oprand0.7 oprand1.6)
        (let ((fun/pair8496.5 (closure-ref c.69 0)))
          (call L.fun/pair8496.5.11 fun/pair8496.5))))
    (define L.cons.63.9
      (lambda (c.68 tmp.58 tmp.59) (let () (cons tmp.58 tmp.59))))
    (define L.*.64.8
      (lambda (c.67 tmp.25 tmp.26)
        (let ()
          (if (fixnum? tmp.26)
            (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
            (error 1)))))
    (define L.ascii-char?.65.7
      (lambda (c.66 tmp.52) (let () (ascii-char? tmp.52))))
    (cletrec
     ((ascii-char?.65 (make-closure L.ascii-char?.65.7 1))
      (*.64 (make-closure L.*.64.8 2))
      (cons.63 (make-closure L.cons.63.9 2))
      (fun/pair8495.4 (make-closure L.fun/pair8495.4.10 2 fun/pair8496.5))
      (fun/pair8496.5 (make-closure L.fun/pair8496.5.11 0 cons.63)))
     (call
      L.fun/pair8495.4.10
      fun/pair8495.4
      (call
       L.*.64.8
       *.64
       (call L.*.64.8 *.64 120 100)
       (let ((ascii-char0.10 #\M) (boolean1.9 #t) (boolean2.8 #t)) 196))
      (call L.ascii-char?.65.7 ascii-char?.65 (if #t #\^ (void)))))))
(check-by-interp
 '(module
    (define L.fun/void8506.9.16
      (lambda (c.84 oprand0.17 oprand1.16)
        (let ((fun/void8507.7 (closure-ref c.84 0)))
          (call L.fun/void8507.7.14 fun/void8507.7))))
    (define L.fun/error8510.8.15
      (lambda (c.83 oprand0.15 oprand1.14) (let () (error 153))))
    (define L.fun/void8507.7.14 (lambda (c.82) (let () (void))))
    (define L.fun/empty8511.6.13
      (lambda (c.81 oprand0.13 oprand1.12) (let () empty)))
    (define L.fun/pair8509.5.12
      (lambda (c.80)
        (let ((cons.73 (closure-ref c.80 0)))
          (call L.cons.73.10 cons.73 105 344))))
    (define L.fun/pair8508.4.11
      (lambda (c.79 oprand0.11 oprand1.10)
        (let ((fun/pair8509.5 (closure-ref c.79 0)))
          (call L.fun/pair8509.5.12 fun/pair8509.5))))
    (define L.cons.73.10
      (lambda (c.78 tmp.68 tmp.69) (let () (cons tmp.68 tmp.69))))
    (define L.make-vector.74.9
      (lambda (c.77 tmp.49)
        (let ((make-init-vector.1 (closure-ref c.77 0)))
          (if (fixnum? tmp.49)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.49)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.76 tmp.21)
        (let ((vector-init-loop.23 (closure-ref c.76 0)))
          (let ((tmp.22 (unsafe-make-vector tmp.21)))
            (call
             L.vector-init-loop.23.7
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.7
      (lambda (c.75 len.24 i.26 vec.25)
        (let ((vector-init-loop.23 (closure-ref c.75 0)))
          (if (eq? len.24 i.26)
            vec.25
            (begin
              (unsafe-vector-set! vec.25 i.26 0)
              (call
               L.vector-init-loop.23.7
               vector-init-loop.23
               len.24
               (unsafe-fx+ i.26 1)
               vec.25))))))
    (cletrec
     ((vector-init-loop.23
       (make-closure L.vector-init-loop.23.7 3 vector-init-loop.23))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.23))
      (make-vector.74 (make-closure L.make-vector.74.9 1 make-init-vector.1))
      (cons.73 (make-closure L.cons.73.10 2))
      (fun/pair8508.4 (make-closure L.fun/pair8508.4.11 2 fun/pair8509.5))
      (fun/pair8509.5 (make-closure L.fun/pair8509.5.12 0 cons.73))
      (fun/empty8511.6 (make-closure L.fun/empty8511.6.13 2))
      (fun/void8507.7 (make-closure L.fun/void8507.7.14 0))
      (fun/error8510.8 (make-closure L.fun/error8510.8.15 2))
      (fun/void8506.9 (make-closure L.fun/void8506.9.16 2 fun/void8507.7)))
     (call
      L.fun/void8506.9.16
      fun/void8506.9
      (let ((ascii-char0.20 #\j)
            (vector1.19 (call L.make-vector.74.9 make-vector.74 8))
            (boolean2.18 #t))
        (error 147))
      (call
       L.fun/pair8508.4.11
       fun/pair8508.4
       (call L.fun/error8510.8.15 fun/error8510.8 (void) (void))
       (call L.fun/empty8511.6.13 fun/empty8511.6 (error 142) #\C))))))
(check-by-interp
 '(module
    (define L.fun/vector8536.6.14
      (lambda (c.72)
        (let ((make-vector.62 (closure-ref c.72 0)))
          (call L.make-vector.62.11 make-vector.62 8))))
    (define L.fun/empty8537.5.13 (lambda (c.71) (let () empty)))
    (define L.fun/empty8535.4.12 (lambda (c.70) (let () empty)))
    (define L.make-vector.62.11
      (lambda (c.69 tmp.38)
        (let ((make-init-vector.1 (closure-ref c.69 0)))
          (if (fixnum? tmp.38)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.38)
            (error 8)))))
    (define L.make-init-vector.1.10
      (lambda (c.68 tmp.10)
        (let ((vector-init-loop.12 (closure-ref c.68 0)))
          (let ((tmp.11 (unsafe-make-vector tmp.10)))
            (call
             L.vector-init-loop.12.9
             vector-init-loop.12
             tmp.10
             0
             tmp.11)))))
    (define L.vector-init-loop.12.9
      (lambda (c.67 len.13 i.15 vec.14)
        (let ((vector-init-loop.12 (closure-ref c.67 0)))
          (if (eq? len.13 i.15)
            vec.14
            (begin
              (unsafe-vector-set! vec.14 i.15 0)
              (call
               L.vector-init-loop.12.9
               vector-init-loop.12
               len.13
               (unsafe-fx+ i.15 1)
               vec.14))))))
    (define L.cons.63.8
      (lambda (c.66 tmp.57 tmp.58) (let () (cons tmp.57 tmp.58))))
    (define L.boolean?.64.7 (lambda (c.65 tmp.48) (let () (boolean? tmp.48))))
    (cletrec
     ((boolean?.64 (make-closure L.boolean?.64.7 1))
      (cons.63 (make-closure L.cons.63.8 2))
      (vector-init-loop.12
       (make-closure L.vector-init-loop.12.9 3 vector-init-loop.12))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.10 1 vector-init-loop.12))
      (make-vector.62 (make-closure L.make-vector.62.11 1 make-init-vector.1))
      (fun/empty8535.4 (make-closure L.fun/empty8535.4.12 0))
      (fun/empty8537.5 (make-closure L.fun/empty8537.5.13 0))
      (fun/vector8536.6 (make-closure L.fun/vector8536.6.14 0 make-vector.62)))
     (let ((empty0.9 (call L.fun/empty8535.4.12 fun/empty8535.4))
           (boolean1.8
            (call
             L.boolean?.64.7
             boolean?.64
             (call L.cons.63.8 cons.63 80 414)))
           (vector2.7 (call L.fun/vector8536.6.14 fun/vector8536.6)))
       (call L.fun/empty8537.5.13 fun/empty8537.5)))))
(check-by-interp
 '(module
    (define L.fun/empty8564.8.12
      (lambda (c.73 oprand0.14 oprand1.13) (let () empty)))
    (define L.fun/ascii-char8563.7.11 (lambda (c.72) (let () #\s)))
    (define L.fun/pair8560.6.10
      (lambda (c.71 oprand0.12 oprand1.11)
        (let ((fun/pair8561.4 (closure-ref c.71 0)))
          (call L.fun/pair8561.4.8 fun/pair8561.4))))
    (define L.fun/ascii-char8562.5.9
      (lambda (c.70 oprand0.10 oprand1.9)
        (let ((fun/ascii-char8563.7 (closure-ref c.70 0)))
          (call L.fun/ascii-char8563.7.11 fun/ascii-char8563.7))))
    (define L.fun/pair8561.4.8
      (lambda (c.69)
        (let ((cons.67 (closure-ref c.69 0)))
          (call L.cons.67.7 cons.67 251 399))))
    (define L.cons.67.7
      (lambda (c.68 tmp.62 tmp.63) (let () (cons tmp.62 tmp.63))))
    (cletrec
     ((cons.67 (make-closure L.cons.67.7 2))
      (fun/pair8561.4 (make-closure L.fun/pair8561.4.8 0 cons.67))
      (fun/ascii-char8562.5
       (make-closure L.fun/ascii-char8562.5.9 2 fun/ascii-char8563.7))
      (fun/pair8560.6 (make-closure L.fun/pair8560.6.10 2 fun/pair8561.4))
      (fun/ascii-char8563.7 (make-closure L.fun/ascii-char8563.7.11 0))
      (fun/empty8564.8 (make-closure L.fun/empty8564.8.12 2)))
     (call
      L.fun/pair8560.6.10
      fun/pair8560.6
      (if #f 61 74)
      (call
       L.fun/ascii-char8562.5.9
       fun/ascii-char8562.5
       (call L.fun/empty8564.8.12 fun/empty8564.8 empty #\r)
       (if #t #t #f))))))
(check-by-interp
 '(module
    (define L.fun/void8611.7.16 (lambda (c.77) (let () (void))))
    (define L.fun/ascii-char8614.6.15 (lambda (c.76) (let () #\S)))
    (define L.fun/vector8612.5.14
      (lambda (c.75)
        (let ((make-vector.64 (closure-ref c.75 0)))
          (call L.make-vector.64.12 make-vector.64 8))))
    (define L.fun/ascii-char8613.4.13 (lambda (c.74) (let () #\B)))
    (define L.make-vector.64.12
      (lambda (c.73 tmp.40)
        (let ((make-init-vector.1 (closure-ref c.73 0)))
          (if (fixnum? tmp.40)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.40)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.72 tmp.12)
        (let ((vector-init-loop.14 (closure-ref c.72 0)))
          (let ((tmp.13 (unsafe-make-vector tmp.12)))
            (call
             L.vector-init-loop.14.10
             vector-init-loop.14
             tmp.12
             0
             tmp.13)))))
    (define L.vector-init-loop.14.10
      (lambda (c.71 len.15 i.17 vec.16)
        (let ((vector-init-loop.14 (closure-ref c.71 0)))
          (if (eq? len.15 i.17)
            vec.16
            (begin
              (unsafe-vector-set! vec.16 i.17 0)
              (call
               L.vector-init-loop.14.10
               vector-init-loop.14
               len.15
               (unsafe-fx+ i.17 1)
               vec.16))))))
    (define L.*.65.9
      (lambda (c.70 tmp.26 tmp.27)
        (let ()
          (if (fixnum? tmp.27)
            (if (fixnum? tmp.26) (unsafe-fx* tmp.26 tmp.27) (error 1))
            (error 1)))))
    (define L.-.66.8
      (lambda (c.69 tmp.30 tmp.31)
        (let ()
          (if (fixnum? tmp.31)
            (if (fixnum? tmp.30) (unsafe-fx- tmp.30 tmp.31) (error 3))
            (error 3)))))
    (define L.+.67.7
      (lambda (c.68 tmp.28 tmp.29)
        (let ()
          (if (fixnum? tmp.29)
            (if (fixnum? tmp.28) (unsafe-fx+ tmp.28 tmp.29) (error 2))
            (error 2)))))
    (cletrec
     ((|+.67| (make-closure L.+.67.7 2))
      (|-.66| (make-closure L.-.66.8 2))
      (*.65 (make-closure L.*.65.9 2))
      (vector-init-loop.14
       (make-closure L.vector-init-loop.14.10 3 vector-init-loop.14))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.14))
      (make-vector.64 (make-closure L.make-vector.64.12 1 make-init-vector.1))
      (fun/ascii-char8613.4 (make-closure L.fun/ascii-char8613.4.13 0))
      (fun/vector8612.5 (make-closure L.fun/vector8612.5.14 0 make-vector.64))
      (fun/ascii-char8614.6 (make-closure L.fun/ascii-char8614.6.15 0))
      (fun/void8611.7 (make-closure L.fun/void8611.7.16 0)))
     (let ((fixnum0.11
            (call
             L.+.67.7
             |+.67|
             (call L.*.65.9 *.65 77 201)
             (call L.-.66.8 |-.66| 53 40)))
           (void1.10 (call L.fun/void8611.7.16 fun/void8611.7))
           (vector2.9 (call L.fun/vector8612.5.14 fun/vector8612.5))
           (ascii-char3.8
            (call L.fun/ascii-char8613.4.13 fun/ascii-char8613.4)))
       (call L.fun/ascii-char8614.6.15 fun/ascii-char8614.6)))))
(check-by-interp
 '(module
    (define L.fun/void8618.6.15 (lambda (c.75) (let () (void))))
    (define L.fun/vector8619.5.14
      (lambda (c.74)
        (let ((make-vector.63 (closure-ref c.74 0)))
          (call L.make-vector.63.12 make-vector.63 8))))
    (define L.fun/ascii-char8617.4.13 (lambda (c.73) (let () #\X)))
    (define L.make-vector.63.12
      (lambda (c.72 tmp.39)
        (let ((make-init-vector.1 (closure-ref c.72 0)))
          (if (fixnum? tmp.39)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.39)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.71 tmp.11)
        (let ((vector-init-loop.13 (closure-ref c.71 0)))
          (let ((tmp.12 (unsafe-make-vector tmp.11)))
            (call
             L.vector-init-loop.13.10
             vector-init-loop.13
             tmp.11
             0
             tmp.12)))))
    (define L.vector-init-loop.13.10
      (lambda (c.70 len.14 i.16 vec.15)
        (let ((vector-init-loop.13 (closure-ref c.70 0)))
          (if (eq? len.14 i.16)
            vec.15
            (begin
              (unsafe-vector-set! vec.15 i.16 0)
              (call
               L.vector-init-loop.13.10
               vector-init-loop.13
               len.14
               (unsafe-fx+ i.16 1)
               vec.15))))))
    (define L.+.64.9
      (lambda (c.69 tmp.27 tmp.28)
        (let ()
          (if (fixnum? tmp.28)
            (if (fixnum? tmp.27) (unsafe-fx+ tmp.27 tmp.28) (error 2))
            (error 2)))))
    (define L.*.65.8
      (lambda (c.68 tmp.25 tmp.26)
        (let ()
          (if (fixnum? tmp.26)
            (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
            (error 1)))))
    (define L.-.66.7
      (lambda (c.67 tmp.29 tmp.30)
        (let ()
          (if (fixnum? tmp.30)
            (if (fixnum? tmp.29) (unsafe-fx- tmp.29 tmp.30) (error 3))
            (error 3)))))
    (cletrec
     ((|-.66| (make-closure L.-.66.7 2))
      (*.65 (make-closure L.*.65.8 2))
      (|+.64| (make-closure L.+.64.9 2))
      (vector-init-loop.13
       (make-closure L.vector-init-loop.13.10 3 vector-init-loop.13))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.13))
      (make-vector.63 (make-closure L.make-vector.63.12 1 make-init-vector.1))
      (fun/ascii-char8617.4 (make-closure L.fun/ascii-char8617.4.13 0))
      (fun/vector8619.5 (make-closure L.fun/vector8619.5.14 0 make-vector.63))
      (fun/void8618.6 (make-closure L.fun/void8618.6.15 0)))
     (let ((fixnum0.10
            (call
             L.*.65.8
             *.65
             (call L.+.64.9 |+.64| 178 122)
             (call L.+.64.9 |+.64| 57 87)))
           (ascii-char1.9
            (call L.fun/ascii-char8617.4.13 fun/ascii-char8617.4))
           (fixnum2.8
            (call
             L.+.64.9
             |+.64|
             (call L.-.66.7 |-.66| 27 2)
             (call L.*.65.8 *.65 32 157)))
           (void3.7 (call L.fun/void8618.6.15 fun/void8618.6)))
       (call L.fun/vector8619.5.14 fun/vector8619.5)))))
(check-by-interp
 '(module
    (define L.lam.68.17
      (lambda (c.79)
        (let ((fun/any8773.7 (closure-ref c.79 0))
              (vector?.67 (closure-ref c.79 1)))
          (call
           L.vector?.67.7
           vector?.67
           (call L.fun/any8773.7.15 fun/any8773.7)))))
    (define L.fun/vector8772.8.16
      (lambda (c.78)
        (let ((make-vector.65 (closure-ref c.78 0)))
          (call L.make-vector.65.11 make-vector.65 8))))
    (define L.fun/any8773.7.15 (lambda (c.77) (let () empty)))
    (define L.fun/void8770.6.14 (lambda (c.76) (let () (void))))
    (define L.fun/empty8774.5.13 (lambda (c.75) (let () empty)))
    (define L.fun/any8771.4.12
      (lambda (c.74)
        (let ((make-vector.65 (closure-ref c.74 0)))
          (call L.make-vector.65.11 make-vector.65 8))))
    (define L.make-vector.65.11
      (lambda (c.73 tmp.41)
        (let ((make-init-vector.1 (closure-ref c.73 0)))
          (if (fixnum? tmp.41)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.41)
            (error 8)))))
    (define L.make-init-vector.1.10
      (lambda (c.72 tmp.13)
        (let ((vector-init-loop.15 (closure-ref c.72 0)))
          (let ((tmp.14 (unsafe-make-vector tmp.13)))
            (call
             L.vector-init-loop.15.9
             vector-init-loop.15
             tmp.13
             0
             tmp.14)))))
    (define L.vector-init-loop.15.9
      (lambda (c.71 len.16 i.18 vec.17)
        (let ((vector-init-loop.15 (closure-ref c.71 0)))
          (if (eq? len.16 i.18)
            vec.17
            (begin
              (unsafe-vector-set! vec.17 i.18 0)
              (call
               L.vector-init-loop.15.9
               vector-init-loop.15
               len.16
               (unsafe-fx+ i.18 1)
               vec.17))))))
    (define L.error?.66.8 (lambda (c.70 tmp.55) (let () (error? tmp.55))))
    (define L.vector?.67.7 (lambda (c.69 tmp.57) (let () (vector? tmp.57))))
    (cletrec
     ((vector?.67 (make-closure L.vector?.67.7 1))
      (error?.66 (make-closure L.error?.66.8 1))
      (vector-init-loop.15
       (make-closure L.vector-init-loop.15.9 3 vector-init-loop.15))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.10 1 vector-init-loop.15))
      (make-vector.65 (make-closure L.make-vector.65.11 1 make-init-vector.1))
      (fun/any8771.4 (make-closure L.fun/any8771.4.12 0 make-vector.65))
      (fun/empty8774.5 (make-closure L.fun/empty8774.5.13 0))
      (fun/void8770.6 (make-closure L.fun/void8770.6.14 0))
      (fun/any8773.7 (make-closure L.fun/any8773.7.15 0))
      (fun/vector8772.8 (make-closure L.fun/vector8772.8.16 0 make-vector.65)))
     (let ((void0.12 (call L.fun/void8770.6.14 fun/void8770.6))
           (boolean1.11
            (call
             L.error?.66.8
             error?.66
             (call L.fun/any8771.4.12 fun/any8771.4)))
           (vector2.10 (call L.fun/vector8772.8.16 fun/vector8772.8))
           (procedure3.9
            (cletrec
             ((lam.68 (make-closure L.lam.68.17 0 fun/any8773.7 vector?.67)))
             lam.68)))
       (call L.fun/empty8774.5.13 fun/empty8774.5)))))
(check-by-interp
 '(module
    (define L.lam.77.25
      (lambda (c.96)
        (let ((fun/vector9404.8 (closure-ref c.96 0)))
          (call L.fun/vector9404.8.18 fun/vector9404.8))))
    (define L.lam.76.24
      (lambda (c.95)
        (let ((fun/pair9400.7 (closure-ref c.95 0)))
          (call L.fun/pair9400.7.17 fun/pair9400.7))))
    (define L.fun/ascii-char9402.13.23
      (lambda (c.94)
        (let ((fun/ascii-char9403.6 (closure-ref c.94 0)))
          (call L.fun/ascii-char9403.6.16 fun/ascii-char9403.6))))
    (define L.fun/pair9401.12.22
      (lambda (c.93)
        (let ((cons.72 (closure-ref c.93 0)))
          (call L.cons.72.10 cons.72 242 377))))
    (define L.fun/vector9405.11.21
      (lambda (c.92)
        (let ((make-vector.71 (closure-ref c.92 0)))
          (call L.make-vector.71.13 make-vector.71 8))))
    (define L.fun/empty9406.10.20
      (lambda (c.91)
        (let ((fun/empty9407.5 (closure-ref c.91 0)))
          (call L.fun/empty9407.5.15 fun/empty9407.5))))
    (define L.fun/void9399.9.19 (lambda (c.90) (let () (void))))
    (define L.fun/vector9404.8.18
      (lambda (c.89)
        (let ((fun/vector9405.11 (closure-ref c.89 0)))
          (call L.fun/vector9405.11.21 fun/vector9405.11))))
    (define L.fun/pair9400.7.17
      (lambda (c.88)
        (let ((fun/pair9401.12 (closure-ref c.88 0)))
          (call L.fun/pair9401.12.22 fun/pair9401.12))))
    (define L.fun/ascii-char9403.6.16 (lambda (c.87) (let () #\d)))
    (define L.fun/empty9407.5.15 (lambda (c.86) (let () empty)))
    (define L.fun/void9398.4.14
      (lambda (c.85)
        (let ((fun/void9399.9 (closure-ref c.85 0)))
          (call L.fun/void9399.9.19 fun/void9399.9))))
    (define L.make-vector.71.13
      (lambda (c.84 tmp.47)
        (let ((make-init-vector.1 (closure-ref c.84 0)))
          (if (fixnum? tmp.47)
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.47)
            (error 8)))))
    (define L.make-init-vector.1.12
      (lambda (c.83 tmp.19)
        (let ((vector-init-loop.21 (closure-ref c.83 0)))
          (let ((tmp.20 (unsafe-make-vector tmp.19)))
            (call
             L.vector-init-loop.21.11
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.11
      (lambda (c.82 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (closure-ref c.82 0)))
          (if (eq? len.22 i.24)
            vec.23
            (begin
              (unsafe-vector-set! vec.23 i.24 0)
              (call
               L.vector-init-loop.21.11
               vector-init-loop.21
               len.22
               (unsafe-fx+ i.24 1)
               vec.23))))))
    (define L.cons.72.10
      (lambda (c.81 tmp.66 tmp.67) (let () (cons tmp.66 tmp.67))))
    (define L.*.73.9
      (lambda (c.80 tmp.33 tmp.34)
        (let ()
          (if (fixnum? tmp.34)
            (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
            (error 1)))))
    (define L.-.74.8
      (lambda (c.79 tmp.37 tmp.38)
        (let ()
          (if (fixnum? tmp.38)
            (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
            (error 3)))))
    (define L.+.75.7
      (lambda (c.78 tmp.35 tmp.36)
        (let ()
          (if (fixnum? tmp.36)
            (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
            (error 2)))))
    (cletrec
     ((|+.75| (make-closure L.+.75.7 2))
      (|-.74| (make-closure L.-.74.8 2))
      (*.73 (make-closure L.*.73.9 2))
      (cons.72 (make-closure L.cons.72.10 2))
      (vector-init-loop.21
       (make-closure L.vector-init-loop.21.11 3 vector-init-loop.21))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.12 1 vector-init-loop.21))
      (make-vector.71 (make-closure L.make-vector.71.13 1 make-init-vector.1))
      (fun/void9398.4 (make-closure L.fun/void9398.4.14 0 fun/void9399.9))
      (fun/empty9407.5 (make-closure L.fun/empty9407.5.15 0))
      (fun/ascii-char9403.6 (make-closure L.fun/ascii-char9403.6.16 0))
      (fun/pair9400.7 (make-closure L.fun/pair9400.7.17 0 fun/pair9401.12))
      (fun/vector9404.8
       (make-closure L.fun/vector9404.8.18 0 fun/vector9405.11))
      (fun/void9399.9 (make-closure L.fun/void9399.9.19 0))
      (fun/empty9406.10 (make-closure L.fun/empty9406.10.20 0 fun/empty9407.5))
      (fun/vector9405.11
       (make-closure L.fun/vector9405.11.21 0 make-vector.71))
      (fun/pair9401.12 (make-closure L.fun/pair9401.12.22 0 cons.72))
      (fun/ascii-char9402.13
       (make-closure L.fun/ascii-char9402.13.23 0 fun/ascii-char9403.6)))
     (let ((void0.18 (call L.fun/void9398.4.14 fun/void9398.4))
           (fixnum1.17
            (call
             L.-.74.8
             |-.74|
             (call
              L.*.73.9
              *.73
              (call L.*.73.9 *.73 245 94)
              (call L.-.74.8 |-.74| 94 201))
             (call
              L.+.75.7
              |+.75|
              (call L.-.74.8 |-.74| 225 16)
              (call L.+.75.7 |+.75| 46 174))))
           (procedure2.16
            (cletrec
             ((lam.76 (make-closure L.lam.76.24 0 fun/pair9400.7)))
             lam.76))
           (ascii-char3.15
            (call L.fun/ascii-char9402.13.23 fun/ascii-char9402.13))
           (procedure4.14
            (cletrec
             ((lam.77 (make-closure L.lam.77.25 0 fun/vector9404.8)))
             lam.77)))
       (call L.fun/empty9406.10.20 fun/empty9406.10)))))
(check-by-interp
 '(module
    (define L.fun/pair13318.15.22
      (lambda (c.93)
        (let ((fun/pair13319.9 (closure-ref c.93 0)))
          (call L.fun/pair13319.9.16 fun/pair13319.9))))
    (define L.fun/void13311.14.21 (lambda (c.92) (let () (void))))
    (define L.fun/ascii-char13314.13.20
      (lambda (c.91)
        (let ((fun/ascii-char13315.5 (closure-ref c.91 0)))
          (call L.fun/ascii-char13315.5.12 fun/ascii-char13315.5))))
    (define L.fun/error13309.12.19 (lambda (c.90) (let () (error 248))))
    (define L.fun/empty13317.11.18 (lambda (c.89) (let () empty)))
    (define L.fun/void13310.10.17
      (lambda (c.88)
        (let ((fun/void13311.14 (closure-ref c.88 0)))
          (call L.fun/void13311.14.21 fun/void13311.14))))
    (define L.fun/pair13319.9.16
      (lambda (c.87)
        (let ((cons.74 (closure-ref c.87 0)))
          (call L.cons.74.10 cons.74 243 439))))
    (define L.fun/error13312.8.15
      (lambda (c.86)
        (let ((fun/error13313.6 (closure-ref c.86 0)))
          (call L.fun/error13313.6.13 fun/error13313.6))))
    (define L.fun/error13308.7.14
      (lambda (c.85)
        (let ((fun/error13309.12 (closure-ref c.85 0)))
          (call L.fun/error13309.12.19 fun/error13309.12))))
    (define L.fun/error13313.6.13 (lambda (c.84) (let () (error 61))))
    (define L.fun/ascii-char13315.5.12 (lambda (c.83) (let () #\d)))
    (define L.fun/empty13316.4.11
      (lambda (c.82)
        (let ((fun/empty13317.11 (closure-ref c.82 0)))
          (call L.fun/empty13317.11.18 fun/empty13317.11))))
    (define L.cons.74.10
      (lambda (c.81 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
    (define L.+.75.9
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.76.8
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.-.77.7
      (lambda (c.78 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (cletrec
     ((|-.77| (make-closure L.-.77.7 2))
      (*.76 (make-closure L.*.76.8 2))
      (|+.75| (make-closure L.+.75.9 2))
      (cons.74 (make-closure L.cons.74.10 2))
      (fun/empty13316.4
       (make-closure L.fun/empty13316.4.11 0 fun/empty13317.11))
      (fun/ascii-char13315.5 (make-closure L.fun/ascii-char13315.5.12 0))
      (fun/error13313.6 (make-closure L.fun/error13313.6.13 0))
      (fun/error13308.7
       (make-closure L.fun/error13308.7.14 0 fun/error13309.12))
      (fun/error13312.8
       (make-closure L.fun/error13312.8.15 0 fun/error13313.6))
      (fun/pair13319.9 (make-closure L.fun/pair13319.9.16 0 cons.74))
      (fun/void13310.10
       (make-closure L.fun/void13310.10.17 0 fun/void13311.14))
      (fun/empty13317.11 (make-closure L.fun/empty13317.11.18 0))
      (fun/error13309.12 (make-closure L.fun/error13309.12.19 0))
      (fun/ascii-char13314.13
       (make-closure L.fun/ascii-char13314.13.20 0 fun/ascii-char13315.5))
      (fun/void13311.14 (make-closure L.fun/void13311.14.21 0))
      (fun/pair13318.15
       (make-closure L.fun/pair13318.15.22 0 fun/pair13319.9)))
     (let ((error0.21 (call L.fun/error13308.7.14 fun/error13308.7))
           (void1.20 (call L.fun/void13310.10.17 fun/void13310.10))
           (error2.19 (call L.fun/error13312.8.15 fun/error13312.8))
           (fixnum3.18
            (call
             L.-.77.7
             |-.77|
             (call
              L.-.77.7
              |-.77|
              (call
               L.+.75.9
               |+.75|
               (call L.+.75.9 |+.75| 109 250)
               (call L.*.76.8 *.76 227 148))
              (call
               L.*.76.8
               *.76
               (call L.-.77.7 |-.77| 215 130)
               (call L.*.76.8 *.76 223 30)))
             (call
              L.*.76.8
              *.76
              (call
               L.-.77.7
               |-.77|
               (call L.*.76.8 *.76 247 1)
               (call L.*.76.8 *.76 63 60))
              (call
               L.+.75.9
               |+.75|
               (call L.*.76.8 *.76 208 208)
               (call L.-.77.7 |-.77| 184 128)))))
           (ascii-char4.17
            (call L.fun/ascii-char13314.13.20 fun/ascii-char13314.13))
           (empty5.16 (call L.fun/empty13316.4.11 fun/empty13316.4)))
       (call L.fun/pair13318.15.22 fun/pair13318.15)))))
(check-by-interp
 '(module
    (define L.lam.74.21
      (lambda (c.89)
        (let ((fun/vector13354.8 (closure-ref c.89 0)))
          (call L.fun/vector13354.8.17 fun/vector13354.8))))
    (define L.fun/ascii-char13353.11.20 (lambda (c.88) (let () #\H)))
    (define L.fun/error13359.10.19 (lambda (c.87) (let () (error 4))))
    (define L.fun/vector13356.9.18
      (lambda (c.86)
        (let ((fun/vector13357.5 (closure-ref c.86 0)))
          (call L.fun/vector13357.5.14 fun/vector13357.5))))
    (define L.fun/vector13354.8.17
      (lambda (c.85)
        (let ((fun/vector13355.6 (closure-ref c.85 0)))
          (call L.fun/vector13355.6.15 fun/vector13355.6))))
    (define L.fun/ascii-char13352.7.16
      (lambda (c.84)
        (let ((fun/ascii-char13353.11 (closure-ref c.84 0)))
          (call L.fun/ascii-char13353.11.20 fun/ascii-char13353.11))))
    (define L.fun/vector13355.6.15
      (lambda (c.83)
        (let ((make-vector.70 (closure-ref c.83 0)))
          (call L.make-vector.70.12 make-vector.70 8))))
    (define L.fun/vector13357.5.14
      (lambda (c.82)
        (let ((make-vector.70 (closure-ref c.82 0)))
          (call L.make-vector.70.12 make-vector.70 8))))
    (define L.fun/error13358.4.13
      (lambda (c.81)
        (let ((fun/error13359.10 (closure-ref c.81 0)))
          (call L.fun/error13359.10.19 fun/error13359.10))))
    (define L.make-vector.70.12
      (lambda (c.80 tmp.46)
        (let ((make-init-vector.1 (closure-ref c.80 0)))
          (if (fixnum? tmp.46)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.46)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.79 tmp.18)
        (let ((vector-init-loop.20 (closure-ref c.79 0)))
          (let ((tmp.19 (unsafe-make-vector tmp.18)))
            (call
             L.vector-init-loop.20.10
             vector-init-loop.20
             tmp.18
             0
             tmp.19)))))
    (define L.vector-init-loop.20.10
      (lambda (c.78 len.21 i.23 vec.22)
        (let ((vector-init-loop.20 (closure-ref c.78 0)))
          (if (eq? len.21 i.23)
            vec.22
            (begin
              (unsafe-vector-set! vec.22 i.23 0)
              (call
               L.vector-init-loop.20.10
               vector-init-loop.20
               len.21
               (unsafe-fx+ i.23 1)
               vec.22))))))
    (define L.*.71.9
      (lambda (c.77 tmp.32 tmp.33)
        (let ()
          (if (fixnum? tmp.33)
            (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
            (error 1)))))
    (define L.+.72.8
      (lambda (c.76 tmp.34 tmp.35)
        (let ()
          (if (fixnum? tmp.35)
            (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
            (error 2)))))
    (define L.-.73.7
      (lambda (c.75 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
            (error 3)))))
    (cletrec
     ((|-.73| (make-closure L.-.73.7 2))
      (|+.72| (make-closure L.+.72.8 2))
      (*.71 (make-closure L.*.71.9 2))
      (vector-init-loop.20
       (make-closure L.vector-init-loop.20.10 3 vector-init-loop.20))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.20))
      (make-vector.70 (make-closure L.make-vector.70.12 1 make-init-vector.1))
      (fun/error13358.4
       (make-closure L.fun/error13358.4.13 0 fun/error13359.10))
      (fun/vector13357.5
       (make-closure L.fun/vector13357.5.14 0 make-vector.70))
      (fun/vector13355.6
       (make-closure L.fun/vector13355.6.15 0 make-vector.70))
      (fun/ascii-char13352.7
       (make-closure L.fun/ascii-char13352.7.16 0 fun/ascii-char13353.11))
      (fun/vector13354.8
       (make-closure L.fun/vector13354.8.17 0 fun/vector13355.6))
      (fun/vector13356.9
       (make-closure L.fun/vector13356.9.18 0 fun/vector13357.5))
      (fun/error13359.10 (make-closure L.fun/error13359.10.19 0))
      (fun/ascii-char13353.11 (make-closure L.fun/ascii-char13353.11.20 0)))
     (let ((fixnum0.17
            (call
             L.*.71.9
             *.71
             (call
              L.+.72.8
              |+.72|
              (call
               L.+.72.8
               |+.72|
               (call L.*.71.9 *.71 61 201)
               (call L.*.71.9 *.71 11 18))
              (call
               L.+.72.8
               |+.72|
               (call L.-.73.7 |-.73| 92 27)
               (call L.+.72.8 |+.72| 99 227)))
             (call
              L.+.72.8
              |+.72|
              (call
               L.*.71.9
               *.71
               (call L.-.73.7 |-.73| 78 219)
               (call L.+.72.8 |+.72| 231 79))
              (call
               L.+.72.8
               |+.72|
               (call L.-.73.7 |-.73| 40 93)
               (call L.*.71.9 *.71 114 8)))))
           (ascii-char1.16
            (call L.fun/ascii-char13352.7.16 fun/ascii-char13352.7))
           (procedure2.15
            (cletrec
             ((lam.74 (make-closure L.lam.74.21 0 fun/vector13354.8)))
             lam.74))
           (fixnum3.14
            (call
             L.-.73.7
             |-.73|
             (call
              L.*.71.9
              *.71
              (call
               L.-.73.7
               |-.73|
               (call L.-.73.7 |-.73| 184 187)
               (call L.-.73.7 |-.73| 249 83))
              (call
               L.-.73.7
               |-.73|
               (call L.*.71.9 *.71 248 208)
               (call L.+.72.8 |+.72| 199 131)))
             (call
              L.-.73.7
              |-.73|
              (call
               L.*.71.9
               *.71
               (call L.*.71.9 *.71 16 237)
               (call L.*.71.9 *.71 184 137))
              (call
               L.*.71.9
               *.71
               (call L.-.73.7 |-.73| 76 191)
               (call L.-.73.7 |-.73| 185 90)))))
           (vector4.13 (call L.fun/vector13356.9.18 fun/vector13356.9))
           (error5.12 (call L.fun/error13358.4.13 fun/error13358.4)))
       (if (procedure? procedure2.15)
         (if (eq? (unsafe-procedure-arity procedure2.15) 0)
           (closure-call procedure2.15 procedure2.15)
           (error 42))
         (error 43))))))
(check-by-interp
 '(module
    (define L.fun/empty14584.13.19
      (lambda (c.87)
        (let ((fun/empty14585.11 (closure-ref c.87 0)))
          (call L.fun/empty14585.11.17 fun/empty14585.11))))
    (define L.fun/void14589.12.18 (lambda (c.86) (let () (void))))
    (define L.fun/empty14585.11.17 (lambda (c.85) (let () empty)))
    (define L.fun/ascii-char14587.10.16 (lambda (c.84) (let () #\T)))
    (define L.fun/void14592.9.15
      (lambda (c.83)
        (let ((fun/void14593.4 (closure-ref c.83 0)))
          (call L.fun/void14593.4.10 fun/void14593.4))))
    (define L.fun/void14588.8.14
      (lambda (c.82)
        (let ((fun/void14589.12 (closure-ref c.82 0)))
          (call L.fun/void14589.12.18 fun/void14589.12))))
    (define L.fun/ascii-char14586.7.13
      (lambda (c.81)
        (let ((fun/ascii-char14587.10 (closure-ref c.81 0)))
          (call L.fun/ascii-char14587.10.16 fun/ascii-char14587.10))))
    (define L.fun/void14590.6.12
      (lambda (c.80)
        (let ((fun/void14591.5 (closure-ref c.80 0)))
          (call L.fun/void14591.5.11 fun/void14591.5))))
    (define L.fun/void14591.5.11 (lambda (c.79) (let () (void))))
    (define L.fun/void14593.4.10 (lambda (c.78) (let () (void))))
    (define L.-.72.9
      (lambda (c.77 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
            (error 3)))))
    (define L.+.73.8
      (lambda (c.76 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
            (error 2)))))
    (define L.*.74.7
      (lambda (c.75 tmp.34 tmp.35)
        (let ()
          (if (fixnum? tmp.35)
            (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
            (error 1)))))
    (cletrec
     ((*.74 (make-closure L.*.74.7 2))
      (|+.73| (make-closure L.+.73.8 2))
      (|-.72| (make-closure L.-.72.9 2))
      (fun/void14593.4 (make-closure L.fun/void14593.4.10 0))
      (fun/void14591.5 (make-closure L.fun/void14591.5.11 0))
      (fun/void14590.6 (make-closure L.fun/void14590.6.12 0 fun/void14591.5))
      (fun/ascii-char14586.7
       (make-closure L.fun/ascii-char14586.7.13 0 fun/ascii-char14587.10))
      (fun/void14588.8 (make-closure L.fun/void14588.8.14 0 fun/void14589.12))
      (fun/void14592.9 (make-closure L.fun/void14592.9.15 0 fun/void14593.4))
      (fun/ascii-char14587.10 (make-closure L.fun/ascii-char14587.10.16 0))
      (fun/empty14585.11 (make-closure L.fun/empty14585.11.17 0))
      (fun/void14589.12 (make-closure L.fun/void14589.12.18 0))
      (fun/empty14584.13
       (make-closure L.fun/empty14584.13.19 0 fun/empty14585.11)))
     (let ((empty0.19 (call L.fun/empty14584.13.19 fun/empty14584.13))
           (ascii-char1.18
            (call L.fun/ascii-char14586.7.13 fun/ascii-char14586.7))
           (void2.17 (call L.fun/void14588.8.14 fun/void14588.8))
           (fixnum3.16
            (call
             L.+.73.8
             |+.73|
             (call
              L.+.73.8
              |+.73|
              (call
               L.-.72.9
               |-.72|
               (call L.-.72.9 |-.72| 194 113)
               (call L.-.72.9 |-.72| 185 241))
              (call
               L.*.74.7
               *.74
               (call L.+.73.8 |+.73| 162 91)
               (call L.-.72.9 |-.72| 164 197)))
             (call
              L.+.73.8
              |+.73|
              (call
               L.*.74.7
               *.74
               (call L.-.72.9 |-.72| 249 224)
               (call L.-.72.9 |-.72| 250 187))
              (call
               L.*.74.7
               *.74
               (call L.*.74.7 *.74 214 94)
               (call L.*.74.7 *.74 206 191)))))
           (void4.15 (call L.fun/void14590.6.12 fun/void14590.6))
           (fixnum5.14
            (call
             L.+.73.8
             |+.73|
             (call
              L.-.72.9
              |-.72|
              (call
               L.+.73.8
               |+.73|
               (call L.-.72.9 |-.72| 148 37)
               (call L.*.74.7 *.74 110 11))
              (call
               L.*.74.7
               *.74
               (call L.*.74.7 *.74 5 77)
               (call L.-.72.9 |-.72| 53 223)))
             (call
              L.+.73.8
              |+.73|
              (call
               L.-.72.9
               |-.72|
               (call L.*.74.7 *.74 64 86)
               (call L.-.72.9 |-.72| 202 121))
              (call
               L.*.74.7
               *.74
               (call L.*.74.7 *.74 76 26)
               (call L.*.74.7 *.74 37 229))))))
       (call L.fun/void14592.9.15 fun/void14592.9)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char15136.15.26 (lambda (c.99) (let () #\N)))
    (define L.fun/void15141.14.25
      (lambda (c.98)
        (let ((fun/void15142.8 (closure-ref c.98 0)))
          (call L.fun/void15142.8.19 fun/void15142.8))))
    (define L.fun/empty15139.13.24
      (lambda (c.97)
        (let ((fun/empty15140.4 (closure-ref c.97 0)))
          (call L.fun/empty15140.4.15 fun/empty15140.4))))
    (define L.fun/void15146.12.23 (lambda (c.96) (let () (void))))
    (define L.fun/vector15137.11.22
      (lambda (c.95)
        (let ((fun/vector15138.6 (closure-ref c.95 0)))
          (call L.fun/vector15138.6.17 fun/vector15138.6))))
    (define L.fun/any15143.10.21
      (lambda (c.94)
        (let ((fun/any15144.9 (closure-ref c.94 0)))
          (call L.fun/any15144.9.20 fun/any15144.9))))
    (define L.fun/any15144.9.20
      (lambda (c.93)
        (let ((cons.75 (closure-ref c.93 0)))
          (call L.cons.75.11 cons.75 90 455))))
    (define L.fun/void15142.8.19 (lambda (c.92) (let () (void))))
    (define L.fun/ascii-char15135.7.18
      (lambda (c.91)
        (let ((fun/ascii-char15136.15 (closure-ref c.91 0)))
          (call L.fun/ascii-char15136.15.26 fun/ascii-char15136.15))))
    (define L.fun/vector15138.6.17
      (lambda (c.90)
        (let ((make-vector.74 (closure-ref c.90 0)))
          (call L.make-vector.74.14 make-vector.74 8))))
    (define L.fun/void15145.5.16
      (lambda (c.89)
        (let ((fun/void15146.12 (closure-ref c.89 0)))
          (call L.fun/void15146.12.23 fun/void15146.12))))
    (define L.fun/empty15140.4.15 (lambda (c.88) (let () empty)))
    (define L.make-vector.74.14
      (lambda (c.87 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.87 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.13
      (lambda (c.86 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.86 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.12
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.12
      (lambda (c.85 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.85 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.12
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (define L.cons.75.11
      (lambda (c.84 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
    (define L.-.76.10
      (lambda (c.83 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.+.77.9
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.78.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.empty?.79.7 (lambda (c.80 tmp.61) (let () (empty? tmp.61))))
    (cletrec
     ((empty?.79 (make-closure L.empty?.79.7 1))
      (*.78 (make-closure L.*.78.8 2))
      (|+.77| (make-closure L.+.77.9 2))
      (|-.76| (make-closure L.-.76.10 2))
      (cons.75 (make-closure L.cons.75.11 2))
      (vector-init-loop.24
       (make-closure L.vector-init-loop.24.12 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.13 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.14 1 make-init-vector.1))
      (fun/empty15140.4 (make-closure L.fun/empty15140.4.15 0))
      (fun/void15145.5 (make-closure L.fun/void15145.5.16 0 fun/void15146.12))
      (fun/vector15138.6
       (make-closure L.fun/vector15138.6.17 0 make-vector.74))
      (fun/ascii-char15135.7
       (make-closure L.fun/ascii-char15135.7.18 0 fun/ascii-char15136.15))
      (fun/void15142.8 (make-closure L.fun/void15142.8.19 0))
      (fun/any15144.9 (make-closure L.fun/any15144.9.20 0 cons.75))
      (fun/any15143.10 (make-closure L.fun/any15143.10.21 0 fun/any15144.9))
      (fun/vector15137.11
       (make-closure L.fun/vector15137.11.22 0 fun/vector15138.6))
      (fun/void15146.12 (make-closure L.fun/void15146.12.23 0))
      (fun/empty15139.13
       (make-closure L.fun/empty15139.13.24 0 fun/empty15140.4))
      (fun/void15141.14 (make-closure L.fun/void15141.14.25 0 fun/void15142.8))
      (fun/ascii-char15136.15 (make-closure L.fun/ascii-char15136.15.26 0)))
     (let ((ascii-char0.21
            (call L.fun/ascii-char15135.7.18 fun/ascii-char15135.7))
           (vector1.20 (call L.fun/vector15137.11.22 fun/vector15137.11))
           (empty2.19 (call L.fun/empty15139.13.24 fun/empty15139.13))
           (fixnum3.18
            (call
             L.+.77.9
             |+.77|
             (call
              L.-.76.10
              |-.76|
              (call
               L.+.77.9
               |+.77|
               (call L.-.76.10 |-.76| 172 24)
               (call L.-.76.10 |-.76| 248 201))
              (call
               L.+.77.9
               |+.77|
               (call L.+.77.9 |+.77| 37 230)
               (call L.-.76.10 |-.76| 61 215)))
             (call
              L.-.76.10
              |-.76|
              (call
               L.+.77.9
               |+.77|
               (call L.*.78.8 *.78 171 97)
               (call L.-.76.10 |-.76| 108 8))
              (call
               L.-.76.10
               |-.76|
               (call L.-.76.10 |-.76| 49 73)
               (call L.+.77.9 |+.77| 180 234)))))
           (void4.17 (call L.fun/void15141.14.25 fun/void15141.14))
           (boolean5.16
            (call
             L.empty?.79.7
             empty?.79
             (call L.fun/any15143.10.21 fun/any15143.10))))
       (call L.fun/void15145.5.16 fun/void15145.5)))))
(check-by-interp
 '(module
    (define L.lam.77.24
      (lambda (c.95)
        (let ((fun/empty15764.14 (closure-ref c.95 0)))
          (call L.fun/empty15764.14.20 fun/empty15764.14))))
    (define L.fun/ascii-char15768.17.23
      (lambda (c.94)
        (let ((fun/ascii-char15769.10 (closure-ref c.94 0)))
          (call L.fun/ascii-char15769.10.16 fun/ascii-char15769.10))))
    (define L.fun/ascii-char15777.16.22 (lambda (c.93) (let () #\L)))
    (define L.fun/void15775.15.21 (lambda (c.92) (let () (void))))
    (define L.fun/empty15764.14.20
      (lambda (c.91)
        (let ((fun/empty15765.5 (closure-ref c.91 0)))
          (call L.fun/empty15765.5.11 fun/empty15765.5))))
    (define L.fun/empty15766.13.19
      (lambda (c.90)
        (let ((fun/empty15767.11 (closure-ref c.90 0)))
          (call L.fun/empty15767.11.17 fun/empty15767.11))))
    (define L.fun/ascii-char15776.12.18
      (lambda (c.89)
        (let ((fun/ascii-char15777.16 (closure-ref c.89 0)))
          (call L.fun/ascii-char15777.16.22 fun/ascii-char15777.16))))
    (define L.fun/empty15767.11.17 (lambda (c.88) (let () empty)))
    (define L.fun/ascii-char15769.10.16 (lambda (c.87) (let () #\_)))
    (define L.fun/vector15771.9.15
      (lambda (c.86)
        (let ((make-vector.76 (closure-ref c.86 0)))
          (call L.make-vector.76.9 make-vector.76 8))))
    (define L.fun/error15772.8.14
      (lambda (c.85)
        (let ((fun/error15773.7 (closure-ref c.85 0)))
          (call L.fun/error15773.7.13 fun/error15773.7))))
    (define L.fun/error15773.7.13 (lambda (c.84) (let () (error 17))))
    (define L.fun/void15774.6.12
      (lambda (c.83)
        (let ((fun/void15775.15 (closure-ref c.83 0)))
          (call L.fun/void15775.15.21 fun/void15775.15))))
    (define L.fun/empty15765.5.11 (lambda (c.82) (let () empty)))
    (define L.fun/vector15770.4.10
      (lambda (c.81)
        (let ((fun/vector15771.9 (closure-ref c.81 0)))
          (call L.fun/vector15771.9.15 fun/vector15771.9))))
    (define L.make-vector.76.9
      (lambda (c.80 tmp.52)
        (let ((make-init-vector.1 (closure-ref c.80 0)))
          (if (fixnum? tmp.52)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.52)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.79 tmp.24)
        (let ((vector-init-loop.26 (closure-ref c.79 0)))
          (let ((tmp.25 (unsafe-make-vector tmp.24)))
            (call
             L.vector-init-loop.26.7
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.7
      (lambda (c.78 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (closure-ref c.78 0)))
          (if (eq? len.27 i.29)
            vec.28
            (begin
              (unsafe-vector-set! vec.28 i.29 0)
              (call
               L.vector-init-loop.26.7
               vector-init-loop.26
               len.27
               (unsafe-fx+ i.29 1)
               vec.28))))))
    (cletrec
     ((vector-init-loop.26
       (make-closure L.vector-init-loop.26.7 3 vector-init-loop.26))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.26))
      (make-vector.76 (make-closure L.make-vector.76.9 1 make-init-vector.1))
      (fun/vector15770.4
       (make-closure L.fun/vector15770.4.10 0 fun/vector15771.9))
      (fun/empty15765.5 (make-closure L.fun/empty15765.5.11 0))
      (fun/void15774.6 (make-closure L.fun/void15774.6.12 0 fun/void15775.15))
      (fun/error15773.7 (make-closure L.fun/error15773.7.13 0))
      (fun/error15772.8
       (make-closure L.fun/error15772.8.14 0 fun/error15773.7))
      (fun/vector15771.9
       (make-closure L.fun/vector15771.9.15 0 make-vector.76))
      (fun/ascii-char15769.10 (make-closure L.fun/ascii-char15769.10.16 0))
      (fun/empty15767.11 (make-closure L.fun/empty15767.11.17 0))
      (fun/ascii-char15776.12
       (make-closure L.fun/ascii-char15776.12.18 0 fun/ascii-char15777.16))
      (fun/empty15766.13
       (make-closure L.fun/empty15766.13.19 0 fun/empty15767.11))
      (fun/empty15764.14
       (make-closure L.fun/empty15764.14.20 0 fun/empty15765.5))
      (fun/void15775.15 (make-closure L.fun/void15775.15.21 0))
      (fun/ascii-char15777.16 (make-closure L.fun/ascii-char15777.16.22 0))
      (fun/ascii-char15768.17
       (make-closure L.fun/ascii-char15768.17.23 0 fun/ascii-char15769.10)))
     (let ((procedure0.23
            (cletrec
             ((lam.77 (make-closure L.lam.77.24 0 fun/empty15764.14)))
             lam.77))
           (empty1.22 (call L.fun/empty15766.13.19 fun/empty15766.13))
           (ascii-char2.21
            (call L.fun/ascii-char15768.17.23 fun/ascii-char15768.17))
           (vector3.20 (call L.fun/vector15770.4.10 fun/vector15770.4))
           (error4.19 (call L.fun/error15772.8.14 fun/error15772.8))
           (void5.18 (call L.fun/void15774.6.12 fun/void15774.6)))
       (call L.fun/ascii-char15776.12.18 fun/ascii-char15776.12)))))
(check-by-interp
 '(module
    (define L.lam.79.26
      (lambda (c.99)
        (let ((fun/pair21851.7 (closure-ref c.99 0)))
          (call L.fun/pair21851.7.17 fun/pair21851.7))))
    (define L.fun/void21847.15.25
      (lambda (c.98)
        (let ((fun/void21848.4 (closure-ref c.98 0)))
          (call L.fun/void21848.4.14 fun/void21848.4))))
    (define L.fun/ascii-char21853.14.24
      (lambda (c.97)
        (let ((fun/ascii-char21854.5 (closure-ref c.97 0)))
          (call L.fun/ascii-char21854.5.15 fun/ascii-char21854.5))))
    (define L.fun/error21845.13.23
      (lambda (c.96)
        (let ((fun/error21846.10 (closure-ref c.96 0)))
          (call L.fun/error21846.10.20 fun/error21846.10))))
    (define L.fun/pair21852.12.22
      (lambda (c.95)
        (let ((cons.75 (closure-ref c.95 0)))
          (call L.cons.75.10 cons.75 78 279))))
    (define L.fun/vector21855.11.21
      (lambda (c.94)
        (let ((fun/vector21856.6 (closure-ref c.94 0)))
          (call L.fun/vector21856.6.16 fun/vector21856.6))))
    (define L.fun/error21846.10.20 (lambda (c.93) (let () (error 231))))
    (define L.fun/vector21850.9.19
      (lambda (c.92)
        (let ((make-vector.74 (closure-ref c.92 0)))
          (call L.make-vector.74.13 make-vector.74 8))))
    (define L.fun/vector21849.8.18
      (lambda (c.91)
        (let ((fun/vector21850.9 (closure-ref c.91 0)))
          (call L.fun/vector21850.9.19 fun/vector21850.9))))
    (define L.fun/pair21851.7.17
      (lambda (c.90)
        (let ((fun/pair21852.12 (closure-ref c.90 0)))
          (call L.fun/pair21852.12.22 fun/pair21852.12))))
    (define L.fun/vector21856.6.16
      (lambda (c.89)
        (let ((make-vector.74 (closure-ref c.89 0)))
          (call L.make-vector.74.13 make-vector.74 8))))
    (define L.fun/ascii-char21854.5.15 (lambda (c.88) (let () #\h)))
    (define L.fun/void21848.4.14 (lambda (c.87) (let () (void))))
    (define L.make-vector.74.13
      (lambda (c.86 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.86 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.12
      (lambda (c.85 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.85 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.11
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.11
      (lambda (c.84 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.84 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.11
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (define L.cons.75.10
      (lambda (c.83 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
    (define L.-.76.9
      (lambda (c.82 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.*.77.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.+.78.7
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (cletrec
     ((|+.78| (make-closure L.+.78.7 2))
      (*.77 (make-closure L.*.77.8 2))
      (|-.76| (make-closure L.-.76.9 2))
      (cons.75 (make-closure L.cons.75.10 2))
      (vector-init-loop.24
       (make-closure L.vector-init-loop.24.11 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.12 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.13 1 make-init-vector.1))
      (fun/void21848.4 (make-closure L.fun/void21848.4.14 0))
      (fun/ascii-char21854.5 (make-closure L.fun/ascii-char21854.5.15 0))
      (fun/vector21856.6
       (make-closure L.fun/vector21856.6.16 0 make-vector.74))
      (fun/pair21851.7 (make-closure L.fun/pair21851.7.17 0 fun/pair21852.12))
      (fun/vector21849.8
       (make-closure L.fun/vector21849.8.18 0 fun/vector21850.9))
      (fun/vector21850.9
       (make-closure L.fun/vector21850.9.19 0 make-vector.74))
      (fun/error21846.10 (make-closure L.fun/error21846.10.20 0))
      (fun/vector21855.11
       (make-closure L.fun/vector21855.11.21 0 fun/vector21856.6))
      (fun/pair21852.12 (make-closure L.fun/pair21852.12.22 0 cons.75))
      (fun/error21845.13
       (make-closure L.fun/error21845.13.23 0 fun/error21846.10))
      (fun/ascii-char21853.14
       (make-closure L.fun/ascii-char21853.14.24 0 fun/ascii-char21854.5))
      (fun/void21847.15
       (make-closure L.fun/void21847.15.25 0 fun/void21848.4)))
     (let ((error0.21 (call L.fun/error21845.13.23 fun/error21845.13))
           (void1.20 (call L.fun/void21847.15.25 fun/void21847.15))
           (vector2.19 (call L.fun/vector21849.8.18 fun/vector21849.8))
           (procedure3.18
            (cletrec
             ((lam.79 (make-closure L.lam.79.26 0 fun/pair21851.7)))
             lam.79))
           (ascii-char4.17
            (call L.fun/ascii-char21853.14.24 fun/ascii-char21853.14))
           (fixnum5.16
            (call
             L.*.77.8
             *.77
             (call
              L.*.77.8
              *.77
              (call
               L.*.77.8
               *.77
               (call L.-.76.9 |-.76| 82 66)
               (call L.-.76.9 |-.76| 146 83))
              (call
               L.+.78.7
               |+.78|
               (call L.+.78.7 |+.78| 80 86)
               (call L.-.76.9 |-.76| 83 43)))
             (call
              L.*.77.8
              *.77
              (call
               L.-.76.9
               |-.76|
               (call L.*.77.8 *.77 176 39)
               (call L.-.76.9 |-.76| 237 12))
              (call
               L.-.76.9
               |-.76|
               (call L.*.77.8 *.77 137 222)
               (call L.-.76.9 |-.76| 128 107))))))
       (call L.fun/vector21855.11.21 fun/vector21855.11)))))
(check-by-interp
 '(module
    (define L.lam.75.22
      (lambda (c.91)
        (let ((fun/vector10024.14 (closure-ref c.91 0)))
          (call L.fun/vector10024.14.20 fun/vector10024.14))))
    (define L.fun/void10032.15.21
      (lambda (c.90)
        (let ((fun/void10033.5 (closure-ref c.90 0)))
          (call L.fun/void10033.5.11 fun/void10033.5))))
    (define L.fun/vector10024.14.20
      (lambda (c.89)
        (let ((fun/vector10025.12 (closure-ref c.89 0)))
          (call L.fun/vector10025.12.18 fun/vector10025.12))))
    (define L.fun/empty10022.13.19
      (lambda (c.88)
        (let ((fun/empty10023.7 (closure-ref c.88 0)))
          (call L.fun/empty10023.7.13 fun/empty10023.7))))
    (define L.fun/vector10025.12.18
      (lambda (c.87)
        (let ((make-vector.74 (closure-ref c.87 0)))
          (call L.make-vector.74.9 make-vector.74 8))))
    (define L.fun/empty10027.11.17 (lambda (c.86) (let () empty)))
    (define L.fun/void10028.10.16
      (lambda (c.85)
        (let ((fun/void10029.8 (closure-ref c.85 0)))
          (call L.fun/void10029.8.14 fun/void10029.8))))
    (define L.fun/vector10031.9.15
      (lambda (c.84)
        (let ((make-vector.74 (closure-ref c.84 0)))
          (call L.make-vector.74.9 make-vector.74 8))))
    (define L.fun/void10029.8.14 (lambda (c.83) (let () (void))))
    (define L.fun/empty10023.7.13 (lambda (c.82) (let () empty)))
    (define L.fun/vector10030.6.12
      (lambda (c.81)
        (let ((fun/vector10031.9 (closure-ref c.81 0)))
          (call L.fun/vector10031.9.15 fun/vector10031.9))))
    (define L.fun/void10033.5.11 (lambda (c.80) (let () (void))))
    (define L.fun/empty10026.4.10
      (lambda (c.79)
        (let ((fun/empty10027.11 (closure-ref c.79 0)))
          (call L.fun/empty10027.11.17 fun/empty10027.11))))
    (define L.make-vector.74.9
      (lambda (c.78 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.78 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.77 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.77 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.7
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.7
      (lambda (c.76 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.76 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.7
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (cletrec
     ((vector-init-loop.24
       (make-closure L.vector-init-loop.24.7 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.9 1 make-init-vector.1))
      (fun/empty10026.4
       (make-closure L.fun/empty10026.4.10 0 fun/empty10027.11))
      (fun/void10033.5 (make-closure L.fun/void10033.5.11 0))
      (fun/vector10030.6
       (make-closure L.fun/vector10030.6.12 0 fun/vector10031.9))
      (fun/empty10023.7 (make-closure L.fun/empty10023.7.13 0))
      (fun/void10029.8 (make-closure L.fun/void10029.8.14 0))
      (fun/vector10031.9
       (make-closure L.fun/vector10031.9.15 0 make-vector.74))
      (fun/void10028.10 (make-closure L.fun/void10028.10.16 0 fun/void10029.8))
      (fun/empty10027.11 (make-closure L.fun/empty10027.11.17 0))
      (fun/vector10025.12
       (make-closure L.fun/vector10025.12.18 0 make-vector.74))
      (fun/empty10022.13
       (make-closure L.fun/empty10022.13.19 0 fun/empty10023.7))
      (fun/vector10024.14
       (make-closure L.fun/vector10024.14.20 0 fun/vector10025.12))
      (fun/void10032.15
       (make-closure L.fun/void10032.15.21 0 fun/void10033.5)))
     (let ((empty0.21 (call L.fun/empty10022.13.19 fun/empty10022.13))
           (procedure1.20
            (cletrec
             ((lam.75 (make-closure L.lam.75.22 0 fun/vector10024.14)))
             lam.75))
           (empty2.19 (call L.fun/empty10026.4.10 fun/empty10026.4))
           (void3.18 (call L.fun/void10028.10.16 fun/void10028.10))
           (vector4.17 (call L.fun/vector10030.6.12 fun/vector10030.6))
           (void5.16 (call L.fun/void10032.15.21 fun/void10032.15)))
       (if (procedure? procedure1.20)
         (if (eq? (unsafe-procedure-arity procedure1.20) 0)
           (closure-call procedure1.20 procedure1.20)
           (error 42))
         (error 43))))))
(check-by-interp
 '(module
    (define L.lam.78.23
      (lambda (c.95)
        (let ((fun/error12088.11 (closure-ref c.95 0)))
          (call L.fun/error12088.11.18 fun/error12088.11))))
    (define L.fun/void12098.15.22
      (lambda (c.94)
        (let ((fun/void12099.10 (closure-ref c.94 0)))
          (call L.fun/void12099.10.17 fun/void12099.10))))
    (define L.fun/error12094.14.21
      (lambda (c.93)
        (let ((fun/error12095.6 (closure-ref c.93 0)))
          (call L.fun/error12095.6.13 fun/error12095.6))))
    (define L.fun/error12089.13.20 (lambda (c.92) (let () (error 114))))
    (define L.fun/empty12097.12.19 (lambda (c.91) (let () empty)))
    (define L.fun/error12088.11.18
      (lambda (c.90)
        (let ((fun/error12089.13 (closure-ref c.90 0)))
          (call L.fun/error12089.13.20 fun/error12089.13))))
    (define L.fun/void12099.10.17 (lambda (c.89) (let () (void))))
    (define L.fun/any12093.9.16 (lambda (c.88) (let () (void))))
    (define L.fun/empty12091.8.15 (lambda (c.87) (let () empty)))
    (define L.fun/empty12096.7.14
      (lambda (c.86)
        (let ((fun/empty12097.12 (closure-ref c.86 0)))
          (call L.fun/empty12097.12.19 fun/empty12097.12))))
    (define L.fun/error12095.6.13 (lambda (c.85) (let () (error 45))))
    (define L.fun/empty12090.5.12
      (lambda (c.84)
        (let ((fun/empty12091.8 (closure-ref c.84 0)))
          (call L.fun/empty12091.8.15 fun/empty12091.8))))
    (define L.fun/any12092.4.11
      (lambda (c.83)
        (let ((fun/any12093.9 (closure-ref c.83 0)))
          (call L.fun/any12093.9.16 fun/any12093.9))))
    (define L.-.74.10
      (lambda (c.82 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.+.75.9
      (lambda (c.81 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.76.8
      (lambda (c.80 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.fixnum?.77.7 (lambda (c.79 tmp.59) (let () (fixnum? tmp.59))))
    (cletrec
     ((fixnum?.77 (make-closure L.fixnum?.77.7 1))
      (*.76 (make-closure L.*.76.8 2))
      (|+.75| (make-closure L.+.75.9 2))
      (|-.74| (make-closure L.-.74.10 2))
      (fun/any12092.4 (make-closure L.fun/any12092.4.11 0 fun/any12093.9))
      (fun/empty12090.5
       (make-closure L.fun/empty12090.5.12 0 fun/empty12091.8))
      (fun/error12095.6 (make-closure L.fun/error12095.6.13 0))
      (fun/empty12096.7
       (make-closure L.fun/empty12096.7.14 0 fun/empty12097.12))
      (fun/empty12091.8 (make-closure L.fun/empty12091.8.15 0))
      (fun/any12093.9 (make-closure L.fun/any12093.9.16 0))
      (fun/void12099.10 (make-closure L.fun/void12099.10.17 0))
      (fun/error12088.11
       (make-closure L.fun/error12088.11.18 0 fun/error12089.13))
      (fun/empty12097.12 (make-closure L.fun/empty12097.12.19 0))
      (fun/error12089.13 (make-closure L.fun/error12089.13.20 0))
      (fun/error12094.14
       (make-closure L.fun/error12094.14.21 0 fun/error12095.6))
      (fun/void12098.15
       (make-closure L.fun/void12098.15.22 0 fun/void12099.10)))
     (let ((procedure0.21
            (cletrec
             ((lam.78 (make-closure L.lam.78.23 0 fun/error12088.11)))
             lam.78))
           (fixnum1.20
            (call
             L.-.74.10
             |-.74|
             (call
              L.*.76.8
              *.76
              (call
               L.-.74.10
               |-.74|
               (call L.-.74.10 |-.74| 54 166)
               (call L.+.75.9 |+.75| 146 119))
              (call
               L.-.74.10
               |-.74|
               (call L.-.74.10 |-.74| 184 21)
               (call L.*.76.8 *.76 8 253)))
             (call
              L.-.74.10
              |-.74|
              (call
               L.+.75.9
               |+.75|
               (call L.-.74.10 |-.74| 209 95)
               (call L.+.75.9 |+.75| 30 246))
              (call
               L.*.76.8
               *.76
               (call L.+.75.9 |+.75| 68 87)
               (call L.-.74.10 |-.74| 191 238)))))
           (empty2.19 (call L.fun/empty12090.5.12 fun/empty12090.5))
           (boolean3.18
            (call
             L.fixnum?.77.7
             fixnum?.77
             (call L.fun/any12092.4.11 fun/any12092.4)))
           (error4.17 (call L.fun/error12094.14.21 fun/error12094.14))
           (empty5.16 (call L.fun/empty12096.7.14 fun/empty12096.7)))
       (call L.fun/void12098.15.22 fun/void12098.15)))))
(check-by-interp
 '(module
    (define L.fun/void8620.8.12 (lambda (c.71) (let () (void))))
    (define L.fun/any8618.7.11 (lambda (c.70) (let () #\M)))
    (define L.fun/ascii-char8619.6.10 (lambda (c.69) (let () #\g)))
    (define L.fun/void8621.5.9 (lambda (c.68) (let () (void))))
    (define L.fun/void8617.4.8 (lambda (c.67) (let () (void))))
    (define L.pair?.65.7 (lambda (c.66 tmp.56) (let () (pair? tmp.56))))
    (cletrec
     ((pair?.65 (make-closure L.pair?.65.7 1))
      (fun/void8617.4 (make-closure L.fun/void8617.4.8 0))
      (fun/void8621.5 (make-closure L.fun/void8621.5.9 0))
      (fun/ascii-char8619.6 (make-closure L.fun/ascii-char8619.6.10 0))
      (fun/any8618.7 (make-closure L.fun/any8618.7.11 0))
      (fun/void8620.8 (make-closure L.fun/void8620.8.12 0)))
     (let ((void0.12 (call L.fun/void8617.4.8 fun/void8617.4))
           (boolean1.11
            (call
             L.pair?.65.7
             pair?.65
             (call L.fun/any8618.7.11 fun/any8618.7)))
           (ascii-char2.10
            (call L.fun/ascii-char8619.6.10 fun/ascii-char8619.6))
           (void3.9 (call L.fun/void8620.8.12 fun/void8620.8)))
       (call L.fun/void8621.5.9 fun/void8621.5)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9293.13.22
      (lambda (c.90)
        (let ((fun/ascii-char9294.12 (closure-ref c.90 0)))
          (call L.fun/ascii-char9294.12.21 fun/ascii-char9294.12))))
    (define L.fun/ascii-char9294.12.21 (lambda (c.89) (let () #\V)))
    (define L.fun/vector9291.11.20
      (lambda (c.88)
        (let ((fun/vector9292.8 (closure-ref c.88 0)))
          (call L.fun/vector9292.8.17 fun/vector9292.8))))
    (define L.fun/empty9295.10.19
      (lambda (c.87)
        (let ((fun/empty9296.9 (closure-ref c.87 0)))
          (call L.fun/empty9296.9.18 fun/empty9296.9))))
    (define L.fun/empty9296.9.18 (lambda (c.86) (let () empty)))
    (define L.fun/vector9292.8.17
      (lambda (c.85)
        (let ((make-vector.71 (closure-ref c.85 0)))
          (call L.make-vector.71.12 make-vector.71 8))))
    (define L.fun/error9288.7.16 (lambda (c.84) (let () (error 238))))
    (define L.fun/vector9290.6.15
      (lambda (c.83)
        (let ((make-vector.71 (closure-ref c.83 0)))
          (call L.make-vector.71.12 make-vector.71 8))))
    (define L.fun/error9287.5.14
      (lambda (c.82)
        (let ((fun/error9288.7 (closure-ref c.82 0)))
          (call L.fun/error9288.7.16 fun/error9288.7))))
    (define L.fun/vector9289.4.13
      (lambda (c.81)
        (let ((fun/vector9290.6 (closure-ref c.81 0)))
          (call L.fun/vector9290.6.15 fun/vector9290.6))))
    (define L.make-vector.71.12
      (lambda (c.80 tmp.47)
        (let ((make-init-vector.1 (closure-ref c.80 0)))
          (if (fixnum? tmp.47)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.47)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.79 tmp.19)
        (let ((vector-init-loop.21 (closure-ref c.79 0)))
          (let ((tmp.20 (unsafe-make-vector tmp.19)))
            (call
             L.vector-init-loop.21.10
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.10
      (lambda (c.78 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (closure-ref c.78 0)))
          (if (eq? len.22 i.24)
            vec.23
            (begin
              (unsafe-vector-set! vec.23 i.24 0)
              (call
               L.vector-init-loop.21.10
               vector-init-loop.21
               len.22
               (unsafe-fx+ i.24 1)
               vec.23))))))
    (define L.-.72.9
      (lambda (c.77 tmp.37 tmp.38)
        (let ()
          (if (fixnum? tmp.38)
            (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
            (error 3)))))
    (define L.*.73.8
      (lambda (c.76 tmp.33 tmp.34)
        (let ()
          (if (fixnum? tmp.34)
            (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
            (error 1)))))
    (define L.+.74.7
      (lambda (c.75 tmp.35 tmp.36)
        (let ()
          (if (fixnum? tmp.36)
            (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
            (error 2)))))
    (cletrec
     ((|+.74| (make-closure L.+.74.7 2))
      (*.73 (make-closure L.*.73.8 2))
      (|-.72| (make-closure L.-.72.9 2))
      (vector-init-loop.21
       (make-closure L.vector-init-loop.21.10 3 vector-init-loop.21))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.21))
      (make-vector.71 (make-closure L.make-vector.71.12 1 make-init-vector.1))
      (fun/vector9289.4
       (make-closure L.fun/vector9289.4.13 0 fun/vector9290.6))
      (fun/error9287.5 (make-closure L.fun/error9287.5.14 0 fun/error9288.7))
      (fun/vector9290.6 (make-closure L.fun/vector9290.6.15 0 make-vector.71))
      (fun/error9288.7 (make-closure L.fun/error9288.7.16 0))
      (fun/vector9292.8 (make-closure L.fun/vector9292.8.17 0 make-vector.71))
      (fun/empty9296.9 (make-closure L.fun/empty9296.9.18 0))
      (fun/empty9295.10 (make-closure L.fun/empty9295.10.19 0 fun/empty9296.9))
      (fun/vector9291.11
       (make-closure L.fun/vector9291.11.20 0 fun/vector9292.8))
      (fun/ascii-char9294.12 (make-closure L.fun/ascii-char9294.12.21 0))
      (fun/ascii-char9293.13
       (make-closure L.fun/ascii-char9293.13.22 0 fun/ascii-char9294.12)))
     (let ((error0.18 (call L.fun/error9287.5.14 fun/error9287.5))
           (fixnum1.17
            (call
             L.*.73.8
             *.73
             (call
              L.+.74.7
              |+.74|
              (call L.-.72.9 |-.72| 10 182)
              (call L.*.73.8 *.73 226 247))
             (call
              L.*.73.8
              *.73
              (call L.+.74.7 |+.74| 35 137)
              (call L.+.74.7 |+.74| 166 53))))
           (vector2.16 (call L.fun/vector9289.4.13 fun/vector9289.4))
           (vector3.15 (call L.fun/vector9291.11.20 fun/vector9291.11))
           (ascii-char4.14
            (call L.fun/ascii-char9293.13.22 fun/ascii-char9293.13)))
       (call L.fun/empty9295.10.19 fun/empty9295.10)))))
(check-by-interp
 '(module
    (define L.fun/empty9343.14.18 (lambda (c.84) (let () empty)))
    (define L.fun/ascii-char9346.13.17
      (lambda (c.83)
        (let ((fun/ascii-char9347.12 (closure-ref c.83 0)))
          (call L.fun/ascii-char9347.12.16 fun/ascii-char9347.12))))
    (define L.fun/ascii-char9347.12.16 (lambda (c.82) (let () #\g)))
    (define L.fun/void9338.11.15 (lambda (c.81) (let () (void))))
    (define L.fun/void9344.10.14
      (lambda (c.80)
        (let ((fun/void9345.7 (closure-ref c.80 0)))
          (call L.fun/void9345.7.11 fun/void9345.7))))
    (define L.fun/ascii-char9341.9.13 (lambda (c.79) (let () #\X)))
    (define L.fun/empty9342.8.12
      (lambda (c.78)
        (let ((fun/empty9343.14 (closure-ref c.78 0)))
          (call L.fun/empty9343.14.18 fun/empty9343.14))))
    (define L.fun/void9345.7.11 (lambda (c.77) (let () (void))))
    (define L.fun/ascii-char9340.6.10
      (lambda (c.76)
        (let ((fun/ascii-char9341.9 (closure-ref c.76 0)))
          (call L.fun/ascii-char9341.9.13 fun/ascii-char9341.9))))
    (define L.fun/any9339.5.9 (lambda (c.75) (let () 1)))
    (define L.fun/void9337.4.8
      (lambda (c.74)
        (let ((fun/void9338.11 (closure-ref c.74 0)))
          (call L.fun/void9338.11.15 fun/void9338.11))))
    (define L.vector?.72.7 (lambda (c.73 tmp.64) (let () (vector? tmp.64))))
    (cletrec
     ((vector?.72 (make-closure L.vector?.72.7 1))
      (fun/void9337.4 (make-closure L.fun/void9337.4.8 0 fun/void9338.11))
      (fun/any9339.5 (make-closure L.fun/any9339.5.9 0))
      (fun/ascii-char9340.6
       (make-closure L.fun/ascii-char9340.6.10 0 fun/ascii-char9341.9))
      (fun/void9345.7 (make-closure L.fun/void9345.7.11 0))
      (fun/empty9342.8 (make-closure L.fun/empty9342.8.12 0 fun/empty9343.14))
      (fun/ascii-char9341.9 (make-closure L.fun/ascii-char9341.9.13 0))
      (fun/void9344.10 (make-closure L.fun/void9344.10.14 0 fun/void9345.7))
      (fun/void9338.11 (make-closure L.fun/void9338.11.15 0))
      (fun/ascii-char9347.12 (make-closure L.fun/ascii-char9347.12.16 0))
      (fun/ascii-char9346.13
       (make-closure L.fun/ascii-char9346.13.17 0 fun/ascii-char9347.12))
      (fun/empty9343.14 (make-closure L.fun/empty9343.14.18 0)))
     (let ((void0.19 (call L.fun/void9337.4.8 fun/void9337.4))
           (boolean1.18
            (call
             L.vector?.72.7
             vector?.72
             (call L.fun/any9339.5.9 fun/any9339.5)))
           (ascii-char2.17
            (call L.fun/ascii-char9340.6.10 fun/ascii-char9340.6))
           (empty3.16 (call L.fun/empty9342.8.12 fun/empty9342.8))
           (void4.15 (call L.fun/void9344.10.14 fun/void9344.10)))
       (call L.fun/ascii-char9346.13.17 fun/ascii-char9346.13)))))
(check-by-interp
 '(module
    (define L.lam.74.22
      (lambda (c.90)
        (let ((fun/any10243.13 (closure-ref c.90 0))
              (vector?.73 (closure-ref c.90 1)))
          (call
           L.vector?.73.7
           vector?.73
           (call L.fun/any10243.13.21 fun/any10243.13)))))
    (define L.fun/any10243.13.21 (lambda (c.89) (let () #t)))
    (define L.fun/any10242.12.20 (lambda (c.88) (let () (error 110))))
    (define L.fun/error10244.11.19
      (lambda (c.87)
        (let ((fun/error10245.9 (closure-ref c.87 0)))
          (call L.fun/error10245.9.17 fun/error10245.9))))
    (define L.fun/empty10249.10.18 (lambda (c.86) (let () empty)))
    (define L.fun/error10245.9.17 (lambda (c.85) (let () (error 53))))
    (define L.fun/empty10248.8.16
      (lambda (c.84)
        (let ((fun/empty10249.10 (closure-ref c.84 0)))
          (call L.fun/empty10249.10.18 fun/empty10249.10))))
    (define L.fun/empty10246.7.15
      (lambda (c.83)
        (let ((fun/empty10247.4 (closure-ref c.83 0)))
          (call L.fun/empty10247.4.12 fun/empty10247.4))))
    (define L.fun/vector10250.6.14
      (lambda (c.82)
        (let ((fun/vector10251.5 (closure-ref c.82 0)))
          (call L.fun/vector10251.5.13 fun/vector10251.5))))
    (define L.fun/vector10251.5.13
      (lambda (c.81)
        (let ((make-vector.71 (closure-ref c.81 0)))
          (call L.make-vector.71.11 make-vector.71 8))))
    (define L.fun/empty10247.4.12 (lambda (c.80) (let () empty)))
    (define L.make-vector.71.11
      (lambda (c.79 tmp.47)
        (let ((make-init-vector.1 (closure-ref c.79 0)))
          (if (fixnum? tmp.47)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.47)
            (error 8)))))
    (define L.make-init-vector.1.10
      (lambda (c.78 tmp.19)
        (let ((vector-init-loop.21 (closure-ref c.78 0)))
          (let ((tmp.20 (unsafe-make-vector tmp.19)))
            (call
             L.vector-init-loop.21.9
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.9
      (lambda (c.77 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (closure-ref c.77 0)))
          (if (eq? len.22 i.24)
            vec.23
            (begin
              (unsafe-vector-set! vec.23 i.24 0)
              (call
               L.vector-init-loop.21.9
               vector-init-loop.21
               len.22
               (unsafe-fx+ i.24 1)
               vec.23))))))
    (define L.void?.72.8 (lambda (c.76 tmp.59) (let () (void? tmp.59))))
    (define L.vector?.73.7 (lambda (c.75 tmp.63) (let () (vector? tmp.63))))
    (cletrec
     ((vector?.73 (make-closure L.vector?.73.7 1))
      (void?.72 (make-closure L.void?.72.8 1))
      (vector-init-loop.21
       (make-closure L.vector-init-loop.21.9 3 vector-init-loop.21))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.10 1 vector-init-loop.21))
      (make-vector.71 (make-closure L.make-vector.71.11 1 make-init-vector.1))
      (fun/empty10247.4 (make-closure L.fun/empty10247.4.12 0))
      (fun/vector10251.5
       (make-closure L.fun/vector10251.5.13 0 make-vector.71))
      (fun/vector10250.6
       (make-closure L.fun/vector10250.6.14 0 fun/vector10251.5))
      (fun/empty10246.7
       (make-closure L.fun/empty10246.7.15 0 fun/empty10247.4))
      (fun/empty10248.8
       (make-closure L.fun/empty10248.8.16 0 fun/empty10249.10))
      (fun/error10245.9 (make-closure L.fun/error10245.9.17 0))
      (fun/empty10249.10 (make-closure L.fun/empty10249.10.18 0))
      (fun/error10244.11
       (make-closure L.fun/error10244.11.19 0 fun/error10245.9))
      (fun/any10242.12 (make-closure L.fun/any10242.12.20 0))
      (fun/any10243.13 (make-closure L.fun/any10243.13.21 0)))
     (let ((boolean0.18
            (call
             L.void?.72.8
             void?.72
             (call L.fun/any10242.12.20 fun/any10242.12)))
           (procedure1.17
            (cletrec
             ((lam.74 (make-closure L.lam.74.22 0 fun/any10243.13 vector?.73)))
             lam.74))
           (error2.16 (call L.fun/error10244.11.19 fun/error10244.11))
           (empty3.15 (call L.fun/empty10246.7.15 fun/empty10246.7))
           (empty4.14 (call L.fun/empty10248.8.16 fun/empty10248.8)))
       (call L.fun/vector10250.6.14 fun/vector10250.6)))))
(check-by-interp
 '(module
    (define L.fun/vector10780.15.21
      (lambda (c.88)
        (let ((fun/vector10781.14 (closure-ref c.88 0)))
          (call L.fun/vector10781.14.20 fun/vector10781.14))))
    (define L.fun/vector10781.14.20
      (lambda (c.87)
        (let ((make-vector.73 (closure-ref c.87 0)))
          (call L.make-vector.73.9 make-vector.73 8))))
    (define L.fun/ascii-char10779.13.19 (lambda (c.86) (let () #\c)))
    (define L.fun/ascii-char10778.12.18
      (lambda (c.85)
        (let ((fun/ascii-char10779.13 (closure-ref c.85 0)))
          (call L.fun/ascii-char10779.13.19 fun/ascii-char10779.13))))
    (define L.fun/void10774.11.17
      (lambda (c.84)
        (let ((fun/void10775.8 (closure-ref c.84 0)))
          (call L.fun/void10775.8.14 fun/void10775.8))))
    (define L.fun/void10771.10.16 (lambda (c.83) (let () (void))))
    (define L.fun/void10773.9.15 (lambda (c.82) (let () (void))))
    (define L.fun/void10775.8.14 (lambda (c.81) (let () (void))))
    (define L.fun/void10772.7.13
      (lambda (c.80)
        (let ((fun/void10773.9 (closure-ref c.80 0)))
          (call L.fun/void10773.9.15 fun/void10773.9))))
    (define L.fun/void10776.6.12
      (lambda (c.79)
        (let ((fun/void10777.5 (closure-ref c.79 0)))
          (call L.fun/void10777.5.11 fun/void10777.5))))
    (define L.fun/void10777.5.11 (lambda (c.78) (let () (void))))
    (define L.fun/void10770.4.10
      (lambda (c.77)
        (let ((fun/void10771.10 (closure-ref c.77 0)))
          (call L.fun/void10771.10.16 fun/void10771.10))))
    (define L.make-vector.73.9
      (lambda (c.76 tmp.49)
        (let ((make-init-vector.1 (closure-ref c.76 0)))
          (if (fixnum? tmp.49)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.49)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.75 tmp.21)
        (let ((vector-init-loop.23 (closure-ref c.75 0)))
          (let ((tmp.22 (unsafe-make-vector tmp.21)))
            (call
             L.vector-init-loop.23.7
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.7
      (lambda (c.74 len.24 i.26 vec.25)
        (let ((vector-init-loop.23 (closure-ref c.74 0)))
          (if (eq? len.24 i.26)
            vec.25
            (begin
              (unsafe-vector-set! vec.25 i.26 0)
              (call
               L.vector-init-loop.23.7
               vector-init-loop.23
               len.24
               (unsafe-fx+ i.26 1)
               vec.25))))))
    (cletrec
     ((vector-init-loop.23
       (make-closure L.vector-init-loop.23.7 3 vector-init-loop.23))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.23))
      (make-vector.73 (make-closure L.make-vector.73.9 1 make-init-vector.1))
      (fun/void10770.4 (make-closure L.fun/void10770.4.10 0 fun/void10771.10))
      (fun/void10777.5 (make-closure L.fun/void10777.5.11 0))
      (fun/void10776.6 (make-closure L.fun/void10776.6.12 0 fun/void10777.5))
      (fun/void10772.7 (make-closure L.fun/void10772.7.13 0 fun/void10773.9))
      (fun/void10775.8 (make-closure L.fun/void10775.8.14 0))
      (fun/void10773.9 (make-closure L.fun/void10773.9.15 0))
      (fun/void10771.10 (make-closure L.fun/void10771.10.16 0))
      (fun/void10774.11 (make-closure L.fun/void10774.11.17 0 fun/void10775.8))
      (fun/ascii-char10778.12
       (make-closure L.fun/ascii-char10778.12.18 0 fun/ascii-char10779.13))
      (fun/ascii-char10779.13 (make-closure L.fun/ascii-char10779.13.19 0))
      (fun/vector10781.14
       (make-closure L.fun/vector10781.14.20 0 make-vector.73))
      (fun/vector10780.15
       (make-closure L.fun/vector10780.15.21 0 fun/vector10781.14)))
     (let ((void0.20 (call L.fun/void10770.4.10 fun/void10770.4))
           (void1.19 (call L.fun/void10772.7.13 fun/void10772.7))
           (void2.18 (call L.fun/void10774.11.17 fun/void10774.11))
           (void3.17 (call L.fun/void10776.6.12 fun/void10776.6))
           (ascii-char4.16
            (call L.fun/ascii-char10778.12.18 fun/ascii-char10778.12)))
       (call L.fun/vector10780.15.21 fun/vector10780.15)))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((fun/error11008.12 (closure-ref c.93 0)))
          (call L.fun/error11008.12.18 fun/error11008.12))))
    (define L.fun/ascii-char11012.15.21
      (lambda (c.92)
        (let ((fun/ascii-char11013.14 (closure-ref c.92 0)))
          (call L.fun/ascii-char11013.14.20 fun/ascii-char11013.14))))
    (define L.fun/ascii-char11013.14.20 (lambda (c.91) (let () #\k)))
    (define L.fun/void11015.13.19 (lambda (c.90) (let () (void))))
    (define L.fun/error11008.12.18
      (lambda (c.89)
        (let ((fun/error11009.10 (closure-ref c.89 0)))
          (call L.fun/error11009.10.16 fun/error11009.10))))
    (define L.fun/void11014.11.17
      (lambda (c.88)
        (let ((fun/void11015.13 (closure-ref c.88 0)))
          (call L.fun/void11015.13.19 fun/void11015.13))))
    (define L.fun/error11009.10.16 (lambda (c.87) (let () (error 242))))
    (define L.fun/empty11016.9.15
      (lambda (c.86)
        (let ((fun/empty11017.7 (closure-ref c.86 0)))
          (call L.fun/empty11017.7.13 fun/empty11017.7))))
    (define L.fun/void11011.8.14 (lambda (c.85) (let () (void))))
    (define L.fun/empty11017.7.13 (lambda (c.84) (let () empty)))
    (define L.fun/void11007.6.12 (lambda (c.83) (let () (void))))
    (define L.fun/void11010.5.11
      (lambda (c.82)
        (let ((fun/void11011.8 (closure-ref c.82 0)))
          (call L.fun/void11011.8.14 fun/void11011.8))))
    (define L.fun/void11006.4.10
      (lambda (c.81)
        (let ((fun/void11007.6 (closure-ref c.81 0)))
          (call L.fun/void11007.6.12 fun/void11007.6))))
    (define L.-.74.9
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.+.75.8
      (lambda (c.79 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.76.7
      (lambda (c.78 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (cletrec
     ((*.76 (make-closure L.*.76.7 2))
      (|+.75| (make-closure L.+.75.8 2))
      (|-.74| (make-closure L.-.74.9 2))
      (fun/void11006.4 (make-closure L.fun/void11006.4.10 0 fun/void11007.6))
      (fun/void11010.5 (make-closure L.fun/void11010.5.11 0 fun/void11011.8))
      (fun/void11007.6 (make-closure L.fun/void11007.6.12 0))
      (fun/empty11017.7 (make-closure L.fun/empty11017.7.13 0))
      (fun/void11011.8 (make-closure L.fun/void11011.8.14 0))
      (fun/empty11016.9
       (make-closure L.fun/empty11016.9.15 0 fun/empty11017.7))
      (fun/error11009.10 (make-closure L.fun/error11009.10.16 0))
      (fun/void11014.11
       (make-closure L.fun/void11014.11.17 0 fun/void11015.13))
      (fun/error11008.12
       (make-closure L.fun/error11008.12.18 0 fun/error11009.10))
      (fun/void11015.13 (make-closure L.fun/void11015.13.19 0))
      (fun/ascii-char11013.14 (make-closure L.fun/ascii-char11013.14.20 0))
      (fun/ascii-char11012.15
       (make-closure L.fun/ascii-char11012.15.21 0 fun/ascii-char11013.14)))
     (let ((fixnum0.21
            (call
             L.+.75.8
             |+.75|
             (call
              L.-.74.9
              |-.74|
              (call
               L.-.74.9
               |-.74|
               (call L.-.74.9 |-.74| 169 4)
               (call L.+.75.8 |+.75| 213 92))
              (call
               L.-.74.9
               |-.74|
               (call L.*.76.7 *.76 180 13)
               (call L.*.76.7 *.76 208 214)))
             (call
              L.+.75.8
              |+.75|
              (call
               L.-.74.9
               |-.74|
               (call L.*.76.7 *.76 0 191)
               (call L.+.75.8 |+.75| 206 116))
              (call
               L.*.76.7
               *.76
               (call L.-.74.9 |-.74| 199 135)
               (call L.-.74.9 |-.74| 16 95)))))
           (void1.20 (call L.fun/void11006.4.10 fun/void11006.4))
           (procedure2.19
            (cletrec
             ((lam.77 (make-closure L.lam.77.22 0 fun/error11008.12)))
             lam.77))
           (void3.18 (call L.fun/void11010.5.11 fun/void11010.5))
           (ascii-char4.17
            (call L.fun/ascii-char11012.15.21 fun/ascii-char11012.15))
           (void5.16 (call L.fun/void11014.11.17 fun/void11014.11)))
       (call L.fun/empty11016.9.15 fun/empty11016.9)))))
(check-by-interp
 '(module
    (define L.lam.75.20
      (lambda (c.89)
        (let ((|-.72| (closure-ref c.89 0))
              (|+.74| (closure-ref c.89 1))
              (*.73 (closure-ref c.89 2)))
          (call
           L.*.73.8
           *.73
           (call
            L.+.74.7
            |+.74|
            (call
             L.*.73.8
             *.73
             (call L.-.72.9 |-.72| 150 41)
             (call L.-.72.9 |-.72| 173 100))
            (call
             L.+.74.7
             |+.74|
             (call L.+.74.7 |+.74| 213 92)
             (call L.+.74.7 |+.74| 41 60)))
           (call
            L.*.73.8
            *.73
            (call
             L.+.74.7
             |+.74|
             (call L.+.74.7 |+.74| 2 4)
             (call L.+.74.7 |+.74| 78 239))
            (call
             L.-.72.9
             |-.72|
             (call L.*.73.8 *.73 228 169)
             (call L.+.74.7 |+.74| 198 43)))))))
    (define L.fun/ascii-char11875.13.19
      (lambda (c.88)
        (let ((fun/ascii-char11876.6 (closure-ref c.88 0)))
          (call L.fun/ascii-char11876.6.12 fun/ascii-char11876.6))))
    (define L.fun/void11871.12.18
      (lambda (c.87)
        (let ((fun/void11872.11 (closure-ref c.87 0)))
          (call L.fun/void11872.11.17 fun/void11872.11))))
    (define L.fun/void11872.11.17 (lambda (c.86) (let () (void))))
    (define L.fun/error11877.10.16
      (lambda (c.85)
        (let ((fun/error11878.4 (closure-ref c.85 0)))
          (call L.fun/error11878.4.10 fun/error11878.4))))
    (define L.fun/ascii-char11874.9.15 (lambda (c.84) (let () #\r)))
    (define L.fun/ascii-char11873.8.14
      (lambda (c.83)
        (let ((fun/ascii-char11874.9 (closure-ref c.83 0)))
          (call L.fun/ascii-char11874.9.15 fun/ascii-char11874.9))))
    (define L.fun/error11880.7.13 (lambda (c.82) (let () (error 168))))
    (define L.fun/ascii-char11876.6.12 (lambda (c.81) (let () #\m)))
    (define L.fun/error11879.5.11
      (lambda (c.80)
        (let ((fun/error11880.7 (closure-ref c.80 0)))
          (call L.fun/error11880.7.13 fun/error11880.7))))
    (define L.fun/error11878.4.10 (lambda (c.79) (let () (error 64))))
    (define L.-.72.9
      (lambda (c.78 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
            (error 3)))))
    (define L.*.73.8
      (lambda (c.77 tmp.34 tmp.35)
        (let ()
          (if (fixnum? tmp.35)
            (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
            (error 1)))))
    (define L.+.74.7
      (lambda (c.76 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
            (error 2)))))
    (cletrec
     ((|+.74| (make-closure L.+.74.7 2))
      (*.73 (make-closure L.*.73.8 2))
      (|-.72| (make-closure L.-.72.9 2))
      (fun/error11878.4 (make-closure L.fun/error11878.4.10 0))
      (fun/error11879.5
       (make-closure L.fun/error11879.5.11 0 fun/error11880.7))
      (fun/ascii-char11876.6 (make-closure L.fun/ascii-char11876.6.12 0))
      (fun/error11880.7 (make-closure L.fun/error11880.7.13 0))
      (fun/ascii-char11873.8
       (make-closure L.fun/ascii-char11873.8.14 0 fun/ascii-char11874.9))
      (fun/ascii-char11874.9 (make-closure L.fun/ascii-char11874.9.15 0))
      (fun/error11877.10
       (make-closure L.fun/error11877.10.16 0 fun/error11878.4))
      (fun/void11872.11 (make-closure L.fun/void11872.11.17 0))
      (fun/void11871.12
       (make-closure L.fun/void11871.12.18 0 fun/void11872.11))
      (fun/ascii-char11875.13
       (make-closure L.fun/ascii-char11875.13.19 0 fun/ascii-char11876.6)))
     (let ((procedure0.19
            (cletrec
             ((lam.75 (make-closure L.lam.75.20 0 |-.72| |+.74| *.73)))
             lam.75))
           (void1.18 (call L.fun/void11871.12.18 fun/void11871.12))
           (ascii-char2.17
            (call L.fun/ascii-char11873.8.14 fun/ascii-char11873.8))
           (ascii-char3.16
            (call L.fun/ascii-char11875.13.19 fun/ascii-char11875.13))
           (error4.15 (call L.fun/error11877.10.16 fun/error11877.10))
           (error5.14 (call L.fun/error11879.5.11 fun/error11879.5)))
       (call
        L.*.73.8
        *.73
        (call
         L.-.72.9
         |-.72|
         (call
          L.+.74.7
          |+.74|
          (call L.-.72.9 |-.72| 71 30)
          (if (procedure? procedure0.19)
            (if (eq? (unsafe-procedure-arity procedure0.19) 0)
              (closure-call procedure0.19 procedure0.19)
              (error 42))
            (error 43)))
         (if (procedure? procedure0.19)
           (if (eq? (unsafe-procedure-arity procedure0.19) 0)
             (closure-call procedure0.19 procedure0.19)
             (error 42))
           (error 43)))
        (if (procedure? procedure0.19)
          (if (eq? (unsafe-procedure-arity procedure0.19) 0)
            (closure-call procedure0.19 procedure0.19)
            (error 42))
          (error 43)))))))
(check-by-interp
 '(module
    (define L.fun/empty12694.17.22
      (lambda (c.93)
        (let ((fun/empty12695.15 (closure-ref c.93 0)))
          (call L.fun/empty12695.15.20 fun/empty12695.15))))
    (define L.fun/ascii-char12704.16.21
      (lambda (c.92)
        (let ((fun/ascii-char12705.14 (closure-ref c.92 0)))
          (call L.fun/ascii-char12705.14.19 fun/ascii-char12705.14))))
    (define L.fun/empty12695.15.20 (lambda (c.91) (let () empty)))
    (define L.fun/ascii-char12705.14.19 (lambda (c.90) (let () #\])))
    (define L.fun/empty12693.13.18 (lambda (c.89) (let () empty)))
    (define L.fun/void12700.12.17
      (lambda (c.88)
        (let ((fun/void12701.9 (closure-ref c.88 0)))
          (call L.fun/void12701.9.14 fun/void12701.9))))
    (define L.fun/any12702.11.16
      (lambda (c.87)
        (let ((fun/any12703.6 (closure-ref c.87 0)))
          (call L.fun/any12703.6.11 fun/any12703.6))))
    (define L.fun/error12697.10.15 (lambda (c.86) (let () (error 95))))
    (define L.fun/void12701.9.14 (lambda (c.85) (let () (void))))
    (define L.fun/error12696.8.13
      (lambda (c.84)
        (let ((fun/error12697.10 (closure-ref c.84 0)))
          (call L.fun/error12697.10.15 fun/error12697.10))))
    (define L.fun/empty12692.7.12
      (lambda (c.83)
        (let ((fun/empty12693.13 (closure-ref c.83 0)))
          (call L.fun/empty12693.13.18 fun/empty12693.13))))
    (define L.fun/any12703.6.11
      (lambda (c.82)
        (let ((cons.76 (closure-ref c.82 0)))
          (call L.cons.76.8 cons.76 139 388))))
    (define L.fun/ascii-char12699.5.10 (lambda (c.81) (let () #\[)))
    (define L.fun/ascii-char12698.4.9
      (lambda (c.80)
        (let ((fun/ascii-char12699.5 (closure-ref c.80 0)))
          (call L.fun/ascii-char12699.5.10 fun/ascii-char12699.5))))
    (define L.cons.76.8
      (lambda (c.79 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
    (define L.empty?.77.7 (lambda (c.78 tmp.63) (let () (empty? tmp.63))))
    (cletrec
     ((empty?.77 (make-closure L.empty?.77.7 1))
      (cons.76 (make-closure L.cons.76.8 2))
      (fun/ascii-char12698.4
       (make-closure L.fun/ascii-char12698.4.9 0 fun/ascii-char12699.5))
      (fun/ascii-char12699.5 (make-closure L.fun/ascii-char12699.5.10 0))
      (fun/any12703.6 (make-closure L.fun/any12703.6.11 0 cons.76))
      (fun/empty12692.7
       (make-closure L.fun/empty12692.7.12 0 fun/empty12693.13))
      (fun/error12696.8
       (make-closure L.fun/error12696.8.13 0 fun/error12697.10))
      (fun/void12701.9 (make-closure L.fun/void12701.9.14 0))
      (fun/error12697.10 (make-closure L.fun/error12697.10.15 0))
      (fun/any12702.11 (make-closure L.fun/any12702.11.16 0 fun/any12703.6))
      (fun/void12700.12 (make-closure L.fun/void12700.12.17 0 fun/void12701.9))
      (fun/empty12693.13 (make-closure L.fun/empty12693.13.18 0))
      (fun/ascii-char12705.14 (make-closure L.fun/ascii-char12705.14.19 0))
      (fun/empty12695.15 (make-closure L.fun/empty12695.15.20 0))
      (fun/ascii-char12704.16
       (make-closure L.fun/ascii-char12704.16.21 0 fun/ascii-char12705.14))
      (fun/empty12694.17
       (make-closure L.fun/empty12694.17.22 0 fun/empty12695.15)))
     (let ((empty0.23 (call L.fun/empty12692.7.12 fun/empty12692.7))
           (empty1.22 (call L.fun/empty12694.17.22 fun/empty12694.17))
           (error2.21 (call L.fun/error12696.8.13 fun/error12696.8))
           (ascii-char3.20
            (call L.fun/ascii-char12698.4.9 fun/ascii-char12698.4))
           (void4.19 (call L.fun/void12700.12.17 fun/void12700.12))
           (boolean5.18
            (call
             L.empty?.77.7
             empty?.77
             (call L.fun/any12702.11.16 fun/any12702.11))))
       (call L.fun/ascii-char12704.16.21 fun/ascii-char12704.16)))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((*.75 (closure-ref c.93 0))
              (|+.76| (closure-ref c.93 1))
              (|-.74| (closure-ref c.93 2)))
          (call
           L.-.74.9
           |-.74|
           (call
            L.+.76.7
            |+.76|
            (call
             L.*.75.8
             *.75
             (call L.-.74.9 |-.74| 170 108)
             (call L.*.75.8 *.75 124 91))
            (call
             L.-.74.9
             |-.74|
             (call L.+.76.7 |+.76| 196 124)
             (call L.-.74.9 |-.74| 29 207)))
           (call
            L.*.75.8
            *.75
            (call
             L.+.76.7
             |+.76|
             (call L.-.74.9 |-.74| 74 25)
             (call L.*.75.8 *.75 40 225))
            (call
             L.-.74.9
             |-.74|
             (call L.+.76.7 |+.76| 92 174)
             (call L.*.75.8 *.75 221 197)))))))
    (define L.fun/error12708.15.21
      (lambda (c.92)
        (let ((fun/error12709.10 (closure-ref c.92 0)))
          (call L.fun/error12709.10.16 fun/error12709.10))))
    (define L.fun/ascii-char12711.14.20 (lambda (c.91) (let () #\u)))
    (define L.fun/ascii-char12712.13.19
      (lambda (c.90)
        (let ((fun/ascii-char12713.6 (closure-ref c.90 0)))
          (call L.fun/ascii-char12713.6.12 fun/ascii-char12713.6))))
    (define L.fun/ascii-char12718.12.18
      (lambda (c.89)
        (let ((fun/ascii-char12719.11 (closure-ref c.89 0)))
          (call L.fun/ascii-char12719.11.17 fun/ascii-char12719.11))))
    (define L.fun/ascii-char12719.11.17 (lambda (c.88) (let () #\[)))
    (define L.fun/error12709.10.16 (lambda (c.87) (let () (error 67))))
    (define L.fun/error12716.9.15
      (lambda (c.86)
        (let ((fun/error12717.8 (closure-ref c.86 0)))
          (call L.fun/error12717.8.14 fun/error12717.8))))
    (define L.fun/error12717.8.14 (lambda (c.85) (let () (error 129))))
    (define L.fun/ascii-char12710.7.13
      (lambda (c.84)
        (let ((fun/ascii-char12711.14 (closure-ref c.84 0)))
          (call L.fun/ascii-char12711.14.20 fun/ascii-char12711.14))))
    (define L.fun/ascii-char12713.6.12 (lambda (c.83) (let () #\E)))
    (define L.fun/ascii-char12714.5.11
      (lambda (c.82)
        (let ((fun/ascii-char12715.4 (closure-ref c.82 0)))
          (call L.fun/ascii-char12715.4.10 fun/ascii-char12715.4))))
    (define L.fun/ascii-char12715.4.10 (lambda (c.81) (let () #\i)))
    (define L.-.74.9
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.*.75.8
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.+.76.7
      (lambda (c.78 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (cletrec
     ((|+.76| (make-closure L.+.76.7 2))
      (*.75 (make-closure L.*.75.8 2))
      (|-.74| (make-closure L.-.74.9 2))
      (fun/ascii-char12715.4 (make-closure L.fun/ascii-char12715.4.10 0))
      (fun/ascii-char12714.5
       (make-closure L.fun/ascii-char12714.5.11 0 fun/ascii-char12715.4))
      (fun/ascii-char12713.6 (make-closure L.fun/ascii-char12713.6.12 0))
      (fun/ascii-char12710.7
       (make-closure L.fun/ascii-char12710.7.13 0 fun/ascii-char12711.14))
      (fun/error12717.8 (make-closure L.fun/error12717.8.14 0))
      (fun/error12716.9
       (make-closure L.fun/error12716.9.15 0 fun/error12717.8))
      (fun/error12709.10 (make-closure L.fun/error12709.10.16 0))
      (fun/ascii-char12719.11 (make-closure L.fun/ascii-char12719.11.17 0))
      (fun/ascii-char12718.12
       (make-closure L.fun/ascii-char12718.12.18 0 fun/ascii-char12719.11))
      (fun/ascii-char12712.13
       (make-closure L.fun/ascii-char12712.13.19 0 fun/ascii-char12713.6))
      (fun/ascii-char12711.14 (make-closure L.fun/ascii-char12711.14.20 0))
      (fun/error12708.15
       (make-closure L.fun/error12708.15.21 0 fun/error12709.10)))
     (let ((error0.21 (call L.fun/error12708.15.21 fun/error12708.15))
           (procedure1.20
            (cletrec
             ((lam.77 (make-closure L.lam.77.22 0 *.75 |+.76| |-.74|)))
             lam.77))
           (ascii-char2.19
            (call L.fun/ascii-char12710.7.13 fun/ascii-char12710.7))
           (ascii-char3.18
            (call L.fun/ascii-char12712.13.19 fun/ascii-char12712.13))
           (ascii-char4.17
            (call L.fun/ascii-char12714.5.11 fun/ascii-char12714.5))
           (error5.16 (call L.fun/error12716.9.15 fun/error12716.9)))
       (call L.fun/ascii-char12718.12.18 fun/ascii-char12718.12)))))
(check-by-interp
 '(module
    (define L.fun/error14513.13.19 (lambda (c.87) (let () (error 19))))
    (define L.fun/error14512.12.18
      (lambda (c.86)
        (let ((fun/error14513.13 (closure-ref c.86 0)))
          (call L.fun/error14513.13.19 fun/error14513.13))))
    (define L.fun/error14509.11.17 (lambda (c.85) (let () (error 191))))
    (define L.fun/error14508.10.16
      (lambda (c.84)
        (let ((fun/error14509.11 (closure-ref c.84 0)))
          (call L.fun/error14509.11.17 fun/error14509.11))))
    (define L.fun/ascii-char14517.9.15 (lambda (c.83) (let () #\c)))
    (define L.fun/ascii-char14510.8.14
      (lambda (c.82)
        (let ((fun/ascii-char14511.4 (closure-ref c.82 0)))
          (call L.fun/ascii-char14511.4.10 fun/ascii-char14511.4))))
    (define L.fun/error14515.7.13 (lambda (c.81) (let () (error 218))))
    (define L.fun/error14514.6.12
      (lambda (c.80)
        (let ((fun/error14515.7 (closure-ref c.80 0)))
          (call L.fun/error14515.7.13 fun/error14515.7))))
    (define L.fun/ascii-char14516.5.11
      (lambda (c.79)
        (let ((fun/ascii-char14517.9 (closure-ref c.79 0)))
          (call L.fun/ascii-char14517.9.15 fun/ascii-char14517.9))))
    (define L.fun/ascii-char14511.4.10 (lambda (c.78) (let () #\E)))
    (define L.*.72.9
      (lambda (c.77 tmp.34 tmp.35)
        (let ()
          (if (fixnum? tmp.35)
            (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
            (error 1)))))
    (define L.-.73.8
      (lambda (c.76 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
            (error 3)))))
    (define L.+.74.7
      (lambda (c.75 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
            (error 2)))))
    (cletrec
     ((|+.74| (make-closure L.+.74.7 2))
      (|-.73| (make-closure L.-.73.8 2))
      (*.72 (make-closure L.*.72.9 2))
      (fun/ascii-char14511.4 (make-closure L.fun/ascii-char14511.4.10 0))
      (fun/ascii-char14516.5
       (make-closure L.fun/ascii-char14516.5.11 0 fun/ascii-char14517.9))
      (fun/error14514.6
       (make-closure L.fun/error14514.6.12 0 fun/error14515.7))
      (fun/error14515.7 (make-closure L.fun/error14515.7.13 0))
      (fun/ascii-char14510.8
       (make-closure L.fun/ascii-char14510.8.14 0 fun/ascii-char14511.4))
      (fun/ascii-char14517.9 (make-closure L.fun/ascii-char14517.9.15 0))
      (fun/error14508.10
       (make-closure L.fun/error14508.10.16 0 fun/error14509.11))
      (fun/error14509.11 (make-closure L.fun/error14509.11.17 0))
      (fun/error14512.12
       (make-closure L.fun/error14512.12.18 0 fun/error14513.13))
      (fun/error14513.13 (make-closure L.fun/error14513.13.19 0)))
     (let ((error0.19 (call L.fun/error14508.10.16 fun/error14508.10))
           (fixnum1.18
            (call
             L.+.74.7
             |+.74|
             (call
              L.+.74.7
              |+.74|
              (call
               L.+.74.7
               |+.74|
               (call L.*.72.9 *.72 245 103)
               (call L.-.73.8 |-.73| 14 91))
              (call
               L.*.72.9
               *.72
               (call L.*.72.9 *.72 122 65)
               (call L.*.72.9 *.72 59 49)))
             (call
              L.-.73.8
              |-.73|
              (call
               L.*.72.9
               *.72
               (call L.+.74.7 |+.74| 170 243)
               (call L.+.74.7 |+.74| 227 62))
              (call
               L.-.73.8
               |-.73|
               (call L.*.72.9 *.72 165 152)
               (call L.*.72.9 *.72 34 234)))))
           (fixnum2.17
            (call
             L.-.73.8
             |-.73|
             (call
              L.-.73.8
              |-.73|
              (call
               L.*.72.9
               *.72
               (call L.-.73.8 |-.73| 28 218)
               (call L.+.74.7 |+.74| 219 163))
              (call
               L.*.72.9
               *.72
               (call L.-.73.8 |-.73| 33 43)
               (call L.*.72.9 *.72 234 231)))
             (call
              L.+.74.7
              |+.74|
              (call
               L.-.73.8
               |-.73|
               (call L.-.73.8 |-.73| 62 212)
               (call L.-.73.8 |-.73| 164 217))
              (call
               L.-.73.8
               |-.73|
               (call L.*.72.9 *.72 209 38)
               (call L.-.73.8 |-.73| 224 233)))))
           (ascii-char3.16
            (call L.fun/ascii-char14510.8.14 fun/ascii-char14510.8))
           (error4.15 (call L.fun/error14512.12.18 fun/error14512.12))
           (error5.14 (call L.fun/error14514.6.12 fun/error14514.6)))
       (call L.fun/ascii-char14516.5.11 fun/ascii-char14516.5)))))
(check-by-interp
 '(module
    (define L.lam.74.19
      (lambda (c.87)
        (let ((fun/error14882.7 (closure-ref c.87 0)))
          (call L.fun/error14882.7.10 fun/error14882.7))))
    (define L.fun/empty14877.15.18 (lambda (c.86) (let () empty)))
    (define L.fun/error14878.14.17
      (lambda (c.85)
        (let ((fun/error14879.9 (closure-ref c.85 0)))
          (call L.fun/error14879.9.12 fun/error14879.9))))
    (define L.fun/empty14876.13.16
      (lambda (c.84)
        (let ((fun/empty14877.15 (closure-ref c.84 0)))
          (call L.fun/empty14877.15.18 fun/empty14877.15))))
    (define L.fun/ascii-char14885.12.15 (lambda (c.83) (let () #\b)))
    (define L.fun/ascii-char14884.11.14
      (lambda (c.82)
        (let ((fun/ascii-char14885.12 (closure-ref c.82 0)))
          (call L.fun/ascii-char14885.12.15 fun/ascii-char14885.12))))
    (define L.fun/empty14887.10.13 (lambda (c.81) (let () empty)))
    (define L.fun/error14879.9.12 (lambda (c.80) (let () (error 114))))
    (define L.fun/error14881.8.11 (lambda (c.79) (let () (error 44))))
    (define L.fun/error14882.7.10
      (lambda (c.78)
        (let ((fun/error14883.4 (closure-ref c.78 0)))
          (call L.fun/error14883.4.7 fun/error14883.4))))
    (define L.fun/empty14886.6.9
      (lambda (c.77)
        (let ((fun/empty14887.10 (closure-ref c.77 0)))
          (call L.fun/empty14887.10.13 fun/empty14887.10))))
    (define L.fun/error14880.5.8
      (lambda (c.76)
        (let ((fun/error14881.8 (closure-ref c.76 0)))
          (call L.fun/error14881.8.11 fun/error14881.8))))
    (define L.fun/error14883.4.7 (lambda (c.75) (let () (error 146))))
    (cletrec
     ((fun/error14883.4 (make-closure L.fun/error14883.4.7 0))
      (fun/error14880.5 (make-closure L.fun/error14880.5.8 0 fun/error14881.8))
      (fun/empty14886.6
       (make-closure L.fun/empty14886.6.9 0 fun/empty14887.10))
      (fun/error14882.7
       (make-closure L.fun/error14882.7.10 0 fun/error14883.4))
      (fun/error14881.8 (make-closure L.fun/error14881.8.11 0))
      (fun/error14879.9 (make-closure L.fun/error14879.9.12 0))
      (fun/empty14887.10 (make-closure L.fun/empty14887.10.13 0))
      (fun/ascii-char14884.11
       (make-closure L.fun/ascii-char14884.11.14 0 fun/ascii-char14885.12))
      (fun/ascii-char14885.12 (make-closure L.fun/ascii-char14885.12.15 0))
      (fun/empty14876.13
       (make-closure L.fun/empty14876.13.16 0 fun/empty14877.15))
      (fun/error14878.14
       (make-closure L.fun/error14878.14.17 0 fun/error14879.9))
      (fun/empty14877.15 (make-closure L.fun/empty14877.15.18 0)))
     (let ((empty0.21 (call L.fun/empty14876.13.16 fun/empty14876.13))
           (error1.20 (call L.fun/error14878.14.17 fun/error14878.14))
           (error2.19 (call L.fun/error14880.5.8 fun/error14880.5))
           (procedure3.18
            (cletrec
             ((lam.74 (make-closure L.lam.74.19 0 fun/error14882.7)))
             lam.74))
           (ascii-char4.17
            (call L.fun/ascii-char14884.11.14 fun/ascii-char14884.11))
           (empty5.16 (call L.fun/empty14886.6.9 fun/empty14886.6)))
       (if (procedure? procedure3.18)
         (if (eq? (unsafe-procedure-arity procedure3.18) 0)
           (closure-call procedure3.18 procedure3.18)
           (error 42))
         (error 43))))))
(check-by-interp
 '(module
    (define L.lam.79.26
      (lambda (c.99)
        (let ((fun/any15198.16 (closure-ref c.99 0))
              (ascii-char?.77 (closure-ref c.99 1)))
          (call
           L.ascii-char?.77.7
           ascii-char?.77
           (call L.fun/any15198.16.23 fun/any15198.16)))))
    (define L.lam.78.25
      (lambda (c.98)
        (let ((fun/empty15196.4 (closure-ref c.98 0)))
          (call L.fun/empty15196.4.11 fun/empty15196.4))))
    (define L.fun/empty15205.17.24 (lambda (c.97) (let () empty)))
    (define L.fun/any15198.16.23
      (lambda (c.96)
        (let ((fun/any15199.14 (closure-ref c.96 0)))
          (call L.fun/any15199.14.21 fun/any15199.14))))
    (define L.fun/error15201.15.22 (lambda (c.95) (let () (error 204))))
    (define L.fun/any15199.14.21 (lambda (c.94) (let () (void))))
    (define L.fun/error15200.13.20
      (lambda (c.93)
        (let ((fun/error15201.15 (closure-ref c.93 0)))
          (call L.fun/error15201.15.22 fun/error15201.15))))
    (define L.fun/empty15204.12.19
      (lambda (c.92)
        (let ((fun/empty15205.17 (closure-ref c.92 0)))
          (call L.fun/empty15205.17.24 fun/empty15205.17))))
    (define L.fun/vector15209.11.18
      (lambda (c.91)
        (let ((make-vector.76 (closure-ref c.91 0)))
          (call L.make-vector.76.10 make-vector.76 8))))
    (define L.fun/empty15197.10.17 (lambda (c.90) (let () empty)))
    (define L.fun/ascii-char15203.9.16 (lambda (c.89) (let () #\r)))
    (define L.fun/vector15208.8.15
      (lambda (c.88)
        (let ((fun/vector15209.11 (closure-ref c.88 0)))
          (call L.fun/vector15209.11.18 fun/vector15209.11))))
    (define L.fun/empty15207.7.14 (lambda (c.87) (let () empty)))
    (define L.fun/ascii-char15202.6.13
      (lambda (c.86)
        (let ((fun/ascii-char15203.9 (closure-ref c.86 0)))
          (call L.fun/ascii-char15203.9.16 fun/ascii-char15203.9))))
    (define L.fun/empty15206.5.12
      (lambda (c.85)
        (let ((fun/empty15207.7 (closure-ref c.85 0)))
          (call L.fun/empty15207.7.14 fun/empty15207.7))))
    (define L.fun/empty15196.4.11
      (lambda (c.84)
        (let ((fun/empty15197.10 (closure-ref c.84 0)))
          (call L.fun/empty15197.10.17 fun/empty15197.10))))
    (define L.make-vector.76.10
      (lambda (c.83 tmp.52)
        (let ((make-init-vector.1 (closure-ref c.83 0)))
          (if (fixnum? tmp.52)
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.52)
            (error 8)))))
    (define L.make-init-vector.1.9
      (lambda (c.82 tmp.24)
        (let ((vector-init-loop.26 (closure-ref c.82 0)))
          (let ((tmp.25 (unsafe-make-vector tmp.24)))
            (call
             L.vector-init-loop.26.8
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.8
      (lambda (c.81 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (closure-ref c.81 0)))
          (if (eq? len.27 i.29)
            vec.28
            (begin
              (unsafe-vector-set! vec.28 i.29 0)
              (call
               L.vector-init-loop.26.8
               vector-init-loop.26
               len.27
               (unsafe-fx+ i.29 1)
               vec.28))))))
    (define L.ascii-char?.77.7
      (lambda (c.80 tmp.65) (let () (ascii-char? tmp.65))))
    (cletrec
     ((ascii-char?.77 (make-closure L.ascii-char?.77.7 1))
      (vector-init-loop.26
       (make-closure L.vector-init-loop.26.8 3 vector-init-loop.26))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.9 1 vector-init-loop.26))
      (make-vector.76 (make-closure L.make-vector.76.10 1 make-init-vector.1))
      (fun/empty15196.4
       (make-closure L.fun/empty15196.4.11 0 fun/empty15197.10))
      (fun/empty15206.5
       (make-closure L.fun/empty15206.5.12 0 fun/empty15207.7))
      (fun/ascii-char15202.6
       (make-closure L.fun/ascii-char15202.6.13 0 fun/ascii-char15203.9))
      (fun/empty15207.7 (make-closure L.fun/empty15207.7.14 0))
      (fun/vector15208.8
       (make-closure L.fun/vector15208.8.15 0 fun/vector15209.11))
      (fun/ascii-char15203.9 (make-closure L.fun/ascii-char15203.9.16 0))
      (fun/empty15197.10 (make-closure L.fun/empty15197.10.17 0))
      (fun/vector15209.11
       (make-closure L.fun/vector15209.11.18 0 make-vector.76))
      (fun/empty15204.12
       (make-closure L.fun/empty15204.12.19 0 fun/empty15205.17))
      (fun/error15200.13
       (make-closure L.fun/error15200.13.20 0 fun/error15201.15))
      (fun/any15199.14 (make-closure L.fun/any15199.14.21 0))
      (fun/error15201.15 (make-closure L.fun/error15201.15.22 0))
      (fun/any15198.16 (make-closure L.fun/any15198.16.23 0 fun/any15199.14))
      (fun/empty15205.17 (make-closure L.fun/empty15205.17.24 0)))
     (let ((procedure0.23
            (cletrec
             ((lam.78 (make-closure L.lam.78.25 0 fun/empty15196.4)))
             lam.78))
           (procedure1.22
            (cletrec
             ((lam.79
               (make-closure L.lam.79.26 0 fun/any15198.16 ascii-char?.77)))
             lam.79))
           (error2.21 (call L.fun/error15200.13.20 fun/error15200.13))
           (ascii-char3.20
            (call L.fun/ascii-char15202.6.13 fun/ascii-char15202.6))
           (empty4.19 (call L.fun/empty15204.12.19 fun/empty15204.12))
           (empty5.18 (call L.fun/empty15206.5.12 fun/empty15206.5)))
       (call L.fun/vector15208.8.15 fun/vector15208.8)))))
(check-by-interp
 '(module
    (define L.fun/void17417.17.23 (lambda (c.93) (let () (void))))
    (define L.fun/error17406.16.22
      (lambda (c.92)
        (let ((fun/error17407.14 (closure-ref c.92 0)))
          (call L.fun/error17407.14.20 fun/error17407.14))))
    (define L.fun/error17411.15.21 (lambda (c.91) (let () (error 42))))
    (define L.fun/error17407.14.20 (lambda (c.90) (let () (error 211))))
    (define L.fun/error17412.13.19
      (lambda (c.89)
        (let ((fun/error17413.11 (closure-ref c.89 0)))
          (call L.fun/error17413.11.17 fun/error17413.11))))
    (define L.fun/ascii-char17414.12.18
      (lambda (c.88)
        (let ((fun/ascii-char17415.6 (closure-ref c.88 0)))
          (call L.fun/ascii-char17415.6.12 fun/ascii-char17415.6))))
    (define L.fun/error17413.11.17 (lambda (c.87) (let () (error 54))))
    (define L.fun/void17416.10.16
      (lambda (c.86)
        (let ((fun/void17417.17 (closure-ref c.86 0)))
          (call L.fun/void17417.17.23 fun/void17417.17))))
    (define L.fun/vector17409.9.15
      (lambda (c.85)
        (let ((make-vector.76 (closure-ref c.85 0)))
          (call L.make-vector.76.9 make-vector.76 8))))
    (define L.fun/error17410.8.14
      (lambda (c.84)
        (let ((fun/error17411.15 (closure-ref c.84 0)))
          (call L.fun/error17411.15.21 fun/error17411.15))))
    (define L.fun/vector17419.7.13
      (lambda (c.83)
        (let ((make-vector.76 (closure-ref c.83 0)))
          (call L.make-vector.76.9 make-vector.76 8))))
    (define L.fun/ascii-char17415.6.12 (lambda (c.82) (let () #\e)))
    (define L.fun/vector17418.5.11
      (lambda (c.81)
        (let ((fun/vector17419.7 (closure-ref c.81 0)))
          (call L.fun/vector17419.7.13 fun/vector17419.7))))
    (define L.fun/vector17408.4.10
      (lambda (c.80)
        (let ((fun/vector17409.9 (closure-ref c.80 0)))
          (call L.fun/vector17409.9.15 fun/vector17409.9))))
    (define L.make-vector.76.9
      (lambda (c.79 tmp.52)
        (let ((make-init-vector.1 (closure-ref c.79 0)))
          (if (fixnum? tmp.52)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.52)
            (error 8)))))
    (define L.make-init-vector.1.8
      (lambda (c.78 tmp.24)
        (let ((vector-init-loop.26 (closure-ref c.78 0)))
          (let ((tmp.25 (unsafe-make-vector tmp.24)))
            (call
             L.vector-init-loop.26.7
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.7
      (lambda (c.77 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (closure-ref c.77 0)))
          (if (eq? len.27 i.29)
            vec.28
            (begin
              (unsafe-vector-set! vec.28 i.29 0)
              (call
               L.vector-init-loop.26.7
               vector-init-loop.26
               len.27
               (unsafe-fx+ i.29 1)
               vec.28))))))
    (cletrec
     ((vector-init-loop.26
       (make-closure L.vector-init-loop.26.7 3 vector-init-loop.26))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.8 1 vector-init-loop.26))
      (make-vector.76 (make-closure L.make-vector.76.9 1 make-init-vector.1))
      (fun/vector17408.4
       (make-closure L.fun/vector17408.4.10 0 fun/vector17409.9))
      (fun/vector17418.5
       (make-closure L.fun/vector17418.5.11 0 fun/vector17419.7))
      (fun/ascii-char17415.6 (make-closure L.fun/ascii-char17415.6.12 0))
      (fun/vector17419.7
       (make-closure L.fun/vector17419.7.13 0 make-vector.76))
      (fun/error17410.8
       (make-closure L.fun/error17410.8.14 0 fun/error17411.15))
      (fun/vector17409.9
       (make-closure L.fun/vector17409.9.15 0 make-vector.76))
      (fun/void17416.10
       (make-closure L.fun/void17416.10.16 0 fun/void17417.17))
      (fun/error17413.11 (make-closure L.fun/error17413.11.17 0))
      (fun/ascii-char17414.12
       (make-closure L.fun/ascii-char17414.12.18 0 fun/ascii-char17415.6))
      (fun/error17412.13
       (make-closure L.fun/error17412.13.19 0 fun/error17413.11))
      (fun/error17407.14 (make-closure L.fun/error17407.14.20 0))
      (fun/error17411.15 (make-closure L.fun/error17411.15.21 0))
      (fun/error17406.16
       (make-closure L.fun/error17406.16.22 0 fun/error17407.14))
      (fun/void17417.17 (make-closure L.fun/void17417.17.23 0)))
     (let ((error0.23 (call L.fun/error17406.16.22 fun/error17406.16))
           (vector1.22 (call L.fun/vector17408.4.10 fun/vector17408.4))
           (error2.21 (call L.fun/error17410.8.14 fun/error17410.8))
           (error3.20 (call L.fun/error17412.13.19 fun/error17412.13))
           (ascii-char4.19
            (call L.fun/ascii-char17414.12.18 fun/ascii-char17414.12))
           (void5.18 (call L.fun/void17416.10.16 fun/void17416.10)))
       (call L.fun/vector17418.5.11 fun/vector17418.5)))))
(check-by-interp
 '(module
    (define L.lam.78.25
      (lambda (c.97)
        (let ((fun/empty18589.13 (closure-ref c.97 0)))
          (call L.fun/empty18589.13.22 fun/empty18589.13))))
    (define L.fun/ascii-char18591.15.24
      (lambda (c.96)
        (let ((fun/ascii-char18592.14 (closure-ref c.96 0)))
          (call L.fun/ascii-char18592.14.23 fun/ascii-char18592.14))))
    (define L.fun/ascii-char18592.14.23 (lambda (c.95) (let () #\g)))
    (define L.fun/empty18589.13.22
      (lambda (c.94)
        (let ((fun/empty18590.10 (closure-ref c.94 0)))
          (call L.fun/empty18590.10.19 fun/empty18590.10))))
    (define L.fun/error18585.12.21
      (lambda (c.93)
        (let ((fun/error18586.11 (closure-ref c.93 0)))
          (call L.fun/error18586.11.20 fun/error18586.11))))
    (define L.fun/error18586.11.20 (lambda (c.92) (let () (error 31))))
    (define L.fun/empty18590.10.19 (lambda (c.91) (let () empty)))
    (define L.fun/vector18595.9.18
      (lambda (c.90)
        (let ((fun/vector18596.8 (closure-ref c.90 0)))
          (call L.fun/vector18596.8.17 fun/vector18596.8))))
    (define L.fun/vector18596.8.17
      (lambda (c.89)
        (let ((make-vector.74 (closure-ref c.89 0)))
          (call L.make-vector.74.12 make-vector.74 8))))
    (define L.fun/empty18593.7.16
      (lambda (c.88)
        (let ((fun/empty18594.4 (closure-ref c.88 0)))
          (call L.fun/empty18594.4.13 fun/empty18594.4))))
    (define L.fun/error18588.6.15 (lambda (c.87) (let () (error 113))))
    (define L.fun/error18587.5.14
      (lambda (c.86)
        (let ((fun/error18588.6 (closure-ref c.86 0)))
          (call L.fun/error18588.6.15 fun/error18588.6))))
    (define L.fun/empty18594.4.13 (lambda (c.85) (let () empty)))
    (define L.make-vector.74.12
      (lambda (c.84 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.84 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.83 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.83 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.10
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.10
      (lambda (c.82 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.82 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.10
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (define L.-.75.9
      (lambda (c.81 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.+.76.8
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.77.7
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (cletrec
     ((*.77 (make-closure L.*.77.7 2))
      (|+.76| (make-closure L.+.76.8 2))
      (|-.75| (make-closure L.-.75.9 2))
      (vector-init-loop.24
       (make-closure L.vector-init-loop.24.10 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.12 1 make-init-vector.1))
      (fun/empty18594.4 (make-closure L.fun/empty18594.4.13 0))
      (fun/error18587.5
       (make-closure L.fun/error18587.5.14 0 fun/error18588.6))
      (fun/error18588.6 (make-closure L.fun/error18588.6.15 0))
      (fun/empty18593.7
       (make-closure L.fun/empty18593.7.16 0 fun/empty18594.4))
      (fun/vector18596.8
       (make-closure L.fun/vector18596.8.17 0 make-vector.74))
      (fun/vector18595.9
       (make-closure L.fun/vector18595.9.18 0 fun/vector18596.8))
      (fun/empty18590.10 (make-closure L.fun/empty18590.10.19 0))
      (fun/error18586.11 (make-closure L.fun/error18586.11.20 0))
      (fun/error18585.12
       (make-closure L.fun/error18585.12.21 0 fun/error18586.11))
      (fun/empty18589.13
       (make-closure L.fun/empty18589.13.22 0 fun/empty18590.10))
      (fun/ascii-char18592.14 (make-closure L.fun/ascii-char18592.14.23 0))
      (fun/ascii-char18591.15
       (make-closure L.fun/ascii-char18591.15.24 0 fun/ascii-char18592.14)))
     (let ((error0.21 (call L.fun/error18585.12.21 fun/error18585.12))
           (error1.20 (call L.fun/error18587.5.14 fun/error18587.5))
           (procedure2.19
            (cletrec
             ((lam.78 (make-closure L.lam.78.25 0 fun/empty18589.13)))
             lam.78))
           (fixnum3.18
            (call
             L.*.77.7
             *.77
             (call
              L.-.75.9
              |-.75|
              (call
               L.+.76.8
               |+.76|
               (call L.-.75.9 |-.75| 129 28)
               (call L.-.75.9 |-.75| 120 104))
              (call
               L.-.75.9
               |-.75|
               (call L.*.77.7 *.77 177 151)
               (call L.+.76.8 |+.76| 2 114)))
             (call
              L.+.76.8
              |+.76|
              (call
               L.-.75.9
               |-.75|
               (call L.-.75.9 |-.75| 158 176)
               (call L.-.75.9 |-.75| 38 134))
              (call
               L.+.76.8
               |+.76|
               (call L.+.76.8 |+.76| 119 101)
               (call L.+.76.8 |+.76| 52 154)))))
           (ascii-char4.17
            (call L.fun/ascii-char18591.15.24 fun/ascii-char18591.15))
           (empty5.16 (call L.fun/empty18593.7.16 fun/empty18593.7)))
       (call L.fun/vector18595.9.18 fun/vector18595.9)))))
(check-by-interp
 '(module
    (define L.lam.78.25
      (lambda (c.97)
        (let ((fun/vector19107.5 (closure-ref c.97 0)))
          (call L.fun/vector19107.5.14 fun/vector19107.5))))
    (define L.fun/vector19108.15.24
      (lambda (c.96)
        (let ((make-vector.74 (closure-ref c.96 0)))
          (call L.make-vector.74.12 make-vector.74 8))))
    (define L.fun/ascii-char19112.14.23 (lambda (c.95) (let () #\p)))
    (define L.fun/ascii-char19109.13.22
      (lambda (c.94)
        (let ((fun/ascii-char19110.9 (closure-ref c.94 0)))
          (call L.fun/ascii-char19110.9.18 fun/ascii-char19110.9))))
    (define L.fun/error19114.12.21 (lambda (c.93) (let () (error 9))))
    (define L.fun/error19113.11.20
      (lambda (c.92)
        (let ((fun/error19114.12 (closure-ref c.92 0)))
          (call L.fun/error19114.12.21 fun/error19114.12))))
    (define L.fun/ascii-char19111.10.19
      (lambda (c.91)
        (let ((fun/ascii-char19112.14 (closure-ref c.91 0)))
          (call L.fun/ascii-char19112.14.23 fun/ascii-char19112.14))))
    (define L.fun/ascii-char19110.9.18 (lambda (c.90) (let () #\Z)))
    (define L.fun/void19115.8.17
      (lambda (c.89)
        (let ((fun/void19116.6 (closure-ref c.89 0)))
          (call L.fun/void19116.6.15 fun/void19116.6))))
    (define L.fun/empty19105.7.16
      (lambda (c.88)
        (let ((fun/empty19106.4 (closure-ref c.88 0)))
          (call L.fun/empty19106.4.13 fun/empty19106.4))))
    (define L.fun/void19116.6.15 (lambda (c.87) (let () (void))))
    (define L.fun/vector19107.5.14
      (lambda (c.86)
        (let ((fun/vector19108.15 (closure-ref c.86 0)))
          (call L.fun/vector19108.15.24 fun/vector19108.15))))
    (define L.fun/empty19106.4.13 (lambda (c.85) (let () empty)))
    (define L.make-vector.74.12
      (lambda (c.84 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.84 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.83 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.83 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.10
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.10
      (lambda (c.82 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.82 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.10
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (define L.-.75.9
      (lambda (c.81 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.+.76.8
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.77.7
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (cletrec
     ((*.77 (make-closure L.*.77.7 2))
      (|+.76| (make-closure L.+.76.8 2))
      (|-.75| (make-closure L.-.75.9 2))
      (vector-init-loop.24
       (make-closure L.vector-init-loop.24.10 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.11 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.12 1 make-init-vector.1))
      (fun/empty19106.4 (make-closure L.fun/empty19106.4.13 0))
      (fun/vector19107.5
       (make-closure L.fun/vector19107.5.14 0 fun/vector19108.15))
      (fun/void19116.6 (make-closure L.fun/void19116.6.15 0))
      (fun/empty19105.7
       (make-closure L.fun/empty19105.7.16 0 fun/empty19106.4))
      (fun/void19115.8 (make-closure L.fun/void19115.8.17 0 fun/void19116.6))
      (fun/ascii-char19110.9 (make-closure L.fun/ascii-char19110.9.18 0))
      (fun/ascii-char19111.10
       (make-closure L.fun/ascii-char19111.10.19 0 fun/ascii-char19112.14))
      (fun/error19113.11
       (make-closure L.fun/error19113.11.20 0 fun/error19114.12))
      (fun/error19114.12 (make-closure L.fun/error19114.12.21 0))
      (fun/ascii-char19109.13
       (make-closure L.fun/ascii-char19109.13.22 0 fun/ascii-char19110.9))
      (fun/ascii-char19112.14 (make-closure L.fun/ascii-char19112.14.23 0))
      (fun/vector19108.15
       (make-closure L.fun/vector19108.15.24 0 make-vector.74)))
     (let ((empty0.21 (call L.fun/empty19105.7.16 fun/empty19105.7))
           (fixnum1.20
            (call
             L.*.77.7
             *.77
             (call
              L.+.76.8
              |+.76|
              (call
               L.-.75.9
               |-.75|
               (call L.-.75.9 |-.75| 1 111)
               (call L.-.75.9 |-.75| 118 140))
              (call
               L.*.77.7
               *.77
               (call L.-.75.9 |-.75| 158 77)
               (call L.+.76.8 |+.76| 222 154)))
             (call
              L.+.76.8
              |+.76|
              (call
               L.-.75.9
               |-.75|
               (call L.+.76.8 |+.76| 64 198)
               (call L.*.77.7 *.77 197 213))
              (call
               L.*.77.7
               *.77
               (call L.*.77.7 *.77 206 230)
               (call L.+.76.8 |+.76| 117 189)))))
           (procedure2.19
            (cletrec
             ((lam.78 (make-closure L.lam.78.25 0 fun/vector19107.5)))
             lam.78))
           (ascii-char3.18
            (call L.fun/ascii-char19109.13.22 fun/ascii-char19109.13))
           (ascii-char4.17
            (call L.fun/ascii-char19111.10.19 fun/ascii-char19111.10))
           (error5.16 (call L.fun/error19113.11.20 fun/error19113.11)))
       (call L.fun/void19115.8.17 fun/void19115.8)))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((fun/void20270.7 (closure-ref c.93 0)))
          (call L.fun/void20270.7.11 fun/void20270.7))))
    (define L.fun/void20281.17.21 (lambda (c.92) (let () (void))))
    (define L.fun/ascii-char20274.16.20
      (lambda (c.91)
        (let ((fun/ascii-char20275.14 (closure-ref c.91 0)))
          (call L.fun/ascii-char20275.14.18 fun/ascii-char20275.14))))
    (define L.fun/empty20272.15.19
      (lambda (c.90)
        (let ((fun/empty20273.9 (closure-ref c.90 0)))
          (call L.fun/empty20273.9.13 fun/empty20273.9))))
    (define L.fun/ascii-char20275.14.18 (lambda (c.89) (let () #\Z)))
    (define L.fun/error20276.13.17
      (lambda (c.88)
        (let ((fun/error20277.12 (closure-ref c.88 0)))
          (call L.fun/error20277.12.16 fun/error20277.12))))
    (define L.fun/error20277.12.16 (lambda (c.87) (let () (error 110))))
    (define L.fun/empty20279.11.15 (lambda (c.86) (let () empty)))
    (define L.fun/void20280.10.14
      (lambda (c.85)
        (let ((fun/void20281.17 (closure-ref c.85 0)))
          (call L.fun/void20281.17.21 fun/void20281.17))))
    (define L.fun/empty20273.9.13 (lambda (c.84) (let () empty)))
    (define L.fun/empty20278.8.12
      (lambda (c.83)
        (let ((fun/empty20279.11 (closure-ref c.83 0)))
          (call L.fun/empty20279.11.15 fun/empty20279.11))))
    (define L.fun/void20270.7.11
      (lambda (c.82)
        (let ((fun/void20271.5 (closure-ref c.82 0)))
          (call L.fun/void20271.5.9 fun/void20271.5))))
    (define L.fun/any20283.6.10 (lambda (c.81) (let () (error 163))))
    (define L.fun/void20271.5.9 (lambda (c.80) (let () (void))))
    (define L.fun/any20282.4.8
      (lambda (c.79)
        (let ((fun/any20283.6 (closure-ref c.79 0)))
          (call L.fun/any20283.6.10 fun/any20283.6))))
    (define L.pair?.76.7 (lambda (c.78 tmp.67) (let () (pair? tmp.67))))
    (cletrec
     ((pair?.76 (make-closure L.pair?.76.7 1))
      (fun/any20282.4 (make-closure L.fun/any20282.4.8 0 fun/any20283.6))
      (fun/void20271.5 (make-closure L.fun/void20271.5.9 0))
      (fun/any20283.6 (make-closure L.fun/any20283.6.10 0))
      (fun/void20270.7 (make-closure L.fun/void20270.7.11 0 fun/void20271.5))
      (fun/empty20278.8
       (make-closure L.fun/empty20278.8.12 0 fun/empty20279.11))
      (fun/empty20273.9 (make-closure L.fun/empty20273.9.13 0))
      (fun/void20280.10
       (make-closure L.fun/void20280.10.14 0 fun/void20281.17))
      (fun/empty20279.11 (make-closure L.fun/empty20279.11.15 0))
      (fun/error20277.12 (make-closure L.fun/error20277.12.16 0))
      (fun/error20276.13
       (make-closure L.fun/error20276.13.17 0 fun/error20277.12))
      (fun/ascii-char20275.14 (make-closure L.fun/ascii-char20275.14.18 0))
      (fun/empty20272.15
       (make-closure L.fun/empty20272.15.19 0 fun/empty20273.9))
      (fun/ascii-char20274.16
       (make-closure L.fun/ascii-char20274.16.20 0 fun/ascii-char20275.14))
      (fun/void20281.17 (make-closure L.fun/void20281.17.21 0)))
     (let ((procedure0.23
            (cletrec
             ((lam.77 (make-closure L.lam.77.22 0 fun/void20270.7)))
             lam.77))
           (empty1.22 (call L.fun/empty20272.15.19 fun/empty20272.15))
           (ascii-char2.21
            (call L.fun/ascii-char20274.16.20 fun/ascii-char20274.16))
           (error3.20 (call L.fun/error20276.13.17 fun/error20276.13))
           (empty4.19 (call L.fun/empty20278.8.12 fun/empty20278.8))
           (void5.18 (call L.fun/void20280.10.14 fun/void20280.10)))
       (call
        L.pair?.76.7
        pair?.76
        (call L.fun/any20282.4.8 fun/any20282.4))))))
(check-by-interp
 '(module
    (define L.fun/any21160.15.26
      (lambda (c.99)
        (let ((fun/any21161.5 (closure-ref c.99 0)))
          (call L.fun/any21161.5.16 fun/any21161.5))))
    (define L.fun/error21157.14.25 (lambda (c.98) (let () (error 103))))
    (define L.fun/vector21158.13.24
      (lambda (c.97)
        (let ((fun/vector21159.11 (closure-ref c.97 0)))
          (call L.fun/vector21159.11.22 fun/vector21159.11))))
    (define L.fun/void21167.12.23 (lambda (c.96) (let () (void))))
    (define L.fun/vector21159.11.22
      (lambda (c.95)
        (let ((make-vector.74 (closure-ref c.95 0)))
          (call L.make-vector.74.14 make-vector.74 8))))
    (define L.fun/error21156.10.21
      (lambda (c.94)
        (let ((fun/error21157.14 (closure-ref c.94 0)))
          (call L.fun/error21157.14.25 fun/error21157.14))))
    (define L.fun/void21166.9.20
      (lambda (c.93)
        (let ((fun/void21167.12 (closure-ref c.93 0)))
          (call L.fun/void21167.12.23 fun/void21167.12))))
    (define L.fun/empty21162.8.19
      (lambda (c.92)
        (let ((fun/empty21163.4 (closure-ref c.92 0)))
          (call L.fun/empty21163.4.15 fun/empty21163.4))))
    (define L.fun/any21164.7.18
      (lambda (c.91)
        (let ((fun/any21165.6 (closure-ref c.91 0)))
          (call L.fun/any21165.6.17 fun/any21165.6))))
    (define L.fun/any21165.6.17
      (lambda (c.90)
        (let ((make-vector.74 (closure-ref c.90 0)))
          (call L.make-vector.74.14 make-vector.74 8))))
    (define L.fun/any21161.5.16 (lambda (c.89) (let () 186)))
    (define L.fun/empty21163.4.15 (lambda (c.88) (let () empty)))
    (define L.make-vector.74.14
      (lambda (c.87 tmp.50)
        (let ((make-init-vector.1 (closure-ref c.87 0)))
          (if (fixnum? tmp.50)
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            (error 8)))))
    (define L.make-init-vector.1.13
      (lambda (c.86 tmp.22)
        (let ((vector-init-loop.24 (closure-ref c.86 0)))
          (let ((tmp.23 (unsafe-make-vector tmp.22)))
            (call
             L.vector-init-loop.24.12
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.12
      (lambda (c.85 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (closure-ref c.85 0)))
          (if (eq? len.25 i.27)
            vec.26
            (begin
              (unsafe-vector-set! vec.26 i.27 0)
              (call
               L.vector-init-loop.24.12
               vector-init-loop.24
               len.25
               (unsafe-fx+ i.27 1)
               vec.26))))))
    (define L.empty?.75.11 (lambda (c.84 tmp.61) (let () (empty? tmp.61))))
    (define L.-.76.10
      (lambda (c.83 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (define L.*.77.9
      (lambda (c.82 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.+.78.8
      (lambda (c.81 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.vector?.79.7 (lambda (c.80 tmp.66) (let () (vector? tmp.66))))
    (cletrec
     ((vector?.79 (make-closure L.vector?.79.7 1))
      (|+.78| (make-closure L.+.78.8 2))
      (*.77 (make-closure L.*.77.9 2))
      (|-.76| (make-closure L.-.76.10 2))
      (empty?.75 (make-closure L.empty?.75.11 1))
      (vector-init-loop.24
       (make-closure L.vector-init-loop.24.12 3 vector-init-loop.24))
      (make-init-vector.1
       (make-closure L.make-init-vector.1.13 1 vector-init-loop.24))
      (make-vector.74 (make-closure L.make-vector.74.14 1 make-init-vector.1))
      (fun/empty21163.4 (make-closure L.fun/empty21163.4.15 0))
      (fun/any21161.5 (make-closure L.fun/any21161.5.16 0))
      (fun/any21165.6 (make-closure L.fun/any21165.6.17 0 make-vector.74))
      (fun/any21164.7 (make-closure L.fun/any21164.7.18 0 fun/any21165.6))
      (fun/empty21162.8
       (make-closure L.fun/empty21162.8.19 0 fun/empty21163.4))
      (fun/void21166.9 (make-closure L.fun/void21166.9.20 0 fun/void21167.12))
      (fun/error21156.10
       (make-closure L.fun/error21156.10.21 0 fun/error21157.14))
      (fun/vector21159.11
       (make-closure L.fun/vector21159.11.22 0 make-vector.74))
      (fun/void21167.12 (make-closure L.fun/void21167.12.23 0))
      (fun/vector21158.13
       (make-closure L.fun/vector21158.13.24 0 fun/vector21159.11))
      (fun/error21157.14 (make-closure L.fun/error21157.14.25 0))
      (fun/any21160.15 (make-closure L.fun/any21160.15.26 0 fun/any21161.5)))
     (let ((error0.21 (call L.fun/error21156.10.21 fun/error21156.10))
           (vector1.20 (call L.fun/vector21158.13.24 fun/vector21158.13))
           (boolean2.19
            (call
             L.empty?.75.11
             empty?.75
             (call L.fun/any21160.15.26 fun/any21160.15)))
           (fixnum3.18
            (call
             L.*.77.9
             *.77
             (call
              L.+.78.8
              |+.78|
              (call
               L.*.77.9
               *.77
               (call L.-.76.10 |-.76| 26 52)
               (call L.-.76.10 |-.76| 136 64))
              (call
               L.*.77.9
               *.77
               (call L.-.76.10 |-.76| 37 135)
               (call L.*.77.9 *.77 21 177)))
             (call
              L.+.78.8
              |+.78|
              (call
               L.-.76.10
               |-.76|
               (call L.-.76.10 |-.76| 56 11)
               (call L.*.77.9 *.77 177 202))
              (call
               L.+.78.8
               |+.78|
               (call L.-.76.10 |-.76| 123 25)
               (call L.-.76.10 |-.76| 222 131)))))
           (empty4.17 (call L.fun/empty21162.8.19 fun/empty21162.8))
           (boolean5.16
            (call
             L.vector?.79.7
             vector?.79
             (call L.fun/any21164.7.18 fun/any21164.7))))
       (call L.fun/void21166.9.20 fun/void21166.9)))))
(check-by-interp
 '(module
    (define L.fun/any23215.15.24
      (lambda (c.97)
        (let ((fun/any23216.11 (closure-ref c.97 0)))
          (call L.fun/any23216.11.20 fun/any23216.11))))
    (define L.fun/ascii-char23226.14.23 (lambda (c.96) (let () #\Y)))
    (define L.fun/error23217.13.22
      (lambda (c.95)
        (let ((fun/error23218.5 (closure-ref c.95 0)))
          (call L.fun/error23218.5.14 fun/error23218.5))))
    (define L.fun/ascii-char23225.12.21
      (lambda (c.94)
        (let ((fun/ascii-char23226.14 (closure-ref c.94 0)))
          (call L.fun/ascii-char23226.14.23 fun/ascii-char23226.14))))
    (define L.fun/any23216.11.20
      (lambda (c.93)
        (let ((cons.74 (closure-ref c.93 0)))
          (call L.cons.74.12 cons.74 102 340))))
    (define L.fun/void23219.10.19
      (lambda (c.92)
        (let ((fun/void23220.8 (closure-ref c.92 0)))
          (call L.fun/void23220.8.17 fun/void23220.8))))
    (define L.fun/any23221.9.18
      (lambda (c.91)
        (let ((fun/any23222.4 (closure-ref c.91 0)))
          (call L.fun/any23222.4.13 fun/any23222.4))))
    (define L.fun/void23220.8.17 (lambda (c.90) (let () (void))))
    (define L.fun/void23224.7.16 (lambda (c.89) (let () (void))))
    (define L.fun/void23223.6.15
      (lambda (c.88)
        (let ((fun/void23224.7 (closure-ref c.88 0)))
          (call L.fun/void23224.7.16 fun/void23224.7))))
    (define L.fun/error23218.5.14 (lambda (c.87) (let () (error 182))))
    (define L.fun/any23222.4.13
      (lambda (c.86)
        (let ((cons.74 (closure-ref c.86 0)))
          (call L.cons.74.12 cons.74 40 437))))
    (define L.cons.74.12
      (lambda (c.85 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
    (define L.pair?.75.11 (lambda (c.84 tmp.65) (let () (pair? tmp.65))))
    (define L.boolean?.76.10 (lambda (c.83 tmp.60) (let () (boolean? tmp.60))))
    (define L.+.77.9
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
            (error 2)))))
    (define L.*.78.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
            (error 1)))))
    (define L.-.79.7
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (fixnum? tmp.41)
            (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
            (error 3)))))
    (cletrec
     ((|-.79| (make-closure L.-.79.7 2))
      (*.78 (make-closure L.*.78.8 2))
      (|+.77| (make-closure L.+.77.9 2))
      (boolean?.76 (make-closure L.boolean?.76.10 1))
      (pair?.75 (make-closure L.pair?.75.11 1))
      (cons.74 (make-closure L.cons.74.12 2))
      (fun/any23222.4 (make-closure L.fun/any23222.4.13 0 cons.74))
      (fun/error23218.5 (make-closure L.fun/error23218.5.14 0))
      (fun/void23223.6 (make-closure L.fun/void23223.6.15 0 fun/void23224.7))
      (fun/void23224.7 (make-closure L.fun/void23224.7.16 0))
      (fun/void23220.8 (make-closure L.fun/void23220.8.17 0))
      (fun/any23221.9 (make-closure L.fun/any23221.9.18 0 fun/any23222.4))
      (fun/void23219.10 (make-closure L.fun/void23219.10.19 0 fun/void23220.8))
      (fun/any23216.11 (make-closure L.fun/any23216.11.20 0 cons.74))
      (fun/ascii-char23225.12
       (make-closure L.fun/ascii-char23225.12.21 0 fun/ascii-char23226.14))
      (fun/error23217.13
       (make-closure L.fun/error23217.13.22 0 fun/error23218.5))
      (fun/ascii-char23226.14 (make-closure L.fun/ascii-char23226.14.23 0))
      (fun/any23215.15 (make-closure L.fun/any23215.15.24 0 fun/any23216.11)))
     (let ((boolean0.21
            (call
             L.pair?.75.11
             pair?.75
             (call L.fun/any23215.15.24 fun/any23215.15)))
           (error1.20 (call L.fun/error23217.13.22 fun/error23217.13))
           (void2.19 (call L.fun/void23219.10.19 fun/void23219.10))
           (boolean3.18
            (call
             L.boolean?.76.10
             boolean?.76
             (call L.fun/any23221.9.18 fun/any23221.9)))
           (fixnum4.17
            (call
             L.*.78.8
             *.78
             (call
              L.*.78.8
              *.78
              (call
               L.*.78.8
               *.78
               (call L.+.77.9 |+.77| 215 43)
               (call L.*.78.8 *.78 163 91))
              (call
               L.+.77.9
               |+.77|
               (call L.+.77.9 |+.77| 43 216)
               (call L.+.77.9 |+.77| 12 113)))
             (call
              L.-.79.7
              |-.79|
              (call
               L.-.79.7
               |-.79|
               (call L.*.78.8 *.78 184 4)
               (call L.+.77.9 |+.77| 164 45))
              (call
               L.-.79.7
               |-.79|
               (call L.+.77.9 |+.77| 162 116)
               (call L.-.79.7 |-.79| 205 220)))))
           (void5.16 (call L.fun/void23223.6.15 fun/void23223.6)))
       (call L.fun/ascii-char23225.12.21 fun/ascii-char23225.12)))))
(check-by-interp
 '(module
    (define L.lam.78.23
      (lambda (c.95)
        (let ((fun/any24030.9 (closure-ref c.95 0))
              (procedure?.73 (closure-ref c.95 1)))
          (call
           L.procedure?.73.11
           procedure?.73
           (call L.fun/any24030.9.18 fun/any24030.9)))))
    (define L.fun/empty24034.13.22
      (lambda (c.94)
        (let ((fun/empty24035.4 (closure-ref c.94 0)))
          (call L.fun/empty24035.4.13 fun/empty24035.4))))
    (define L.fun/any24032.12.21
      (lambda (c.93)
        (let ((fun/any24033.10 (closure-ref c.93 0)))
          (call L.fun/any24033.10.19 fun/any24033.10))))
    (define L.fun/pair24036.11.20
      (lambda (c.92)
        (let ((fun/pair24037.7 (closure-ref c.92 0)))
          (call L.fun/pair24037.7.16 fun/pair24037.7))))
    (define L.fun/any24033.10.19 (lambda (c.91) (let () #\X)))
    (define L.fun/any24030.9.18
      (lambda (c.90)
        (let ((fun/any24031.8 (closure-ref c.90 0)))
          (call L.fun/any24031.8.17 fun/any24031.8))))
    (define L.fun/any24031.8.17 (lambda (c.89) (let () #f)))
    (define L.fun/pair24037.7.16
      (lambda (c.88)
        (let ((cons.72 (closure-ref c.88 0)))
          (call L.cons.72.12 cons.72 50 301))))
    (define L.fun/empty24028.6.15
      (lambda (c.87)
        (let ((fun/empty24029.5 (closure-ref c.87 0)))
          (call L.fun/empty24029.5.14 fun/empty24029.5))))
    (define L.fun/empty24029.5.14 (lambda (c.86) (let () empty)))
    (define L.fun/empty24035.4.13 (lambda (c.85) (let () empty)))
    (define L.cons.72.12
      (lambda (c.84 tmp.67 tmp.68) (let () (cons tmp.67 tmp.68))))
    (define L.procedure?.73.11
      (lambda (c.83 tmp.66) (let () (procedure? tmp.66))))
    (define L.-.74.10
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (fixnum? tmp.39)
            (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
            (error 3)))))
    (define L.*.75.9
      (lambda (c.81 tmp.34 tmp.35)
        (let ()
          (if (fixnum? tmp.35)
            (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
            (error 1)))))
    (define L.+.76.8
      (lambda (c.80 tmp.36 tmp.37)
        (let ()
          (if (fixnum? tmp.37)
            (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
            (error 2)))))
    (define L.empty?.77.7 (lambda (c.79 tmp.59) (let () (empty? tmp.59))))
    (cletrec
     ((empty?.77 (make-closure L.empty?.77.7 1))
      (|+.76| (make-closure L.+.76.8 2))
      (*.75 (make-closure L.*.75.9 2))
      (|-.74| (make-closure L.-.74.10 2))
      (procedure?.73 (make-closure L.procedure?.73.11 1))
      (cons.72 (make-closure L.cons.72.12 2))
      (fun/empty24035.4 (make-closure L.fun/empty24035.4.13 0))
      (fun/empty24029.5 (make-closure L.fun/empty24029.5.14 0))
      (fun/empty24028.6
       (make-closure L.fun/empty24028.6.15 0 fun/empty24029.5))
      (fun/pair24037.7 (make-closure L.fun/pair24037.7.16 0 cons.72))
      (fun/any24031.8 (make-closure L.fun/any24031.8.17 0))
      (fun/any24030.9 (make-closure L.fun/any24030.9.18 0 fun/any24031.8))
      (fun/any24033.10 (make-closure L.fun/any24033.10.19 0))
      (fun/pair24036.11 (make-closure L.fun/pair24036.11.20 0 fun/pair24037.7))
      (fun/any24032.12 (make-closure L.fun/any24032.12.21 0 fun/any24033.10))
      (fun/empty24034.13
       (make-closure L.fun/empty24034.13.22 0 fun/empty24035.4)))
     (let ((empty0.19 (call L.fun/empty24028.6.15 fun/empty24028.6))
           (procedure1.18
            (cletrec
             ((lam.78
               (make-closure L.lam.78.23 0 fun/any24030.9 procedure?.73)))
             lam.78))
           (fixnum2.17
            (call
             L.*.75.9
             *.75
             (call
              L.+.76.8
              |+.76|
              (call
               L.*.75.9
               *.75
               (call L.-.74.10 |-.74| 139 114)
               (call L.*.75.9 *.75 226 88))
              (call
               L.+.76.8
               |+.76|
               (call L.+.76.8 |+.76| 94 45)
               (call L.*.75.9 *.75 34 204)))
             (call
              L.-.74.10
              |-.74|
              (call
               L.+.76.8
               |+.76|
               (call L.-.74.10 |-.74| 40 48)
               (call L.+.76.8 |+.76| 67 44))
              (call
               L.*.75.9
               *.75
               (call L.-.74.10 |-.74| 121 46)
               (call L.+.76.8 |+.76| 5 152)))))
           (fixnum3.16
            (call
             L.*.75.9
             *.75
             (call
              L.-.74.10
              |-.74|
              (call
               L.+.76.8
               |+.76|
               (call L.*.75.9 *.75 250 42)
               (call L.+.76.8 |+.76| 40 186))
              (call
               L.-.74.10
               |-.74|
               (call L.+.76.8 |+.76| 44 155)
               (call L.*.75.9 *.75 123 40)))
             (call
              L.*.75.9
              *.75
              (call
               L.+.76.8
               |+.76|
               (call L.-.74.10 |-.74| 203 106)
               (call L.*.75.9 *.75 38 6))
              (call
               L.*.75.9
               *.75
               (call L.+.76.8 |+.76| 77 100)
               (call L.-.74.10 |-.74| 66 58)))))
           (boolean4.15
            (call
             L.empty?.77.7
             empty?.77
             (call L.fun/any24032.12.21 fun/any24032.12)))
           (empty5.14 (call L.fun/empty24034.13.22 fun/empty24034.13)))
       (call L.fun/pair24036.11.20 fun/pair24036.11)))))
