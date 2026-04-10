#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
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

(check-by-interp
 '(module
    (letrec ((L.cons.56.7
              (lambda (c.57 tmp.51 tmp.52) (let () (cons tmp.51 tmp.52)))))
      (cletrec
       ((cons.56 (make-closure L.cons.56.7 2)))
       (closure-call cons.56 cons.56 6 501)))))
(check-by-interp
 '(module
    (letrec ((L.cons.56.7
              (lambda (c.57 tmp.51 tmp.52) (let () (cons tmp.51 tmp.52)))))
      (cletrec
       ((cons.56 (make-closure L.cons.56.7 2)))
       (closure-call cons.56 cons.56 42 510)))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8439.4.7 (lambda (c.57) (let () (error 148)))))
      (cletrec
       ((fun/error8439.4 (make-closure L.fun/error8439.4.7 0)))
       (closure-call fun/error8439.4 fun/error8439.4)))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8442.4.7 (lambda (c.57) (let () (error 247)))))
      (cletrec
       ((fun/error8442.4 (make-closure L.fun/error8442.4.7 0)))
       (closure-call fun/error8442.4 fun/error8442.4)))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8445.4.7 (lambda (c.57) (let () (error 141)))))
      (cletrec
       ((fun/error8445.4 (make-closure L.fun/error8445.4.7 0)))
       (closure-call fun/error8445.4 fun/error8445.4)))))
(check-by-interp
 '(module
    (letrec ((L.cons.57.7
              (lambda (c.58 tmp.52 tmp.53) (let () (cons tmp.52 tmp.53))))
             (L.fun/pair8448.4.8
              (lambda (c.59)
                (let ((cons.57 (closure-ref c.59 0)))
                  (closure-call cons.57 cons.57 183 277)))))
      (cletrec
       ((cons.57 (make-closure L.cons.57.7 2))
        (fun/pair8448.4 (make-closure L.fun/pair8448.4.8 0 cons.57)))
       (closure-call fun/pair8448.4 fun/pair8448.4)))))
(check-by-interp '(module (let ((ascii-char0.5 #\N) (void1.4 (void))) #t)))
(check-by-interp
 '(module
    (letrec ((L.vector-init-loop.8.7
              (lambda (c.60 len.9 i.11 vec.10)
                (let ((vector-init-loop.8 (closure-ref c.60 0)))
                  (if (eq? len.9 i.11)
                    vec.10
                    (begin
                      (unsafe-vector-set! vec.10 i.11 0)
                      (closure-call
                       vector-init-loop.8
                       vector-init-loop.8
                       len.9
                       (unsafe-fx+ i.11 1)
                       vec.10))))))
             (L.make-init-vector.1.8
              (lambda (c.61 tmp.6)
                (let ((vector-init-loop.8 (closure-ref c.61 0)))
                  (let ((tmp.7 (unsafe-make-vector tmp.6)))
                    (closure-call
                     vector-init-loop.8
                     vector-init-loop.8
                     tmp.6
                     0
                     tmp.7)))))
             (L.make-vector.58.9
              (lambda (c.62 tmp.34)
                (let ((make-init-vector.1 (closure-ref c.62 0)))
                  (if (fixnum? tmp.34)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.34)
                    (error 8))))))
      (cletrec
       ((vector-init-loop.8
         (make-closure L.vector-init-loop.8.7 3 vector-init-loop.8))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.8 1 vector-init-loop.8))
        (make-vector.58
         (make-closure L.make-vector.58.9 1 make-init-vector.1)))
       (let ((vector0.5 (closure-call make-vector.58 make-vector.58 8))
             (procedure1.4
              (letrec ((L.lam.59.10 (lambda (c.63) (let () 72))))
                (cletrec ((lam.59 (make-closure L.lam.59.10 0))) lam.59))))
         empty)))))
(check-by-interp
 '(module
    (letrec ((L.cons.59.7
              (lambda (c.60 tmp.54 tmp.55) (let () (cons tmp.54 tmp.55))))
             (L.fun/empty8458.4.8 (lambda (c.61) (let () empty)))
             (L.fun/empty8457.5.9
              (lambda (c.62 oprand0.6)
                (let ((fun/empty8458.4 (closure-ref c.62 0)))
                  (closure-call fun/empty8458.4 fun/empty8458.4)))))
      (cletrec
       ((cons.59 (make-closure L.cons.59.7 2))
        (fun/empty8458.4 (make-closure L.fun/empty8458.4.8 0))
        (fun/empty8457.5 (make-closure L.fun/empty8457.5.9 1 fun/empty8458.4)))
       (closure-call
        fun/empty8457.5
        fun/empty8457.5
        (if #f
          (closure-call cons.59 cons.59 197 480)
          (closure-call cons.59 cons.59 47 421)))))))
(check-by-interp '(module (if #f (void) (void))))
(check-by-interp
 '(module
    (letrec ((L.vector-init-loop.6.7
              (lambda (c.57 len.7 i.9 vec.8)
                (let ((vector-init-loop.6 (closure-ref c.57 0)))
                  (if (eq? len.7 i.9)
                    vec.8
                    (begin
                      (unsafe-vector-set! vec.8 i.9 0)
                      (closure-call
                       vector-init-loop.6
                       vector-init-loop.6
                       len.7
                       (unsafe-fx+ i.9 1)
                       vec.8))))))
             (L.make-init-vector.1.8
              (lambda (c.58 tmp.4)
                (let ((vector-init-loop.6 (closure-ref c.58 0)))
                  (let ((tmp.5 (unsafe-make-vector tmp.4)))
                    (closure-call
                     vector-init-loop.6
                     vector-init-loop.6
                     tmp.4
                     0
                     tmp.5)))))
             (L.make-vector.56.9
              (lambda (c.59 tmp.32)
                (let ((make-init-vector.1 (closure-ref c.59 0)))
                  (if (fixnum? tmp.32)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.32)
                    (error 8))))))
      (cletrec
       ((vector-init-loop.6
         (make-closure L.vector-init-loop.6.7 3 vector-init-loop.6))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.8 1 vector-init-loop.6))
        (make-vector.56
         (make-closure L.make-vector.56.9 1 make-init-vector.1)))
       (if #f
         (closure-call make-vector.56 make-vector.56 8)
         (closure-call make-vector.56 make-vector.56 8))))))
(check-by-interp
 '(module
    (letrec ((L.cons.61.7
              (lambda (c.62 tmp.56 tmp.57) (let () (cons tmp.56 tmp.57))))
             (L.fun/error8467.4.8
              (lambda (c.63 oprand0.7) (let () (error 175))))
             (L.fun/empty8465.5.9
              (lambda (c.64 oprand0.8)
                (let ((fun/empty8466.6 (closure-ref c.64 0)))
                  (closure-call fun/empty8466.6 fun/empty8466.6))))
             (L.fun/empty8466.6.10 (lambda (c.65) (let () empty))))
      (cletrec
       ((cons.61 (make-closure L.cons.61.7 2))
        (fun/error8467.4 (make-closure L.fun/error8467.4.8 1))
        (fun/empty8465.5 (make-closure L.fun/empty8465.5.9 1 fun/empty8466.6))
        (fun/empty8466.6 (make-closure L.fun/empty8466.6.10 0)))
       (closure-call
        fun/empty8465.5
        fun/empty8465.5
        (closure-call
         fun/error8467.4
         fun/error8467.4
         (closure-call cons.61 cons.61 79 502)))))))
