#lang racket

(require rackunit
         cpsc411/langs/v7
         (only-in "../implement-safe-primops.rkt" implement-safe-primops))

(define (check-exprs-unique-lang-v7 p)
  (if (exprs-unique-lang-v7? p) p (error (format "program \n ~a \n is not semantically valid"
    (pretty-format p)))))

(define (check-exprs-unsafe-data-lang-v7 p)
  (if (exprs-unsafe-data-lang-v7? p) p (error (format "program \n ~a \n is not semantically valid"
    (pretty-format p)))))

(define (peek x)
  ; (pretty-display x)
  x)

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-exprs-unique-lang-v7 (check-exprs-unique-lang-v7 p))
                (interp-exprs-unsafe-data-lang-v7
                 (check-exprs-unsafe-data-lang-v7 (peek (implement-safe-primops p))))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module 0))
(check-by-interp '(module 1))
(check-by-interp '(module #f))
(check-by-interp '(module #t))
(check-by-interp '(module #\3))
(check-by-interp '(module #\J))
(check-by-interp '(module (void)))
(check-by-interp '(module (call + 0 0)))
(check-by-interp '(module (call not #f)))
(check-by-interp '(module (call not #t)))
(check-by-interp '(module (if #f empty 0)))
(check-by-interp '(module (call fixnum? #t)))
(check-by-interp '(module (call error? (void))))
(check-by-interp '(module (call fixnum? empty)))
(check-by-interp '(module (call ascii-char? #t)))
(check-by-interp '(module (call boolean? (void))))
(check-by-interp '(module (call ascii-char? (void))))
(check-by-interp '(module (let ([foobar.8.1 #f]) foobar.8.1)))
(check-by-interp '(module (let ([foobar.2.2 #\d]
                                [bat.1.1 #\n])
                            foobar.2.2)))
(check-by-interp '(module (define L.proc.0.1 (lambda () #t)) (call void? 1)
                    ))
(check-by-interp '(module (define L.tmp.0.1 (lambda (foo.9.1) #t)) (call <= 0 0)
                    ))
(check-by-interp '(module (let ([foobar.1.3 #f]
                                [foo.2.2 empty]
                                [foo.5.1 135803637])
                            empty)))
(check-by-interp
 '(module (define L.x.0.1 (lambda (foo.4.5 ball.9.4 foo.8.3 ball.3.2 ball.5.1) -495192066)) #t
    ))
(check-by-interp
 '(module (define L.func.0.1 (lambda (foobar.2.6 foobar.9.5 bat.5.4 bar.8.3 ball.0.2 foo.1.1) 1)) #f
    ))
(check-by-interp '(module (define L.fn.0.1 (lambda (foo.5.1) (void)))
                          (define L.tmp.1.2 (lambda () empty))
                    #\L))
(check-by-interp '(module (define L.func.0.1 (lambda (bar.9.4 foobar.0.3 bar.7.2 ball.1.1) #f))
                          (if #\K
                              #t
                              (void))
                    ))
(check-by-interp '(module (define L.proc.0.1 (lambda (foobar.7.4 bar.4.3 bat.2.2 foo.8.1) bar.4.3))
                          (call eq? #\a 1)
                    ))
(check-by-interp '(module (define L.func.0.1
                            (lambda (bat.7.5 ball.3.4 bat.4.3 ball.0.2 bar.2.1) ball.0.2))
                          (call * 1 0)
                    ))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (bar.6.7 foo.7.6 foo.5.5 ball.1.4 foobar.8.3 bat.4.2 foobar.0.1)
                              foobar.0.1))
                          empty
                    ))
(check-by-interp '(module (define L.fn.0.1 (lambda (bat.3.2 bar.9.1) #f))
                          (define L.func.1.2 (lambda (foobar.4.4 bar.8.3) bar.8.3))
                    #t))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (foobar.4.6 foo.8.5 bar.0.4 foobar.3.3 bar.9.2 bat.7.1) #t))
                          (call eq? #\m 233919391)
                    ))
(check-by-interp '(module (define L.x.0.1 (lambda (bat.7.2 foobar.0.1) 1))
                          (define L.func.1.2 (lambda (bat.6.5 bar.1.4 foobar.2.3) #t))
                    (void)))
(check-by-interp '(module (define L.func.0.1 (lambda (foobar.0.3 ball.4.2 foo.8.1) ball.4.2))
                          (let ([bar.3.6 #f]
                                [ball.4.5 empty]
                                [foo.1.4 empty])
                            0)
                    ))
(check-by-interp '(module (define L.func.0.1
                            (lambda (foobar.8.5 foo.9.4 foobar.2.3 bar.6.2 foobar.0.1) #f))
                          (define L.proc.1.2 (lambda (bar.6.6) bar.6.6))
                    #f))
(check-by-interp '(module (define L.fn.0.1 (lambda (bat.7.2 foobar.4.1) foobar.4.1))
                          (let ([bar.3.6 (void)]
                                [bar.9.5 empty]
                                [foobar.2.4 0]
                                [foo.5.3 0])
                            #t)
                    ))
(check-by-interp '(module (define L.x.0.1 (lambda () empty))
                          (define L.proc.1.2
                            (lambda (bat.2.7 bat.4.6 ball.0.5 foobar.9.4 foo.3.3 ball.1.2 foobar.8.1)
                              #t))
                    #\r))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (bat.3.5 bat.0.4 foobar.6.3 foobar.9.2 foobar.1.1) bat.0.4))
                          (define L.proc.1.2 (lambda (bar.7.7 bat.0.6) #f))
                    empty))
(check-by-interp '(module (define L.tmp.0.1
                            (lambda (ball.2.5 foobar.3.4 foo.9.3 foo.6.2 bat.4.1) foobar.3.4))
                          (define L.x.1.2 (lambda (bat.8.6) #f))
                    (if #\e
                        (void)
                        empty)))
(check-by-interp '(module (define L.x.0.1 (lambda (ball.0.1) ball.0.1))
                          (define L.tmp.1.2
                            (lambda (foo.1.8 bat.2.7 bat.9.6 foo.4.5 ball.5.4 bat.6.3 bat.7.2) 0))
                    (call void? #\3)))
(check-by-interp '(module (define L.fn.0.1 (lambda () (void)))
                          (define L.fn.1.2 (lambda (ball.8.4 foo.1.3 bar.7.2 foo.4.1) foo.4.1))
                    (define L.tmp.2.3 (lambda (bat.2.5) bat.2.5))
                    #t))
(check-by-interp '(module (define L.func.0.1
                            (lambda (foobar.3.5 ball.2.4 ball.1.3 foobar.8.2 ball.9.1) #f))
                          (define L.func.1.2 (lambda (ball.0.8 foobar.8.7 ball.5.6) #\X))
                    (void)))
(check-by-interp '(module (define L.proc.0.1 (lambda (ball.8.2 ball.9.1) #\l))
                          (define L.fn.1.2
                            (lambda (bar.0.7 ball.3.6 ball.8.5 ball.9.4 foobar.5.3) #t))
                    (call boolean? empty)))
(check-by-interp '(module (let ([foo.4.3 (call eq? empty 0)]
                                [foobar.1.2 #f]
                                [ball.5.1 253953304])
                            (let ([ball.5.4 (if #t
                                                (void)
                                                foo.4.3)])
                              (call ascii-char? ball.5.4)))))
(check-by-interp '(module (define L.fn.0.1 (lambda (foo.4.3 bat.8.2 bat.6.1) bat.8.2))
                          (define L.x.1.2 (lambda (foobar.3.4) empty))
                    (define L.func.2.3 (lambda () #f))
                    (if (void)
                        (void)
                        #\r)))
(check-by-interp '(module (define L.func.0.1
                            (lambda (foobar.8.5 ball.0.4 foobar.2.3 foobar.6.2 bat.9.1) #f))
                          (define L.func.1.2 (lambda (foobar.2.7 foo.1.6) foobar.2.7))
                    (call ascii-char? #f)))
(check-by-interp
 '(module (define L.proc.0.1
            (lambda (ball.4.7 foobar.7.6 foo.6.5 bar.9.4 bat.3.3 foobar.0.2 ball.8.1) #t))
          (define L.x.1.2 (lambda (bat.3.12 bar.9.11 foo.1.10 ball.4.9 bar.5.8) foo.1.10))
    #f))
(check-by-interp '(module (define L.func.0.1 (lambda (foobar.4.5 bar.8.4 bat.7.3 bar.1.2 foo.9.1) #t))
                          (define L.func.1.2 (lambda (foobar.3.9 foo.6.8 foobar.4.7 bar.1.6) #f))
                    (call ascii-char? #\P)))
(check-by-interp '(module (define L.x.0.1 (lambda (ball.3.1) 0))
                          (define L.proc.1.2
                            (lambda (bat.1.6 foobar.8.5 foobar.5.4 ball.3.3 bat.7.2) foobar.5.4))
                    (let ([bat.7.8 empty]
                          [foobar.2.7 #f])
                      empty)))
(check-by-interp
 '(module (define L.tmp.0.1 (lambda (ball.3.5 bat.8.4 foobar.7.3 bar.6.2 bar.5.1) bar.5.1))
          (define L.tmp.1.2
            (lambda (bat.2.12 foobar.4.11 bar.6.10 foobar.7.9 bar.5.8 ball.3.7 foo.9.6) 0))
    (call boolean? (void))))
(check-by-interp '(module (define L.x.0.1 (lambda (foo.8.4 foobar.6.3 bat.0.2 ball.7.1) ball.7.1))
                          (define L.fn.1.2
                            (lambda (bat.3.11 foobar.9.10 foobar.5.9 foo.8.8 bat.4.7 ball.7.6 foo.2.5)
                              -441245769))
                    (call ascii-char? (void))))
(check-by-interp '(module (define L.proc.0.1 (lambda (foo.9.2 foo.0.1) #t))
                          (define L.fn.1.2 (lambda (bat.3.5 bat.1.4 bat.7.3) bat.1.4))
                    (define L.func.2.3 (lambda (foo.2.7 foo.9.6) 0))
                    (let ([foo.9.8 #t]) (call * 513154086 1))))
(check-by-interp '(module (define L.proc.0.1 (lambda (foobar.1.5 foo.5.4 bat.4.3 foo.2.2 bat.0.1) #t))
                          (define L.tmp.1.2 (lambda (bat.0.6) #t))
                    (define L.x.2.3
                      (lambda (ball.9.13 bar.7.12 bat.4.11 foo.2.10 foobar.1.9 foo.3.8 foo.6.7) #f))
                    0))
(check-by-interp '(module (define L.fn.0.1
                            (lambda (foobar.4.6 foo.3.5 bar.0.4 foo.7.3 bar.8.2 foobar.2.1) empty))
                          (define L.proc.1.2 (lambda (foo.7.9 foo.3.8 bar.0.7) #t))
                    (define L.x.2.3 (lambda (foobar.2.11 bar.8.10) foobar.2.11))
                    empty))
(check-by-interp
 '(module (define L.tmp.0.1
            (lambda (bar.2.7 foobar.0.6 foobar.9.5 ball.1.4 bat.3.3 bar.4.2 ball.8.1) foobar.0.6))
          (define L.x.1.2
            (lambda (foobar.0.14 bar.2.13 bar.4.12 ball.6.11 ball.5.10 bat.3.9 foobar.9.8) #f))
    (call empty? 1)))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (foobar.8.7 foobar.2.6 bat.9.5 bar.6.4 bar.3.3 foobar.0.2 bar.4.1)
                              1))
                          (define L.func.1.2 (lambda () #t))
                    (define L.fn.2.3 (lambda (foobar.7.10 ball.1.9 foobar.0.8) ball.1.9))
                    (if #f #t empty)))
(check-by-interp
 '(module (define L.fn.0.1
            (lambda (foobar.3.7 bar.4.6 bat.6.5 foo.9.4 ball.0.3 foobar.5.2 foobar.8.1) bat.6.5))
          (define L.tmp.1.2 (lambda (ball.1.8) ball.1.8))
    (define L.tmp.2.3 (lambda (foobar.8.11 foobar.5.10 ball.0.9) #f))
    (call ascii-char? 1)))
(check-by-interp '(module (define L.tmp.0.1 (lambda (foo.4.3 bar.6.2 foobar.0.1) bar.6.2))
                          (define L.fn.1.2 (lambda (foo.1.7 ball.9.6 foobar.3.5 bat.2.4) foo.1.7))
                    (define L.x.2.3
                      (lambda (bar.6.13 bat.2.12 foobar.7.11 foo.1.10 ball.9.9 foobar.0.8) 1))
                    (call boolean? #f)))
(check-by-interp '(module (define L.tmp.0.1
                            (lambda (bat.9.7 bar.0.6 bat.4.5 bar.8.4 bar.2.3 bar.5.2 ball.3.1)
                              bar.5.2))
                          (define L.x.1.2 (lambda (ball.3.12 bar.0.11 foo.7.10 bar.8.9 bar.5.8) 0))
                    (define L.func.2.3 (lambda (foo.7.16 bar.2.15 bar.8.14 foobar.1.13) 1))
                    (call ascii-char? empty)))
(check-by-interp '(module (define L.proc.0.1 (lambda (bat.2.4 ball.8.3 foobar.7.2 foo.1.1) #t))
                          (define L.proc.1.2
                            (lambda (bat.5.9 foo.6.8 foobar.3.7 foobar.7.6 bat.0.5) #f))
                    (define L.x.2.3 (lambda (bar.4.12 foobar.3.11 bar.9.10) 0))
                    (let ([bat.5.13 (call eq? 1 #f)]) (call < -278642811 1))))
(check-by-interp
 '(module (define L.proc.0.1 (lambda (foo.9.6 ball.5.5 ball.4.4 bar.8.3 ball.1.2 bat.7.1) #f))
          (define L.proc.1.2 (lambda (bar.0.8 foo.6.7) #f))
    (define L.fn.2.3 (lambda (ball.5.15 bar.8.14 foo.9.13 bat.7.12 ball.1.11 foo.6.10 bar.0.9) #t))
    (if (void)
        (let ([ball.1.16 (call empty? #f)]) ball.1.16)
        1)))
(check-by-interp
 '(module (define L.x.0.1
            (lambda (bar.0.7 foobar.1.6 bat.4.5 foobar.5.4 foo.8.3 bat.9.2 bat.2.1) bar.0.7))
          (define L.tmp.1.2 (lambda (foobar.3.13 foobar.1.12 bat.9.11 foobar.5.10 bar.6.9 bat.4.8) 0))
    (define L.tmp.2.3
      (lambda (bat.2.20 foobar.3.19 bar.0.18 foobar.5.17 bar.6.16 ball.7.15 foo.8.14) #f))
    (call fixnum? #f)))
(check-by-interp
 '(module (define L.tmp.0.1 (lambda (foo.3.6 foo.0.5 ball.9.4 ball.1.3 ball.6.2 foobar.5.1) foo.3.6))
          (define L.x.1.2 (lambda (foobar.5.11 ball.7.10 foo.3.9 ball.1.8 ball.6.7) 296261657))
    (define L.tmp.2.3 (lambda (ball.6.15 ball.7.14 foo.2.13 foobar.5.12) ball.6.15))
    (let ([foobar.8.18 empty]
          [ball.6.17 empty]
          [foo.0.16 #\L])
      #\r)))
(check-by-interp
 '(module (define L.fn.0.1 (lambda (ball.6.7 bar.9.6 bat.8.5 ball.7.4 bat.4.3 bar.1.2 foobar.5.1) 1))
          (define L.proc.1.2
            (lambda (foobar.5.14 bar.1.13 ball.7.12 bat.8.11 bat.4.10 ball.3.9 ball.6.8) ball.7.12))
    (define L.x.2.3 (lambda (ball.6.20 bar.9.19 ball.3.18 foobar.5.17 ball.7.16 bat.8.15) #f))
    (let ([ball.3.24 (void)]
          [foobar.5.23 #\T]
          [foo.2.22 empty]
          [ball.6.21 empty])
      ball.6.21)))
;;; Added by Trevor on 2026-03-19
