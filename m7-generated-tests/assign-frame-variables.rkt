#lang racket
(require rackunit
         cpsc411/langs/v7
         (only-in "../assign-frame-variables.rkt" assign-frame-variables))

(define (check-asm-pred-lang-v7/spilled p)
  (if (asm-pred-lang-v7/spilled? p) p #f))

(define (check-asm-pred-lang-v7/assignments p)
  (if (asm-pred-lang-v7/assignments? p) p #f))

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-asm-pred-lang-v7/spilled (check-asm-pred-lang-v7/spilled p))
                (interp-asm-pred-lang-v7/assignments
                 (check-asm-pred-lang-v7/assignments (assign-frame-variables p)))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 0)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 8)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 6)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 14)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 13102)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 18990)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.24 (rax rbp)) (rbp (rax tmp-ra.24))
                                                                         (rax (rbp tmp-ra.24))))
                                       (assignment ((tmp-ra.24 r15))))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 30)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.29 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.29))
                                                             (rsi (r15 rdi rbp tmp-ra.29))
                                                             (rdi (r15 rbp rsi tmp-ra.29))
                                                             (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.29 r15))))
          (define L.+.1
            ((locals ())
             (conflicts
              ((tmp.24 (rbp tmp-ra.28 tmp.4 tmp.3))
               (tmp.30 (tmp.4 rbp tmp-ra.28 tmp.3))
               (tmp.4 (rbp tmp-ra.28 tmp.3 tmp.30 tmp.25 tmp.24 tmp.31 tmp.27 tmp.26 tmp.32))
               (tmp.25 (rbp tmp-ra.28 tmp.4 tmp.3))
               (tmp-ra.28
                (tmp.4 tmp.3 rbp rsi rdi tmp.30 tmp.25 tmp.24 tmp.31 tmp.27 tmp.26 tmp.32 rax))
               (tmp.32 (rbp tmp-ra.28 tmp.4))
               (tmp.27 (rbp tmp-ra.28 tmp.4 tmp.3))
               (tmp.3 (tmp.4 rbp tmp-ra.28 rsi tmp.30 tmp.25 tmp.24 tmp.31 tmp.27 tmp.26))
               (tmp.31 (tmp.3 rbp tmp-ra.28 tmp.4))
               (tmp.26 (rbp tmp-ra.28 tmp.4 tmp.3))
               (rax (rbp tmp-ra.28))
               (rbp (tmp.4 tmp.3 tmp-ra.28 tmp.30 tmp.25 tmp.24 tmp.31 tmp.27 tmp.26 tmp.32 rax))
               (rdi (tmp-ra.28))
               (rsi (tmp.3 tmp-ra.28))))
             (assignment ((tmp-ra.28 r15) (tmp.4 r14)
                                          (tmp.3 r13)
                                          (tmp.24 r9)
                                          (tmp.30 r9)
                                          (tmp.25 r9)
                                          (tmp.27 r9)
                                          (tmp.31 r9)
                                          (tmp.26 r9)
                                          (tmp.32 r13))))
            (begin
              (set! tmp-ra.28 r15)
              (set! tmp.3 rdi)
              (set! tmp.4 rsi)
              (if (begin
                    (if (begin
                          (begin
                            (set! tmp.30 tmp.4)
                            (set! tmp.30 (bitwise-and tmp.30 7))
                            (set! tmp.25 tmp.30))
                          (= tmp.25 0))
                        (set! tmp.24 14)
                        (set! tmp.24 6))
                    (!= tmp.24 6))
                  (if (begin
                        (if (begin
                              (begin
                                (set! tmp.31 tmp.3)
                                (set! tmp.31 (bitwise-and tmp.31 7))
                                (set! tmp.27 tmp.31))
                              (= tmp.27 0))
                            (set! tmp.26 14)
                            (set! tmp.26 6))
                        (!= tmp.26 6))
                      (begin
                        (set! tmp.32 tmp.3)
                        (set! tmp.32 (+ tmp.32 tmp.4))
                        (set! rax tmp.32)
                        (jump tmp-ra.28 rbp rax))
                      (begin
                        (set! rax 574)
                        (jump tmp-ra.28 rbp rax)))
                  (begin
                    (set! rax 574)
                    (jump tmp-ra.28 rbp rax)))))
    (begin
      (set! tmp-ra.29 r15)
      (set! rsi 0)
      (set! rdi 0)
      (set! r15 tmp-ra.29)
      (jump L.+.1 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.25 (rdi rbp)) (rbp (r15 rdi tmp-ra.25))
                                                         (rdi (r15 rbp tmp-ra.25))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.25 r15))))
          (define L.not.1
            ((locals ()) (conflicts ((tmp.23 (rbp tmp-ra.24)) (tmp-ra.24 (tmp.23 rbp rdi rax))
                                                              (rax (rbp tmp-ra.24))
                                                              (rbp (tmp.23 tmp-ra.24 rax))
                                                              (rdi (tmp-ra.24))))
                         (assignment ((tmp-ra.24 r15) (tmp.23 r14))))
            (begin
              (set! tmp-ra.24 r15)
              (set! tmp.23 rdi)
              (if (!= tmp.23 6)
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.24 rbp rax))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.24 rbp rax)))))
    (begin
      (set! tmp-ra.25 r15)
      (set! rdi 6)
      (set! r15 tmp-ra.25)
      (jump L.not.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.25 (rdi rbp)) (rbp (r15 rdi tmp-ra.25))
                                                         (rdi (r15 rbp tmp-ra.25))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.25 r15))))
          (define L.not.1
            ((locals ()) (conflicts ((tmp.23 (rbp tmp-ra.24)) (tmp-ra.24 (tmp.23 rbp rdi rax))
                                                              (rax (rbp tmp-ra.24))
                                                              (rbp (tmp.23 tmp-ra.24 rax))
                                                              (rdi (tmp-ra.24))))
                         (assignment ((tmp-ra.24 r15) (tmp.23 r14))))
            (begin
              (set! tmp-ra.24 r15)
              (set! tmp.23 rdi)
              (if (!= tmp.23 6)
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.24 rbp rax))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.24 rbp rax)))))
    (begin
      (set! tmp-ra.25 r15)
      (set! rdi 14)
      (set! r15 tmp-ra.25)
      (jump L.not.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp.25 (rbp tmp-ra.24)) (tmp-ra.24 (rbp tmp.25 rax))
                                                            (rax (rbp tmp-ra.24))
                                                            (rbp (tmp-ra.24 tmp.25 rax))))
                       (assignment ((tmp-ra.24 r15) (tmp.25 r14))))
          (begin
            (set! tmp-ra.24 r15)
            (if (begin
                  (set! tmp.25 6)
                  (!= tmp.25 6))
                (begin
                  (set! rax 22)
                  (jump tmp-ra.24 rbp rax))
                (begin
                  (set! rax 0)
                  (jump tmp-ra.24 rbp rax))))
    ))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.fixnum?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.17 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.17 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.17 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.17 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.17 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.17)
                      (set! tmp.27 (bitwise-and tmp.27 7))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 0))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 14)
      (set! r15 tmp-ra.26)
      (jump L.fixnum?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.error?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.22 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.22 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.22 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.22 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.22 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.22)
                      (set! tmp.27 (bitwise-and tmp.27 255))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 62))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 30)
      (set! r15 tmp-ra.26)
      (jump L.error?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.fixnum?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.17 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.17 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.17 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.17 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.17 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.17)
                      (set! tmp.27 (bitwise-and tmp.27 7))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 0))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 22)
      (set! r15 tmp-ra.26)
      (jump L.fixnum?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.ascii-char?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.21 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.21 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.21 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.21 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.21 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.21)
                      (set! tmp.27 (bitwise-and tmp.27 255))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 14)
      (set! r15 tmp-ra.26)
      (jump L.ascii-char?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.boolean?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.18 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.18 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.18 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.18 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.18 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.18)
                      (set! tmp.27 (bitwise-and tmp.27 247))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 6))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 30)
      (set! r15 tmp-ra.26)
      (jump L.boolean?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.26 (rdi rbp)) (rbp (r15 rdi tmp-ra.26))
                                                         (rdi (r15 rbp tmp-ra.26))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.26 r15))))
          (define L.ascii-char?.1
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.21 (rbp tmp-ra.25))
                                                  (tmp.27 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.21 rbp rdi tmp.27 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.21 tmp-ra.25 tmp.27 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.21 r14) (tmp.27 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.21 rdi)
              (if (begin
                    (begin
                      (set! tmp.27 tmp.21)
                      (set! tmp.27 (bitwise-and tmp.27 255))
                      (set! tmp.24 tmp.27))
                    (= tmp.24 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (begin
      (set! tmp-ra.26 r15)
      (set! rdi 30)
      (set! r15 tmp-ra.26)
      (jump L.ascii-char?.1 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.25 (rax foobar.8.1 rbp)) (foobar.8.1 (rbp tmp-ra.25))
                                                                    (rbp (rax foobar.8.1 tmp-ra.25))
                                                                    (rax (rbp tmp-ra.25))))
                       (assignment ((tmp-ra.25 r15) (foobar.8.1 r14))))
          (begin
            (set! tmp-ra.25 r15)
            (set! foobar.8.1 6)
            (set! rax foobar.8.1)
            (jump tmp-ra.25 rbp rax))
    ))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.26 (rax bat.1.1 foobar.2.2 rbp))
                                                   (foobar.2.2 (bat.1.1 rbp tmp-ra.26))
                                                   (bat.1.1 (rbp tmp-ra.26 foobar.2.2))
                                                   (rbp (rax bat.1.1 foobar.2.2 tmp-ra.26))
                                                   (rax (rbp tmp-ra.26))))
                                       (assignment ((tmp-ra.26 r15) (foobar.2.2 r14) (bat.1.1 r13))))
                          (begin
                            (set! tmp-ra.26 r15)
                            (set! foobar.2.2 25646)
                            (set! bat.1.1 28206)
                            (set! rax foobar.2.2)
                            (jump tmp-ra.26 rbp rax))
                    ))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.27 (rdi rbp)) (rbp (r15 rdi tmp-ra.27))
                                                         (rdi (r15 rbp tmp-ra.27))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.27 r15))))
          (define L.void?.2
            ((locals ())
             (conflicts ((tmp.24 (rbp tmp-ra.25)) (tmp.20 (rbp tmp-ra.25))
                                                  (tmp.28 (rbp tmp-ra.25))
                                                  (tmp-ra.25 (tmp.20 rbp rdi tmp.28 tmp.24 rax))
                                                  (rax (rbp tmp-ra.25))
                                                  (rbp (tmp.20 tmp-ra.25 tmp.28 tmp.24 rax))
                                                  (rdi (tmp-ra.25))))
             (assignment ((tmp-ra.25 r15) (tmp.24 r14) (tmp.20 r14) (tmp.28 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! tmp.20 rdi)
              (if (begin
                    (begin
                      (set! tmp.28 tmp.20)
                      (set! tmp.28 (bitwise-and tmp.28 255))
                      (set! tmp.24 tmp.28))
                    (= tmp.24 30))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.25 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.25 rbp rax)))))
    (define L.proc.0.1
      ((locals ()) (conflicts ((tmp-ra.26 (rax rbp)) (rbp (rax tmp-ra.26)) (rax (rbp tmp-ra.26))))
                   (assignment ((tmp-ra.26 r15))))
      (begin
        (set! tmp-ra.26 r15)
        (set! rax 14)
        (jump tmp-ra.26 rbp rax)))
    (begin
      (set! tmp-ra.27 r15)
      (set! rdi 8)
      (set! r15 tmp-ra.27)
      (jump L.void?.2 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.31 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.31))
                                                             (rsi (r15 rdi rbp tmp-ra.31))
                                                             (rdi (r15 rbp rsi tmp-ra.31))
                                                             (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.31 r15))))
          (define L.<=.2
            ((locals ())
             (conflicts
              ((tmp.25 (rbp tmp-ra.29 tmp.10 tmp.11))
               (tmp.32 (tmp.11 rbp tmp-ra.29 tmp.10))
               (tmp.11 (rbp tmp-ra.29 tmp.10 tmp.32 tmp.26 tmp.25 tmp.33 tmp.28 tmp.27))
               (tmp.26 (rbp tmp-ra.29 tmp.10 tmp.11))
               (tmp-ra.29 (tmp.11 tmp.10 rbp rsi rdi tmp.32 tmp.26 tmp.25 tmp.33 tmp.28 tmp.27 rax))
               (tmp.28 (rbp tmp-ra.29 tmp.10 tmp.11))
               (tmp.10 (tmp.11 rbp tmp-ra.29 rsi tmp.32 tmp.26 tmp.25 tmp.33 tmp.28 tmp.27))
               (tmp.33 (tmp.10 rbp tmp-ra.29 tmp.11))
               (tmp.27 (rbp tmp-ra.29 tmp.10 tmp.11))
               (rax (rbp tmp-ra.29))
               (rbp (tmp.11 tmp.10 tmp-ra.29 tmp.32 tmp.26 tmp.25 tmp.33 tmp.28 tmp.27 rax))
               (rdi (tmp-ra.29))
               (rsi (tmp.10 tmp-ra.29))))
             (assignment ((tmp-ra.29 r15) (tmp.10 r14)
                                          (tmp.11 r13)
                                          (tmp.25 r9)
                                          (tmp.32 r9)
                                          (tmp.26 r9)
                                          (tmp.28 r9)
                                          (tmp.33 r9)
                                          (tmp.27 r9))))
            (begin
              (set! tmp-ra.29 r15)
              (set! tmp.10 rdi)
              (set! tmp.11 rsi)
              (if (begin
                    (if (begin
                          (begin
                            (set! tmp.32 tmp.11)
                            (set! tmp.32 (bitwise-and tmp.32 7))
                            (set! tmp.26 tmp.32))
                          (= tmp.26 0))
                        (set! tmp.25 14)
                        (set! tmp.25 6))
                    (!= tmp.25 6))
                  (if (begin
                        (if (begin
                              (begin
                                (set! tmp.33 tmp.10)
                                (set! tmp.33 (bitwise-and tmp.33 7))
                                (set! tmp.28 tmp.33))
                              (= tmp.28 0))
                            (set! tmp.27 14)
                            (set! tmp.27 6))
                        (!= tmp.27 6))
                      (if (<= tmp.10 tmp.11)
                          (begin
                            (set! rax 14)
                            (jump tmp-ra.29 rbp rax))
                          (begin
                            (set! rax 6)
                            (jump tmp-ra.29 rbp rax)))
                      (begin
                        (set! rax 1342)
                        (jump tmp-ra.29 rbp rax)))
                  (begin
                    (set! rax 1342)
                    (jump tmp-ra.29 rbp rax)))))
    (define L.tmp.0.1
      ((locals ()) (conflicts ((tmp-ra.30 (rax foo.9.1 rbp rdi)) (foo.9.1 (rbp tmp-ra.30))
                                                                 (rdi (tmp-ra.30))
                                                                 (rbp (rax foo.9.1 tmp-ra.30))
                                                                 (rax (rbp tmp-ra.30))))
                   (assignment ((tmp-ra.30 r15) (foo.9.1 r14))))
      (begin
        (set! tmp-ra.30 r15)
        (set! foo.9.1 rdi)
        (set! rax 14)
        (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (set! rsi 0)
      (set! rdi 0)
      (set! r15 tmp-ra.31)
      (jump L.<=.2 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.27 (rax foo.5.1 foo.2.2 foobar.1.3 rbp))
                                   (foobar.1.3 (rbp tmp-ra.27))
                                   (foo.2.2 (rbp tmp-ra.27))
                                   (foo.5.1 (rbp tmp-ra.27))
                                   (rbp (rax foo.5.1 foo.2.2 foobar.1.3 tmp-ra.27))
                                   (rax (rbp tmp-ra.27))))
                       (assignment ((tmp-ra.27 r15) (foobar.1.3 r14) (foo.2.2 r14) (foo.5.1 r14))))
          (begin
            (set! tmp-ra.27 r15)
            (set! foobar.1.3 6)
            (set! foo.2.2 22)
            (set! foo.5.1 1086429096)
            (set! rax 22)
            (jump tmp-ra.27 rbp rax))
    ))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.30 (rax rbp)) (rbp (rax tmp-ra.30)) (rax (rbp tmp-ra.30))))
                       (assignment ((tmp-ra.30 r15))))
          (define L.x.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.29 (rax ball.5.1 ball.3.2 foo.8.3 ball.9.4 foo.4.5 rbp r8 rcx rdx rsi rdi))
               (foo.4.5 (rbp tmp-ra.29 r8 rcx rdx rsi))
               (ball.9.4 (rbp tmp-ra.29 r8 rcx rdx))
               (foo.8.3 (rbp tmp-ra.29 r8 rcx))
               (ball.3.2 (rbp tmp-ra.29 r8))
               (ball.5.1 (rbp tmp-ra.29))
               (rdi (tmp-ra.29))
               (rsi (foo.4.5 tmp-ra.29))
               (rdx (ball.9.4 foo.4.5 tmp-ra.29))
               (rcx (foo.8.3 ball.9.4 foo.4.5 tmp-ra.29))
               (r8 (ball.3.2 foo.8.3 ball.9.4 foo.4.5 tmp-ra.29))
               (rbp (rax ball.5.1 ball.3.2 foo.8.3 ball.9.4 foo.4.5 tmp-ra.29))
               (rax (rbp tmp-ra.29))))
             (assignment ((tmp-ra.29 r15) (foo.4.5 r14)
                                          (ball.9.4 r14)
                                          (foo.8.3 r14)
                                          (ball.3.2 r14)
                                          (ball.5.1 r14))))
            (begin
              (set! tmp-ra.29 r15)
              (set! foo.4.5 rdi)
              (set! ball.9.4 rsi)
              (set! foo.8.3 rdx)
              (set! ball.3.2 rcx)
              (set! ball.5.1 r8)
              (set! rax -3961536528)
              (jump tmp-ra.29 rbp rax)))
    (begin
      (set! tmp-ra.30 r15)
      (set! rax 14)
      (jump tmp-ra.30 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.31 (rax rbp)) (rbp (rax tmp-ra.31)) (rax (rbp tmp-ra.31))))
                       (assignment ((tmp-ra.31 r15))))
          (define L.func.0.1
            ((locals ())
             (conflicts ((tmp-ra.30 (rax foo.1.1
                                         ball.0.2
                                         bar.8.3
                                         bat.5.4
                                         foobar.9.5
                                         foobar.2.6
                                         rbp
                                         r9
                                         r8
                                         rcx
                                         rdx
                                         rsi
                                         rdi))
                         (foobar.2.6 (rbp tmp-ra.30 r9 r8 rcx rdx rsi))
                         (foobar.9.5 (rbp tmp-ra.30 r9 r8 rcx rdx))
                         (bat.5.4 (rbp tmp-ra.30 r9 r8 rcx))
                         (bar.8.3 (rbp tmp-ra.30 r9 r8))
                         (ball.0.2 (rbp tmp-ra.30 r9))
                         (foo.1.1 (rbp tmp-ra.30))
                         (rdi (tmp-ra.30))
                         (rsi (foobar.2.6 tmp-ra.30))
                         (rdx (foobar.9.5 foobar.2.6 tmp-ra.30))
                         (rcx (bat.5.4 foobar.9.5 foobar.2.6 tmp-ra.30))
                         (r8 (bar.8.3 bat.5.4 foobar.9.5 foobar.2.6 tmp-ra.30))
                         (r9 (ball.0.2 bar.8.3 bat.5.4 foobar.9.5 foobar.2.6 tmp-ra.30))
                         (rbp (rax foo.1.1 ball.0.2 bar.8.3 bat.5.4 foobar.9.5 foobar.2.6 tmp-ra.30))
                         (rax (rbp tmp-ra.30))))
             (assignment ((tmp-ra.30 r15) (foobar.2.6 r14)
                                          (foobar.9.5 r14)
                                          (bat.5.4 r14)
                                          (bar.8.3 r14)
                                          (ball.0.2 r14)
                                          (foo.1.1 r14))))
            (begin
              (set! tmp-ra.30 r15)
              (set! foobar.2.6 rdi)
              (set! foobar.9.5 rsi)
              (set! bat.5.4 rdx)
              (set! bar.8.3 rcx)
              (set! ball.0.2 r8)
              (set! foo.1.1 r9)
              (set! rax 8)
              (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (set! rax 6)
      (jump tmp-ra.31 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.27 (rax rbp)) (rbp (rax tmp-ra.27)) (rax (rbp tmp-ra.27))))
                       (assignment ((tmp-ra.27 r15))))
          (define L.fn.0.1
            ((locals ()) (conflicts ((tmp-ra.25 (rax foo.5.1 rbp rdi)) (foo.5.1 (rbp tmp-ra.25))
                                                                       (rdi (tmp-ra.25))
                                                                       (rbp (rax foo.5.1 tmp-ra.25))
                                                                       (rax (rbp tmp-ra.25))))
                         (assignment ((tmp-ra.25 r15) (foo.5.1 r14))))
            (begin
              (set! tmp-ra.25 r15)
              (set! foo.5.1 rdi)
              (set! rax 30)
              (jump tmp-ra.25 rbp rax)))
    (define L.tmp.1.2
      ((locals ()) (conflicts ((tmp-ra.26 (rax rbp)) (rbp (rax tmp-ra.26)) (rax (rbp tmp-ra.26))))
                   (assignment ((tmp-ra.26 r15))))
      (begin
        (set! tmp-ra.26 r15)
        (set! rax 22)
        (jump tmp-ra.26 rbp rax)))
    (begin
      (set! tmp-ra.27 r15)
      (set! rax 19502)
      (jump tmp-ra.27 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp.30 (rbp tmp-ra.29)) (tmp-ra.29 (rbp tmp.30 rax))
                                                            (rax (rbp tmp-ra.29))
                                                            (rbp (tmp-ra.29 tmp.30 rax))))
                       (assignment ((tmp-ra.29 r15) (tmp.30 r14))))
          (define L.func.0.1
            ((locals ())
             (conflicts ((tmp-ra.28 (rax ball.1.1 bar.7.2 foobar.0.3 bar.9.4 rbp rcx rdx rsi rdi))
                         (bar.9.4 (rbp tmp-ra.28 rcx rdx rsi))
                         (foobar.0.3 (rbp tmp-ra.28 rcx rdx))
                         (bar.7.2 (rbp tmp-ra.28 rcx))
                         (ball.1.1 (rbp tmp-ra.28))
                         (rdi (tmp-ra.28))
                         (rsi (bar.9.4 tmp-ra.28))
                         (rdx (foobar.0.3 bar.9.4 tmp-ra.28))
                         (rcx (bar.7.2 foobar.0.3 bar.9.4 tmp-ra.28))
                         (rbp (rax ball.1.1 bar.7.2 foobar.0.3 bar.9.4 tmp-ra.28))
                         (rax (rbp tmp-ra.28))))
             (assignment
              ((tmp-ra.28 r15) (bar.9.4 r14) (foobar.0.3 r14) (bar.7.2 r14) (ball.1.1 r14))))
            (begin
              (set! tmp-ra.28 r15)
              (set! bar.9.4 rdi)
              (set! foobar.0.3 rsi)
              (set! bar.7.2 rdx)
              (set! ball.1.1 rcx)
              (set! rax 6)
              (jump tmp-ra.28 rbp rax)))
    (begin
      (set! tmp-ra.29 r15)
      (if (begin
            (set! tmp.30 19246)
            (!= tmp.30 6))
          (begin
            (set! rax 14)
            (jump tmp-ra.29 rbp rax))
          (begin
            (set! rax 30)
            (jump tmp-ra.29 rbp rax))))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.30 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.30))
                                                             (rsi (r15 rdi rbp tmp-ra.30))
                                                             (rdi (r15 rbp rsi tmp-ra.30))
                                                             (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.30 r15))))
          (define L.eq?.2
            ((locals ()) (conflicts ((tmp.19 (tmp.20 rbp tmp-ra.28 rsi))
                                     (tmp.20 (rbp tmp-ra.28 tmp.19))
                                     (tmp-ra.28 (tmp.20 tmp.19 rbp rsi rdi rax))
                                     (rax (rbp tmp-ra.28))
                                     (rbp (tmp.20 tmp.19 tmp-ra.28 rax))
                                     (rdi (tmp-ra.28))
                                     (rsi (tmp.19 tmp-ra.28))))
                         (assignment ((tmp-ra.28 r15) (tmp.19 r14) (tmp.20 r13))))
            (begin
              (set! tmp-ra.28 r15)
              (set! tmp.19 rdi)
              (set! tmp.20 rsi)
              (if (= tmp.19 tmp.20)
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.28 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.28 rbp rax)))))
    (define L.proc.0.1
      ((locals ())
       (conflicts ((tmp-ra.29 (rax foo.8.1 bat.2.2 bar.4.3 foobar.7.4 rbp rcx rdx rsi rdi))
                   (foobar.7.4 (rbp tmp-ra.29 rcx rdx rsi))
                   (bar.4.3 (foo.8.1 bat.2.2 rbp tmp-ra.29 rcx rdx))
                   (bat.2.2 (rbp tmp-ra.29 bar.4.3 rcx))
                   (foo.8.1 (rbp tmp-ra.29 bar.4.3))
                   (rdi (tmp-ra.29))
                   (rsi (foobar.7.4 tmp-ra.29))
                   (rdx (bar.4.3 foobar.7.4 tmp-ra.29))
                   (rcx (bat.2.2 bar.4.3 foobar.7.4 tmp-ra.29))
                   (rbp (rax foo.8.1 bat.2.2 bar.4.3 foobar.7.4 tmp-ra.29))
                   (rax (rbp tmp-ra.29))))
       (assignment ((tmp-ra.29 r15) (bar.4.3 r14) (foobar.7.4 r14) (bat.2.2 r13) (foo.8.1 r13))))
      (begin
        (set! tmp-ra.29 r15)
        (set! foobar.7.4 rdi)
        (set! bar.4.3 rsi)
        (set! bat.2.2 rdx)
        (set! foo.8.1 rcx)
        (set! rax bar.4.3)
        (jump tmp-ra.29 rbp rax)))
    (begin
      (set! tmp-ra.30 r15)
      (set! rsi 8)
      (set! rdi 24878)
      (set! r15 tmp-ra.30)
      (jump L.eq?.2 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.36 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.36))
                                                             (rsi (r15 rdi rbp tmp-ra.36))
                                                             (rdi (r15 rbp rsi tmp-ra.36))
                                                             (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.36 r15))))
          (define L.*.2
            ((locals ())
             (conflicts
              ((tmp.29 (rbp tmp-ra.34 tmp.6 tmp.7))
               (tmp.37 (tmp.7 rbp tmp-ra.34 tmp.6))
               (tmp.7 (rbp tmp-ra.34 tmp.6 tmp.37 tmp.30 tmp.29 tmp.38 tmp.32 tmp.31))
               (tmp.30 (rbp tmp-ra.34 tmp.6 tmp.7))
               (tmp-ra.34 (tmp.7 tmp.6
                                 rbp
                                 rsi
                                 rdi
                                 tmp.37
                                 tmp.30
                                 tmp.29
                                 tmp.38
                                 tmp.32
                                 tmp.31
                                 tmp.40
                                 tmp.33
                                 tmp.39
                                 rax))
               (tmp.39 (rbp tmp-ra.34 tmp.6))
               (tmp.33 (tmp.40 rbp tmp-ra.34 tmp.6))
               (tmp.40 (rbp tmp-ra.34 tmp.33))
               (tmp.32 (rbp tmp-ra.34 tmp.6 tmp.7))
               (tmp.6
                (tmp.7 rbp tmp-ra.34 rsi tmp.37 tmp.30 tmp.29 tmp.38 tmp.32 tmp.31 tmp.33 tmp.39))
               (tmp.38 (tmp.6 rbp tmp-ra.34 tmp.7))
               (tmp.31 (rbp tmp-ra.34 tmp.6 tmp.7))
               (rax (rbp tmp-ra.34))
               (rbp (tmp.7 tmp.6
                           tmp-ra.34
                           tmp.37
                           tmp.30
                           tmp.29
                           tmp.38
                           tmp.32
                           tmp.31
                           tmp.40
                           tmp.33
                           tmp.39
                           rax))
               (rdi (tmp-ra.34))
               (rsi (tmp.6 tmp-ra.34))))
             (assignment ((tmp-ra.34 r15) (tmp.6 r14)
                                          (tmp.7 r13)
                                          (tmp.29 r9)
                                          (tmp.37 r9)
                                          (tmp.30 r9)
                                          (tmp.33 r13)
                                          (tmp.32 r9)
                                          (tmp.38 r9)
                                          (tmp.31 r9)
                                          (tmp.39 r13)
                                          (tmp.40 r14))))
            (begin
              (set! tmp-ra.34 r15)
              (set! tmp.6 rdi)
              (set! tmp.7 rsi)
              (if (begin
                    (if (begin
                          (begin
                            (set! tmp.37 tmp.7)
                            (set! tmp.37 (bitwise-and tmp.37 7))
                            (set! tmp.30 tmp.37))
                          (= tmp.30 0))
                        (set! tmp.29 14)
                        (set! tmp.29 6))
                    (!= tmp.29 6))
                  (if (begin
                        (if (begin
                              (begin
                                (set! tmp.38 tmp.6)
                                (set! tmp.38 (bitwise-and tmp.38 7))
                                (set! tmp.32 tmp.38))
                              (= tmp.32 0))
                            (set! tmp.31 14)
                            (set! tmp.31 6))
                        (!= tmp.31 6))
                      (begin
                        (set! tmp.39 tmp.7)
                        (set! tmp.39 (arithmetic-shift-right tmp.39 3))
                        (set! tmp.33 tmp.39)
                        (set! tmp.40 tmp.6)
                        (set! tmp.40 (* tmp.40 tmp.33))
                        (set! rax tmp.40)
                        (jump tmp-ra.34 rbp rax))
                      (begin
                        (set! rax 318)
                        (jump tmp-ra.34 rbp rax)))
                  (begin
                    (set! rax 318)
                    (jump tmp-ra.34 rbp rax)))))
    (define L.func.0.1
      ((locals ())
       (conflicts ((tmp-ra.35 (rax bar.2.1 ball.0.2 bat.4.3 ball.3.4 bat.7.5 rbp r8 rcx rdx rsi rdi))
                   (bat.7.5 (rbp tmp-ra.35 r8 rcx rdx rsi))
                   (ball.3.4 (rbp tmp-ra.35 r8 rcx rdx))
                   (bat.4.3 (rbp tmp-ra.35 r8 rcx))
                   (ball.0.2 (bar.2.1 rbp tmp-ra.35 r8))
                   (bar.2.1 (rbp tmp-ra.35 ball.0.2))
                   (rdi (tmp-ra.35))
                   (rsi (bat.7.5 tmp-ra.35))
                   (rdx (ball.3.4 bat.7.5 tmp-ra.35))
                   (rcx (bat.4.3 ball.3.4 bat.7.5 tmp-ra.35))
                   (r8 (ball.0.2 bat.4.3 ball.3.4 bat.7.5 tmp-ra.35))
                   (rbp (rax bar.2.1 ball.0.2 bat.4.3 ball.3.4 bat.7.5 tmp-ra.35))
                   (rax (rbp tmp-ra.35))))
       (assignment
        ((tmp-ra.35 r15) (bat.7.5 r14) (ball.3.4 r14) (bat.4.3 r14) (ball.0.2 r14) (bar.2.1 r13))))
      (begin
        (set! tmp-ra.35 r15)
        (set! bat.7.5 rdi)
        (set! ball.3.4 rsi)
        (set! bat.4.3 rdx)
        (set! ball.0.2 rcx)
        (set! bar.2.1 r8)
        (set! rax ball.0.2)
        (jump tmp-ra.35 rbp rax)))
    (begin
      (set! tmp-ra.36 r15)
      (set! rsi 0)
      (set! rdi 8)
      (set! r15 tmp-ra.36)
      (jump L.*.2 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.32 (rax rbp)) (rbp (rax tmp-ra.32)) (rax (rbp tmp-ra.32))))
                       (assignment ((tmp-ra.32 r15))))
          (define L.proc.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.31 (rax foobar.0.1
                               bat.4.2
                               foobar.8.3
                               ball.1.4
                               foo.5.5
                               foo.7.6
                               bar.6.7
                               rbp
                               fv0
                               r9
                               r8
                               rcx
                               rdx
                               rsi
                               rdi))
               (bar.6.7 (rbp tmp-ra.31 fv0 r9 r8 rcx rdx rsi))
               (foo.7.6 (rbp tmp-ra.31 fv0 r9 r8 rcx rdx))
               (foo.5.5 (rbp tmp-ra.31 fv0 r9 r8 rcx))
               (ball.1.4 (rbp tmp-ra.31 fv0 r9 r8))
               (foobar.8.3 (rbp tmp-ra.31 fv0 r9))
               (bat.4.2 (rbp tmp-ra.31 fv0))
               (foobar.0.1 (rbp tmp-ra.31))
               (rdi (tmp-ra.31))
               (rsi (bar.6.7 tmp-ra.31))
               (rdx (foo.7.6 bar.6.7 tmp-ra.31))
               (rcx (foo.5.5 foo.7.6 bar.6.7 tmp-ra.31))
               (r8 (ball.1.4 foo.5.5 foo.7.6 bar.6.7 tmp-ra.31))
               (r9 (foobar.8.3 ball.1.4 foo.5.5 foo.7.6 bar.6.7 tmp-ra.31))
               (fv0 (bat.4.2 foobar.8.3 ball.1.4 foo.5.5 foo.7.6 bar.6.7 tmp-ra.31))
               (rbp (rax foobar.0.1 bat.4.2 foobar.8.3 ball.1.4 foo.5.5 foo.7.6 bar.6.7 tmp-ra.31))
               (rax (rbp tmp-ra.31))))
             (assignment ((tmp-ra.31 r15) (bar.6.7 r14)
                                          (foo.7.6 r14)
                                          (foo.5.5 r14)
                                          (ball.1.4 r14)
                                          (foobar.8.3 r14)
                                          (bat.4.2 r14)
                                          (foobar.0.1 r14))))
            (begin
              (set! tmp-ra.31 r15)
              (set! bar.6.7 rdi)
              (set! foo.7.6 rsi)
              (set! foo.5.5 rdx)
              (set! ball.1.4 rcx)
              (set! foobar.8.3 r8)
              (set! bat.4.2 r9)
              (set! foobar.0.1 fv0)
              (set! rax foobar.0.1)
              (jump tmp-ra.31 rbp rax)))
    (begin
      (set! tmp-ra.32 r15)
      (set! rax 22)
      (jump tmp-ra.32 rbp rax))))
