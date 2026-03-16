; temporary script file to filter out tests cases that never terminates

#lang racket

(require cpsc411/langs/v5
  cpsc411/langs/v6)

(define (runs-within-time? p interp-lang)
  (define ch (make-channel))

  (define thr
    (thread (lambda ()
              (channel-put ch
                           (with-handlers ([exn:fail? (lambda (e) 'error)])
                             (interp-lang p))))))

  (define result (sync/timeout 3 ch))
  (cond
    [(not result) ; timeout
     (kill-thread thr)
     #f]
    [(eq? result 'error) #f]
    [else #t]))

(define (dummy-interp p)
    (error "you forgot to set an actual interpretor!"))

(define (peek x)
  ; (pretty-display x)
  x)

; step1: replace dummy-interp with the right interpretor
(define (check-by-interp-v6 p)
    (when (runs-within-time? p interp-asm-pred-lang-v6/spilled)
       (displayln (string-append "(check-by-interp " (pretty-format p) ")"))))

; step1: replace dummy-interp with the right interpretor
(define (check-by-interp p )
    (when (runs-within-time? p interp-asm-pred-lang-v6/spilled)
        (displayln (string-append "(check-by-interp " (pretty-format p) ")"))))

; step2: add test cases here and run
   (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.4 (rax ball.2.3 foobar.3.1 bat.9.2 rbp))
                                     (bat.9.2 (rbp tmp-ra.4))
                                     (foobar.3.1 (rbp tmp-ra.4))
                                     (ball.2.3 (rbp tmp-ra.4))
                                     (rbp (rax ball.2.3 foobar.3.1 bat.9.2 tmp-ra.4))
                                     (rax (rbp tmp-ra.4))))
                         (assignment ((tmp-ra.4 r15) (bat.9.2 r14) (foobar.3.1 r14) (ball.2.3 r14))))
            (begin
              (set! tmp-ra.4 r15)
              (set! bat.9.2 -422317085)
              (set! foobar.3.1 bat.9.2)
              (set! ball.2.3 foobar.3.1)
              (set! rax foobar.3.1)
              (jump tmp-ra.4 rbp rax))
      ))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((foobar.9.10 (rbp tmp-ra.14))
                         (ball.6.11 (rbp tmp-ra.14))
                         (tmp-ra.14 (tmp.16 foobar.9.10 rbp rax ball.6.11 rdi rsi))
                         (tmp.16 (rbp tmp-ra.14))
                         (rsi (r15 rdi rbp tmp-ra.14))
                         (rbp (tmp.16 foobar.9.10 tmp-ra.14 rax ball.6.11 r15 rdi rsi))
                         (rdi (r15 rbp rsi tmp-ra.14))
                         (r15 (rbp rdi rsi))
                         (rax (rbp tmp-ra.14))))
             (assignment ((tmp-ra.14 r15) (foobar.9.10 r14) (ball.6.11 r14) (tmp.16 r14))))
            (define L.func.0.1
              ((locals ())
               (conflicts
                ((tmp-ra.12 (rax foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 rbp r8 rcx rdx rsi rdi))
                 (ball.3.5 (rbp tmp-ra.12 r8 rcx rdx rsi))
                 (ball.4.4 (rbp tmp-ra.12 r8 rcx rdx))
                 (bat.0.3 (rbp tmp-ra.12 r8 rcx))
                 (bat.5.2 (rbp tmp-ra.12 r8))
                 (foobar.2.1 (rbp tmp-ra.12))
                 (rdi (tmp-ra.12))
                 (rsi (ball.3.5 tmp-ra.12))
                 (rdx (ball.4.4 ball.3.5 tmp-ra.12))
                 (rcx (bat.0.3 ball.4.4 ball.3.5 tmp-ra.12))
                 (r8 (bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12))
                 (rbp (rax foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12))
                 (rax (rbp tmp-ra.12))))
               (assignment ((tmp-ra.12 r15) (ball.3.5 r14)
                                            (ball.4.4 r14)
                                            (bat.0.3 r14)
                                            (bat.5.2 r14)
                                            (foobar.2.1 r14))))
              (begin
                (set! tmp-ra.12 r15)
                (set! ball.3.5 rdi)
                (set! ball.4.4 rsi)
                (set! bat.0.3 rdx)
                (set! bat.5.2 rcx)
                (set! foobar.2.1 r8)
                (set! rax 9223372036854775807)
                (jump tmp-ra.12 rbp rax)))
      (define L.proc.1.2
        ((locals ())
         (conflicts ((tmp.15 (rbp tmp-ra.13 bar.7.8 bat.0.7))
                     (bat.0.7 (ball.8.9 rax bar.7.6 rbp tmp-ra.13 rsi tmp.15))
                     (tmp-ra.13 (ball.8.9 bar.7.8 bar.7.6 bat.0.7 rbp rsi rdi tmp.15 rax))
                     (bar.7.8 (ball.8.9 rax rbp tmp-ra.13 tmp.15))
                     (bar.7.6 (rbp tmp-ra.13 bat.0.7))
                     (ball.8.9 (rbp tmp-ra.13 bar.7.8 bat.0.7))
                     (rax (bar.7.8 bat.0.7 rbp tmp-ra.13))
                     (rbp (ball.8.9 r15 rdi rsi bar.7.8 bar.7.6 bat.0.7 tmp-ra.13 tmp.15 rax))
                     (rdi (r15 rbp rsi tmp-ra.13))
                     (rsi (r15 rdi rbp bat.0.7 tmp-ra.13))
                     (r15 (rbp rdi rsi))))
         (assignment
          ((tmp-ra.13 fv0) (bar.7.8 fv1) (bat.0.7 fv1) (tmp.15 r15) (ball.8.9 r15) (bar.7.6 r15))))
        (begin
          (set! tmp-ra.13 r15)
          (set! bat.0.7 rdi)
          (set! bar.7.6 rsi)
          (set! bar.7.8 bat.0.7)
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.3
                          (begin
                            (set! rsi bar.7.8)
                            (set! rdi bar.7.8)
                            (set! r15 L.rp.3)
                            (jump L.proc.1.2 rbp r15 rdi rsi)))
            (set! rbp (+ rbp 24)))
          (set! ball.8.9 rax)
          (if (begin
                (set! tmp.15 -59730991)
                (= tmp.15 bat.0.7))
              (begin
                (set! rax 0)
                (jump tmp-ra.13 rbp rax))
              (begin
                (set! rax bar.7.8)
                (jump tmp-ra.13 rbp rax)))))
      (begin
        (set! tmp-ra.14 r15)
        (if (false)
            (set! foobar.9.10 9223372036854775807)
            (begin
              (set! tmp.16 1)
              (set! tmp.16 (* tmp.16 -9223372036854775808))
              (set! foobar.9.10 tmp.16)))
        (if (not (> foobar.9.10 foobar.9.10))
            (begin
              (set! ball.6.11 foobar.9.10)
              (set! rax -1510146984)
              (jump tmp-ra.14 rbp rax))
            (begin
              (set! rsi foobar.9.10)
              (set! rdi -9223372036854775808)
              (set! r15 tmp-ra.14)
              (jump L.proc.1.2 rbp r15 rdi rsi))))))
  (check-by-interp
   '(module ((locals ())
             (conflicts
              ((tmp-ra.6 (rax tmp.9 bat.8.2 bat.9.4 tmp.7 bat.9.3 bat.3.5 tmp.8 bat.9.1 rbp))
               (bat.3.5 (rbp tmp-ra.6))
               (tmp.8 (rbp tmp-ra.6))
               (tmp.7 (rbp tmp-ra.6))
               (bat.9.3 (rbp tmp-ra.6))
               (bat.9.4 (rbp tmp-ra.6))
               (bat.9.1 (rbp tmp-ra.6))
               (bat.8.2 (rbp tmp-ra.6))
               (tmp.9 (rbp tmp-ra.6))
               (rbp (rax tmp.9 bat.8.2 bat.9.4 tmp.7 bat.9.3 bat.3.5 tmp.8 bat.9.1 tmp-ra.6))
               (rax (rbp tmp-ra.6))))
             (assignment ((tmp-ra.6 r15) (bat.3.5 r14)
                                         (tmp.8 r14)
                                         (tmp.7 r14)
                                         (bat.9.3 r14)
                                         (bat.9.4 r14)
                                         (bat.9.1 r14)
                                         (bat.8.2 r14)
                                         (tmp.9 r14))))
            (begin
              (set! tmp-ra.6 r15)
              (if (begin
                    (set! bat.8.2 -1418594624)
                    (false))
                  (begin
                    (if (begin
                          (set! tmp.7 -1123833745)
                          (> tmp.7 1))
                        (set! bat.9.3 1)
                        (set! bat.9.3 0))
                    (set! bat.9.4 767736686)
                    (set! bat.9.1 bat.9.4))
                  (if (true)
                      (begin
                        (set! bat.3.5 1942655457)
                        (set! bat.9.1 bat.3.5))
                      (begin
                        (set! tmp.8 -9223372036854775808)
                        (set! tmp.8 (+ tmp.8 1))
                        (set! bat.9.1 tmp.8))))
              (set! tmp.9 bat.9.1)
              (set! tmp.9 (- tmp.9 bat.9.1))
              (set! rax tmp.9)
              (jump tmp-ra.6 rbp rax))
      ))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((tmp-ra.9 (rax tmp.12 foobar.5.7 rbp)) (foobar.5.7 (rbp tmp-ra.9))
                                                                (tmp.12 (rbp tmp-ra.9))
                                                                (rbp (rax tmp.12 foobar.5.7 tmp-ra.9))
                                                                (rax (rbp tmp-ra.9))))
             (assignment ((tmp-ra.9 r15) (foobar.5.7 r14) (tmp.12 r14))))
            (define L.func.0.1
              ((locals ())
               (conflicts
                ((tmp.10 (rbp tmp-ra.8 bat.0.1 foo.7.2))
                 (tmp-ra.8 (foo.3.6 bat.0.1
                                    foo.7.2
                                    bat.2.3
                                    foobar.9.4
                                    foobar.8.5
                                    rbp
                                    tmp.10
                                    tmp.11
                                    rax
                                    rdi
                                    rsi
                                    rdx
                                    rcx
                                    r8))
                 (bat.0.1 (foo.3.6 rax rbp tmp-ra.8 foo.7.2 foobar.9.4 tmp.10 tmp.11 rdx rcx r8))
                 (tmp.11 (rbp tmp-ra.8 bat.0.1))
                 (foo.7.2 (foo.3.6 rax bat.0.1 rbp tmp-ra.8 foobar.9.4 r8 tmp.10))
                 (foobar.8.5 (rbp tmp-ra.8 r8 rcx rdx rsi))
                 (foobar.9.4 (bat.0.1 foo.7.2 bat.2.3 rbp tmp-ra.8 r8 rcx rdx))
                 (bat.2.3 (rbp tmp-ra.8 foobar.9.4 r8 rcx))
                 (foo.3.6 (rbp tmp-ra.8 bat.0.1 foo.7.2))
                 (r8 (foo.7.2 bat.2.3 foobar.9.4 foobar.8.5 r15 rdi rsi rdx rcx rbp tmp-ra.8 bat.0.1))
                 (rbp (foo.3.6 bat.0.1
                               foo.7.2
                               bat.2.3
                               foobar.9.4
                               foobar.8.5
                               tmp-ra.8
                               tmp.10
                               tmp.11
                               rax
                               r15
                               rdi
                               rsi
                               rdx
                               rcx
                               r8))
                 (rcx (bat.2.3 foobar.9.4 foobar.8.5 r15 rdi rsi rdx rbp r8 tmp-ra.8 bat.0.1))
                 (rdx (foobar.9.4 foobar.8.5 r15 rdi rsi rbp rcx r8 tmp-ra.8 bat.0.1))
                 (rsi (foobar.8.5 r15 rdi rbp rdx rcx r8 tmp-ra.8))
                 (rdi (r15 rbp rsi rdx rcx r8 tmp-ra.8))
                 (r15 (rbp rdi rsi rdx rcx r8))
                 (rax (bat.0.1 foo.7.2 rbp tmp-ra.8))))
               (assignment ((tmp-ra.8 fv0) (bat.0.1 fv1)
                                           (foo.7.2 fv2)
                                           (foobar.9.4 r15)
                                           (foobar.8.5 r15)
                                           (bat.2.3 r14)
                                           (tmp.10 r15)
                                           (foo.3.6 r15)
                                           (tmp.11 r15))))
              (begin
                (set! tmp-ra.8 r15)
                (set! foobar.8.5 rdi)
                (set! foobar.9.4 rsi)
                (set! bat.2.3 rdx)
                (set! foo.7.2 rcx)
                (set! bat.0.1 r8)
                (begin
                  (set! rbp (- rbp 24))
                  (return-point L.rp.2
                                (begin
                                  (set! r8 bat.0.1)
                                  (set! rcx foo.7.2)
                                  (set! rdx foobar.9.4)
                                  (set! rsi -9223372036854775808)
                                  (set! rdi -1343541856)
                                  (set! r15 L.rp.2)
                                  (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))
                  (set! rbp (+ rbp 24)))
                (set! foo.3.6 rax)
                (if (begin
                      (set! tmp.10 0)
                      (!= tmp.10 9223372036854775807))
                    (if (begin
                          (set! tmp.11 1346978436)
                          (= tmp.11 bat.0.1))
                        (begin
                          (set! rax 0)
                          (jump tmp-ra.8 rbp rax))
                        (begin
                          (set! rax bat.0.1)
                          (jump tmp-ra.8 rbp rax)))
                    (begin
                      (set! r8 foo.7.2)
                      (set! rcx 9223372036854775807)
                      (set! rdx 1)
                      (set! rsi bat.0.1)
                      (set! rdi -1402588641)
                      (set! r15 tmp-ra.8)
                      (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))))
      (begin
        (set! tmp-ra.9 r15)
        (if (begin
              (set! tmp.12 824269768)
              (< tmp.12 9223372036854775807))
            (set! foobar.5.7 -9223372036854775808)
            (set! foobar.5.7 709343632))
        (set! rax foobar.5.7)
        (jump tmp-ra.9 rbp rax))))
  (check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.2 (rax tmp.3 foo.6.1 rbp))
                                                     (foo.6.1 (rbp tmp-ra.2))
                                                     (tmp.3 (rbp tmp-ra.2))
                                                     (rbp (rax tmp.3 foo.6.1 tmp-ra.2))
                                                     (rax (rbp tmp-ra.2))))
                                         (assignment ((tmp-ra.2 r15) (foo.6.1 r14) (tmp.3 r14))))
                            (begin
                              (set! tmp-ra.2 r15)
                              (set! foo.6.1 -356902212)
                              (set! tmp.3 -979281755)
                              (set! tmp.3 (+ tmp.3 9223372036854775807))
                              (set! rax tmp.3)
                              (jump tmp-ra.2 rbp rax))
                      ))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp.6 (rbp tmp-ra.5)) (tmp-ra.5 (rbp tmp.6 rax))
                                                            (rax (rbp tmp-ra.5))
                                                            (rbp (tmp-ra.5 tmp.6 rax))))
                         (assignment ((tmp-ra.5 r15) (tmp.6 r14))))
            (define L.tmp.0.1
              ((locals ())
               (conflicts ((tmp-ra.4 (foo.5.1 foobar.9.2 ball.6.3 rbp rdx rsi rdi))
                           (ball.6.3 (rbp tmp-ra.4 rdx rsi))
                           (foobar.9.2 (rbp tmp-ra.4 rdx))
                           (foo.5.1 (rbp tmp-ra.4))
                           (rdi (r15 rbp rsi rdx tmp-ra.4))
                           (rsi (r15 rdi rbp rdx ball.6.3 tmp-ra.4))
                           (rdx (r15 rdi rsi rbp foobar.9.2 ball.6.3 tmp-ra.4))
                           (rbp (r15 rdi rsi rdx foo.5.1 foobar.9.2 ball.6.3 tmp-ra.4))
                           (r15 (rbp rdi rsi rdx))))
               (assignment ((tmp-ra.4 r15) (ball.6.3 r14) (foobar.9.2 r14) (foo.5.1 r14))))
              (begin
                (set! tmp-ra.4 r15)
                (set! ball.6.3 rdi)
                (set! foobar.9.2 rsi)
                (set! foo.5.1 rdx)
                (set! rdx foo.5.1)
                (set! rsi 182548382)
                (set! rdi 0)
                (set! r15 tmp-ra.4)
                (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
      (begin
        (set! tmp-ra.5 r15)
        (if (begin
              (set! tmp.6 1)
              (= tmp.6 -444572554))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.5 rbp rax))
            (begin
              (set! rax 0)
              (jump tmp-ra.5 rbp rax))))))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp.18 (rbp tmp-ra.16)) (tmp-ra.16 (rbp tmp.18 rax))
                                                              (rax (rbp tmp-ra.16))
                                                              (rbp (tmp-ra.16 tmp.18 rax))))
                         (assignment ((tmp-ra.16 r15) (tmp.18 r14))))
            (define L.x.0.1
              ((locals ())
               (conflicts
                ((bat.6.3
                  (bat.5.1 ball.4.2 rbp tmp-ra.14 bar.7.4 foobar.9.6 bat.6.7 bat.5.8 rcx r8 rax))
                 (foobar.9.6 (rbp tmp-ra.14 bat.6.3 bar.7.4 ball.4.2))
                 (bat.6.7 (rbp tmp-ra.14 bat.6.3 bar.7.4 ball.4.2))
                 (bar.7.4
                  (bat.5.1 ball.4.2 bat.6.3 rbp tmp-ra.14 r8 rcx rdx foobar.9.6 bat.6.7 bat.5.8 rax))
                 (tmp-ra.14 (bat.5.1 ball.4.2
                                     bat.6.3
                                     bar.7.4
                                     ball.3.5
                                     rbp
                                     r8
                                     rcx
                                     rdx
                                     rsi
                                     rdi
                                     foobar.9.6
                                     bat.6.7
                                     bat.5.8
                                     rax))
                 (ball.4.2 (bat.5.1 rbp tmp-ra.14 bat.6.3 bar.7.4 r8 foobar.9.6 bat.6.7))
                 (bat.5.1 (rbp tmp-ra.14 bat.6.3 bar.7.4 ball.4.2 rsi rdx r8))
                 (bat.5.8 (rbp tmp-ra.14 bat.6.3 bar.7.4))
                 (ball.3.5 (rbp tmp-ra.14 r8 rcx rdx rsi))
                 (rax (bat.6.3 bar.7.4 rbp tmp-ra.14))
                 (rbp (bat.5.1 ball.4.2
                               bat.6.3
                               bar.7.4
                               ball.3.5
                               tmp-ra.14
                               foobar.9.6
                               bat.6.7
                               bat.5.8
                               r15
                               rdi
                               rsi
                               rdx
                               rcx
                               r8
                               rax))
                 (r8 (ball.4.2 bar.7.4 ball.3.5 tmp-ra.14 r15 rdi rsi rdx rcx rbp bat.5.1 bat.6.3))
                 (rcx (bar.7.4 ball.3.5 tmp-ra.14 r15 rdi rsi rdx rbp r8 bat.6.3))
                 (rdx (bar.7.4 ball.3.5 tmp-ra.14 r15 rdi rsi rbp rcx r8 bat.5.1))
                 (rsi (ball.3.5 tmp-ra.14 r15 rdi rbp rdx rcx r8 bat.5.1))
                 (rdi (tmp-ra.14 r15 rbp rsi rdx rcx r8))
                 (r15 (rbp rdi rsi rdx rcx r8))))
               (assignment ((tmp-ra.14 fv0) (bat.6.3 fv1)
                                            (bar.7.4 fv2)
                                            (ball.4.2 r15)
                                            (bat.5.1 r14)
                                            (ball.3.5 r15)
                                            (foobar.9.6 r14)
                                            (bat.6.7 r14)
                                            (bat.5.8 r15))))
              (begin
                (set! tmp-ra.14 r15)
                (set! ball.3.5 rdi)
                (set! bar.7.4 rsi)
                (set! bat.6.3 rdx)
                (set! ball.4.2 rcx)
                (set! bat.5.1 r8)
                (if (not (<= bat.6.3 9223372036854775807))
                    (begin
                      (set! bat.6.7 -18835826)
                      (set! foobar.9.6 bat.6.7)
                      (if (>= bat.6.3 ball.4.2)
                          (begin
                            (set! rax bat.6.3)
                            (jump tmp-ra.14 rbp rax))
                          (begin
                            (set! rax bar.7.4)
                            (jump tmp-ra.14 rbp rax))))
                    (begin
                      (begin
                        (set! rbp (- rbp 24))
                        (return-point L.rp.3
                                      (begin
                                        (set! r8 0)
                                        (set! rcx bat.5.1)
                                        (set! rdx bat.6.3)
                                        (set! rsi 9223372036854775807)
                                        (set! rdi bat.5.1)
                                        (set! r15 L.rp.3)
                                        (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))
                        (set! rbp (+ rbp 24)))
                      (set! bat.5.8 rax)
                      (if (<= bar.7.4 -186024487)
                          (begin
                            (set! rax bat.5.8)
                            (jump tmp-ra.14 rbp rax))
                          (begin
                            (set! rax bat.6.3)
                            (jump tmp-ra.14 rbp rax)))))))
      (define L.func.1.2
        ((locals ())
         (conflicts
          ((tmp-ra.15 (rax bat.5.13 tmp.17 foobar.9.12 bar.7.11 ball.4.9 bar.8.10 rbp rsi rdi))
           (bar.8.10 (tmp.17 bar.7.11 ball.4.9 rbp tmp-ra.15 rsi))
           (ball.4.9 (rbp tmp-ra.15 bar.8.10))
           (bar.7.11 (tmp.17 foobar.9.12 rbp tmp-ra.15 bar.8.10))
           (foobar.9.12 (rbp tmp-ra.15 bar.7.11))
           (tmp.17 (rbp tmp-ra.15 bar.7.11 bar.8.10))
           (bat.5.13 (rbp tmp-ra.15))
           (rdi (tmp-ra.15))
           (rsi (bar.8.10 tmp-ra.15))
           (rbp (rax bat.5.13 tmp.17 foobar.9.12 bar.7.11 ball.4.9 bar.8.10 tmp-ra.15))
           (rax (rbp tmp-ra.15))))
         (assignment ((tmp-ra.15 r15) (bar.8.10 r14)
                                      (bar.7.11 r13)
                                      (tmp.17 r9)
                                      (ball.4.9 r13)
                                      (foobar.9.12 r14)
                                      (bat.5.13 r14))))
        (begin
          (set! tmp-ra.15 r15)
          (set! bar.8.10 rdi)
          (set! ball.4.9 rsi)
          (set! bar.7.11 -932453002)
          (if (begin
                (set! tmp.17 -1133252869)
                (>= tmp.17 9223372036854775807))
              (set! foobar.9.12 479665611)
              (set! foobar.9.12 bar.8.10))
          (set! bat.5.13 bar.7.11)
          (set! rax bar.7.11)
          (jump tmp-ra.15 rbp rax)))
      (begin
        (set! tmp-ra.16 r15)
        (if (begin
              (set! tmp.18 1588211020)
              (>= tmp.18 1))
            (begin
              (set! rax 9223372036854775807)
              (jump tmp-ra.16 rbp rax))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.16 rbp rax))))))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((tmp-ra.9 (rdi bat.2.6 tmp.11 rbp)) (tmp.11 (rbp tmp-ra.9))
                                                             (bat.2.6 (rbp tmp-ra.9))
                                                             (rbp (r15 rdi bat.2.6 tmp.11 tmp-ra.9))
                                                             (rdi (r15 rbp tmp-ra.9))
                                                             (r15 (rbp rdi))))
             (assignment ((tmp-ra.9 r15) (tmp.11 r14) (bat.2.6 r14))))
            (define L.proc.0.1
              ((locals ()) (conflicts ((tmp-ra.7 (rsi rdx bar.1.2 tmp.10 bat.9.1 rbp rdi))
                                       (bat.9.1 (tmp.10 rbp tmp-ra.7))
                                       (tmp.10 (rbp tmp-ra.7 bat.9.1))
                                       (bar.1.2 (rdx rbp tmp-ra.7))
                                       (rdi (r15 rbp rsi rdx tmp-ra.7))
                                       (rbp (r15 rdi rsi rdx bar.1.2 tmp.10 bat.9.1 tmp-ra.7))
                                       (rdx (r15 rdi rsi rbp tmp-ra.7 bar.1.2))
                                       (rsi (r15 rdi rbp rdx tmp-ra.7))
                                       (r15 (rbp rdi rsi rdx))))
                           (assignment ((tmp-ra.7 r15) (bat.9.1 r14) (tmp.10 r13) (bar.1.2 r14))))
              (begin
                (set! tmp-ra.7 r15)
                (set! bat.9.1 rdi)
                (set! tmp.10 1)
                (set! tmp.10 (+ tmp.10 bat.9.1))
                (set! bar.1.2 tmp.10)
                (set! rdx 9223372036854775807)
                (set! rsi bar.1.2)
                (set! rdi 515658026)
                (set! r15 tmp-ra.7)
                (jump L.func.1.2 rbp r15 rdi rsi rdx)))
      (define L.func.1.2
        ((locals ()) (conflicts ((tmp-ra.8 (bar.1.3 foobar.6.4 foobar.8.5 rbp rdi rsi rdx))
                                 (foobar.8.5 (bar.1.3 foobar.6.4 rbp tmp-ra.8 rsi rdx))
                                 (foobar.6.4 (bar.1.3 rbp tmp-ra.8 foobar.8.5 rdx))
                                 (bar.1.3 (rbp tmp-ra.8 foobar.8.5 foobar.6.4))
                                 (rdx (foobar.6.4 foobar.8.5 r15 rdi rsi rbp tmp-ra.8))
                                 (rbp (bar.1.3 foobar.6.4 foobar.8.5 tmp-ra.8 r15 rdi rsi rdx))
                                 (rsi (foobar.8.5 r15 rdi rbp rdx tmp-ra.8))
                                 (rdi (r15 rbp rsi rdx tmp-ra.8))
                                 (r15 (rbp rdi rsi rdx))))
                     (assignment ((tmp-ra.8 r15) (foobar.8.5 r14) (foobar.6.4 r13) (bar.1.3 r9))))
        (begin
          (set! tmp-ra.8 r15)
          (set! foobar.8.5 rdi)
          (set! foobar.6.4 rsi)
          (set! bar.1.3 rdx)
          (if (true)
              (begin
                (set! rdx foobar.6.4)
                (set! rsi foobar.8.5)
                (set! rdi -508654129)
                (set! r15 tmp-ra.8)
                (jump L.func.1.2 rbp r15 rdi rsi rdx))
              (begin
                (set! rdx foobar.6.4)
                (set! rsi 9223372036854775807)
                (set! rdi 1)
                (set! r15 tmp-ra.8)
                (jump L.func.1.2 rbp r15 rdi rsi rdx)))))
      (begin
        (set! tmp-ra.9 r15)
        (set! tmp.11 0)
        (set! tmp.11 (* tmp.11 -9223372036854775808))
        (set! bat.2.6 tmp.11)
        (set! rdi -39871347)
        (set! r15 tmp-ra.9)
        (jump L.proc.0.1 rbp r15 rdi))))
  (check-by-interp '(module ((locals ()) (conflicts ((tmp.2 (rbp tmp-ra.1)) (tmp-ra.1 (rbp tmp.2 rax))
                                                                            (rax (rbp tmp-ra.1))
                                                                            (rbp (tmp-ra.1 tmp.2
                                                                                           rax))))
                                         (assignment ((tmp-ra.1 r15) (tmp.2 r14))))
                            (begin
                              (set! tmp-ra.1 r15)
                              (if (begin
                                    (set! tmp.2 1)
                                    (>= tmp.2 -9223372036854775808))
                                  (begin
                                    (set! rax 234292566)
                                    (jump tmp-ra.1 rbp rax))
                                  (begin
                                    (set! rax -1579825632)
                                    (jump tmp-ra.1 rbp rax))))
                      ))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.8 (rdi rsi rdx rcx r8 r9 rbp))
                                     (rbp (r15 rdi rsi rdx rcx r8 r9 tmp-ra.8))
                                     (r9 (r15 rdi rsi rdx rcx r8 rbp tmp-ra.8))
                                     (r8 (r15 rdi rsi rdx rcx rbp r9 tmp-ra.8))
                                     (rcx (r15 rdi rsi rdx rbp r8 r9 tmp-ra.8))
                                     (rdx (r15 rdi rsi rbp rcx r8 r9 tmp-ra.8))
                                     (rsi (r15 rdi rbp rdx rcx r8 r9 tmp-ra.8))
                                     (rdi (r15 rbp rsi rdx rcx r8 r9 tmp-ra.8))
                                     (r15 (rbp rdi rsi rdx rcx r8 r9))))
                         (assignment ((tmp-ra.8 r15))))
            (define L.x.0.1
              ((locals ())
               (conflicts
                ((tmp.9 (rbp tmp-ra.7 foo.2.6 ball.5.5 bat.3.2 ball.4.3 foobar.9.4))
                 (foo.2.6
                  (bar.7.1 bat.3.2 ball.4.3 foobar.9.4 ball.5.5 rbp tmp-ra.7 tmp.9 rsi rdx rcx r8 r9))
                 (tmp-ra.7 (bar.7.1 bat.3.2
                                    ball.4.3
                                    foobar.9.4
                                    ball.5.5
                                    foo.2.6
                                    rbp
                                    tmp.9
                                    rdi
                                    rsi
                                    rdx
                                    rcx
                                    r8
                                    r9))
                 (foobar.9.4
                  (bar.7.1 bat.3.2 ball.4.3 rbp tmp-ra.7 foo.2.6 ball.5.5 tmp.9 rsi rdx rcx r8 r9))
                 (ball.4.3
                  (bar.7.1 bat.3.2 rbp tmp-ra.7 foo.2.6 ball.5.5 foobar.9.4 tmp.9 rdx rcx r8 r9))
                 (bat.3.2 (bar.7.1 rbp tmp-ra.7 foo.2.6 ball.5.5 ball.4.3 foobar.9.4 tmp.9 r8 r9))
                 (ball.5.5
                  (bar.7.1 bat.3.2 ball.4.3 foobar.9.4 rbp tmp-ra.7 foo.2.6 r8 rcx rdx tmp.9 r9))
                 (bar.7.1 (rbp tmp-ra.7 foo.2.6 ball.5.5 bat.3.2 ball.4.3 foobar.9.4))
                 (r9
                  (foo.2.6 r15 rdi rsi rdx rcx r8 rbp tmp-ra.7 foobar.9.4 ball.4.3 bat.3.2 ball.5.5))
                 (rbp (bar.7.1 bat.3.2
                               ball.4.3
                               foobar.9.4
                               ball.5.5
                               foo.2.6
                               tmp-ra.7
                               tmp.9
                               r15
                               rdi
                               rsi
                               rdx
                               rcx
                               r8
                               r9))
                 (r8
                  (ball.5.5 foo.2.6 r15 rdi rsi rdx rcx rbp r9 tmp-ra.7 foobar.9.4 ball.4.3 bat.3.2))
                 (rcx (ball.5.5 foo.2.6 r15 rdi rsi rdx rbp r8 r9 tmp-ra.7 foobar.9.4 ball.4.3))
                 (rdx (ball.5.5 foo.2.6 r15 rdi rsi rbp rcx r8 r9 tmp-ra.7 foobar.9.4 ball.4.3))
                 (rsi (foo.2.6 r15 rdi rbp rdx rcx r8 r9 tmp-ra.7 foobar.9.4))
                 (rdi (r15 rbp rsi rdx rcx r8 r9 tmp-ra.7))
                 (r15 (rbp rdi rsi rdx rcx r8 r9))))
               (assignment ((tmp-ra.7 r15) (foo.2.6 r14)
                                           (foobar.9.4 r13)
                                           (ball.4.3 rdi)
                                           (ball.5.5 rsi)
                                           (bat.3.2 rdx)
                                           (tmp.9 r9)
                                           (bar.7.1 r9))))
              (begin
                (set! tmp-ra.7 r15)
                (set! foo.2.6 rdi)
                (set! ball.5.5 rsi)
                (set! foobar.9.4 rdx)
                (set! ball.4.3 rcx)
                (set! bat.3.2 r8)
                (set! bar.7.1 r9)
                (if (not (not (begin
                                (set! tmp.9 9223372036854775807)
                                (= tmp.9 foo.2.6))))
                    (begin
                      (set! r9 9223372036854775807)
                      (set! r8 -1679374410)
                      (set! rcx 1)
                      (set! rdx 1)
                      (set! rsi 0)
                      (set! rdi foo.2.6)
                      (set! r15 tmp-ra.7)
                      (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9))
                    (begin
                      (set! r9 -9223372036854775808)
                      (set! r8 ball.5.5)
                      (set! rcx bat.3.2)
                      (set! rdx -30425170)
                      (set! rsi ball.4.3)
                      (set! rdi foobar.9.4)
                      (set! r15 tmp-ra.7)
                      (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (begin
        (set! tmp-ra.8 r15)
        (set! r9 1)
        (set! r8 -1659310511)
        (set! rcx 671608402)
        (set! rdx 1)
        (set! rsi 0)
        (set! rdi 158605610)
        (set! r15 tmp-ra.8)
        (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))
  (check-by-interp '(module ((locals ()) (conflicts ((tmp-ra.1 (rax rbp)) (rbp (rax tmp-ra.1))
                                                                          (rax (rbp tmp-ra.1))))
                                         (assignment ((tmp-ra.1 r15))))
                            (begin
                              (set! tmp-ra.1 r15)
                              (set! rax 1)
                              (jump tmp-ra.1 rbp rax))
                      ))
  (check-by-interp
   '(module ((locals ())
             (conflicts
              ((tmp.27 (rbp tmp-ra.21 bat.0.14))
               (bat.0.14 (rbp tmp-ra.21 tmp.27 tmp.28))
               (tmp.28 (rbp tmp-ra.21 bat.0.14))
               (foobar.8.17 (rbp tmp-ra.21))
               (bar.2.15 (rbp tmp-ra.21))
               (bar.2.16 (rbp tmp-ra.21))
               (tmp-ra.21
                (rbp foobar.8.17 bar.2.15 bar.2.16 bat.0.14 tmp.27 tmp.28 rdx rcx r8 r9 fv0 rdi rsi))
               (rsi (rdx rcx r8 r9 fv0 r15 rdi rbp tmp-ra.21))
               (rbp (tmp-ra.21 foobar.8.17
                               bar.2.15
                               bar.2.16
                               bat.0.14
                               tmp.27
                               tmp.28
                               rdx
                               rcx
                               r8
                               r9
                               fv0
                               r15
                               rdi
                               rsi))
               (rdi (rdx rcx r8 r9 fv0 r15 rbp rsi tmp-ra.21))
               (r15 (rdx rcx r8 r9 fv0 rbp rdi rsi))
               (fv0 (r15 rdi rsi rdx rcx r8 r9 rbp tmp-ra.21))
               (r9 (r15 rdi rsi rdx rcx r8 rbp fv0 tmp-ra.21))
               (r8 (r15 rdi rsi rdx rcx rbp r9 fv0 tmp-ra.21))
               (rcx (r15 rdi rsi rdx rbp r8 r9 fv0 tmp-ra.21))
               (rdx (r15 rdi rsi rbp rcx r8 r9 fv0 tmp-ra.21))))
             (assignment ((tmp-ra.21 r15) (bat.0.14 r14)
                                          (tmp.27 r13)
                                          (tmp.28 r13)
                                          (foobar.8.17 r14)
                                          (bar.2.15 r14)
                                          (bar.2.16 r14))))
            (define L.fn.0.1
              ((locals ())
               (conflicts ((tmp-ra.18 (rax tmp.22 foobar.4.3 bat.0.1 ball.9.2 rbp rsi rdi))
                           (ball.9.2 (bat.0.1 rbp tmp-ra.18 rsi))
                           (bat.0.1 (rbp tmp-ra.18 ball.9.2))
                           (foobar.4.3 (rbp tmp-ra.18))
                           (tmp.22 (rbp tmp-ra.18))
                           (rdi (tmp-ra.18))
                           (rsi (ball.9.2 tmp-ra.18))
                           (rbp (rax tmp.22 foobar.4.3 bat.0.1 ball.9.2 tmp-ra.18))
                           (rax (rbp tmp-ra.18))))
               (assignment
                ((tmp-ra.18 r15) (ball.9.2 r14) (bat.0.1 r13) (foobar.4.3 r14) (tmp.22 r14))))
              (begin
                (set! tmp-ra.18 r15)
                (set! ball.9.2 rdi)
                (set! bat.0.1 rsi)
                (set! foobar.4.3 ball.9.2)
                (set! tmp.22 0)
                (set! tmp.22 (* tmp.22 0))
                (set! rax tmp.22)
                (jump tmp-ra.18 rbp rax)))
      (define L.fn.1.2
        ((locals ())
         (conflicts ((tmp.23 (rbp tmp-ra.19)) (tmp-ra.19 (rbp tmp.23 ball.9.4 tmp.24 tmp.25 rax))
                                              (ball.9.4 (rbp tmp-ra.19))
                                              (tmp.24 (rbp tmp-ra.19))
                                              (tmp.25 (rbp tmp-ra.19))
                                              (rax (rbp tmp-ra.19))
                                              (rbp (tmp-ra.19 tmp.23 ball.9.4 tmp.24 tmp.25 rax))))
         (assignment ((tmp-ra.19 r15) (tmp.23 r14) (ball.9.4 r14) (tmp.24 r14) (tmp.25 r14))))
        (begin
          (set! tmp-ra.19 r15)
          (if (begin
                (set! tmp.23 -9223372036854775808)
                (>= tmp.23 9223372036854775807))
              (begin
                (set! rax -1098447432)
                (jump tmp-ra.19 rbp rax))
              (begin
                (set! tmp.24 -9223372036854775808)
                (set! tmp.24 (+ tmp.24 -9223372036854775808))
                (set! ball.9.4 tmp.24)
                (if (begin
                      (set! tmp.25 857729561)
                      (< tmp.25 9223372036854775807))
                    (begin
                      (set! rax 9223372036854775807)
                      (jump tmp-ra.19 rbp rax))
                    (begin
                      (set! rax 1)
                      (jump tmp-ra.19 rbp rax)))))))
      (define L.fn.2.3
        ((locals ())
         (conflicts
          ((tmp-ra.20 (bar.2.5 bat.3.6
                               bar.7.7
                               foobar.4.8
                               ball.9.9
                               bat.0.10
                               bat.5.11
                               rbp
                               fv0
                               r9
                               r8
                               rcx
                               rdx
                               rdi
                               rsi
                               bar.2.12
                               tmp.26
                               rax
                               bat.6.13))
           (bat.0.10 (bar.2.5 bat.3.6
                              bar.7.7
                              foobar.4.8
                              ball.9.9
                              rbp
                              tmp-ra.20
                              bat.5.11
                              fv0
                              r9
                              r8
                              rcx
                              rdx
                              rsi
                              bar.2.12))
           (foobar.4.8 (bar.2.5 bat.3.6 bar.7.7 rbp tmp-ra.20 bat.0.10 bat.5.11 fv0 r9 r8 tmp.26))
           (bar.2.12 (rbp tmp-ra.20 bat.0.10))
           (bat.5.11 (bar.2.5 bat.3.6
                              bar.7.7
                              foobar.4.8
                              ball.9.9
                              bat.0.10
                              rbp
                              tmp-ra.20
                              fv0
                              r9
                              r8
                              rcx
                              rdx
                              rsi))
           (bat.6.13 (rbp tmp-ra.20))
           (bat.3.6 (bar.2.5 rbp tmp-ra.20 bat.0.10 foobar.4.8 bat.5.11 fv0))
           (tmp.26 (rbp tmp-ra.20 foobar.4.8))
           (ball.9.9 (rbp tmp-ra.20 bat.0.10 bat.5.11 fv0 r9 r8 rcx))
           (bar.7.7 (rbp tmp-ra.20 bat.0.10 foobar.4.8 bat.5.11 fv0 r9))
           (bar.2.5 (rbp tmp-ra.20 bat.0.10 foobar.4.8 bat.5.11 bat.3.6))
           (rbp (bar.2.5 bat.3.6
                         bar.7.7
                         foobar.4.8
                         ball.9.9
                         bat.0.10
                         bat.5.11
                         tmp-ra.20
                         r15
                         rdi
                         rsi
                         bar.2.12
                         tmp.26
                         rax
                         bat.6.13))
           (rax (rbp tmp-ra.20))
           (rsi (bat.5.11 r15 rdi rbp tmp-ra.20 bat.0.10))
           (rdi (r15 rbp rsi tmp-ra.20))
           (r15 (rbp rdi rsi))
           (rdx (bat.0.10 bat.5.11 tmp-ra.20))
           (rcx (ball.9.9 bat.0.10 bat.5.11 tmp-ra.20))
           (r8 (foobar.4.8 ball.9.9 bat.0.10 bat.5.11 tmp-ra.20))
           (r9 (bar.7.7 foobar.4.8 ball.9.9 bat.0.10 bat.5.11 tmp-ra.20))
           (fv0 (bat.3.6 bar.7.7 foobar.4.8 ball.9.9 bat.0.10 bat.5.11 tmp-ra.20))))
         (assignment ((tmp-ra.20 r15) (bat.0.10 r14)
                                      (bat.5.11 r13)
                                      (foobar.4.8 rdi)
                                      (ball.9.9 rdi)
                                      (bat.3.6 r9)
                                      (bar.7.7 r8)
                                      (bar.2.5 r8)
                                      (bar.2.12 r13)
                                      (tmp.26 r14)
                                      (bat.6.13 r14))))
        (begin
          (set! tmp-ra.20 r15)
          (set! bat.5.11 rdi)
          (set! bat.0.10 rsi)
          (set! ball.9.9 rdx)
          (set! foobar.4.8 rcx)
          (set! bar.7.7 r8)
          (set! bat.3.6 r9)
          (set! bar.2.5 fv0)
          (if (not (true))
              (begin
                (if (>= foobar.4.8 -9223372036854775808)
                    (set! bar.2.12 1)
                    (set! bar.2.12 1))
                (set! rsi bar.2.12)
                (set! rdi bat.0.10)
                (set! r15 tmp-ra.20)
                (jump L.fn.0.1 rbp r15 rdi rsi))
              (if (true)
                  (begin
                    (set! tmp.26 bat.3.6)
                    (set! tmp.26 (* tmp.26 foobar.4.8))
                    (set! rax tmp.26)
                    (jump tmp-ra.20 rbp rax))
                  (begin
                    (set! bat.6.13 bat.5.11)
                    (set! rax 674342291)
                    (jump tmp-ra.20 rbp rax))))))
      (begin
        (set! tmp-ra.21 r15)
        (if (begin
              (begin
                (set! bar.2.16 1)
                (set! bar.2.15 -9223372036854775808)
                (set! foobar.8.17 bar.2.15)
                (set! bat.0.14 9223372036854775807))
              (if (true)
                  (if (= bat.0.14 bat.0.14)
                      (begin
                        (set! tmp.27 -1195644570)
                        (>= tmp.27 bat.0.14))
                      (= bat.0.14 bat.0.14))
                  (if (> bat.0.14 bat.0.14)
                      (>= bat.0.14 bat.0.14)
                      (begin
                        (set! tmp.28 0)
                        (= tmp.28 bat.0.14)))))
            (begin
              (set! fv0 0)
              (set! r9 9223372036854775807)
              (set! r8 -2036437657)
              (set! rcx 0)
              (set! rdx 0)
              (set! rsi -1663007716)
              (set! rdi 1453047515)
              (set! r15 tmp-ra.21)
              (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0))
            (begin
              (set! rsi -1792916675)
              (set! rdi 1)
              (set! r15 tmp-ra.21)
              (jump L.fn.0.1 rbp r15 rdi rsi))))))
  (check-by-interp
   '(module ((locals ())
             (conflicts
              ((bat.4.1 (rbp tmp-ra.5 ball.6.4 tmp.9))
               (tmp.9 (rbp tmp-ra.5 bat.4.1))
               (tmp-ra.5 (tmp.6 tmp.7 bar.5.2 tmp.8 bar.3.3 bat.4.1 rbp ball.6.4 tmp.9 rax))
               (ball.6.4 (rbp tmp-ra.5 bat.4.1))
               (bar.3.3 (rbp tmp-ra.5))
               (tmp.8 (rbp tmp-ra.5))
               (tmp.7 (rbp tmp-ra.5))
               (bar.5.2 (rbp tmp-ra.5))
               (tmp.6 (rbp tmp-ra.5))
               (rax (rbp tmp-ra.5))
               (rbp (tmp.6 tmp.7 bar.5.2 tmp.8 bar.3.3 bat.4.1 tmp-ra.5 ball.6.4 tmp.9 rax))))
             (assignment ((tmp-ra.5 r15) (bat.4.1 r14)
                                         (tmp.9 r13)
                                         (ball.6.4 r13)
                                         (bar.3.3 r14)
                                         (tmp.8 r14)
                                         (tmp.7 r14)
                                         (bar.5.2 r14)
                                         (tmp.6 r14))))
            (begin
              (set! tmp-ra.5 r15)
              (if (begin
                    (set! tmp.6 -9223372036854775808)
                    (> tmp.6 9223372036854775807))
                  (begin
                    (if (begin
                          (set! tmp.7 1)
                          (!= tmp.7 9223372036854775807))
                        (set! bar.5.2 9223372036854775807)
                        (set! bar.5.2 463110926))
                    (set! bat.4.1 0))
                  (begin
                    (set! bar.3.3 0)
                    (set! tmp.8 -1584028825)
                    (set! tmp.8 (- tmp.8 -9223372036854775808))
                    (set! bat.4.1 tmp.8)))
              (if (not (> bat.4.1 1))
                  (if (begin
                        (set! ball.6.4 -9223372036854775808)
                        (>= ball.6.4 ball.6.4))
                      (if (> bat.4.1 491128034)
                          (begin
                            (set! rax bat.4.1)
                            (jump tmp-ra.5 rbp rax))
                          (begin
                            (set! rax 1)
                            (jump tmp-ra.5 rbp rax)))
                      (if (begin
                            (set! tmp.9 1050399943)
                            (= tmp.9 bat.4.1))
                          (begin
                            (set! rax -1604958676)
                            (jump tmp-ra.5 rbp rax))
                          (begin
                            (set! rax bat.4.1)
                            (jump tmp-ra.5 rbp rax))))
                  (begin
                    (set! rax bat.4.1)
                    (jump tmp-ra.5 rbp rax))))
      ))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.9 (rdi rsi rdx rcx r8 r9 fv0 rbp))
                                     (rbp (r15 rdi rsi rdx rcx r8 r9 fv0 tmp-ra.9))
                                     (fv0 (r15 rdi rsi rdx rcx r8 r9 rbp tmp-ra.9))
                                     (r9 (r15 rdi rsi rdx rcx r8 rbp fv0 tmp-ra.9))
                                     (r8 (r15 rdi rsi rdx rcx rbp r9 fv0 tmp-ra.9))
                                     (rcx (r15 rdi rsi rdx rbp r8 r9 fv0 tmp-ra.9))
                                     (rdx (r15 rdi rsi rbp rcx r8 r9 fv0 tmp-ra.9))
                                     (rsi (r15 rdi rbp rdx rcx r8 r9 fv0 tmp-ra.9))
                                     (rdi (r15 rbp rsi rdx rcx r8 r9 fv0 tmp-ra.9))
                                     (r15 (rbp rdi rsi rdx rcx r8 r9 fv0))))
                         (assignment ((tmp-ra.9 r15))))
            (define L.tmp.0.1
              ((locals ())
               (conflicts
                ((tmp-ra.8 (bat.8.1 ball.3.2
                                    bar.5.3
                                    bat.1.4
                                    foobar.7.5
                                    foo.4.6
                                    foobar.9.7
                                    rbp
                                    fv0
                                    r9
                                    r8
                                    rcx
                                    rdx
                                    rsi
                                    rdi))
                 (foobar.9.7 (rbp tmp-ra.8 fv0 r9 r8 rcx rdx rsi))
                 (foo.4.6 (rbp tmp-ra.8 fv0 r9 r8 rcx rdx))
                 (foobar.7.5 (rbp tmp-ra.8 fv0 r9 r8 rcx))
                 (bat.1.4 (rbp tmp-ra.8 fv0 r9 r8))
                 (bar.5.3 (rbp tmp-ra.8 fv0 r9))
                 (ball.3.2 (bat.8.1 rbp tmp-ra.8 fv0))
                 (bat.8.1 (rcx r8 r9 fv0 rbp tmp-ra.8 ball.3.2))
                 (rdi (r15 rbp rsi rdx rcx r8 r9 fv0 tmp-ra.8))
                 (rsi (r15 rdi rbp rdx rcx r8 r9 fv0 foobar.9.7 tmp-ra.8))
                 (rdx (r15 rdi rsi rbp rcx r8 r9 fv0 foo.4.6 foobar.9.7 tmp-ra.8))
                 (rcx (r15 rdi rsi rdx rbp r8 r9 fv0 bat.8.1 foobar.7.5 foo.4.6 foobar.9.7 tmp-ra.8))
                 (r8 (r15 rdi
                          rsi
                          rdx
                          rcx
                          rbp
                          r9
                          fv0
                          bat.8.1
                          bat.1.4
                          foobar.7.5
                          foo.4.6
                          foobar.9.7
                          tmp-ra.8))
                 (r9 (r15 rdi
                          rsi
                          rdx
                          rcx
                          r8
                          rbp
                          fv0
                          bat.8.1
                          bar.5.3
                          bat.1.4
                          foobar.7.5
                          foo.4.6
                          foobar.9.7
                          tmp-ra.8))
                 (fv0 (r15 rdi
                           rsi
                           rdx
                           rcx
                           r8
                           r9
                           rbp
                           bat.8.1
                           ball.3.2
                           bar.5.3
                           bat.1.4
                           foobar.7.5
                           foo.4.6
                           foobar.9.7
                           tmp-ra.8))
                 (rbp (r15 rdi
                           rsi
                           rdx
                           rcx
                           r8
                           r9
                           fv0
                           bat.8.1
                           ball.3.2
                           bar.5.3
                           bat.1.4
                           foobar.7.5
                           foo.4.6
                           foobar.9.7
                           tmp-ra.8))
                 (r15 (rbp rdi rsi rdx rcx r8 r9 fv0))))
               (assignment ((tmp-ra.8 r15) (foobar.9.7 r14)
                                           (foo.4.6 r14)
                                           (bat.8.1 r14)
                                           (foobar.7.5 r14)
                                           (bat.1.4 r14)
                                           (bar.5.3 r14)
                                           (ball.3.2 r13))))
              (begin
                (set! tmp-ra.8 r15)
                (set! foobar.9.7 rdi)
                (set! foo.4.6 rsi)
                (set! foobar.7.5 rdx)
                (set! bat.1.4 rcx)
                (set! bar.5.3 r8)
                (set! ball.3.2 r9)
                (set! bat.8.1 fv0)
                (set! fv0 ball.3.2)
                (set! r9 -1130190811)
                (set! r8 -9223372036854775808)
                (set! rcx 1751496267)
                (set! rdx bat.8.1)
                (set! rsi 0)
                (set! rdi -9223372036854775808)
                (set! r15 tmp-ra.8)
                (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.9 r15)
        (set! fv0 1)
        (set! r9 9223372036854775807)
        (set! r8 -9223372036854775808)
        (set! rcx -522285902)
        (set! rdx 754255570)
        (set! rsi -1704260755)
        (set! rdi 0)
        (set! r15 tmp-ra.9)
        (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0))))
  (check-by-interp
   '(module ((locals ()) (conflicts ((foo.9.17 (rbp tmp-ra.21))
                                     (tmp-ra.21 (rbp rax foo.9.17 rdi rsi rdx rcx r8 r9 fv0))
                                     (fv0 (r15 rdi rsi rdx rcx r8 r9 rbp tmp-ra.21))
                                     (rbp (tmp-ra.21 rax foo.9.17 r15 rdi rsi rdx rcx r8 r9 fv0))
                                     (r9 (r15 rdi rsi rdx rcx r8 rbp fv0 tmp-ra.21))
                                     (r8 (r15 rdi rsi rdx rcx rbp r9 fv0 tmp-ra.21))
                                     (rcx (r15 rdi rsi rdx rbp r8 r9 fv0 tmp-ra.21))
                                     (rdx (r15 rdi rsi rbp rcx r8 r9 fv0 tmp-ra.21))
                                     (rsi (r15 rdi rbp rdx rcx r8 r9 fv0 tmp-ra.21))
                                     (rdi (r15 rbp rsi rdx rcx r8 r9 fv0 tmp-ra.21))
                                     (r15 (rbp rdi rsi rdx rcx r8 r9 fv0))
                                     (rax (rbp tmp-ra.21))))
                         (assignment ((tmp-ra.21 r15) (foo.9.17 r14))))
            (define L.proc.0.1
              ((locals ())
               (conflicts ((tmp-ra.18 (r8 bar.0.1 foo.6.2 bat.5.3 foo.8.4 rbp rcx rdx rsi rdi))
                           (foo.8.4 (rbp tmp-ra.18 rcx rdx rsi))
                           (bat.5.3 (r8 bar.0.1 foo.6.2 rbp tmp-ra.18 rcx rdx))
                           (foo.6.2 (bar.0.1 rbp tmp-ra.18 bat.5.3 rcx))
                           (bar.0.1 (rdx rcx r8 rbp tmp-ra.18 bat.5.3 foo.6.2))
                           (rdi (r15 rbp rsi rdx rcx r8 tmp-ra.18))
                           (rsi (r15 rdi rbp rdx rcx r8 foo.8.4 tmp-ra.18))
                           (rdx (r15 rdi rsi rbp rcx r8 bar.0.1 bat.5.3 foo.8.4 tmp-ra.18))
                           (rcx (r15 rdi rsi rdx rbp r8 bar.0.1 foo.6.2 bat.5.3 foo.8.4 tmp-ra.18))
                           (rbp (r15 rdi rsi rdx rcx r8 bar.0.1 foo.6.2 bat.5.3 foo.8.4 tmp-ra.18))
                           (r8 (r15 rdi rsi rdx rcx rbp tmp-ra.18 bar.0.1 bat.5.3))
                           (r15 (rbp rdi rsi rdx rcx r8))))
               (assignment ((tmp-ra.18 r15) (bat.5.3 r14) (bar.0.1 r13) (foo.8.4 r14) (foo.6.2 r9))))
              (begin
                (set! tmp-ra.18 r15)
                (set! foo.8.4 rdi)
                (set! bat.5.3 rsi)
                (set! foo.6.2 rdx)
                (set! bar.0.1 rcx)
                (set! r8 foo.6.2)
                (set! rcx 9223372036854775807)
                (set! rdx bat.5.3)
                (set! rsi bar.0.1)
                (set! rdi 9223372036854775807)
                (set! r15 tmp-ra.18)
                (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8)))
      (define L.func.1.2
        ((locals ())
         (conflicts
          ((tmp-ra.19 (r9 fv0 bat.4.5 foo.9.6 bar.0.7 foo.8.8 bat.3.9 rbp r8 rcx rdx rsi rdi))
           (bat.3.9 (rbp tmp-ra.19 r8 rcx rdx rsi))
           (foo.8.8 (r9 fv0 bat.4.5 foo.9.6 bar.0.7 rbp tmp-ra.19 r8 rcx rdx))
           (bar.0.7 (rdx r9 fv0 bat.4.5 foo.9.6 rbp tmp-ra.19 foo.8.8 r8 rcx))
           (foo.9.6 (r9 fv0 bat.4.5 rbp tmp-ra.19 bar.0.7 foo.8.8 r8))
           (bat.4.5 (fv0 rbp tmp-ra.19 bar.0.7 foo.8.8 foo.9.6))
           (rdi (r15 rbp rsi rdx rcx r8 r9 fv0 tmp-ra.19))
           (rsi (r15 rdi rbp rdx rcx r8 r9 fv0 bat.3.9 tmp-ra.19))
           (rdx (r15 rdi rsi rbp rcx r8 r9 fv0 bar.0.7 foo.8.8 bat.3.9 tmp-ra.19))
           (rcx (r15 rdi rsi rdx rbp r8 r9 fv0 bar.0.7 foo.8.8 bat.3.9 tmp-ra.19))
           (r8 (r15 rdi rsi rdx rcx rbp r9 fv0 foo.9.6 bar.0.7 foo.8.8 bat.3.9 tmp-ra.19))
           (rbp (r15 rdi rsi rdx rcx r8 r9 fv0 bat.4.5 foo.9.6 bar.0.7 foo.8.8 bat.3.9 tmp-ra.19))
           (fv0 (r15 rdi rsi rdx rcx r8 r9 rbp tmp-ra.19 bar.0.7 foo.8.8 foo.9.6 bat.4.5))
           (r9 (r15 rdi rsi rdx rcx r8 rbp fv0 tmp-ra.19 bar.0.7 foo.8.8 foo.9.6))
           (r15 (rbp rdi rsi rdx rcx r8 r9 fv0))))
         (assignment
          ((tmp-ra.19 r15) (foo.8.8 r14) (bar.0.7 r13) (foo.9.6 rdi) (bat.3.9 r14) (bat.4.5 r9))))
        (begin
          (set! tmp-ra.19 r15)
          (set! bat.3.9 rdi)
          (set! foo.8.8 rsi)
          (set! bar.0.7 rdx)
          (set! foo.9.6 rcx)
          (set! bat.4.5 r8)
          (set! fv0 -9223372036854775808)
          (set! r9 bat.4.5)
          (set! r8 foo.9.6)
          (set! rcx bar.0.7)
          (set! rdx foo.8.8)
          (set! rsi bar.0.7)
          (set! rdi 9223372036854775807)
          (set! r15 tmp-ra.19)
          (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (define L.tmp.2.3
        ((locals ())
         (conflicts
          ((tmp-ra.20 (rax foo.6.10
                           foo.2.11
                           foo.8.12
                           bat.4.13
                           bat.5.14
                           bat.3.15
                           foo.7.16
                           rbp
                           fv0
                           r9
                           r8
                           rcx
                           rdx
                           rsi
                           rdi))
           (foo.7.16 (rbp tmp-ra.20 fv0 r9 r8 rcx rdx rsi))
           (bat.3.15 (rbp tmp-ra.20 fv0 r9 r8 rcx rdx))
           (bat.5.14 (foo.6.10 foo.2.11 foo.8.12 bat.4.13 rbp tmp-ra.20 fv0 r9 r8 rcx))
           (bat.4.13 (rbp tmp-ra.20 bat.5.14 fv0 r9 r8))
           (foo.8.12 (rbp tmp-ra.20 bat.5.14 fv0 r9))
           (foo.2.11 (rbp tmp-ra.20 bat.5.14 fv0))
           (foo.6.10 (rbp tmp-ra.20 bat.5.14))
           (rdi (tmp-ra.20))
           (rsi (foo.7.16 tmp-ra.20))
           (rdx (bat.3.15 foo.7.16 tmp-ra.20))
           (rcx (bat.5.14 bat.3.15 foo.7.16 tmp-ra.20))
           (r8 (bat.4.13 bat.5.14 bat.3.15 foo.7.16 tmp-ra.20))
           (r9 (foo.8.12 bat.4.13 bat.5.14 bat.3.15 foo.7.16 tmp-ra.20))
           (fv0 (foo.2.11 foo.8.12 bat.4.13 bat.5.14 bat.3.15 foo.7.16 tmp-ra.20))
           (rbp (rax foo.6.10 foo.2.11 foo.8.12 bat.4.13 bat.5.14 bat.3.15 foo.7.16 tmp-ra.20))
           (rax (rbp tmp-ra.20))))
         (assignment ((tmp-ra.20 r15) (bat.5.14 r14)
                                      (foo.7.16 r14)
                                      (bat.3.15 r14)
                                      (bat.4.13 r13)
                                      (foo.8.12 r13)
                                      (foo.2.11 r13)
                                      (foo.6.10 r13))))
        (begin
          (set! tmp-ra.20 r15)
          (set! foo.7.16 rdi)
          (set! bat.3.15 rsi)
          (set! bat.5.14 rdx)
          (set! bat.4.13 rcx)
          (set! foo.8.12 r8)
          (set! foo.2.11 r9)
          (set! foo.6.10 fv0)
          (set! rax bat.5.14)
          (jump tmp-ra.20 rbp rax)))
      (begin
        (set! tmp-ra.21 r15)
        (if (false)
            (begin
              (set! foo.9.17 1281469771)
              (set! rax 0)
              (jump tmp-ra.21 rbp rax))
            (begin
              (set! fv0 1)
              (set! r9 9223372036854775807)
              (set! r8 1)
              (set! rcx -282402130)
              (set! rdx -9223372036854775808)
              (set! rsi 9223372036854775807)
              (set! rdi 1)
              (set! r15 tmp-ra.21)
              (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0))))))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.19 (rax ball.1.15 rbp)) (ball.1.15 (rbp tmp-ra.19))
                                                                     (rbp (rax ball.1.15 tmp-ra.19))
                                                                     (rax (rbp tmp-ra.19))))
                         (assignment ((tmp-ra.19 r15) (ball.1.15 r14))))
            (define L.tmp.0.1
              ((locals ())
               (conflicts ((tmp-ra.16 (ball.5.1 foobar.2.2
                                                bat.3.3
                                                foo.6.4
                                                foo.7.5
                                                bar.4.6
                                                bar.8.7
                                                rbp
                                                fv0
                                                r9
                                                r8
                                                rcx
                                                rdx
                                                rsi
                                                rdi))
                           (bar.8.7 (rbp tmp-ra.16 fv0 r9 r8 rcx rdx rsi))
                           (bar.4.6 (rbp tmp-ra.16 fv0 r9 r8 rcx rdx))
                           (foo.7.5 (rbp tmp-ra.16 fv0 r9 r8 rcx))
                           (foo.6.4 (ball.5.1 foobar.2.2 bat.3.3 rbp tmp-ra.16 fv0 r9 r8))
                           (bat.3.3 (rbp tmp-ra.16 foo.6.4 fv0 r9))
                           (foobar.2.2 (rbp tmp-ra.16 foo.6.4 fv0))
                           (ball.5.1 (rbp tmp-ra.16 foo.6.4))
                           (rdi (r15 rbp rsi rdx tmp-ra.16))
                           (rsi (r15 rdi rbp rdx bar.8.7 tmp-ra.16))
                           (rdx (r15 rdi rsi rbp bar.4.6 bar.8.7 tmp-ra.16))
                           (rcx (foo.7.5 bar.4.6 bar.8.7 tmp-ra.16))
                           (r8 (foo.6.4 foo.7.5 bar.4.6 bar.8.7 tmp-ra.16))
                           (r9 (bat.3.3 foo.6.4 foo.7.5 bar.4.6 bar.8.7 tmp-ra.16))
                           (fv0 (foobar.2.2 bat.3.3 foo.6.4 foo.7.5 bar.4.6 bar.8.7 tmp-ra.16))
                           (rbp (r15 rdi
                                     rsi
                                     rdx
                                     ball.5.1
                                     foobar.2.2
                                     bat.3.3
                                     foo.6.4
                                     foo.7.5
                                     bar.4.6
                                     bar.8.7
                                     tmp-ra.16))
                           (r15 (rbp rdi rsi rdx))))
               (assignment ((tmp-ra.16 r15) (bar.8.7 r14)
                                            (foo.6.4 r14)
                                            (bar.4.6 r14)
                                            (foo.7.5 r14)
                                            (bat.3.3 r13)
                                            (foobar.2.2 r13)
                                            (ball.5.1 r13))))
              (begin
                (set! tmp-ra.16 r15)
                (set! bar.8.7 rdi)
                (set! bar.4.6 rsi)
                (set! foo.7.5 rdx)
                (set! foo.6.4 rcx)
                (set! bat.3.3 r8)
                (set! foobar.2.2 r9)
                (set! ball.5.1 fv0)
                (set! rdx foo.6.4)
                (set! rsi 946654223)
                (set! rdi 9223372036854775807)
                (set! r15 tmp-ra.16)
                (jump L.func.1.2 rbp r15 rdi rsi rdx)))
      (define L.func.1.2
        ((locals ()) (conflicts ((tmp-ra.17 (bar.8.8 ball.5.9 ball.1.10 rbp rdx rsi rdi))
                                 (ball.1.10 (rbp tmp-ra.17 rdx rsi))
                                 (ball.5.9 (rsi bar.8.8 rbp tmp-ra.17 rdx))
                                 (bar.8.8 (rdx rbp tmp-ra.17 ball.5.9))
                                 (rdi (r15 rbp rsi rdx tmp-ra.17))
                                 (rsi (r15 rdi rbp rdx ball.5.9 ball.1.10 tmp-ra.17))
                                 (rdx (r15 rdi rsi rbp bar.8.8 ball.5.9 ball.1.10 tmp-ra.17))
                                 (rbp (r15 rdi rsi rdx bar.8.8 ball.5.9 ball.1.10 tmp-ra.17))
                                 (r15 (rbp rdi rsi rdx))))
                     (assignment ((tmp-ra.17 r15) (ball.5.9 r14) (ball.1.10 r14) (bar.8.8 r13))))
        (begin
          (set! tmp-ra.17 r15)
          (set! ball.1.10 rdi)
          (set! ball.5.9 rsi)
          (set! bar.8.8 rdx)
          (set! rdx 9223372036854775807)
          (set! rsi bar.8.8)
          (set! rdi ball.5.9)
          (set! r15 tmp-ra.17)
          (jump L.func.1.2 rbp r15 rdi rsi rdx)))
      (define L.fn.2.3
        ((locals ())
         (conflicts ((tmp-ra.18 (ball.5.14 ball.5.11 ball.0.12 bar.8.13 rbp rdx rsi rdi))
                     (bar.8.13 (ball.5.14 ball.5.11 ball.0.12 rbp tmp-ra.18 rdx rsi))
                     (ball.0.12 (rsi ball.5.14 ball.5.11 rbp tmp-ra.18 bar.8.13 rdx))
                     (ball.5.11 (rbp tmp-ra.18 ball.0.12 bar.8.13))
                     (ball.5.14 (rbp tmp-ra.18 ball.0.12 bar.8.13))
                     (rdi (r15 rbp rsi rdx tmp-ra.18))
                     (rsi (r15 rdi rbp rdx ball.0.12 bar.8.13 tmp-ra.18))
                     (rdx (r15 rdi rsi rbp ball.0.12 bar.8.13 tmp-ra.18))
                     (rbp (r15 rdi rsi rdx ball.5.14 ball.5.11 ball.0.12 bar.8.13 tmp-ra.18))
                     (r15 (rbp rdi rsi rdx))))
         (assignment ((tmp-ra.18 r15) (bar.8.13 r14) (ball.0.12 r13) (ball.5.11 r9) (ball.5.14 r9))))
        (begin
          (set! tmp-ra.18 r15)
          (set! bar.8.13 rdi)
          (set! ball.0.12 rsi)
          (set! ball.5.11 rdx)
          (set! ball.5.14 9223372036854775807)
          (set! rdx bar.8.13)
          (set! rsi 0)
          (set! rdi ball.0.12)
          (set! r15 tmp-ra.18)
          (jump L.func.1.2 rbp r15 rdi rsi rdx)))
      (begin
        (set! tmp-ra.19 r15)
        (set! ball.1.15 0)
        (set! rax 1)
        (jump tmp-ra.19 rbp rax))))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((tmp-ra.9 (rdi rsi rdx rcx r8 rbp)) (rbp (r15 rdi rsi rdx rcx r8 tmp-ra.9))
                                                             (r8 (r15 rdi rsi rdx rcx rbp tmp-ra.9))
                                                             (rcx (r15 rdi rsi rdx rbp r8 tmp-ra.9))
                                                             (rdx (r15 rdi rsi rbp rcx r8 tmp-ra.9))
                                                             (rsi (r15 rdi rbp rdx rcx r8 tmp-ra.9))
                                                             (rdi (r15 rbp rsi rdx rcx r8 tmp-ra.9))
                                                             (r15 (rbp rdi rsi rdx rcx r8))))
             (assignment ((tmp-ra.9 r15))))
            (define L.func.0.1
              ((locals ())
               (conflicts
                ((foo.9.7 (rbp tmp-ra.8))
                 (tmp.10 (rbp tmp-ra.8 foo.9.5))
                 (ball.3.6 (rbp tmp-ra.8))
                 (foo.9.5 (foo.1.1 bat.2.2 foobar.7.3 foo.0.4 rbp tmp-ra.8 r8 rcx rdx rsi tmp.10))
                 (tmp-ra.8 (foo.1.1 bat.2.2
                                    foobar.7.3
                                    foo.0.4
                                    foo.9.5
                                    rbp
                                    r8
                                    rcx
                                    rdx
                                    rsi
                                    rdi
                                    foo.9.7
                                    tmp.10
                                    ball.3.6
                                    rax))
                 (foo.0.4 (rbp tmp-ra.8 foo.9.5 r8 rcx rdx))
                 (foobar.7.3 (rbp tmp-ra.8 foo.9.5 r8 rcx))
                 (bat.2.2 (rbp tmp-ra.8 foo.9.5 r8))
                 (foo.1.1 (rbp tmp-ra.8 foo.9.5))
                 (rax (rbp tmp-ra.8))
                 (rbp
                  (foo.1.1 bat.2.2 foobar.7.3 foo.0.4 foo.9.5 tmp-ra.8 foo.9.7 tmp.10 ball.3.6 rax))
                 (rdi (tmp-ra.8))
                 (rsi (foo.9.5 tmp-ra.8))
                 (rdx (foo.0.4 foo.9.5 tmp-ra.8))
                 (rcx (foobar.7.3 foo.0.4 foo.9.5 tmp-ra.8))
                 (r8 (bat.2.2 foobar.7.3 foo.0.4 foo.9.5 tmp-ra.8))))
               (assignment ((tmp-ra.8 r15) (foo.9.5 r14)
                                           (foo.0.4 r13)
                                           (foobar.7.3 r13)
                                           (bat.2.2 r13)
                                           (tmp.10 r13)
                                           (foo.1.1 r13)
                                           (foo.9.7 r14)
                                           (ball.3.6 r14))))
              (begin
                (set! tmp-ra.8 r15)
                (set! foo.9.5 rdi)
                (set! foo.0.4 rsi)
                (set! foobar.7.3 rdx)
                (set! bat.2.2 rcx)
                (set! foo.1.1 r8)
                (if (false)
                    (begin
                      (if (begin
                            (set! tmp.10 -9223372036854775808)
                            (!= tmp.10 0))
                          (set! ball.3.6 1)
                          (set! ball.3.6 foo.9.5))
                      (set! foo.9.7 9223372036854775807)
                      (set! rax 9223372036854775807)
                      (jump tmp-ra.8 rbp rax))
                    (begin
                      (set! rax 1)
                      (jump tmp-ra.8 rbp rax)))))
      (begin
        (set! tmp-ra.9 r15)
        (set! r8 1653803490)
        (set! rcx 1918330809)
        (set! rdx 1)
        (set! rsi 9223372036854775807)
        (set! rdi -9223372036854775808)
        (set! r15 tmp-ra.9)
        (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8))))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.10 (rax rbp)) (rbp (rax tmp-ra.10))
                                                           (rax (rbp tmp-ra.10))))
                         (assignment ((tmp-ra.10 r15))))
            (define L.fn.0.1
              ((locals ()) (conflicts ((foobar.1.3 (rbp tmp-ra.7 bat.6.1 bat.8.2))
                                       (bat.8.2 (bat.6.1 rbp tmp-ra.7 rsi foobar.1.3))
                                       (tmp-ra.7 (bat.6.1 bat.8.2 rbp foobar.1.3 rdi rsi rdx))
                                       (bat.6.1 (rbp tmp-ra.7 bat.8.2 foobar.1.3 rsi rdx))
                                       (r15 (rdi rsi rdx rbp))
                                       (rbp (bat.6.1 bat.8.2 tmp-ra.7 foobar.1.3 rdi rsi rdx r15))
                                       (rdx (r15 rdi rsi rbp tmp-ra.7 bat.6.1))
                                       (rsi (bat.8.2 r15 rdi rbp rdx tmp-ra.7 bat.6.1))
                                       (rdi (r15 rbp rsi rdx tmp-ra.7))))
                           (assignment ((tmp-ra.7 r15) (bat.6.1 r14) (bat.8.2 r13) (foobar.1.3 r9))))
              (begin
                (set! tmp-ra.7 r15)
                (set! bat.8.2 rdi)
                (set! bat.6.1 rsi)
                (if (begin
                      (set! foobar.1.3 559317709)
                      (not (= foobar.1.3 bat.8.2)))
                    (begin
                      (set! rdx -675648818)
                      (set! rsi -9223372036854775808)
                      (set! rdi bat.6.1)
                      (set! r15 tmp-ra.7)
                      (jump L.func.1.2 rbp r15 rdi rsi rdx))
                    (begin
                      (set! r15 tmp-ra.7)
                      (jump L.tmp.2.3 rbp r15)))))
      (define L.func.1.2
        ((locals ()) (conflicts ((tmp-ra.8 (foo.5.4 foo.0.5 foobar.1.6 rbp rdx rsi rdi))
                                 (foobar.1.6 (rbp tmp-ra.8 rdx rsi))
                                 (foo.0.5 (rbp tmp-ra.8 rdx))
                                 (foo.5.4 (rbp tmp-ra.8))
                                 (rdi (tmp-ra.8))
                                 (rsi (foobar.1.6 tmp-ra.8))
                                 (rdx (foo.0.5 foobar.1.6 tmp-ra.8))
                                 (rbp (r15 foo.5.4 foo.0.5 foobar.1.6 tmp-ra.8))
                                 (r15 (rbp))))
                     (assignment ((tmp-ra.8 r15) (foobar.1.6 r14) (foo.0.5 r14) (foo.5.4 r14))))
        (begin
          (set! tmp-ra.8 r15)
          (set! foobar.1.6 rdi)
          (set! foo.0.5 rsi)
          (set! foo.5.4 rdx)
          (set! r15 tmp-ra.8)
          (jump L.tmp.2.3 rbp r15)))
      (define L.tmp.2.3
        ((locals ()) (conflicts ((tmp-ra.9 (rbp)) (rbp (r15 tmp-ra.9)) (r15 (rbp))))
                     (assignment ((tmp-ra.9 r15))))
        (begin
          (set! tmp-ra.9 r15)
          (set! r15 tmp-ra.9)
          (jump L.tmp.2.3 rbp r15)))
      (begin
        (set! tmp-ra.10 r15)
        (set! rax 1)
        (jump tmp-ra.10 rbp rax))))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((tmp-ra.9 (rdi rsi rdx rcx rbp)) (rbp (r15 rdi rsi rdx rcx tmp-ra.9))
                                                          (rcx (r15 rdi rsi rdx rbp tmp-ra.9))
                                                          (rdx (r15 rdi rsi rbp rcx tmp-ra.9))
                                                          (rsi (r15 rdi rbp rdx rcx tmp-ra.9))
                                                          (rdi (r15 rbp rsi rdx rcx tmp-ra.9))
                                                          (r15 (rbp rdi rsi rdx rcx))))
             (assignment ((tmp-ra.9 r15))))
            (define L.x.0.1
              ((locals ())
               (conflicts
                ((tmp-ra.8 (rax tmp.10
                                foobar.7.6
                                bar.3.7
                                bat.2.5
                                bat.9.1
                                bat.2.2
                                ball.0.3
                                bar.3.4
                                rbp
                                rcx
                                rdx
                                rsi
                                rdi))
                 (bar.3.4
                  (foobar.7.6 bar.3.7 bat.2.5 bat.9.1 bat.2.2 ball.0.3 rbp tmp-ra.8 rcx rdx rsi))
                 (ball.0.3 (bat.9.1 bat.2.2 rbp tmp-ra.8 bar.3.4 rcx rdx))
                 (bat.2.2 (rbp tmp-ra.8 bar.3.4 ball.0.3 rcx))
                 (bat.9.1 (rbp tmp-ra.8 bar.3.4 ball.0.3))
                 (bat.2.5 (rbp tmp-ra.8 bar.3.4))
                 (bar.3.7 (rbp tmp-ra.8 bar.3.4))
                 (foobar.7.6 (rbp tmp-ra.8 bar.3.4))
                 (tmp.10 (rbp tmp-ra.8))
                 (rdi (tmp-ra.8))
                 (rsi (bar.3.4 tmp-ra.8))
                 (rdx (ball.0.3 bar.3.4 tmp-ra.8))
                 (rcx (bat.2.2 ball.0.3 bar.3.4 tmp-ra.8))
                 (rbp
                  (rax tmp.10 foobar.7.6 bar.3.7 bat.2.5 bat.9.1 bat.2.2 ball.0.3 bar.3.4 tmp-ra.8))
                 (rax (rbp tmp-ra.8))))
               (assignment ((tmp-ra.8 r15) (bar.3.4 r14)
                                           (ball.0.3 r13)
                                           (bat.2.2 r9)
                                           (bat.9.1 r9)
                                           (bat.2.5 r13)
                                           (bar.3.7 r13)
                                           (foobar.7.6 r13)
                                           (tmp.10 r14))))
              (begin
                (set! tmp-ra.8 r15)
                (set! bar.3.4 rdi)
                (set! ball.0.3 rsi)
                (set! bat.2.2 rdx)
                (set! bat.9.1 rcx)
                (if (= ball.0.3 bat.9.1)
                    (set! bat.2.5 ball.0.3)
                    (set! bat.2.5 -1012326174))
                (set! bar.3.7 0)
                (set! foobar.7.6 bar.3.7)
                (set! tmp.10 bar.3.4)
                (set! tmp.10 (- tmp.10 0))
                (set! rax tmp.10)
                (jump tmp-ra.8 rbp rax)))
      (begin
        (set! tmp-ra.9 r15)
        (set! rcx 1259250868)
        (set! rdx 1097392993)
        (set! rsi 0)
        (set! rdi 1)
        (set! r15 tmp-ra.9)
        (jump L.x.0.1 rbp r15 rdi rsi rdx rcx))))
  (check-by-interp
   '(module ((locals ()) (conflicts ((tmp-ra.15 (rdi rsi rbp)) (rbp (r15 rdi rsi tmp-ra.15))
                                                               (rsi (r15 rdi rbp tmp-ra.15))
                                                               (rdi (r15 rbp rsi tmp-ra.15))
                                                               (r15 (rbp rdi rsi))))
                         (assignment ((tmp-ra.15 r15))))
            (define L.func.0.1
              ((locals ())
               (conflicts ((tmp-ra.12 (ball.3.1 bat.9.2
                                                foobar.7.3
                                                foobar.6.4
                                                bat.0.5
                                                ball.1.6
                                                foo.4.7
                                                rbp
                                                fv0
                                                r9
                                                r8
                                                rcx
                                                rdx
                                                rsi
                                                rdi))
                           (foo.4.7 (rbp tmp-ra.12 fv0 r9 r8 rcx rdx rsi))
                           (ball.1.6 (rbp tmp-ra.12 fv0 r9 r8 rcx rdx))
                           (bat.0.5 (rbp tmp-ra.12 fv0 r9 r8 rcx))
                           (foobar.6.4 (rsi ball.3.1 bat.9.2 foobar.7.3 rbp tmp-ra.12 fv0 r9 r8))
                           (foobar.7.3 (rbp tmp-ra.12 foobar.6.4 fv0 r9))
                           (bat.9.2 (rbp tmp-ra.12 foobar.6.4 fv0))
                           (ball.3.1 (rbp tmp-ra.12 foobar.6.4))
                           (rdi (r15 rbp rsi tmp-ra.12))
                           (rsi (r15 rdi rbp foobar.6.4 foo.4.7 tmp-ra.12))
                           (rdx (ball.1.6 foo.4.7 tmp-ra.12))
                           (rcx (bat.0.5 ball.1.6 foo.4.7 tmp-ra.12))
                           (r8 (foobar.6.4 bat.0.5 ball.1.6 foo.4.7 tmp-ra.12))
                           (r9 (foobar.7.3 foobar.6.4 bat.0.5 ball.1.6 foo.4.7 tmp-ra.12))
                           (fv0 (bat.9.2 foobar.7.3 foobar.6.4 bat.0.5 ball.1.6 foo.4.7 tmp-ra.12))
                           (rbp (r15 rdi
                                     rsi
                                     ball.3.1
                                     bat.9.2
                                     foobar.7.3
                                     foobar.6.4
                                     bat.0.5
                                     ball.1.6
                                     foo.4.7
                                     tmp-ra.12))
                           (r15 (rbp rdi rsi))))
               (assignment ((tmp-ra.12 r15) (foobar.6.4 r14)
                                            (foo.4.7 r14)
                                            (ball.1.6 r14)
                                            (bat.0.5 r14)
                                            (foobar.7.3 r13)
                                            (bat.9.2 r13)
                                            (ball.3.1 r13))))
              (begin
                (set! tmp-ra.12 r15)
                (set! foo.4.7 rdi)
                (set! ball.1.6 rsi)
                (set! bat.0.5 rdx)
                (set! foobar.6.4 rcx)
                (set! foobar.7.3 r8)
                (set! bat.9.2 r9)
                (set! ball.3.1 fv0)
                (set! rsi 0)
                (set! rdi foobar.6.4)
                (set! r15 tmp-ra.12)
                (jump L.x.1.2 rbp r15 rdi rsi)))
      (define L.x.1.2
        ((locals ())
         (conflicts
          ((tmp.17 (rbp tmp-ra.13 ball.8.10 bat.9.8))
           (bat.9.8 (ball.3.11 tmp.16 ball.8.10 rcx r8 r9 rax rbp tmp-ra.13 foobar.7.9 tmp.17))
           (ball.8.10 (ball.3.11 tmp.16 rbp tmp-ra.13 bat.9.8 foobar.7.9 tmp.17))
           (tmp-ra.13 (ball.3.11 tmp.16 ball.8.10 bat.9.8 foobar.7.9 rbp rsi rdi tmp.17 rax))
           (foobar.7.9 (ball.8.10 rdx r8 r9 nfv.14 rax bat.9.8 rbp tmp-ra.13 rsi))
           (nfv.14 (r15 rdi rsi rdx rcx r8 r9 rbp foobar.7.9))
           (tmp.16 (rbp tmp-ra.13 ball.8.10 bat.9.8))
           (ball.3.11 (rbp tmp-ra.13 ball.8.10 bat.9.8))
           (rax (bat.9.8 foobar.7.9 rbp tmp-ra.13))
           (rbp (ball.3.11 tmp.16
                           ball.8.10
                           r15
                           rdi
                           rsi
                           rdx
                           rcx
                           r8
                           r9
                           nfv.14
                           bat.9.8
                           foobar.7.9
                           tmp-ra.13
                           tmp.17
                           rax))
           (rdi (r15 rbp rsi rdx rcx r8 r9 nfv.14 tmp-ra.13))
           (rsi (r15 rdi rbp rdx rcx r8 r9 nfv.14 foobar.7.9 tmp-ra.13))
           (r9 (r15 rdi rsi rdx rcx r8 rbp nfv.14 foobar.7.9 bat.9.8))
           (r8 (r15 rdi rsi rdx rcx rbp r9 nfv.14 foobar.7.9 bat.9.8))
           (rcx (r15 rdi rsi rdx rbp r8 r9 nfv.14 bat.9.8))
           (rdx (r15 rdi rsi rbp rcx r8 r9 nfv.14 foobar.7.9))
           (r15 (rbp rdi rsi rdx rcx r8 r9 nfv.14))))
         (assignment ((tmp-ra.13 fv0) (bat.9.8 fv1)
                                      (foobar.7.9 fv2)
                                      (nfv.14 fv3)
                                      (ball.8.10 r15)
                                      (tmp.17 r14)
                                      (tmp.16 r14)
                                      (ball.3.11 r14))))
        (begin
          (set! tmp-ra.13 r15)
          (set! foobar.7.9 rdi)
          (set! bat.9.8 rsi)
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.3
                          (begin
                            (set! nfv.14 bat.9.8)
                            (set! r9 -9223372036854775808)
                            (set! r8 -9223372036854775808)
                            (set! rcx foobar.7.9)
                            (set! rdx bat.9.8)
                            (set! rsi bat.9.8)
                            (set! rdi foobar.7.9)
                            (set! r15 L.rp.3)
                            (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8 r9 nfv.14)))
            (set! rbp (+ rbp 24)))
          (set! ball.8.10 rax)
          (set! tmp.16 foobar.7.9)
          (set! tmp.16 (+ tmp.16 -841927304))
          (set! ball.3.11 tmp.16)
          (if (begin
                (set! tmp.17 -9223372036854775808)
                (= tmp.17 bat.9.8))
              (begin
                (set! rax ball.8.10)
                (jump tmp-ra.13 rbp rax))
              (begin
                (set! rax -19487548)
                (jump tmp-ra.13 rbp rax)))))
      (begin
        (set! tmp-ra.15 r15)
        (set! rsi 169577204)
        (set! rdi 1130382988)
        (set! r15 tmp-ra.15)
        (jump L.x.1.2 rbp r15 rdi rsi))))
  (check-by-interp
   '(module ((locals ())
             (conflicts
              ((foo.6.13 (rbp tmp-ra.17))
               (tmp.19 (rbp tmp-ra.17))
               (tmp.20 (rbp tmp-ra.17))
               (tmp.21 (rbp tmp-ra.17))
               (tmp-ra.17 (rbp tmp.19 foo.6.13 bar.1.14 tmp.20 tmp.21 rax rdi rsi rdx rcx r8 r9))
               (bar.1.14 (rbp tmp-ra.17))
               (r9 (r15 rdi rsi rdx rcx r8 rbp tmp-ra.17))
               (rbp (tmp-ra.17 tmp.19 foo.6.13 bar.1.14 tmp.20 tmp.21 rax r15 rdi rsi rdx rcx r8 r9))
               (r8 (r15 rdi rsi rdx rcx rbp r9 tmp-ra.17))
               (rcx (r15 rdi rsi rdx rbp r8 r9 tmp-ra.17))
               (rdx (r15 rdi rsi rbp rcx r8 r9 tmp-ra.17))
               (rsi (r15 rdi rbp rdx rcx r8 r9 tmp-ra.17))
               (rdi (r15 rbp rsi rdx rcx r8 r9 tmp-ra.17))
               (r15 (rbp rdi rsi rdx rcx r8 r9))
               (rax (rbp tmp-ra.17))))
             (assignment
              ((tmp-ra.17 r15) (foo.6.13 r14) (tmp.19 r14) (tmp.20 r14) (tmp.21 r14) (bar.1.14 r14))))
            (define L.proc.0.1
              ((locals ())
               (conflicts
                ((ball.5.3 (ball.7.1 bat.4.2 rbp tmp-ra.15 bar.8.5 r9 r8 foobar.2.8 bar.1.7 tmp.18))
                 (foobar.2.8 (rbp tmp-ra.15 ball.5.3))
                 (bar.1.7 (rbp tmp-ra.15 ball.5.3))
                 (tmp.18 (rbp tmp-ra.15 ball.5.3))
                 (tmp-ra.15 (ball.7.1 bat.4.2
                                      ball.5.3
                                      foobar.2.4
                                      bar.8.5
                                      bat.0.6
                                      rbp
                                      rax
                                      foobar.2.8
                                      bar.1.7
                                      tmp.18
                                      rdi
                                      rsi
                                      rdx
                                      rcx
                                      r8
                                      r9))
                 (bat.4.2 (ball.7.1 rbp tmp-ra.15 ball.5.3 bar.8.5 rcx r8 r9))
                 (bar.8.5 (ball.7.1 bat.4.2 ball.5.3 foobar.2.4 rbp tmp-ra.15 r9 rcx rdx r8))
                 (bat.0.6 (rbp tmp-ra.15 r9 r8 rcx rdx rsi))
                 (foobar.2.4 (rbp tmp-ra.15 bar.8.5 r9 r8 rcx))
                 (ball.7.1 (rbp tmp-ra.15 ball.5.3 bar.8.5 bat.4.2))
                 (r9
                  (ball.5.3 foobar.2.4 bar.8.5 bat.0.6 r15 rdi rsi rdx rcx r8 rbp tmp-ra.15 bat.4.2))
                 (rbp (ball.7.1 bat.4.2
                                ball.5.3
                                foobar.2.4
                                bar.8.5
                                bat.0.6
                                tmp-ra.15
                                rax
                                foobar.2.8
                                bar.1.7
                                tmp.18
                                r15
                                rdi
                                rsi
                                rdx
                                rcx
                                r8
                                r9))
                 (r8
                  (ball.5.3 foobar.2.4 bat.0.6 r15 rdi rsi rdx rcx rbp r9 tmp-ra.15 bat.4.2 bar.8.5))
                 (rcx (foobar.2.4 bar.8.5 bat.0.6 r15 rdi rsi rdx rbp r8 r9 tmp-ra.15 bat.4.2))
                 (rdx (bar.8.5 bat.0.6 r15 rdi rsi rbp rcx r8 r9 tmp-ra.15))
                 (rsi (bat.0.6 r15 rdi rbp rdx rcx r8 r9 tmp-ra.15))
                 (rdi (r15 rbp rsi rdx rcx r8 r9 tmp-ra.15))
                 (r15 (rbp rdi rsi rdx rcx r8 r9))
                 (rax (rbp tmp-ra.15))))
               (assignment ((tmp-ra.15 r15) (ball.5.3 r14)
                                            (bar.8.5 r13)
                                            (bat.4.2 rdi)
                                            (bat.0.6 r14)
                                            (foobar.2.4 r14)
                                            (ball.7.1 r9)
                                            (foobar.2.8 r13)
                                            (bar.1.7 r13)
                                            (tmp.18 r13))))
              (begin
                (set! tmp-ra.15 r15)
                (set! bat.0.6 rdi)
                (set! bar.8.5 rsi)
                (set! foobar.2.4 rdx)
                (set! ball.5.3 rcx)
                (set! bat.4.2 r8)
                (set! ball.7.1 r9)
                (if (false)
                    (begin
                      (set! tmp.18 1763789232)
                      (set! tmp.18 (+ tmp.18 0))
                      (set! bar.1.7 tmp.18)
                      (set! foobar.2.8 9223372036854775807)
                      (set! rax ball.5.3)
                      (jump tmp-ra.15 rbp rax))
                    (begin
                      (set! r9 bar.8.5)
                      (set! r8 -9223372036854775808)
                      (set! rcx bar.8.5)
                      (set! rdx bat.4.2)
                      (set! rsi bat.4.2)
                      (set! rdi 9223372036854775807)
                      (set! r15 tmp-ra.15)
                      (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (define L.func.1.2
        ((locals ())
         (conflicts ((tmp-ra.16 (ball.5.9 bat.4.10 bar.1.11 foobar.2.12 rbp rcx rdx rsi rdi))
                     (foobar.2.12 (rbp tmp-ra.16 rcx rdx rsi))
                     (bar.1.11 (rsi ball.5.9 bat.4.10 rbp tmp-ra.16 rcx rdx))
                     (bat.4.10 (rdx ball.5.9 rbp tmp-ra.16 bar.1.11 rcx))
                     (ball.5.9 (rcx rbp tmp-ra.16 bar.1.11 bat.4.10))
                     (rdi (r15 rbp rsi rdx rcx tmp-ra.16))
                     (rsi (r15 rdi rbp rdx rcx bar.1.11 foobar.2.12 tmp-ra.16))
                     (rdx (r15 rdi rsi rbp rcx bat.4.10 bar.1.11 foobar.2.12 tmp-ra.16))
                     (rcx (r15 rdi rsi rdx rbp ball.5.9 bat.4.10 bar.1.11 foobar.2.12 tmp-ra.16))
                     (rbp (r15 rdi rsi rdx rcx ball.5.9 bat.4.10 bar.1.11 foobar.2.12 tmp-ra.16))
                     (r15 (rbp rdi rsi rdx rcx))))
         (assignment ((tmp-ra.16 r15) (bar.1.11 r14) (bat.4.10 r13) (foobar.2.12 r14) (ball.5.9 r9))))
        (begin
          (set! tmp-ra.16 r15)
          (set! foobar.2.12 rdi)
          (set! bar.1.11 rsi)
          (set! bat.4.10 rdx)
          (set! ball.5.9 rcx)
          (set! rcx 1283566420)
          (set! rdx ball.5.9)
          (set! rsi bat.4.10)
          (set! rdi bar.1.11)
          (set! r15 tmp-ra.16)
          (jump L.func.1.2 rbp r15 rdi rsi rdx rcx)))
      (begin
        (set! tmp-ra.17 r15)
        (if (begin
              (begin
                (set! tmp.19 -9223372036854775808)
                (set! tmp.19 (- tmp.19 9223372036854775807))
                (set! foo.6.13 tmp.19))
              (false))
            (if (true)
                (if (true)
                    (begin
                      (set! rcx -9223372036854775808)
                      (set! rdx -481495635)
                      (set! rsi 0)
                      (set! rdi 9223372036854775807)
                      (set! r15 tmp-ra.17)
                      (jump L.func.1.2 rbp r15 rdi rsi rdx rcx))
                    (begin
                      (set! bar.1.14 1)
                      (set! rax 1)
                      (jump tmp-ra.17 rbp rax)))
                (if (not (begin
                           (set! tmp.20 -2094891483)
                           (<= tmp.20 -9223372036854775808)))
                    (if (begin
                          (set! tmp.21 -9223372036854775808)
                          (>= tmp.21 -753552692))
                        (begin
                          (set! rax 1)
                          (jump tmp-ra.17 rbp rax))
                        (begin
                          (set! rax 9223372036854775807)
                          (jump tmp-ra.17 rbp rax)))
                    (begin
                      (set! r9 -1972468042)
                      (set! r8 9223372036854775807)
                      (set! rcx 1598924696)
                      (set! rdx 0)
                      (set! rsi 1)
                      (set! rdi 1)
                      (set! r15 tmp-ra.17)
                      (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))
            (if (false)
                (begin
                  (set! r9 1)
                  (set! r8 716409514)
                  (set! rcx 0)
                  (set! rdx 0)
                  (set! rsi 9223372036854775807)
                  (set! rdi 9223372036854775807)
                  (set! r15 tmp-ra.17)
                  (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))
                (begin
                  (set! r9 1)
                  (set! r8 -100459334)
                  (set! rcx -983869259)
                  (set! rdx -9223372036854775808)
                  (set! rsi -1938006617)
                  (set! rdi 1)
                  (set! r15 tmp-ra.17)
                  (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))))
  (check-by-interp
   '(module ((locals ())
             (conflicts ((tmp-ra.12 (rdi rsi rdx rcx r8 rbp)) (rbp (r15 rdi rsi rdx rcx r8 tmp-ra.12))
                                                              (r8 (r15 rdi rsi rdx rcx rbp tmp-ra.12))
                                                              (rcx (r15 rdi rsi rdx rbp r8 tmp-ra.12))
                                                              (rdx (r15 rdi rsi rbp rcx r8 tmp-ra.12))
                                                              (rsi (r15 rdi rbp rdx rcx r8 tmp-ra.12))
                                                              (rdi (r15 rbp rsi rdx rcx r8 tmp-ra.12))
                                                              (r15 (rbp rdi rsi rdx rcx r8))))
             (assignment ((tmp-ra.12 r15))))
            (define L.tmp.0.1
              ((locals ())
               (conflicts ((tmp-ra.10 (rcx r8 bar.4.1 ball.5.2 bar.9.3 rbp rdx rsi rdi))
                           (bar.9.3 (rbp tmp-ra.10 rdx rsi))
                           (ball.5.2 (rcx r8 bar.4.1 rbp tmp-ra.10 rdx))
                           (bar.4.1 (rbp tmp-ra.10 ball.5.2))
                           (rdi (r15 rbp rsi rdx rcx r8 tmp-ra.10))
                           (rsi (r15 rdi rbp rdx rcx r8 bar.9.3 tmp-ra.10))
                           (rdx (r15 rdi rsi rbp rcx r8 ball.5.2 bar.9.3 tmp-ra.10))
                           (rbp (r15 rdi rsi rdx rcx r8 bar.4.1 ball.5.2 bar.9.3 tmp-ra.10))
                           (r8 (r15 rdi rsi rdx rcx rbp tmp-ra.10 ball.5.2))
                           (rcx (r15 rdi rsi rdx rbp r8 tmp-ra.10 ball.5.2))
                           (r15 (rbp rdi rsi rdx rcx r8))))
               (assignment ((tmp-ra.10 r15) (ball.5.2 r14) (bar.9.3 r14) (bar.4.1 r13))))
              (begin
                (set! tmp-ra.10 r15)
                (set! bar.9.3 rdi)
                (set! ball.5.2 rsi)
                (set! bar.4.1 rdx)
                (set! r8 bar.4.1)
                (set! rcx 1)
                (set! rdx ball.5.2)
                (set! rsi -1620042780)
                (set! rdi 0)
                (set! r15 tmp-ra.10)
                (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8)))
      (define L.x.1.2
        ((locals ())
         (conflicts
          ((tmp-ra.11
            (rax tmp.13 foo.6.9 foo.1.4 bat.0.5 bar.9.6 bar.2.7 ball.8.8 rbp r8 rcx rdx rsi rdi))
           (ball.8.8 (rbp tmp-ra.11 r8 rcx rdx rsi))
           (bar.2.7 (rbp tmp-ra.11 r8 rcx rdx))
           (bar.9.6 (rbp tmp-ra.11 r8 rcx))
           (bat.0.5 (tmp.13 foo.6.9 foo.1.4 rbp tmp-ra.11 r8))
           (foo.1.4 (rbp tmp-ra.11 bat.0.5))
           (foo.6.9 (rbp tmp-ra.11 bat.0.5))
           (tmp.13 (rbp tmp-ra.11 bat.0.5))
           (rdi (tmp-ra.11))
           (rsi (ball.8.8 tmp-ra.11))
           (rdx (bar.2.7 ball.8.8 tmp-ra.11))
           (rcx (bar.9.6 bar.2.7 ball.8.8 tmp-ra.11))
           (r8 (bat.0.5 bar.9.6 bar.2.7 ball.8.8 tmp-ra.11))
           (rbp (rax tmp.13 foo.6.9 foo.1.4 bat.0.5 bar.9.6 bar.2.7 ball.8.8 tmp-ra.11))
           (rax (rbp tmp-ra.11))))
         (assignment ((tmp-ra.11 r15) (ball.8.8 r14)
                                      (bat.0.5 r14)
                                      (bar.2.7 r14)
                                      (bar.9.6 r14)
                                      (foo.1.4 r13)
                                      (foo.6.9 r13)
                                      (tmp.13 r13))))
        (begin
          (set! tmp-ra.11 r15)
          (set! ball.8.8 rdi)
          (set! bar.2.7 rsi)
          (set! bar.9.6 rdx)
          (set! bat.0.5 rcx)
          (set! foo.1.4 r8)
          (set! foo.6.9 9223372036854775807)
          (set! tmp.13 -9223372036854775808)
          (set! tmp.13 (+ tmp.13 bat.0.5))
          (set! rax tmp.13)
          (jump tmp-ra.11 rbp rax)))
      (begin
        (set! tmp-ra.12 r15)
        (set! r8 0)
        (set! rcx 1)
        (set! rdx 9223372036854775807)
        (set! rsi -913438169)
        (set! rdi -1611188905)
        (set! r15 tmp-ra.12)
        (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8))))
 