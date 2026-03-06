#lang racket

(require cpsc411/compiler-lib)
(provide uncover-locals)

;; redisigning to pass around locals instead of using global mutable state
#;(define (uncover-locals al2)
    ; (displayln "running uncover-locals")
    (define locals '())
    (define (uncover-aloc aloc)
      (set! locals (set-union locals `(,aloc)))
      aloc)
    (define (uncover-triv triv)
      (match triv
        [(? int64?) triv]
        [(? aloc?) (uncover-aloc triv)]))
    (define (uncover-pred pred)
      (match pred
        [`(,relop ,aloc ,triv)
         #:when (memq relop '(< <= = >= > !=))
         `(,relop ,(uncover-aloc aloc) ,(uncover-triv triv))]
        [`(true) pred]
        [`(false) pred]
        [`(not ,pred) `(not ,(uncover-pred pred))]
        [`(begin
            ,fxs ...
            ,pred)
         (append '(begin) (map uncover-effect fxs) (list (uncover-pred pred)))]
        [`(if ,pred1 ,pred2 ,pred3)
         `(if ,(uncover-pred pred1)
              ,(uncover-pred pred2)
              ,(uncover-pred pred3))]))

    (define (uncover-effect effect)
      (match effect
        [`(set! ,aloc (,binop ,aloc ,triv))
         `(set! ,(uncover-aloc aloc) (,binop ,aloc ,(uncover-triv triv)))]
        [`(set! ,aloc ,triv) `(set! ,(uncover-aloc aloc) ,(uncover-triv triv))]
        [`(begin
            ,fxs ...
            ,fx)
         (append '(begin) (map uncover-effect fxs) (list (uncover-effect fx)))]
        [`(if ,pred ,effect1 ,effect2)
         `(if ,(uncover-pred pred)
              ,(uncover-effect effect1)
              ,(uncover-effect effect2))]))
    (define (uncover-tail tail)
      (match tail
        [`(begin
            ,fxs ...
            ,tail)
         (append '(begin) (map uncover-effect fxs) (list (uncover-tail tail)))]
        [`(halt ,triv) `(halt ,(uncover-triv triv))]
        [`(if ,pred ,tail1 ,tail2)
         `(if ,(uncover-pred pred)
              ,(uncover-tail tail1)
              ,(uncover-tail tail2))]))
    (define (uncover-p p)
      (match p
        [`(module ,info ,definitions
            ...
            ,tail)

         (let ([utail (uncover-tail tail)])
           `(module ,(info-set info 'locals locals) ,utail
              ))]))
    (uncover-p al2))

;; asm-pred-lang-v5 p -> asm-pred-lang-v5/locals p
;; Compiles Asm-pred-lang v5 to Asm-pred-lang v5/locals,
;; analysing which abstract locations are used in each block,
;; and updating each block and the module with the set of variables
;; in an info? fields.
(define (uncover-locals p)

  (define (uncover-defintiions def)
    (match def
      [`(define ,label
          ,info
          ,tail)
       `(define ,label
          ,(info-set info 'locals (set->list (uncover-tail tail)))
          ,tail)]))

  (define (uncover-triv triv)
    (match triv
      [(? int64?) (set)]
      [(? aloc?) (set triv)]))

  (define (uncover-loc loc)
    (match loc
      [(? aloc?) (set loc)]
      [_ (set)]))

  (define (uncover-pred pred)
    (match pred
      [`(,relop ,loc ,triv)
       #:when (memq relop '(< <= = >= > !=))
       (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(true) (set)]
      [`(false) (set)]
      [`(not ,p) (uncover-pred p)]
      [`(begin
          ,fxs ...
          ,p)
       (set-union (uncover-effects fxs) (uncover-pred p))]
      [`(if ,p1 ,p2 ,p3) (set-union (uncover-pred p1) (uncover-pred p2) (uncover-pred p3))]))

  (define (uncover-effect effect)
    (match effect
      [`(set! ,loc (,binop ,loc ,triv)) (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(set! ,loc ,triv) (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(begin
          ,fxs ...
          ,fx)
       (set-union (uncover-effects fxs) (uncover-effect fx))]
      [`(if ,pred ,e1 ,e2) (set-union (uncover-pred pred) (uncover-effect e1) (uncover-effect e2))]))

  (define (uncover-effects fxs)
    (for/fold ([locals (set)]) ([fx fxs])
      (set-union locals (uncover-effect fx))))

  (define (uncover-tail tail)
    (match tail
      [`(begin
          ,fxs ...
          ,t)
       (set-union (uncover-effects fxs) (uncover-tail t))]
      [`(halt ,triv) (uncover-triv triv)]
      [`(if ,pred ,t1 ,t2) (set-union (uncover-pred pred) (uncover-tail t1) (uncover-tail t2))]
      [`(jump ,trg ,loc ...) (foldr (lambda (cur acc) (set-union (uncover-loc cur) acc)) (set) loc)]))

  (define (uncover-p p)
    (match p
      [`(module ,info ,definitions
          ...
          ,tail)
       `(module ,(info-set info 'locals (set->list (uncover-tail tail)))
                ,@(map uncover-defintiions definitions)
          ,tail)]))
  (uncover-p p))

(module+ test
  (require rackunit
           cpsc411/langs/v5)
  (define-syntax-rule (check-by-interp asmplv5)
    (check-equal? (interp-asm-pred-lang-v5 asmplv5)
                  (interp-asm-pred-lang-v5/locals (uncover-locals asmplv5))))

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp '(module ()
                            (define L.L.func.0.1.4
                              ()
                              (halt 0))
                      (define L.L.tmp.1.2.5
                        ()
                        (begin
                          (set! foo.2.1.5 rdi)
                          (jump L.L.func.0.1.4 rbp)))
                      (define L.L.func.2.3.6
                        ()
                        (begin
                          (if (true)
                              (begin
                                (set! foo.2.3.7 1)
                                (set! bar.4.2.6 foo.2.3.7))
                              (begin
                                (set! tmp.9 -9223372036854775808)
                                (set! tmp.9 (* tmp.9 1806293504))
                                (set! bar.4.2.6 tmp.9)))
                          (if (begin
                                (set! tmp.10 1)
                                (> tmp.10 0))
                              (set! foobar.6.4.8 156890122)
                              (set! foobar.6.4.8 bar.4.2.6))
                          (halt 0)))
                      (begin
                        (set! rdi -1860620182)
                        (jump L.L.tmp.1.2.5 rbp rdi))))
  (check-by-interp '(module ()
                            (define L.L.tmp.0.1.4
                              ()
                              (if (begin
                                    (set! tmp.9 9223372036854775807)
                                    (>= tmp.9 -1020514810))
                                  (jump L.L.x.2.3.6 rbp)
                                  (begin
                                    (set! tmp.11 1)
                                    (set! tmp.11 (* tmp.11 0))
                                    (set! tmp.10 tmp.11)
                                    (halt tmp.10))))
                      (define L.L.func.1.2.5
                        ()
                        (begin
                          (set! bar.1.1.5 -9223372036854775808)
                          (if (not (begin
                                     (set! tmp.12 9223372036854775807)
                                     (> tmp.12 0)))
                              (halt 1309557052)
                              (halt bar.1.1.5))))
                      (define L.L.x.2.3.6
                        ()
                        (if (if (true)
                                (not (begin
                                       (set! tmp.13 0)
                                       (> tmp.13 1)))
                                (true))
                            (if (begin
                                  (set! tmp.14 0)
                                  (> tmp.14 0))
                                (if (begin
                                      (set! tmp.15 9223372036854775807)
                                      (< tmp.15 9223372036854775807))
                                    (halt 9223372036854775807)
                                    (halt -260353756))
                                (begin
                                  (set! ball.0.2.6 0)
                                  (halt ball.0.2.6)))
                            (begin
                              (if (begin
                                    (set! tmp.16 -302047143)
                                    (!= tmp.16 0))
                                  (set! bar.3.3.7 9223372036854775807)
                                  (set! bar.3.3.7 102036653))
                              (if (begin
                                    (set! tmp.17 0)
                                    (= tmp.17 bar.3.3.7))
                                  (halt bar.3.3.7)
                                  (halt -362331747)))))
                      (begin
                        (set! tmp.18 -9223372036854775808)
                        (set! tmp.18 (* tmp.18 -9223372036854775808))
                        (set! ball.0.4.8 tmp.18)
                        (set! tmp.20 ball.0.4.8)
                        (set! tmp.20 (+ tmp.20 0))
                        (set! tmp.19 tmp.20)
                        (halt tmp.19))))
  (check-by-interp '(module ()
                            (define L.L.proc.0.1.4
                              ()
                              (begin
                                (set! ball.6.1.5 rdi)
                                (jump L.L.func.1.2.5 rbp)))
                      (define L.L.func.1.2.5
                        ()
                        (begin
                          (set! tmp.10 1)
                          (set! tmp.10 (* tmp.10 0))
                          (set! tmp.9 tmp.10)
                          (halt tmp.9)))
                      (define L.L.fn.2.3.6
                        ()
                        (begin
                          (set! ball.3.2.6 rdi)
                          (if (true)
                              (begin
                                (if (begin
                                      (set! tmp.11 -2033705372)
                                      (<= tmp.11 965540822))
                                    (set! bat.0.3.7 -1853172774)
                                    (set! bat.0.3.7 1133506028))
                                (set! foo.4.4.8 1)
                                (halt 1236904416))
                              (jump L.L.func.1.2.5 rbp))))
                      (begin
                        (set! rdi 1)
                        (jump L.L.proc.0.1.4 rbp rdi))))
  (check-by-interp '(module ()
                            (define L.fn.0.1
                              ()
                              (begin
                                (if (false)
                                    (set! bat.9.1 1)
                                    (begin
                                      (set! foo.5.2 1)
                                      (set! bat.9.1 1)))
                                (if (if (begin
                                          (set! tmp.5 9223372036854775807)
                                          (>= tmp.5 -9223372036854775808))
                                        (begin
                                          (set! tmp.6 -248968641)
                                          (= tmp.6 9223372036854775807))
                                        (!= bat.9.1 -9223372036854775808))
                                    (begin
                                      (set! ball.4.3 bat.9.1)
                                      (halt 1622965009))
                                    (begin
                                      (set! foo.5.4 bat.9.1)
                                      (halt bat.9.1)))))
                      (if (false)
                          (if (begin
                                (set! tmp.7 995853130)
                                (>= tmp.7 1))
                              (halt 1)
                              (halt -9223372036854775808))
                          (jump L.fn.0.1 rbp))))
  (check-by-interp '(module ()
                            (begin
                              (set! tmp.2 -9223372036854775808)
                              (set! tmp.2 (+ tmp.2 -1465538260))
                              (set! tmp.1 tmp.2)
                              (halt tmp.1))
                      ))
  (check-by-interp '(module ()
                            (define L.fn.0.1
                              ()
                              (begin
                                (set! tmp.10 1)
                                (set! tmp.10 (+ tmp.10 9223372036854775807))
                                (set! bar.2.1 tmp.10)
                                (set! foo.1.3 bar.2.1)
                                (set! foo.8.2 foo.1.3)
                                (halt bar.2.1)))
                      (define L.func.1.2
                        ()
                        (begin
                          (if (begin
                                (set! foo.8.5 1)
                                (begin
                                  (set! tmp.11 1)
                                  (< tmp.11 foo.8.5)))
                              (begin
                                (set! foo.1.6 406779451)
                                (set! ball.3.4 1200977699))
                              (begin
                                (set! foo.8.7 0)
                                (set! ball.3.4 foo.8.7)))
                          (set! tmp.13 ball.3.4)
                          (set! tmp.13 (* tmp.13 ball.3.4))
                          (set! tmp.12 tmp.13)
                          (halt tmp.12)))
                      (begin
                        (set! bat.5.8 1)
                        (set! ball.9.9 0)
                        (halt bat.5.8))))
  (check-by-interp '(module ()
                            (define L.x.0.1
                              ()
                              (begin
                                (set! ball.1.2 rdi)
                                (set! foo.0.1 rsi)
                                (jump L.tmp.1.2 rbp)))
                      (define L.tmp.1.2
                        ()
                        (if (if (if (begin
                                      (set! tmp.8 -765445006)
                                      (<= tmp.8 0))
                                    (begin
                                      (set! tmp.9 0)
                                      (!= tmp.9 -7399083))
                                    (begin
                                      (set! tmp.10 9223372036854775807)
                                      (<= tmp.10 1)))
                                (false)
                                (true))
                            (begin
                              (set! bar.5.4 -9223372036854775808)
                              (set! ball.4.3 bar.5.4)
                              (if (> ball.4.3 ball.4.3)
                                  (halt -9223372036854775808)
                                  (halt ball.4.3)))
                            (begin
                              (if (begin
                                    (set! tmp.11 1)
                                    (>= tmp.11 0))
                                  (set! foobar.9.5 -9223372036854775808)
                                  (set! foobar.9.5 -9223372036854775808))
                              (if (begin
                                    (set! tmp.12 0)
                                    (= tmp.12 foobar.9.5))
                                  (halt 0)
                                  (halt 9223372036854775807)))))
                      (define L.func.2.3
                        ()
                        (begin
                          (set! ball.4.7 rdi)
                          (set! ball.6.6 rsi)
                          (jump L.tmp.1.2 rbp)))
                      (if (begin
                            (set! tmp.13 0)
                            (<= tmp.13 1))
                          (halt -1271132888)
                          (halt 2101306416))))
  (check-by-interp '(module ()
                            (define L.proc.0.1
                              ()
                              (begin
                                (set! bar.8.1 rdi)
                                (if (false)
                                    (begin
                                      (set! bat.4.3 bar.8.1)
                                      (set! bat.7.2 1733388107))
                                    (begin
                                      (set! foobar.2.4 -818241658)
                                      (set! bat.7.2 foobar.2.4)))
                                (set! tmp.6 -1769976594)
                                (set! tmp.6 (* tmp.6 bat.7.2))
                                (set! bat.3.5 tmp.6)
                                (if (!= bar.8.1 bar.8.1)
                                    (halt 1)
                                    (halt bar.8.1))))
                      (if (begin
                            (set! tmp.7 0)
                            (<= tmp.7 0))
                          (halt 1764584349)
                          (halt -9223372036854775808))))
  (check-by-interp '(module ()
                            (define L.proc.0.1
                              ()
                              (begin
                                (set! ball.3.1 rdi)
                                (if (not (false))
                                    (jump L.x.1.2 rbp)
                                    (begin
                                      (set! bat.9.3 ball.3.1)
                                      (set! foobar.4.2 9223372036854775807)
                                      (set! tmp.7 -9223372036854775808)
                                      (set! tmp.7 (+ tmp.7 ball.3.1))
                                      (set! tmp.6 tmp.7)
                                      (halt tmp.6)))))
                      (define L.x.1.2
                        ()
                        (halt 1))
                      (begin
                        (set! ball.1.5 453798193)
                        (set! foobar.4.4 ball.1.5)
                        (if (begin
                              (set! tmp.8 9223372036854775807)
                              (>= tmp.8 foobar.4.4))
                            (halt 0)
                            (halt -1617493587)))))
  (check-by-interp '(module ()
                            (define L.func.0.1
                              ()
                              (begin
                                (set! bat.8.1 rdi)
                                (if (begin
                                      (begin
                                        (set! tmp.3 9223372036854775807)
                                        (set! tmp.3 (* tmp.3 bat.8.1))
                                        (set! bat.2.2 tmp.3))
                                      (true))
                                    (if (true)
                                        (if (< bat.8.1 -9223372036854775808)
                                            (halt bat.8.1)
                                            (halt bat.8.1))
                                        (if (begin
                                              (set! tmp.4 -9223372036854775808)
                                              (= tmp.4 bat.8.1))
                                            (halt bat.8.1)
                                            (halt bat.8.1)))
                                    (jump L.proc.1.2 rbp))))
                      (define L.proc.1.2
                        ()
                        (begin
                          (set! rdi 954069433)
                          (jump L.func.0.1 rbp rdi)))
                      (if (false)
                          (begin
                            (set! tmp.6 1337690701)
                            (set! tmp.6 (* tmp.6 9223372036854775807))
                            (set! tmp.5 tmp.6)
                            (halt tmp.5))
                          (jump L.proc.1.2 rbp))))
  (check-by-interp '(module ((locals (tmp.2 tmp.1)))
                            (if (not (begin
                                       (set! tmp.1 1)
                                       (> tmp.1 9223372036854775807)))
                                (if (begin
                                      (set! tmp.2 1)
                                      (>= tmp.2 1197468889))
                                    (halt 9223372036854775807)
                                    (halt 1))
                                (halt 1))
                      ))
  (check-by-interp '(module ()
                            (define L.func.0.1
                              ()
                              (begin
                                (set! foo.9.5 rdi)
                                (set! foo.2.4 rsi)
                                (set! bar.1.3 rdx)
                                (set! bat.7.2 rcx)
                                (set! foobar.4.1 r8)
                                (halt -1458025903)))
                      (begin
                        (set! r8 0)
                        (set! rcx -9223372036854775808)
                        (set! rdx -808937821)
                        (set! rsi 1)
                        (set! rdi -9223372036854775808)
                        (jump L.func.0.1 rbp rdi rsi rdx rcx r8))))
  (check-by-interp '(module ()
                            (define L.tmp.0.1
                              ()
                              (begin
                                (set! ball.6.4 rdi)
                                (set! bat.5.3 rsi)
                                (set! bar.8.2 rdx)
                                (set! foobar.0.1 rcx)
                                (set! bat.2.5 ball.6.4)
                                (if (if (begin
                                          (set! tmp.7 -9223372036854775808)
                                          (<= tmp.7 bat.5.3))
                                        (begin
                                          (set! tmp.8 -9223372036854775808)
                                          (>= tmp.8 ball.6.4))
                                        (>= bat.5.3 2025307007))
                                    (begin
                                      (set! tmp.10 bat.2.5)
                                      (set! tmp.10 (+ tmp.10 9223372036854775807))
                                      (set! tmp.9 tmp.10)
                                      (halt tmp.9))
                                    (if (<= bat.5.3 -9223372036854775808)
                                        (halt 9223372036854775807)
                                        (halt 0)))))
                      (begin
                        (set! ball.6.6 0)
                        (halt ball.6.6))))
  (check-by-interp '(module ()
                            (define L.func.0.1
                              ()
                              (begin
                                (set! ball.6.2 rdi)
                                (set! foobar.3.1 rsi)
                                (if (begin
                                      (set! tmp.12 0)
                                      (= tmp.12 foobar.3.1))
                                    (begin
                                      (set! tmp.14 -9223372036854775808)
                                      (set! tmp.14 (+ tmp.14 -9223372036854775808))
                                      (set! tmp.13 tmp.14)
                                      (halt tmp.13))
                                    (if (if (< ball.6.2 ball.6.2)
                                            (<= foobar.3.1 foobar.3.1)
                                            (= foobar.3.1 ball.6.2))
                                        (begin
                                          (set! tmp.16 foobar.3.1)
                                          (set! tmp.16 (+ tmp.16 foobar.3.1))
                                          (set! tmp.15 tmp.16)
                                          (halt tmp.15))
                                        (if (begin
                                              (set! tmp.17 1)
                                              (= tmp.17 foobar.3.1))
                                            (halt ball.6.2)
                                            (halt foobar.3.1))))))
                      (define L.x.1.2
                        ()
                        (begin
                          (set! bar.0.3 rdi)
                          (set! bat.2.6 1757280127)
                          (set! bat.9.5 bat.2.6)
                          (set! ball.5.7 1)
                          (set! ball.1.4 -1128483887)
                          (if (begin
                                (set! foo.7.8 bar.0.3)
                                (> foo.7.8 foo.7.8))
                              (halt ball.1.4)
                              (begin
                                (set! tmp.19 ball.1.4)
                                (set! tmp.19 (+ tmp.19 bar.0.3))
                                (set! tmp.18 tmp.19)
                                (halt tmp.18)))))
                      (define L.fn.2.3
                        ()
                        (if (begin
                              (begin
                                (set! tmp.20 -9223372036854775808)
                                (set! tmp.20 (+ tmp.20 -1421853645))
                                (set! foobar.8.9 tmp.20))
                              (not (begin
                                     (set! tmp.21 0)
                                     (>= tmp.21 -1400373009))))
                            (begin
                              (set! tmp.23 -167927521)
                              (set! tmp.23 (+ tmp.23 1))
                              (set! tmp.22 tmp.23)
                              (halt tmp.22))
                            (begin
                              (set! tmp.24 1041085683)
                              (set! tmp.24 (* tmp.24 9223372036854775807))
                              (set! ball.1.10 tmp.24)
                              (set! foo.4.11 ball.1.10)
                              (halt 770292232))))
                      (begin
                        (set! rdi 1840464414)
                        (jump L.x.1.2 rbp rdi))))
  (check-by-interp '(module ()
                            (define L.proc.0.1
                              ()
                              (begin
                                (set! ball.4.3 rdi)
                                (set! foo.7.2 rsi)
                                (set! ball.2.1 rdx)
                                (set! rdx foo.7.2)
                                (set! rsi ball.2.1)
                                (set! rdi 9223372036854775807)
                                (jump L.proc.0.1 rbp rdi rsi rdx)))
                      (define L.func.1.2
                        ()
                        (begin
                          (set! ball.1.9 rdi)
                          (set! bat.0.8 rsi)
                          (set! foo.7.7 rdx)
                          (set! ball.4.6 rcx)
                          (set! foobar.6.5 r8)
                          (set! bar.3.4 r9)
                          (set! ball.4.11 foo.7.7)
                          (set! foobar.5.12 ball.1.9)
                          (set! bar.3.10 -9223372036854775808)
                          (set! rdx bar.3.10)
                          (set! rsi -780648786)
                          (set! rdi bar.3.10)
                          (jump L.proc.0.1 rbp rdi rsi rdx)))
                      (begin
                        (set! bat.0.13 -579691794)
                        (halt 953357957))))
  (check-by-interp '(module ()
                            (begin
                              (set! ball.2.2 9223372036854775807)
                              (set! bar.5.1 -546026276)
                              (if (!= bar.5.1 1)
                                  (halt 9223372036854775807)
                                  (halt 2063023986)))
                      ))
  (check-by-interp '(module ()
                            (define L.func.0.1
                              ()
                              (begin
                                (set! foo.8.2 rdi)
                                (set! bar.2.1 rsi)
                                (if (not (begin
                                           (set! foo.8.3 foo.8.2)
                                           (= foo.8.3 0)))
                                    (begin
                                      (set! tmp.6 foo.8.2)
                                      (set! tmp.6 (+ tmp.6 0))
                                      (set! foobar.6.4 tmp.6)
                                      (set! tmp.8 0)
                                      (set! tmp.8 (* tmp.8 9223372036854775807))
                                      (set! tmp.7 tmp.8)
                                      (halt tmp.7))
                                    (begin
                                      (set! tmp.9 0)
                                      (set! tmp.9 (* tmp.9 bar.2.1))
                                      (set! bat.7.5 tmp.9)
                                      (if (!= bat.7.5 -9223372036854775808)
                                          (halt bar.2.1)
                                          (halt 0))))))
                      (if (begin
                            (set! tmp.10 9223372036854775807)
                            (= tmp.10 -315897602))
                          (halt 1)
                          (halt -9223372036854775808))))
  (check-by-interp '(module ()
                            (define L.fn.0.1
                              ()
                              (begin
                                (set! foobar.3.2 rdi)
                                (set! ball.7.1 rsi)
                                (set! tmp.15 1)
                                (set! tmp.15 (* tmp.15 9223372036854775807))
                                (set! bat.4.4 tmp.15)
                                (set! tmp.16 -9223372036854775808)
                                (set! tmp.16 (+ tmp.16 bat.4.4))
                                (set! bar.9.3 tmp.16)
                                (set! bat.4.5 9223372036854775807)
                                (if (begin
                                      (set! tmp.17 1)
                                      (!= tmp.17 bar.9.3))
                                    (halt 9223372036854775807)
                                    (halt ball.7.1))))
                      (define L.x.1.2
                        ()
                        (begin
                          (set! bat.2.6 rdi)
                          (set! tmp.18 -1410706204)
                          (set! tmp.18 (+ tmp.18 bat.2.6))
                          (set! bat.4.8 tmp.18)
                          (set! bat.2.9 1)
                          (set! foobar.3.7 -9223372036854775808)
                          (set! tmp.20 -152436426)
                          (set! tmp.20 (* tmp.20 0))
                          (set! tmp.19 tmp.20)
                          (halt tmp.19)))
                      (define L.proc.2.3
                        ()
                        (begin
                          (set! foo.5.13 rdi)
                          (set! ball.7.12 rsi)
                          (set! foo.0.11 rdx)
                          (set! ball.8.10 rcx)
                          (set! foobar.1.14 foo.5.13)
                          (set! tmp.22 956544411)
                          (set! tmp.22 (+ tmp.22 1))
                          (set! tmp.21 tmp.22)
                          (halt tmp.21)))
                      (begin
                        (set! tmp.24 979460199)
                        (set! tmp.24 (+ tmp.24 -1697959716))
                        (set! tmp.23 tmp.24)
                        (halt tmp.23))))
  (check-by-interp '(module ()
                            (define L.proc.0.1
                              ()
                              (begin
                                (set! foobar.1.6 rdi)
                                (set! bar.0.5 rsi)
                                (set! foobar.2.4 rdx)
                                (set! ball.8.3 rcx)
                                (set! bat.3.2 r8)
                                (set! bar.5.1 r9)
                                (if (begin
                                      (set! bar.7.8 -669410514)
                                      (< bat.3.2 bat.3.2))
                                    (begin
                                      (set! tmp.11 bar.5.1)
                                      (set! tmp.11 (+ tmp.11 ball.8.3))
                                      (set! bar.9.7 tmp.11))
                                    (set! bar.9.7 foobar.2.4))
                                (set! foo.4.10 ball.8.3)
                                (set! ball.6.9 1)
                                (if (<= foobar.2.4 1)
                                    (halt 9223372036854775807)
                                    (halt bat.3.2))))
                      (begin
                        (set! r9 9223372036854775807)
                        (set! r8 -1891086346)
                        (set! rcx -1371550930)
                        (set! rdx 0)
                        (set! rsi 9223372036854775807)
                        (set! rdi 0)
                        (jump L.proc.0.1 rbp rdi rsi rdx rcx r8 r9))))
  (check-by-interp '(module ()
                            (define L.x.0.1
                              ()
                              (begin
                                (set! bat.7.7 rdi)
                                (set! ball.9.6 rsi)
                                (set! foobar.3.5 rdx)
                                (set! ball.5.4 rcx)
                                (set! ball.4.3 r8)
                                (set! bar.0.2 r9)
                                (set! ball.2.1 fv0)
                                (if (not (if (begin
                                               (set! tmp.28 388494724)
                                               (>= tmp.28 ball.9.6))
                                             (> ball.5.4 -9223372036854775808)
                                             (< foobar.3.5 ball.5.4)))
                                    (if (<= ball.4.3 bar.0.2)
                                        (halt 0)
                                        (begin
                                          (set! ball.4.8 ball.5.4)
                                          (halt 1887946265)))
                                    (halt foobar.3.5))))
                      (define L.tmp.1.2
                        ()
                        (begin
                          (set! bat.7.14 rdi)
                          (set! ball.9.13 rsi)
                          (set! ball.5.12 rdx)
                          (set! foo.6.11 rcx)
                          (set! bar.0.10 r8)
                          (set! ball.2.9 r9)
                          (if (true)
                              (begin
                                (set! tmp.30 foo.6.11)
                                (set! tmp.30 (* tmp.30 9223372036854775807))
                                (set! tmp.29 tmp.30)
                                (halt tmp.29))
                              (if (begin
                                    (set! foobar.3.15 1)
                                    (<= bar.0.10 ball.5.12))
                                  (begin
                                    (set! ball.9.16 -9223372036854775808)
                                    (halt ball.9.16))
                                  (begin
                                    (set! bat.7.17 1)
                                    (halt 1))))))
                      (define L.tmp.2.3
                        ()
                        (begin
                          (set! bat.7.23 rdi)
                          (set! ball.2.22 rsi)
                          (set! foo.6.21 rdx)
                          (set! foobar.3.20 rcx)
                          (set! bar.8.19 r8)
                          (set! bar.0.18 r9)
                          (if (begin
                                (set! ball.2.25 258314756)
                                (!= bar.8.19 0))
                              (set! foobar.3.24 bar.8.19)
                              (begin
                                (set! foo.6.26 -1809848824)
                                (set! foobar.3.24 9223372036854775807)))
                          (if (begin
                                (set! tmp.31 1525021420)
                                (< tmp.31 1))
                              (begin
                                (set! r9 1067478227)
                                (set! r8 -768559462)
                                (set! rcx foo.6.21)
                                (set! rdx -1256996529)
                                (set! rsi 1)
                                (set! rdi foobar.3.24)
                                (jump L.tmp.1.2 rbp rdi rsi rdx rcx r8 r9))
                              (if (begin
                                    (set! tmp.32 389818959)
                                    (> tmp.32 882297114))
                                  (halt bar.8.19)
                                  (halt ball.2.22)))))
                      (begin
                        (set! bar.0.27 1)
                        (halt 1))))
  (check-by-interp '(module ()
                            (define L.tmp.0.1
                              ()
                              (begin
                                (set! foo.1.7 rdi)
                                (set! ball.6.6 rsi)
                                (set! bar.9.5 rdx)
                                (set! bat.3.4 rcx)
                                (set! ball.8.3 r8)
                                (set! bat.0.2 r9)
                                (set! ball.7.1 fv0)
                                (set! tmp.18 bat.3.4)
                                (set! tmp.18 (* tmp.18 bat.0.2))
                                (set! tmp.17 tmp.18)
                                (halt tmp.17)))
                      (define L.func.1.2
                        ()
                        (begin
                          (set! foo.1.12 rdi)
                          (set! bar.2.11 rsi)
                          (set! foo.5.10 rdx)
                          (set! bat.3.9 rcx)
                          (set! bar.9.8 r8)
                          (set! bat.3.13 1)
                          (halt 9223372036854775807)))
                      (define L.fn.2.3
                        ()
                        (begin
                          (set! ball.7.15 rdi)
                          (set! ball.8.14 rsi)
                          (if (>= ball.7.15 1)
                              (if (= ball.7.15 ball.7.15)
                                  (set! bat.3.16 ball.8.14)
                                  (set! bat.3.16 214741259))
                              (begin
                                (set! tmp.19 1683358713)
                                (set! tmp.19 (+ tmp.19 ball.8.14))
                                (set! bat.3.16 tmp.19)))
                          (set! fv0 -2043460455)
                          (set! r9 ball.7.15)
                          (set! r8 9223372036854775807)
                          (set! rcx ball.7.15)
                          (set! rdx 0)
                          (set! rsi ball.8.14)
                          (set! rdi bat.3.16)
                          (jump L.tmp.0.1 rbp rdi rsi rdx rcx r8 r9 fv0)))
                      (begin
                        (set! fv0 -9223372036854775808)
                        (set! r9 1)
                        (set! r8 -9223372036854775808)
                        (set! rcx 9223372036854775807)
                        (set! rdx -9223372036854775808)
                        (set! rsi -9223372036854775808)
                        (set! rdi -9223372036854775808)
                        (jump L.tmp.0.1 rbp rdi rsi rdx rcx r8 r9 fv0))))
  (check-by-interp '(module ()
                            (if (true)
                                (begin
                                  (set! tmp.2 1)
                                  (set! tmp.2 (+ tmp.2 -9223372036854775808))
                                  (set! tmp.1 tmp.2)
                                  (halt tmp.1))
                                (if (begin
                                      (set! tmp.3 1383245321)
                                      (> tmp.3 0))
                                    (halt 0)
                                    (halt 1)))
                      ))
  (check-by-interp '(module ()
                            (define L.x.0.1
                              ()
                              (begin
                                (set! ball.0.7 rdi)
                                (set! foobar.1.6 rsi)
                                (set! foo.3.5 rdx)
                                (set! foobar.2.4 rcx)
                                (set! foo.6.3 r8)
                                (set! foobar.5.2 r9)
                                (set! ball.8.1 fv0)
                                (set! rdi 1)
                                (jump L.x.4.5 rbp rdi)))
                      (define L.func.1.2
                        ()
                        (begin
                          (set! bar.9.8 9223372036854775807)
                          (set! foobar.1.9 bar.9.8)
                          (if (begin
                                (set! tmp.45 -577997854)
                                (>= tmp.45 foobar.1.9))
                              (halt -9223372036854775808)
                              (halt bar.9.8))))
                      (define L.fn.2.3
                        ()
                        (begin
                          (set! tmp.46 1)
                          (set! tmp.46 (+ tmp.46 1))
                          (set! ball.7.10 tmp.46)
                          (if (false)
                              (halt ball.7.10)
                              (begin
                                (set! foobar.1.11 ball.7.10)
                                (halt 1969054361)))))
                      (define L.x.3.4
                        ()
                        (begin
                          (set! foobar.4.18 rdi)
                          (set! foobar.5.17 rsi)
                          (set! bar.9.16 rdx)
                          (set! foobar.2.15 rcx)
                          (set! ball.8.14 r8)
                          (set! foo.3.13 r9)
                          (set! ball.7.12 fv0)
                          (set! fv0 -9223372036854775808)
                          (set! r9 foobar.4.18)
                          (set! r8 9223372036854775807)
                          (set! rcx 25911444)
                          (set! rdx 9223372036854775807)
                          (set! rsi -9223372036854775808)
                          (set! rdi 0)
                          (jump L.func.6.7 rbp rdi rsi rdx rcx r8 r9 fv0)))
                      (define L.x.4.5
                        ()
                        (begin
                          (set! foobar.4.19 rdi)
                          (set! fv0 foobar.4.19)
                          (set! r9 foobar.4.19)
                          (set! r8 foobar.4.19)
                          (set! rcx 1)
                          (set! rdx foobar.4.19)
                          (set! rsi foobar.4.19)
                          (set! rdi 0)
                          (jump L.x.3.4 rbp rdi rsi rdx rcx r8 r9 fv0)))
                      (define L.x.5.6
                        ()
                        (begin
                          (set! foo.6.25 rdi)
                          (set! foo.3.24 rsi)
                          (set! foobar.4.23 rdx)
                          (set! bar.9.22 rcx)
                          (set! foobar.1.21 r8)
                          (set! foobar.5.20 r9)
                          (set! foobar.1.27 bar.9.22)
                          (set! foo.6.28 foo.3.24)
                          (set! foobar.5.26 foobar.1.27)
                          (if (begin
                                (set! ball.8.29 bar.9.22)
                                (> foo.3.24 foo.6.25))
                              (begin
                                (set! fv0 -1819248150)
                                (set! r9 foobar.5.26)
                                (set! r8 foo.3.24)
                                (set! rcx foobar.5.26)
                                (set! rdx foobar.4.23)
                                (set! rsi 9223372036854775807)
                                (set! rdi -1863740769)
                                (jump L.x.0.1 rbp rdi rsi rdx rcx r8 r9 fv0))
                              (halt 1))))
                      (define L.func.6.7
                        ()
                        (begin
                          (set! foobar.2.36 rdi)
                          (set! foo.6.35 rsi)
                          (set! ball.0.34 rdx)
                          (set! ball.8.33 rcx)
                          (set! foo.3.32 r8)
                          (set! foobar.1.31 r9)
                          (set! foobar.5.30 fv0)
                          (if (if (true)
                                  (begin
                                    (set! ball.0.37 foobar.2.36)
                                    (begin
                                      (set! tmp.47 -1497437069)
                                      (> tmp.47 -9223372036854775808)))
                                  (not (begin
                                         (set! tmp.48 -1101838227)
                                         (!= tmp.48 -1416967818))))
                              (begin
                                (set! tmp.49 foobar.2.36)
                                (set! tmp.49 (+ tmp.49 foobar.2.36))
                                (set! ball.8.38 tmp.49)
                                (set! foobar.1.39 0)
                                (halt foobar.1.39))
                              (halt 1))))
                      (define L.fn.7.8
                        ()
                        (if (true)
                            (if (not (begin
                                       (set! tmp.50 0)
                                       (> tmp.50 100011461)))
                                (begin
                                  (set! r9 -1579752260)
                                  (set! r8 0)
                                  (set! rcx -1248542300)
                                  (set! rdx 0)
                                  (set! rsi 16140507)
                                  (set! rdi -9223372036854775808)
                                  (jump L.x.5.6 rbp rdi rsi rdx rcx r8 r9))
                                (if (begin
                                      (set! tmp.51 -9223372036854775808)
                                      (= tmp.51 471889533))
                                    (halt 1)
                                    (halt 0)))
                            (if (if (begin
                                      (set! tmp.52 1)
                                      (>= tmp.52 0))
                                    (begin
                                      (set! tmp.53 0)
                                      (>= tmp.53 -9223372036854775808))
                                    (begin
                                      (set! tmp.54 9223372036854775807)
                                      (> tmp.54 0)))
                                (jump L.fn.7.8 rbp)
                                (if (begin
                                      (set! tmp.55 1)
                                      (> tmp.55 1))
                                    (halt -444155079)
                                    (halt 9223372036854775807)))))
                      (if (begin
                            (if (begin
                                  (set! foobar.2.41 -9223372036854775808)
                                  (true))
                                (begin
                                  (if (begin
                                        (set! tmp.56 9223372036854775807)
                                        (> tmp.56 0))
                                      (set! foobar.2.42 -1444900091)
                                      (set! foobar.2.42 -9223372036854775808))
                                  (set! foo.6.40 foobar.2.42))
                                (if (true)
                                    (begin
                                      (set! foobar.5.43 9223372036854775807)
                                      (set! foo.6.40 foobar.5.43))
                                    (if (begin
                                          (set! tmp.57 -9223372036854775808)
                                          (= tmp.57 1173781558))
                                        (set! foo.6.40 0)
                                        (set! foo.6.40 1))))
                            (if (true)
                                (begin
                                  (set! bar.9.44 0)
                                  (true))
                                (begin
                                  (set! tmp.58 858519747)
                                  (< tmp.58 foo.6.40))))
                          (halt 1)
                          (if (begin
                                (set! tmp.59 1)
                                (< tmp.59 -1323259230))
                              (jump L.fn.2.3 rbp)
                              (jump L.fn.2.3 rbp)))))

  ;; !!!

  ; example output for uncover-locals

  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (halt x.1))
                                  ))
               '(module ((locals (x.1)))
                        (begin
                          (set! x.1 0)
                          (halt x.1))
                  ))
  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (set! y.1 x.1)
                                          (set! y.1 (+ y.1 x.1))
                                          (halt y.1))
                                  ))
               `(module ((locals ,locals))
                        (begin
                          (set! x.1 0)
                          (set! y.1 x.1)
                          (set! y.1 (+ y.1 x.1))
                          (halt y.1))
                  )
               (equal? (list->seteq locals) (seteq 'x.1 'y.1)))

  ;; works, just in different order
  #;(check-equal? (uncover-locals `(module ()
                                           (begin
                                             (set! x.1 5)
                                             (set! y.2 x.1)
                                             (begin
                                               (set! b.3 x.1)
                                               (set! b.3 (+ b.3 y.2))
                                               (set! c.4 b.3)
                                               (if (if (true)
                                                       (false)
                                                       (not (false)))
                                                   (halt c.4)
                                                   (begin
                                                     (set! x.1 c.4)
                                                     (set! x.1 y.2)
                                                     (halt c.4)))))
                                     ))
                  `(module ((locals (b.3 x.1 y.2 c.4)))
                           (begin
                             (set! x.1 5)
                             (set! y.2 x.1)
                             (begin
                               (set! b.3 x.1)
                               (set! b.3 (+ b.3 y.2))
                               (set! c.4 b.3)
                               (if (if (true)
                                       (false)
                                       (not (false)))
                                   (halt c.4)
                                   (begin
                                     (set! x.1 c.4)
                                     (set! x.1 y.2)
                                     (halt c.4)))))
                     ))
  (check-match (uncover-locals '(module ()
                                        (define L.newlabel.1
                                          ()
                                          (begin
                                            (set! x.1 0)
                                            (halt x.1)))
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1)))
                        (define L.newlabel.1
                          ((locals (x.1)))
                          (begin
                            (set! x.1 0)
                            (halt x.1)))
                  (begin
                    (set! x.1 0)
                    (halt x.1))))

  (check-match (uncover-locals '(module ()
                                        (define L.newlabel.1
                                          ()
                                          (begin
                                            (set! x.1 0)
                                            (halt x.1)))
                                  (define L.newlabel.2
                                    ()
                                    (begin
                                      (set! x.1 5)
                                      (set! y.2 x.1)
                                      (begin
                                        (set! b.3 x.1)
                                        (set! b.3 (+ b.3 y.2))
                                        (set! c.4 b.3)
                                        (if (if (true)
                                                (false)
                                                (not (false)))
                                            (halt c.4)
                                            (begin
                                              (set! x.1 c.4)
                                              (set! x.1 y.2)
                                              (halt c.4))))))
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1)))
                        (define L.newlabel.1
                          ((locals (x.1)))
                          (begin
                            (set! x.1 0)
                            (halt x.1)))
                  (define L.newlabel.2
                    ((locals (c.4 x.1 b.3 y.2)))
                    (begin
                      (set! x.1 5)
                      (set! y.2 x.1)
                      (begin
                        (set! b.3 x.1)
                        (set! b.3 (+ b.3 y.2))
                        (set! c.4 b.3)
                        (if (if (true)
                                (false)
                                (not (false)))
                            (halt c.4)
                            (begin
                              (set! x.1 c.4)
                              (set! x.1 y.2)
                              (halt c.4))))))
                  (begin
                    (set! x.1 0)
                    (halt x.1)))))