(check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.30 (rax rbp)) (rbp (rax tmp-ra.30))
                                                                         (rax (rbp tmp-ra.30))))
                                       (assignment ((tmp-ra.30 r15))))
                          (define L.fn.0.1
                            ((locals ()) (conflicts ((tmp-ra.28 (rax bar.9.1 bat.3.2 rbp rsi rdi))
                                                     (bat.3.2 (rbp tmp-ra.28 rsi))
                                                     (bar.9.1 (rbp tmp-ra.28))
                                                     (rdi (tmp-ra.28))
                                                     (rsi (bat.3.2 tmp-ra.28))
                                                     (rbp (rax bar.9.1 bat.3.2 tmp-ra.28))
                                                     (rax (rbp tmp-ra.28))))
                                         (assignment ((tmp-ra.28 r15) (bat.3.2 r14) (bar.9.1 r14))))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! bat.3.2 rdi)
                              (set! bar.9.1 rsi)
                              (set! rax 6)
                              (jump tmp-ra.28 rbp rax)))
                    (define L.func.1.2
                      ((locals ()) (conflicts ((tmp-ra.29 (rax bar.8.3 foobar.4.4 rbp rsi rdi))
                                               (foobar.4.4 (rbp tmp-ra.29 rsi))
                                               (bar.8.3 (rbp tmp-ra.29))
                                               (rdi (tmp-ra.29))
                                               (rsi (foobar.4.4 tmp-ra.29))
                                               (rbp (rax bar.8.3 foobar.4.4 tmp-ra.29))
                                               (rax (rbp tmp-ra.29))))
                                   (assignment ((tmp-ra.29 r15) (foobar.4.4 r14) (bar.8.3 r14))))
                      (begin
                        (set! tmp-ra.29 r15)
                        (set! foobar.4.4 rdi)
                        (set! bar.8.3 rsi)
                        (set! rax bar.8.3)
                        (jump tmp-ra.29 rbp rax)))
                    (begin
                      (set! tmp-ra.30 r15)
                      (set! rax 14)
                      (jump tmp-ra.30 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.32 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.32))
                                                             (rsi (r15 rdi rbp tmp-ra.32))
                                                             (rdi (r15 rbp rsi tmp-ra.32))
                                                             (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.32 r15))))
          (define L.eq?.2
            ((locals ()) (conflicts ((tmp.21 (tmp.22 rbp tmp-ra.30 rsi))
                                     (tmp.22 (rbp tmp-ra.30 tmp.21))
                                     (tmp-ra.30 (tmp.22 tmp.21 rbp rsi rdi rax))
                                     (rax (rbp tmp-ra.30))
                                     (rbp (tmp.22 tmp.21 tmp-ra.30 rax))
                                     (rdi (tmp-ra.30))
                                     (rsi (tmp.21 tmp-ra.30))))
                         (assignment ((tmp-ra.30 r15) (tmp.21 r14) (tmp.22 r13))))
            (begin
              (set! tmp-ra.30 r15)
              (set! tmp.21 rdi)
              (set! tmp.22 rsi)
              (if (= tmp.21 tmp.22)
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.30 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.30 rbp rax)))))
    (define L.proc.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.31
          (rax bat.7.1 bar.9.2 foobar.3.3 bar.0.4 foo.8.5 foobar.4.6 rbp r9 r8 rcx rdx rsi rdi))
         (foobar.4.6 (rbp tmp-ra.31 r9 r8 rcx rdx rsi))
         (foo.8.5 (rbp tmp-ra.31 r9 r8 rcx rdx))
         (bar.0.4 (rbp tmp-ra.31 r9 r8 rcx))
         (foobar.3.3 (rbp tmp-ra.31 r9 r8))
         (bar.9.2 (rbp tmp-ra.31 r9))
         (bat.7.1 (rbp tmp-ra.31))
         (rdi (tmp-ra.31))
         (rsi (foobar.4.6 tmp-ra.31))
         (rdx (foo.8.5 foobar.4.6 tmp-ra.31))
         (rcx (bar.0.4 foo.8.5 foobar.4.6 tmp-ra.31))
         (r8 (foobar.3.3 bar.0.4 foo.8.5 foobar.4.6 tmp-ra.31))
         (r9 (bar.9.2 foobar.3.3 bar.0.4 foo.8.5 foobar.4.6 tmp-ra.31))
         (rbp (rax bat.7.1 bar.9.2 foobar.3.3 bar.0.4 foo.8.5 foobar.4.6 tmp-ra.31))
         (rax (rbp tmp-ra.31))))
       (assignment ((tmp-ra.31 r15) (foobar.4.6 r14)
                                    (foo.8.5 r14)
                                    (bar.0.4 r14)
                                    (foobar.3.3 r14)
                                    (bar.9.2 r14)
                                    (bat.7.1 r14))))
      (begin
        (set! tmp-ra.31 r15)
        (set! foobar.4.6 rdi)
        (set! foo.8.5 rsi)
        (set! bar.0.4 rdx)
        (set! foobar.3.3 rcx)
        (set! bar.9.2 r8)
        (set! bat.7.1 r9)
        (set! rax 14)
        (jump tmp-ra.31 rbp rax)))
    (begin
      (set! tmp-ra.32 r15)
      (set! rsi 1871355128)
      (set! rdi 27950)
      (set! r15 tmp-ra.32)
      (jump L.eq?.2 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.31 (rax rbp)) (rbp (rax tmp-ra.31)) (rax (rbp tmp-ra.31))))
                       (assignment ((tmp-ra.31 r15))))
          (define L.x.0.1
            ((locals ()) (conflicts ((tmp-ra.29 (rax foobar.0.1 bat.7.2 rbp rsi rdi))
                                     (bat.7.2 (rbp tmp-ra.29 rsi))
                                     (foobar.0.1 (rbp tmp-ra.29))
                                     (rdi (tmp-ra.29))
                                     (rsi (bat.7.2 tmp-ra.29))
                                     (rbp (rax foobar.0.1 bat.7.2 tmp-ra.29))
                                     (rax (rbp tmp-ra.29))))
                         (assignment ((tmp-ra.29 r15) (bat.7.2 r14) (foobar.0.1 r14))))
            (begin
              (set! tmp-ra.29 r15)
              (set! bat.7.2 rdi)
              (set! foobar.0.1 rsi)
              (set! rax 8)
              (jump tmp-ra.29 rbp rax)))
    (define L.func.1.2
      ((locals ()) (conflicts ((tmp-ra.30 (rax foobar.2.3 bar.1.4 bat.6.5 rbp rdx rsi rdi))
                               (bat.6.5 (rbp tmp-ra.30 rdx rsi))
                               (bar.1.4 (rbp tmp-ra.30 rdx))
                               (foobar.2.3 (rbp tmp-ra.30))
                               (rdi (tmp-ra.30))
                               (rsi (bat.6.5 tmp-ra.30))
                               (rdx (bar.1.4 bat.6.5 tmp-ra.30))
                               (rbp (rax foobar.2.3 bar.1.4 bat.6.5 tmp-ra.30))
                               (rax (rbp tmp-ra.30))))
                   (assignment ((tmp-ra.30 r15) (bat.6.5 r14) (bar.1.4 r14) (foobar.2.3 r14))))
      (begin
        (set! tmp-ra.30 r15)
        (set! bat.6.5 rdi)
        (set! bar.1.4 rsi)
        (set! foobar.2.3 rdx)
        (set! rax 14)
        (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (set! rax 30)
      (jump tmp-ra.31 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.31 (rax foo.1.4 ball.4.5 bar.3.6 rbp))
                                   (bar.3.6 (rbp tmp-ra.31))
                                   (ball.4.5 (rbp tmp-ra.31))
                                   (foo.1.4 (rbp tmp-ra.31))
                                   (rbp (rax foo.1.4 ball.4.5 bar.3.6 tmp-ra.31))
                                   (rax (rbp tmp-ra.31))))
                       (assignment ((tmp-ra.31 r15) (bar.3.6 r14) (ball.4.5 r14) (foo.1.4 r14))))
          (define L.func.0.1
            ((locals ()) (conflicts ((tmp-ra.30 (rax foo.8.1 ball.4.2 foobar.0.3 rbp rdx rsi rdi))
                                     (foobar.0.3 (rbp tmp-ra.30 rdx rsi))
                                     (ball.4.2 (foo.8.1 rbp tmp-ra.30 rdx))
                                     (foo.8.1 (rbp tmp-ra.30 ball.4.2))
                                     (rdi (tmp-ra.30))
                                     (rsi (foobar.0.3 tmp-ra.30))
                                     (rdx (ball.4.2 foobar.0.3 tmp-ra.30))
                                     (rbp (rax foo.8.1 ball.4.2 foobar.0.3 tmp-ra.30))
                                     (rax (rbp tmp-ra.30))))
                         (assignment ((tmp-ra.30 r15) (foobar.0.3 r14) (ball.4.2 r14) (foo.8.1 r13))))
            (begin
              (set! tmp-ra.30 r15)
              (set! foobar.0.3 rdi)
              (set! ball.4.2 rsi)
              (set! foo.8.1 rdx)
              (set! rax ball.4.2)
              (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (set! bar.3.6 6)
      (set! ball.4.5 22)
      (set! foo.1.4 22)
      (set! rax 0)
      (jump tmp-ra.31 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.32 (rax rbp)) (rbp (rax tmp-ra.32)) (rax (rbp tmp-ra.32))))
                       (assignment ((tmp-ra.32 r15))))
          (define L.func.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.30
                (rax foobar.0.1 bar.6.2 foobar.2.3 foo.9.4 foobar.8.5 rbp r8 rcx rdx rsi rdi))
               (foobar.8.5 (rbp tmp-ra.30 r8 rcx rdx rsi))
               (foo.9.4 (rbp tmp-ra.30 r8 rcx rdx))
               (foobar.2.3 (rbp tmp-ra.30 r8 rcx))
               (bar.6.2 (rbp tmp-ra.30 r8))
               (foobar.0.1 (rbp tmp-ra.30))
               (rdi (tmp-ra.30))
               (rsi (foobar.8.5 tmp-ra.30))
               (rdx (foo.9.4 foobar.8.5 tmp-ra.30))
               (rcx (foobar.2.3 foo.9.4 foobar.8.5 tmp-ra.30))
               (r8 (bar.6.2 foobar.2.3 foo.9.4 foobar.8.5 tmp-ra.30))
               (rbp (rax foobar.0.1 bar.6.2 foobar.2.3 foo.9.4 foobar.8.5 tmp-ra.30))
               (rax (rbp tmp-ra.30))))
             (assignment ((tmp-ra.30 r15) (foobar.8.5 r14)
                                          (foo.9.4 r14)
                                          (foobar.2.3 r14)
                                          (bar.6.2 r14)
                                          (foobar.0.1 r14))))
            (begin
              (set! tmp-ra.30 r15)
              (set! foobar.8.5 rdi)
              (set! foo.9.4 rsi)
              (set! foobar.2.3 rdx)
              (set! bar.6.2 rcx)
              (set! foobar.0.1 r8)
              (set! rax 6)
              (jump tmp-ra.30 rbp rax)))
    (define L.proc.1.2
      ((locals ()) (conflicts ((tmp-ra.31 (rax bar.6.6 rbp rdi)) (bar.6.6 (rbp tmp-ra.31))
                                                                 (rdi (tmp-ra.31))
                                                                 (rbp (rax bar.6.6 tmp-ra.31))
                                                                 (rax (rbp tmp-ra.31))))
                   (assignment ((tmp-ra.31 r15) (bar.6.6 r14))))
      (begin
        (set! tmp-ra.31 r15)
        (set! bar.6.6 rdi)
        (set! rax bar.6.6)
        (jump tmp-ra.31 rbp rax)))
    (begin
      (set! tmp-ra.32 r15)
      (set! rax 6)
      (jump tmp-ra.32 rbp rax))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp-ra.31 (rax foo.5.3 foobar.2.4 bar.9.5 bar.3.6 rbp))
                       (bar.3.6 (rbp tmp-ra.31))
                       (bar.9.5 (rbp tmp-ra.31))
                       (foobar.2.4 (rbp tmp-ra.31))
                       (foo.5.3 (rbp tmp-ra.31))
                       (rbp (rax foo.5.3 foobar.2.4 bar.9.5 bar.3.6 tmp-ra.31))
                       (rax (rbp tmp-ra.31))))
           (assignment ((tmp-ra.31 r15) (bar.3.6 r14) (bar.9.5 r14) (foobar.2.4 r14) (foo.5.3 r14))))
          (define L.fn.0.1
            ((locals ()) (conflicts ((tmp-ra.30 (rax foobar.4.1 bat.7.2 rbp rsi rdi))
                                     (bat.7.2 (rbp tmp-ra.30 rsi))
                                     (foobar.4.1 (rbp tmp-ra.30))
                                     (rdi (tmp-ra.30))
                                     (rsi (bat.7.2 tmp-ra.30))
                                     (rbp (rax foobar.4.1 bat.7.2 tmp-ra.30))
                                     (rax (rbp tmp-ra.30))))
                         (assignment ((tmp-ra.30 r15) (bat.7.2 r14) (foobar.4.1 r14))))
            (begin
              (set! tmp-ra.30 r15)
              (set! bat.7.2 rdi)
              (set! foobar.4.1 rsi)
              (set! rax foobar.4.1)
              (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (set! bar.3.6 30)
      (set! bar.9.5 22)
      (set! foobar.2.4 0)
      (set! foo.5.3 0)
      (set! rax 14)
      (jump tmp-ra.31 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.33 (rax rbp)) (rbp (rax tmp-ra.33)) (rax (rbp tmp-ra.33))))
                       (assignment ((tmp-ra.33 r15))))
          (define L.x.0.1
            ((locals ()) (conflicts ((tmp-ra.31 (rax rbp)) (rbp (rax tmp-ra.31))
                                                           (rax (rbp tmp-ra.31))))
                         (assignment ((tmp-ra.31 r15))))
            (begin
              (set! tmp-ra.31 r15)
              (set! rax 22)
              (jump tmp-ra.31 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.32 (rax foobar.8.1
                         ball.1.2
                         foo.3.3
                         foobar.9.4
                         ball.0.5
                         bat.4.6
                         bat.2.7
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bat.2.7 (rbp tmp-ra.32 fv0 r9 r8 rcx rdx rsi))
         (bat.4.6 (rbp tmp-ra.32 fv0 r9 r8 rcx rdx))
         (ball.0.5 (rbp tmp-ra.32 fv0 r9 r8 rcx))
         (foobar.9.4 (rbp tmp-ra.32 fv0 r9 r8))
         (foo.3.3 (rbp tmp-ra.32 fv0 r9))
         (ball.1.2 (rbp tmp-ra.32 fv0))
         (foobar.8.1 (rbp tmp-ra.32))
         (rdi (tmp-ra.32))
         (rsi (bat.2.7 tmp-ra.32))
         (rdx (bat.4.6 bat.2.7 tmp-ra.32))
         (rcx (ball.0.5 bat.4.6 bat.2.7 tmp-ra.32))
         (r8 (foobar.9.4 ball.0.5 bat.4.6 bat.2.7 tmp-ra.32))
         (r9 (foo.3.3 foobar.9.4 ball.0.5 bat.4.6 bat.2.7 tmp-ra.32))
         (fv0 (ball.1.2 foo.3.3 foobar.9.4 ball.0.5 bat.4.6 bat.2.7 tmp-ra.32))
         (rbp (rax foobar.8.1 ball.1.2 foo.3.3 foobar.9.4 ball.0.5 bat.4.6 bat.2.7 tmp-ra.32))
         (rax (rbp tmp-ra.32))))
       (assignment ((tmp-ra.32 r15) (bat.2.7 r14)
                                    (bat.4.6 r14)
                                    (ball.0.5 r14)
                                    (foobar.9.4 r14)
                                    (foo.3.3 r14)
                                    (ball.1.2 r14)
                                    (foobar.8.1 r14))))
      (begin
        (set! tmp-ra.32 r15)
        (set! bat.2.7 rdi)
        (set! bat.4.6 rsi)
        (set! ball.0.5 rdx)
        (set! foobar.9.4 rcx)
        (set! foo.3.3 r8)
        (set! ball.1.2 r9)
        (set! foobar.8.1 fv0)
        (set! rax 14)
        (jump tmp-ra.32 rbp rax)))
    (begin
      (set! tmp-ra.33 r15)
      (set! rax 29230)
      (jump tmp-ra.33 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.33 (rax rbp)) (rbp (rax tmp-ra.33)) (rax (rbp tmp-ra.33))))
                       (assignment ((tmp-ra.33 r15))))
          (define L.proc.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.31
                (rax foobar.1.1 foobar.9.2 foobar.6.3 bat.0.4 bat.3.5 rbp r8 rcx rdx rsi rdi))
               (bat.3.5 (rbp tmp-ra.31 r8 rcx rdx rsi))
               (bat.0.4 (foobar.1.1 foobar.9.2 foobar.6.3 rbp tmp-ra.31 r8 rcx rdx))
               (foobar.6.3 (rbp tmp-ra.31 bat.0.4 r8 rcx))
               (foobar.9.2 (rbp tmp-ra.31 bat.0.4 r8))
               (foobar.1.1 (rbp tmp-ra.31 bat.0.4))
               (rdi (tmp-ra.31))
               (rsi (bat.3.5 tmp-ra.31))
               (rdx (bat.0.4 bat.3.5 tmp-ra.31))
               (rcx (foobar.6.3 bat.0.4 bat.3.5 tmp-ra.31))
               (r8 (foobar.9.2 foobar.6.3 bat.0.4 bat.3.5 tmp-ra.31))
               (rbp (rax foobar.1.1 foobar.9.2 foobar.6.3 bat.0.4 bat.3.5 tmp-ra.31))
               (rax (rbp tmp-ra.31))))
             (assignment ((tmp-ra.31 r15) (bat.0.4 r14)
                                          (bat.3.5 r14)
                                          (foobar.6.3 r13)
                                          (foobar.9.2 r13)
                                          (foobar.1.1 r13))))
            (begin
              (set! tmp-ra.31 r15)
              (set! bat.3.5 rdi)
              (set! bat.0.4 rsi)
              (set! foobar.6.3 rdx)
              (set! foobar.9.2 rcx)
              (set! foobar.1.1 r8)
              (set! rax bat.0.4)
              (jump tmp-ra.31 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts ((tmp-ra.32 (rax bat.0.6 bar.7.7 rbp rsi rdi)) (bar.7.7 (rbp tmp-ra.32 rsi))
                                                                 (bat.0.6 (rbp tmp-ra.32))
                                                                 (rdi (tmp-ra.32))
                                                                 (rsi (bar.7.7 tmp-ra.32))
                                                                 (rbp (rax bat.0.6 bar.7.7 tmp-ra.32))
                                                                 (rax (rbp tmp-ra.32))))
       (assignment ((tmp-ra.32 r15) (bar.7.7 r14) (bat.0.6 r14))))
      (begin
        (set! tmp-ra.32 r15)
        (set! bar.7.7 rdi)
        (set! bat.0.6 rsi)
        (set! rax 6)
        (jump tmp-ra.32 rbp rax)))
    (begin
      (set! tmp-ra.33 r15)
      (set! rax 22)
      (jump tmp-ra.33 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp.33 (rbp tmp-ra.32)) (tmp-ra.32 (rbp tmp.33 rax))
                                                            (rax (rbp tmp-ra.32))
                                                            (rbp (tmp-ra.32 tmp.33 rax))))
                       (assignment ((tmp-ra.32 r15) (tmp.33 r14))))
          (define L.tmp.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.30 (rax bat.4.1 foo.6.2 foo.9.3 foobar.3.4 ball.2.5 rbp r8 rcx rdx rsi rdi))
               (ball.2.5 (rbp tmp-ra.30 r8 rcx rdx rsi))
               (foobar.3.4 (bat.4.1 foo.6.2 foo.9.3 rbp tmp-ra.30 r8 rcx rdx))
               (foo.9.3 (rbp tmp-ra.30 foobar.3.4 r8 rcx))
               (foo.6.2 (rbp tmp-ra.30 foobar.3.4 r8))
               (bat.4.1 (rbp tmp-ra.30 foobar.3.4))
               (rdi (tmp-ra.30))
               (rsi (ball.2.5 tmp-ra.30))
               (rdx (foobar.3.4 ball.2.5 tmp-ra.30))
               (rcx (foo.9.3 foobar.3.4 ball.2.5 tmp-ra.30))
               (r8 (foo.6.2 foo.9.3 foobar.3.4 ball.2.5 tmp-ra.30))
               (rbp (rax bat.4.1 foo.6.2 foo.9.3 foobar.3.4 ball.2.5 tmp-ra.30))
               (rax (rbp tmp-ra.30))))
             (assignment ((tmp-ra.30 r15) (foobar.3.4 r14)
                                          (ball.2.5 r14)
                                          (foo.9.3 r13)
                                          (foo.6.2 r13)
                                          (bat.4.1 r13))))
            (begin
              (set! tmp-ra.30 r15)
              (set! ball.2.5 rdi)
              (set! foobar.3.4 rsi)
              (set! foo.9.3 rdx)
              (set! foo.6.2 rcx)
              (set! bat.4.1 r8)
              (set! rax foobar.3.4)
              (jump tmp-ra.30 rbp rax)))
    (define L.x.1.2
      ((locals ()) (conflicts ((tmp-ra.31 (rax bat.8.6 rbp rdi)) (bat.8.6 (rbp tmp-ra.31))
                                                                 (rdi (tmp-ra.31))
                                                                 (rbp (rax bat.8.6 tmp-ra.31))
                                                                 (rax (rbp tmp-ra.31))))
                   (assignment ((tmp-ra.31 r15) (bat.8.6 r14))))
      (begin
        (set! tmp-ra.31 r15)
        (set! bat.8.6 rdi)
        (set! rax 6)
        (jump tmp-ra.31 rbp rax)))
    (begin
      (set! tmp-ra.32 r15)
      (if (begin
            (set! tmp.33 25902)
            (!= tmp.33 6))
          (begin
            (set! rax 30)
            (jump tmp-ra.32 rbp rax))
          (begin
            (set! rax 22)
            (jump tmp-ra.32 rbp rax))))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.36 (rdi rbp)) (rbp (r15 rdi tmp-ra.36))
                                                         (rdi (r15 rbp tmp-ra.36))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.36 r15))))
          (define L.void?.3
            ((locals ())
             (conflicts ((tmp.32 (rbp tmp-ra.33)) (tmp.28 (rbp tmp-ra.33))
                                                  (tmp.37 (rbp tmp-ra.33))
                                                  (tmp-ra.33 (tmp.28 rbp rdi tmp.37 tmp.32 rax))
                                                  (rax (rbp tmp-ra.33))
                                                  (rbp (tmp.28 tmp-ra.33 tmp.37 tmp.32 rax))
                                                  (rdi (tmp-ra.33))))
             (assignment ((tmp-ra.33 r15) (tmp.32 r14) (tmp.28 r14) (tmp.37 r14))))
            (begin
              (set! tmp-ra.33 r15)
              (set! tmp.28 rdi)
              (if (begin
                    (begin
                      (set! tmp.37 tmp.28)
                      (set! tmp.37 (bitwise-and tmp.37 255))
                      (set! tmp.32 tmp.37))
                    (= tmp.32 30))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.33 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.33 rbp rax)))))
    (define L.x.0.1
      ((locals ()) (conflicts ((tmp-ra.34 (rax ball.0.1 rbp rdi)) (ball.0.1 (rbp tmp-ra.34))
                                                                  (rdi (tmp-ra.34))
                                                                  (rbp (rax ball.0.1 tmp-ra.34))
                                                                  (rax (rbp tmp-ra.34))))
                   (assignment ((tmp-ra.34 r15) (ball.0.1 r14))))
      (begin
        (set! tmp-ra.34 r15)
        (set! ball.0.1 rdi)
        (set! rax ball.0.1)
        (jump tmp-ra.34 rbp rax)))
    (define L.tmp.1.2
      ((locals ())
       (conflicts ((tmp-ra.35 (rax bat.7.2
                                   bat.6.3
                                   ball.5.4
                                   foo.4.5
                                   bat.9.6
                                   bat.2.7
                                   foo.1.8
                                   rbp
                                   fv0
                                   r9
                                   r8
                                   rcx
                                   rdx
                                   rsi
                                   rdi))
                   (foo.1.8 (rbp tmp-ra.35 fv0 r9 r8 rcx rdx rsi))
                   (bat.2.7 (rbp tmp-ra.35 fv0 r9 r8 rcx rdx))
                   (bat.9.6 (rbp tmp-ra.35 fv0 r9 r8 rcx))
                   (foo.4.5 (rbp tmp-ra.35 fv0 r9 r8))
                   (ball.5.4 (rbp tmp-ra.35 fv0 r9))
                   (bat.6.3 (rbp tmp-ra.35 fv0))
                   (bat.7.2 (rbp tmp-ra.35))
                   (rdi (tmp-ra.35))
                   (rsi (foo.1.8 tmp-ra.35))
                   (rdx (bat.2.7 foo.1.8 tmp-ra.35))
                   (rcx (bat.9.6 bat.2.7 foo.1.8 tmp-ra.35))
                   (r8 (foo.4.5 bat.9.6 bat.2.7 foo.1.8 tmp-ra.35))
                   (r9 (ball.5.4 foo.4.5 bat.9.6 bat.2.7 foo.1.8 tmp-ra.35))
                   (fv0 (bat.6.3 ball.5.4 foo.4.5 bat.9.6 bat.2.7 foo.1.8 tmp-ra.35))
                   (rbp (rax bat.7.2 bat.6.3 ball.5.4 foo.4.5 bat.9.6 bat.2.7 foo.1.8 tmp-ra.35))
                   (rax (rbp tmp-ra.35))))
       (assignment ((tmp-ra.35 r15) (foo.1.8 r14)
                                    (bat.2.7 r14)
                                    (bat.9.6 r14)
                                    (foo.4.5 r14)
                                    (ball.5.4 r14)
                                    (bat.6.3 r14)
                                    (bat.7.2 r14))))
      (begin
        (set! tmp-ra.35 r15)
        (set! foo.1.8 rdi)
        (set! bat.2.7 rsi)
        (set! bat.9.6 rdx)
        (set! foo.4.5 rcx)
        (set! ball.5.4 r8)
        (set! bat.6.3 r9)
        (set! bat.7.2 fv0)
        (set! rax 0)
        (jump tmp-ra.35 rbp rax)))
    (begin
      (set! tmp-ra.36 r15)
      (set! rdi 13102)
      (set! r15 tmp-ra.36)
      (jump L.void?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.32 (rax rbp)) (rbp (rax tmp-ra.32)) (rax (rbp tmp-ra.32))))
                       (assignment ((tmp-ra.32 r15))))
          (define L.fn.0.1
            ((locals ()) (conflicts ((tmp-ra.29 (rax rbp)) (rbp (rax tmp-ra.29))
                                                           (rax (rbp tmp-ra.29))))
                         (assignment ((tmp-ra.29 r15))))
            (begin
              (set! tmp-ra.29 r15)
              (set! rax 30)
              (jump tmp-ra.29 rbp rax)))
    (define L.fn.1.2
      ((locals ())
       (conflicts ((tmp-ra.30 (rax foo.4.1 bar.7.2 foo.1.3 ball.8.4 rbp rcx rdx rsi rdi))
                   (ball.8.4 (rbp tmp-ra.30 rcx rdx rsi))
                   (foo.1.3 (rbp tmp-ra.30 rcx rdx))
                   (bar.7.2 (rbp tmp-ra.30 rcx))
                   (foo.4.1 (rbp tmp-ra.30))
                   (rdi (tmp-ra.30))
                   (rsi (ball.8.4 tmp-ra.30))
                   (rdx (foo.1.3 ball.8.4 tmp-ra.30))
                   (rcx (bar.7.2 foo.1.3 ball.8.4 tmp-ra.30))
                   (rbp (rax foo.4.1 bar.7.2 foo.1.3 ball.8.4 tmp-ra.30))
                   (rax (rbp tmp-ra.30))))
       (assignment ((tmp-ra.30 r15) (ball.8.4 r14) (foo.1.3 r14) (bar.7.2 r14) (foo.4.1 r14))))
      (begin
        (set! tmp-ra.30 r15)
        (set! ball.8.4 rdi)
        (set! foo.1.3 rsi)
        (set! bar.7.2 rdx)
        (set! foo.4.1 rcx)
        (set! rax foo.4.1)
        (jump tmp-ra.30 rbp rax)))
    (define L.tmp.2.3
      ((locals ()) (conflicts ((tmp-ra.31 (rax bat.2.5 rbp rdi)) (bat.2.5 (rbp tmp-ra.31))
                                                                 (rdi (tmp-ra.31))
                                                                 (rbp (rax bat.2.5 tmp-ra.31))
                                                                 (rax (rbp tmp-ra.31))))
                   (assignment ((tmp-ra.31 r15) (bat.2.5 r14))))
      (begin
        (set! tmp-ra.31 r15)
        (set! bat.2.5 rdi)
        (set! rax bat.2.5)
        (jump tmp-ra.31 rbp rax)))
    (begin
      (set! tmp-ra.32 r15)
      (set! rax 14)
      (jump tmp-ra.32 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.34 (rax rbp)) (rbp (rax tmp-ra.34)) (rax (rbp tmp-ra.34))))
                       (assignment ((tmp-ra.34 r15))))
          (define L.func.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.32
                (rax ball.9.1 foobar.8.2 ball.1.3 ball.2.4 foobar.3.5 rbp r8 rcx rdx rsi rdi))
               (foobar.3.5 (rbp tmp-ra.32 r8 rcx rdx rsi))
               (ball.2.4 (rbp tmp-ra.32 r8 rcx rdx))
               (ball.1.3 (rbp tmp-ra.32 r8 rcx))
               (foobar.8.2 (rbp tmp-ra.32 r8))
               (ball.9.1 (rbp tmp-ra.32))
               (rdi (tmp-ra.32))
               (rsi (foobar.3.5 tmp-ra.32))
               (rdx (ball.2.4 foobar.3.5 tmp-ra.32))
               (rcx (ball.1.3 ball.2.4 foobar.3.5 tmp-ra.32))
               (r8 (foobar.8.2 ball.1.3 ball.2.4 foobar.3.5 tmp-ra.32))
               (rbp (rax ball.9.1 foobar.8.2 ball.1.3 ball.2.4 foobar.3.5 tmp-ra.32))
               (rax (rbp tmp-ra.32))))
             (assignment ((tmp-ra.32 r15) (foobar.3.5 r14)
                                          (ball.2.4 r14)
                                          (ball.1.3 r14)
                                          (foobar.8.2 r14)
                                          (ball.9.1 r14))))
            (begin
              (set! tmp-ra.32 r15)
              (set! foobar.3.5 rdi)
              (set! ball.2.4 rsi)
              (set! ball.1.3 rdx)
              (set! foobar.8.2 rcx)
              (set! ball.9.1 r8)
              (set! rax 6)
              (jump tmp-ra.32 rbp rax)))
    (define L.func.1.2
      ((locals ()) (conflicts ((tmp-ra.33 (rax ball.5.6 foobar.8.7 ball.0.8 rbp rdx rsi rdi))
                               (ball.0.8 (rbp tmp-ra.33 rdx rsi))
                               (foobar.8.7 (rbp tmp-ra.33 rdx))
                               (ball.5.6 (rbp tmp-ra.33))
                               (rdi (tmp-ra.33))
                               (rsi (ball.0.8 tmp-ra.33))
                               (rdx (foobar.8.7 ball.0.8 tmp-ra.33))
                               (rbp (rax ball.5.6 foobar.8.7 ball.0.8 tmp-ra.33))
                               (rax (rbp tmp-ra.33))))
                   (assignment ((tmp-ra.33 r15) (ball.0.8 r14) (foobar.8.7 r14) (ball.5.6 r14))))
      (begin
        (set! tmp-ra.33 r15)
        (set! ball.0.8 rdi)
        (set! foobar.8.7 rsi)
        (set! ball.5.6 rdx)
        (set! rax 22574)
        (jump tmp-ra.33 rbp rax)))
    (begin
      (set! tmp-ra.34 r15)
      (set! rax 30)
      (jump tmp-ra.34 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.35 (rdi rbp)) (rbp (r15 rdi tmp-ra.35))
                                                         (rdi (r15 rbp tmp-ra.35))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.35 r15))))
          (define L.boolean?.3
            ((locals ())
             (conflicts ((tmp.31 (rbp tmp-ra.32)) (tmp.25 (rbp tmp-ra.32))
                                                  (tmp.36 (rbp tmp-ra.32))
                                                  (tmp-ra.32 (tmp.25 rbp rdi tmp.36 tmp.31 rax))
                                                  (rax (rbp tmp-ra.32))
                                                  (rbp (tmp.25 tmp-ra.32 tmp.36 tmp.31 rax))
                                                  (rdi (tmp-ra.32))))
             (assignment ((tmp-ra.32 r15) (tmp.31 r14) (tmp.25 r14) (tmp.36 r14))))
            (begin
              (set! tmp-ra.32 r15)
              (set! tmp.25 rdi)
              (if (begin
                    (begin
                      (set! tmp.36 tmp.25)
                      (set! tmp.36 (bitwise-and tmp.36 247))
                      (set! tmp.31 tmp.36))
                    (= tmp.31 6))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.32 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.32 rbp rax)))))
    (define L.proc.0.1
      ((locals ()) (conflicts ((tmp-ra.33 (rax ball.9.1 ball.8.2 rbp rsi rdi))
                               (ball.8.2 (rbp tmp-ra.33 rsi))
                               (ball.9.1 (rbp tmp-ra.33))
                               (rdi (tmp-ra.33))
                               (rsi (ball.8.2 tmp-ra.33))
                               (rbp (rax ball.9.1 ball.8.2 tmp-ra.33))
                               (rax (rbp tmp-ra.33))))
                   (assignment ((tmp-ra.33 r15) (ball.8.2 r14) (ball.9.1 r14))))
      (begin
        (set! tmp-ra.33 r15)
        (set! ball.8.2 rdi)
        (set! ball.9.1 rsi)
        (set! rax 27694)
        (jump tmp-ra.33 rbp rax)))
    (define L.fn.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.34 (rax foobar.5.3 ball.9.4 ball.8.5 ball.3.6 bar.0.7 rbp r8 rcx rdx rsi rdi))
         (bar.0.7 (rbp tmp-ra.34 r8 rcx rdx rsi))
         (ball.3.6 (rbp tmp-ra.34 r8 rcx rdx))
         (ball.8.5 (rbp tmp-ra.34 r8 rcx))
         (ball.9.4 (rbp tmp-ra.34 r8))
         (foobar.5.3 (rbp tmp-ra.34))
         (rdi (tmp-ra.34))
         (rsi (bar.0.7 tmp-ra.34))
         (rdx (ball.3.6 bar.0.7 tmp-ra.34))
         (rcx (ball.8.5 ball.3.6 bar.0.7 tmp-ra.34))
         (r8 (ball.9.4 ball.8.5 ball.3.6 bar.0.7 tmp-ra.34))
         (rbp (rax foobar.5.3 ball.9.4 ball.8.5 ball.3.6 bar.0.7 tmp-ra.34))
         (rax (rbp tmp-ra.34))))
       (assignment ((tmp-ra.34 r15) (bar.0.7 r14)
                                    (ball.3.6 r14)
                                    (ball.8.5 r14)
                                    (ball.9.4 r14)
                                    (foobar.5.3 r14))))
      (begin
        (set! tmp-ra.34 r15)
        (set! bar.0.7 rdi)
        (set! ball.3.6 rsi)
        (set! ball.8.5 rdx)
        (set! ball.9.4 rcx)
        (set! foobar.5.3 r8)
        (set! rax 14)
        (jump tmp-ra.34 rbp rax)))
    (begin
      (set! tmp-ra.35 r15)
      (set! rdi 22)
      (set! r15 tmp-ra.35)
      (jump L.boolean?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp-ra.31 (rdi tmp.33 ball.5.4 ball.5.1 foobar.1.2 foo.4.3 rax rbp))
                       (foo.4.3 (tmp.33 ball.5.1 foobar.1.2 rbp tmp-ra.31))
                       (foobar.1.2 (rbp tmp-ra.31 foo.4.3))
                       (ball.5.1 (rbp tmp-ra.31 foo.4.3))
                       (ball.5.4 (rbp tmp-ra.31))
                       (tmp.33 (rbp tmp-ra.31 foo.4.3))
                       (rbp (tmp.33 ball.5.4 ball.5.1 foobar.1.2 foo.4.3 r15 rdi rsi rax tmp-ra.31))
                       (rax (rbp tmp-ra.31))
                       (rsi (r15 rdi rbp))
                       (rdi (tmp-ra.31 r15 rbp rsi))
                       (r15 (rbp rdi rsi))))
           (assignment ((tmp-ra.31 fv0) (foo.4.3 r15)
                                        (foobar.1.2 r14)
                                        (ball.5.1 r14)
                                        (tmp.33 r14)
                                        (ball.5.4 r15))))
          (define L.ascii-char?.2
            ((locals ())
             (conflicts ((tmp.28 (rbp tmp-ra.29)) (tmp.25 (rbp tmp-ra.29))
                                                  (tmp.32 (rbp tmp-ra.29))
                                                  (tmp-ra.29 (tmp.25 rbp rdi tmp.32 tmp.28 rax))
                                                  (rax (rbp tmp-ra.29))
                                                  (rbp (tmp.25 tmp-ra.29 tmp.32 tmp.28 rax))
                                                  (rdi (tmp-ra.29))))
             (assignment ((tmp-ra.29 r15) (tmp.28 r14) (tmp.25 r14) (tmp.32 r14))))
            (begin
              (set! tmp-ra.29 r15)
              (set! tmp.25 rdi)
              (if (begin
                    (begin
                      (set! tmp.32 tmp.25)
                      (set! tmp.32 (bitwise-and tmp.32 255))
                      (set! tmp.28 tmp.32))
                    (= tmp.28 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.29 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.29 rbp rax)))))
    (define L.eq?.1
      ((locals ())
       (conflicts ((tmp.19 (tmp.20 rbp tmp-ra.30 rsi)) (tmp.20 (rbp tmp-ra.30 tmp.19))
                                                       (tmp-ra.30 (tmp.20 tmp.19 rbp rsi rdi rax))
                                                       (rax (rbp tmp-ra.30))
                                                       (rbp (tmp.20 tmp.19 tmp-ra.30 rax))
                                                       (rdi (tmp-ra.30))
                                                       (rsi (tmp.19 tmp-ra.30))))
       (assignment ((tmp-ra.30 r15) (tmp.19 r14) (tmp.20 r13))))
      (begin
        (set! tmp-ra.30 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (= tmp.19 tmp.20)
            (begin
              (set! rax 14)
              (jump tmp-ra.30 rbp rax))
            (begin
              (set! rax 6)
              (jump tmp-ra.30 rbp rax)))))
    (begin
      (set! tmp-ra.31 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.3
                      (begin
                        (set! rsi 0)
                        (set! rdi 22)
                        (set! r15 L.rp.3)
                        (jump L.eq?.1 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 8)))
      (set! foo.4.3 rax)
      (set! foobar.1.2 6)
      (set! ball.5.1 2031626432)
      (if (begin
            (set! tmp.33 14)
            (!= tmp.33 6))
          (set! ball.5.4 30)
          (set! ball.5.4 foo.4.3))
      (set! rdi ball.5.4)
      (set! r15 tmp-ra.31)
      (jump L.ascii-char?.2 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp.32 (rbp tmp-ra.31)) (tmp-ra.31 (rbp tmp.32 rax))
                                                            (rax (rbp tmp-ra.31))
                                                            (rbp (tmp-ra.31 tmp.32 rax))))
                       (assignment ((tmp-ra.31 r15) (tmp.32 r14))))
          (define L.fn.0.1
            ((locals ()) (conflicts ((tmp-ra.28 (rax bat.6.1 bat.8.2 foo.4.3 rbp rdx rsi rdi))
                                     (foo.4.3 (rbp tmp-ra.28 rdx rsi))
                                     (bat.8.2 (bat.6.1 rbp tmp-ra.28 rdx))
                                     (bat.6.1 (rbp tmp-ra.28 bat.8.2))
                                     (rdi (tmp-ra.28))
                                     (rsi (foo.4.3 tmp-ra.28))
                                     (rdx (bat.8.2 foo.4.3 tmp-ra.28))
                                     (rbp (rax bat.6.1 bat.8.2 foo.4.3 tmp-ra.28))
                                     (rax (rbp tmp-ra.28))))
                         (assignment ((tmp-ra.28 r15) (foo.4.3 r14) (bat.8.2 r14) (bat.6.1 r13))))
            (begin
              (set! tmp-ra.28 r15)
              (set! foo.4.3 rdi)
              (set! bat.8.2 rsi)
              (set! bat.6.1 rdx)
              (set! rax bat.8.2)
              (jump tmp-ra.28 rbp rax)))
    (define L.x.1.2
      ((locals ()) (conflicts ((tmp-ra.29 (rax foobar.3.4 rbp rdi)) (foobar.3.4 (rbp tmp-ra.29))
                                                                    (rdi (tmp-ra.29))
                                                                    (rbp (rax foobar.3.4 tmp-ra.29))
                                                                    (rax (rbp tmp-ra.29))))
                   (assignment ((tmp-ra.29 r15) (foobar.3.4 r14))))
      (begin
        (set! tmp-ra.29 r15)
        (set! foobar.3.4 rdi)
        (set! rax 22)
        (jump tmp-ra.29 rbp rax)))
    (define L.func.2.3
      ((locals ()) (conflicts ((tmp-ra.30 (rax rbp)) (rbp (rax tmp-ra.30)) (rax (rbp tmp-ra.30))))
                   (assignment ((tmp-ra.30 r15))))
      (begin
        (set! tmp-ra.30 r15)
        (set! rax 6)
        (jump tmp-ra.30 rbp rax)))
    (begin
      (set! tmp-ra.31 r15)
      (if (begin
            (set! tmp.32 30)
            (!= tmp.32 6))
          (begin
            (set! rax 30)
            (jump tmp-ra.31 rbp rax))
          (begin
            (set! rax 29230)
            (jump tmp-ra.31 rbp rax))))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.35 (rdi rbp)) (rbp (r15 rdi tmp-ra.35))
                                                         (rdi (r15 rbp tmp-ra.35))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.35 r15))))
          (define L.ascii-char?.3
            ((locals ())
             (conflicts ((tmp.31 (rbp tmp-ra.32)) (tmp.28 (rbp tmp-ra.32))
                                                  (tmp.36 (rbp tmp-ra.32))
                                                  (tmp-ra.32 (tmp.28 rbp rdi tmp.36 tmp.31 rax))
                                                  (rax (rbp tmp-ra.32))
                                                  (rbp (tmp.28 tmp-ra.32 tmp.36 tmp.31 rax))
                                                  (rdi (tmp-ra.32))))
             (assignment ((tmp-ra.32 r15) (tmp.31 r14) (tmp.28 r14) (tmp.36 r14))))
            (begin
              (set! tmp-ra.32 r15)
              (set! tmp.28 rdi)
              (if (begin
                    (begin
                      (set! tmp.36 tmp.28)
                      (set! tmp.36 (bitwise-and tmp.36 255))
                      (set! tmp.31 tmp.36))
                    (= tmp.31 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.32 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.32 rbp rax)))))
    (define L.func.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.33 (rax bat.9.1 foobar.6.2 foobar.2.3 ball.0.4 foobar.8.5 rbp r8 rcx rdx rsi rdi))
         (foobar.8.5 (rbp tmp-ra.33 r8 rcx rdx rsi))
         (ball.0.4 (rbp tmp-ra.33 r8 rcx rdx))
         (foobar.2.3 (rbp tmp-ra.33 r8 rcx))
         (foobar.6.2 (rbp tmp-ra.33 r8))
         (bat.9.1 (rbp tmp-ra.33))
         (rdi (tmp-ra.33))
         (rsi (foobar.8.5 tmp-ra.33))
         (rdx (ball.0.4 foobar.8.5 tmp-ra.33))
         (rcx (foobar.2.3 ball.0.4 foobar.8.5 tmp-ra.33))
         (r8 (foobar.6.2 foobar.2.3 ball.0.4 foobar.8.5 tmp-ra.33))
         (rbp (rax bat.9.1 foobar.6.2 foobar.2.3 ball.0.4 foobar.8.5 tmp-ra.33))
         (rax (rbp tmp-ra.33))))
       (assignment ((tmp-ra.33 r15) (foobar.8.5 r14)
                                    (ball.0.4 r14)
                                    (foobar.2.3 r14)
                                    (foobar.6.2 r14)
                                    (bat.9.1 r14))))
      (begin
        (set! tmp-ra.33 r15)
        (set! foobar.8.5 rdi)
        (set! ball.0.4 rsi)
        (set! foobar.2.3 rdx)
        (set! foobar.6.2 rcx)
        (set! bat.9.1 r8)
        (set! rax 6)
        (jump tmp-ra.33 rbp rax)))
    (define L.func.1.2
      ((locals ()) (conflicts ((tmp-ra.34 (rax foo.1.6 foobar.2.7 rbp rsi rdi))
                               (foobar.2.7 (foo.1.6 rbp tmp-ra.34 rsi))
                               (foo.1.6 (rbp tmp-ra.34 foobar.2.7))
                               (rdi (tmp-ra.34))
                               (rsi (foobar.2.7 tmp-ra.34))
                               (rbp (rax foo.1.6 foobar.2.7 tmp-ra.34))
                               (rax (rbp tmp-ra.34))))
                   (assignment ((tmp-ra.34 r15) (foobar.2.7 r14) (foo.1.6 r13))))
      (begin
        (set! tmp-ra.34 r15)
        (set! foobar.2.7 rdi)
        (set! foo.1.6 rsi)
        (set! rax foobar.2.7)
        (jump tmp-ra.34 rbp rax)))
    (begin
      (set! tmp-ra.35 r15)
      (set! rdi 6)
      (set! r15 tmp-ra.35)
      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.38 (rax rbp)) (rbp (rax tmp-ra.38)) (rax (rbp tmp-ra.38))))
                       (assignment ((tmp-ra.38 r15))))
          (define L.proc.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.36 (rax ball.8.1
                               foobar.0.2
                               bat.3.3
                               bar.9.4
                               foo.6.5
                               foobar.7.6
                               ball.4.7
                               rbp
                               fv0
                               r9
                               r8
                               rcx
                               rdx
                               rsi
                               rdi))
               (ball.4.7 (rbp tmp-ra.36 fv0 r9 r8 rcx rdx rsi))
               (foobar.7.6 (rbp tmp-ra.36 fv0 r9 r8 rcx rdx))
               (foo.6.5 (rbp tmp-ra.36 fv0 r9 r8 rcx))
               (bar.9.4 (rbp tmp-ra.36 fv0 r9 r8))
               (bat.3.3 (rbp tmp-ra.36 fv0 r9))
               (foobar.0.2 (rbp tmp-ra.36 fv0))
               (ball.8.1 (rbp tmp-ra.36))
               (rdi (tmp-ra.36))
               (rsi (ball.4.7 tmp-ra.36))
               (rdx (foobar.7.6 ball.4.7 tmp-ra.36))
               (rcx (foo.6.5 foobar.7.6 ball.4.7 tmp-ra.36))
               (r8 (bar.9.4 foo.6.5 foobar.7.6 ball.4.7 tmp-ra.36))
               (r9 (bat.3.3 bar.9.4 foo.6.5 foobar.7.6 ball.4.7 tmp-ra.36))
               (fv0 (foobar.0.2 bat.3.3 bar.9.4 foo.6.5 foobar.7.6 ball.4.7 tmp-ra.36))
               (rbp (rax ball.8.1 foobar.0.2 bat.3.3 bar.9.4 foo.6.5 foobar.7.6 ball.4.7 tmp-ra.36))
               (rax (rbp tmp-ra.36))))
             (assignment ((tmp-ra.36 r15) (ball.4.7 r14)
                                          (foobar.7.6 r14)
                                          (foo.6.5 r14)
                                          (bar.9.4 r14)
                                          (bat.3.3 r14)
                                          (foobar.0.2 r14)
                                          (ball.8.1 r14))))
            (begin
              (set! tmp-ra.36 r15)
              (set! ball.4.7 rdi)
              (set! foobar.7.6 rsi)
              (set! foo.6.5 rdx)
              (set! bar.9.4 rcx)
              (set! bat.3.3 r8)
              (set! foobar.0.2 r9)
              (set! ball.8.1 fv0)
              (set! rax 14)
              (jump tmp-ra.36 rbp rax)))
    (define L.x.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.37 (rax bar.5.8 ball.4.9 foo.1.10 bar.9.11 bat.3.12 rbp r8 rcx rdx rsi rdi))
         (bat.3.12 (rbp tmp-ra.37 r8 rcx rdx rsi))
         (bar.9.11 (rbp tmp-ra.37 r8 rcx rdx))
         (foo.1.10 (bar.5.8 ball.4.9 rbp tmp-ra.37 r8 rcx))
         (ball.4.9 (rbp tmp-ra.37 foo.1.10 r8))
         (bar.5.8 (rbp tmp-ra.37 foo.1.10))
         (rdi (tmp-ra.37))
         (rsi (bat.3.12 tmp-ra.37))
         (rdx (bar.9.11 bat.3.12 tmp-ra.37))
         (rcx (foo.1.10 bar.9.11 bat.3.12 tmp-ra.37))
         (r8 (ball.4.9 foo.1.10 bar.9.11 bat.3.12 tmp-ra.37))
         (rbp (rax bar.5.8 ball.4.9 foo.1.10 bar.9.11 bat.3.12 tmp-ra.37))
         (rax (rbp tmp-ra.37))))
       (assignment
        ((tmp-ra.37 r15) (bat.3.12 r14) (foo.1.10 r14) (bar.9.11 r14) (ball.4.9 r13) (bar.5.8 r13))))
      (begin
        (set! tmp-ra.37 r15)
        (set! bat.3.12 rdi)
        (set! bar.9.11 rsi)
        (set! foo.1.10 rdx)
        (set! ball.4.9 rcx)
        (set! bar.5.8 r8)
        (set! rax foo.1.10)
        (jump tmp-ra.37 rbp rax)))
    (begin
      (set! tmp-ra.38 r15)
      (set! rax 6)
      (jump tmp-ra.38 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.37 (rdi rbp)) (rbp (r15 rdi tmp-ra.37))
                                                         (rdi (r15 rbp tmp-ra.37))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.37 r15))))
          (define L.ascii-char?.3
            ((locals ())
             (conflicts ((tmp.33 (rbp tmp-ra.34)) (tmp.30 (rbp tmp-ra.34))
                                                  (tmp.38 (rbp tmp-ra.34))
                                                  (tmp-ra.34 (tmp.30 rbp rdi tmp.38 tmp.33 rax))
                                                  (rax (rbp tmp-ra.34))
                                                  (rbp (tmp.30 tmp-ra.34 tmp.38 tmp.33 rax))
                                                  (rdi (tmp-ra.34))))
             (assignment ((tmp-ra.34 r15) (tmp.33 r14) (tmp.30 r14) (tmp.38 r14))))
            (begin
              (set! tmp-ra.34 r15)
              (set! tmp.30 rdi)
              (if (begin
                    (begin
                      (set! tmp.38 tmp.30)
                      (set! tmp.38 (bitwise-and tmp.38 255))
                      (set! tmp.33 tmp.38))
                    (= tmp.33 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.34 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.34 rbp rax)))))
    (define L.func.0.1
      ((locals ())
       (conflicts ((tmp-ra.35 (rax foo.9.1 bar.1.2 bat.7.3 bar.8.4 foobar.4.5 rbp r8 rcx rdx rsi rdi))
                   (foobar.4.5 (rbp tmp-ra.35 r8 rcx rdx rsi))
                   (bar.8.4 (rbp tmp-ra.35 r8 rcx rdx))
                   (bat.7.3 (rbp tmp-ra.35 r8 rcx))
                   (bar.1.2 (rbp tmp-ra.35 r8))
                   (foo.9.1 (rbp tmp-ra.35))
                   (rdi (tmp-ra.35))
                   (rsi (foobar.4.5 tmp-ra.35))
                   (rdx (bar.8.4 foobar.4.5 tmp-ra.35))
                   (rcx (bat.7.3 bar.8.4 foobar.4.5 tmp-ra.35))
                   (r8 (bar.1.2 bat.7.3 bar.8.4 foobar.4.5 tmp-ra.35))
                   (rbp (rax foo.9.1 bar.1.2 bat.7.3 bar.8.4 foobar.4.5 tmp-ra.35))
                   (rax (rbp tmp-ra.35))))
       (assignment
        ((tmp-ra.35 r15) (foobar.4.5 r14) (bar.8.4 r14) (bat.7.3 r14) (bar.1.2 r14) (foo.9.1 r14))))
      (begin
        (set! tmp-ra.35 r15)
        (set! foobar.4.5 rdi)
        (set! bar.8.4 rsi)
        (set! bat.7.3 rdx)
        (set! bar.1.2 rcx)
        (set! foo.9.1 r8)
        (set! rax 14)
        (jump tmp-ra.35 rbp rax)))
    (define L.func.1.2
      ((locals ())
       (conflicts ((tmp-ra.36 (rax bar.1.6 foobar.4.7 foo.6.8 foobar.3.9 rbp rcx rdx rsi rdi))
                   (foobar.3.9 (rbp tmp-ra.36 rcx rdx rsi))
                   (foo.6.8 (rbp tmp-ra.36 rcx rdx))
                   (foobar.4.7 (rbp tmp-ra.36 rcx))
                   (bar.1.6 (rbp tmp-ra.36))
                   (rdi (tmp-ra.36))
                   (rsi (foobar.3.9 tmp-ra.36))
                   (rdx (foo.6.8 foobar.3.9 tmp-ra.36))
                   (rcx (foobar.4.7 foo.6.8 foobar.3.9 tmp-ra.36))
                   (rbp (rax bar.1.6 foobar.4.7 foo.6.8 foobar.3.9 tmp-ra.36))
                   (rax (rbp tmp-ra.36))))
       (assignment ((tmp-ra.36 r15) (foobar.3.9 r14) (foo.6.8 r14) (foobar.4.7 r14) (bar.1.6 r14))))
      (begin
        (set! tmp-ra.36 r15)
        (set! foobar.3.9 rdi)
        (set! foo.6.8 rsi)
        (set! foobar.4.7 rdx)
        (set! bar.1.6 rcx)
        (set! rax 6)
        (jump tmp-ra.36 rbp rax)))
    (begin
      (set! tmp-ra.37 r15)
      (set! rdi 20526)
      (set! r15 tmp-ra.37)
      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.34 (rax foobar.2.7 bat.7.8 rbp))
                                   (bat.7.8 (rbp tmp-ra.34))
                                   (foobar.2.7 (rbp tmp-ra.34))
                                   (rbp (rax foobar.2.7 bat.7.8 tmp-ra.34))
                                   (rax (rbp tmp-ra.34))))
                       (assignment ((tmp-ra.34 r15) (bat.7.8 r14) (foobar.2.7 r14))))
          (define L.x.0.1
            ((locals ()) (conflicts ((tmp-ra.32 (rax ball.3.1 rbp rdi)) (ball.3.1 (rbp tmp-ra.32))
                                                                        (rdi (tmp-ra.32))
                                                                        (rbp (rax ball.3.1 tmp-ra.32))
                                                                        (rax (rbp tmp-ra.32))))
                         (assignment ((tmp-ra.32 r15) (ball.3.1 r14))))
            (begin
              (set! tmp-ra.32 r15)
              (set! ball.3.1 rdi)
              (set! rax 0)
              (jump tmp-ra.32 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.33 (rax bat.7.2 ball.3.3 foobar.5.4 foobar.8.5 bat.1.6 rbp r8 rcx rdx rsi rdi))
         (bat.1.6 (rbp tmp-ra.33 r8 rcx rdx rsi))
         (foobar.8.5 (rbp tmp-ra.33 r8 rcx rdx))
         (foobar.5.4 (bat.7.2 ball.3.3 rbp tmp-ra.33 r8 rcx))
         (ball.3.3 (rbp tmp-ra.33 foobar.5.4 r8))
         (bat.7.2 (rbp tmp-ra.33 foobar.5.4))
         (rdi (tmp-ra.33))
         (rsi (bat.1.6 tmp-ra.33))
         (rdx (foobar.8.5 bat.1.6 tmp-ra.33))
         (rcx (foobar.5.4 foobar.8.5 bat.1.6 tmp-ra.33))
         (r8 (ball.3.3 foobar.5.4 foobar.8.5 bat.1.6 tmp-ra.33))
         (rbp (rax bat.7.2 ball.3.3 foobar.5.4 foobar.8.5 bat.1.6 tmp-ra.33))
         (rax (rbp tmp-ra.33))))
       (assignment ((tmp-ra.33 r15) (bat.1.6 r14)
                                    (foobar.5.4 r14)
                                    (foobar.8.5 r14)
                                    (ball.3.3 r13)
                                    (bat.7.2 r13))))
      (begin
        (set! tmp-ra.33 r15)
        (set! bat.1.6 rdi)
        (set! foobar.8.5 rsi)
        (set! foobar.5.4 rdx)
        (set! ball.3.3 rcx)
        (set! bat.7.2 r8)
        (set! rax foobar.5.4)
        (jump tmp-ra.33 rbp rax)))
    (begin
      (set! tmp-ra.34 r15)
      (set! bat.7.8 22)
      (set! foobar.2.7 6)
      (set! rax 22)
      (jump tmp-ra.34 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.40 (rdi rbp)) (rbp (r15 rdi tmp-ra.40))
                                                         (rdi (r15 rbp tmp-ra.40))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.40 r15))))
          (define L.boolean?.3
            ((locals ())
             (conflicts ((tmp.36 (rbp tmp-ra.37)) (tmp.30 (rbp tmp-ra.37))
                                                  (tmp.41 (rbp tmp-ra.37))
                                                  (tmp-ra.37 (tmp.30 rbp rdi tmp.41 tmp.36 rax))
                                                  (rax (rbp tmp-ra.37))
                                                  (rbp (tmp.30 tmp-ra.37 tmp.41 tmp.36 rax))
                                                  (rdi (tmp-ra.37))))
             (assignment ((tmp-ra.37 r15) (tmp.36 r14) (tmp.30 r14) (tmp.41 r14))))
            (begin
              (set! tmp-ra.37 r15)
              (set! tmp.30 rdi)
              (if (begin
                    (begin
                      (set! tmp.41 tmp.30)
                      (set! tmp.41 (bitwise-and tmp.41 247))
                      (set! tmp.36 tmp.41))
                    (= tmp.36 6))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.37 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.37 rbp rax)))))
    (define L.tmp.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.38 (rax bar.5.1 bar.6.2 foobar.7.3 bat.8.4 ball.3.5 rbp r8 rcx rdx rsi rdi))
         (ball.3.5 (rbp tmp-ra.38 r8 rcx rdx rsi))
         (bat.8.4 (rbp tmp-ra.38 r8 rcx rdx))
         (foobar.7.3 (rbp tmp-ra.38 r8 rcx))
         (bar.6.2 (rbp tmp-ra.38 r8))
         (bar.5.1 (rbp tmp-ra.38))
         (rdi (tmp-ra.38))
         (rsi (ball.3.5 tmp-ra.38))
         (rdx (bat.8.4 ball.3.5 tmp-ra.38))
         (rcx (foobar.7.3 bat.8.4 ball.3.5 tmp-ra.38))
         (r8 (bar.6.2 foobar.7.3 bat.8.4 ball.3.5 tmp-ra.38))
         (rbp (rax bar.5.1 bar.6.2 foobar.7.3 bat.8.4 ball.3.5 tmp-ra.38))
         (rax (rbp tmp-ra.38))))
       (assignment
        ((tmp-ra.38 r15) (ball.3.5 r14) (bat.8.4 r14) (foobar.7.3 r14) (bar.6.2 r14) (bar.5.1 r14))))
      (begin
        (set! tmp-ra.38 r15)
        (set! ball.3.5 rdi)
        (set! bat.8.4 rsi)
        (set! foobar.7.3 rdx)
        (set! bar.6.2 rcx)
        (set! bar.5.1 r8)
        (set! rax bar.5.1)
        (jump tmp-ra.38 rbp rax)))
    (define L.tmp.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.39 (rax foo.9.6
                         ball.3.7
                         bar.5.8
                         foobar.7.9
                         bar.6.10
                         foobar.4.11
                         bat.2.12
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bat.2.12 (rbp tmp-ra.39 fv0 r9 r8 rcx rdx rsi))
         (foobar.4.11 (rbp tmp-ra.39 fv0 r9 r8 rcx rdx))
         (bar.6.10 (rbp tmp-ra.39 fv0 r9 r8 rcx))
         (foobar.7.9 (rbp tmp-ra.39 fv0 r9 r8))
         (bar.5.8 (rbp tmp-ra.39 fv0 r9))
         (ball.3.7 (rbp tmp-ra.39 fv0))
         (foo.9.6 (rbp tmp-ra.39))
         (rdi (tmp-ra.39))
         (rsi (bat.2.12 tmp-ra.39))
         (rdx (foobar.4.11 bat.2.12 tmp-ra.39))
         (rcx (bar.6.10 foobar.4.11 bat.2.12 tmp-ra.39))
         (r8 (foobar.7.9 bar.6.10 foobar.4.11 bat.2.12 tmp-ra.39))
         (r9 (bar.5.8 foobar.7.9 bar.6.10 foobar.4.11 bat.2.12 tmp-ra.39))
         (fv0 (ball.3.7 bar.5.8 foobar.7.9 bar.6.10 foobar.4.11 bat.2.12 tmp-ra.39))
         (rbp (rax foo.9.6 ball.3.7 bar.5.8 foobar.7.9 bar.6.10 foobar.4.11 bat.2.12 tmp-ra.39))
         (rax (rbp tmp-ra.39))))
       (assignment ((tmp-ra.39 r15) (bat.2.12 r14)
                                    (foobar.4.11 r14)
                                    (bar.6.10 r14)
                                    (foobar.7.9 r14)
                                    (bar.5.8 r14)
                                    (ball.3.7 r14)
                                    (foo.9.6 r14))))
      (begin
        (set! tmp-ra.39 r15)
        (set! bat.2.12 rdi)
        (set! foobar.4.11 rsi)
        (set! bar.6.10 rdx)
        (set! foobar.7.9 rcx)
        (set! bar.5.8 r8)
        (set! ball.3.7 r9)
        (set! foo.9.6 fv0)
        (set! rax 0)
        (jump tmp-ra.39 rbp rax)))
    (begin
      (set! tmp-ra.40 r15)
      (set! rdi 30)
      (set! r15 tmp-ra.40)
      (jump L.boolean?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.39 (rdi rbp)) (rbp (r15 rdi tmp-ra.39))
                                                         (rdi (r15 rbp tmp-ra.39))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.39 r15))))
          (define L.ascii-char?.3
            ((locals ())
             (conflicts ((tmp.35 (rbp tmp-ra.36)) (tmp.32 (rbp tmp-ra.36))
                                                  (tmp.40 (rbp tmp-ra.36))
                                                  (tmp-ra.36 (tmp.32 rbp rdi tmp.40 tmp.35 rax))
                                                  (rax (rbp tmp-ra.36))
                                                  (rbp (tmp.32 tmp-ra.36 tmp.40 tmp.35 rax))
                                                  (rdi (tmp-ra.36))))
             (assignment ((tmp-ra.36 r15) (tmp.35 r14) (tmp.32 r14) (tmp.40 r14))))
            (begin
              (set! tmp-ra.36 r15)
              (set! tmp.32 rdi)
              (if (begin
                    (begin
                      (set! tmp.40 tmp.32)
                      (set! tmp.40 (bitwise-and tmp.40 255))
                      (set! tmp.35 tmp.40))
                    (= tmp.35 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.36 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.36 rbp rax)))))
    (define L.x.0.1
      ((locals ())
       (conflicts ((tmp-ra.37 (rax ball.7.1 bat.0.2 foobar.6.3 foo.8.4 rbp rcx rdx rsi rdi))
                   (foo.8.4 (rbp tmp-ra.37 rcx rdx rsi))
                   (foobar.6.3 (rbp tmp-ra.37 rcx rdx))
                   (bat.0.2 (rbp tmp-ra.37 rcx))
                   (ball.7.1 (rbp tmp-ra.37))
                   (rdi (tmp-ra.37))
                   (rsi (foo.8.4 tmp-ra.37))
                   (rdx (foobar.6.3 foo.8.4 tmp-ra.37))
                   (rcx (bat.0.2 foobar.6.3 foo.8.4 tmp-ra.37))
                   (rbp (rax ball.7.1 bat.0.2 foobar.6.3 foo.8.4 tmp-ra.37))
                   (rax (rbp tmp-ra.37))))
       (assignment ((tmp-ra.37 r15) (foo.8.4 r14) (foobar.6.3 r14) (bat.0.2 r14) (ball.7.1 r14))))
      (begin
        (set! tmp-ra.37 r15)
        (set! foo.8.4 rdi)
        (set! foobar.6.3 rsi)
        (set! bat.0.2 rdx)
        (set! ball.7.1 rcx)
        (set! rax ball.7.1)
        (jump tmp-ra.37 rbp rax)))
    (define L.fn.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.38 (rax foo.2.5
                         ball.7.6
                         bat.4.7
                         foo.8.8
                         foobar.5.9
                         foobar.9.10
                         bat.3.11
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bat.3.11 (rbp tmp-ra.38 fv0 r9 r8 rcx rdx rsi))
         (foobar.9.10 (rbp tmp-ra.38 fv0 r9 r8 rcx rdx))
         (foobar.5.9 (rbp tmp-ra.38 fv0 r9 r8 rcx))
         (foo.8.8 (rbp tmp-ra.38 fv0 r9 r8))
         (bat.4.7 (rbp tmp-ra.38 fv0 r9))
         (ball.7.6 (rbp tmp-ra.38 fv0))
         (foo.2.5 (rbp tmp-ra.38))
         (rdi (tmp-ra.38))
         (rsi (bat.3.11 tmp-ra.38))
         (rdx (foobar.9.10 bat.3.11 tmp-ra.38))
         (rcx (foobar.5.9 foobar.9.10 bat.3.11 tmp-ra.38))
         (r8 (foo.8.8 foobar.5.9 foobar.9.10 bat.3.11 tmp-ra.38))
         (r9 (bat.4.7 foo.8.8 foobar.5.9 foobar.9.10 bat.3.11 tmp-ra.38))
         (fv0 (ball.7.6 bat.4.7 foo.8.8 foobar.5.9 foobar.9.10 bat.3.11 tmp-ra.38))
         (rbp (rax foo.2.5 ball.7.6 bat.4.7 foo.8.8 foobar.5.9 foobar.9.10 bat.3.11 tmp-ra.38))
         (rax (rbp tmp-ra.38))))
       (assignment ((tmp-ra.38 r15) (bat.3.11 r14)
                                    (foobar.9.10 r14)
                                    (foobar.5.9 r14)
                                    (foo.8.8 r14)
                                    (bat.4.7 r14)
                                    (ball.7.6 r14)
                                    (foo.2.5 r14))))
      (begin
        (set! tmp-ra.38 r15)
        (set! bat.3.11 rdi)
        (set! foobar.9.10 rsi)
        (set! foobar.5.9 rdx)
        (set! foo.8.8 rcx)
        (set! bat.4.7 r8)
        (set! ball.7.6 r9)
        (set! foo.2.5 fv0)
        (set! rax -3529966152)
        (jump tmp-ra.38 rbp rax)))
    (begin
      (set! tmp-ra.39 r15)
      (set! rdi 30)
      (set! r15 tmp-ra.39)
      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp-ra.41 (rdi rsi foo.9.8 rbp)) (foo.9.8 (rbp tmp-ra.41))
                                                         (rbp (r15 rdi rsi foo.9.8 tmp-ra.41))
                                                         (rsi (r15 rdi rbp tmp-ra.41))
                                                         (rdi (r15 rbp rsi tmp-ra.41))
                                                         (r15 (rbp rdi rsi))))
           (assignment ((tmp-ra.41 r15) (foo.9.8 r14))))
          (define L.*.4
            ((locals ())
             (conflicts
              ((tmp.32 (rbp tmp-ra.37 tmp.9 tmp.10))
               (tmp.42 (tmp.10 rbp tmp-ra.37 tmp.9))
               (tmp.10 (rbp tmp-ra.37 tmp.9 tmp.42 tmp.33 tmp.32 tmp.43 tmp.35 tmp.34))
               (tmp.33 (rbp tmp-ra.37 tmp.9 tmp.10))
               (tmp-ra.37 (tmp.10 tmp.9
                                  rbp
                                  rsi
                                  rdi
                                  tmp.42
                                  tmp.33
                                  tmp.32
                                  tmp.43
                                  tmp.35
                                  tmp.34
                                  tmp.45
                                  tmp.36
                                  tmp.44
                                  rax))
               (tmp.44 (rbp tmp-ra.37 tmp.9))
               (tmp.36 (tmp.45 rbp tmp-ra.37 tmp.9))
               (tmp.45 (rbp tmp-ra.37 tmp.36))
               (tmp.35 (rbp tmp-ra.37 tmp.9 tmp.10))
               (tmp.9
                (tmp.10 rbp tmp-ra.37 rsi tmp.42 tmp.33 tmp.32 tmp.43 tmp.35 tmp.34 tmp.36 tmp.44))
               (tmp.43 (tmp.9 rbp tmp-ra.37 tmp.10))
               (tmp.34 (rbp tmp-ra.37 tmp.9 tmp.10))
               (rax (rbp tmp-ra.37))
               (rbp (tmp.10 tmp.9
                            tmp-ra.37
                            tmp.42
                            tmp.33
                            tmp.32
                            tmp.43
                            tmp.35
                            tmp.34
                            tmp.45
                            tmp.36
                            tmp.44
                            rax))
               (rdi (tmp-ra.37))
               (rsi (tmp.9 tmp-ra.37))))
             (assignment ((tmp-ra.37 r15) (tmp.9 r14)
                                          (tmp.10 r13)
                                          (tmp.32 r9)
                                          (tmp.42 r9)
                                          (tmp.33 r9)
                                          (tmp.36 r13)
                                          (tmp.35 r9)
                                          (tmp.43 r9)
                                          (tmp.34 r9)
                                          (tmp.44 r13)
                                          (tmp.45 r14))))
            (begin
              (set! tmp-ra.37 r15)
              (set! tmp.9 rdi)
              (set! tmp.10 rsi)
              (if (begin
                    (if (begin
                          (begin
                            (set! tmp.42 tmp.10)
                            (set! tmp.42 (bitwise-and tmp.42 7))
                            (set! tmp.33 tmp.42))
                          (= tmp.33 0))
                        (set! tmp.32 14)
                        (set! tmp.32 6))
                    (!= tmp.32 6))
                  (if (begin
                        (if (begin
                              (begin
                                (set! tmp.43 tmp.9)
                                (set! tmp.43 (bitwise-and tmp.43 7))
                                (set! tmp.35 tmp.43))
                              (= tmp.35 0))
                            (set! tmp.34 14)
                            (set! tmp.34 6))
                        (!= tmp.34 6))
                      (begin
                        (set! tmp.44 tmp.10)
                        (set! tmp.44 (arithmetic-shift-right tmp.44 3))
                        (set! tmp.36 tmp.44)
                        (set! tmp.45 tmp.9)
                        (set! tmp.45 (* tmp.45 tmp.36))
                        (set! rax tmp.45)
                        (jump tmp-ra.37 rbp rax))
                      (begin
                        (set! rax 318)
                        (jump tmp-ra.37 rbp rax)))
                  (begin
                    (set! rax 318)
                    (jump tmp-ra.37 rbp rax)))))
    (define L.proc.0.1
      ((locals ())
       (conflicts ((tmp-ra.38 (rax foo.0.1 foo.9.2 rbp rsi rdi)) (foo.9.2 (rbp tmp-ra.38 rsi))
                                                                 (foo.0.1 (rbp tmp-ra.38))
                                                                 (rdi (tmp-ra.38))
                                                                 (rsi (foo.9.2 tmp-ra.38))
                                                                 (rbp (rax foo.0.1 foo.9.2 tmp-ra.38))
                                                                 (rax (rbp tmp-ra.38))))
       (assignment ((tmp-ra.38 r15) (foo.9.2 r14) (foo.0.1 r14))))
      (begin
        (set! tmp-ra.38 r15)
        (set! foo.9.2 rdi)
        (set! foo.0.1 rsi)
        (set! rax 14)
        (jump tmp-ra.38 rbp rax)))
    (define L.fn.1.2
      ((locals ()) (conflicts ((tmp-ra.39 (rax bat.7.3 bat.1.4 bat.3.5 rbp rdx rsi rdi))
                               (bat.3.5 (rbp tmp-ra.39 rdx rsi))
                               (bat.1.4 (bat.7.3 rbp tmp-ra.39 rdx))
                               (bat.7.3 (rbp tmp-ra.39 bat.1.4))
                               (rdi (tmp-ra.39))
                               (rsi (bat.3.5 tmp-ra.39))
                               (rdx (bat.1.4 bat.3.5 tmp-ra.39))
                               (rbp (rax bat.7.3 bat.1.4 bat.3.5 tmp-ra.39))
                               (rax (rbp tmp-ra.39))))
                   (assignment ((tmp-ra.39 r15) (bat.3.5 r14) (bat.1.4 r14) (bat.7.3 r13))))
      (begin
        (set! tmp-ra.39 r15)
        (set! bat.3.5 rdi)
        (set! bat.1.4 rsi)
        (set! bat.7.3 rdx)
        (set! rax bat.1.4)
        (jump tmp-ra.39 rbp rax)))
    (define L.func.2.3
      ((locals ())
       (conflicts ((tmp-ra.40 (rax foo.9.6 foo.2.7 rbp rsi rdi)) (foo.2.7 (rbp tmp-ra.40 rsi))
                                                                 (foo.9.6 (rbp tmp-ra.40))
                                                                 (rdi (tmp-ra.40))
                                                                 (rsi (foo.2.7 tmp-ra.40))
                                                                 (rbp (rax foo.9.6 foo.2.7 tmp-ra.40))
                                                                 (rax (rbp tmp-ra.40))))
       (assignment ((tmp-ra.40 r15) (foo.2.7 r14) (foo.9.6 r14))))
      (begin
        (set! tmp-ra.40 r15)
        (set! foo.2.7 rdi)
        (set! foo.9.6 rsi)
        (set! rax 0)
        (jump tmp-ra.40 rbp rax)))
    (begin
      (set! tmp-ra.41 r15)
      (set! foo.9.8 14)
      (set! rsi 8)
      (set! rdi 4105232688)
      (set! r15 tmp-ra.41)
      (jump L.*.4 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.40 (rax rbp)) (rbp (rax tmp-ra.40)) (rax (rbp tmp-ra.40))))
                       (assignment ((tmp-ra.40 r15))))
          (define L.proc.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.37 (rax bat.0.1 foo.2.2 bat.4.3 foo.5.4 foobar.1.5 rbp r8 rcx rdx rsi rdi))
               (foobar.1.5 (rbp tmp-ra.37 r8 rcx rdx rsi))
               (foo.5.4 (rbp tmp-ra.37 r8 rcx rdx))
               (bat.4.3 (rbp tmp-ra.37 r8 rcx))
               (foo.2.2 (rbp tmp-ra.37 r8))
               (bat.0.1 (rbp tmp-ra.37))
               (rdi (tmp-ra.37))
               (rsi (foobar.1.5 tmp-ra.37))
               (rdx (foo.5.4 foobar.1.5 tmp-ra.37))
               (rcx (bat.4.3 foo.5.4 foobar.1.5 tmp-ra.37))
               (r8 (foo.2.2 bat.4.3 foo.5.4 foobar.1.5 tmp-ra.37))
               (rbp (rax bat.0.1 foo.2.2 bat.4.3 foo.5.4 foobar.1.5 tmp-ra.37))
               (rax (rbp tmp-ra.37))))
             (assignment ((tmp-ra.37 r15) (foobar.1.5 r14)
                                          (foo.5.4 r14)
                                          (bat.4.3 r14)
                                          (foo.2.2 r14)
                                          (bat.0.1 r14))))
            (begin
              (set! tmp-ra.37 r15)
              (set! foobar.1.5 rdi)
              (set! foo.5.4 rsi)
              (set! bat.4.3 rdx)
              (set! foo.2.2 rcx)
              (set! bat.0.1 r8)
              (set! rax 14)
              (jump tmp-ra.37 rbp rax)))
    (define L.tmp.1.2
      ((locals ()) (conflicts ((tmp-ra.38 (rax bat.0.6 rbp rdi)) (bat.0.6 (rbp tmp-ra.38))
                                                                 (rdi (tmp-ra.38))
                                                                 (rbp (rax bat.0.6 tmp-ra.38))
                                                                 (rax (rbp tmp-ra.38))))
                   (assignment ((tmp-ra.38 r15) (bat.0.6 r14))))
      (begin
        (set! tmp-ra.38 r15)
        (set! bat.0.6 rdi)
        (set! rax 14)
        (jump tmp-ra.38 rbp rax)))
    (define L.x.2.3
      ((locals ())
       (conflicts
        ((tmp-ra.39 (rax foo.6.7
                         foo.3.8
                         foobar.1.9
                         foo.2.10
                         bat.4.11
                         bar.7.12
                         ball.9.13
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (ball.9.13 (rbp tmp-ra.39 fv0 r9 r8 rcx rdx rsi))
         (bar.7.12 (rbp tmp-ra.39 fv0 r9 r8 rcx rdx))
         (bat.4.11 (rbp tmp-ra.39 fv0 r9 r8 rcx))
         (foo.2.10 (rbp tmp-ra.39 fv0 r9 r8))
         (foobar.1.9 (rbp tmp-ra.39 fv0 r9))
         (foo.3.8 (rbp tmp-ra.39 fv0))
         (foo.6.7 (rbp tmp-ra.39))
         (rdi (tmp-ra.39))
         (rsi (ball.9.13 tmp-ra.39))
         (rdx (bar.7.12 ball.9.13 tmp-ra.39))
         (rcx (bat.4.11 bar.7.12 ball.9.13 tmp-ra.39))
         (r8 (foo.2.10 bat.4.11 bar.7.12 ball.9.13 tmp-ra.39))
         (r9 (foobar.1.9 foo.2.10 bat.4.11 bar.7.12 ball.9.13 tmp-ra.39))
         (fv0 (foo.3.8 foobar.1.9 foo.2.10 bat.4.11 bar.7.12 ball.9.13 tmp-ra.39))
         (rbp (rax foo.6.7 foo.3.8 foobar.1.9 foo.2.10 bat.4.11 bar.7.12 ball.9.13 tmp-ra.39))
         (rax (rbp tmp-ra.39))))
       (assignment ((tmp-ra.39 r15) (ball.9.13 r14)
                                    (bar.7.12 r14)
                                    (bat.4.11 r14)
                                    (foo.2.10 r14)
                                    (foobar.1.9 r14)
                                    (foo.3.8 r14)
                                    (foo.6.7 r14))))
      (begin
        (set! tmp-ra.39 r15)
        (set! ball.9.13 rdi)
        (set! bar.7.12 rsi)
        (set! bat.4.11 rdx)
        (set! foo.2.10 rcx)
        (set! foobar.1.9 r8)
        (set! foo.3.8 r9)
        (set! foo.6.7 fv0)
        (set! rax 6)
        (jump tmp-ra.39 rbp rax)))
    (begin
      (set! tmp-ra.40 r15)
      (set! rax 0)
      (jump tmp-ra.40 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.38 (rax rbp)) (rbp (rax tmp-ra.38)) (rax (rbp tmp-ra.38))))
                       (assignment ((tmp-ra.38 r15))))
          (define L.fn.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.35
                (rax foobar.2.1 bar.8.2 foo.7.3 bar.0.4 foo.3.5 foobar.4.6 rbp r9 r8 rcx rdx rsi rdi))
               (foobar.4.6 (rbp tmp-ra.35 r9 r8 rcx rdx rsi))
               (foo.3.5 (rbp tmp-ra.35 r9 r8 rcx rdx))
               (bar.0.4 (rbp tmp-ra.35 r9 r8 rcx))
               (foo.7.3 (rbp tmp-ra.35 r9 r8))
               (bar.8.2 (rbp tmp-ra.35 r9))
               (foobar.2.1 (rbp tmp-ra.35))
               (rdi (tmp-ra.35))
               (rsi (foobar.4.6 tmp-ra.35))
               (rdx (foo.3.5 foobar.4.6 tmp-ra.35))
               (rcx (bar.0.4 foo.3.5 foobar.4.6 tmp-ra.35))
               (r8 (foo.7.3 bar.0.4 foo.3.5 foobar.4.6 tmp-ra.35))
               (r9 (bar.8.2 foo.7.3 bar.0.4 foo.3.5 foobar.4.6 tmp-ra.35))
               (rbp (rax foobar.2.1 bar.8.2 foo.7.3 bar.0.4 foo.3.5 foobar.4.6 tmp-ra.35))
               (rax (rbp tmp-ra.35))))
             (assignment ((tmp-ra.35 r15) (foobar.4.6 r14)
                                          (foo.3.5 r14)
                                          (bar.0.4 r14)
                                          (foo.7.3 r14)
                                          (bar.8.2 r14)
                                          (foobar.2.1 r14))))
            (begin
              (set! tmp-ra.35 r15)
              (set! foobar.4.6 rdi)
              (set! foo.3.5 rsi)
              (set! bar.0.4 rdx)
              (set! foo.7.3 rcx)
              (set! bar.8.2 r8)
              (set! foobar.2.1 r9)
              (set! rax 22)
              (jump tmp-ra.35 rbp rax)))
    (define L.proc.1.2
      ((locals ()) (conflicts ((tmp-ra.36 (rax bar.0.7 foo.3.8 foo.7.9 rbp rdx rsi rdi))
                               (foo.7.9 (rbp tmp-ra.36 rdx rsi))
                               (foo.3.8 (rbp tmp-ra.36 rdx))
                               (bar.0.7 (rbp tmp-ra.36))
                               (rdi (tmp-ra.36))
                               (rsi (foo.7.9 tmp-ra.36))
                               (rdx (foo.3.8 foo.7.9 tmp-ra.36))
                               (rbp (rax bar.0.7 foo.3.8 foo.7.9 tmp-ra.36))
                               (rax (rbp tmp-ra.36))))
                   (assignment ((tmp-ra.36 r15) (foo.7.9 r14) (foo.3.8 r14) (bar.0.7 r14))))
      (begin
        (set! tmp-ra.36 r15)
        (set! foo.7.9 rdi)
        (set! foo.3.8 rsi)
        (set! bar.0.7 rdx)
        (set! rax 14)
        (jump tmp-ra.36 rbp rax)))
    (define L.x.2.3
      ((locals ()) (conflicts ((tmp-ra.37 (rax bar.8.10 foobar.2.11 rbp rsi rdi))
                               (foobar.2.11 (bar.8.10 rbp tmp-ra.37 rsi))
                               (bar.8.10 (rbp tmp-ra.37 foobar.2.11))
                               (rdi (tmp-ra.37))
                               (rsi (foobar.2.11 tmp-ra.37))
                               (rbp (rax bar.8.10 foobar.2.11 tmp-ra.37))
                               (rax (rbp tmp-ra.37))))
                   (assignment ((tmp-ra.37 r15) (foobar.2.11 r14) (bar.8.10 r13))))
      (begin
        (set! tmp-ra.37 r15)
        (set! foobar.2.11 rdi)
        (set! bar.8.10 rsi)
        (set! rax foobar.2.11)
        (jump tmp-ra.37 rbp rax)))
    (begin
      (set! tmp-ra.38 r15)
      (set! rax 22)
      (jump tmp-ra.38 rbp rax))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.42 (rdi rbp)) (rbp (r15 rdi tmp-ra.42))
                                                         (rdi (r15 rbp tmp-ra.42))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.42 r15))))
          (define L.empty?.3
            ((locals ())
             (conflicts ((tmp.38 (rbp tmp-ra.39)) (tmp.33 (rbp tmp-ra.39))
                                                  (tmp.43 (rbp tmp-ra.39))
                                                  (tmp-ra.39 (tmp.33 rbp rdi tmp.43 tmp.38 rax))
                                                  (rax (rbp tmp-ra.39))
                                                  (rbp (tmp.33 tmp-ra.39 tmp.43 tmp.38 rax))
                                                  (rdi (tmp-ra.39))))
             (assignment ((tmp-ra.39 r15) (tmp.38 r14) (tmp.33 r14) (tmp.43 r14))))
            (begin
              (set! tmp-ra.39 r15)
              (set! tmp.33 rdi)
              (if (begin
                    (begin
                      (set! tmp.43 tmp.33)
                      (set! tmp.43 (bitwise-and tmp.43 255))
                      (set! tmp.38 tmp.43))
                    (= tmp.38 22))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.39 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.39 rbp rax)))))
    (define L.tmp.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.40 (rax ball.8.1
                         bar.4.2
                         bat.3.3
                         ball.1.4
                         foobar.9.5
                         foobar.0.6
                         bar.2.7
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bar.2.7 (rbp tmp-ra.40 fv0 r9 r8 rcx rdx rsi))
         (foobar.0.6 (ball.8.1 bar.4.2 bat.3.3 ball.1.4 foobar.9.5 rbp tmp-ra.40 fv0 r9 r8 rcx rdx))
         (foobar.9.5 (rbp tmp-ra.40 foobar.0.6 fv0 r9 r8 rcx))
         (ball.1.4 (rbp tmp-ra.40 foobar.0.6 fv0 r9 r8))
         (bat.3.3 (rbp tmp-ra.40 foobar.0.6 fv0 r9))
         (bar.4.2 (rbp tmp-ra.40 foobar.0.6 fv0))
         (ball.8.1 (rbp tmp-ra.40 foobar.0.6))
         (rdi (tmp-ra.40))
         (rsi (bar.2.7 tmp-ra.40))
         (rdx (foobar.0.6 bar.2.7 tmp-ra.40))
         (rcx (foobar.9.5 foobar.0.6 bar.2.7 tmp-ra.40))
         (r8 (ball.1.4 foobar.9.5 foobar.0.6 bar.2.7 tmp-ra.40))
         (r9 (bat.3.3 ball.1.4 foobar.9.5 foobar.0.6 bar.2.7 tmp-ra.40))
         (fv0 (bar.4.2 bat.3.3 ball.1.4 foobar.9.5 foobar.0.6 bar.2.7 tmp-ra.40))
         (rbp (rax ball.8.1 bar.4.2 bat.3.3 ball.1.4 foobar.9.5 foobar.0.6 bar.2.7 tmp-ra.40))
         (rax (rbp tmp-ra.40))))
       (assignment ((tmp-ra.40 r15) (foobar.0.6 r14)
                                    (bar.2.7 r14)
                                    (foobar.9.5 r13)
                                    (ball.1.4 r13)
                                    (bat.3.3 r13)
                                    (bar.4.2 r13)
                                    (ball.8.1 r13))))
      (begin
        (set! tmp-ra.40 r15)
        (set! bar.2.7 rdi)
        (set! foobar.0.6 rsi)
        (set! foobar.9.5 rdx)
        (set! ball.1.4 rcx)
        (set! bat.3.3 r8)
        (set! bar.4.2 r9)
        (set! ball.8.1 fv0)
        (set! rax foobar.0.6)
        (jump tmp-ra.40 rbp rax)))
    (define L.x.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.41 (rax foobar.9.8
                         bat.3.9
                         ball.5.10
                         ball.6.11
                         bar.4.12
                         bar.2.13
                         foobar.0.14
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (foobar.0.14 (rbp tmp-ra.41 fv0 r9 r8 rcx rdx rsi))
         (bar.2.13 (rbp tmp-ra.41 fv0 r9 r8 rcx rdx))
         (bar.4.12 (rbp tmp-ra.41 fv0 r9 r8 rcx))
         (ball.6.11 (rbp tmp-ra.41 fv0 r9 r8))
         (ball.5.10 (rbp tmp-ra.41 fv0 r9))
         (bat.3.9 (rbp tmp-ra.41 fv0))
         (foobar.9.8 (rbp tmp-ra.41))
         (rdi (tmp-ra.41))
         (rsi (foobar.0.14 tmp-ra.41))
         (rdx (bar.2.13 foobar.0.14 tmp-ra.41))
         (rcx (bar.4.12 bar.2.13 foobar.0.14 tmp-ra.41))
         (r8 (ball.6.11 bar.4.12 bar.2.13 foobar.0.14 tmp-ra.41))
         (r9 (ball.5.10 ball.6.11 bar.4.12 bar.2.13 foobar.0.14 tmp-ra.41))
         (fv0 (bat.3.9 ball.5.10 ball.6.11 bar.4.12 bar.2.13 foobar.0.14 tmp-ra.41))
         (rbp (rax foobar.9.8 bat.3.9 ball.5.10 ball.6.11 bar.4.12 bar.2.13 foobar.0.14 tmp-ra.41))
         (rax (rbp tmp-ra.41))))
       (assignment ((tmp-ra.41 r15) (foobar.0.14 r14)
                                    (bar.2.13 r14)
                                    (bar.4.12 r14)
                                    (ball.6.11 r14)
                                    (ball.5.10 r14)
                                    (bat.3.9 r14)
                                    (foobar.9.8 r14))))
      (begin
        (set! tmp-ra.41 r15)
        (set! foobar.0.14 rdi)
        (set! bar.2.13 rsi)
        (set! bar.4.12 rdx)
        (set! ball.6.11 rcx)
        (set! ball.5.10 r8)
        (set! bat.3.9 r9)
        (set! foobar.9.8 fv0)
        (set! rax 6)
        (jump tmp-ra.41 rbp rax)))
    (begin
      (set! tmp-ra.42 r15)
      (set! rdi 8)
      (set! r15 tmp-ra.42)
      (jump L.empty?.3 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp.38 (rbp tmp-ra.37)) (tmp-ra.37 (rbp tmp.38 rax))
                                                            (rax (rbp tmp-ra.37))
                                                            (rbp (tmp-ra.37 tmp.38 rax))))
                       (assignment ((tmp-ra.37 r15) (tmp.38 r14))))
          (define L.proc.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.34 (rax bar.4.1
                               foobar.0.2
                               bar.3.3
                               bar.6.4
                               bat.9.5
                               foobar.2.6
                               foobar.8.7
                               rbp
                               fv0
                               r9
                               r8
                               rcx
                               rdx
                               rsi
                               rdi))
               (foobar.8.7 (rbp tmp-ra.34 fv0 r9 r8 rcx rdx rsi))
               (foobar.2.6 (rbp tmp-ra.34 fv0 r9 r8 rcx rdx))
               (bat.9.5 (rbp tmp-ra.34 fv0 r9 r8 rcx))
               (bar.6.4 (rbp tmp-ra.34 fv0 r9 r8))
               (bar.3.3 (rbp tmp-ra.34 fv0 r9))
               (foobar.0.2 (rbp tmp-ra.34 fv0))
               (bar.4.1 (rbp tmp-ra.34))
               (rdi (tmp-ra.34))
               (rsi (foobar.8.7 tmp-ra.34))
               (rdx (foobar.2.6 foobar.8.7 tmp-ra.34))
               (rcx (bat.9.5 foobar.2.6 foobar.8.7 tmp-ra.34))
               (r8 (bar.6.4 bat.9.5 foobar.2.6 foobar.8.7 tmp-ra.34))
               (r9 (bar.3.3 bar.6.4 bat.9.5 foobar.2.6 foobar.8.7 tmp-ra.34))
               (fv0 (foobar.0.2 bar.3.3 bar.6.4 bat.9.5 foobar.2.6 foobar.8.7 tmp-ra.34))
               (rbp (rax bar.4.1 foobar.0.2 bar.3.3 bar.6.4 bat.9.5 foobar.2.6 foobar.8.7 tmp-ra.34))
               (rax (rbp tmp-ra.34))))
             (assignment ((tmp-ra.34 r15) (foobar.8.7 r14)
                                          (foobar.2.6 r14)
                                          (bat.9.5 r14)
                                          (bar.6.4 r14)
                                          (bar.3.3 r14)
                                          (foobar.0.2 r14)
                                          (bar.4.1 r14))))
            (begin
              (set! tmp-ra.34 r15)
              (set! foobar.8.7 rdi)
              (set! foobar.2.6 rsi)
              (set! bat.9.5 rdx)
              (set! bar.6.4 rcx)
              (set! bar.3.3 r8)
              (set! foobar.0.2 r9)
              (set! bar.4.1 fv0)
              (set! rax 8)
              (jump tmp-ra.34 rbp rax)))
    (define L.func.1.2
      ((locals ()) (conflicts ((tmp-ra.35 (rax rbp)) (rbp (rax tmp-ra.35)) (rax (rbp tmp-ra.35))))
                   (assignment ((tmp-ra.35 r15))))
      (begin
        (set! tmp-ra.35 r15)
        (set! rax 14)
        (jump tmp-ra.35 rbp rax)))
    (define L.fn.2.3
      ((locals ()) (conflicts ((tmp-ra.36 (rax foobar.0.8 ball.1.9 foobar.7.10 rbp rdx rsi rdi))
                               (foobar.7.10 (rbp tmp-ra.36 rdx rsi))
                               (ball.1.9 (foobar.0.8 rbp tmp-ra.36 rdx))
                               (foobar.0.8 (rbp tmp-ra.36 ball.1.9))
                               (rdi (tmp-ra.36))
                               (rsi (foobar.7.10 tmp-ra.36))
                               (rdx (ball.1.9 foobar.7.10 tmp-ra.36))
                               (rbp (rax foobar.0.8 ball.1.9 foobar.7.10 tmp-ra.36))
                               (rax (rbp tmp-ra.36))))
                   (assignment ((tmp-ra.36 r15) (foobar.7.10 r14) (ball.1.9 r14) (foobar.0.8 r13))))
      (begin
        (set! tmp-ra.36 r15)
        (set! foobar.7.10 rdi)
        (set! ball.1.9 rsi)
        (set! foobar.0.8 rdx)
        (set! rax ball.1.9)
        (jump tmp-ra.36 rbp rax)))
    (begin
      (set! tmp-ra.37 r15)
      (if (begin
            (set! tmp.38 6)
            (!= tmp.38 6))
          (begin
            (set! rax 14)
            (jump tmp-ra.37 rbp rax))
          (begin
            (set! rax 22)
            (jump tmp-ra.37 rbp rax))))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.40 (rdi rbp)) (rbp (r15 rdi tmp-ra.40))
                                                         (rdi (r15 rbp tmp-ra.40))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.40 r15))))
          (define L.ascii-char?.4
            ((locals ())
             (conflicts ((tmp.35 (rbp tmp-ra.36)) (tmp.32 (rbp tmp-ra.36))
                                                  (tmp.41 (rbp tmp-ra.36))
                                                  (tmp-ra.36 (tmp.32 rbp rdi tmp.41 tmp.35 rax))
                                                  (rax (rbp tmp-ra.36))
                                                  (rbp (tmp.32 tmp-ra.36 tmp.41 tmp.35 rax))
                                                  (rdi (tmp-ra.36))))
             (assignment ((tmp-ra.36 r15) (tmp.35 r14) (tmp.32 r14) (tmp.41 r14))))
            (begin
              (set! tmp-ra.36 r15)
              (set! tmp.32 rdi)
              (if (begin
                    (begin
                      (set! tmp.41 tmp.32)
                      (set! tmp.41 (bitwise-and tmp.41 255))
                      (set! tmp.35 tmp.41))
                    (= tmp.35 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.36 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.36 rbp rax)))))
    (define L.fn.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.37 (rax foobar.8.1
                         foobar.5.2
                         ball.0.3
                         foo.9.4
                         bat.6.5
                         bar.4.6
                         foobar.3.7
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (foobar.3.7 (rbp tmp-ra.37 fv0 r9 r8 rcx rdx rsi))
         (bar.4.6 (rbp tmp-ra.37 fv0 r9 r8 rcx rdx))
         (bat.6.5 (foobar.8.1 foobar.5.2 ball.0.3 foo.9.4 rbp tmp-ra.37 fv0 r9 r8 rcx))
         (foo.9.4 (rbp tmp-ra.37 bat.6.5 fv0 r9 r8))
         (ball.0.3 (rbp tmp-ra.37 bat.6.5 fv0 r9))
         (foobar.5.2 (rbp tmp-ra.37 bat.6.5 fv0))
         (foobar.8.1 (rbp tmp-ra.37 bat.6.5))
         (rdi (tmp-ra.37))
         (rsi (foobar.3.7 tmp-ra.37))
         (rdx (bar.4.6 foobar.3.7 tmp-ra.37))
         (rcx (bat.6.5 bar.4.6 foobar.3.7 tmp-ra.37))
         (r8 (foo.9.4 bat.6.5 bar.4.6 foobar.3.7 tmp-ra.37))
         (r9 (ball.0.3 foo.9.4 bat.6.5 bar.4.6 foobar.3.7 tmp-ra.37))
         (fv0 (foobar.5.2 ball.0.3 foo.9.4 bat.6.5 bar.4.6 foobar.3.7 tmp-ra.37))
         (rbp (rax foobar.8.1 foobar.5.2 ball.0.3 foo.9.4 bat.6.5 bar.4.6 foobar.3.7 tmp-ra.37))
         (rax (rbp tmp-ra.37))))
       (assignment ((tmp-ra.37 r15) (bat.6.5 r14)
                                    (foobar.3.7 r14)
                                    (bar.4.6 r14)
                                    (foo.9.4 r13)
                                    (ball.0.3 r13)
                                    (foobar.5.2 r13)
                                    (foobar.8.1 r13))))
      (begin
        (set! tmp-ra.37 r15)
        (set! foobar.3.7 rdi)
        (set! bar.4.6 rsi)
        (set! bat.6.5 rdx)
        (set! foo.9.4 rcx)
        (set! ball.0.3 r8)
        (set! foobar.5.2 r9)
        (set! foobar.8.1 fv0)
        (set! rax bat.6.5)
        (jump tmp-ra.37 rbp rax)))
    (define L.tmp.1.2
      ((locals ()) (conflicts ((tmp-ra.38 (rax ball.1.8 rbp rdi)) (ball.1.8 (rbp tmp-ra.38))
                                                                  (rdi (tmp-ra.38))
                                                                  (rbp (rax ball.1.8 tmp-ra.38))
                                                                  (rax (rbp tmp-ra.38))))
                   (assignment ((tmp-ra.38 r15) (ball.1.8 r14))))
      (begin
        (set! tmp-ra.38 r15)
        (set! ball.1.8 rdi)
        (set! rax ball.1.8)
        (jump tmp-ra.38 rbp rax)))
    (define L.tmp.2.3
      ((locals ()) (conflicts ((tmp-ra.39 (rax ball.0.9 foobar.5.10 foobar.8.11 rbp rdx rsi rdi))
                               (foobar.8.11 (rbp tmp-ra.39 rdx rsi))
                               (foobar.5.10 (rbp tmp-ra.39 rdx))
                               (ball.0.9 (rbp tmp-ra.39))
                               (rdi (tmp-ra.39))
                               (rsi (foobar.8.11 tmp-ra.39))
                               (rdx (foobar.5.10 foobar.8.11 tmp-ra.39))
                               (rbp (rax ball.0.9 foobar.5.10 foobar.8.11 tmp-ra.39))
                               (rax (rbp tmp-ra.39))))
                   (assignment ((tmp-ra.39 r15) (foobar.8.11 r14) (foobar.5.10 r14) (ball.0.9 r14))))
      (begin
        (set! tmp-ra.39 r15)
        (set! foobar.8.11 rdi)
        (set! foobar.5.10 rsi)
        (set! ball.0.9 rdx)
        (set! rax 6)
        (jump tmp-ra.39 rbp rax)))
    (begin
      (set! tmp-ra.40 r15)
      (set! rdi 8)
      (set! r15 tmp-ra.40)
      (jump L.ascii-char?.4 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.42 (rdi rbp)) (rbp (r15 rdi tmp-ra.42))
                                                         (rdi (r15 rbp tmp-ra.42))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.42 r15))))
          (define L.boolean?.4
            ((locals ())
             (conflicts ((tmp.37 (rbp tmp-ra.38)) (tmp.31 (rbp tmp-ra.38))
                                                  (tmp.43 (rbp tmp-ra.38))
                                                  (tmp-ra.38 (tmp.31 rbp rdi tmp.43 tmp.37 rax))
                                                  (rax (rbp tmp-ra.38))
                                                  (rbp (tmp.31 tmp-ra.38 tmp.43 tmp.37 rax))
                                                  (rdi (tmp-ra.38))))
             (assignment ((tmp-ra.38 r15) (tmp.37 r14) (tmp.31 r14) (tmp.43 r14))))
            (begin
              (set! tmp-ra.38 r15)
              (set! tmp.31 rdi)
              (if (begin
                    (begin
                      (set! tmp.43 tmp.31)
                      (set! tmp.43 (bitwise-and tmp.43 247))
                      (set! tmp.37 tmp.43))
                    (= tmp.37 6))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.38 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.38 rbp rax)))))
    (define L.tmp.0.1
      ((locals ()) (conflicts ((tmp-ra.39 (rax foobar.0.1 bar.6.2 foo.4.3 rbp rdx rsi rdi))
                               (foo.4.3 (rbp tmp-ra.39 rdx rsi))
                               (bar.6.2 (foobar.0.1 rbp tmp-ra.39 rdx))
                               (foobar.0.1 (rbp tmp-ra.39 bar.6.2))
                               (rdi (tmp-ra.39))
                               (rsi (foo.4.3 tmp-ra.39))
                               (rdx (bar.6.2 foo.4.3 tmp-ra.39))
                               (rbp (rax foobar.0.1 bar.6.2 foo.4.3 tmp-ra.39))
                               (rax (rbp tmp-ra.39))))
                   (assignment ((tmp-ra.39 r15) (foo.4.3 r14) (bar.6.2 r14) (foobar.0.1 r13))))
      (begin
        (set! tmp-ra.39 r15)
        (set! foo.4.3 rdi)
        (set! bar.6.2 rsi)
        (set! foobar.0.1 rdx)
        (set! rax bar.6.2)
        (jump tmp-ra.39 rbp rax)))
    (define L.fn.1.2
      ((locals ())
       (conflicts ((tmp-ra.40 (rax bat.2.4 foobar.3.5 ball.9.6 foo.1.7 rbp rcx rdx rsi rdi))
                   (foo.1.7 (bat.2.4 foobar.3.5 ball.9.6 rbp tmp-ra.40 rcx rdx rsi))
                   (ball.9.6 (rbp tmp-ra.40 foo.1.7 rcx rdx))
                   (foobar.3.5 (rbp tmp-ra.40 foo.1.7 rcx))
                   (bat.2.4 (rbp tmp-ra.40 foo.1.7))
                   (rdi (tmp-ra.40))
                   (rsi (foo.1.7 tmp-ra.40))
                   (rdx (ball.9.6 foo.1.7 tmp-ra.40))
                   (rcx (foobar.3.5 ball.9.6 foo.1.7 tmp-ra.40))
                   (rbp (rax bat.2.4 foobar.3.5 ball.9.6 foo.1.7 tmp-ra.40))
                   (rax (rbp tmp-ra.40))))
       (assignment ((tmp-ra.40 r15) (foo.1.7 r14) (ball.9.6 r13) (foobar.3.5 r13) (bat.2.4 r13))))
      (begin
        (set! tmp-ra.40 r15)
        (set! foo.1.7 rdi)
        (set! ball.9.6 rsi)
        (set! foobar.3.5 rdx)
        (set! bat.2.4 rcx)
        (set! rax foo.1.7)
        (jump tmp-ra.40 rbp rax)))
    (define L.x.2.3
      ((locals ())
       (conflicts
        ((tmp-ra.41
          (rax foobar.0.8 ball.9.9 foo.1.10 foobar.7.11 bat.2.12 bar.6.13 rbp r9 r8 rcx rdx rsi rdi))
         (bar.6.13 (rbp tmp-ra.41 r9 r8 rcx rdx rsi))
         (bat.2.12 (rbp tmp-ra.41 r9 r8 rcx rdx))
         (foobar.7.11 (rbp tmp-ra.41 r9 r8 rcx))
         (foo.1.10 (rbp tmp-ra.41 r9 r8))
         (ball.9.9 (rbp tmp-ra.41 r9))
         (foobar.0.8 (rbp tmp-ra.41))
         (rdi (tmp-ra.41))
         (rsi (bar.6.13 tmp-ra.41))
         (rdx (bat.2.12 bar.6.13 tmp-ra.41))
         (rcx (foobar.7.11 bat.2.12 bar.6.13 tmp-ra.41))
         (r8 (foo.1.10 foobar.7.11 bat.2.12 bar.6.13 tmp-ra.41))
         (r9 (ball.9.9 foo.1.10 foobar.7.11 bat.2.12 bar.6.13 tmp-ra.41))
         (rbp (rax foobar.0.8 ball.9.9 foo.1.10 foobar.7.11 bat.2.12 bar.6.13 tmp-ra.41))
         (rax (rbp tmp-ra.41))))
       (assignment ((tmp-ra.41 r15) (bar.6.13 r14)
                                    (bat.2.12 r14)
                                    (foobar.7.11 r14)
                                    (foo.1.10 r14)
                                    (ball.9.9 r14)
                                    (foobar.0.8 r14))))
      (begin
        (set! tmp-ra.41 r15)
        (set! bar.6.13 rdi)
        (set! bat.2.12 rsi)
        (set! foobar.7.11 rdx)
        (set! foo.1.10 rcx)
        (set! ball.9.9 r8)
        (set! foobar.0.8 r9)
        (set! rax 8)
        (jump tmp-ra.41 rbp rax)))
    (begin
      (set! tmp-ra.42 r15)
      (set! rdi 6)
      (set! r15 tmp-ra.42)
      (jump L.boolean?.4 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.45 (rdi rbp)) (rbp (r15 rdi tmp-ra.45))
                                                         (rdi (r15 rbp tmp-ra.45))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.45 r15))))
          (define L.ascii-char?.4
            ((locals ())
             (conflicts ((tmp.40 (rbp tmp-ra.41)) (tmp.37 (rbp tmp-ra.41))
                                                  (tmp.46 (rbp tmp-ra.41))
                                                  (tmp-ra.41 (tmp.37 rbp rdi tmp.46 tmp.40 rax))
                                                  (rax (rbp tmp-ra.41))
                                                  (rbp (tmp.37 tmp-ra.41 tmp.46 tmp.40 rax))
                                                  (rdi (tmp-ra.41))))
             (assignment ((tmp-ra.41 r15) (tmp.40 r14) (tmp.37 r14) (tmp.46 r14))))
            (begin
              (set! tmp-ra.41 r15)
              (set! tmp.37 rdi)
              (if (begin
                    (begin
                      (set! tmp.46 tmp.37)
                      (set! tmp.46 (bitwise-and tmp.46 255))
                      (set! tmp.40 tmp.46))
                    (= tmp.40 46))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.41 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.41 rbp rax)))))
    (define L.tmp.0.1
      ((locals ())
       (conflicts ((tmp-ra.42 (rax ball.3.1
                                   bar.5.2
                                   bar.2.3
                                   bar.8.4
                                   bat.4.5
                                   bar.0.6
                                   bat.9.7
                                   rbp
                                   fv0
                                   r9
                                   r8
                                   rcx
                                   rdx
                                   rsi
                                   rdi))
                   (bat.9.7 (rbp tmp-ra.42 fv0 r9 r8 rcx rdx rsi))
                   (bar.0.6 (rbp tmp-ra.42 fv0 r9 r8 rcx rdx))
                   (bat.4.5 (rbp tmp-ra.42 fv0 r9 r8 rcx))
                   (bar.8.4 (rbp tmp-ra.42 fv0 r9 r8))
                   (bar.2.3 (rbp tmp-ra.42 fv0 r9))
                   (bar.5.2 (ball.3.1 rbp tmp-ra.42 fv0))
                   (ball.3.1 (rbp tmp-ra.42 bar.5.2))
                   (rdi (tmp-ra.42))
                   (rsi (bat.9.7 tmp-ra.42))
                   (rdx (bar.0.6 bat.9.7 tmp-ra.42))
                   (rcx (bat.4.5 bar.0.6 bat.9.7 tmp-ra.42))
                   (r8 (bar.8.4 bat.4.5 bar.0.6 bat.9.7 tmp-ra.42))
                   (r9 (bar.2.3 bar.8.4 bat.4.5 bar.0.6 bat.9.7 tmp-ra.42))
                   (fv0 (bar.5.2 bar.2.3 bar.8.4 bat.4.5 bar.0.6 bat.9.7 tmp-ra.42))
                   (rbp (rax ball.3.1 bar.5.2 bar.2.3 bar.8.4 bat.4.5 bar.0.6 bat.9.7 tmp-ra.42))
                   (rax (rbp tmp-ra.42))))
       (assignment ((tmp-ra.42 r15) (bat.9.7 r14)
                                    (bar.0.6 r14)
                                    (bat.4.5 r14)
                                    (bar.8.4 r14)
                                    (bar.2.3 r14)
                                    (bar.5.2 r14)
                                    (ball.3.1 r13))))
      (begin
        (set! tmp-ra.42 r15)
        (set! bat.9.7 rdi)
        (set! bar.0.6 rsi)
        (set! bat.4.5 rdx)
        (set! bar.8.4 rcx)
        (set! bar.2.3 r8)
        (set! bar.5.2 r9)
        (set! ball.3.1 fv0)
        (set! rax bar.5.2)
        (jump tmp-ra.42 rbp rax)))
    (define L.x.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.43 (rax bar.5.8 bar.8.9 foo.7.10 bar.0.11 ball.3.12 rbp r8 rcx rdx rsi rdi))
         (ball.3.12 (rbp tmp-ra.43 r8 rcx rdx rsi))
         (bar.0.11 (rbp tmp-ra.43 r8 rcx rdx))
         (foo.7.10 (rbp tmp-ra.43 r8 rcx))
         (bar.8.9 (rbp tmp-ra.43 r8))
         (bar.5.8 (rbp tmp-ra.43))
         (rdi (tmp-ra.43))
         (rsi (ball.3.12 tmp-ra.43))
         (rdx (bar.0.11 ball.3.12 tmp-ra.43))
         (rcx (foo.7.10 bar.0.11 ball.3.12 tmp-ra.43))
         (r8 (bar.8.9 foo.7.10 bar.0.11 ball.3.12 tmp-ra.43))
         (rbp (rax bar.5.8 bar.8.9 foo.7.10 bar.0.11 ball.3.12 tmp-ra.43))
         (rax (rbp tmp-ra.43))))
       (assignment
        ((tmp-ra.43 r15) (ball.3.12 r14) (bar.0.11 r14) (foo.7.10 r14) (bar.8.9 r14) (bar.5.8 r14))))
      (begin
        (set! tmp-ra.43 r15)
        (set! ball.3.12 rdi)
        (set! bar.0.11 rsi)
        (set! foo.7.10 rdx)
        (set! bar.8.9 rcx)
        (set! bar.5.8 r8)
        (set! rax 0)
        (jump tmp-ra.43 rbp rax)))
    (define L.func.2.3
      ((locals ())
       (conflicts ((tmp-ra.44 (rax foobar.1.13 bar.8.14 bar.2.15 foo.7.16 rbp rcx rdx rsi rdi))
                   (foo.7.16 (rbp tmp-ra.44 rcx rdx rsi))
                   (bar.2.15 (rbp tmp-ra.44 rcx rdx))
                   (bar.8.14 (rbp tmp-ra.44 rcx))
                   (foobar.1.13 (rbp tmp-ra.44))
                   (rdi (tmp-ra.44))
                   (rsi (foo.7.16 tmp-ra.44))
                   (rdx (bar.2.15 foo.7.16 tmp-ra.44))
                   (rcx (bar.8.14 bar.2.15 foo.7.16 tmp-ra.44))
                   (rbp (rax foobar.1.13 bar.8.14 bar.2.15 foo.7.16 tmp-ra.44))
                   (rax (rbp tmp-ra.44))))
       (assignment ((tmp-ra.44 r15) (foo.7.16 r14) (bar.2.15 r14) (bar.8.14 r14) (foobar.1.13 r14))))
      (begin
        (set! tmp-ra.44 r15)
        (set! foo.7.16 rdi)
        (set! bar.2.15 rsi)
        (set! bar.8.14 rdx)
        (set! foobar.1.13 rcx)
        (set! rax 8)
        (jump tmp-ra.44 rbp rax)))
    (begin
      (set! tmp-ra.45 r15)
      (set! rdi 22)
      (set! r15 tmp-ra.45)
      (jump L.ascii-char?.4 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.46 (rdi rsi bat.5.13 rax rbp))
                                   (bat.5.13 (rbp tmp-ra.46))
                                   (rbp (bat.5.13 r15 rdi rsi rax tmp-ra.46))
                                   (rax (rbp tmp-ra.46))
                                   (rsi (tmp-ra.46 r15 rdi rbp))
                                   (rdi (tmp-ra.46 r15 rbp rsi))
                                   (r15 (rbp rdi rsi))))
                       (assignment ((tmp-ra.46 fv0) (bat.5.13 r15))))
          (define L.<.5
            ((locals ())
             (conflicts
              ((tmp.37 (rbp tmp-ra.41 tmp.20 tmp.21))
               (tmp.47 (tmp.21 rbp tmp-ra.41 tmp.20))
               (tmp.21 (rbp tmp-ra.41 tmp.20 tmp.47 tmp.38 tmp.37 tmp.48 tmp.40 tmp.39))
               (tmp.38 (rbp tmp-ra.41 tmp.20 tmp.21))
               (tmp-ra.41 (tmp.21 tmp.20 rbp rsi rdi tmp.47 tmp.38 tmp.37 tmp.48 tmp.40 tmp.39 rax))
               (tmp.40 (rbp tmp-ra.41 tmp.20 tmp.21))
               (tmp.20 (tmp.21 rbp tmp-ra.41 rsi tmp.47 tmp.38 tmp.37 tmp.48 tmp.40 tmp.39))
               (tmp.48 (tmp.20 rbp tmp-ra.41 tmp.21))
               (tmp.39 (rbp tmp-ra.41 tmp.20 tmp.21))
               (rax (rbp tmp-ra.41))
               (rbp (tmp.21 tmp.20 tmp-ra.41 tmp.47 tmp.38 tmp.37 tmp.48 tmp.40 tmp.39 rax))
               (rdi (tmp-ra.41))
               (rsi (tmp.20 tmp-ra.41))))
             (assignment ((tmp-ra.41 r15) (tmp.20 r14)
                                          (tmp.21 r13)
                                          (tmp.37 r9)
                                          (tmp.47 r9)
                                          (tmp.38 r9)
                                          (tmp.40 r9)
                                          (tmp.48 r9)
                                          (tmp.39 r9))))
            (begin
              (set! tmp-ra.41 r15)
              (set! tmp.20 rdi)
              (set! tmp.21 rsi)
              (if (begin
                    (if (begin
                          (begin
                            (set! tmp.47 tmp.21)
                            (set! tmp.47 (bitwise-and tmp.47 7))
                            (set! tmp.38 tmp.47))
                          (= tmp.38 0))
                        (set! tmp.37 14)
                        (set! tmp.37 6))
                    (!= tmp.37 6))
                  (if (begin
                        (if (begin
                              (begin
                                (set! tmp.48 tmp.20)
                                (set! tmp.48 (bitwise-and tmp.48 7))
                                (set! tmp.40 tmp.48))
                              (= tmp.40 0))
                            (set! tmp.39 14)
                            (set! tmp.39 6))
                        (!= tmp.39 6))
                      (if (< tmp.20 tmp.21)
                          (begin
                            (set! rax 14)
                            (jump tmp-ra.41 rbp rax))
                          (begin
                            (set! rax 6)
                            (jump tmp-ra.41 rbp rax)))
                      (begin
                        (set! rax 1086)
                        (jump tmp-ra.41 rbp rax)))
                  (begin
                    (set! rax 1086)
                    (jump tmp-ra.41 rbp rax)))))
    (define L.eq?.4
      ((locals ())
       (conflicts ((tmp.28 (tmp.29 rbp tmp-ra.42 rsi)) (tmp.29 (rbp tmp-ra.42 tmp.28))
                                                       (tmp-ra.42 (tmp.29 tmp.28 rbp rsi rdi rax))
                                                       (rax (rbp tmp-ra.42))
                                                       (rbp (tmp.29 tmp.28 tmp-ra.42 rax))
                                                       (rdi (tmp-ra.42))
                                                       (rsi (tmp.28 tmp-ra.42))))
       (assignment ((tmp-ra.42 r15) (tmp.28 r14) (tmp.29 r13))))
      (begin
        (set! tmp-ra.42 r15)
        (set! tmp.28 rdi)
        (set! tmp.29 rsi)
        (if (= tmp.28 tmp.29)
            (begin
              (set! rax 14)
              (jump tmp-ra.42 rbp rax))
            (begin
              (set! rax 6)
              (jump tmp-ra.42 rbp rax)))))
    (define L.proc.0.1
      ((locals ())
       (conflicts ((tmp-ra.43 (rax foo.1.1 foobar.7.2 ball.8.3 bat.2.4 rbp rcx rdx rsi rdi))
                   (bat.2.4 (rbp tmp-ra.43 rcx rdx rsi))
                   (ball.8.3 (rbp tmp-ra.43 rcx rdx))
                   (foobar.7.2 (rbp tmp-ra.43 rcx))
                   (foo.1.1 (rbp tmp-ra.43))
                   (rdi (tmp-ra.43))
                   (rsi (bat.2.4 tmp-ra.43))
                   (rdx (ball.8.3 bat.2.4 tmp-ra.43))
                   (rcx (foobar.7.2 ball.8.3 bat.2.4 tmp-ra.43))
                   (rbp (rax foo.1.1 foobar.7.2 ball.8.3 bat.2.4 tmp-ra.43))
                   (rax (rbp tmp-ra.43))))
       (assignment ((tmp-ra.43 r15) (bat.2.4 r14) (ball.8.3 r14) (foobar.7.2 r14) (foo.1.1 r14))))
      (begin
        (set! tmp-ra.43 r15)
        (set! bat.2.4 rdi)
        (set! ball.8.3 rsi)
        (set! foobar.7.2 rdx)
        (set! foo.1.1 rcx)
        (set! rax 14)
        (jump tmp-ra.43 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.44 (rax bat.0.5 foobar.7.6 foobar.3.7 foo.6.8 bat.5.9 rbp r8 rcx rdx rsi rdi))
         (bat.5.9 (rbp tmp-ra.44 r8 rcx rdx rsi))
         (foo.6.8 (rbp tmp-ra.44 r8 rcx rdx))
         (foobar.3.7 (rbp tmp-ra.44 r8 rcx))
         (foobar.7.6 (rbp tmp-ra.44 r8))
         (bat.0.5 (rbp tmp-ra.44))
         (rdi (tmp-ra.44))
         (rsi (bat.5.9 tmp-ra.44))
         (rdx (foo.6.8 bat.5.9 tmp-ra.44))
         (rcx (foobar.3.7 foo.6.8 bat.5.9 tmp-ra.44))
         (r8 (foobar.7.6 foobar.3.7 foo.6.8 bat.5.9 tmp-ra.44))
         (rbp (rax bat.0.5 foobar.7.6 foobar.3.7 foo.6.8 bat.5.9 tmp-ra.44))
         (rax (rbp tmp-ra.44))))
       (assignment ((tmp-ra.44 r15) (bat.5.9 r14)
                                    (foo.6.8 r14)
                                    (foobar.3.7 r14)
                                    (foobar.7.6 r14)
                                    (bat.0.5 r14))))
      (begin
        (set! tmp-ra.44 r15)
        (set! bat.5.9 rdi)
        (set! foo.6.8 rsi)
        (set! foobar.3.7 rdx)
        (set! foobar.7.6 rcx)
        (set! bat.0.5 r8)
        (set! rax 6)
        (jump tmp-ra.44 rbp rax)))
    (define L.x.2.3
      ((locals ()) (conflicts ((tmp-ra.45 (rax bar.9.10 foobar.3.11 bar.4.12 rbp rdx rsi rdi))
                               (bar.4.12 (rbp tmp-ra.45 rdx rsi))
                               (foobar.3.11 (rbp tmp-ra.45 rdx))
                               (bar.9.10 (rbp tmp-ra.45))
                               (rdi (tmp-ra.45))
                               (rsi (bar.4.12 tmp-ra.45))
                               (rdx (foobar.3.11 bar.4.12 tmp-ra.45))
                               (rbp (rax bar.9.10 foobar.3.11 bar.4.12 tmp-ra.45))
                               (rax (rbp tmp-ra.45))))
                   (assignment ((tmp-ra.45 r15) (bar.4.12 r14) (foobar.3.11 r14) (bar.9.10 r14))))
      (begin
        (set! tmp-ra.45 r15)
        (set! bar.4.12 rdi)
        (set! foobar.3.11 rsi)
        (set! bar.9.10 rdx)
        (set! rax 0)
        (jump tmp-ra.45 rbp rax)))
    (begin
      (set! tmp-ra.46 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.6
                      (begin
                        (set! rsi 6)
                        (set! rdi 8)
                        (set! r15 L.rp.6)
                        (jump L.eq?.4 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 8)))
      (set! bat.5.13 rax)
      (set! rsi 8)
      (set! rdi -2229142488)
      (set! r15 tmp-ra.46)
      (jump L.<.5 rbp r15 rdi rsi))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp.47 (rbp tmp-ra.45)) (ball.1.16 (rbp tmp-ra.45))
                                                (tmp-ra.45 (rbp tmp.47 ball.1.16 rax))
                                                (rax (rbp tmp-ra.45))
                                                (rbp (tmp-ra.45 tmp.47 ball.1.16 r15 rdi rax))
                                                (rdi (r15 rbp))
                                                (r15 (rbp rdi))))
           (assignment ((tmp-ra.45 fv0) (tmp.47 r15) (ball.1.16 r15))))
          (define L.empty?.4
            ((locals ())
             (conflicts ((tmp.40 (rbp tmp-ra.41)) (tmp.35 (rbp tmp-ra.41))
                                                  (tmp.46 (rbp tmp-ra.41))
                                                  (tmp-ra.41 (tmp.35 rbp rdi tmp.46 tmp.40 rax))
                                                  (rax (rbp tmp-ra.41))
                                                  (rbp (tmp.35 tmp-ra.41 tmp.46 tmp.40 rax))
                                                  (rdi (tmp-ra.41))))
             (assignment ((tmp-ra.41 r15) (tmp.40 r14) (tmp.35 r14) (tmp.46 r14))))
            (begin
              (set! tmp-ra.41 r15)
              (set! tmp.35 rdi)
              (if (begin
                    (begin
                      (set! tmp.46 tmp.35)
                      (set! tmp.46 (bitwise-and tmp.46 255))
                      (set! tmp.40 tmp.46))
                    (= tmp.40 22))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.41 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.41 rbp rax)))))
    (define L.proc.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.42
          (rax bat.7.1 ball.1.2 bar.8.3 ball.4.4 ball.5.5 foo.9.6 rbp r9 r8 rcx rdx rsi rdi))
         (foo.9.6 (rbp tmp-ra.42 r9 r8 rcx rdx rsi))
         (ball.5.5 (rbp tmp-ra.42 r9 r8 rcx rdx))
         (ball.4.4 (rbp tmp-ra.42 r9 r8 rcx))
         (bar.8.3 (rbp tmp-ra.42 r9 r8))
         (ball.1.2 (rbp tmp-ra.42 r9))
         (bat.7.1 (rbp tmp-ra.42))
         (rdi (tmp-ra.42))
         (rsi (foo.9.6 tmp-ra.42))
         (rdx (ball.5.5 foo.9.6 tmp-ra.42))
         (rcx (ball.4.4 ball.5.5 foo.9.6 tmp-ra.42))
         (r8 (bar.8.3 ball.4.4 ball.5.5 foo.9.6 tmp-ra.42))
         (r9 (ball.1.2 bar.8.3 ball.4.4 ball.5.5 foo.9.6 tmp-ra.42))
         (rbp (rax bat.7.1 ball.1.2 bar.8.3 ball.4.4 ball.5.5 foo.9.6 tmp-ra.42))
         (rax (rbp tmp-ra.42))))
       (assignment ((tmp-ra.42 r15) (foo.9.6 r14)
                                    (ball.5.5 r14)
                                    (ball.4.4 r14)
                                    (bar.8.3 r14)
                                    (ball.1.2 r14)
                                    (bat.7.1 r14))))
      (begin
        (set! tmp-ra.42 r15)
        (set! foo.9.6 rdi)
        (set! ball.5.5 rsi)
        (set! ball.4.4 rdx)
        (set! bar.8.3 rcx)
        (set! ball.1.2 r8)
        (set! bat.7.1 r9)
        (set! rax 6)
        (jump tmp-ra.42 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts ((tmp-ra.43 (rax foo.6.7 bar.0.8 rbp rsi rdi)) (bar.0.8 (rbp tmp-ra.43 rsi))
                                                                 (foo.6.7 (rbp tmp-ra.43))
                                                                 (rdi (tmp-ra.43))
                                                                 (rsi (bar.0.8 tmp-ra.43))
                                                                 (rbp (rax foo.6.7 bar.0.8 tmp-ra.43))
                                                                 (rax (rbp tmp-ra.43))))
       (assignment ((tmp-ra.43 r15) (bar.0.8 r14) (foo.6.7 r14))))
      (begin
        (set! tmp-ra.43 r15)
        (set! bar.0.8 rdi)
        (set! foo.6.7 rsi)
        (set! rax 6)
        (jump tmp-ra.43 rbp rax)))
    (define L.fn.2.3
      ((locals ())
       (conflicts
        ((tmp-ra.44 (rax bar.0.9
                         foo.6.10
                         ball.1.11
                         bat.7.12
                         foo.9.13
                         bar.8.14
                         ball.5.15
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (ball.5.15 (rbp tmp-ra.44 fv0 r9 r8 rcx rdx rsi))
         (bar.8.14 (rbp tmp-ra.44 fv0 r9 r8 rcx rdx))
         (foo.9.13 (rbp tmp-ra.44 fv0 r9 r8 rcx))
         (bat.7.12 (rbp tmp-ra.44 fv0 r9 r8))
         (ball.1.11 (rbp tmp-ra.44 fv0 r9))
         (foo.6.10 (rbp tmp-ra.44 fv0))
         (bar.0.9 (rbp tmp-ra.44))
         (rdi (tmp-ra.44))
         (rsi (ball.5.15 tmp-ra.44))
         (rdx (bar.8.14 ball.5.15 tmp-ra.44))
         (rcx (foo.9.13 bar.8.14 ball.5.15 tmp-ra.44))
         (r8 (bat.7.12 foo.9.13 bar.8.14 ball.5.15 tmp-ra.44))
         (r9 (ball.1.11 bat.7.12 foo.9.13 bar.8.14 ball.5.15 tmp-ra.44))
         (fv0 (foo.6.10 ball.1.11 bat.7.12 foo.9.13 bar.8.14 ball.5.15 tmp-ra.44))
         (rbp (rax bar.0.9 foo.6.10 ball.1.11 bat.7.12 foo.9.13 bar.8.14 ball.5.15 tmp-ra.44))
         (rax (rbp tmp-ra.44))))
       (assignment ((tmp-ra.44 r15) (ball.5.15 r14)
                                    (bar.8.14 r14)
                                    (foo.9.13 r14)
                                    (bat.7.12 r14)
                                    (ball.1.11 r14)
                                    (foo.6.10 r14)
                                    (bar.0.9 r14))))
      (begin
        (set! tmp-ra.44 r15)
        (set! ball.5.15 rdi)
        (set! bar.8.14 rsi)
        (set! foo.9.13 rdx)
        (set! bat.7.12 rcx)
        (set! ball.1.11 r8)
        (set! foo.6.10 r9)
        (set! bar.0.9 fv0)
        (set! rax 14)
        (jump tmp-ra.44 rbp rax)))
    (begin
      (set! tmp-ra.45 r15)
      (if (begin
            (set! tmp.47 30)
            (!= tmp.47 6))
          (begin
            (begin
              (set! rbp (- rbp 8))
              (return-point L.rp.5
                            (begin
                              (set! rdi 6)
                              (set! r15 L.rp.5)
                              (jump L.empty?.4 rbp r15 rdi)))
              (set! rbp (+ rbp 8)))
            (set! ball.1.16 rax)
            (set! rax ball.1.16)
            (jump tmp-ra.45 rbp rax))
          (begin
            (set! rax 8)
            (jump tmp-ra.45 rbp rax))))))