(check-by-interp
 '(module
    (letrec ((L.-.63.7
              (lambda (c.64 tmp.29 tmp.30)
                (let ()
                  (if (fixnum? tmp.30)
                    (if (fixnum? tmp.29) (unsafe-fx- tmp.29 tmp.30) (error 3))
                    (error 3)))))
             (L.fun/void8484.4.8 (lambda (c.65) (let () (void))))
             (L.fun/ascii-char8485.5.9
              (lambda (c.66 oprand0.8 oprand1.7) (let () #\B)))
             (L.fun/void8483.6.10
              (lambda (c.67 oprand0.10 oprand1.9)
                (let ((fun/void8484.4 (closure-ref c.67 0)))
                  (closure-call fun/void8484.4 fun/void8484.4)))))
      (cletrec
       ((|-.63| (make-closure L.-.63.7 2))
        (fun/void8484.4 (make-closure L.fun/void8484.4.8 0))
        (fun/ascii-char8485.5 (make-closure L.fun/ascii-char8485.5.9 2))
        (fun/void8483.6 (make-closure L.fun/void8483.6.10 2 fun/void8484.4)))
       (closure-call
        fun/void8483.6
        fun/void8483.6
        (closure-call
         fun/ascii-char8485.5
         fun/ascii-char8485.5
         (closure-call |-.63| |-.63| 28 88)
         (closure-call fun/ascii-char8485.5 fun/ascii-char8485.5 88 #\C))
        (if #t 120 66))))))
(check-by-interp
 '(module
    (if (if #t #t #f)
      (if #t (error 18) (error 103))
      (let ((ascii-char0.6 #\p) (fixnum1.5 201) (empty2.4 empty))
        (error 21)))))
(check-by-interp
 '(module
    (letrec ((L.vector?.63.7 (lambda (c.64 tmp.54) (let () (vector? tmp.54))))
             (L.vector-init-loop.12.8
              (lambda (c.65 len.13 i.15 vec.14)
                (let ((vector-init-loop.12 (closure-ref c.65 0)))
                  (if (eq? len.13 i.15)
                    vec.14
                    (begin
                      (unsafe-vector-set! vec.14 i.15 0)
                      (closure-call
                       vector-init-loop.12
                       vector-init-loop.12
                       len.13
                       (unsafe-fx+ i.15 1)
                       vec.14))))))
             (L.make-init-vector.1.9
              (lambda (c.66 tmp.10)
                (let ((vector-init-loop.12 (closure-ref c.66 0)))
                  (let ((tmp.11 (unsafe-make-vector tmp.10)))
                    (closure-call
                     vector-init-loop.12
                     vector-init-loop.12
                     tmp.10
                     0
                     tmp.11)))))
             (L.make-vector.62.10
              (lambda (c.67 tmp.38)
                (let ((make-init-vector.1 (closure-ref c.67 0)))
                  (if (fixnum? tmp.38)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.38)
                    (error 8)))))
             (L.fun/error8492.4.11 (lambda (c.68) (let () (error 77))))
             (L.fun/void8490.5.12 (lambda (c.69) (let () (void))))
             (L.fun/void8491.6.13 (lambda (c.70) (let () (void)))))
      (cletrec
       ((vector?.63 (make-closure L.vector?.63.7 1))
        (vector-init-loop.12
         (make-closure L.vector-init-loop.12.8 3 vector-init-loop.12))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.9 1 vector-init-loop.12))
        (make-vector.62
         (make-closure L.make-vector.62.10 1 make-init-vector.1))
        (fun/error8492.4 (make-closure L.fun/error8492.4.11 0))
        (fun/void8490.5 (make-closure L.fun/void8490.5.12 0))
        (fun/void8491.6 (make-closure L.fun/void8491.6.13 0)))
       (let ((void0.9 (closure-call fun/void8490.5 fun/void8490.5))
             (void1.8 (closure-call fun/void8491.6 fun/void8491.6))
             (boolean2.7
              (closure-call
               vector?.63
               vector?.63
               (closure-call make-vector.62 make-vector.62 8))))
         (closure-call fun/error8492.4 fun/error8492.4))))))
(check-by-interp
 '(module
    (letrec ((L.vector-init-loop.9.7
              (lambda (c.60 len.10 i.12 vec.11)
                (let ((vector-init-loop.9 (closure-ref c.60 0)))
                  (if (eq? len.10 i.12)
                    vec.11
                    (begin
                      (unsafe-vector-set! vec.11 i.12 0)
                      (closure-call
                       vector-init-loop.9
                       vector-init-loop.9
                       len.10
                       (unsafe-fx+ i.12 1)
                       vec.11))))))
             (L.make-init-vector.1.8
              (lambda (c.61 tmp.7)
                (let ((vector-init-loop.9 (closure-ref c.61 0)))
                  (let ((tmp.8 (unsafe-make-vector tmp.7)))
                    (closure-call
                     vector-init-loop.9
                     vector-init-loop.9
                     tmp.7
                     0
                     tmp.8)))))
             (L.make-vector.59.9
              (lambda (c.62 tmp.35)
                (let ((make-init-vector.1 (closure-ref c.62 0)))
                  (if (fixnum? tmp.35)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.35)
                    (error 8)))))
             (L.fun/error8495.4.10
              (lambda (c.63 oprand0.6 oprand1.5) (let () (error 68)))))
      (cletrec
       ((vector-init-loop.9
         (make-closure L.vector-init-loop.9.7 3 vector-init-loop.9))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.8 1 vector-init-loop.9))
        (make-vector.59 (make-closure L.make-vector.59.9 1 make-init-vector.1))
        (fun/error8495.4 (make-closure L.fun/error8495.4.10 2)))
       (if (if #t #t #f)
         (if #t (error 231) (error 156))
         (closure-call
          fun/error8495.4
          fun/error8495.4
          #\c
          (closure-call make-vector.59 make-vector.59 8)))))))
(check-by-interp
 '(module
    (letrec ((L.-.62.7
              (lambda (c.63 tmp.27 tmp.28)
                (let ()
                  (if (fixnum? tmp.28)
                    (if (fixnum? tmp.27) (unsafe-fx- tmp.27 tmp.28) (error 3))
                    (error 3)))))
             (L.empty?.61.8 (lambda (c.64 tmp.48) (let () (empty? tmp.48))))
             (L.fun/error8528.4.9 (lambda (c.65) (let () (error 215))))
             (L.fun/ascii-char8529.5.10 (lambda (c.66) (let () #\W))))
      (cletrec
       ((|-.62| (make-closure L.-.62.7 2))
        (empty?.61 (make-closure L.empty?.61.8 1))
        (fun/error8528.4 (make-closure L.fun/error8528.4.9 0))
        (fun/ascii-char8529.5 (make-closure L.fun/ascii-char8529.5.10 0)))
       (let ((error0.8 (closure-call fun/error8528.4 fun/error8528.4))
             (ascii-char1.7
              (closure-call fun/ascii-char8529.5 fun/ascii-char8529.5))
             (boolean2.6 (closure-call empty?.61 empty?.61 #\I)))
         (closure-call |-.62| |-.62| 186 245))))))
(check-by-interp
 '(module
    (letrec ((L.cons.62.7
              (lambda (c.63 tmp.57 tmp.58) (let () (cons tmp.57 tmp.58))))
             (L.fun/pair8539.4.8
              (lambda (c.64 oprand0.7 oprand1.6) (let () oprand1.6)))
             (L.fun/pair8538.5.9
              (lambda (c.65 oprand0.9 oprand1.8)
                (let ((cons.62 (closure-ref c.65 0)))
                  (closure-call cons.62 cons.62 5 510)))))
      (cletrec
       ((cons.62 (make-closure L.cons.62.7 2))
        (fun/pair8539.4 (make-closure L.fun/pair8539.4.8 2))
        (fun/pair8538.5 (make-closure L.fun/pair8538.5.9 2 cons.62)))
       (if (if #t #f #f)
         (closure-call fun/pair8538.5 fun/pair8538.5 247 #f)
         (closure-call
          fun/pair8539.4
          fun/pair8539.4
          #f
          (closure-call cons.62 cons.62 28 345)))))))
(check-by-interp
 '(module
    (letrec ((L.cons.63.7
              (lambda (c.64 tmp.57 tmp.58) (let () (cons tmp.57 tmp.58))))
             (L.vector-init-loop.12.8
              (lambda (c.65 len.13 i.15 vec.14)
                (let ((vector-init-loop.12 (closure-ref c.65 0)))
                  (if (eq? len.13 i.15)
                    vec.14
                    (begin
                      (unsafe-vector-set! vec.14 i.15 0)
                      (closure-call
                       vector-init-loop.12
                       vector-init-loop.12
                       len.13
                       (unsafe-fx+ i.15 1)
                       vec.14))))))
             (L.make-init-vector.1.9
              (lambda (c.66 tmp.10)
                (let ((vector-init-loop.12 (closure-ref c.66 0)))
                  (let ((tmp.11 (unsafe-make-vector tmp.10)))
                    (closure-call
                     vector-init-loop.12
                     vector-init-loop.12
                     tmp.10
                     0
                     tmp.11)))))
             (L.make-vector.62.10
              (lambda (c.67 tmp.38)
                (let ((make-init-vector.1 (closure-ref c.67 0)))
                  (if (fixnum? tmp.38)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.38)
                    (error 8)))))
             (L.fun/ascii-char8543.4.11
              (lambda (c.68 oprand0.7 oprand1.6) (let () #\x)))
             (L.fun/boolean8542.5.12
              (lambda (c.69 oprand0.9 oprand1.8) (let () #t))))
      (cletrec
       ((cons.63 (make-closure L.cons.63.7 2))
        (vector-init-loop.12
         (make-closure L.vector-init-loop.12.8 3 vector-init-loop.12))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.9 1 vector-init-loop.12))
        (make-vector.62
         (make-closure L.make-vector.62.10 1 make-init-vector.1))
        (fun/ascii-char8543.4 (make-closure L.fun/ascii-char8543.4.11 2))
        (fun/boolean8542.5 (make-closure L.fun/boolean8542.5.12 2)))
       (if (closure-call
            fun/boolean8542.5
            fun/boolean8542.5
            #\]
            (closure-call make-vector.62 make-vector.62 8))
         (closure-call
          fun/ascii-char8543.4
          fun/ascii-char8543.4
          (closure-call cons.63 cons.63 180 382)
          229)
         (if #f #\^ #\i))))))
(check-by-interp
 '(module
    (letrec ((L.*.66.7
              (lambda (c.67 tmp.25 tmp.26)
                (let ()
                  (if (fixnum? tmp.26)
                    (if (fixnum? tmp.25) (unsafe-fx* tmp.25 tmp.26) (error 1))
                    (error 1)))))
             (L.+.65.8
              (lambda (c.68 tmp.27 tmp.28)
                (let ()
                  (if (fixnum? tmp.28)
                    (if (fixnum? tmp.27) (unsafe-fx+ tmp.27 tmp.28) (error 2))
                    (error 2)))))
             (L.-.64.9
              (lambda (c.69 tmp.29 tmp.30)
                (let ()
                  (if (fixnum? tmp.30)
                    (if (fixnum? tmp.29) (unsafe-fx- tmp.29 tmp.30) (error 3))
                    (error 3)))))
             (L.vector-init-loop.13.10
              (lambda (c.70 len.14 i.16 vec.15)
                (let ((vector-init-loop.13 (closure-ref c.70 0)))
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
             (L.make-init-vector.1.11
              (lambda (c.71 tmp.11)
                (let ((vector-init-loop.13 (closure-ref c.71 0)))
                  (let ((tmp.12 (unsafe-make-vector tmp.11)))
                    (closure-call
                     vector-init-loop.13
                     vector-init-loop.13
                     tmp.11
                     0
                     tmp.12)))))
             (L.make-vector.63.12
              (lambda (c.72 tmp.39)
                (let ((make-init-vector.1 (closure-ref c.72 0)))
                  (if (fixnum? tmp.39)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.39)
                    (error 8)))))
             (L.fun/empty8591.4.13 (lambda (c.73) (let () empty)))
             (L.fun/vector8589.5.14
              (lambda (c.74)
                (let ((make-vector.63 (closure-ref c.74 0)))
                  (closure-call make-vector.63 make-vector.63 8))))
             (L.fun/ascii-char8590.6.15 (lambda (c.75) (let () #\D))))
      (cletrec
       ((*.66 (make-closure L.*.66.7 2))
        (|+.65| (make-closure L.+.65.8 2))
        (|-.64| (make-closure L.-.64.9 2))
        (vector-init-loop.13
         (make-closure L.vector-init-loop.13.10 3 vector-init-loop.13))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.11 1 vector-init-loop.13))
        (make-vector.63
         (make-closure L.make-vector.63.12 1 make-init-vector.1))
        (fun/empty8591.4 (make-closure L.fun/empty8591.4.13 0))
        (fun/vector8589.5
         (make-closure L.fun/vector8589.5.14 0 make-vector.63))
        (fun/ascii-char8590.6 (make-closure L.fun/ascii-char8590.6.15 0)))
       (let ((fixnum0.10
              (closure-call
               |-.64|
               |-.64|
               (closure-call |-.64| |-.64| 215 72)
               (closure-call |-.64| |-.64| 219 173)))
             (vector1.9 (closure-call fun/vector8589.5 fun/vector8589.5))
             (fixnum2.8
              (closure-call
               |+.65|
               |+.65|
               (closure-call |+.65| |+.65| 93 220)
               (closure-call *.66 *.66 170 131)))
             (ascii-char3.7
              (closure-call fun/ascii-char8590.6 fun/ascii-char8590.6)))
         (closure-call fun/empty8591.4 fun/empty8591.4))))))
(check-by-interp
 '(module
    (letrec ((L.cons.56.7
              (lambda (c.57 tmp.51 tmp.52) (let () (cons tmp.51 tmp.52)))))
      (cletrec
       ((cons.56 (make-closure L.cons.56.7 2)))
       (if (if #t #t #f)
         (if #t
           (closure-call cons.56 cons.56 51 420)
           (closure-call cons.56 cons.56 40 364))
         (if #t
           (closure-call cons.56 cons.56 241 350)
           (closure-call cons.56 cons.56 112 345)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8689.4.7 (lambda (c.66) (let () #\I)))
             (L.fun/error8691.5.8 (lambda (c.67) (let () (error 124))))
             (L.fun/empty8692.6.9 (lambda (c.68) (let () empty)))
             (L.fun/ascii-char8688.7.10 (lambda (c.69) (let () #\j)))
             (L.fun/void8690.8.11 (lambda (c.70) (let () (void)))))
      (cletrec
       ((fun/ascii-char8689.4 (make-closure L.fun/ascii-char8689.4.7 0))
        (fun/error8691.5 (make-closure L.fun/error8691.5.8 0))
        (fun/empty8692.6 (make-closure L.fun/empty8692.6.9 0))
        (fun/ascii-char8688.7 (make-closure L.fun/ascii-char8688.7.10 0))
        (fun/void8690.8 (make-closure L.fun/void8690.8.11 0)))
       (let ((ascii-char0.12
              (closure-call fun/ascii-char8688.7 fun/ascii-char8688.7))
             (ascii-char1.11
              (closure-call fun/ascii-char8689.4 fun/ascii-char8689.4))
             (void2.10 (closure-call fun/void8690.8 fun/void8690.8))
             (procedure3.9
              (letrec ((L.lam.65.12
                        (lambda (c.71)
                          (let ((fun/error8691.5 (closure-ref c.71 0)))
                            (closure-call fun/error8691.5 fun/error8691.5)))))
                (cletrec
                 ((lam.65 (make-closure L.lam.65.12 0 fun/error8691.5)))
                 lam.65))))
         (closure-call fun/empty8692.6 fun/empty8692.6))))))
(check-by-interp
 '(module
    (letrec ((L.boolean?.67.7
              (lambda (c.68 tmp.51) (let () (boolean? tmp.51))))
             (L.vector?.66.8 (lambda (c.69 tmp.57) (let () (vector? tmp.57))))
             (L.vector-init-loop.15.9
              (lambda (c.70 len.16 i.18 vec.17)
                (let ((vector-init-loop.15 (closure-ref c.70 0)))
                  (if (eq? len.16 i.18)
                    vec.17
                    (begin
                      (unsafe-vector-set! vec.17 i.18 0)
                      (closure-call
                       vector-init-loop.15
                       vector-init-loop.15
                       len.16
                       (unsafe-fx+ i.18 1)
                       vec.17))))))
             (L.make-init-vector.1.10
              (lambda (c.71 tmp.13)
                (let ((vector-init-loop.15 (closure-ref c.71 0)))
                  (let ((tmp.14 (unsafe-make-vector tmp.13)))
                    (closure-call
                     vector-init-loop.15
                     vector-init-loop.15
                     tmp.13
                     0
                     tmp.14)))))
             (L.make-vector.65.11
              (lambda (c.72 tmp.41)
                (let ((make-init-vector.1 (closure-ref c.72 0)))
                  (if (fixnum? tmp.41)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.41)
                    (error 8)))))
             (L.fun/vector8765.4.12
              (lambda (c.73)
                (let ((make-vector.65 (closure-ref c.73 0)))
                  (closure-call make-vector.65 make-vector.65 8))))
             (L.fun/ascii-char8761.5.13 (lambda (c.74) (let () #\k)))
             (L.fun/any8762.6.14 (lambda (c.75) (let () (void))))
             (L.fun/void8763.7.15 (lambda (c.76) (let () (void))))
             (L.fun/any8764.8.16 (lambda (c.77) (let () (error 55)))))
      (cletrec
       ((boolean?.67 (make-closure L.boolean?.67.7 1))
        (vector?.66 (make-closure L.vector?.66.8 1))
        (vector-init-loop.15
         (make-closure L.vector-init-loop.15.9 3 vector-init-loop.15))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.10 1 vector-init-loop.15))
        (make-vector.65
         (make-closure L.make-vector.65.11 1 make-init-vector.1))
        (fun/vector8765.4
         (make-closure L.fun/vector8765.4.12 0 make-vector.65))
        (fun/ascii-char8761.5 (make-closure L.fun/ascii-char8761.5.13 0))
        (fun/any8762.6 (make-closure L.fun/any8762.6.14 0))
        (fun/void8763.7 (make-closure L.fun/void8763.7.15 0))
        (fun/any8764.8 (make-closure L.fun/any8764.8.16 0)))
       (let ((ascii-char0.12
              (closure-call fun/ascii-char8761.5 fun/ascii-char8761.5))
             (boolean1.11
              (closure-call
               vector?.66
               vector?.66
               (closure-call fun/any8762.6 fun/any8762.6)))
             (void2.10 (closure-call fun/void8763.7 fun/void8763.7))
             (boolean3.9
              (closure-call
               boolean?.67
               boolean?.67
               (closure-call fun/any8764.8 fun/any8764.8))))
         (closure-call fun/vector8765.4 fun/vector8765.4))))))
(check-by-interp
 '(module
    (letrec ((L.*.109.7
              (lambda (c.111 tmp.67 tmp.68)
                (let ()
                  (if (fixnum? tmp.68)
                    (if (fixnum? tmp.67) (unsafe-fx* tmp.67 tmp.68) (error 1))
                    (error 1)))))
             (L.>.108.8
              (lambda (c.112 tmp.77 tmp.78)
                (let ()
                  (if (fixnum? tmp.78)
                    (if (fixnum? tmp.77) (unsafe-fx> tmp.77 tmp.78) (error 6))
                    (error 6)))))
             (L.ascii-char?.107.9
              (lambda (c.113 tmp.94) (let () (ascii-char? tmp.94))))
             (L.vector-init-loop.55.10
              (lambda (c.114 len.56 i.58 vec.57)
                (let ((vector-init-loop.55 (closure-ref c.114 0)))
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
             (L.make-init-vector.1.11
              (lambda (c.115 tmp.53)
                (let ((vector-init-loop.55 (closure-ref c.115 0)))
                  (let ((tmp.54 (unsafe-make-vector tmp.53)))
                    (closure-call
                     vector-init-loop.55
                     vector-init-loop.55
                     tmp.53
                     0
                     tmp.54)))))
             (L.make-vector.106.12
              (lambda (c.116 tmp.81)
                (let ((make-init-vector.1 (closure-ref c.116 0)))
                  (if (fixnum? tmp.81)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.81)
                    (error 8)))))
             (L.cons.105.13
              (lambda (c.117 tmp.100 tmp.101) (let () (cons tmp.100 tmp.101))))
             (L.fun/fixnum8791.4.14
              (lambda (c.118 oprand0.19 oprand1.18 oprand2.17)
                (let ((fun/fixnum8792.13 (closure-ref c.118 0)))
                  (closure-call fun/fixnum8792.13 fun/fixnum8792.13))))
             (L.fun/pair8797.5.15
              (lambda (c.119 oprand0.22 oprand1.21 oprand2.20)
                (let ((fun/pair8798.16 (closure-ref c.119 0)))
                  (closure-call fun/pair8798.16 fun/pair8798.16))))
             (L.fun/error8799.6.16
              (lambda (c.120 oprand0.25 oprand1.24 oprand2.23)
                (let () (error 158))))
             (L.fun/pair8789.7.17
              (lambda (c.121)
                (let ((fun/pair8790.10 (closure-ref c.121 0)))
                  (closure-call fun/pair8790.10 fun/pair8790.10))))
             (L.fun/pair8788.8.18
              (lambda (c.122 oprand0.28 oprand1.27 oprand2.26)
                (let ((fun/pair8789.7 (closure-ref c.122 0)))
                  (closure-call fun/pair8789.7 fun/pair8789.7))))
             (L.fun/empty8793.9.19
              (lambda (c.123 oprand0.31 oprand1.30 oprand2.29) (let () empty)))
             (L.fun/pair8790.10.20
              (lambda (c.124)
                (let ((cons.105 (closure-ref c.124 0)))
                  (closure-call cons.105 cons.105 25 485))))
             (L.fun/fixnum8796.11.21
              (lambda (c.125 oprand0.34 oprand1.33 oprand2.32) (let () 254)))
             (L.fun/ascii-char8795.12.22 (lambda (c.126) (let () #\K)))
             (L.fun/fixnum8792.13.23 (lambda (c.127) (let () 185)))
             (L.fun/error8800.14.24
              (lambda (c.128 oprand0.37 oprand1.36 oprand2.35)
                (let () oprand2.35)))
             (L.fun/ascii-char8794.15.25
              (lambda (c.129 oprand0.40 oprand1.39 oprand2.38)
                (let ((fun/ascii-char8795.12 (closure-ref c.129 0)))
                  (closure-call fun/ascii-char8795.12 fun/ascii-char8795.12))))
             (L.fun/pair8798.16.26
              (lambda (c.130)
                (let ((cons.105 (closure-ref c.130 0)))
                  (closure-call cons.105 cons.105 24 277)))))
      (cletrec
       ((*.109 (make-closure L.*.109.7 2))
        (>.108 (make-closure L.>.108.8 2))
        (ascii-char?.107 (make-closure L.ascii-char?.107.9 1))
        (vector-init-loop.55
         (make-closure L.vector-init-loop.55.10 3 vector-init-loop.55))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.11 1 vector-init-loop.55))
        (make-vector.106
         (make-closure L.make-vector.106.12 1 make-init-vector.1))
        (cons.105 (make-closure L.cons.105.13 2))
        (fun/fixnum8791.4
         (make-closure L.fun/fixnum8791.4.14 3 fun/fixnum8792.13))
        (fun/pair8797.5 (make-closure L.fun/pair8797.5.15 3 fun/pair8798.16))
        (fun/error8799.6 (make-closure L.fun/error8799.6.16 3))
        (fun/pair8789.7 (make-closure L.fun/pair8789.7.17 0 fun/pair8790.10))
        (fun/pair8788.8 (make-closure L.fun/pair8788.8.18 3 fun/pair8789.7))
        (fun/empty8793.9 (make-closure L.fun/empty8793.9.19 3))
        (fun/pair8790.10 (make-closure L.fun/pair8790.10.20 0 cons.105))
        (fun/fixnum8796.11 (make-closure L.fun/fixnum8796.11.21 3))
        (fun/ascii-char8795.12 (make-closure L.fun/ascii-char8795.12.22 0))
        (fun/fixnum8792.13 (make-closure L.fun/fixnum8792.13.23 0))
        (fun/error8800.14 (make-closure L.fun/error8800.14.24 3))
        (fun/ascii-char8794.15
         (make-closure L.fun/ascii-char8794.15.25 3 fun/ascii-char8795.12))
        (fun/pair8798.16 (make-closure L.fun/pair8798.16.26 0 cons.105)))
       (closure-call
        fun/pair8788.8
        fun/pair8788.8
        (closure-call
         >.108
         >.108
         (closure-call
          fun/fixnum8791.4
          fun/fixnum8791.4
          (closure-call fun/empty8793.9 fun/empty8793.9 250 #t (error 11))
          (if #f empty empty)
          (closure-call
           ascii-char?.107
           ascii-char?.107
           (closure-call make-vector.106 make-vector.106 8)))
         (if #t 182 209))
        (closure-call
         fun/ascii-char8794.15
         fun/ascii-char8794.15
         (closure-call
          *.109
          *.109
          (let ((error0.44 (error 211))
                (fixnum1.43 224)
                (vector2.42 (closure-call make-vector.106 make-vector.106 8))
                (procedure3.41
                 (letrec ((L.lam.110.27 (lambda (c.131) (let () #\X))))
                   (cletrec
                    ((lam.110 (make-closure L.lam.110.27 0)))
                    lam.110))))
            226)
          (closure-call
           fun/fixnum8796.11
           fun/fixnum8796.11
           174
           (error 224)
           (void)))
         (closure-call
          fun/pair8797.5
          fun/pair8797.5
          (closure-call fun/error8799.6 fun/error8799.6 empty 6 (void))
          (if #t (void) (void))
          (closure-call
           fun/ascii-char8794.15
           fun/ascii-char8794.15
           79
           (closure-call cons.105 cons.105 43 357)
           (closure-call make-vector.106 make-vector.106 8)))
         (if #f
           (closure-call make-vector.106 make-vector.106 8)
           (closure-call make-vector.106 make-vector.106 8)))
        (closure-call
         fun/error8800.14
         fun/error8800.14
         (if #t
           (closure-call make-vector.106 make-vector.106 8)
           (closure-call make-vector.106 make-vector.106 8))
         (let ((vector0.48 (closure-call make-vector.106 make-vector.106 8))
               (vector1.47 (closure-call make-vector.106 make-vector.106 8))
               (ascii-char2.46 #\])
               (vector3.45 (closure-call make-vector.106 make-vector.106 8)))
           (void))
         (let ((boolean0.52 #t)
               (void1.51 (void))
               (boolean2.50 #f)
               (boolean3.49 #f))
           (error 220))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8923.4.7
              (lambda (c.73)
                (let ((fun/error8924.14 (closure-ref c.73 0)))
                  (closure-call fun/error8924.14 fun/error8924.14))))
             (L.fun/ascii-char8926.5.8 (lambda (c.74) (let () #\x)))
             (L.fun/empty8929.6.9
              (lambda (c.75)
                (let ((fun/empty8930.11 (closure-ref c.75 0)))
                  (closure-call fun/empty8930.11 fun/empty8930.11))))
             (L.fun/void8927.7.10
              (lambda (c.76)
                (let ((fun/void8928.15 (closure-ref c.76 0)))
                  (closure-call fun/void8928.15 fun/void8928.15))))
             (L.fun/ascii-char8921.8.11
              (lambda (c.77)
                (let ((fun/ascii-char8922.10 (closure-ref c.77 0)))
                  (closure-call fun/ascii-char8922.10 fun/ascii-char8922.10))))
             (L.fun/error8919.9.12
              (lambda (c.78)
                (let ((fun/error8920.12 (closure-ref c.78 0)))
                  (closure-call fun/error8920.12 fun/error8920.12))))
             (L.fun/ascii-char8922.10.13 (lambda (c.79) (let () #\k)))
             (L.fun/empty8930.11.14 (lambda (c.80) (let () empty)))
             (L.fun/error8920.12.15 (lambda (c.81) (let () (error 185))))
             (L.fun/ascii-char8925.13.16
              (lambda (c.82)
                (let ((fun/ascii-char8926.5 (closure-ref c.82 0)))
                  (closure-call fun/ascii-char8926.5 fun/ascii-char8926.5))))
             (L.fun/error8924.14.17 (lambda (c.83) (let () (error 130))))
             (L.fun/void8928.15.18 (lambda (c.84) (let () (void)))))
      (cletrec
       ((fun/error8923.4 (make-closure L.fun/error8923.4.7 0 fun/error8924.14))
        (fun/ascii-char8926.5 (make-closure L.fun/ascii-char8926.5.8 0))
        (fun/empty8929.6 (make-closure L.fun/empty8929.6.9 0 fun/empty8930.11))
        (fun/void8927.7 (make-closure L.fun/void8927.7.10 0 fun/void8928.15))
        (fun/ascii-char8921.8
         (make-closure L.fun/ascii-char8921.8.11 0 fun/ascii-char8922.10))
        (fun/error8919.9
         (make-closure L.fun/error8919.9.12 0 fun/error8920.12))
        (fun/ascii-char8922.10 (make-closure L.fun/ascii-char8922.10.13 0))
        (fun/empty8930.11 (make-closure L.fun/empty8930.11.14 0))
        (fun/error8920.12 (make-closure L.fun/error8920.12.15 0))
        (fun/ascii-char8925.13
         (make-closure L.fun/ascii-char8925.13.16 0 fun/ascii-char8926.5))
        (fun/error8924.14 (make-closure L.fun/error8924.14.17 0))
        (fun/void8928.15 (make-closure L.fun/void8928.15.18 0)))
       (let ((error0.20 (closure-call fun/error8919.9 fun/error8919.9))
             (ascii-char1.19
              (closure-call fun/ascii-char8921.8 fun/ascii-char8921.8))
             (error2.18 (closure-call fun/error8923.4 fun/error8923.4))
             (ascii-char3.17
              (closure-call fun/ascii-char8925.13 fun/ascii-char8925.13))
             (void4.16 (closure-call fun/void8927.7 fun/void8927.7)))
         (closure-call fun/empty8929.6 fun/empty8929.6))))))
(check-by-interp
 '(module
    (letrec ((L.>=.71.7
              (lambda (c.73 tmp.41 tmp.42)
                (let ()
                  (if (fixnum? tmp.42)
                    (if (fixnum? tmp.41) (unsafe-fx>= tmp.41 tmp.42) (error 7))
                    (error 7)))))
             (L.<=.70.8
              (lambda (c.74 tmp.37 tmp.38)
                (let ()
                  (if (fixnum? tmp.38)
                    (if (fixnum? tmp.37) (unsafe-fx<= tmp.37 tmp.38) (error 5))
                    (error 5)))))
             (L.+.69.9
              (lambda (c.75 tmp.31 tmp.32)
                (let ()
                  (if (fixnum? tmp.32)
                    (if (fixnum? tmp.31) (unsafe-fx+ tmp.31 tmp.32) (error 2))
                    (error 2)))))
             (L.*.68.10
              (lambda (c.76 tmp.29 tmp.30)
                (let ()
                  (if (fixnum? tmp.30)
                    (if (fixnum? tmp.29) (unsafe-fx* tmp.29 tmp.30) (error 1))
                    (error 1)))))
             (L.-.67.11
              (lambda (c.77 tmp.33 tmp.34)
                (let ()
                  (if (fixnum? tmp.34)
                    (if (fixnum? tmp.33) (unsafe-fx- tmp.33 tmp.34) (error 3))
                    (error 3)))))
             (L.fun/empty9121.4.12 (lambda (c.78) (let () empty)))
             (L.fun/ascii-char9123.5.13 (lambda (c.79) (let () #\s)))
             (L.fun/empty9120.6.14
              (lambda (c.80)
                (let ((fun/empty9121.4 (closure-ref c.80 0)))
                  (closure-call fun/empty9121.4 fun/empty9121.4))))
             (L.fun/void9119.7.15 (lambda (c.81) (let () (void))))
             (L.fun/ascii-char9122.8.16
              (lambda (c.82)
                (let ((fun/ascii-char9123.5 (closure-ref c.82 0)))
                  (closure-call fun/ascii-char9123.5 fun/ascii-char9123.5))))
             (L.fun/void9118.9.17
              (lambda (c.83)
                (let ((fun/void9119.7 (closure-ref c.83 0)))
                  (closure-call fun/void9119.7 fun/void9119.7)))))
      (cletrec
       ((>=.71 (make-closure L.>=.71.7 2))
        (<=.70 (make-closure L.<=.70.8 2))
        (|+.69| (make-closure L.+.69.9 2))
        (*.68 (make-closure L.*.68.10 2))
        (|-.67| (make-closure L.-.67.11 2))
        (fun/empty9121.4 (make-closure L.fun/empty9121.4.12 0))
        (fun/ascii-char9123.5 (make-closure L.fun/ascii-char9123.5.13 0))
        (fun/empty9120.6 (make-closure L.fun/empty9120.6.14 0 fun/empty9121.4))
        (fun/void9119.7 (make-closure L.fun/void9119.7.15 0))
        (fun/ascii-char9122.8
         (make-closure L.fun/ascii-char9122.8.16 0 fun/ascii-char9123.5))
        (fun/void9118.9 (make-closure L.fun/void9118.9.17 0 fun/void9119.7)))
       (let ((void0.14 (closure-call fun/void9118.9 fun/void9118.9))
             (fixnum1.13
              (closure-call
               *.68
               *.68
               (closure-call
                *.68
                *.68
                (closure-call |-.67| |-.67| 25 226)
                (closure-call |-.67| |-.67| 159 56))
               (closure-call
                |-.67|
                |-.67|
                (closure-call *.68 *.68 192 122)
                (closure-call |-.67| |-.67| 47 86))))
             (empty2.12 (closure-call fun/empty9120.6 fun/empty9120.6))
             (procedure3.11
              (letrec ((L.lam.72.18
                        (lambda (c.84)
                          (let ((|-.67| (closure-ref c.84 0))
                                (|+.69| (closure-ref c.84 1))
                                (<=.70 (closure-ref c.84 2)))
                            (closure-call
                             <=.70
                             <=.70
                             (closure-call
                              |+.69|
                              |+.69|
                              (closure-call |+.69| |+.69| 101 114)
                              (closure-call |+.69| |+.69| 88 54))
                             (closure-call
                              |+.69|
                              |+.69|
                              (closure-call |+.69| |+.69| 59 2)
                              (closure-call |-.67| |-.67| 47 76)))))))
                (cletrec
                 ((lam.72 (make-closure L.lam.72.18 0 |-.67| |+.69| <=.70)))
                 lam.72)))
             (ascii-char4.10
              (closure-call fun/ascii-char9122.8 fun/ascii-char9122.8)))
         (closure-call
          >=.71
          >=.71
          (closure-call
           |-.67|
           |-.67|
           (closure-call |+.69| |+.69| 68 167)
           (closure-call |+.69| |+.69| 167 157))
          (closure-call
           |-.67|
           |-.67|
           (closure-call |-.67| |-.67| 30 155)
           (closure-call |+.69| |+.69| 28 101))))))))
(check-by-interp
 '(module
    (letrec ((L.<=.78.7
              (lambda (c.81 tmp.46 tmp.47)
                (let ()
                  (if (fixnum? tmp.47)
                    (if (fixnum? tmp.46) (unsafe-fx<= tmp.46 tmp.47) (error 5))
                    (error 5)))))
             (L.vector?.77.8 (lambda (c.82 tmp.68) (let () (vector? tmp.68))))
             (L.vector-init-loop.26.9
              (lambda (c.83 len.27 i.29 vec.28)
                (let ((vector-init-loop.26 (closure-ref c.83 0)))
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
             (L.make-init-vector.1.10
              (lambda (c.84 tmp.24)
                (let ((vector-init-loop.26 (closure-ref c.84 0)))
                  (let ((tmp.25 (unsafe-make-vector tmp.24)))
                    (closure-call
                     vector-init-loop.26
                     vector-init-loop.26
                     tmp.24
                     0
                     tmp.25)))))
             (L.make-vector.76.11
              (lambda (c.85 tmp.52)
                (let ((make-init-vector.1 (closure-ref c.85 0)))
                  (if (fixnum? tmp.52)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.52)
                    (error 8)))))
             (L.fun/error9127.4.12 (lambda (c.86) (let () (error 167))))
             (L.fun/ascii-char9131.5.13 (lambda (c.87) (let () #\o)))
             (L.fun/empty9128.6.14 (lambda (c.88) (let () empty)))
             (L.fun/ascii-char9132.7.15 (lambda (c.89) (let () #\p)))
             (L.fun/ascii-char9130.8.16 (lambda (c.90) (let () #\p)))
             (L.fun/vector9133.9.17
              (lambda (c.91)
                (let ((make-vector.76 (closure-ref c.91 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/ascii-char9129.10.18 (lambda (c.92) (let () #\P)))
             (L.fun/vector9134.11.19
              (lambda (c.93)
                (let ((make-vector.76 (closure-ref c.93 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/void9126.12.20 (lambda (c.94) (let () (void))))
             (L.fun/ascii-char9135.13.21 (lambda (c.95) (let () #\u))))
      (cletrec
       ((<=.78 (make-closure L.<=.78.7 2))
        (vector?.77 (make-closure L.vector?.77.8 1))
        (vector-init-loop.26
         (make-closure L.vector-init-loop.26.9 3 vector-init-loop.26))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.10 1 vector-init-loop.26))
        (make-vector.76
         (make-closure L.make-vector.76.11 1 make-init-vector.1))
        (fun/error9127.4 (make-closure L.fun/error9127.4.12 0))
        (fun/ascii-char9131.5 (make-closure L.fun/ascii-char9131.5.13 0))
        (fun/empty9128.6 (make-closure L.fun/empty9128.6.14 0))
        (fun/ascii-char9132.7 (make-closure L.fun/ascii-char9132.7.15 0))
        (fun/ascii-char9130.8 (make-closure L.fun/ascii-char9130.8.16 0))
        (fun/vector9133.9
         (make-closure L.fun/vector9133.9.17 0 make-vector.76))
        (fun/ascii-char9129.10 (make-closure L.fun/ascii-char9129.10.18 0))
        (fun/vector9134.11
         (make-closure L.fun/vector9134.11.19 0 make-vector.76))
        (fun/void9126.12 (make-closure L.fun/void9126.12.20 0))
        (fun/ascii-char9135.13 (make-closure L.fun/ascii-char9135.13.21 0)))
       (if (closure-call vector?.77 vector?.77 (if #f empty (void)))
         (let ((procedure0.18
                (letrec ((L.lam.79.22
                          (lambda (c.96)
                            (let ((fun/void9126.12 (closure-ref c.96 0)))
                              (closure-call
                               fun/void9126.12
                               fun/void9126.12)))))
                  (cletrec
                   ((lam.79 (make-closure L.lam.79.22 0 fun/void9126.12)))
                   lam.79)))
               (error1.17 (closure-call fun/error9127.4 fun/error9127.4))
               (empty2.16 (closure-call fun/empty9128.6 fun/empty9128.6))
               (ascii-char3.15
                (closure-call fun/ascii-char9129.10 fun/ascii-char9129.10))
               (ascii-char4.14
                (closure-call fun/ascii-char9130.8 fun/ascii-char9130.8)))
           (closure-call fun/ascii-char9131.5 fun/ascii-char9131.5))
         (let ((procedure0.23
                (letrec ((L.lam.80.23
                          (lambda (c.97)
                            (let ((fun/ascii-char9132.7 (closure-ref c.97 0)))
                              (closure-call
                               fun/ascii-char9132.7
                               fun/ascii-char9132.7)))))
                  (cletrec
                   ((lam.80 (make-closure L.lam.80.23 0 fun/ascii-char9132.7)))
                   lam.80)))
               (vector1.22 (closure-call fun/vector9133.9 fun/vector9133.9))
               (vector2.21 (closure-call fun/vector9134.11 fun/vector9134.11))
               (ascii-char3.20
                (closure-call fun/ascii-char9135.13 fun/ascii-char9135.13))
               (boolean4.19 (closure-call <=.78 <=.78 42 157)))
           (if (procedure? procedure0.23)
             (if (eq? (unsafe-procedure-arity procedure0.23) 0)
               (closure-call procedure0.23 procedure0.23)
               (error 42))
             (error 43))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char9194.4.7 (lambda (c.74) (let () #\f)))
             (L.fun/void9197.5.8
              (lambda (c.75)
                (let ((fun/void9198.8 (closure-ref c.75 0)))
                  (closure-call fun/void9198.8 fun/void9198.8))))
             (L.fun/error9195.6.9
              (lambda (c.76)
                (let ((fun/error9196.13 (closure-ref c.76 0)))
                  (closure-call fun/error9196.13 fun/error9196.13))))
             (L.fun/empty9199.7.10
              (lambda (c.77)
                (let ((fun/empty9200.10 (closure-ref c.77 0)))
                  (closure-call fun/empty9200.10 fun/empty9200.10))))
             (L.fun/void9198.8.11 (lambda (c.78) (let () (void))))
             (L.fun/ascii-char9193.9.12
              (lambda (c.79)
                (let ((fun/ascii-char9194.4 (closure-ref c.79 0)))
                  (closure-call fun/ascii-char9194.4 fun/ascii-char9194.4))))
             (L.fun/empty9200.10.13 (lambda (c.80) (let () empty)))
             (L.fun/void9202.11.14 (lambda (c.81) (let () (void))))
             (L.fun/error9191.12.15
              (lambda (c.82)
                (let ((fun/error9192.14 (closure-ref c.82 0)))
                  (closure-call fun/error9192.14 fun/error9192.14))))
             (L.fun/error9196.13.16 (lambda (c.83) (let () (error 198))))
             (L.fun/error9192.14.17 (lambda (c.84) (let () (error 213))))
             (L.fun/void9201.15.18
              (lambda (c.85)
                (let ((fun/void9202.11 (closure-ref c.85 0)))
                  (closure-call fun/void9202.11 fun/void9202.11)))))
      (cletrec
       ((fun/ascii-char9194.4 (make-closure L.fun/ascii-char9194.4.7 0))
        (fun/void9197.5 (make-closure L.fun/void9197.5.8 0 fun/void9198.8))
        (fun/error9195.6 (make-closure L.fun/error9195.6.9 0 fun/error9196.13))
        (fun/empty9199.7
         (make-closure L.fun/empty9199.7.10 0 fun/empty9200.10))
        (fun/void9198.8 (make-closure L.fun/void9198.8.11 0))
        (fun/ascii-char9193.9
         (make-closure L.fun/ascii-char9193.9.12 0 fun/ascii-char9194.4))
        (fun/empty9200.10 (make-closure L.fun/empty9200.10.13 0))
        (fun/void9202.11 (make-closure L.fun/void9202.11.14 0))
        (fun/error9191.12
         (make-closure L.fun/error9191.12.15 0 fun/error9192.14))
        (fun/error9196.13 (make-closure L.fun/error9196.13.16 0))
        (fun/error9192.14 (make-closure L.fun/error9192.14.17 0))
        (fun/void9201.15
         (make-closure L.fun/void9201.15.18 0 fun/void9202.11)))
       (let ((procedure0.20
              (letrec ((L.lam.73.19
                        (lambda (c.86)
                          (let ((fun/error9191.12 (closure-ref c.86 0)))
                            (closure-call
                             fun/error9191.12
                             fun/error9191.12)))))
                (cletrec
                 ((lam.73 (make-closure L.lam.73.19 0 fun/error9191.12)))
                 lam.73)))
             (ascii-char1.19
              (closure-call fun/ascii-char9193.9 fun/ascii-char9193.9))
             (error2.18 (closure-call fun/error9195.6 fun/error9195.6))
             (void3.17 (closure-call fun/void9197.5 fun/void9197.5))
             (empty4.16 (closure-call fun/empty9199.7 fun/empty9199.7)))
         (closure-call fun/void9201.15 fun/void9201.15))))))
(check-by-interp
 '(module
    (letrec ((L.-.74.7
              (lambda (c.76 tmp.37 tmp.38)
                (let ()
                  (if (fixnum? tmp.38)
                    (if (fixnum? tmp.37) (unsafe-fx- tmp.37 tmp.38) (error 3))
                    (error 3)))))
             (L.*.73.8
              (lambda (c.77 tmp.33 tmp.34)
                (let ()
                  (if (fixnum? tmp.34)
                    (if (fixnum? tmp.33) (unsafe-fx* tmp.33 tmp.34) (error 1))
                    (error 1)))))
             (L.+.72.9
              (lambda (c.78 tmp.35 tmp.36)
                (let ()
                  (if (fixnum? tmp.36)
                    (if (fixnum? tmp.35) (unsafe-fx+ tmp.35 tmp.36) (error 2))
                    (error 2)))))
             (L.vector-init-loop.21.10
              (lambda (c.79 len.22 i.24 vec.23)
                (let ((vector-init-loop.21 (closure-ref c.79 0)))
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
             (L.make-init-vector.1.11
              (lambda (c.80 tmp.19)
                (let ((vector-init-loop.21 (closure-ref c.80 0)))
                  (let ((tmp.20 (unsafe-make-vector tmp.19)))
                    (closure-call
                     vector-init-loop.21
                     vector-init-loop.21
                     tmp.19
                     0
                     tmp.20)))))
             (L.make-vector.71.12
              (lambda (c.81 tmp.47)
                (let ((make-init-vector.1 (closure-ref c.81 0)))
                  (if (fixnum? tmp.47)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.47)
                    (error 8)))))
             (L.fun/ascii-char9893.4.13 (lambda (c.82) (let () #\Q)))
             (L.fun/void9890.5.14
              (lambda (c.83)
                (let ((fun/void9891.9 (closure-ref c.83 0)))
                  (closure-call fun/void9891.9 fun/void9891.9))))
             (L.fun/ascii-char9887.6.15 (lambda (c.84) (let () #\])))
             (L.fun/ascii-char9892.7.16
              (lambda (c.85)
                (let ((fun/ascii-char9893.4 (closure-ref c.85 0)))
                  (closure-call fun/ascii-char9893.4 fun/ascii-char9893.4))))
             (L.fun/void9884.8.17
              (lambda (c.86)
                (let ((fun/void9885.12 (closure-ref c.86 0)))
                  (closure-call fun/void9885.12 fun/void9885.12))))
             (L.fun/void9891.9.18 (lambda (c.87) (let () (void))))
             (L.fun/vector9888.10.19
              (lambda (c.88)
                (let ((fun/vector9889.13 (closure-ref c.88 0)))
                  (closure-call fun/vector9889.13 fun/vector9889.13))))
             (L.fun/ascii-char9886.11.20
              (lambda (c.89)
                (let ((fun/ascii-char9887.6 (closure-ref c.89 0)))
                  (closure-call fun/ascii-char9887.6 fun/ascii-char9887.6))))
             (L.fun/void9885.12.21 (lambda (c.90) (let () (void))))
             (L.fun/vector9889.13.22
              (lambda (c.91)
                (let ((make-vector.71 (closure-ref c.91 0)))
                  (closure-call make-vector.71 make-vector.71 8)))))
      (cletrec
       ((|-.74| (make-closure L.-.74.7 2))
        (*.73 (make-closure L.*.73.8 2))
        (|+.72| (make-closure L.+.72.9 2))
        (vector-init-loop.21
         (make-closure L.vector-init-loop.21.10 3 vector-init-loop.21))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.11 1 vector-init-loop.21))
        (make-vector.71
         (make-closure L.make-vector.71.12 1 make-init-vector.1))
        (fun/ascii-char9893.4 (make-closure L.fun/ascii-char9893.4.13 0))
        (fun/void9890.5 (make-closure L.fun/void9890.5.14 0 fun/void9891.9))
        (fun/ascii-char9887.6 (make-closure L.fun/ascii-char9887.6.15 0))
        (fun/ascii-char9892.7
         (make-closure L.fun/ascii-char9892.7.16 0 fun/ascii-char9893.4))
        (fun/void9884.8 (make-closure L.fun/void9884.8.17 0 fun/void9885.12))
        (fun/void9891.9 (make-closure L.fun/void9891.9.18 0))
        (fun/vector9888.10
         (make-closure L.fun/vector9888.10.19 0 fun/vector9889.13))
        (fun/ascii-char9886.11
         (make-closure L.fun/ascii-char9886.11.20 0 fun/ascii-char9887.6))
        (fun/void9885.12 (make-closure L.fun/void9885.12.21 0))
        (fun/vector9889.13
         (make-closure L.fun/vector9889.13.22 0 make-vector.71)))
       (let ((void0.18 (closure-call fun/void9884.8 fun/void9884.8))
             (ascii-char1.17
              (closure-call fun/ascii-char9886.11 fun/ascii-char9886.11))
             (procedure2.16
              (letrec ((L.lam.75.23
                        (lambda (c.92)
                          (let ((fun/vector9888.10 (closure-ref c.92 0)))
                            (closure-call
                             fun/vector9888.10
                             fun/vector9888.10)))))
                (cletrec
                 ((lam.75 (make-closure L.lam.75.23 0 fun/vector9888.10)))
                 lam.75)))
             (void3.15 (closure-call fun/void9890.5 fun/void9890.5))
             (fixnum4.14
              (closure-call
               *.73
               *.73
               (closure-call
                *.73
                *.73
                (closure-call |+.72| |+.72| 168 24)
                (closure-call *.73 *.73 207 124))
               (closure-call
                *.73
                *.73
                (closure-call *.73 *.73 127 249)
                (closure-call |-.74| |-.74| 196 211)))))
         (closure-call fun/ascii-char9892.7 fun/ascii-char9892.7))))))
(check-by-interp
 '(module
    (letrec ((L.<=.73.7
              (lambda (c.75 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx<= tmp.38 tmp.39) (error 5))
                    (error 5)))))
             (L.*.72.8
              (lambda (c.76 tmp.30 tmp.31)
                (let ()
                  (if (fixnum? tmp.31)
                    (if (fixnum? tmp.30) (unsafe-fx* tmp.30 tmp.31) (error 1))
                    (error 1)))))
             (L.-.71.9
              (lambda (c.77 tmp.34 tmp.35)
                (let ()
                  (if (fixnum? tmp.35)
                    (if (fixnum? tmp.34) (unsafe-fx- tmp.34 tmp.35) (error 3))
                    (error 3)))))
             (L.+.70.10
              (lambda (c.78 tmp.32 tmp.33)
                (let ()
                  (if (fixnum? tmp.33)
                    (if (fixnum? tmp.32) (unsafe-fx+ tmp.32 tmp.33) (error 2))
                    (error 2)))))
             (L.void?.69.11 (lambda (c.79 tmp.56) (let () (void? tmp.56))))
             (L.vector-init-loop.18.12
              (lambda (c.80 len.19 i.21 vec.20)
                (let ((vector-init-loop.18 (closure-ref c.80 0)))
                  (if (eq? len.19 i.21)
                    vec.20
                    (begin
                      (unsafe-vector-set! vec.20 i.21 0)
                      (closure-call
                       vector-init-loop.18
                       vector-init-loop.18
                       len.19
                       (unsafe-fx+ i.21 1)
                       vec.20))))))
             (L.make-init-vector.1.13
              (lambda (c.81 tmp.16)
                (let ((vector-init-loop.18 (closure-ref c.81 0)))
                  (let ((tmp.17 (unsafe-make-vector tmp.16)))
                    (closure-call
                     vector-init-loop.18
                     vector-init-loop.18
                     tmp.16
                     0
                     tmp.17)))))
             (L.make-vector.68.14
              (lambda (c.82 tmp.44)
                (let ((make-init-vector.1 (closure-ref c.82 0)))
                  (if (fixnum? tmp.44)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.44)
                    (error 8)))))
             (L.fun/void10282.4.15 (lambda (c.83) (let () (void))))
             (L.fun/empty10284.5.16 (lambda (c.84) (let () empty)))
             (L.fun/vector10278.6.17
              (lambda (c.85)
                (let ((fun/vector10279.8 (closure-ref c.85 0)))
                  (closure-call fun/vector10279.8 fun/vector10279.8))))
             (L.fun/empty10283.7.18
              (lambda (c.86)
                (let ((fun/empty10284.5 (closure-ref c.86 0)))
                  (closure-call fun/empty10284.5 fun/empty10284.5))))
             (L.fun/vector10279.8.19
              (lambda (c.87)
                (let ((make-vector.68 (closure-ref c.87 0)))
                  (closure-call make-vector.68 make-vector.68 8))))
             (L.fun/any10280.9.20 (lambda (c.88) (let () #f)))
             (L.fun/void10281.10.21
              (lambda (c.89)
                (let ((fun/void10282.4 (closure-ref c.89 0)))
                  (closure-call fun/void10282.4 fun/void10282.4)))))
      (cletrec
       ((<=.73 (make-closure L.<=.73.7 2))
        (*.72 (make-closure L.*.72.8 2))
        (|-.71| (make-closure L.-.71.9 2))
        (|+.70| (make-closure L.+.70.10 2))
        (void?.69 (make-closure L.void?.69.11 1))
        (vector-init-loop.18
         (make-closure L.vector-init-loop.18.12 3 vector-init-loop.18))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.13 1 vector-init-loop.18))
        (make-vector.68
         (make-closure L.make-vector.68.14 1 make-init-vector.1))
        (fun/void10282.4 (make-closure L.fun/void10282.4.15 0))
        (fun/empty10284.5 (make-closure L.fun/empty10284.5.16 0))
        (fun/vector10278.6
         (make-closure L.fun/vector10278.6.17 0 fun/vector10279.8))
        (fun/empty10283.7
         (make-closure L.fun/empty10283.7.18 0 fun/empty10284.5))
        (fun/vector10279.8
         (make-closure L.fun/vector10279.8.19 0 make-vector.68))
        (fun/any10280.9 (make-closure L.fun/any10280.9.20 0))
        (fun/void10281.10
         (make-closure L.fun/void10281.10.21 0 fun/void10282.4)))
       (let ((vector0.15 (closure-call fun/vector10278.6 fun/vector10278.6))
             (boolean1.14
              (closure-call
               void?.69
               void?.69
               (closure-call fun/any10280.9 fun/any10280.9)))
             (fixnum2.13
              (closure-call
               |+.70|
               |+.70|
               (closure-call
                |-.71|
                |-.71|
                (closure-call |+.70| |+.70| 119 181)
                (closure-call |+.70| |+.70| 72 105))
               (closure-call
                |-.71|
                |-.71|
                (closure-call |+.70| |+.70| 81 154)
                (closure-call *.72 *.72 141 81))))
             (procedure3.12
              (letrec ((L.lam.74.22
                        (lambda (c.90)
                          (let ((fun/void10281.10 (closure-ref c.90 0)))
                            (closure-call
                             fun/void10281.10
                             fun/void10281.10)))))
                (cletrec
                 ((lam.74 (make-closure L.lam.74.22 0 fun/void10281.10)))
                 lam.74)))
             (boolean4.11
              (closure-call
               <=.73
               <=.73
               (closure-call
                *.72
                *.72
                (closure-call |-.71| |-.71| 176 127)
                (closure-call |+.70| |+.70| 186 126))
               (closure-call
                |-.71|
                |-.71|
                (closure-call *.72 *.72 75 253)
                (closure-call |-.71| |-.71| 185 207)))))
         (closure-call fun/empty10283.7 fun/empty10283.7))))))
(check-by-interp
 '(module
    (letrec ((L.*.69.7
              (lambda (c.70 tmp.29 tmp.30)
                (let ()
                  (if (fixnum? tmp.30)
                    (if (fixnum? tmp.29) (unsafe-fx* tmp.29 tmp.30) (error 1))
                    (error 1)))))
             (L.-.68.8
              (lambda (c.71 tmp.33 tmp.34)
                (let ()
                  (if (fixnum? tmp.34)
                    (if (fixnum? tmp.33) (unsafe-fx- tmp.33 tmp.34) (error 3))
                    (error 3)))))
             (L.+.67.9
              (lambda (c.72 tmp.31 tmp.32)
                (let ()
                  (if (fixnum? tmp.32)
                    (if (fixnum? tmp.31) (unsafe-fx+ tmp.31 tmp.32) (error 2))
                    (error 2)))))
             (L.fun/error10623.4.10
              (lambda (c.73)
                (let ((fun/error10624.5 (closure-ref c.73 0)))
                  (closure-call fun/error10624.5 fun/error10624.5))))
             (L.fun/error10624.5.11 (lambda (c.74) (let () (error 75))))
             (L.fun/void10626.6.12 (lambda (c.75) (let () (void))))
             (L.fun/void10627.7.13
              (lambda (c.76)
                (let ((fun/void10628.8 (closure-ref c.76 0)))
                  (closure-call fun/void10628.8 fun/void10628.8))))
             (L.fun/void10628.8.14 (lambda (c.77) (let () (void))))
             (L.fun/void10625.9.15
              (lambda (c.78)
                (let ((fun/void10626.6 (closure-ref c.78 0)))
                  (closure-call fun/void10626.6 fun/void10626.6)))))
      (cletrec
       ((*.69 (make-closure L.*.69.7 2))
        (|-.68| (make-closure L.-.68.8 2))
        (|+.67| (make-closure L.+.67.9 2))
        (fun/error10623.4
         (make-closure L.fun/error10623.4.10 0 fun/error10624.5))
        (fun/error10624.5 (make-closure L.fun/error10624.5.11 0))
        (fun/void10626.6 (make-closure L.fun/void10626.6.12 0))
        (fun/void10627.7 (make-closure L.fun/void10627.7.13 0 fun/void10628.8))
        (fun/void10628.8 (make-closure L.fun/void10628.8.14 0))
        (fun/void10625.9
         (make-closure L.fun/void10625.9.15 0 fun/void10626.6)))
       (let ((error0.14 (closure-call fun/error10623.4 fun/error10623.4))
             (void1.13 (closure-call fun/void10625.9 fun/void10625.9))
             (fixnum2.12
              (closure-call
               |+.67|
               |+.67|
               (closure-call
                |+.67|
                |+.67|
                (closure-call |+.67| |+.67| 177 96)
                (closure-call |-.68| |-.68| 65 207))
               (closure-call
                *.69
                *.69
                (closure-call |-.68| |-.68| 170 11)
                (closure-call *.69 *.69 52 179))))
             (fixnum3.11
              (closure-call
               *.69
               *.69
               (closure-call
                |+.67|
                |+.67|
                (closure-call |-.68| |-.68| 72 203)
                (closure-call |+.67| |+.67| 144 243))
               (closure-call
                |-.68|
                |-.68|
                (closure-call |-.68| |-.68| 179 253)
                (closure-call *.69 *.69 42 49))))
             (fixnum4.10
              (closure-call
               |-.68|
               |-.68|
               (closure-call
                |+.67|
                |+.67|
                (closure-call *.69 *.69 47 226)
                (closure-call |-.68| |-.68| 208 124))
               (closure-call
                |-.68|
                |-.68|
                (closure-call |+.67| |+.67| 230 152)
                (closure-call |+.67| |+.67| 214 219)))))
         (closure-call fun/void10627.7 fun/void10627.7))))))
(check-by-interp
 '(module
    (letrec ((L.fixnum?.73.7 (lambda (c.75 tmp.57) (let () (fixnum? tmp.57))))
             (L.vector-init-loop.22.8
              (lambda (c.76 len.23 i.25 vec.24)
                (let ((vector-init-loop.22 (closure-ref c.76 0)))
                  (if (eq? len.23 i.25)
                    vec.24
                    (begin
                      (unsafe-vector-set! vec.24 i.25 0)
                      (closure-call
                       vector-init-loop.22
                       vector-init-loop.22
                       len.23
                       (unsafe-fx+ i.25 1)
                       vec.24))))))
             (L.make-init-vector.1.9
              (lambda (c.77 tmp.20)
                (let ((vector-init-loop.22 (closure-ref c.77 0)))
                  (let ((tmp.21 (unsafe-make-vector tmp.20)))
                    (closure-call
                     vector-init-loop.22
                     vector-init-loop.22
                     tmp.20
                     0
                     tmp.21)))))
             (L.make-vector.72.10
              (lambda (c.78 tmp.48)
                (let ((make-init-vector.1 (closure-ref c.78 0)))
                  (if (fixnum? tmp.48)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.48)
                    (error 8)))))
             (L.fun/error10718.4.11 (lambda (c.79) (let () (error 183))))
             (L.fun/any10714.5.12
              (lambda (c.80)
                (let ((make-vector.72 (closure-ref c.80 0)))
                  (closure-call make-vector.72 make-vector.72 8))))
             (L.fun/void10715.6.13
              (lambda (c.81)
                (let ((fun/void10716.14 (closure-ref c.81 0)))
                  (closure-call fun/void10716.14 fun/void10716.14))))
             (L.fun/vector10712.7.14
              (lambda (c.82)
                (let ((fun/vector10713.11 (closure-ref c.82 0)))
                  (closure-call fun/vector10713.11 fun/vector10713.11))))
             (L.fun/ascii-char10710.8.15
              (lambda (c.83)
                (let ((fun/ascii-char10711.12 (closure-ref c.83 0)))
                  (closure-call
                   fun/ascii-char10711.12
                   fun/ascii-char10711.12))))
             (L.fun/empty10708.9.16
              (lambda (c.84)
                (let ((fun/empty10709.13 (closure-ref c.84 0)))
                  (closure-call fun/empty10709.13 fun/empty10709.13))))
             (L.fun/error10717.10.17
              (lambda (c.85)
                (let ((fun/error10718.4 (closure-ref c.85 0)))
                  (closure-call fun/error10718.4 fun/error10718.4))))
             (L.fun/vector10713.11.18
              (lambda (c.86)
                (let ((make-vector.72 (closure-ref c.86 0)))
                  (closure-call make-vector.72 make-vector.72 8))))
             (L.fun/ascii-char10711.12.19 (lambda (c.87) (let () #\[)))
             (L.fun/empty10709.13.20 (lambda (c.88) (let () empty)))
             (L.fun/void10716.14.21 (lambda (c.89) (let () (void)))))
      (cletrec
       ((fixnum?.73 (make-closure L.fixnum?.73.7 1))
        (vector-init-loop.22
         (make-closure L.vector-init-loop.22.8 3 vector-init-loop.22))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.9 1 vector-init-loop.22))
        (make-vector.72
         (make-closure L.make-vector.72.10 1 make-init-vector.1))
        (fun/error10718.4 (make-closure L.fun/error10718.4.11 0))
        (fun/any10714.5 (make-closure L.fun/any10714.5.12 0 make-vector.72))
        (fun/void10715.6
         (make-closure L.fun/void10715.6.13 0 fun/void10716.14))
        (fun/vector10712.7
         (make-closure L.fun/vector10712.7.14 0 fun/vector10713.11))
        (fun/ascii-char10710.8
         (make-closure L.fun/ascii-char10710.8.15 0 fun/ascii-char10711.12))
        (fun/empty10708.9
         (make-closure L.fun/empty10708.9.16 0 fun/empty10709.13))
        (fun/error10717.10
         (make-closure L.fun/error10717.10.17 0 fun/error10718.4))
        (fun/vector10713.11
         (make-closure L.fun/vector10713.11.18 0 make-vector.72))
        (fun/ascii-char10711.12 (make-closure L.fun/ascii-char10711.12.19 0))
        (fun/empty10709.13 (make-closure L.fun/empty10709.13.20 0))
        (fun/void10716.14 (make-closure L.fun/void10716.14.21 0)))
       (let ((empty0.19 (closure-call fun/empty10708.9 fun/empty10708.9))
             (procedure1.18
              (letrec ((L.lam.74.22
                        (lambda (c.90)
                          (let ((fun/ascii-char10710.8 (closure-ref c.90 0)))
                            (closure-call
                             fun/ascii-char10710.8
                             fun/ascii-char10710.8)))))
                (cletrec
                 ((lam.74 (make-closure L.lam.74.22 0 fun/ascii-char10710.8)))
                 lam.74)))
             (vector2.17 (closure-call fun/vector10712.7 fun/vector10712.7))
             (boolean3.16
              (closure-call
               fixnum?.73
               fixnum?.73
               (closure-call fun/any10714.5 fun/any10714.5)))
             (void4.15 (closure-call fun/void10715.6 fun/void10715.6)))
         (closure-call fun/error10717.10 fun/error10717.10))))))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-ref.3.7
              (lambda (c.76 tmp.28 tmp.29)
                (let ()
                  (if (unsafe-fx< tmp.29 (unsafe-vector-length tmp.28))
                    (if (unsafe-fx>= tmp.29 0)
                      (unsafe-vector-ref tmp.28 tmp.29)
                      (error 11))
                    (error 11)))))
             (L.vector-ref.72.8
              (lambda (c.77 tmp.50 tmp.51)
                (let ((unsafe-vector-ref.3 (closure-ref c.77 0)))
                  (if (fixnum? tmp.51)
                    (if (vector? tmp.50)
                      (closure-call
                       unsafe-vector-ref.3
                       unsafe-vector-ref.3
                       tmp.50
                       tmp.51)
                      (error 11))
                    (error 11)))))
             (L.+.71.9
              (lambda (c.78 tmp.33 tmp.34)
                (let ()
                  (if (fixnum? tmp.34)
                    (if (fixnum? tmp.33) (unsafe-fx+ tmp.33 tmp.34) (error 2))
                    (error 2)))))
             (L.-.70.10
              (lambda (c.79 tmp.35 tmp.36)
                (let ()
                  (if (fixnum? tmp.36)
                    (if (fixnum? tmp.35) (unsafe-fx- tmp.35 tmp.36) (error 3))
                    (error 3)))))
             (L.vector-init-loop.19.11
              (lambda (c.80 len.20 i.22 vec.21)
                (let ((vector-init-loop.19 (closure-ref c.80 0)))
                  (if (eq? len.20 i.22)
                    vec.21
                    (begin
                      (unsafe-vector-set! vec.21 i.22 0)
                      (closure-call
                       vector-init-loop.19
                       vector-init-loop.19
                       len.20
                       (unsafe-fx+ i.22 1)
                       vec.21))))))
             (L.make-init-vector.1.12
              (lambda (c.81 tmp.17)
                (let ((vector-init-loop.19 (closure-ref c.81 0)))
                  (let ((tmp.18 (unsafe-make-vector tmp.17)))
                    (closure-call
                     vector-init-loop.19
                     vector-init-loop.19
                     tmp.17
                     0
                     tmp.18)))))
             (L.make-vector.69.13
              (lambda (c.82 tmp.45)
                (let ((make-init-vector.1 (closure-ref c.82 0)))
                  (if (fixnum? tmp.45)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.45)
                    (error 8)))))
             (L.fun/void10791.4.14
              (lambda (c.83)
                (let ((fun/void10792.10 (closure-ref c.83 0)))
                  (closure-call fun/void10792.10 fun/void10792.10))))
             (L.fun/ascii-char10794.5.15 (lambda (c.84) (let () #\F)))
             (L.fun/ascii-char10796.6.16 (lambda (c.85) (let () #\j)))
             (L.fun/ascii-char10795.7.17
              (lambda (c.86)
                (let ((fun/ascii-char10796.6 (closure-ref c.86 0)))
                  (closure-call fun/ascii-char10796.6 fun/ascii-char10796.6))))
             (L.fun/vector10789.8.18
              (lambda (c.87)
                (let ((fun/vector10790.9 (closure-ref c.87 0)))
                  (closure-call fun/vector10790.9 fun/vector10790.9))))
             (L.fun/vector10790.9.19
              (lambda (c.88)
                (let ((make-vector.69 (closure-ref c.88 0)))
                  (closure-call make-vector.69 make-vector.69 8))))
             (L.fun/void10792.10.20 (lambda (c.89) (let () (void))))
             (L.fun/ascii-char10793.11.21
              (lambda (c.90)
                (let ((fun/ascii-char10794.5 (closure-ref c.90 0)))
                  (closure-call
                   fun/ascii-char10794.5
                   fun/ascii-char10794.5)))))
      (cletrec
       ((unsafe-vector-ref.3 (make-closure L.unsafe-vector-ref.3.7 2))
        (vector-ref.72 (make-closure L.vector-ref.72.8 2 unsafe-vector-ref.3))
        (|+.71| (make-closure L.+.71.9 2))
        (|-.70| (make-closure L.-.70.10 2))
        (vector-init-loop.19
         (make-closure L.vector-init-loop.19.11 3 vector-init-loop.19))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.12 1 vector-init-loop.19))
        (make-vector.69
         (make-closure L.make-vector.69.13 1 make-init-vector.1))
        (fun/void10791.4
         (make-closure L.fun/void10791.4.14 0 fun/void10792.10))
        (fun/ascii-char10794.5 (make-closure L.fun/ascii-char10794.5.15 0))
        (fun/ascii-char10796.6 (make-closure L.fun/ascii-char10796.6.16 0))
        (fun/ascii-char10795.7
         (make-closure L.fun/ascii-char10795.7.17 0 fun/ascii-char10796.6))
        (fun/vector10789.8
         (make-closure L.fun/vector10789.8.18 0 fun/vector10790.9))
        (fun/vector10790.9
         (make-closure L.fun/vector10790.9.19 0 make-vector.69))
        (fun/void10792.10 (make-closure L.fun/void10792.10.20 0))
        (fun/ascii-char10793.11
         (make-closure L.fun/ascii-char10793.11.21 0 fun/ascii-char10794.5)))
       (let ((vector0.16 (closure-call fun/vector10789.8 fun/vector10789.8))
             (procedure1.15
              (letrec ((L.lam.73.22
                        (lambda (c.91)
                          (let ((fun/void10791.4 (closure-ref c.91 0)))
                            (closure-call fun/void10791.4 fun/void10791.4)))))
                (cletrec
                 ((lam.73 (make-closure L.lam.73.22 0 fun/void10791.4)))
                 lam.73)))
             (ascii-char2.14
              (closure-call fun/ascii-char10793.11 fun/ascii-char10793.11))
             (procedure3.13
              (letrec ((L.lam.74.23
                        (lambda (c.92)
                          (let ((fun/ascii-char10795.7 (closure-ref c.92 0)))
                            (closure-call
                             fun/ascii-char10795.7
                             fun/ascii-char10795.7)))))
                (cletrec
                 ((lam.74 (make-closure L.lam.74.23 0 fun/ascii-char10795.7)))
                 lam.74)))
             (procedure4.12
              (letrec ((L.lam.75.24
                        (lambda (c.93)
                          (let ((|-.70| (closure-ref c.93 0))
                                (|+.71| (closure-ref c.93 1)))
                            (closure-call
                             |+.71|
                             |+.71|
                             (closure-call
                              |-.70|
                              |-.70|
                              (closure-call |-.70| |-.70| 90 126)
                              (closure-call |-.70| |-.70| 96 108))
                             (closure-call
                              |+.71|
                              |+.71|
                              (closure-call |+.71| |+.71| 101 105)
                              (closure-call |-.70| |-.70| 163 189)))))))
                (cletrec
                 ((lam.75 (make-closure L.lam.75.24 0 |-.70| |+.71|)))
                 lam.75))))
         (closure-call vector-ref.72 vector-ref.72 vector0.16 1))))))
(check-by-interp
 '(module
    (letrec ((L.cons.75.7
              (lambda (c.78 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
             (L.vector-init-loop.24.8
              (lambda (c.79 len.25 i.27 vec.26)
                (let ((vector-init-loop.24 (closure-ref c.79 0)))
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
             (L.make-init-vector.1.9
              (lambda (c.80 tmp.22)
                (let ((vector-init-loop.24 (closure-ref c.80 0)))
                  (let ((tmp.23 (unsafe-make-vector tmp.22)))
                    (closure-call
                     vector-init-loop.24
                     vector-init-loop.24
                     tmp.22
                     0
                     tmp.23)))))
             (L.make-vector.74.10
              (lambda (c.81 tmp.50)
                (let ((make-init-vector.1 (closure-ref c.81 0)))
                  (if (fixnum? tmp.50)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.50)
                    (error 8)))))
             (L.fun/vector11667.4.11
              (lambda (c.82)
                (let ((fun/vector11668.9 (closure-ref c.82 0)))
                  (closure-call fun/vector11668.9 fun/vector11668.9))))
             (L.fun/pair11669.5.12
              (lambda (c.83)
                (let ((fun/pair11670.11 (closure-ref c.83 0)))
                  (closure-call fun/pair11670.11 fun/pair11670.11))))
             (L.fun/void11665.6.13
              (lambda (c.84)
                (let ((fun/void11666.14 (closure-ref c.84 0)))
                  (closure-call fun/void11666.14 fun/void11666.14))))
             (L.fun/empty11663.7.14
              (lambda (c.85)
                (let ((fun/empty11664.15 (closure-ref c.85 0)))
                  (closure-call fun/empty11664.15 fun/empty11664.15))))
             (L.fun/error11662.8.15 (lambda (c.86) (let () (error 142))))
             (L.fun/vector11668.9.16
              (lambda (c.87)
                (let ((make-vector.74 (closure-ref c.87 0)))
                  (closure-call make-vector.74 make-vector.74 8))))
             (L.fun/empty11660.10.17 (lambda (c.88) (let () empty)))
             (L.fun/pair11670.11.18
              (lambda (c.89)
                (let ((cons.75 (closure-ref c.89 0)))
                  (closure-call cons.75 cons.75 150 417))))
             (L.fun/error11661.12.19
              (lambda (c.90)
                (let ((fun/error11662.8 (closure-ref c.90 0)))
                  (closure-call fun/error11662.8 fun/error11662.8))))
             (L.fun/empty11659.13.20
              (lambda (c.91)
                (let ((fun/empty11660.10 (closure-ref c.91 0)))
                  (closure-call fun/empty11660.10 fun/empty11660.10))))
             (L.fun/void11666.14.21 (lambda (c.92) (let () (void))))
             (L.fun/empty11664.15.22 (lambda (c.93) (let () empty))))
      (cletrec
       ((cons.75 (make-closure L.cons.75.7 2))
        (vector-init-loop.24
         (make-closure L.vector-init-loop.24.8 3 vector-init-loop.24))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.9 1 vector-init-loop.24))
        (make-vector.74
         (make-closure L.make-vector.74.10 1 make-init-vector.1))
        (fun/vector11667.4
         (make-closure L.fun/vector11667.4.11 0 fun/vector11668.9))
        (fun/pair11669.5
         (make-closure L.fun/pair11669.5.12 0 fun/pair11670.11))
        (fun/void11665.6
         (make-closure L.fun/void11665.6.13 0 fun/void11666.14))
        (fun/empty11663.7
         (make-closure L.fun/empty11663.7.14 0 fun/empty11664.15))
        (fun/error11662.8 (make-closure L.fun/error11662.8.15 0))
        (fun/vector11668.9
         (make-closure L.fun/vector11668.9.16 0 make-vector.74))
        (fun/empty11660.10 (make-closure L.fun/empty11660.10.17 0))
        (fun/pair11670.11 (make-closure L.fun/pair11670.11.18 0 cons.75))
        (fun/error11661.12
         (make-closure L.fun/error11661.12.19 0 fun/error11662.8))
        (fun/empty11659.13
         (make-closure L.fun/empty11659.13.20 0 fun/empty11660.10))
        (fun/void11666.14 (make-closure L.fun/void11666.14.21 0))
        (fun/empty11664.15 (make-closure L.fun/empty11664.15.22 0)))
       (let ((procedure0.21
              (letrec ((L.lam.76.23
                        (lambda (c.94)
                          (let ((fun/empty11659.13 (closure-ref c.94 0)))
                            (closure-call
                             fun/empty11659.13
                             fun/empty11659.13)))))
                (cletrec
                 ((lam.76 (make-closure L.lam.76.23 0 fun/empty11659.13)))
                 lam.76)))
             (error1.20 (closure-call fun/error11661.12 fun/error11661.12))
             (empty2.19 (closure-call fun/empty11663.7 fun/empty11663.7))
             (void3.18 (closure-call fun/void11665.6 fun/void11665.6))
             (vector4.17 (closure-call fun/vector11667.4 fun/vector11667.4))
             (procedure5.16
              (letrec ((L.lam.77.24
                        (lambda (c.95)
                          (let ((fun/pair11669.5 (closure-ref c.95 0)))
                            (closure-call fun/pair11669.5 fun/pair11669.5)))))
                (cletrec
                 ((lam.77 (make-closure L.lam.77.24 0 fun/pair11669.5)))
                 lam.77))))
         (if (procedure? procedure0.21)
           (if (eq? (unsafe-procedure-arity procedure0.21) 0)
             (closure-call procedure0.21 procedure0.21)
             (error 42))
           (error 43)))))))
(check-by-interp
 '(module
    (letrec ((L.+.76.7
              (lambda (c.77 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                    (error 2)))))
             (L.*.75.8
              (lambda (c.78 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                    (error 1)))))
             (L.-.74.9
              (lambda (c.79 tmp.40 tmp.41)
                (let ()
                  (if (fixnum? tmp.41)
                    (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                    (error 3)))))
             (L.fun/empty12026.4.10
              (lambda (c.80)
                (let ((fun/empty12027.12 (closure-ref c.80 0)))
                  (closure-call fun/empty12027.12 fun/empty12027.12))))
             (L.fun/error12024.5.11
              (lambda (c.81)
                (let ((fun/error12025.9 (closure-ref c.81 0)))
                  (closure-call fun/error12025.9 fun/error12025.9))))
             (L.fun/ascii-char12030.6.12
              (lambda (c.82)
                (let ((fun/ascii-char12031.14 (closure-ref c.82 0)))
                  (closure-call
                   fun/ascii-char12031.14
                   fun/ascii-char12031.14))))
             (L.fun/error12034.7.13
              (lambda (c.83)
                (let ((fun/error12035.15 (closure-ref c.83 0)))
                  (closure-call fun/error12035.15 fun/error12035.15))))
             (L.fun/error12028.8.14
              (lambda (c.84)
                (let ((fun/error12029.13 (closure-ref c.84 0)))
                  (closure-call fun/error12029.13 fun/error12029.13))))
             (L.fun/error12025.9.15 (lambda (c.85) (let () (error 190))))
             (L.fun/ascii-char12033.10.16 (lambda (c.86) (let () #\k)))
             (L.fun/ascii-char12032.11.17
              (lambda (c.87)
                (let ((fun/ascii-char12033.10 (closure-ref c.87 0)))
                  (closure-call
                   fun/ascii-char12033.10
                   fun/ascii-char12033.10))))
             (L.fun/empty12027.12.18 (lambda (c.88) (let () empty)))
             (L.fun/error12029.13.19 (lambda (c.89) (let () (error 244))))
             (L.fun/ascii-char12031.14.20 (lambda (c.90) (let () #\])))
             (L.fun/error12035.15.21 (lambda (c.91) (let () (error 38)))))
      (cletrec
       ((|+.76| (make-closure L.+.76.7 2))
        (*.75 (make-closure L.*.75.8 2))
        (|-.74| (make-closure L.-.74.9 2))
        (fun/empty12026.4
         (make-closure L.fun/empty12026.4.10 0 fun/empty12027.12))
        (fun/error12024.5
         (make-closure L.fun/error12024.5.11 0 fun/error12025.9))
        (fun/ascii-char12030.6
         (make-closure L.fun/ascii-char12030.6.12 0 fun/ascii-char12031.14))
        (fun/error12034.7
         (make-closure L.fun/error12034.7.13 0 fun/error12035.15))
        (fun/error12028.8
         (make-closure L.fun/error12028.8.14 0 fun/error12029.13))
        (fun/error12025.9 (make-closure L.fun/error12025.9.15 0))
        (fun/ascii-char12033.10 (make-closure L.fun/ascii-char12033.10.16 0))
        (fun/ascii-char12032.11
         (make-closure L.fun/ascii-char12032.11.17 0 fun/ascii-char12033.10))
        (fun/empty12027.12 (make-closure L.fun/empty12027.12.18 0))
        (fun/error12029.13 (make-closure L.fun/error12029.13.19 0))
        (fun/ascii-char12031.14 (make-closure L.fun/ascii-char12031.14.20 0))
        (fun/error12035.15 (make-closure L.fun/error12035.15.21 0)))
       (let ((fixnum0.21
              (closure-call
               |+.76|
               |+.76|
               (closure-call
                |-.74|
                |-.74|
                (closure-call
                 |+.76|
                 |+.76|
                 (closure-call |-.74| |-.74| 20 248)
                 (closure-call *.75 *.75 206 242))
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call |+.76| |+.76| 165 249)
                 (closure-call *.75 *.75 245 99)))
               (closure-call
                *.75
                *.75
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call *.75 *.75 200 34)
                 (closure-call |+.76| |+.76| 43 207))
                (closure-call
                 *.75
                 *.75
                 (closure-call |-.74| |-.74| 204 93)
                 (closure-call *.75 *.75 55 91)))))
             (error1.20 (closure-call fun/error12024.5 fun/error12024.5))
             (empty2.19 (closure-call fun/empty12026.4 fun/empty12026.4))
             (error3.18 (closure-call fun/error12028.8 fun/error12028.8))
             (ascii-char4.17
              (closure-call fun/ascii-char12030.6 fun/ascii-char12030.6))
             (ascii-char5.16
              (closure-call fun/ascii-char12032.11 fun/ascii-char12032.11)))
         (closure-call fun/error12034.7 fun/error12034.7))))))
(check-by-interp
 '(module
    (letrec ((L.cons.74.7
              (lambda (c.76 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
             (L.fun/error13992.4.8 (lambda (c.77) (let () (error 29))))
             (L.fun/ascii-char13987.5.9
              (lambda (c.78)
                (let ((fun/ascii-char13988.11 (closure-ref c.78 0)))
                  (closure-call
                   fun/ascii-char13988.11
                   fun/ascii-char13988.11))))
             (L.fun/void13994.6.10 (lambda (c.79) (let () (void))))
             (L.fun/void13996.7.11 (lambda (c.80) (let () (void))))
             (L.fun/void13990.8.12 (lambda (c.81) (let () (void))))
             (L.fun/pair13985.9.13
              (lambda (c.82)
                (let ((fun/pair13986.12 (closure-ref c.82 0)))
                  (closure-call fun/pair13986.12 fun/pair13986.12))))
             (L.fun/void13993.10.14
              (lambda (c.83)
                (let ((fun/void13994.6 (closure-ref c.83 0)))
                  (closure-call fun/void13994.6 fun/void13994.6))))
             (L.fun/ascii-char13988.11.15 (lambda (c.84) (let () #\j)))
             (L.fun/pair13986.12.16
              (lambda (c.85)
                (let ((cons.74 (closure-ref c.85 0)))
                  (closure-call cons.74 cons.74 112 427))))
             (L.fun/error13991.13.17
              (lambda (c.86)
                (let ((fun/error13992.4 (closure-ref c.86 0)))
                  (closure-call fun/error13992.4 fun/error13992.4))))
             (L.fun/void13995.14.18
              (lambda (c.87)
                (let ((fun/void13996.7 (closure-ref c.87 0)))
                  (closure-call fun/void13996.7 fun/void13996.7))))
             (L.fun/void13989.15.19
              (lambda (c.88)
                (let ((fun/void13990.8 (closure-ref c.88 0)))
                  (closure-call fun/void13990.8 fun/void13990.8)))))
      (cletrec
       ((cons.74 (make-closure L.cons.74.7 2))
        (fun/error13992.4 (make-closure L.fun/error13992.4.8 0))
        (fun/ascii-char13987.5
         (make-closure L.fun/ascii-char13987.5.9 0 fun/ascii-char13988.11))
        (fun/void13994.6 (make-closure L.fun/void13994.6.10 0))
        (fun/void13996.7 (make-closure L.fun/void13996.7.11 0))
        (fun/void13990.8 (make-closure L.fun/void13990.8.12 0))
        (fun/pair13985.9
         (make-closure L.fun/pair13985.9.13 0 fun/pair13986.12))
        (fun/void13993.10
         (make-closure L.fun/void13993.10.14 0 fun/void13994.6))
        (fun/ascii-char13988.11 (make-closure L.fun/ascii-char13988.11.15 0))
        (fun/pair13986.12 (make-closure L.fun/pair13986.12.16 0 cons.74))
        (fun/error13991.13
         (make-closure L.fun/error13991.13.17 0 fun/error13992.4))
        (fun/void13995.14
         (make-closure L.fun/void13995.14.18 0 fun/void13996.7))
        (fun/void13989.15
         (make-closure L.fun/void13989.15.19 0 fun/void13990.8)))
       (let ((procedure0.21
              (letrec ((L.lam.75.20
                        (lambda (c.89)
                          (let ((fun/pair13985.9 (closure-ref c.89 0)))
                            (closure-call fun/pair13985.9 fun/pair13985.9)))))
                (cletrec
                 ((lam.75 (make-closure L.lam.75.20 0 fun/pair13985.9)))
                 lam.75)))
             (ascii-char1.20
              (closure-call fun/ascii-char13987.5 fun/ascii-char13987.5))
             (void2.19 (closure-call fun/void13989.15 fun/void13989.15))
             (error3.18 (closure-call fun/error13991.13 fun/error13991.13))
             (void4.17 (closure-call fun/void13993.10 fun/void13993.10))
             (void5.16 (closure-call fun/void13995.14 fun/void13995.14)))
         (if (procedure? procedure0.21)
           (if (eq? (unsafe-procedure-arity procedure0.21) 0)
             (closure-call procedure0.21 procedure0.21)
             (error 42))
           (error 43)))))))
(check-by-interp
 '(module
    (letrec ((L.ascii-char?.79.7
              (lambda (c.81 tmp.63) (let () (ascii-char? tmp.63))))
             (L.fixnum?.78.8 (lambda (c.82 tmp.59) (let () (fixnum? tmp.59))))
             (L.+.77.9
              (lambda (c.83 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                    (error 2)))))
             (L.*.76.10
              (lambda (c.84 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                    (error 1)))))
             (L.-.75.11
              (lambda (c.85 tmp.40 tmp.41)
                (let ()
                  (if (fixnum? tmp.41)
                    (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                    (error 3)))))
             (L.vector-init-loop.24.12
              (lambda (c.86 len.25 i.27 vec.26)
                (let ((vector-init-loop.24 (closure-ref c.86 0)))
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
             (L.make-init-vector.1.13
              (lambda (c.87 tmp.22)
                (let ((vector-init-loop.24 (closure-ref c.87 0)))
                  (let ((tmp.23 (unsafe-make-vector tmp.22)))
                    (closure-call
                     vector-init-loop.24
                     vector-init-loop.24
                     tmp.22
                     0
                     tmp.23)))))
             (L.make-vector.74.14
              (lambda (c.88 tmp.50)
                (let ((make-init-vector.1 (closure-ref c.88 0)))
                  (if (fixnum? tmp.50)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.50)
                    (error 8)))))
             (L.fun/vector14738.4.15
              (lambda (c.89)
                (let ((fun/vector14739.15 (closure-ref c.89 0)))
                  (closure-call fun/vector14739.15 fun/vector14739.15))))
             (L.fun/vector14745.5.16
              (lambda (c.90)
                (let ((make-vector.74 (closure-ref c.90 0)))
                  (closure-call make-vector.74 make-vector.74 8))))
             (L.fun/vector14744.6.17
              (lambda (c.91)
                (let ((fun/vector14745.5 (closure-ref c.91 0)))
                  (closure-call fun/vector14745.5 fun/vector14745.5))))
             (L.fun/any14740.7.18
              (lambda (c.92)
                (let ((fun/any14741.12 (closure-ref c.92 0)))
                  (closure-call fun/any14741.12 fun/any14741.12))))
             (L.fun/ascii-char14748.8.19
              (lambda (c.93)
                (let ((fun/ascii-char14749.14 (closure-ref c.93 0)))
                  (closure-call
                   fun/ascii-char14749.14
                   fun/ascii-char14749.14))))
             (L.fun/ascii-char14742.9.20
              (lambda (c.94)
                (let ((fun/ascii-char14743.13 (closure-ref c.94 0)))
                  (closure-call
                   fun/ascii-char14743.13
                   fun/ascii-char14743.13))))
             (L.fun/any14746.10.21
              (lambda (c.95)
                (let ((fun/any14747.11 (closure-ref c.95 0)))
                  (closure-call fun/any14747.11 fun/any14747.11))))
             (L.fun/any14747.11.22 (lambda (c.96) (let () empty)))
             (L.fun/any14741.12.23
              (lambda (c.97)
                (let ((make-vector.74 (closure-ref c.97 0)))
                  (closure-call make-vector.74 make-vector.74 8))))
             (L.fun/ascii-char14743.13.24 (lambda (c.98) (let () #\f)))
             (L.fun/ascii-char14749.14.25 (lambda (c.99) (let () #\z)))
             (L.fun/vector14739.15.26
              (lambda (c.100)
                (let ((make-vector.74 (closure-ref c.100 0)))
                  (closure-call make-vector.74 make-vector.74 8)))))
      (cletrec
       ((ascii-char?.79 (make-closure L.ascii-char?.79.7 1))
        (fixnum?.78 (make-closure L.fixnum?.78.8 1))
        (|+.77| (make-closure L.+.77.9 2))
        (*.76 (make-closure L.*.76.10 2))
        (|-.75| (make-closure L.-.75.11 2))
        (vector-init-loop.24
         (make-closure L.vector-init-loop.24.12 3 vector-init-loop.24))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.13 1 vector-init-loop.24))
        (make-vector.74
         (make-closure L.make-vector.74.14 1 make-init-vector.1))
        (fun/vector14738.4
         (make-closure L.fun/vector14738.4.15 0 fun/vector14739.15))
        (fun/vector14745.5
         (make-closure L.fun/vector14745.5.16 0 make-vector.74))
        (fun/vector14744.6
         (make-closure L.fun/vector14744.6.17 0 fun/vector14745.5))
        (fun/any14740.7 (make-closure L.fun/any14740.7.18 0 fun/any14741.12))
        (fun/ascii-char14748.8
         (make-closure L.fun/ascii-char14748.8.19 0 fun/ascii-char14749.14))
        (fun/ascii-char14742.9
         (make-closure L.fun/ascii-char14742.9.20 0 fun/ascii-char14743.13))
        (fun/any14746.10 (make-closure L.fun/any14746.10.21 0 fun/any14747.11))
        (fun/any14747.11 (make-closure L.fun/any14747.11.22 0))
        (fun/any14741.12 (make-closure L.fun/any14741.12.23 0 make-vector.74))
        (fun/ascii-char14743.13 (make-closure L.fun/ascii-char14743.13.24 0))
        (fun/ascii-char14749.14 (make-closure L.fun/ascii-char14749.14.25 0))
        (fun/vector14739.15
         (make-closure L.fun/vector14739.15.26 0 make-vector.74)))
       (let ((vector0.21 (closure-call fun/vector14738.4 fun/vector14738.4))
             (fixnum1.20
              (closure-call
               |+.77|
               |+.77|
               (closure-call
                *.76
                *.76
                (closure-call
                 *.76
                 *.76
                 (closure-call |-.75| |-.75| 45 247)
                 (closure-call |-.75| |-.75| 119 239))
                (closure-call
                 |+.77|
                 |+.77|
                 (closure-call |-.75| |-.75| 100 45)
                 (closure-call *.76 *.76 251 105)))
               (closure-call
                *.76
                *.76
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call *.76 *.76 114 238)
                 (closure-call *.76 *.76 230 88))
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call |+.77| |+.77| 250 216)
                 (closure-call |+.77| |+.77| 89 76)))))
             (boolean2.19
              (closure-call
               fixnum?.78
               fixnum?.78
               (closure-call fun/any14740.7 fun/any14740.7)))
             (ascii-char3.18
              (closure-call fun/ascii-char14742.9 fun/ascii-char14742.9))
             (vector4.17 (closure-call fun/vector14744.6 fun/vector14744.6))
             (procedure5.16
              (letrec ((L.lam.80.27
                        (lambda (c.101)
                          (let ((fun/any14746.10 (closure-ref c.101 0))
                                (ascii-char?.79 (closure-ref c.101 1)))
                            (closure-call
                             ascii-char?.79
                             ascii-char?.79
                             (closure-call
                              fun/any14746.10
                              fun/any14746.10))))))
                (cletrec
                 ((lam.80
                   (make-closure
                    L.lam.80.27
                    0
                    fun/any14746.10
                    ascii-char?.79)))
                 lam.80))))
         (closure-call fun/ascii-char14748.8 fun/ascii-char14748.8))))))
(check-by-interp
 '(module
    (letrec ((L.procedure?.76.7
              (lambda (c.77 tmp.66) (let () (procedure? tmp.66))))
             (L.*.75.8
              (lambda (c.78 tmp.34 tmp.35)
                (let ()
                  (if (fixnum? tmp.35)
                    (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
                    (error 1)))))
             (L.-.74.9
              (lambda (c.79 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
                    (error 3)))))
             (L.+.73.10
              (lambda (c.80 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
                    (error 2)))))
             (L.vector-init-loop.22.11
              (lambda (c.81 len.23 i.25 vec.24)
                (let ((vector-init-loop.22 (closure-ref c.81 0)))
                  (if (eq? len.23 i.25)
                    vec.24
                    (begin
                      (unsafe-vector-set! vec.24 i.25 0)
                      (closure-call
                       vector-init-loop.22
                       vector-init-loop.22
                       len.23
                       (unsafe-fx+ i.25 1)
                       vec.24))))))
             (L.make-init-vector.1.12
              (lambda (c.82 tmp.20)
                (let ((vector-init-loop.22 (closure-ref c.82 0)))
                  (let ((tmp.21 (unsafe-make-vector tmp.20)))
                    (closure-call
                     vector-init-loop.22
                     vector-init-loop.22
                     tmp.20
                     0
                     tmp.21)))))
             (L.make-vector.72.13
              (lambda (c.83 tmp.48)
                (let ((make-init-vector.1 (closure-ref c.83 0)))
                  (if (fixnum? tmp.48)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.48)
                    (error 8)))))
             (L.fun/ascii-char14780.4.14
              (lambda (c.84)
                (let ((fun/ascii-char14781.11 (closure-ref c.84 0)))
                  (closure-call
                   fun/ascii-char14781.11
                   fun/ascii-char14781.11))))
             (L.fun/vector14772.5.15
              (lambda (c.85)
                (let ((fun/vector14773.8 (closure-ref c.85 0)))
                  (closure-call fun/vector14773.8 fun/vector14773.8))))
             (L.fun/empty14779.6.16 (lambda (c.86) (let () empty)))
             (L.fun/any14775.7.17 (lambda (c.87) (let () 147)))
             (L.fun/vector14773.8.18
              (lambda (c.88)
                (let ((make-vector.72 (closure-ref c.88 0)))
                  (closure-call make-vector.72 make-vector.72 8))))
             (L.fun/vector14777.9.19
              (lambda (c.89)
                (let ((make-vector.72 (closure-ref c.89 0)))
                  (closure-call make-vector.72 make-vector.72 8))))
             (L.fun/empty14778.10.20
              (lambda (c.90)
                (let ((fun/empty14779.6 (closure-ref c.90 0)))
                  (closure-call fun/empty14779.6 fun/empty14779.6))))
             (L.fun/ascii-char14781.11.21 (lambda (c.91) (let () #\Z)))
             (L.fun/vector14776.12.22
              (lambda (c.92)
                (let ((fun/vector14777.9 (closure-ref c.92 0)))
                  (closure-call fun/vector14777.9 fun/vector14777.9))))
             (L.fun/any14774.13.23
              (lambda (c.93)
                (let ((fun/any14775.7 (closure-ref c.93 0)))
                  (closure-call fun/any14775.7 fun/any14775.7)))))
      (cletrec
       ((procedure?.76 (make-closure L.procedure?.76.7 1))
        (*.75 (make-closure L.*.75.8 2))
        (|-.74| (make-closure L.-.74.9 2))
        (|+.73| (make-closure L.+.73.10 2))
        (vector-init-loop.22
         (make-closure L.vector-init-loop.22.11 3 vector-init-loop.22))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.12 1 vector-init-loop.22))
        (make-vector.72
         (make-closure L.make-vector.72.13 1 make-init-vector.1))
        (fun/ascii-char14780.4
         (make-closure L.fun/ascii-char14780.4.14 0 fun/ascii-char14781.11))
        (fun/vector14772.5
         (make-closure L.fun/vector14772.5.15 0 fun/vector14773.8))
        (fun/empty14779.6 (make-closure L.fun/empty14779.6.16 0))
        (fun/any14775.7 (make-closure L.fun/any14775.7.17 0))
        (fun/vector14773.8
         (make-closure L.fun/vector14773.8.18 0 make-vector.72))
        (fun/vector14777.9
         (make-closure L.fun/vector14777.9.19 0 make-vector.72))
        (fun/empty14778.10
         (make-closure L.fun/empty14778.10.20 0 fun/empty14779.6))
        (fun/ascii-char14781.11 (make-closure L.fun/ascii-char14781.11.21 0))
        (fun/vector14776.12
         (make-closure L.fun/vector14776.12.22 0 fun/vector14777.9))
        (fun/any14774.13 (make-closure L.fun/any14774.13.23 0 fun/any14775.7)))
       (let ((fixnum0.19
              (closure-call
               *.75
               *.75
               (closure-call
                |-.74|
                |-.74|
                (closure-call
                 |+.73|
                 |+.73|
                 (closure-call |+.73| |+.73| 228 49)
                 (closure-call |+.73| |+.73| 11 111))
                (closure-call
                 |+.73|
                 |+.73|
                 (closure-call |-.74| |-.74| 17 94)
                 (closure-call *.75 *.75 83 228)))
               (closure-call
                |-.74|
                |-.74|
                (closure-call
                 *.75
                 *.75
                 (closure-call |-.74| |-.74| 76 30)
                 (closure-call |+.73| |+.73| 20 59))
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call |-.74| |-.74| 248 63)
                 (closure-call *.75 *.75 59 35)))))
             (vector1.18 (closure-call fun/vector14772.5 fun/vector14772.5))
             (boolean2.17
              (closure-call
               procedure?.76
               procedure?.76
               (closure-call fun/any14774.13 fun/any14774.13)))
             (vector3.16 (closure-call fun/vector14776.12 fun/vector14776.12))
             (fixnum4.15
              (closure-call
               |-.74|
               |-.74|
               (closure-call
                |-.74|
                |-.74|
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call *.75 *.75 35 53)
                 (closure-call |+.73| |+.73| 152 36))
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call |+.73| |+.73| 147 111)
                 (closure-call |-.74| |-.74| 250 208)))
               (closure-call
                |+.73|
                |+.73|
                (closure-call
                 |+.73|
                 |+.73|
                 (closure-call |+.73| |+.73| 245 114)
                 (closure-call *.75 *.75 118 89))
                (closure-call
                 |-.74|
                 |-.74|
                 (closure-call *.75 *.75 148 242)
                 (closure-call |-.74| |-.74| 212 75)))))
             (empty5.14 (closure-call fun/empty14778.10 fun/empty14778.10)))
         (closure-call fun/ascii-char14780.4 fun/ascii-char14780.4))))))
(check-by-interp
 '(module
    (letrec ((L.ascii-char?.77.7
              (lambda (c.78 tmp.65) (let () (ascii-char? tmp.65))))
             (L.cons.76.8
              (lambda (c.79 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
             (L.fun/error15417.4.9 (lambda (c.80) (let () (error 26))))
             (L.fun/any15415.5.10 (lambda (c.81) (let () #f)))
             (L.fun/pair15426.6.11
              (lambda (c.82)
                (let ((fun/pair15427.15 (closure-ref c.82 0)))
                  (closure-call fun/pair15427.15 fun/pair15427.15))))
             (L.fun/error15423.7.12 (lambda (c.83) (let () (error 88))))
             (L.fun/void15424.8.13
              (lambda (c.84)
                (let ((fun/void15425.13 (closure-ref c.84 0)))
                  (closure-call fun/void15425.13 fun/void15425.13))))
             (L.fun/error15421.9.14 (lambda (c.85) (let () (error 37))))
             (L.fun/error15418.10.15
              (lambda (c.86)
                (let ((fun/error15419.11 (closure-ref c.86 0)))
                  (closure-call fun/error15419.11 fun/error15419.11))))
             (L.fun/error15419.11.16 (lambda (c.87) (let () (error 229))))
             (L.fun/error15422.12.17
              (lambda (c.88)
                (let ((fun/error15423.7 (closure-ref c.88 0)))
                  (closure-call fun/error15423.7 fun/error15423.7))))
             (L.fun/void15425.13.18 (lambda (c.89) (let () (void))))
             (L.fun/any15414.14.19
              (lambda (c.90)
                (let ((fun/any15415.5 (closure-ref c.90 0)))
                  (closure-call fun/any15415.5 fun/any15415.5))))
             (L.fun/pair15427.15.20
              (lambda (c.91)
                (let ((cons.76 (closure-ref c.91 0)))
                  (closure-call cons.76 cons.76 247 511))))
             (L.fun/error15416.16.21
              (lambda (c.92)
                (let ((fun/error15417.4 (closure-ref c.92 0)))
                  (closure-call fun/error15417.4 fun/error15417.4))))
             (L.fun/error15420.17.22
              (lambda (c.93)
                (let ((fun/error15421.9 (closure-ref c.93 0)))
                  (closure-call fun/error15421.9 fun/error15421.9)))))
      (cletrec
       ((ascii-char?.77 (make-closure L.ascii-char?.77.7 1))
        (cons.76 (make-closure L.cons.76.8 2))
        (fun/error15417.4 (make-closure L.fun/error15417.4.9 0))
        (fun/any15415.5 (make-closure L.fun/any15415.5.10 0))
        (fun/pair15426.6
         (make-closure L.fun/pair15426.6.11 0 fun/pair15427.15))
        (fun/error15423.7 (make-closure L.fun/error15423.7.12 0))
        (fun/void15424.8
         (make-closure L.fun/void15424.8.13 0 fun/void15425.13))
        (fun/error15421.9 (make-closure L.fun/error15421.9.14 0))
        (fun/error15418.10
         (make-closure L.fun/error15418.10.15 0 fun/error15419.11))
        (fun/error15419.11 (make-closure L.fun/error15419.11.16 0))
        (fun/error15422.12
         (make-closure L.fun/error15422.12.17 0 fun/error15423.7))
        (fun/void15425.13 (make-closure L.fun/void15425.13.18 0))
        (fun/any15414.14 (make-closure L.fun/any15414.14.19 0 fun/any15415.5))
        (fun/pair15427.15 (make-closure L.fun/pair15427.15.20 0 cons.76))
        (fun/error15416.16
         (make-closure L.fun/error15416.16.21 0 fun/error15417.4))
        (fun/error15420.17
         (make-closure L.fun/error15420.17.22 0 fun/error15421.9)))
       (let ((boolean0.23
              (closure-call
               ascii-char?.77
               ascii-char?.77
               (closure-call fun/any15414.14 fun/any15414.14)))
             (error1.22 (closure-call fun/error15416.16 fun/error15416.16))
             (error2.21 (closure-call fun/error15418.10 fun/error15418.10))
             (error3.20 (closure-call fun/error15420.17 fun/error15420.17))
             (error4.19 (closure-call fun/error15422.12 fun/error15422.12))
             (void5.18 (closure-call fun/void15424.8 fun/void15424.8)))
         (closure-call fun/pair15426.6 fun/pair15426.6))))))
(check-by-interp
 '(module
    (letrec ((L.+.76.7
              (lambda (c.77 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                    (error 2)))))
             (L.-.75.8
              (lambda (c.78 tmp.40 tmp.41)
                (let ()
                  (if (fixnum? tmp.41)
                    (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                    (error 3)))))
             (L.*.74.9
              (lambda (c.79 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                    (error 1)))))
             (L.fun/ascii-char16435.4.10
              (lambda (c.80)
                (let ((fun/ascii-char16436.10 (closure-ref c.80 0)))
                  (closure-call
                   fun/ascii-char16436.10
                   fun/ascii-char16436.10))))
             (L.fun/ascii-char16444.5.11 (lambda (c.81) (let () #\e)))
             (L.fun/void16439.6.12
              (lambda (c.82)
                (let ((fun/void16440.14 (closure-ref c.82 0)))
                  (closure-call fun/void16440.14 fun/void16440.14))))
             (L.fun/ascii-char16437.7.13
              (lambda (c.83)
                (let ((fun/ascii-char16438.9 (closure-ref c.83 0)))
                  (closure-call fun/ascii-char16438.9 fun/ascii-char16438.9))))
             (L.fun/error16433.8.14
              (lambda (c.84)
                (let ((fun/error16434.13 (closure-ref c.84 0)))
                  (closure-call fun/error16434.13 fun/error16434.13))))
             (L.fun/ascii-char16438.9.15 (lambda (c.85) (let () #\H)))
             (L.fun/ascii-char16436.10.16 (lambda (c.86) (let () #\[)))
             (L.fun/ascii-char16442.11.17 (lambda (c.87) (let () #\`)))
             (L.fun/ascii-char16441.12.18
              (lambda (c.88)
                (let ((fun/ascii-char16442.11 (closure-ref c.88 0)))
                  (closure-call
                   fun/ascii-char16442.11
                   fun/ascii-char16442.11))))
             (L.fun/error16434.13.19 (lambda (c.89) (let () (error 239))))
             (L.fun/void16440.14.20 (lambda (c.90) (let () (void))))
             (L.fun/ascii-char16443.15.21
              (lambda (c.91)
                (let ((fun/ascii-char16444.5 (closure-ref c.91 0)))
                  (closure-call
                   fun/ascii-char16444.5
                   fun/ascii-char16444.5)))))
      (cletrec
       ((|+.76| (make-closure L.+.76.7 2))
        (|-.75| (make-closure L.-.75.8 2))
        (*.74 (make-closure L.*.74.9 2))
        (fun/ascii-char16435.4
         (make-closure L.fun/ascii-char16435.4.10 0 fun/ascii-char16436.10))
        (fun/ascii-char16444.5 (make-closure L.fun/ascii-char16444.5.11 0))
        (fun/void16439.6
         (make-closure L.fun/void16439.6.12 0 fun/void16440.14))
        (fun/ascii-char16437.7
         (make-closure L.fun/ascii-char16437.7.13 0 fun/ascii-char16438.9))
        (fun/error16433.8
         (make-closure L.fun/error16433.8.14 0 fun/error16434.13))
        (fun/ascii-char16438.9 (make-closure L.fun/ascii-char16438.9.15 0))
        (fun/ascii-char16436.10 (make-closure L.fun/ascii-char16436.10.16 0))
        (fun/ascii-char16442.11 (make-closure L.fun/ascii-char16442.11.17 0))
        (fun/ascii-char16441.12
         (make-closure L.fun/ascii-char16441.12.18 0 fun/ascii-char16442.11))
        (fun/error16434.13 (make-closure L.fun/error16434.13.19 0))
        (fun/void16440.14 (make-closure L.fun/void16440.14.20 0))
        (fun/ascii-char16443.15
         (make-closure L.fun/ascii-char16443.15.21 0 fun/ascii-char16444.5)))
       (let ((error0.21 (closure-call fun/error16433.8 fun/error16433.8))
             (ascii-char1.20
              (closure-call fun/ascii-char16435.4 fun/ascii-char16435.4))
             (fixnum2.19
              (closure-call
               |+.76|
               |+.76|
               (closure-call
                *.74
                *.74
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call *.74 *.74 240 46)
                 (closure-call |-.75| |-.75| 188 112))
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call *.74 *.74 35 210)
                 (closure-call |+.76| |+.76| 107 254)))
               (closure-call
                |-.75|
                |-.75|
                (closure-call
                 *.74
                 *.74
                 (closure-call |-.75| |-.75| 80 233)
                 (closure-call *.74 *.74 108 186))
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call |-.75| |-.75| 234 172)
                 (closure-call |+.76| |+.76| 179 80)))))
             (ascii-char3.18
              (closure-call fun/ascii-char16437.7 fun/ascii-char16437.7))
             (void4.17 (closure-call fun/void16439.6 fun/void16439.6))
             (ascii-char5.16
              (closure-call fun/ascii-char16441.12 fun/ascii-char16441.12)))
         (closure-call fun/ascii-char16443.15 fun/ascii-char16443.15))))))
(check-by-interp
 '(module
    (letrec ((L.>.89.7
              (lambda (c.90 tmp.55 tmp.56)
                (let ()
                  (if (fixnum? tmp.56)
                    (if (fixnum? tmp.55) (unsafe-fx> tmp.55 tmp.56) (error 6))
                    (error 6)))))
             (L.*.88.8
              (lambda (c.91 tmp.45 tmp.46)
                (let ()
                  (if (fixnum? tmp.46)
                    (if (fixnum? tmp.45) (unsafe-fx* tmp.45 tmp.46) (error 1))
                    (error 1)))))
             (L.boolean?.87.9
              (lambda (c.92 tmp.69) (let () (boolean? tmp.69))))
             (L.<=.86.10
              (lambda (c.93 tmp.53 tmp.54)
                (let ()
                  (if (fixnum? tmp.54)
                    (if (fixnum? tmp.53) (unsafe-fx<= tmp.53 tmp.54) (error 5))
                    (error 5)))))
             (L.+.85.11
              (lambda (c.94 tmp.47 tmp.48)
                (let ()
                  (if (fixnum? tmp.48)
                    (if (fixnum? tmp.47) (unsafe-fx+ tmp.47 tmp.48) (error 2))
                    (error 2)))))
             (L.-.84.12
              (lambda (c.95 tmp.49 tmp.50)
                (let ()
                  (if (fixnum? tmp.50)
                    (if (fixnum? tmp.49) (unsafe-fx- tmp.49 tmp.50) (error 3))
                    (error 3)))))
             (L.vector-init-loop.33.13
              (lambda (c.96 len.34 i.36 vec.35)
                (let ((vector-init-loop.33 (closure-ref c.96 0)))
                  (if (eq? len.34 i.36)
                    vec.35
                    (begin
                      (unsafe-vector-set! vec.35 i.36 0)
                      (closure-call
                       vector-init-loop.33
                       vector-init-loop.33
                       len.34
                       (unsafe-fx+ i.36 1)
                       vec.35))))))
             (L.make-init-vector.1.14
              (lambda (c.97 tmp.31)
                (let ((vector-init-loop.33 (closure-ref c.97 0)))
                  (let ((tmp.32 (unsafe-make-vector tmp.31)))
                    (closure-call
                     vector-init-loop.33
                     vector-init-loop.33
                     tmp.31
                     0
                     tmp.32)))))
             (L.make-vector.83.15
              (lambda (c.98 tmp.59)
                (let ((make-init-vector.1 (closure-ref c.98 0)))
                  (if (fixnum? tmp.59)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.59)
                    (error 8)))))
             (L.fun/ascii-char16492.4.16 (lambda (c.99) (let () #\h)))
             (L.fun/empty16491.5.17 (lambda (c.100) (let () empty)))
             (L.fun/vector16484.6.18
              (lambda (c.101)
                (let ((make-vector.83 (closure-ref c.101 0)))
                  (closure-call make-vector.83 make-vector.83 8))))
             (L.fun/empty16487.7.19 (lambda (c.102) (let () empty)))
             (L.fun/any16488.8.20 (lambda (c.103) (let () 68)))
             (L.fun/empty16489.9.21 (lambda (c.104) (let () empty)))
             (L.fun/error16485.10.22 (lambda (c.105) (let () (error 237))))
             (L.fun/empty16490.11.23 (lambda (c.106) (let () empty)))
             (L.fun/error16486.12.24 (lambda (c.107) (let () (error 225)))))
      (cletrec
       ((>.89 (make-closure L.>.89.7 2))
        (*.88 (make-closure L.*.88.8 2))
        (boolean?.87 (make-closure L.boolean?.87.9 1))
        (<=.86 (make-closure L.<=.86.10 2))
        (|+.85| (make-closure L.+.85.11 2))
        (|-.84| (make-closure L.-.84.12 2))
        (vector-init-loop.33
         (make-closure L.vector-init-loop.33.13 3 vector-init-loop.33))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.14 1 vector-init-loop.33))
        (make-vector.83
         (make-closure L.make-vector.83.15 1 make-init-vector.1))
        (fun/ascii-char16492.4 (make-closure L.fun/ascii-char16492.4.16 0))
        (fun/empty16491.5 (make-closure L.fun/empty16491.5.17 0))
        (fun/vector16484.6
         (make-closure L.fun/vector16484.6.18 0 make-vector.83))
        (fun/empty16487.7 (make-closure L.fun/empty16487.7.19 0))
        (fun/any16488.8 (make-closure L.fun/any16488.8.20 0))
        (fun/empty16489.9 (make-closure L.fun/empty16489.9.21 0))
        (fun/error16485.10 (make-closure L.fun/error16485.10.22 0))
        (fun/empty16490.11 (make-closure L.fun/empty16490.11.23 0))
        (fun/error16486.12 (make-closure L.fun/error16486.12.24 0)))
       (if (let ((fixnum0.18
                  (closure-call
                   |-.84|
                   |-.84|
                   (closure-call |-.84| |-.84| 89 200)
                   (closure-call |+.85| |+.85| 38 241)))
                 (vector1.17
                  (closure-call fun/vector16484.6 fun/vector16484.6))
                 (error2.16 (closure-call fun/error16485.10 fun/error16485.10))
                 (error3.15 (closure-call fun/error16486.12 fun/error16486.12))
                 (empty4.14 (closure-call fun/empty16487.7 fun/empty16487.7))
                 (boolean5.13
                  (closure-call
                   <=.86
                   <=.86
                   (closure-call |-.84| |-.84| 185 172)
                   (closure-call |+.85| |+.85| 136 173))))
             (closure-call
              boolean?.87
              boolean?.87
              (closure-call fun/any16488.8 fun/any16488.8)))
         (if (if #t #f #f)
           (let ((ascii-char0.24 #\_)
                 (ascii-char1.23 #\A)
                 (boolean2.22 #f)
                 (void3.21 (void))
                 (boolean4.20 #f)
                 (empty5.19 empty))
             #\U)
           (if #t #\v #\U))
         (let ((empty0.30 (closure-call fun/empty16489.9 fun/empty16489.9))
               (fixnum1.29
                (closure-call
                 |-.84|
                 |-.84|
                 (closure-call *.88 *.88 53 209)
                 (closure-call *.88 *.88 2 115)))
               (boolean2.28
                (closure-call
                 >.89
                 >.89
                 (closure-call *.88 *.88 94 22)
                 (closure-call |+.85| |+.85| 89 85)))
               (empty3.27 (closure-call fun/empty16490.11 fun/empty16490.11))
               (fixnum4.26
                (closure-call
                 |-.84|
                 |-.84|
                 (closure-call |-.84| |-.84| 17 63)
                 (closure-call *.88 *.88 147 5)))
               (empty5.25 (closure-call fun/empty16491.5 fun/empty16491.5)))
           (closure-call fun/ascii-char16492.4 fun/ascii-char16492.4)))))))
(check-by-interp
 '(module
    (letrec ((L.procedure?.78.7
              (lambda (c.79 tmp.70) (let () (procedure? tmp.70))))
             (L.cons.77.8
              (lambda (c.80 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
             (L.vector-init-loop.26.9
              (lambda (c.81 len.27 i.29 vec.28)
                (let ((vector-init-loop.26 (closure-ref c.81 0)))
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
             (L.make-init-vector.1.10
              (lambda (c.82 tmp.24)
                (let ((vector-init-loop.26 (closure-ref c.82 0)))
                  (let ((tmp.25 (unsafe-make-vector tmp.24)))
                    (closure-call
                     vector-init-loop.26
                     vector-init-loop.26
                     tmp.24
                     0
                     tmp.25)))))
             (L.make-vector.76.11
              (lambda (c.83 tmp.52)
                (let ((make-init-vector.1 (closure-ref c.83 0)))
                  (if (fixnum? tmp.52)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.52)
                    (error 8)))))
             (L.fun/any16598.4.12
              (lambda (c.84)
                (let ((fun/any16599.12 (closure-ref c.84 0)))
                  (closure-call fun/any16599.12 fun/any16599.12))))
             (L.fun/ascii-char16603.5.13 (lambda (c.85) (let () #\])))
             (L.fun/vector16592.6.14
              (lambda (c.86)
                (let ((fun/vector16593.13 (closure-ref c.86 0)))
                  (closure-call fun/vector16593.13 fun/vector16593.13))))
             (L.fun/vector16605.7.15
              (lambda (c.87)
                (let ((make-vector.76 (closure-ref c.87 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/vector16595.8.16
              (lambda (c.88)
                (let ((make-vector.76 (closure-ref c.88 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/void16601.9.17 (lambda (c.89) (let () (void))))
             (L.fun/ascii-char16597.10.18 (lambda (c.90) (let () #\c)))
             (L.fun/vector16604.11.19
              (lambda (c.91)
                (let ((fun/vector16605.7 (closure-ref c.91 0)))
                  (closure-call fun/vector16605.7 fun/vector16605.7))))
             (L.fun/any16599.12.20
              (lambda (c.92)
                (let ((cons.77 (closure-ref c.92 0)))
                  (closure-call cons.77 cons.77 178 511))))
             (L.fun/vector16593.13.21
              (lambda (c.93)
                (let ((make-vector.76 (closure-ref c.93 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/ascii-char16596.14.22
              (lambda (c.94)
                (let ((fun/ascii-char16597.10 (closure-ref c.94 0)))
                  (closure-call
                   fun/ascii-char16597.10
                   fun/ascii-char16597.10))))
             (L.fun/ascii-char16602.15.23
              (lambda (c.95)
                (let ((fun/ascii-char16603.5 (closure-ref c.95 0)))
                  (closure-call fun/ascii-char16603.5 fun/ascii-char16603.5))))
             (L.fun/void16600.16.24
              (lambda (c.96)
                (let ((fun/void16601.9 (closure-ref c.96 0)))
                  (closure-call fun/void16601.9 fun/void16601.9))))
             (L.fun/vector16594.17.25
              (lambda (c.97)
                (let ((fun/vector16595.8 (closure-ref c.97 0)))
                  (closure-call fun/vector16595.8 fun/vector16595.8)))))
      (cletrec
       ((procedure?.78 (make-closure L.procedure?.78.7 1))
        (cons.77 (make-closure L.cons.77.8 2))
        (vector-init-loop.26
         (make-closure L.vector-init-loop.26.9 3 vector-init-loop.26))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.10 1 vector-init-loop.26))
        (make-vector.76
         (make-closure L.make-vector.76.11 1 make-init-vector.1))
        (fun/any16598.4 (make-closure L.fun/any16598.4.12 0 fun/any16599.12))
        (fun/ascii-char16603.5 (make-closure L.fun/ascii-char16603.5.13 0))
        (fun/vector16592.6
         (make-closure L.fun/vector16592.6.14 0 fun/vector16593.13))
        (fun/vector16605.7
         (make-closure L.fun/vector16605.7.15 0 make-vector.76))
        (fun/vector16595.8
         (make-closure L.fun/vector16595.8.16 0 make-vector.76))
        (fun/void16601.9 (make-closure L.fun/void16601.9.17 0))
        (fun/ascii-char16597.10 (make-closure L.fun/ascii-char16597.10.18 0))
        (fun/vector16604.11
         (make-closure L.fun/vector16604.11.19 0 fun/vector16605.7))
        (fun/any16599.12 (make-closure L.fun/any16599.12.20 0 cons.77))
        (fun/vector16593.13
         (make-closure L.fun/vector16593.13.21 0 make-vector.76))
        (fun/ascii-char16596.14
         (make-closure L.fun/ascii-char16596.14.22 0 fun/ascii-char16597.10))
        (fun/ascii-char16602.15
         (make-closure L.fun/ascii-char16602.15.23 0 fun/ascii-char16603.5))
        (fun/void16600.16
         (make-closure L.fun/void16600.16.24 0 fun/void16601.9))
        (fun/vector16594.17
         (make-closure L.fun/vector16594.17.25 0 fun/vector16595.8)))
       (let ((vector0.23 (closure-call fun/vector16592.6 fun/vector16592.6))
             (vector1.22 (closure-call fun/vector16594.17 fun/vector16594.17))
             (ascii-char2.21
              (closure-call fun/ascii-char16596.14 fun/ascii-char16596.14))
             (boolean3.20
              (closure-call
               procedure?.78
               procedure?.78
               (closure-call fun/any16598.4 fun/any16598.4)))
             (void4.19 (closure-call fun/void16600.16 fun/void16600.16))
             (ascii-char5.18
              (closure-call fun/ascii-char16602.15 fun/ascii-char16602.15)))
         (closure-call fun/vector16604.11 fun/vector16604.11))))))
(check-by-interp
 '(module
    (letrec ((L.void?.79.7 (lambda (c.81 tmp.64) (let () (void? tmp.64))))
             (L.vector?.78.8 (lambda (c.82 tmp.68) (let () (vector? tmp.68))))
             (L.cons.77.9
              (lambda (c.83 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
             (L.vector-init-loop.26.10
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
             (L.make-init-vector.1.11
              (lambda (c.85 tmp.24)
                (let ((vector-init-loop.26 (closure-ref c.85 0)))
                  (let ((tmp.25 (unsafe-make-vector tmp.24)))
                    (closure-call
                     vector-init-loop.26
                     vector-init-loop.26
                     tmp.24
                     0
                     tmp.25)))))
             (L.make-vector.76.12
              (lambda (c.86 tmp.52)
                (let ((make-init-vector.1 (closure-ref c.86 0)))
                  (if (fixnum? tmp.52)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.52)
                    (error 8)))))
             (L.fun/vector18001.4.13
              (lambda (c.87)
                (let ((make-vector.76 (closure-ref c.87 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/vector17999.5.14
              (lambda (c.88)
                (let ((make-vector.76 (closure-ref c.88 0)))
                  (closure-call make-vector.76 make-vector.76 8))))
             (L.fun/vector17998.6.15
              (lambda (c.89)
                (let ((fun/vector17999.5 (closure-ref c.89 0)))
                  (closure-call fun/vector17999.5 fun/vector17999.5))))
             (L.fun/ascii-char18008.7.16
              (lambda (c.90)
                (let ((fun/ascii-char18009.17 (closure-ref c.90 0)))
                  (closure-call
                   fun/ascii-char18009.17
                   fun/ascii-char18009.17))))
             (L.fun/void18006.8.17
              (lambda (c.91)
                (let ((fun/void18007.12 (closure-ref c.91 0)))
                  (closure-call fun/void18007.12 fun/void18007.12))))
             (L.fun/any18002.9.18
              (lambda (c.92)
                (let ((fun/any18003.14 (closure-ref c.92 0)))
                  (closure-call fun/any18003.14 fun/any18003.14))))
             (L.fun/empty17997.10.19 (lambda (c.93) (let () empty)))
             (L.fun/any18005.11.20 (lambda (c.94) (let () (error 158))))
             (L.fun/void18007.12.21 (lambda (c.95) (let () (void))))
             (L.fun/any18004.13.22
              (lambda (c.96)
                (let ((fun/any18005.11 (closure-ref c.96 0)))
                  (closure-call fun/any18005.11 fun/any18005.11))))
             (L.fun/any18003.14.23
              (lambda (c.97)
                (let ((cons.77 (closure-ref c.97 0)))
                  (closure-call cons.77 cons.77 98 287))))
             (L.fun/vector18000.15.24
              (lambda (c.98)
                (let ((fun/vector18001.4 (closure-ref c.98 0)))
                  (closure-call fun/vector18001.4 fun/vector18001.4))))
             (L.fun/empty17996.16.25
              (lambda (c.99)
                (let ((fun/empty17997.10 (closure-ref c.99 0)))
                  (closure-call fun/empty17997.10 fun/empty17997.10))))
             (L.fun/ascii-char18009.17.26 (lambda (c.100) (let () #\G))))
      (cletrec
       ((void?.79 (make-closure L.void?.79.7 1))
        (vector?.78 (make-closure L.vector?.78.8 1))
        (cons.77 (make-closure L.cons.77.9 2))
        (vector-init-loop.26
         (make-closure L.vector-init-loop.26.10 3 vector-init-loop.26))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.11 1 vector-init-loop.26))
        (make-vector.76
         (make-closure L.make-vector.76.12 1 make-init-vector.1))
        (fun/vector18001.4
         (make-closure L.fun/vector18001.4.13 0 make-vector.76))
        (fun/vector17999.5
         (make-closure L.fun/vector17999.5.14 0 make-vector.76))
        (fun/vector17998.6
         (make-closure L.fun/vector17998.6.15 0 fun/vector17999.5))
        (fun/ascii-char18008.7
         (make-closure L.fun/ascii-char18008.7.16 0 fun/ascii-char18009.17))
        (fun/void18006.8
         (make-closure L.fun/void18006.8.17 0 fun/void18007.12))
        (fun/any18002.9 (make-closure L.fun/any18002.9.18 0 fun/any18003.14))
        (fun/empty17997.10 (make-closure L.fun/empty17997.10.19 0))
        (fun/any18005.11 (make-closure L.fun/any18005.11.20 0))
        (fun/void18007.12 (make-closure L.fun/void18007.12.21 0))
        (fun/any18004.13 (make-closure L.fun/any18004.13.22 0 fun/any18005.11))
        (fun/any18003.14 (make-closure L.fun/any18003.14.23 0 cons.77))
        (fun/vector18000.15
         (make-closure L.fun/vector18000.15.24 0 fun/vector18001.4))
        (fun/empty17996.16
         (make-closure L.fun/empty17996.16.25 0 fun/empty17997.10))
        (fun/ascii-char18009.17 (make-closure L.fun/ascii-char18009.17.26 0)))
       (let ((procedure0.23
              (letrec ((L.lam.80.27
                        (lambda (c.101)
                          (let ((fun/empty17996.16 (closure-ref c.101 0)))
                            (closure-call
                             fun/empty17996.16
                             fun/empty17996.16)))))
                (cletrec
                 ((lam.80 (make-closure L.lam.80.27 0 fun/empty17996.16)))
                 lam.80)))
             (vector1.22 (closure-call fun/vector17998.6 fun/vector17998.6))
             (vector2.21 (closure-call fun/vector18000.15 fun/vector18000.15))
             (boolean3.20
              (closure-call
               vector?.78
               vector?.78
               (closure-call fun/any18002.9 fun/any18002.9)))
             (boolean4.19
              (closure-call
               void?.79
               void?.79
               (closure-call fun/any18004.13 fun/any18004.13)))
             (void5.18 (closure-call fun/void18006.8 fun/void18006.8)))
         (closure-call fun/ascii-char18008.7 fun/ascii-char18008.7))))))
(check-by-interp
 '(module
    (letrec ((L.+.76.7
              (lambda (c.77 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                    (error 2)))))
             (L.-.75.8
              (lambda (c.78 tmp.40 tmp.41)
                (let ()
                  (if (fixnum? tmp.41)
                    (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                    (error 3)))))
             (L.*.74.9
              (lambda (c.79 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                    (error 1)))))
             (L.fun/error18490.4.10
              (lambda (c.80)
                (let ((fun/error18491.8 (closure-ref c.80 0)))
                  (closure-call fun/error18491.8 fun/error18491.8))))
             (L.fun/empty18499.5.11 (lambda (c.81) (let () empty)))
             (L.fun/error18497.6.12 (lambda (c.82) (let () (error 98))))
             (L.fun/ascii-char18492.7.13
              (lambda (c.83)
                (let ((fun/ascii-char18493.13 (closure-ref c.83 0)))
                  (closure-call
                   fun/ascii-char18493.13
                   fun/ascii-char18493.13))))
             (L.fun/error18491.8.14 (lambda (c.84) (let () (error 186))))
             (L.fun/void18494.9.15
              (lambda (c.85)
                (let ((fun/void18495.15 (closure-ref c.85 0)))
                  (closure-call fun/void18495.15 fun/void18495.15))))
             (L.fun/void18489.10.16 (lambda (c.86) (let () (void))))
             (L.fun/empty18498.11.17
              (lambda (c.87)
                (let ((fun/empty18499.5 (closure-ref c.87 0)))
                  (closure-call fun/empty18499.5 fun/empty18499.5))))
             (L.fun/error18496.12.18
              (lambda (c.88)
                (let ((fun/error18497.6 (closure-ref c.88 0)))
                  (closure-call fun/error18497.6 fun/error18497.6))))
             (L.fun/ascii-char18493.13.19 (lambda (c.89) (let () #\Q)))
             (L.fun/void18488.14.20
              (lambda (c.90)
                (let ((fun/void18489.10 (closure-ref c.90 0)))
                  (closure-call fun/void18489.10 fun/void18489.10))))
             (L.fun/void18495.15.21 (lambda (c.91) (let () (void)))))
      (cletrec
       ((|+.76| (make-closure L.+.76.7 2))
        (|-.75| (make-closure L.-.75.8 2))
        (*.74 (make-closure L.*.74.9 2))
        (fun/error18490.4
         (make-closure L.fun/error18490.4.10 0 fun/error18491.8))
        (fun/empty18499.5 (make-closure L.fun/empty18499.5.11 0))
        (fun/error18497.6 (make-closure L.fun/error18497.6.12 0))
        (fun/ascii-char18492.7
         (make-closure L.fun/ascii-char18492.7.13 0 fun/ascii-char18493.13))
        (fun/error18491.8 (make-closure L.fun/error18491.8.14 0))
        (fun/void18494.9
         (make-closure L.fun/void18494.9.15 0 fun/void18495.15))
        (fun/void18489.10 (make-closure L.fun/void18489.10.16 0))
        (fun/empty18498.11
         (make-closure L.fun/empty18498.11.17 0 fun/empty18499.5))
        (fun/error18496.12
         (make-closure L.fun/error18496.12.18 0 fun/error18497.6))
        (fun/ascii-char18493.13 (make-closure L.fun/ascii-char18493.13.19 0))
        (fun/void18488.14
         (make-closure L.fun/void18488.14.20 0 fun/void18489.10))
        (fun/void18495.15 (make-closure L.fun/void18495.15.21 0)))
       (let ((void0.21 (closure-call fun/void18488.14 fun/void18488.14))
             (error1.20 (closure-call fun/error18490.4 fun/error18490.4))
             (fixnum2.19
              (closure-call
               *.74
               *.74
               (closure-call
                |-.75|
                |-.75|
                (closure-call
                 *.74
                 *.74
                 (closure-call *.74 *.74 88 125)
                 (closure-call |-.75| |-.75| 220 155))
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call |-.75| |-.75| 144 224)
                 (closure-call *.74 *.74 186 124)))
               (closure-call
                |-.75|
                |-.75|
                (closure-call
                 |-.75|
                 |-.75|
                 (closure-call |-.75| |-.75| 97 190)
                 (closure-call *.74 *.74 211 147))
                (closure-call
                 |+.76|
                 |+.76|
                 (closure-call *.74 *.74 175 153)
                 (closure-call *.74 *.74 126 159)))))
             (ascii-char3.18
              (closure-call fun/ascii-char18492.7 fun/ascii-char18492.7))
             (void4.17 (closure-call fun/void18494.9 fun/void18494.9))
             (error5.16 (closure-call fun/error18496.12 fun/error18496.12)))
         (closure-call fun/empty18498.11 fun/empty18498.11))))))
(check-by-interp
 '(module
    (letrec ((L.cons.76.7
              (lambda (c.77 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
             (L.fun/empty22590.4.8
              (lambda (c.78)
                (let ((fun/empty22591.9 (closure-ref c.78 0)))
                  (closure-call fun/empty22591.9 fun/empty22591.9))))
             (L.fun/ascii-char22595.5.9 (lambda (c.79) (let () #\b)))
             (L.fun/pair22601.6.10
              (lambda (c.80)
                (let ((cons.76 (closure-ref c.80 0)))
                  (closure-call cons.76 cons.76 100 463))))
             (L.fun/ascii-char22589.7.11 (lambda (c.81) (let () #\[)))
             (L.fun/empty22599.8.12 (lambda (c.82) (let () empty)))
             (L.fun/empty22591.9.13 (lambda (c.83) (let () empty)))
             (L.fun/empty22597.10.14 (lambda (c.84) (let () empty)))
             (L.fun/ascii-char22588.11.15
              (lambda (c.85)
                (let ((fun/ascii-char22589.7 (closure-ref c.85 0)))
                  (closure-call fun/ascii-char22589.7 fun/ascii-char22589.7))))
             (L.fun/error22593.12.16 (lambda (c.86) (let () (error 22))))
             (L.fun/pair22600.13.17
              (lambda (c.87)
                (let ((fun/pair22601.6 (closure-ref c.87 0)))
                  (closure-call fun/pair22601.6 fun/pair22601.6))))
             (L.fun/error22592.14.18
              (lambda (c.88)
                (let ((fun/error22593.12 (closure-ref c.88 0)))
                  (closure-call fun/error22593.12 fun/error22593.12))))
             (L.fun/empty22598.15.19
              (lambda (c.89)
                (let ((fun/empty22599.8 (closure-ref c.89 0)))
                  (closure-call fun/empty22599.8 fun/empty22599.8))))
             (L.fun/empty22596.16.20
              (lambda (c.90)
                (let ((fun/empty22597.10 (closure-ref c.90 0)))
                  (closure-call fun/empty22597.10 fun/empty22597.10))))
             (L.fun/ascii-char22594.17.21
              (lambda (c.91)
                (let ((fun/ascii-char22595.5 (closure-ref c.91 0)))
                  (closure-call
                   fun/ascii-char22595.5
                   fun/ascii-char22595.5)))))
      (cletrec
       ((cons.76 (make-closure L.cons.76.7 2))
        (fun/empty22590.4
         (make-closure L.fun/empty22590.4.8 0 fun/empty22591.9))
        (fun/ascii-char22595.5 (make-closure L.fun/ascii-char22595.5.9 0))
        (fun/pair22601.6 (make-closure L.fun/pair22601.6.10 0 cons.76))
        (fun/ascii-char22589.7 (make-closure L.fun/ascii-char22589.7.11 0))
        (fun/empty22599.8 (make-closure L.fun/empty22599.8.12 0))
        (fun/empty22591.9 (make-closure L.fun/empty22591.9.13 0))
        (fun/empty22597.10 (make-closure L.fun/empty22597.10.14 0))
        (fun/ascii-char22588.11
         (make-closure L.fun/ascii-char22588.11.15 0 fun/ascii-char22589.7))
        (fun/error22593.12 (make-closure L.fun/error22593.12.16 0))
        (fun/pair22600.13
         (make-closure L.fun/pair22600.13.17 0 fun/pair22601.6))
        (fun/error22592.14
         (make-closure L.fun/error22592.14.18 0 fun/error22593.12))
        (fun/empty22598.15
         (make-closure L.fun/empty22598.15.19 0 fun/empty22599.8))
        (fun/empty22596.16
         (make-closure L.fun/empty22596.16.20 0 fun/empty22597.10))
        (fun/ascii-char22594.17
         (make-closure L.fun/ascii-char22594.17.21 0 fun/ascii-char22595.5)))
       (let ((ascii-char0.23
              (closure-call fun/ascii-char22588.11 fun/ascii-char22588.11))
             (empty1.22 (closure-call fun/empty22590.4 fun/empty22590.4))
             (error2.21 (closure-call fun/error22592.14 fun/error22592.14))
             (ascii-char3.20
              (closure-call fun/ascii-char22594.17 fun/ascii-char22594.17))
             (empty4.19 (closure-call fun/empty22596.16 fun/empty22596.16))
             (empty5.18 (closure-call fun/empty22598.15 fun/empty22598.15)))
         (closure-call fun/pair22600.13 fun/pair22600.13))))))
(check-by-interp
 '(module
    (letrec ((L.*.74.7
              (lambda (c.77 tmp.32 tmp.33)
                (let ()
                  (if (fixnum? tmp.33)
                    (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                    (error 1)))))
             (L.+.73.8
              (lambda (c.78 tmp.34 tmp.35)
                (let ()
                  (if (fixnum? tmp.35)
                    (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                    (error 2)))))
             (L.-.72.9
              (lambda (c.79 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
                    (error 3)))))
             (L.boolean?.71.10
              (lambda (c.80 tmp.56) (let () (boolean? tmp.56))))
             (L.cons.70.11
              (lambda (c.81 tmp.65 tmp.66) (let () (cons tmp.65 tmp.66))))
             (L.fun/void23349.4.12 (lambda (c.82) (let () (void))))
             (L.fun/any23351.5.13
              (lambda (c.83)
                (let ((cons.70 (closure-ref c.83 0)))
                  (closure-call cons.70 cons.70 159 398))))
             (L.fun/void23348.6.14
              (lambda (c.84)
                (let ((fun/void23349.4 (closure-ref c.84 0)))
                  (closure-call fun/void23349.4 fun/void23349.4))))
             (L.fun/any23350.7.15
              (lambda (c.85)
                (let ((fun/any23351.5 (closure-ref c.85 0)))
                  (closure-call fun/any23351.5 fun/any23351.5))))
             (L.fun/ascii-char23347.8.16 (lambda (c.86) (let () #\\)))
             (L.fun/ascii-char23346.9.17
              (lambda (c.87)
                (let ((fun/ascii-char23347.8 (closure-ref c.87 0)))
                  (closure-call fun/ascii-char23347.8 fun/ascii-char23347.8))))
             (L.fun/void23353.10.18 (lambda (c.88) (let () (void))))
             (L.fun/void23352.11.19
              (lambda (c.89)
                (let ((fun/void23353.10 (closure-ref c.89 0)))
                  (closure-call fun/void23353.10 fun/void23353.10)))))
      (cletrec
       ((*.74 (make-closure L.*.74.7 2))
        (|+.73| (make-closure L.+.73.8 2))
        (|-.72| (make-closure L.-.72.9 2))
        (boolean?.71 (make-closure L.boolean?.71.10 1))
        (cons.70 (make-closure L.cons.70.11 2))
        (fun/void23349.4 (make-closure L.fun/void23349.4.12 0))
        (fun/any23351.5 (make-closure L.fun/any23351.5.13 0 cons.70))
        (fun/void23348.6 (make-closure L.fun/void23348.6.14 0 fun/void23349.4))
        (fun/any23350.7 (make-closure L.fun/any23350.7.15 0 fun/any23351.5))
        (fun/ascii-char23347.8 (make-closure L.fun/ascii-char23347.8.16 0))
        (fun/ascii-char23346.9
         (make-closure L.fun/ascii-char23346.9.17 0 fun/ascii-char23347.8))
        (fun/void23353.10 (make-closure L.fun/void23353.10.18 0))
        (fun/void23352.11
         (make-closure L.fun/void23352.11.19 0 fun/void23353.10)))
       (let ((ascii-char0.17
              (closure-call fun/ascii-char23346.9 fun/ascii-char23346.9))
             (void1.16 (closure-call fun/void23348.6 fun/void23348.6))
             (boolean2.15
              (closure-call
               boolean?.71
               boolean?.71
               (closure-call fun/any23350.7 fun/any23350.7)))
             (procedure3.14
              (letrec ((L.lam.75.20
                        (lambda (c.90)
                          (let ((*.74 (closure-ref c.90 0))
                                (|-.72| (closure-ref c.90 1))
                                (|+.73| (closure-ref c.90 2)))
                            (closure-call
                             |+.73|
                             |+.73|
                             (closure-call
                              |+.73|
                              |+.73|
                              (closure-call
                               |+.73|
                               |+.73|
                               (closure-call |-.72| |-.72| 239 118)
                               (closure-call |-.72| |-.72| 38 153))
                              (closure-call
                               |+.73|
                               |+.73|
                               (closure-call *.74 *.74 128 179)
                               (closure-call |-.72| |-.72| 208 217)))
                             (closure-call
                              |-.72|
                              |-.72|
                              (closure-call
                               |+.73|
                               |+.73|
                               (closure-call |-.72| |-.72| 121 152)
                               (closure-call *.74 *.74 212 8))
                              (closure-call
                               *.74
                               *.74
                               (closure-call *.74 *.74 175 82)
                               (closure-call |-.72| |-.72| 52 179))))))))
                (cletrec
                 ((lam.75 (make-closure L.lam.75.20 0 *.74 |-.72| |+.73|)))
                 lam.75)))
             (fixnum4.13
              (closure-call
               *.74
               *.74
               (closure-call
                |-.72|
                |-.72|
                (closure-call
                 *.74
                 *.74
                 (closure-call |-.72| |-.72| 100 80)
                 (closure-call |+.73| |+.73| 40 93))
                (closure-call
                 |+.73|
                 |+.73|
                 (closure-call |-.72| |-.72| 163 92)
                 (closure-call |-.72| |-.72| 230 103)))
               (closure-call
                |-.72|
                |-.72|
                (closure-call
                 |-.72|
                 |-.72|
                 (closure-call |-.72| |-.72| 47 61)
                 (closure-call |-.72| |-.72| 139 24))
                (closure-call
                 |+.73|
                 |+.73|
                 (closure-call *.74 *.74 103 132)
                 (closure-call |+.73| |+.73| 140 95)))))
             (procedure5.12
              (letrec ((L.lam.76.21
                        (lambda (c.91)
                          (let ((fun/void23352.11 (closure-ref c.91 0)))
                            (closure-call
                             fun/void23352.11
                             fun/void23352.11)))))
                (cletrec
                 ((lam.76 (make-closure L.lam.76.21 0 fun/void23352.11)))
                 lam.76))))
         (closure-call
          |-.72|
          |-.72|
          (closure-call
           *.74
           *.74
           (if (procedure? procedure3.14)
             (if (eq? (unsafe-procedure-arity procedure3.14) 0)
               (closure-call procedure3.14 procedure3.14)
               (error 42))
             (error 43))
           (if (procedure? procedure3.14)
             (if (eq? (unsafe-procedure-arity procedure3.14) 0)
               (closure-call procedure3.14 procedure3.14)
               (error 42))
             (error 43)))
          (closure-call
           |+.73|
           |+.73|
           (closure-call
            *.74
            *.74
            (closure-call *.74 *.74 105 226)
            (closure-call |+.73| |+.73| 43 81))
           (closure-call
            |+.73|
            |+.73|
            (closure-call *.74 *.74 245 145)
            (closure-call *.74 *.74 109 196)))))))))
(check-by-interp
 '(module
    (letrec ((L.empty?.78.7 (lambda (c.81 tmp.61) (let () (empty? tmp.61))))
             (L.-.77.8
              (lambda (c.82 tmp.40 tmp.41)
                (let ()
                  (if (fixnum? tmp.41)
                    (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
                    (error 3)))))
             (L.+.76.9
              (lambda (c.83 tmp.38 tmp.39)
                (let ()
                  (if (fixnum? tmp.39)
                    (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
                    (error 2)))))
             (L.*.75.10
              (lambda (c.84 tmp.36 tmp.37)
                (let ()
                  (if (fixnum? tmp.37)
                    (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
                    (error 1)))))
             (L.vector-init-loop.24.11
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
             (L.make-init-vector.1.12
              (lambda (c.86 tmp.22)
                (let ((vector-init-loop.24 (closure-ref c.86 0)))
                  (let ((tmp.23 (unsafe-make-vector tmp.22)))
                    (closure-call
                     vector-init-loop.24
                     vector-init-loop.24
                     tmp.22
                     0
                     tmp.23)))))
             (L.make-vector.74.13
              (lambda (c.87 tmp.50)
                (let ((make-init-vector.1 (closure-ref c.87 0)))
                  (if (fixnum? tmp.50)
                    (closure-call make-init-vector.1 make-init-vector.1 tmp.50)
                    (error 8)))))
             (L.fun/vector24625.4.14
              (lambda (c.88)
                (let ((fun/vector24626.15 (closure-ref c.88 0)))
                  (closure-call fun/vector24626.15 fun/vector24626.15))))
             (L.fun/any24628.5.15 (lambda (c.89) (let () empty)))
             (L.fun/error24633.6.16
              (lambda (c.90)
                (let ((fun/error24634.12 (closure-ref c.90 0)))
                  (closure-call fun/error24634.12 fun/error24634.12))))
             (L.fun/empty24629.7.17
              (lambda (c.91)
                (let ((fun/empty24630.11 (closure-ref c.91 0)))
                  (closure-call fun/empty24630.11 fun/empty24630.11))))
             (L.fun/error24636.8.18 (lambda (c.92) (let () (error 205))))
             (L.fun/void24632.9.19 (lambda (c.93) (let () (void))))
             (L.fun/void24631.10.20
              (lambda (c.94)
                (let ((fun/void24632.9 (closure-ref c.94 0)))
                  (closure-call fun/void24632.9 fun/void24632.9))))
             (L.fun/empty24630.11.21 (lambda (c.95) (let () empty)))
             (L.fun/error24634.12.22 (lambda (c.96) (let () (error 74))))
             (L.fun/error24635.13.23
              (lambda (c.97)
                (let ((fun/error24636.8 (closure-ref c.97 0)))
                  (closure-call fun/error24636.8 fun/error24636.8))))
             (L.fun/any24627.14.24
              (lambda (c.98)
                (let ((fun/any24628.5 (closure-ref c.98 0)))
                  (closure-call fun/any24628.5 fun/any24628.5))))
             (L.fun/vector24626.15.25
              (lambda (c.99)
                (let ((make-vector.74 (closure-ref c.99 0)))
                  (closure-call make-vector.74 make-vector.74 8)))))
      (cletrec
       ((empty?.78 (make-closure L.empty?.78.7 1))
        (|-.77| (make-closure L.-.77.8 2))
        (|+.76| (make-closure L.+.76.9 2))
        (*.75 (make-closure L.*.75.10 2))
        (vector-init-loop.24
         (make-closure L.vector-init-loop.24.11 3 vector-init-loop.24))
        (make-init-vector.1
         (make-closure L.make-init-vector.1.12 1 vector-init-loop.24))
        (make-vector.74
         (make-closure L.make-vector.74.13 1 make-init-vector.1))
        (fun/vector24625.4
         (make-closure L.fun/vector24625.4.14 0 fun/vector24626.15))
        (fun/any24628.5 (make-closure L.fun/any24628.5.15 0))
        (fun/error24633.6
         (make-closure L.fun/error24633.6.16 0 fun/error24634.12))
        (fun/empty24629.7
         (make-closure L.fun/empty24629.7.17 0 fun/empty24630.11))
        (fun/error24636.8 (make-closure L.fun/error24636.8.18 0))
        (fun/void24632.9 (make-closure L.fun/void24632.9.19 0))
        (fun/void24631.10
         (make-closure L.fun/void24631.10.20 0 fun/void24632.9))
        (fun/empty24630.11 (make-closure L.fun/empty24630.11.21 0))
        (fun/error24634.12 (make-closure L.fun/error24634.12.22 0))
        (fun/error24635.13
         (make-closure L.fun/error24635.13.23 0 fun/error24636.8))
        (fun/any24627.14 (make-closure L.fun/any24627.14.24 0 fun/any24628.5))
        (fun/vector24626.15
         (make-closure L.fun/vector24626.15.25 0 make-vector.74)))
       (let ((fixnum0.21
              (closure-call
               |-.77|
               |-.77|
               (closure-call
                *.75
                *.75
                (closure-call
                 |+.76|
                 |+.76|
                 (closure-call *.75 *.75 148 145)
                 (closure-call *.75 *.75 226 44))
                (closure-call
                 *.75
                 *.75
                 (closure-call |+.76| |+.76| 65 170)
                 (closure-call |-.77| |-.77| 129 146)))
               (closure-call
                |+.76|
                |+.76|
                (closure-call
                 |+.76|
                 |+.76|
                 (closure-call |+.76| |+.76| 24 189)
                 (closure-call |-.77| |-.77| 110 80))
                (closure-call
                 |+.76|
                 |+.76|
                 (closure-call |-.77| |-.77| 191 251)
                 (closure-call |-.77| |-.77| 78 207)))))
             (vector1.20 (closure-call fun/vector24625.4 fun/vector24625.4))
             (boolean2.19
              (closure-call
               empty?.78
               empty?.78
               (closure-call fun/any24627.14 fun/any24627.14)))
             (procedure3.18
              (letrec ((L.lam.79.26
                        (lambda (c.100)
                          (let ((fun/empty24629.7 (closure-ref c.100 0)))
                            (closure-call
                             fun/empty24629.7
                             fun/empty24629.7)))))
                (cletrec
                 ((lam.79 (make-closure L.lam.79.26 0 fun/empty24629.7)))
                 lam.79)))
             (procedure4.17
              (letrec ((L.lam.80.27
                        (lambda (c.101)
                          (let ((fun/void24631.10 (closure-ref c.101 0)))
                            (closure-call
                             fun/void24631.10
                             fun/void24631.10)))))
                (cletrec
                 ((lam.80 (make-closure L.lam.80.27 0 fun/void24631.10)))
                 lam.80)))
             (error5.16 (closure-call fun/error24633.6 fun/error24633.6)))
         (closure-call fun/error24635.13 fun/error24635.13))))))