(check-by-interp
 '(module ((locals ()) (conflicts ((tmp-ra.49 (rdi rbp)) (rbp (r15 rdi tmp-ra.49))
                                                         (rdi (r15 rbp tmp-ra.49))
                                                         (r15 (rbp rdi))))
                       (assignment ((tmp-ra.49 r15))))
          (define L.fixnum?.4
            ((locals ())
             (conflicts ((tmp.44 (rbp tmp-ra.45)) (tmp.37 (rbp tmp-ra.45))
                                                  (tmp.50 (rbp tmp-ra.45))
                                                  (tmp-ra.45 (tmp.37 rbp rdi tmp.50 tmp.44 rax))
                                                  (rax (rbp tmp-ra.45))
                                                  (rbp (tmp.37 tmp-ra.45 tmp.50 tmp.44 rax))
                                                  (rdi (tmp-ra.45))))
             (assignment ((tmp-ra.45 r15) (tmp.44 r14) (tmp.37 r14) (tmp.50 r14))))
            (begin
              (set! tmp-ra.45 r15)
              (set! tmp.37 rdi)
              (if (begin
                    (begin
                      (set! tmp.50 tmp.37)
                      (set! tmp.50 (bitwise-and tmp.50 7))
                      (set! tmp.44 tmp.50))
                    (= tmp.44 0))
                  (begin
                    (set! rax 14)
                    (jump tmp-ra.45 rbp rax))
                  (begin
                    (set! rax 6)
                    (jump tmp-ra.45 rbp rax)))))
    (define L.x.0.1
      ((locals ())
       (conflicts
        ((tmp-ra.46 (rax bat.2.1
                         bat.9.2
                         foo.8.3
                         foobar.5.4
                         bat.4.5
                         foobar.1.6
                         bar.0.7
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bar.0.7
          (bat.2.1 bat.9.2 foo.8.3 foobar.5.4 bat.4.5 foobar.1.6 rbp tmp-ra.46 fv0 r9 r8 rcx rdx rsi))
         (foobar.1.6 (rbp tmp-ra.46 bar.0.7 fv0 r9 r8 rcx rdx))
         (bat.4.5 (rbp tmp-ra.46 bar.0.7 fv0 r9 r8 rcx))
         (foobar.5.4 (rbp tmp-ra.46 bar.0.7 fv0 r9 r8))
         (foo.8.3 (rbp tmp-ra.46 bar.0.7 fv0 r9))
         (bat.9.2 (rbp tmp-ra.46 bar.0.7 fv0))
         (bat.2.1 (rbp tmp-ra.46 bar.0.7))
         (rdi (tmp-ra.46))
         (rsi (bar.0.7 tmp-ra.46))
         (rdx (foobar.1.6 bar.0.7 tmp-ra.46))
         (rcx (bat.4.5 foobar.1.6 bar.0.7 tmp-ra.46))
         (r8 (foobar.5.4 bat.4.5 foobar.1.6 bar.0.7 tmp-ra.46))
         (r9 (foo.8.3 foobar.5.4 bat.4.5 foobar.1.6 bar.0.7 tmp-ra.46))
         (fv0 (bat.9.2 foo.8.3 foobar.5.4 bat.4.5 foobar.1.6 bar.0.7 tmp-ra.46))
         (rbp (rax bat.2.1 bat.9.2 foo.8.3 foobar.5.4 bat.4.5 foobar.1.6 bar.0.7 tmp-ra.46))
         (rax (rbp tmp-ra.46))))
       (assignment ((tmp-ra.46 r15) (bar.0.7 r14)
                                    (foobar.1.6 r13)
                                    (bat.4.5 r13)
                                    (foobar.5.4 r13)
                                    (foo.8.3 r13)
                                    (bat.9.2 r13)
                                    (bat.2.1 r13))))
      (begin
        (set! tmp-ra.46 r15)
        (set! bar.0.7 rdi)
        (set! foobar.1.6 rsi)
        (set! bat.4.5 rdx)
        (set! foobar.5.4 rcx)
        (set! foo.8.3 r8)
        (set! bat.9.2 r9)
        (set! bat.2.1 fv0)
        (set! rax bar.0.7)
        (jump tmp-ra.46 rbp rax)))
    (define L.tmp.1.2
      ((locals ())
       (conflicts ((tmp-ra.47 (rax bat.4.8
                                   bar.6.9
                                   foobar.5.10
                                   bat.9.11
                                   foobar.1.12
                                   foobar.3.13
                                   rbp
                                   r9
                                   r8
                                   rcx
                                   rdx
                                   rsi
                                   rdi))
                   (foobar.3.13 (rbp tmp-ra.47 r9 r8 rcx rdx rsi))
                   (foobar.1.12 (rbp tmp-ra.47 r9 r8 rcx rdx))
                   (bat.9.11 (rbp tmp-ra.47 r9 r8 rcx))
                   (foobar.5.10 (rbp tmp-ra.47 r9 r8))
                   (bar.6.9 (rbp tmp-ra.47 r9))
                   (bat.4.8 (rbp tmp-ra.47))
                   (rdi (tmp-ra.47))
                   (rsi (foobar.3.13 tmp-ra.47))
                   (rdx (foobar.1.12 foobar.3.13 tmp-ra.47))
                   (rcx (bat.9.11 foobar.1.12 foobar.3.13 tmp-ra.47))
                   (r8 (foobar.5.10 bat.9.11 foobar.1.12 foobar.3.13 tmp-ra.47))
                   (r9 (bar.6.9 foobar.5.10 bat.9.11 foobar.1.12 foobar.3.13 tmp-ra.47))
                   (rbp (rax bat.4.8 bar.6.9 foobar.5.10 bat.9.11 foobar.1.12 foobar.3.13 tmp-ra.47))
                   (rax (rbp tmp-ra.47))))
       (assignment ((tmp-ra.47 r15) (foobar.3.13 r14)
                                    (foobar.1.12 r14)
                                    (bat.9.11 r14)
                                    (foobar.5.10 r14)
                                    (bar.6.9 r14)
                                    (bat.4.8 r14))))
      (begin
        (set! tmp-ra.47 r15)
        (set! foobar.3.13 rdi)
        (set! foobar.1.12 rsi)
        (set! bat.9.11 rdx)
        (set! foobar.5.10 rcx)
        (set! bar.6.9 r8)
        (set! bat.4.8 r9)
        (set! rax 0)
        (jump tmp-ra.47 rbp rax)))
    (define L.tmp.2.3
      ((locals ())
       (conflicts
        ((tmp-ra.48 (rax foo.8.14
                         ball.7.15
                         bar.6.16
                         foobar.5.17
                         bar.0.18
                         foobar.3.19
                         bat.2.20
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (bat.2.20 (rbp tmp-ra.48 fv0 r9 r8 rcx rdx rsi))
         (foobar.3.19 (rbp tmp-ra.48 fv0 r9 r8 rcx rdx))
         (bar.0.18 (rbp tmp-ra.48 fv0 r9 r8 rcx))
         (foobar.5.17 (rbp tmp-ra.48 fv0 r9 r8))
         (bar.6.16 (rbp tmp-ra.48 fv0 r9))
         (ball.7.15 (rbp tmp-ra.48 fv0))
         (foo.8.14 (rbp tmp-ra.48))
         (rdi (tmp-ra.48))
         (rsi (bat.2.20 tmp-ra.48))
         (rdx (foobar.3.19 bat.2.20 tmp-ra.48))
         (rcx (bar.0.18 foobar.3.19 bat.2.20 tmp-ra.48))
         (r8 (foobar.5.17 bar.0.18 foobar.3.19 bat.2.20 tmp-ra.48))
         (r9 (bar.6.16 foobar.5.17 bar.0.18 foobar.3.19 bat.2.20 tmp-ra.48))
         (fv0 (ball.7.15 bar.6.16 foobar.5.17 bar.0.18 foobar.3.19 bat.2.20 tmp-ra.48))
         (rbp (rax foo.8.14 ball.7.15 bar.6.16 foobar.5.17 bar.0.18 foobar.3.19 bat.2.20 tmp-ra.48))
         (rax (rbp tmp-ra.48))))
       (assignment ((tmp-ra.48 r15) (bat.2.20 r14)
                                    (foobar.3.19 r14)
                                    (bar.0.18 r14)
                                    (foobar.5.17 r14)
                                    (bar.6.16 r14)
                                    (ball.7.15 r14)
                                    (foo.8.14 r14))))
      (begin
        (set! tmp-ra.48 r15)
        (set! bat.2.20 rdi)
        (set! foobar.3.19 rsi)
        (set! bar.0.18 rdx)
        (set! foobar.5.17 rcx)
        (set! bar.6.16 r8)
        (set! ball.7.15 r9)
        (set! foo.8.14 fv0)
        (set! rax 6)
        (jump tmp-ra.48 rbp rax)))
    (begin
      (set! tmp-ra.49 r15)
      (set! rdi 6)
      (set! r15 tmp-ra.49)
      (jump L.fixnum?.4 rbp r15 rdi))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp-ra.45 (rax foo.0.16 ball.6.17 foobar.8.18 rbp))
                       (foobar.8.18 (rbp tmp-ra.45))
                       (ball.6.17 (rbp tmp-ra.45))
                       (foo.0.16 (rbp tmp-ra.45))
                       (rbp (rax foo.0.16 ball.6.17 foobar.8.18 tmp-ra.45))
                       (rax (rbp tmp-ra.45))))
           (assignment ((tmp-ra.45 r15) (foobar.8.18 r14) (ball.6.17 r14) (foo.0.16 r14))))
          (define L.tmp.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.42
                (rax foobar.5.1 ball.6.2 ball.1.3 ball.9.4 foo.0.5 foo.3.6 rbp r9 r8 rcx rdx rsi rdi))
               (foo.3.6
                (foobar.5.1 ball.6.2 ball.1.3 ball.9.4 foo.0.5 rbp tmp-ra.42 r9 r8 rcx rdx rsi))
               (foo.0.5 (rbp tmp-ra.42 foo.3.6 r9 r8 rcx rdx))
               (ball.9.4 (rbp tmp-ra.42 foo.3.6 r9 r8 rcx))
               (ball.1.3 (rbp tmp-ra.42 foo.3.6 r9 r8))
               (ball.6.2 (rbp tmp-ra.42 foo.3.6 r9))
               (foobar.5.1 (rbp tmp-ra.42 foo.3.6))
               (rdi (tmp-ra.42))
               (rsi (foo.3.6 tmp-ra.42))
               (rdx (foo.0.5 foo.3.6 tmp-ra.42))
               (rcx (ball.9.4 foo.0.5 foo.3.6 tmp-ra.42))
               (r8 (ball.1.3 ball.9.4 foo.0.5 foo.3.6 tmp-ra.42))
               (r9 (ball.6.2 ball.1.3 ball.9.4 foo.0.5 foo.3.6 tmp-ra.42))
               (rbp (rax foobar.5.1 ball.6.2 ball.1.3 ball.9.4 foo.0.5 foo.3.6 tmp-ra.42))
               (rax (rbp tmp-ra.42))))
             (assignment ((tmp-ra.42 r15) (foo.3.6 r14)
                                          (foo.0.5 r13)
                                          (ball.9.4 r13)
                                          (ball.1.3 r13)
                                          (ball.6.2 r13)
                                          (foobar.5.1 r13))))
            (begin
              (set! tmp-ra.42 r15)
              (set! foo.3.6 rdi)
              (set! foo.0.5 rsi)
              (set! ball.9.4 rdx)
              (set! ball.1.3 rcx)
              (set! ball.6.2 r8)
              (set! foobar.5.1 r9)
              (set! rax foo.3.6)
              (jump tmp-ra.42 rbp rax)))
    (define L.x.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.43 (rax ball.6.7 ball.1.8 foo.3.9 ball.7.10 foobar.5.11 rbp r8 rcx rdx rsi rdi))
         (foobar.5.11 (rbp tmp-ra.43 r8 rcx rdx rsi))
         (ball.7.10 (rbp tmp-ra.43 r8 rcx rdx))
         (foo.3.9 (rbp tmp-ra.43 r8 rcx))
         (ball.1.8 (rbp tmp-ra.43 r8))
         (ball.6.7 (rbp tmp-ra.43))
         (rdi (tmp-ra.43))
         (rsi (foobar.5.11 tmp-ra.43))
         (rdx (ball.7.10 foobar.5.11 tmp-ra.43))
         (rcx (foo.3.9 ball.7.10 foobar.5.11 tmp-ra.43))
         (r8 (ball.1.8 foo.3.9 ball.7.10 foobar.5.11 tmp-ra.43))
         (rbp (rax ball.6.7 ball.1.8 foo.3.9 ball.7.10 foobar.5.11 tmp-ra.43))
         (rax (rbp tmp-ra.43))))
       (assignment ((tmp-ra.43 r15) (foobar.5.11 r14)
                                    (ball.7.10 r14)
                                    (foo.3.9 r14)
                                    (ball.1.8 r14)
                                    (ball.6.7 r14))))
      (begin
        (set! tmp-ra.43 r15)
        (set! foobar.5.11 rdi)
        (set! ball.7.10 rsi)
        (set! foo.3.9 rdx)
        (set! ball.1.8 rcx)
        (set! ball.6.7 r8)
        (set! rax 2370093256)
        (jump tmp-ra.43 rbp rax)))
    (define L.tmp.2.3
      ((locals ())
       (conflicts ((tmp-ra.44 (rax foobar.5.12 foo.2.13 ball.7.14 ball.6.15 rbp rcx rdx rsi rdi))
                   (ball.6.15 (foobar.5.12 foo.2.13 ball.7.14 rbp tmp-ra.44 rcx rdx rsi))
                   (ball.7.14 (rbp tmp-ra.44 ball.6.15 rcx rdx))
                   (foo.2.13 (rbp tmp-ra.44 ball.6.15 rcx))
                   (foobar.5.12 (rbp tmp-ra.44 ball.6.15))
                   (rdi (tmp-ra.44))
                   (rsi (ball.6.15 tmp-ra.44))
                   (rdx (ball.7.14 ball.6.15 tmp-ra.44))
                   (rcx (foo.2.13 ball.7.14 ball.6.15 tmp-ra.44))
                   (rbp (rax foobar.5.12 foo.2.13 ball.7.14 ball.6.15 tmp-ra.44))
                   (rax (rbp tmp-ra.44))))
       (assignment
        ((tmp-ra.44 r15) (ball.6.15 r14) (ball.7.14 r13) (foo.2.13 r13) (foobar.5.12 r13))))
      (begin
        (set! tmp-ra.44 r15)
        (set! ball.6.15 rdi)
        (set! ball.7.14 rsi)
        (set! foo.2.13 rdx)
        (set! foobar.5.12 rcx)
        (set! rax ball.6.15)
        (jump tmp-ra.44 rbp rax)))
    (begin
      (set! tmp-ra.45 r15)
      (set! foobar.8.18 22)
      (set! ball.6.17 22)
      (set! foo.0.16 19502)
      (set! rax 29230)
      (jump tmp-ra.45 rbp rax))))
(check-by-interp
 '(module ((locals ())
           (conflicts ((tmp-ra.51 (rax ball.6.21 foo.2.22 foobar.5.23 ball.3.24 rbp))
                       (ball.3.24 (rbp tmp-ra.51))
                       (foobar.5.23 (rbp tmp-ra.51))
                       (foo.2.22 (rbp tmp-ra.51))
                       (ball.6.21 (rbp tmp-ra.51))
                       (rbp (rax ball.6.21 foo.2.22 foobar.5.23 ball.3.24 tmp-ra.51))
                       (rax (rbp tmp-ra.51))))
           (assignment
            ((tmp-ra.51 r15) (ball.3.24 r14) (foobar.5.23 r14) (foo.2.22 r14) (ball.6.21 r14))))
          (define L.fn.0.1
            ((locals ())
             (conflicts
              ((tmp-ra.48 (rax foobar.5.1
                               bar.1.2
                               bat.4.3
                               ball.7.4
                               bat.8.5
                               bar.9.6
                               ball.6.7
                               rbp
                               fv0
                               r9
                               r8
                               rcx
                               rdx
                               rsi
                               rdi))
               (ball.6.7 (rbp tmp-ra.48 fv0 r9 r8 rcx rdx rsi))
               (bar.9.6 (rbp tmp-ra.48 fv0 r9 r8 rcx rdx))
               (bat.8.5 (rbp tmp-ra.48 fv0 r9 r8 rcx))
               (ball.7.4 (rbp tmp-ra.48 fv0 r9 r8))
               (bat.4.3 (rbp tmp-ra.48 fv0 r9))
               (bar.1.2 (rbp tmp-ra.48 fv0))
               (foobar.5.1 (rbp tmp-ra.48))
               (rdi (tmp-ra.48))
               (rsi (ball.6.7 tmp-ra.48))
               (rdx (bar.9.6 ball.6.7 tmp-ra.48))
               (rcx (bat.8.5 bar.9.6 ball.6.7 tmp-ra.48))
               (r8 (ball.7.4 bat.8.5 bar.9.6 ball.6.7 tmp-ra.48))
               (r9 (bat.4.3 ball.7.4 bat.8.5 bar.9.6 ball.6.7 tmp-ra.48))
               (fv0 (bar.1.2 bat.4.3 ball.7.4 bat.8.5 bar.9.6 ball.6.7 tmp-ra.48))
               (rbp (rax foobar.5.1 bar.1.2 bat.4.3 ball.7.4 bat.8.5 bar.9.6 ball.6.7 tmp-ra.48))
               (rax (rbp tmp-ra.48))))
             (assignment ((tmp-ra.48 r15) (ball.6.7 r14)
                                          (bar.9.6 r14)
                                          (bat.8.5 r14)
                                          (ball.7.4 r14)
                                          (bat.4.3 r14)
                                          (bar.1.2 r14)
                                          (foobar.5.1 r14))))
            (begin
              (set! tmp-ra.48 r15)
              (set! ball.6.7 rdi)
              (set! bar.9.6 rsi)
              (set! bat.8.5 rdx)
              (set! ball.7.4 rcx)
              (set! bat.4.3 r8)
              (set! bar.1.2 r9)
              (set! foobar.5.1 fv0)
              (set! rax 8)
              (jump tmp-ra.48 rbp rax)))
    (define L.proc.1.2
      ((locals ())
       (conflicts
        ((tmp-ra.49 (rax ball.6.8
                         ball.3.9
                         bat.4.10
                         bat.8.11
                         ball.7.12
                         bar.1.13
                         foobar.5.14
                         rbp
                         fv0
                         r9
                         r8
                         rcx
                         rdx
                         rsi
                         rdi))
         (foobar.5.14 (rbp tmp-ra.49 fv0 r9 r8 rcx rdx rsi))
         (bar.1.13 (rbp tmp-ra.49 fv0 r9 r8 rcx rdx))
         (ball.7.12 (ball.6.8 ball.3.9 bat.4.10 bat.8.11 rbp tmp-ra.49 fv0 r9 r8 rcx))
         (bat.8.11 (rbp tmp-ra.49 ball.7.12 fv0 r9 r8))
         (bat.4.10 (rbp tmp-ra.49 ball.7.12 fv0 r9))
         (ball.3.9 (rbp tmp-ra.49 ball.7.12 fv0))
         (ball.6.8 (rbp tmp-ra.49 ball.7.12))
         (rdi (tmp-ra.49))
         (rsi (foobar.5.14 tmp-ra.49))
         (rdx (bar.1.13 foobar.5.14 tmp-ra.49))
         (rcx (ball.7.12 bar.1.13 foobar.5.14 tmp-ra.49))
         (r8 (bat.8.11 ball.7.12 bar.1.13 foobar.5.14 tmp-ra.49))
         (r9 (bat.4.10 bat.8.11 ball.7.12 bar.1.13 foobar.5.14 tmp-ra.49))
         (fv0 (ball.3.9 bat.4.10 bat.8.11 ball.7.12 bar.1.13 foobar.5.14 tmp-ra.49))
         (rbp (rax ball.6.8 ball.3.9 bat.4.10 bat.8.11 ball.7.12 bar.1.13 foobar.5.14 tmp-ra.49))
         (rax (rbp tmp-ra.49))))
       (assignment ((tmp-ra.49 r15) (ball.7.12 r14)
                                    (foobar.5.14 r14)
                                    (bar.1.13 r14)
                                    (bat.8.11 r13)
                                    (bat.4.10 r13)
                                    (ball.3.9 r13)
                                    (ball.6.8 r13))))
      (begin
        (set! tmp-ra.49 r15)
        (set! foobar.5.14 rdi)
        (set! bar.1.13 rsi)
        (set! ball.7.12 rdx)
        (set! bat.8.11 rcx)
        (set! bat.4.10 r8)
        (set! ball.3.9 r9)
        (set! ball.6.8 fv0)
        (set! rax ball.7.12)
        (jump tmp-ra.49 rbp rax)))
    (define L.x.2.3
      ((locals ())
       (conflicts
        ((tmp-ra.50
          (rax bat.8.15 ball.7.16 foobar.5.17 ball.3.18 bar.9.19 ball.6.20 rbp r9 r8 rcx rdx rsi rdi))
         (ball.6.20 (rbp tmp-ra.50 r9 r8 rcx rdx rsi))
         (bar.9.19 (rbp tmp-ra.50 r9 r8 rcx rdx))
         (ball.3.18 (rbp tmp-ra.50 r9 r8 rcx))
         (foobar.5.17 (rbp tmp-ra.50 r9 r8))
         (ball.7.16 (rbp tmp-ra.50 r9))
         (bat.8.15 (rbp tmp-ra.50))
         (rdi (tmp-ra.50))
         (rsi (ball.6.20 tmp-ra.50))
         (rdx (bar.9.19 ball.6.20 tmp-ra.50))
         (rcx (ball.3.18 bar.9.19 ball.6.20 tmp-ra.50))
         (r8 (foobar.5.17 ball.3.18 bar.9.19 ball.6.20 tmp-ra.50))
         (r9 (ball.7.16 foobar.5.17 ball.3.18 bar.9.19 ball.6.20 tmp-ra.50))
         (rbp (rax bat.8.15 ball.7.16 foobar.5.17 ball.3.18 bar.9.19 ball.6.20 tmp-ra.50))
         (rax (rbp tmp-ra.50))))
       (assignment ((tmp-ra.50 r15) (ball.6.20 r14)
                                    (bar.9.19 r14)
                                    (ball.3.18 r14)
                                    (foobar.5.17 r14)
                                    (ball.7.16 r14)
                                    (bat.8.15 r14))))
      (begin
        (set! tmp-ra.50 r15)
        (set! ball.6.20 rdi)
        (set! bar.9.19 rsi)
        (set! ball.3.18 rdx)
        (set! foobar.5.17 rcx)
        (set! ball.7.16 r8)
        (set! bat.8.15 r9)
        (set! rax 6)
        (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! ball.3.24 30)
      (set! foobar.5.23 21550)
      (set! foo.2.22 22)
      (set! ball.6.21 22)
      (set! rax ball.6.21)
      (jump tmp-ra.51 rbp rax))))
;;; Added by Trevor on 2026-03-19
