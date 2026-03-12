#lang racket

(require cpsc411/compiler-lib)

(provide undead-analysis)

;; (asm-pred-lang-v6/locals p) -> (asm-pred-lang-v6/undead p)
;; Performs undeadness analysis, decorating the program with undead-set tree.
;; Only the info field of the program is modified.
(define (undead-analysis p)

  (define call-undead-box (box `()))

  (define (record-call-undead! s)
    (set-box! call-undead-box 
              (set-remove (set-union (unbox call-undead-box) s) (current-frame-base-pointer-register))
              ;(set-union (unbox call-undead-box) s)
              ))

  (define (analyze-defintiions def)
    (match def
      [`(define ,label
          ,info
          ,tail)
       (set-box! call-undead-box `())
       `(define ,label
          ,(info-set (info-set info
                               'undead-out
                               (let-values ([(_ ust) (analyze-program-tail `() tail)])
                                 (first ust)))
                     'call-undead
                     (set->list (unbox call-undead-box)))
          ,tail)]))

  ;; undead-set (asm-lang-v2/locals effect) -> (values undead-set ust)
  ;; SLIGHTLY MODIFIED CODE FROM LECTURE
  ;; takes in the undead-out set for the current instruction
  ;; and computes the undead-in set for the current instruction,
  ;; and the undead-set-tree for the effect
  (define (analyze-program-effect undead-out effect)
    (match effect
      [`(begin
          ,effects ...
          ,effect)
       (let-values ([(undead-out updated-ust) (analyze-program-effect undead-out effect)])
         (let-values ([(pre-wrap-undead-out pre-wrap-updated-ust)
                       (for/foldr ([undead-out undead-out] [ust `(,updated-ust)])
                                  ([effect effects])
                                  (let-values ([(undead-in new-ust) (analyze-program-effect undead-out
                                                                                            effect)])
                                    (values undead-in (cons new-ust ust))))])

           ;(values pre-wrap-undead-out `(,pre-wrap-updated-ust))
           (values pre-wrap-undead-out pre-wrap-updated-ust)))]
      [`(set! ,aloc_1 (,binop ,aloc_1 ,triv))
       (let ([undead-in (set-add (set-add-triv undead-out triv) aloc_1)])
         (values undead-in undead-out))]
      [`(set! ,aloc ,triv)
       (let ([undead-in (set-add-triv (set-remove undead-out aloc) triv)])
         (values undead-in undead-out))]
      [`(if ,pred ,effect1 ,effect2)
       (let*-values ([(undead-out-effect2 ust-effect2) (analyze-program-effect undead-out effect2)]
                     [(undead-out-effect1 ust-effect1) (analyze-program-effect undead-out effect1)]
                     [(undead-out-pred ust-pred)
                      (analyze-program-pred (set-union undead-out-effect1 undead-out-effect2) pred)])
         (values undead-out-pred `(,ust-pred ,ust-effect1 ,ust-effect2)))]
      [`(return-point ,label ,tail)
        (let-values ([(undead-in ust-tail) (analyze-program-tail undead-out tail)])
           (record-call-undead! undead-out)
           (values undead-in `(,undead-out ,(first ust-tail))))]))

  (define (analyze-program-pred undead-out pred)
    (match pred
      [`(,relop ,aloc ,triv)
       #:when (memq relop '(< <= = >= > !=))
       (let ([undead-in (set-add-triv (set-add undead-out aloc) triv)])
         (values undead-in undead-out))]
      [`(true) (values undead-out undead-out)]
      [`(false) (values undead-out undead-out)]
      [`(not ,pred)
       (let-values ([(undead-out-pred updated-ust) (analyze-program-pred undead-out pred)])
         (values undead-out-pred updated-ust))]
      [`(begin
          ,effects ...
          ,pred)
       (let-values ([(undead-out updated-ust) (analyze-program-pred undead-out pred)])
         (let-values ([(pre-wrap-undead-out pre-wrap-updated-ust)
                       (for/foldr ([undead-out undead-out] [ust `(,updated-ust)])
                                  ([effect effects])
                                  (let-values ([(undead-in new-ust) (analyze-program-effect undead-out
                                                                                            effect)])
                                    (values undead-in (cons new-ust ust))))])

           ;(values pre-wrap-undead-out `(,pre-wrap-updated-ust))
           (values pre-wrap-undead-out pre-wrap-updated-ust)))]
      [`(if ,pred1 ,pred2 ,pred3)
       (let*-values ([(undead-out-pred3 ust-pred3) (analyze-program-pred undead-out pred3)]
                     [(undead-out-pred2 ust-pred2) (analyze-program-pred undead-out pred2)]
                     [(undead-out-pred1 ust-pred1)
                      (analyze-program-pred (set-union undead-out-pred3 undead-out-pred2) pred1)])
         (values undead-out-pred1 `(,ust-pred1 ,ust-pred2 ,ust-pred3)))]))

  ; undead-set (asm-lang-v2/locals triv) -> undead-set
  ; TAKEN FROM LECTURE
  ; adds triv to the undead-set if the triv is an aloc.
  (define (set-add-triv undead-set triv)
    (if (aloc? triv)
        (set-add undead-set triv)
        undead-set))

  ;; undead-set (asm-lang-v2/locals tail) -> (values undead-set ust)
  ;; takes in the undead-out set for the current instruction
  ;; and computes the undead-in set for the current instruction,
  ;; and the undead-set-tree for the effect
  (define (analyze-program-tail undead-out tail)
    (match tail
      [`(begin
          ,effects ...
          ,tail)
       (let-values ([(undead-out updated-ust) (analyze-program-tail undead-out tail)])
         (let-values ([(pre-wrap-undead-out pre-wrap-updated-ust)
                       (for/foldr ([undead-out undead-out] [ust updated-ust])
                                  ([effect effects])
                                  (let-values ([(undead-in new-ust) (analyze-program-effect undead-out
                                                                                            effect)])
                                    (values undead-in (cons new-ust ust))))])

           (values pre-wrap-undead-out `(,pre-wrap-updated-ust))
           ;(values pre-wrap-undead-out pre-wrap-updated-ust)
            ))]
      [`(halt ,triv)
       (let ([undead-in (set-add-triv undead-out triv)]) (values undead-in (cons undead-out '())))]
      [`(if ,pred ,tail1 ,tail2)
       (let*-values ([(undead-out-tail2 ust-tail2) (analyze-program-tail undead-out tail2)]
                     [(undead-out-tail1 ust-tail1) (analyze-program-tail undead-out tail1)]
                     [(undead-out-pred ust-pred)
                      (analyze-program-pred (set-union undead-out-tail1 undead-out-tail2) pred)])
         (values undead-out-pred `((,ust-pred ,(first ust-tail1) ,(first ust-tail2)))))]
      [`(jump ,label ,locs ...)
       (values (if (label? label)
                   locs
                   (cons label locs))
               (cons locs undead-out))]))

  (match p
    [`(module ,info ,definitions
        ...
        ,tail)
     `(module ,(info-set info
                         'undead-out
                         (let-values ([(_ ust) (analyze-program-tail `() tail)])
                           (first ust)))
              ,@(map analyze-defintiions definitions)
        ,tail)]))

#;
(module+ test
  (require rackunit
           cpsc411/langs/v5
           cpsc411/langs/v6)

  (check-equal? (undead-analysis
    '(module ((new-frames ()) (locals (tmp.16 tmp-ra.14 ball.6.11 foobar.9.10)))
             (define L.func.0.1
               ((new-frames ()) (locals (foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12)))
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
         ((new-frames (())) (locals (ball.8.9 bar.7.6 bar.7.8 tmp-ra.13 bat.0.7 tmp.15)))
         (begin
           (set! tmp-ra.13 r15)
           (set! bat.0.7 rdi)
           (set! bar.7.6 rsi)
           (set! bar.7.8 bat.0.7)
           (return-point L.rp.3
                         (begin
                           (set! rsi bar.7.8)
                           (set! rdi bar.7.8)
                           (set! r15 L.rp.3)
                           (jump L.proc.1.2 rbp r15 rdi rsi)))
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
               
  `(module
  ((new-frames ())
   (locals (tmp.16 tmp-ra.14 ball.6.11 foobar.9.10))
   (call-undead ())
   (undead-out
    ((tmp-ra.14 rbp)
     ((tmp-ra.14 rbp)
      (foobar.9.10 tmp-ra.14 rbp)
      ((tmp.16 tmp-ra.14 rbp)
       (tmp.16 tmp-ra.14 rbp)
       (foobar.9.10 tmp-ra.14 rbp)))
     ((foobar.9.10 tmp-ra.14 rbp)
      ((tmp-ra.14 rbp) (tmp-ra.14 rax rbp) (rax rbp))
      ((tmp-ra.14 rsi rbp)
       (tmp-ra.14 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp))))))
  (define L.func.0.1
    ((new-frames ())
     (locals (foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12))
     (undead-out
      ((rdi rsi rdx rcx r8 tmp-ra.12 rbp)
       (rsi rdx rcx r8 tmp-ra.12 rbp)
       (rdx rcx r8 tmp-ra.12 rbp)
       (rcx r8 tmp-ra.12 rbp)
       (r8 tmp-ra.12 rbp)
       (tmp-ra.12 rbp)
       (tmp-ra.12 rax rbp)
       (rax rbp)))
     (call-undead ()))
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
    ((new-frames (()))
     (locals (ball.8.9 bar.7.6 bar.7.8 tmp-ra.13 bat.0.7 tmp.15))
     (undead-out
      ((rdi rsi tmp-ra.13 rbp)
       (rsi bat.0.7 tmp-ra.13 rbp)
       (bat.0.7 tmp-ra.13 rbp)
       (bat.0.7 bar.7.8 tmp-ra.13 rbp)
       ((rax bat.0.7 bar.7.8 tmp-ra.13 rbp)
        ((bar.7.8 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (bat.0.7 bar.7.8 tmp-ra.13 rbp)
       (((bat.0.7 tmp.15 bar.7.8 tmp-ra.13 rbp) (bar.7.8 tmp-ra.13 rbp))
        ((tmp-ra.13 rax rbp) (rax rbp))
        ((tmp-ra.13 rax rbp) (rax rbp)))))
     (call-undead (bat.0.7 bar.7.8 tmp-ra.13)))
    (begin
      (set! tmp-ra.13 r15)
      (set! bat.0.7 rdi)
      (set! bar.7.6 rsi)
      (set! bar.7.8 bat.0.7)
      (return-point
       L.rp.3
       (begin
         (set! rsi bar.7.8)
         (set! rdi bar.7.8)
         (set! r15 L.rp.3)
         (jump L.proc.1.2 rbp r15 rdi rsi)))
      (set! ball.8.9 rax)
      (if (begin (set! tmp.15 -59730991) (= tmp.15 bat.0.7))
        (begin (set! rax 0) (jump tmp-ra.13 rbp rax))
        (begin (set! rax bar.7.8) (jump tmp-ra.13 rbp rax)))))
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

  (check-equal? (undead-analysis '(module ((new-frames ()) (locals (tmp-ra.2)))
                               (define L.swap.1
                                 ((new-frames (())) (locals (z.3 tmp-ra.1 x.1 y.2)))
                                 (begin
                                   (set! tmp-ra.1 r15)
                                   (set! x.1 rdi)
                                   (set! y.2 rsi)
                                   (if (< y.2 x.1)
                                       (begin
                                         (set! rax x.1)
                                         (jump tmp-ra.1 rbp rax))
                                       (begin
                                         (return-point L.rp.1
                                                       (begin
                                                         (set! rsi x.1)
                                                         (set! rdi y.2)
                                                         (set! r15 L.rp.1)
                                                         (jump L.swap.1 rbp r15 rdi rsi)))
                                         (set! z.3 rax)
                                         (set! rax z.3)
                                         (jump tmp-ra.1 rbp rax)))))
                         (begin
                           (set! tmp-ra.2 r15)
                           (set! rsi 2)
                           (set! rdi 1)
                           (set! r15 tmp-ra.2)
                           (jump L.swap.1 rbp r15 rdi rsi))))
  `(module
  ((new-frames ())
   (locals (tmp-ra.2))
   (call-undead ())
   (undead-out
    ((tmp-ra.2 rbp)
     (tmp-ra.2 rsi rbp)
     (tmp-ra.2 rsi rdi rbp)
     (rsi rdi r15 rbp)
     (rsi rdi r15 rbp))))
  (define L.swap.1
    ((new-frames (()))
     (locals (z.3 tmp-ra.1 x.1 y.2))
     (undead-out
      ((rdi rsi tmp-ra.1 rbp)
       (rsi x.1 tmp-ra.1 rbp)
       (y.2 x.1 tmp-ra.1 rbp)
       ((y.2 x.1 tmp-ra.1 rbp)
        ((tmp-ra.1 rax rbp) (rax rbp))
        (((rax tmp-ra.1 rbp)
          ((y.2 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
         (z.3 tmp-ra.1 rbp)
         (tmp-ra.1 rax rbp)
         (rax rbp)))))
     (call-undead (tmp-ra.1)))
    (begin
      (set! tmp-ra.1 r15)
      (set! x.1 rdi)
      (set! y.2 rsi)
      (if (< y.2 x.1)
        (begin (set! rax x.1) (jump tmp-ra.1 rbp rax))
        (begin
          (return-point
           L.rp.1
           (begin
             (set! rsi x.1)
             (set! rdi y.2)
             (set! r15 L.rp.1)
             (jump L.swap.1 rbp r15 rdi rsi)))
          (set! z.3 rax)
          (set! rax z.3)
          (jump tmp-ra.1 rbp rax)))))
  (begin
    (set! tmp-ra.2 r15)
    (set! rsi 2)
    (set! rdi 1)
    (set! r15 tmp-ra.2)
    (jump L.swap.1 rbp r15 rdi rsi))))
                           
  (check-equal? (undead-analysis
   '(module ((new-frames ()) (locals (foobar.7.19 foo.8.20 ball.3.21 tmp-ra.25)))
            (define L.proc.0.1
              ((new-frames ()) (locals (foobar.1.1 foobar.4.2 foo.8.3 ball.3.4 tmp-ra.22)))
              (begin
                (set! tmp-ra.22 r15)
                (set! ball.3.4 rdi)
                (set! foo.8.3 rsi)
                (set! foobar.4.2 rdx)
                (set! foobar.1.1 rcx)
                (set! r8 foo.8.3)
                (set! rcx 1)
                (set! rdx 0)
                (set! rsi -9223372036854775808)
                (set! rdi 835392363)
                (set! r15 tmp-ra.22)
                (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8)))
      (define L.fn.1.2
        ((new-frames ()) (locals (foobar.4.5 bat.6.6 bar.2.7 foobar.7.8 bat.0.9 tmp-ra.23)))
        (begin
          (set! tmp-ra.23 r15)
          (set! bat.0.9 rdi)
          (set! foobar.7.8 rsi)
          (set! bar.2.7 rdx)
          (set! bat.6.6 rcx)
          (set! foobar.4.5 r8)
          (set! rdi foobar.7.8)
          (set! r15 tmp-ra.23)
          (jump L.x.2.3 rbp r15 rdi)))
      (define L.x.2.3
        ((new-frames (())) (locals (ball.3.13 foobar.7.14
                                              foobar.1.16
                                              foobar.7.17
                                              bat.0.18
                                              foo.9.15
                                              foo.9.11
                                              tmp.26
                                              bat.0.12
                                              foobar.7.10
                                              tmp-ra.24)))
        (begin
          (set! tmp-ra.24 r15)
          (set! foobar.7.10 rdi)
          (return-point L.rp.4
                        (begin
                          (set! rcx foobar.7.10)
                          (set! rdx foobar.7.10)
                          (set! rsi foobar.7.10)
                          (set! rdi foobar.7.10)
                          (set! r15 L.rp.4)
                          (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx)))
          (set! bat.0.12 rax)
          (set! tmp.26 bat.0.12)
          (set! tmp.26 (- tmp.26 bat.0.12))
          (set! foo.9.11 tmp.26)
          (if (<= foo.9.11 foobar.7.10)
              (set! foo.9.15 foo.9.11)
              (set! foo.9.15 foobar.7.10))
          (set! bat.0.18 foo.9.11)
          (set! foobar.7.17 foobar.7.10)
          (set! foobar.1.16 foo.9.11)
          (set! foobar.7.14 bat.0.18)
          (set! ball.3.13 foobar.7.10)
          (set! rdi ball.3.13)
          (set! r15 tmp-ra.24)
          (jump L.x.2.3 rbp r15 rdi)))
      (begin
        (set! tmp-ra.25 r15)
        (set! ball.3.21 1830309714)
        (set! foo.8.20 -9223372036854775808)
        (set! foobar.7.19 -9223372036854775808)
        (set! rax ball.3.21)
        (jump tmp-ra.25 rbp rax))))
  `(module
  ((new-frames ())
   (locals (foobar.7.19 foo.8.20 ball.3.21 tmp-ra.25))
   (call-undead ())
   (undead-out
    ((tmp-ra.25 rbp)
     (ball.3.21 tmp-ra.25 rbp)
     (ball.3.21 tmp-ra.25 rbp)
     (ball.3.21 tmp-ra.25 rbp)
     (tmp-ra.25 rax rbp)
     (rax rbp))))
  (define L.proc.0.1
    ((new-frames ())
     (locals (foobar.1.1 foobar.4.2 foo.8.3 ball.3.4 tmp-ra.22))
     (undead-out
      ((rdi rsi rdx rcx tmp-ra.22 rbp)
       (rsi rdx rcx tmp-ra.22 rbp)
       (rdx rcx foo.8.3 tmp-ra.22 rbp)
       (rcx foo.8.3 tmp-ra.22 rbp)
       (foo.8.3 tmp-ra.22 rbp)
       (tmp-ra.22 r8 rbp)
       (tmp-ra.22 r8 rcx rbp)
       (tmp-ra.22 r8 rcx rdx rbp)
       (tmp-ra.22 r8 rcx rdx rsi rbp)
       (tmp-ra.22 r8 rcx rdx rsi rdi rbp)
       (r8 rcx rdx rsi rdi r15 rbp)
       (r8 rcx rdx rsi rdi r15 rbp)))
     (call-undead ()))
    (begin
      (set! tmp-ra.22 r15)
      (set! ball.3.4 rdi)
      (set! foo.8.3 rsi)
      (set! foobar.4.2 rdx)
      (set! foobar.1.1 rcx)
      (set! r8 foo.8.3)
      (set! rcx 1)
      (set! rdx 0)
      (set! rsi -9223372036854775808)
      (set! rdi 835392363)
      (set! r15 tmp-ra.22)
      (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8)))
  (define L.fn.1.2
    ((new-frames ())
     (locals (foobar.4.5 bat.6.6 bar.2.7 foobar.7.8 bat.0.9 tmp-ra.23))
     (undead-out
      ((rdi rsi rdx rcx r8 tmp-ra.23 rbp)
       (rsi rdx rcx r8 tmp-ra.23 rbp)
       (rdx rcx r8 foobar.7.8 tmp-ra.23 rbp)
       (rcx r8 foobar.7.8 tmp-ra.23 rbp)
       (r8 foobar.7.8 tmp-ra.23 rbp)
       (foobar.7.8 tmp-ra.23 rbp)
       (tmp-ra.23 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (call-undead ()))
    (begin
      (set! tmp-ra.23 r15)
      (set! bat.0.9 rdi)
      (set! foobar.7.8 rsi)
      (set! bar.2.7 rdx)
      (set! bat.6.6 rcx)
      (set! foobar.4.5 r8)
      (set! rdi foobar.7.8)
      (set! r15 tmp-ra.23)
      (jump L.x.2.3 rbp r15 rdi)))
  (define L.x.2.3
    ((new-frames (()))
     (locals
      (ball.3.13
       foobar.7.14
       foobar.1.16
       foobar.7.17
       bat.0.18
       foo.9.15
       foo.9.11
       tmp.26
       bat.0.12
       foobar.7.10
       tmp-ra.24))
     (undead-out
      ((rdi tmp-ra.24 rbp)
       (foobar.7.10 tmp-ra.24 rbp)
       ((rax foobar.7.10 tmp-ra.24 rbp)
        ((foobar.7.10 rcx rbp)
         (foobar.7.10 rcx rdx rbp)
         (foobar.7.10 rcx rdx rsi rbp)
         (rcx rdx rsi rdi rbp)
         (rcx rdx rsi rdi r15 rbp)
         (rcx rdx rsi rdi r15 rbp)))
       (bat.0.12 foobar.7.10 tmp-ra.24 rbp)
       (bat.0.12 tmp.26 foobar.7.10 tmp-ra.24 rbp)
       (tmp.26 foobar.7.10 tmp-ra.24 rbp)
       (foo.9.11 foobar.7.10 tmp-ra.24 rbp)
       ((foo.9.11 foobar.7.10 tmp-ra.24 rbp)
        (foo.9.11 foobar.7.10 tmp-ra.24 rbp)
        (foo.9.11 foobar.7.10 tmp-ra.24 rbp))
       (foo.9.11 bat.0.18 foobar.7.10 tmp-ra.24 rbp)
       (foo.9.11 bat.0.18 foobar.7.10 tmp-ra.24 rbp)
       (bat.0.18 foobar.7.10 tmp-ra.24 rbp)
       (foobar.7.10 tmp-ra.24 rbp)
       (ball.3.13 tmp-ra.24 rbp)
       (tmp-ra.24 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (call-undead (foobar.7.10 tmp-ra.24)))
    (begin
      (set! tmp-ra.24 r15)
      (set! foobar.7.10 rdi)
      (return-point
       L.rp.4
       (begin
         (set! rcx foobar.7.10)
         (set! rdx foobar.7.10)
         (set! rsi foobar.7.10)
         (set! rdi foobar.7.10)
         (set! r15 L.rp.4)
         (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx)))
      (set! bat.0.12 rax)
      (set! tmp.26 bat.0.12)
      (set! tmp.26 (- tmp.26 bat.0.12))
      (set! foo.9.11 tmp.26)
      (if (<= foo.9.11 foobar.7.10)
        (set! foo.9.15 foo.9.11)
        (set! foo.9.15 foobar.7.10))
      (set! bat.0.18 foo.9.11)
      (set! foobar.7.17 foobar.7.10)
      (set! foobar.1.16 foo.9.11)
      (set! foobar.7.14 bat.0.18)
      (set! ball.3.13 foobar.7.10)
      (set! rdi ball.3.13)
      (set! r15 tmp-ra.24)
      (jump L.x.2.3 rbp r15 rdi)))
  (begin
    (set! tmp-ra.25 r15)
    (set! ball.3.21 1830309714)
    (set! foo.8.20 -9223372036854775808)
    (set! foobar.7.19 -9223372036854775808)
    (set! rax ball.3.21)
    (jump tmp-ra.25 rbp rax)))))

(module+ test
  (require rackunit
           cpsc411/langs/v5
           cpsc411/langs/v6)
  (define-syntax-rule (check-by-interp asmplv5l)
    (check-equal? (interp-asm-pred-lang-v5/locals asmplv5l)
                  (interp-asm-pred-lang-v5/undead (undead-analysis asmplv5l))))
  (define-syntax-rule (check-by-interp-v6 p)
    (check-equal? (interp-asm-pred-lang-v6/locals p)
                  (interp-asm-pred-lang-v6/undead (undead-analysis p))))

  ;; M6 tests; Added by Trevor on March 6th 2026, at most one binding per let
  (check-by-interp-v6 '(module ((new-frames ()) (locals (ball.2.3 foobar.3.1 bat.9.2 tmp-ra.4)))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (set! bat.9.2 -422317085)
                                 (set! foobar.3.1 bat.9.2)
                                 (set! ball.2.3 foobar.3.1)
                                 (set! rax foobar.3.1)
                                 (jump tmp-ra.4 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.16 tmp-ra.14 ball.6.11 foobar.9.10)))
            (define L.func.0.1
              ((new-frames ()) (locals (foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12)))
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
        ((new-frames (())) (locals (ball.8.9 bar.7.6 bar.7.8 tmp-ra.13 bat.0.7 tmp.15)))
        (begin
          (set! tmp-ra.13 r15)
          (set! bat.0.7 rdi)
          (set! bar.7.6 rsi)
          (set! bar.7.8 bat.0.7)
          (return-point L.rp.3
                        (begin
                          (set! rsi bar.7.8)
                          (set! rdi bar.7.8)
                          (set! r15 L.rp.3)
                          (jump L.proc.1.2 rbp r15 rdi rsi)))
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

  ;; return value for above test, used for sanity checking
  #;(module ((new-frames ())
             (locals (tmp.16 tmp-ra.14 ball.6.11 foobar.9.10))
             (call-undead ())
             (undead-out ((tmp-ra.14 rbp)
                          ((tmp-ra.14 rbp) (foobar.9.10 tmp-ra.14 rbp)
                                           ((tmp.16 tmp-ra.14 rbp) (tmp.16 tmp-ra.14 rbp)
                                                                   (foobar.9.10 tmp-ra.14 rbp)))
                          ((foobar.9.10 tmp-ra.14 rbp) ((tmp-ra.14 rbp) (tmp-ra.14 rax rbp) (rax rbp))
                                                       ((tmp-ra.14 rsi rbp) (tmp-ra.14 rsi rdi rbp)
                                                                            (rsi rdi r15 rbp)
                                                                            (rsi rdi r15 rbp))))))
            (define L.func.0.1
              ((new-frames ())
               (locals (foobar.2.1 bat.5.2 bat.0.3 ball.4.4 ball.3.5 tmp-ra.12))
               (undead-out ((rdi rsi rdx rcx r8 tmp-ra.12 rbp) (rsi rdx rcx r8 tmp-ra.12 rbp)
                                                               (rdx rcx r8 tmp-ra.12 rbp)
                                                               (rcx r8 tmp-ra.12 rbp)
                                                               (r8 tmp-ra.12 rbp)
                                                               (tmp-ra.12 rbp)
                                                               (tmp-ra.12 rax rbp)
                                                               (rax rbp)))
               (call-undead ()))
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
        ((new-frames (()))
         (locals (ball.8.9 bar.7.6 bar.7.8 tmp-ra.13 bat.0.7 tmp.15))
         (undead-out ((rdi rsi tmp-ra.13 rbp)
                      (rsi bat.0.7 tmp-ra.13 rbp)
                      (bat.0.7 tmp-ra.13 rbp)
                      (bat.0.7 bar.7.8 tmp-ra.13 rbp)
                      ((rax bat.0.7 bar.7.8 tmp-ra.13 rbp)
                       ((bar.7.8 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
                      (bat.0.7 bar.7.8 tmp-ra.13 rbp)
                      (((bat.0.7 tmp.15 bar.7.8 tmp-ra.13 rbp) (bar.7.8 tmp-ra.13 rbp))
                       ((tmp-ra.13 rax rbp) (rax rbp))
                       ((tmp-ra.13 rax rbp) (rax rbp)))))
         (call-undead (bat.0.7 bar.7.8 tmp-ra.13)))
        (begin
          (set! tmp-ra.13 r15)
          (set! bat.0.7 rdi)
          (set! bar.7.6 rsi)
          (set! bar.7.8 bat.0.7)
          (return-point L.rp.3
                        (begin
                          (set! rsi bar.7.8)
                          (set! rdi bar.7.8)
                          (set! r15 L.rp.3)
                          (jump L.proc.1.2 rbp r15 rdi rsi)))
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
              (jump L.proc.1.2 rbp r15 rdi rsi)))))

  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (tmp.9 bat.8.2 bat.9.1 bat.9.4 bat.9.3 tmp.7 tmp.8 bat.3.5 tmp-ra.6)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.12 foobar.5.7 tmp-ra.9)))
            (define L.func.0.1
              ((new-frames (()))
               (locals
                (foo.3.6 bat.2.3 foobar.9.4 foobar.8.5 foo.7.2 tmp.11 bat.0.1 tmp-ra.8 tmp.10)))
              (begin
                (set! tmp-ra.8 r15)
                (set! foobar.8.5 rdi)
                (set! foobar.9.4 rsi)
                (set! bat.2.3 rdx)
                (set! foo.7.2 rcx)
                (set! bat.0.1 r8)
                (return-point L.rp.2
                              (begin
                                (set! r8 bat.0.1)
                                (set! rcx foo.7.2)
                                (set! rdx foobar.9.4)
                                (set! rsi -9223372036854775808)
                                (set! rdi -1343541856)
                                (set! r15 L.rp.2)
                                (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp.3 foo.6.1 tmp-ra.2)))
                               (begin
                                 (set! tmp-ra.2 r15)
                                 (set! foo.6.1 -356902212)
                                 (set! tmp.3 -979281755)
                                 (set! tmp.3 (+ tmp.3 9223372036854775807))
                                 (set! rax tmp.3)
                                 (jump tmp-ra.2 rbp rax))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.5 tmp.6)))
                               (define L.tmp.0.1
                                 ((new-frames ()) (locals (foo.5.1 foobar.9.2 ball.6.3 tmp-ra.4)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.16 tmp.18)))
            (define L.x.0.1
              ((new-frames (()))
               (locals
                (ball.3.5 bat.5.8 bat.5.1 ball.4.2 tmp-ra.14 bar.7.4 bat.6.7 foobar.9.6 bat.6.3)))
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
                      (return-point L.rp.3
                                    (begin
                                      (set! r8 0)
                                      (set! rcx bat.5.1)
                                      (set! rdx bat.6.3)
                                      (set! rsi 9223372036854775807)
                                      (set! rdi bat.5.1)
                                      (set! r15 L.rp.3)
                                      (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))
                      (set! bat.5.8 rax)
                      (if (<= bar.7.4 -186024487)
                          (begin
                            (set! rax bat.5.8)
                            (jump tmp-ra.14 rbp rax))
                          (begin
                            (set! rax bat.6.3)
                            (jump tmp-ra.14 rbp rax)))))))
      (define L.func.1.2
        ((new-frames ()) (locals (bat.5.13 tmp.17 foobar.9.12 bar.7.11 ball.4.9 bar.8.10 tmp-ra.15)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (bat.2.6 tmp.11 tmp-ra.9)))
                               (define L.proc.0.1
                                 ((new-frames ()) (locals (bar.1.2 tmp.10 bat.9.1 tmp-ra.7)))
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
                           ((new-frames ()) (locals (bar.1.3 foobar.6.4 foobar.8.5 tmp-ra.8)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1 tmp.2)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.8)))
            (define L.x.0.1
              ((new-frames ())
               (locals (bar.7.1 ball.5.5 bat.3.2 ball.4.3 foobar.9.4 tmp-ra.7 foo.2.6 tmp.9)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (set! rax 1)
                                 (jump tmp-ra.1 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (tmp-ra.21 bar.2.16 bar.2.15 foobar.8.17 tmp.28 bat.0.14 tmp.27)))
            (define L.fn.0.1
              ((new-frames ()) (locals (tmp.22 foobar.4.3 bat.0.1 ball.9.2 tmp-ra.18)))
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
        ((new-frames ()) (locals (tmp.25 tmp.24 ball.9.4 tmp-ra.19 tmp.23)))
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
        ((new-frames ()) (locals (bar.2.5 bar.7.7
                                          ball.9.9
                                          tmp.26
                                          bat.3.6
                                          bat.6.13
                                          bat.5.11
                                          bar.2.12
                                          foobar.4.8
                                          bat.0.10
                                          tmp-ra.20)))
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
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (tmp.6 bar.5.2 tmp.7 tmp.8 bar.3.3 ball.6.4 tmp-ra.5 tmp.9 bat.4.1)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.9)))
            (define L.tmp.0.1
              ((new-frames ())
               (locals (bat.8.1 ball.3.2 bar.5.3 bat.1.4 foobar.7.5 foo.4.6 foobar.9.7 tmp-ra.8)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.21 foo.9.17)))
            (define L.proc.0.1
              ((new-frames ()) (locals (bar.0.1 foo.6.2 bat.5.3 foo.8.4 tmp-ra.18)))
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
        ((new-frames ()) (locals (bat.4.5 foo.9.6 bar.0.7 foo.8.8 bat.3.9 tmp-ra.19)))
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
        ((new-frames ())
         (locals (foo.6.10 foo.2.11 foo.8.12 bat.4.13 bat.5.14 bat.3.15 foo.7.16 tmp-ra.20)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (ball.1.15 tmp-ra.19)))
            (define L.tmp.0.1
              ((new-frames ())
               (locals (ball.5.1 foobar.2.2 bat.3.3 foo.6.4 foo.7.5 bar.4.6 bar.8.7 tmp-ra.16)))
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
        ((new-frames ()) (locals (bar.8.8 ball.5.9 ball.1.10 tmp-ra.17)))
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
        ((new-frames ()) (locals (ball.5.14 ball.5.11 ball.0.12 bar.8.13 tmp-ra.18)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.9)))
            (define L.func.0.1
              ((new-frames ())
               (locals (foo.1.1 bat.2.2 foobar.7.3 foo.0.4 tmp-ra.8 foo.9.5 ball.3.6 tmp.10 foo.9.7)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.10)))
                               (define L.fn.0.1
                                 ((new-frames ()) (locals (bat.6.1 tmp-ra.7 bat.8.2 foobar.1.3)))
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
                           ((new-frames ()) (locals (foo.5.4 foo.0.5 foobar.1.6 tmp-ra.8)))
                           (begin
                             (set! tmp-ra.8 r15)
                             (set! foobar.1.6 rdi)
                             (set! foo.0.5 rsi)
                             (set! foo.5.4 rdx)
                             (set! r15 tmp-ra.8)
                             (jump L.tmp.2.3 rbp r15)))
                         (define L.tmp.2.3
                           ((new-frames ()) (locals (tmp-ra.9)))
                           (begin
                             (set! tmp-ra.9 r15)
                             (set! r15 tmp-ra.9)
                             (jump L.tmp.2.3 rbp r15)))
                         (begin
                           (set! tmp-ra.10 r15)
                           (set! rax 1)
                           (jump tmp-ra.10 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.9)))
            (define L.x.0.1
              ((new-frames ())
               (locals (tmp.10 foobar.7.6 bar.3.7 bat.2.5 bat.9.1 bat.2.2 ball.0.3 bar.3.4 tmp-ra.8)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.15)))
            (define L.func.0.1
              ((new-frames ())
               (locals (ball.3.1 bat.9.2 foobar.7.3 foobar.6.4 bat.0.5 ball.1.6 foo.4.7 tmp-ra.12)))
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
        ((new-frames ((nfv.14)))
         (locals (ball.3.11 tmp.16 nfv.14 foobar.7.9 tmp-ra.13 ball.8.10 bat.9.8 tmp.17)))
        (begin
          (set! tmp-ra.13 r15)
          (set! foobar.7.9 rdi)
          (set! bat.9.8 rsi)
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bar.1.14 tmp-ra.17 tmp.21 tmp.20 tmp.19 foo.6.13)))
            (define L.proc.0.1
              ((new-frames ()) (locals (ball.7.1 foobar.2.4
                                                 bat.0.6
                                                 bar.8.5
                                                 bat.4.2
                                                 tmp-ra.15
                                                 tmp.18
                                                 bar.1.7
                                                 foobar.2.8
                                                 ball.5.3)))
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
        ((new-frames ()) (locals (ball.5.9 bat.4.10 bar.1.11 foobar.2.12 tmp-ra.16)))
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
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.12)))
            (define L.tmp.0.1
              ((new-frames ()) (locals (bar.4.1 ball.5.2 bar.9.3 tmp-ra.10)))
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
        ((new-frames ()) (locals (tmp.13 foo.6.9 foo.1.4 bat.0.5 bar.9.6 bar.2.7 ball.8.8 tmp-ra.11)))
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
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.10)))
                               (define L.x.0.1
                                 ((new-frames ()) (locals (foo.4.1 foo.3.2 bar.1.3 tmp-ra.8)))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (set! bar.1.3 rdi)
                                   (set! foo.3.2 rsi)
                                   (set! foo.4.1 rdx)
                                   (set! rcx -1370687846)
                                   (set! rdx -9223372036854775808)
                                   (set! rsi foo.4.1)
                                   (set! rdi 346043157)
                                   (set! r15 tmp-ra.8)
                                   (jump L.x.1.2 rbp r15 rdi rsi rdx rcx)))
                         (define L.x.1.2
                           ((new-frames ()) (locals (foo.8.4 bar.0.5 foo.3.6 bar.1.7 tmp-ra.9)))
                           (begin
                             (set! tmp-ra.9 r15)
                             (set! bar.1.7 rdi)
                             (set! foo.3.6 rsi)
                             (set! bar.0.5 rdx)
                             (set! foo.8.4 rcx)
                             (set! rcx 1658781620)
                             (set! rdx 0)
                             (set! rsi foo.3.6)
                             (set! rdi -1950262775)
                             (set! r15 tmp-ra.9)
                             (jump L.x.1.2 rbp r15 rdi rsi rdx rcx)))
                         (begin
                           (set! tmp-ra.10 r15)
                           (set! rcx 9223372036854775807)
                           (set! rdx -1844821605)
                           (set! rsi 1)
                           (set! rdi -139919863)
                           (set! r15 tmp-ra.10)
                           (jump L.x.1.2 rbp r15 rdi rsi rdx rcx))))
  (check-by-interp-v6
   '(module ((new-frames (()))
             (locals
              (tmp.15 tmp.13 bar.7.5 tmp.14 foobar.1.6 tmp-ra.9 foobar.1.7 tmp.12 tmp.11 tmp.10)))
            (define L.tmp.0.1
              ((new-frames ()) (locals (bar.8.1 ball.5.2 foobar.9.3 bar.4.4 tmp-ra.8)))
              (begin
                (set! tmp-ra.8 r15)
                (set! bar.4.4 rdi)
                (set! foobar.9.3 rsi)
                (set! ball.5.2 rdx)
                (set! bar.8.1 rcx)
                (set! rcx ball.5.2)
                (set! rdx ball.5.2)
                (set! rsi ball.5.2)
                (set! rdi foobar.9.3)
                (set! r15 tmp-ra.8)
                (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx)))
      (begin
        (set! tmp-ra.9 r15)
        (if (false)
            (begin
              (if (if (begin
                        (set! tmp.10 9223372036854775807)
                        (> tmp.10 1428972274))
                      (begin
                        (set! tmp.11 0)
                        (!= tmp.11 479631559))
                      (begin
                        (set! tmp.12 0)
                        (>= tmp.12 1284385619)))
                  (begin
                    (return-point L.rp.2
                                  (begin
                                    (set! rcx 1)
                                    (set! rdx 0)
                                    (set! rsi -1164071576)
                                    (set! rdi 1550080702)
                                    (set! r15 L.rp.2)
                                    (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx)))
                    (set! bar.7.5 rax))
                  (set! bar.7.5 -9223372036854775808))
              (if (if (begin
                        (set! tmp.13 0)
                        (<= tmp.13 bar.7.5))
                      (!= bar.7.5 2009350954)
                      (begin
                        (set! tmp.14 1170635915)
                        (!= tmp.14 bar.7.5)))
                  (begin
                    (set! foobar.1.6 bar.7.5)
                    (set! rax 0)
                    (jump tmp-ra.9 rbp rax))
                  (begin
                    (set! foobar.1.7 -378459323)
                    (set! rax bar.7.5)
                    (jump tmp-ra.9 rbp rax))))
            (if (false)
                (begin
                  (set! rax 0)
                  (jump tmp-ra.9 rbp rax))
                (begin
                  (set! tmp.15 1326448876)
                  (set! tmp.15 (- tmp.15 360169641))
                  (set! rax tmp.15)
                  (jump tmp-ra.9 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foo.7.1 foo.5.3 foo.5.2 tmp-ra.4)))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (set! foo.5.2 1)
                                 (set! foo.5.3 foo.5.2)
                                 (set! foo.7.1 foo.5.3)
                                 (set! rax foo.7.1)
                                 (jump tmp-ra.4 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames (() ()))
             (locals (bat.8.12 tmp.24 tmp.22 tmp.23 tmp-ra.15 bat.8.11 tmp.21 foobar.3.10 tmp.20)))
            (define L.func.0.1
              ((new-frames (()))
               (locals (bat.8.5 ball.4.4 tmp.16 bat.7.2 foobar.3.3 tmp-ra.13 bar.2.1 tmp.17)))
              (begin
                (set! tmp-ra.13 r15)
                (set! foobar.3.3 rdi)
                (set! bat.7.2 rsi)
                (set! bar.2.1 rdx)
                (set! tmp.16 -529343887)
                (set! tmp.16 (* tmp.16 -1285114971))
                (set! ball.4.4 tmp.16)
                (return-point L.rp.3
                              (begin
                                (set! rdx bar.2.1)
                                (set! rsi ball.4.4)
                                (set! rdi ball.4.4)
                                (set! r15 L.rp.3)
                                (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                (set! bat.8.5 rax)
                (if (begin
                      (set! tmp.17 1981945067)
                      (= tmp.17 bar.2.1))
                    (begin
                      (set! rax -195961595)
                      (jump tmp-ra.13 rbp rax))
                    (begin
                      (set! rax 9223372036854775807)
                      (jump tmp-ra.13 rbp rax)))))
      (define L.fn.1.2
        ((new-frames (())) (locals (tmp.19 foobar.1.9 bar.9.7 foobar.1.8 tmp.18 bat.8.6 tmp-ra.14)))
        (begin
          (set! tmp-ra.14 r15)
          (set! bat.8.6 rdi)
          (set! tmp.18 -73068505)
          (set! tmp.18 (+ tmp.18 -9223372036854775808))
          (set! foobar.1.8 tmp.18)
          (if (<= bat.8.6 -9223372036854775808)
              (set! bar.9.7 bat.8.6)
              (set! bar.9.7 -241738702))
          (return-point L.rp.4
                        (begin
                          (set! rdx 0)
                          (set! rsi 9223372036854775807)
                          (set! rdi bat.8.6)
                          (set! r15 L.rp.4)
                          (jump L.func.0.1 rbp r15 rdi rsi rdx)))
          (set! foobar.1.9 rax)
          (set! tmp.19 1)
          (set! tmp.19 (+ tmp.19 foobar.1.9))
          (set! rax tmp.19)
          (jump tmp-ra.14 rbp rax)))
      (begin
        (set! tmp-ra.15 r15)
        (return-point L.rp.5
                      (begin
                        (set! rdx 9223372036854775807)
                        (set! rsi 9223372036854775807)
                        (set! rdi 0)
                        (set! r15 L.rp.5)
                        (jump L.func.0.1 rbp r15 rdi rsi rdx)))
        (set! foobar.3.10 rax)
        (if (not (if (begin
                       (set! tmp.20 -9223372036854775808)
                       (= tmp.20 649827574))
                     (begin
                       (set! tmp.21 -9223372036854775808)
                       (< tmp.21 foobar.3.10))
                     (= foobar.3.10 -9223372036854775808)))
            (if (begin
                  (set! tmp.22 -9223372036854775808)
                  (< tmp.22 -9223372036854775808))
                (begin
                  (set! tmp.23 9223372036854775807)
                  (set! tmp.23 (- tmp.23 foobar.3.10))
                  (set! rax tmp.23)
                  (jump tmp-ra.15 rbp rax))
                (begin
                  (set! bat.8.11 foobar.3.10)
                  (set! rax bat.8.11)
                  (jump tmp-ra.15 rbp rax)))
            (begin
              (return-point L.rp.6
                            (begin
                              (set! rdx 1)
                              (set! rsi 9223372036854775807)
                              (set! rdi 2001362815)
                              (set! r15 L.rp.6)
                              (jump L.func.0.1 rbp r15 rdi rsi rdx)))
              (set! bat.8.12 rax)
              (set! tmp.24 bat.8.12)
              (set! tmp.24 (* tmp.24 foobar.3.10))
              (set! rax tmp.24)
              (jump tmp-ra.15 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.20)))
            (define L.tmp.0.1
              ((new-frames ()) (locals (tmp-ra.17)))
              (begin
                (set! tmp-ra.17 r15)
                (set! r8 1013001136)
                (set! rcx 0)
                (set! rdx 1)
                (set! rsi -9223372036854775808)
                (set! rdi -9223372036854775808)
                (set! r15 tmp-ra.17)
                (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8)))
      (define L.tmp.1.2
        ((new-frames ()) (locals (ball.4.9 foo.3.8
                                           foo.3.10
                                           foobar.2.1
                                           foobar.5.2
                                           foo.3.3
                                           ball.4.4
                                           bar.0.5
                                           bar.9.6
                                           foo.7.7
                                           tmp-ra.18)))
        (begin
          (set! tmp-ra.18 r15)
          (set! foo.7.7 rdi)
          (set! bar.9.6 rsi)
          (set! bar.0.5 rdx)
          (set! ball.4.4 rcx)
          (set! foo.3.3 r8)
          (set! foobar.5.2 r9)
          (set! foobar.2.1 fv0)
          (if (begin
                (set! ball.4.9 foo.7.7)
                (< bar.9.6 0))
              (begin
                (set! foo.3.10 ball.4.4)
                (set! foo.3.8 -224488027))
              (if (= foobar.2.1 bar.0.5)
                  (set! foo.3.8 foobar.2.1)
                  (set! foo.3.8 foobar.2.1)))
          (set! r8 1)
          (set! rcx foobar.5.2)
          (set! rdx -1015791473)
          (set! rsi bar.0.5)
          (set! rdi -9223372036854775808)
          (set! r15 tmp-ra.18)
          (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8)))
      (define L.fn.2.3
        ((new-frames ())
         (locals (foobar.5.16 foobar.5.11 bar.9.12 bar.6.13 ball.4.14 foo.3.15 tmp-ra.19)))
        (begin
          (set! tmp-ra.19 r15)
          (set! foo.3.15 rdi)
          (set! ball.4.14 rsi)
          (set! bar.6.13 rdx)
          (set! bar.9.12 rcx)
          (set! foobar.5.11 r8)
          (set! foobar.5.16 bar.9.12)
          (set! r8 1)
          (set! rcx 1459656882)
          (set! rdx 0)
          (set! rsi -9223372036854775808)
          (set! rdi 0)
          (set! r15 tmp-ra.19)
          (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8)))
      (begin
        (set! tmp-ra.20 r15)
        (set! r8 1)
        (set! rcx 1648096326)
        (set! rdx 9223372036854775807)
        (set! rsi 1)
        (set! rdi 9223372036854775807)
        (set! r15 tmp-ra.20)
        (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.15 tmp-ra.11)))
            (define L.func.0.1
              ((new-frames ()) (locals (tmp.12 foobar.8.1 foo.1.2 bat.7.3 tmp-ra.9)))
              (begin
                (set! tmp-ra.9 r15)
                (set! bat.7.3 rdi)
                (set! foo.1.2 rsi)
                (set! foobar.8.1 rdx)
                (set! tmp.12 1903463490)
                (set! tmp.12 (* tmp.12 -9223372036854775808))
                (set! rax tmp.12)
                (jump tmp-ra.9 rbp rax)))
      (define L.func.1.2
        ((new-frames ())
         (locals (tmp.13 foobar.9.7 bat.7.6 bat.0.4 foobar.4.8 tmp-ra.10 bar.3.5 tmp.14)))
        (begin
          (set! tmp-ra.10 r15)
          (set! foobar.9.7 rdi)
          (set! bat.7.6 rsi)
          (set! bar.3.5 rdx)
          (set! bat.0.4 rcx)
          (set! tmp.13 -9223372036854775808)
          (set! tmp.13 (- tmp.13 foobar.9.7))
          (set! foobar.4.8 tmp.13)
          (if (begin
                (set! tmp.14 9223372036854775807)
                (> tmp.14 bar.3.5))
              (if (< bat.7.6 bat.0.4)
                  (begin
                    (set! rax foobar.4.8)
                    (jump tmp-ra.10 rbp rax))
                  (begin
                    (set! rax bat.7.6)
                    (jump tmp-ra.10 rbp rax)))
              (if (>= bat.0.4 1408489810)
                  (begin
                    (set! rax foobar.4.8)
                    (jump tmp-ra.10 rbp rax))
                  (begin
                    (set! rax bat.7.6)
                    (jump tmp-ra.10 rbp rax))))))
      (begin
        (set! tmp-ra.11 r15)
        (set! tmp.15 977777990)
        (set! tmp.15 (* tmp.15 900224161))
        (set! rax tmp.15)
        (jump tmp-ra.11 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.6)))
            (define L.func.0.1
              ((new-frames (())) (locals (bar.6.4 foo.9.1 foobar.8.3 foobar.1.2 tmp-ra.5 tmp.7)))
              (begin
                (set! tmp-ra.5 r15)
                (set! foobar.8.3 rdi)
                (set! foobar.1.2 rsi)
                (set! foo.9.1 rdx)
                (return-point L.rp.2
                              (begin
                                (set! rdx 9223372036854775807)
                                (set! rsi -1363029646)
                                (set! rdi 9223372036854775807)
                                (set! r15 L.rp.2)
                                (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                (set! bar.6.4 rax)
                (if (begin
                      (set! tmp.7 9223372036854775807)
                      (= tmp.7 0))
                    (begin
                      (set! rdx foobar.1.2)
                      (set! rsi foobar.1.2)
                      (set! rdi 719591632)
                      (set! r15 tmp-ra.5)
                      (jump L.func.0.1 rbp r15 rdi rsi rdx))
                    (if (>= foo.9.1 1396041917)
                        (begin
                          (set! rax -1711968134)
                          (jump tmp-ra.5 rbp rax))
                        (begin
                          (set! rax foobar.8.3)
                          (jump tmp-ra.5 rbp rax))))))
      (begin
        (set! tmp-ra.6 r15)
        (set! rdx 0)
        (set! rsi 9223372036854775807)
        (set! rdi -9223372036854775808)
        (set! r15 tmp-ra.6)
        (jump L.func.0.1 rbp r15 rdi rsi rdx))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.11)))
                               (define L.x.0.1
                                 ((new-frames (())) (locals (tmp-ra.8 foobar.2.1 bar.5.2 tmp.12)))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (if (begin
                                         (set! tmp.12 0)
                                         (<= tmp.12 1773437967))
                                       (begin
                                         (return-point L.rp.4
                                                       (begin
                                                         (set! rdi 1456910402)
                                                         (set! r15 L.rp.4)
                                                         (jump L.tmp.2.3 rbp r15 rdi)))
                                         (set! foobar.2.1 rax)
                                         (set! bar.5.2 -9223372036854775808)
                                         (set! rax 1)
                                         (jump tmp-ra.8 rbp rax))
                                       (begin
                                         (set! rdi -9223372036854775808)
                                         (set! r15 tmp-ra.8)
                                         (jump L.tmp.2.3 rbp r15 rdi)))))
                         (define L.fn.1.2
                           ((new-frames ()) (locals (bat.1.3 foo.9.4 foobar.3.5 bat.6.6 tmp-ra.9)))
                           (begin
                             (set! tmp-ra.9 r15)
                             (set! bat.6.6 rdi)
                             (set! foobar.3.5 rsi)
                             (set! foo.9.4 rdx)
                             (set! bat.1.3 rcx)
                             (set! rdi foo.9.4)
                             (set! r15 tmp-ra.9)
                             (jump L.tmp.2.3 rbp r15 rdi)))
                         (define L.tmp.2.3
                           ((new-frames ()) (locals (bat.1.7 tmp-ra.10)))
                           (begin
                             (set! tmp-ra.10 r15)
                             (set! bat.1.7 rdi)
                             (set! rax bat.1.7)
                             (jump tmp-ra.10 rbp rax)))
                         (begin
                           (set! tmp-ra.11 r15)
                           (set! rdi 0)
                           (set! r15 tmp-ra.11)
                           (jump L.tmp.2.3 rbp r15 rdi))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (foo.5.13 foo.6.15 tmp.22 bat.0.14 tmp-ra.18)))
            (define L.fn.0.1
              ((new-frames ()) (locals (bat.1.3 tmp.19 foo.5.4 foo.5.1 foobar.4.2 tmp-ra.16)))
              (begin
                (set! tmp-ra.16 r15)
                (set! foobar.4.2 rdi)
                (set! foo.5.1 rsi)
                (set! foo.5.4 foobar.4.2)
                (set! tmp.19 foobar.4.2)
                (set! tmp.19 (+ tmp.19 foo.5.4))
                (set! bat.1.3 tmp.19)
                (set! rsi foo.5.1)
                (set! rdi 0)
                (set! r15 tmp-ra.16)
                (jump L.fn.0.1 rbp r15 rdi rsi)))
      (define L.tmp.1.2
        ((new-frames ()) (locals (bat.1.6 foobar.3.12
                                          foo.2.8
                                          bat.9.11
                                          tmp.21
                                          foobar.4.7
                                          tmp-ra.17
                                          tmp.20
                                          bar.7.10
                                          bat.9.5
                                          bat.0.9)))
        (begin
          (set! tmp-ra.17 r15)
          (set! bat.0.9 rdi)
          (set! foo.2.8 rsi)
          (set! foobar.4.7 rdx)
          (set! bat.1.6 rcx)
          (set! bat.9.5 r8)
          (if (if (true)
                  (< bat.9.5 bat.0.9)
                  (begin
                    (set! bar.7.10 bat.0.9)
                    (begin
                      (set! tmp.20 0)
                      (<= tmp.20 -508327908))))
              (begin
                (if (begin
                      (set! tmp.21 167876306)
                      (<= tmp.21 bat.0.9))
                    (set! bat.9.11 44784438)
                    (set! bat.9.11 -874603706))
                (set! r8 foobar.4.7)
                (set! rcx foobar.4.7)
                (set! rdx 0)
                (set! rsi 696038140)
                (set! rdi -9223372036854775808)
                (set! r15 tmp-ra.17)
                (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8))
              (if (begin
                    (set! foobar.3.12 bat.9.5)
                    (= bat.1.6 0))
                  (if (< foobar.4.7 foobar.4.7)
                      (begin
                        (set! rax foo.2.8)
                        (jump tmp-ra.17 rbp rax))
                      (begin
                        (set! rax -727094500)
                        (jump tmp-ra.17 rbp rax)))
                  (begin
                    (set! rsi -9223372036854775808)
                    (set! rdi bat.0.9)
                    (set! r15 tmp-ra.17)
                    (jump L.fn.0.1 rbp r15 rdi rsi))))))
      (begin
        (set! tmp-ra.18 r15)
        (if (begin
              (set! tmp.22 9223372036854775807)
              (<= tmp.22 0))
            (set! bat.0.14 0)
            (set! bat.0.14 93609173))
        (set! foo.6.15 bat.0.14)
        (set! foo.5.13 foo.6.15)
        (set! rax foo.5.13)
        (jump tmp-ra.18 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (foobar.4.3 bat.1.2 foobar.4.5 tmp-ra.6 foo.0.4 bar.7.1 tmp.7)))
            (begin
              (set! tmp-ra.6 r15)
              (set! bat.1.2 -9223372036854775808)
              (set! foobar.4.3 0)
              (set! bar.7.1 foobar.4.3)
              (if (begin
                    (set! foo.0.4 bar.7.1)
                    (begin
                      (set! tmp.7 1)
                      (<= tmp.7 -9223372036854775808)))
                  (begin
                    (set! rax bar.7.1)
                    (jump tmp-ra.6 rbp rax))
                  (begin
                    (set! foobar.4.5 bar.7.1)
                    (set! rax 1974766267)
                    (jump tmp-ra.6 rbp rax))))
      ))
  (check-by-interp-v6 '(module ((new-frames (() ())) (locals (foobar.6.5 tmp-ra.7 ball.3.4 tmp.8)))
                               (define L.x.0.1
                                 ((new-frames ()) (locals (foobar.6.1 foo.8.2 foobar.5.3 tmp-ra.6)))
                                 (begin
                                   (set! tmp-ra.6 r15)
                                   (set! foobar.5.3 rdi)
                                   (set! foo.8.2 rsi)
                                   (set! foobar.6.1 rdx)
                                   (set! rdx foobar.5.3)
                                   (set! rsi foobar.5.3)
                                   (set! rdi 0)
                                   (set! r15 tmp-ra.6)
                                   (jump L.x.0.1 rbp r15 rdi rsi rdx)))
                         (begin
                           (set! tmp-ra.7 r15)
                           (if (begin
                                 (begin
                                   (return-point L.rp.2
                                                 (begin
                                                   (set! rdx 0)
                                                   (set! rsi 9223372036854775807)
                                                   (set! rdi 1)
                                                   (set! r15 L.rp.2)
                                                   (jump L.x.0.1 rbp r15 rdi rsi rdx)))
                                   (set! ball.3.4 rax))
                                 (begin
                                   (set! tmp.8 9223372036854775807)
                                   (< tmp.8 ball.3.4)))
                               (begin
                                 (set! rdx 1)
                                 (set! rsi -9223372036854775808)
                                 (set! rdi 1)
                                 (set! r15 tmp-ra.7)
                                 (jump L.x.0.1 rbp r15 rdi rsi rdx))
                               (begin
                                 (return-point L.rp.3
                                               (begin
                                                 (set! rdx -1530356459)
                                                 (set! rsi 9223372036854775807)
                                                 (set! rdi 9223372036854775807)
                                                 (set! r15 L.rp.3)
                                                 (jump L.x.0.1 rbp r15 rdi rsi rdx)))
                                 (set! foobar.6.5 rax)
                                 (if (= foobar.6.5 foobar.6.5)
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.7 rbp rax))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.7 rbp rax))))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foo.1.10 tmp-ra.12)))
                               (define L.func.0.1
                                 ((new-frames ()) (locals (bat.6.7 bat.5.2
                                                                   foobar.9.3
                                                                   foo.1.4
                                                                   foobar.2.5
                                                                   bar.0.6
                                                                   foo.1.9
                                                                   foobar.8.1
                                                                   tmp-ra.11
                                                                   foo.1.8)))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (set! bar.0.6 rdi)
                                   (set! foobar.2.5 rsi)
                                   (set! foo.1.4 rdx)
                                   (set! foobar.9.3 rcx)
                                   (set! bat.5.2 r8)
                                   (set! foobar.8.1 r9)
                                   (set! bat.6.7 -951184591)
                                   (if (false)
                                       (begin
                                         (set! foo.1.8 -9223372036854775808)
                                         (set! rax foo.1.8)
                                         (jump tmp-ra.11 rbp rax))
                                       (begin
                                         (set! foo.1.9 310790521)
                                         (set! rax foobar.8.1)
                                         (jump tmp-ra.11 rbp rax)))))
                         (begin
                           (set! tmp-ra.12 r15)
                           (set! foo.1.10 -1379426851)
                           (set! rax 488563830)
                           (jump tmp-ra.12 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.10 tmp-ra.8 foobar.4.6 foo.5.5)))
            (define L.func.0.1
              ((new-frames ()) (locals (foo.5.4 tmp-ra.7 ball.0.1 foo.5.2 ball.2.3 tmp.9)))
              (begin
                (set! tmp-ra.7 r15)
                (set! ball.2.3 rdi)
                (set! foo.5.2 rsi)
                (set! ball.0.1 rdx)
                (if (if (begin
                          (set! tmp.9 0)
                          (= tmp.9 ball.2.3))
                        (false)
                        (if (<= ball.0.1 -483103791)
                            (= foo.5.2 ball.2.3)
                            (= ball.2.3 foo.5.2)))
                    (begin
                      (set! rdx 1)
                      (set! rsi 1)
                      (set! rdi foo.5.2)
                      (set! r15 tmp-ra.7)
                      (jump L.func.0.1 rbp r15 rdi rsi rdx))
                    (if (true)
                        (begin
                          (set! foo.5.4 ball.2.3)
                          (set! rax foo.5.4)
                          (jump tmp-ra.7 rbp rax))
                        (begin
                          (set! rdx 1)
                          (set! rsi foo.5.2)
                          (set! rdi foo.5.2)
                          (set! r15 tmp-ra.7)
                          (jump L.func.0.1 rbp r15 rdi rsi rdx))))))
      (begin
        (set! tmp-ra.8 r15)
        (set! foo.5.5 -1766715399)
        (if (not (not (< foo.5.5 foo.5.5)))
            (begin
              (if (< foo.5.5 0)
                  (set! foobar.4.6 9223372036854775807)
                  (set! foobar.4.6 foo.5.5))
              (set! rax -1170116362)
              (jump tmp-ra.8 rbp rax))
            (begin
              (set! tmp.10 0)
              (set! tmp.10 (* tmp.10 0))
              (set! rax tmp.10)
              (jump tmp-ra.8 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames (())) (locals (tmp.9 tmp.10 tmp.11 tmp.12 tmp-ra.8 tmp.13 foo.2.6)))
            (define L.tmp.0.1
              ((new-frames (())) (locals (ball.4.4 foo.6.5 foo.2.1 ball.3.2 foo.8.3 tmp-ra.7)))
              (begin
                (set! tmp-ra.7 r15)
                (set! foo.8.3 rdi)
                (set! ball.3.2 rsi)
                (set! foo.2.1 rdx)
                (set! foo.6.5 1591590730)
                (return-point L.rp.2
                              (begin
                                (set! rdx foo.2.1)
                                (set! rsi foo.2.1)
                                (set! rdi 1001483234)
                                (set! r15 L.rp.2)
                                (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
                (set! ball.4.4 rax)
                (set! rdx ball.3.2)
                (set! rsi foo.2.1)
                (set! rdi -9223372036854775808)
                (set! r15 tmp-ra.7)
                (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
      (begin
        (set! tmp-ra.8 r15)
        (if (if (begin
                  (set! tmp.9 1)
                  (!= tmp.9 0))
                (begin
                  (set! tmp.10 -9223372036854775808)
                  (<= tmp.10 9223372036854775807))
                (begin
                  (set! tmp.11 0)
                  (= tmp.11 0)))
            (begin
              (return-point L.rp.3
                            (begin
                              (set! rdx 1)
                              (set! rsi 1188321444)
                              (set! rdi -1860695803)
                              (set! r15 L.rp.3)
                              (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
              (set! foo.2.6 rax))
            (begin
              (set! tmp.12 -9223372036854775808)
              (set! tmp.12 (+ tmp.12 -335192473))
              (set! foo.2.6 tmp.12)))
        (if (if (!= foo.2.6 foo.2.6)
                (< foo.2.6 foo.2.6)
                (begin
                  (set! tmp.13 -1823864705)
                  (= tmp.13 -2078605817)))
            (begin
              (set! rdx 1739531838)
              (set! rsi foo.2.6)
              (set! rdi foo.2.6)
              (set! r15 tmp-ra.8)
              (jump L.tmp.0.1 rbp r15 rdi rsi rdx))
            (begin
              (set! rdx -1707829089)
              (set! rsi -2103046426)
              (set! rdi 0)
              (set! r15 tmp-ra.8)
              (jump L.tmp.0.1 rbp r15 rdi rsi rdx))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (bat.1.8 tmp-ra.12)))
                               (define L.tmp.0.1
                                 ((new-frames ()) (locals (bar.9.1 bar.4.2 bar.0.3 tmp-ra.9)))
                                 (begin
                                   (set! tmp-ra.9 r15)
                                   (set! bar.0.3 rdi)
                                   (set! bar.4.2 rsi)
                                   (set! bar.9.1 rdx)
                                   (set! rdi 9223372036854775807)
                                   (set! r15 tmp-ra.9)
                                   (jump L.fn.1.2 rbp r15 rdi)))
                         (define L.fn.1.2
                           ((new-frames ()) (locals (tmp.14 bar.9.4 tmp-ra.10 tmp.13)))
                           (begin
                             (set! tmp-ra.10 r15)
                             (set! bar.9.4 rdi)
                             (if (begin
                                   (set! tmp.13 1)
                                   (> tmp.13 1))
                                 (begin
                                   (set! rdx -9223372036854775808)
                                   (set! rsi -9223372036854775808)
                                   (set! rdi bar.9.4)
                                   (set! r15 tmp-ra.10)
                                   (jump L.x.2.3 rbp r15 rdi rsi rdx))
                                 (if (if (> bar.9.4 9223372036854775807)
                                         (<= bar.9.4 2069349298)
                                         (begin
                                           (set! tmp.14 327435684)
                                           (= tmp.14 bar.9.4)))
                                     (begin
                                       (set! rdx bar.9.4)
                                       (set! rsi bar.9.4)
                                       (set! rdi 937688474)
                                       (set! r15 tmp-ra.10)
                                       (jump L.x.2.3 rbp r15 rdi rsi rdx))
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump tmp-ra.10 rbp rax))))))
                         (define L.x.2.3
                           ((new-frames ()) (locals (bar.4.5 ball.8.6 foobar.6.7 tmp-ra.11)))
                           (begin
                             (set! tmp-ra.11 r15)
                             (set! foobar.6.7 rdi)
                             (set! ball.8.6 rsi)
                             (set! bar.4.5 rdx)
                             (set! rdx bar.4.5)
                             (set! rsi -845528888)
                             (set! rdi foobar.6.7)
                             (set! r15 tmp-ra.11)
                             (jump L.x.2.3 rbp r15 rdi rsi rdx)))
                         (begin
                           (set! tmp-ra.12 r15)
                           (set! bat.1.8 0)
                           (set! rax bat.1.8)
                           (jump tmp-ra.12 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (ball.3.17 tmp.24 tmp-ra.21)))
            (define L.x.0.1
              ((new-frames ()) (locals (ball.7.2 bar.5.4
                                                 tmp.23
                                                 tmp.22
                                                 foobar.6.3
                                                 bar.9.6
                                                 tmp-ra.18
                                                 foobar.4.5
                                                 foobar.2.7
                                                 bat.1.1)))
              (begin
                (set! tmp-ra.18 r15)
                (set! foobar.4.5 rdi)
                (set! bar.5.4 rsi)
                (set! foobar.6.3 rdx)
                (set! ball.7.2 rcx)
                (set! bat.1.1 r8)
                (if (false)
                    (if (begin
                          (set! bar.9.6 foobar.6.3)
                          (begin
                            (set! tmp.22 0)
                            (< tmp.22 foobar.6.3)))
                        (begin
                          (set! rsi -9223372036854775808)
                          (set! rdi 0)
                          (set! r15 tmp-ra.18)
                          (jump L.x.1.2 rbp r15 rdi rsi))
                        (begin
                          (set! foobar.2.7 bat.1.1)
                          (set! rax foobar.4.5)
                          (jump tmp-ra.18 rbp rax)))
                    (if (true)
                        (if (begin
                              (set! tmp.23 -9223372036854775808)
                              (!= tmp.23 1))
                            (begin
                              (set! rax 0)
                              (jump tmp-ra.18 rbp rax))
                            (begin
                              (set! rax 849007740)
                              (jump tmp-ra.18 rbp rax)))
                        (begin
                          (set! rax foobar.4.5)
                          (jump tmp-ra.18 rbp rax))))))
      (define L.x.1.2
        ((new-frames ()) (locals (foobar.4.10 bar.0.8 foobar.6.9 tmp-ra.19)))
        (begin
          (set! tmp-ra.19 r15)
          (set! foobar.6.9 rdi)
          (set! bar.0.8 rsi)
          (set! foobar.4.10 bar.0.8)
          (set! r8 9223372036854775807)
          (set! rcx 0)
          (set! rdx foobar.4.10)
          (set! rsi 0)
          (set! rdi foobar.6.9)
          (set! r15 tmp-ra.19)
          (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))
      (define L.x.2.3
        ((new-frames (()))
         (locals (bar.8.16 bar.5.11 ball.3.12 bar.8.13 foobar.4.14 foobar.2.15 tmp-ra.20)))
        (begin
          (set! tmp-ra.20 r15)
          (set! foobar.2.15 rdi)
          (set! foobar.4.14 rsi)
          (set! bar.8.13 rdx)
          (set! ball.3.12 rcx)
          (set! bar.5.11 r8)
          (return-point L.rp.4
                        (begin
                          (set! rsi bar.5.11)
                          (set! rdi bar.5.11)
                          (set! r15 L.rp.4)
                          (jump L.x.1.2 rbp r15 rdi rsi)))
          (set! bar.8.16 rax)
          (set! rsi 1)
          (set! rdi -1927041153)
          (set! r15 tmp-ra.20)
          (jump L.x.1.2 rbp r15 rdi rsi)))
      (begin
        (set! tmp-ra.21 r15)
        (set! tmp.24 1)
        (set! tmp.24 (* tmp.24 -394936001))
        (set! ball.3.17 tmp.24)
        (set! r8 ball.3.17)
        (set! rcx -9223372036854775808)
        (set! rdx 0)
        (set! rsi ball.3.17)
        (set! rdi ball.3.17)
        (set! r15 tmp-ra.21)
        (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.9)))
                               (define L.tmp.0.1
                                 ((new-frames ()) (locals (bar.7.1 bat.8.2 tmp-ra.7)))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (set! bat.8.2 rdi)
                                   (set! bar.7.1 rsi)
                                   (set! rcx 9223372036854775807)
                                   (set! rdx bat.8.2)
                                   (set! rsi bat.8.2)
                                   (set! rdi bat.8.2)
                                   (set! r15 tmp-ra.7)
                                   (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx)))
                         (define L.fn.1.2
                           ((new-frames ()) (locals (bat.8.3 bar.9.4 foobar.6.5 bar.3.6 tmp-ra.8)))
                           (begin
                             (set! tmp-ra.8 r15)
                             (set! bar.3.6 rdi)
                             (set! foobar.6.5 rsi)
                             (set! bar.9.4 rdx)
                             (set! bat.8.3 rcx)
                             (set! rsi bar.9.4)
                             (set! rdi bat.8.3)
                             (set! r15 tmp-ra.8)
                             (jump L.tmp.0.1 rbp r15 rdi rsi)))
                         (begin
                           (set! tmp-ra.9 r15)
                           (set! rsi 698097472)
                           (set! rdi -880757424)
                           (set! r15 tmp-ra.9)
                           (jump L.tmp.0.1 rbp r15 rdi rsi))))
  (check-by-interp-v6
   '(module ((new-frames (())) (locals (foo.5.6 tmp-ra.8 tmp.9)))
            (define L.tmp.0.1
              ((new-frames ()) (locals (foo.6.1 bar.2.2 ball.4.3 bar.8.4 bat.3.5 tmp-ra.7)))
              (begin
                (set! tmp-ra.7 r15)
                (set! bat.3.5 rdi)
                (set! bar.8.4 rsi)
                (set! ball.4.3 rdx)
                (set! bar.2.2 rcx)
                (set! foo.6.1 r8)
                (set! rax foo.6.1)
                (jump tmp-ra.7 rbp rax)))
      (begin
        (set! tmp-ra.8 r15)
        (return-point L.rp.2
                      (begin
                        (set! r8 -9223372036854775808)
                        (set! rcx 1)
                        (set! rdx 0)
                        (set! rsi -9223372036854775808)
                        (set! rdi 1)
                        (set! r15 L.rp.2)
                        (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
        (set! foo.5.6 rax)
        (if (begin
              (set! tmp.9 -9223372036854775808)
              (= tmp.9 175566669))
            (begin
              (set! rax -1855219983)
              (jump tmp-ra.8 rbp rax))
            (begin
              (set! rax foo.5.6)
              (jump tmp-ra.8 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames (())) (locals (bar.5.10 tmp-ra.14 bat.3.8 bar.7.9)))
            (define L.proc.0.1
              ((new-frames ())
               (locals (tmp.15 bar.5.3 tmp.16 bar.2.4 ball.1.1 tmp-ra.11 bar.6.5 bar.2.2 tmp.17)))
              (begin
                (set! tmp-ra.11 r15)
                (set! ball.1.1 rdi)
                (if (begin
                      (set! bar.5.3 1541307282)
                      (begin
                        (set! tmp.15 9223372036854775807)
                        (= tmp.15 -194099637)))
                    (begin
                      (set! tmp.16 ball.1.1)
                      (set! tmp.16 (- tmp.16 -1702731989))
                      (set! bar.2.2 tmp.16))
                    (begin
                      (set! bar.2.4 ball.1.1)
                      (set! bar.2.2 ball.1.1)))
                (if (not (begin
                           (set! tmp.17 -9223372036854775808)
                           (= tmp.17 bar.2.2)))
                    (begin
                      (set! bar.6.5 1)
                      (set! rax bar.2.2)
                      (jump tmp-ra.11 rbp rax))
                    (begin
                      (set! rdi 0)
                      (set! r15 tmp-ra.11)
                      (jump L.proc.0.1 rbp r15 rdi)))))
      (define L.fn.1.2
        ((new-frames ()) (locals (tmp.18 tmp-ra.12)))
        (begin
          (set! tmp-ra.12 r15)
          (set! tmp.18 9223372036854775807)
          (set! tmp.18 (+ tmp.18 1))
          (set! rax tmp.18)
          (jump tmp-ra.12 rbp rax)))
      (define L.fn.2.3
        ((new-frames ()) (locals (bar.6.7 tmp.19 bat.9.6 tmp-ra.13)))
        (begin
          (set! tmp-ra.13 r15)
          (set! bat.9.6 rdi)
          (set! tmp.19 1)
          (set! tmp.19 (* tmp.19 0))
          (set! bar.6.7 tmp.19)
          (set! r15 tmp-ra.13)
          (jump L.fn.1.2 rbp r15)))
      (begin
        (set! tmp-ra.14 r15)
        (if (true)
            (begin
              (return-point L.rp.4
                            (begin
                              (set! rdi 1)
                              (set! r15 L.rp.4)
                              (jump L.fn.2.3 rbp r15 rdi)))
              (set! bat.3.8 rax)
              (set! bar.7.9 bat.3.8)
              (set! rax 1)
              (jump tmp-ra.14 rbp rax))
            (begin
              (set! bar.5.10 -1579827217)
              (set! rdi bar.5.10)
              (set! r15 tmp-ra.14)
              (jump L.fn.2.3 rbp r15 rdi))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.26 tmp-ra.20)))
            (define L.x.0.1
              ((new-frames (())) (locals (tmp.21 foobar.7.7
                                                 ball.4.1
                                                 foo.9.3
                                                 foobar.5.4
                                                 bar.6.5
                                                 tmp.23
                                                 bat.3.6
                                                 tmp-ra.17
                                                 tmp.22
                                                 foobar.7.2)))
              (begin
                (set! tmp-ra.17 r15)
                (set! bar.6.5 rdi)
                (set! foobar.5.4 rsi)
                (set! foo.9.3 rdx)
                (set! foobar.7.2 rcx)
                (set! ball.4.1 r8)
                (return-point L.rp.4
                              (begin
                                (set! r8 1)
                                (set! rcx foo.9.3)
                                (set! rdx ball.4.1)
                                (set! rsi ball.4.1)
                                (set! rdi 0)
                                (set! r15 L.rp.4)
                                (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))
                (set! foobar.7.7 rax)
                (set! tmp.21 foobar.7.7)
                (set! tmp.21 (- tmp.21 foobar.7.7))
                (set! bat.3.6 tmp.21)
                (if (true)
                    (begin
                      (set! tmp.22 -9223372036854775808)
                      (set! tmp.22 (* tmp.22 foobar.7.2))
                      (set! rax tmp.22)
                      (jump tmp-ra.17 rbp rax))
                    (if (begin
                          (set! tmp.23 -9223372036854775808)
                          (!= tmp.23 bat.3.6))
                        (begin
                          (set! rax foobar.7.2)
                          (jump tmp-ra.17 rbp rax))
                        (begin
                          (set! rax 0)
                          (jump tmp-ra.17 rbp rax))))))
      (define L.fn.1.2
        ((new-frames ())
         (locals
          (foobar.7.8 foo.2.12 ball.4.9 foo.8.10 ball.0.14 tmp-ra.18 foobar.1.11 foo.8.13 tmp.24)))
        (begin
          (set! tmp-ra.18 r15)
          (set! foo.2.12 rdi)
          (set! foobar.1.11 rsi)
          (set! foo.8.10 rdx)
          (set! ball.4.9 rcx)
          (set! foobar.7.8 r8)
          (if (false)
              (begin
                (if (begin
                      (set! tmp.24 -1658461695)
                      (!= tmp.24 9223372036854775807))
                    (set! foo.8.13 -9223372036854775808)
                    (set! foo.8.13 foobar.1.11))
                (set! rax 9223372036854775807)
                (jump tmp-ra.18 rbp rax))
              (if (false)
                  (if (= foo.8.10 1)
                      (begin
                        (set! rax ball.4.9)
                        (jump tmp-ra.18 rbp rax))
                      (begin
                        (set! rax 9223372036854775807)
                        (jump tmp-ra.18 rbp rax)))
                  (begin
                    (set! ball.0.14 foo.8.10)
                    (set! rax 1)
                    (jump tmp-ra.18 rbp rax))))))
      (define L.tmp.2.3
        ((new-frames ()) (locals (foo.8.16 tmp-ra.19 foobar.5.15 tmp.25)))
        (begin
          (set! tmp-ra.19 r15)
          (set! foo.8.16 1)
          (set! foobar.5.15 foo.8.16)
          (if (if (begin
                    (set! tmp.25 9223372036854775807)
                    (> tmp.25 foobar.5.15))
                  (>= foobar.5.15 9223372036854775807)
                  (<= foobar.5.15 foobar.5.15))
              (if (> foobar.5.15 foobar.5.15)
                  (begin
                    (set! rax 1)
                    (jump tmp-ra.19 rbp rax))
                  (begin
                    (set! rax foobar.5.15)
                    (jump tmp-ra.19 rbp rax)))
              (begin
                (set! r8 9223372036854775807)
                (set! rcx foobar.5.15)
                (set! rdx foobar.5.15)
                (set! rsi -126978532)
                (set! rdi foobar.5.15)
                (set! r15 tmp-ra.19)
                (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))))
      (begin
        (set! tmp-ra.20 r15)
        (set! tmp.26 -1293429216)
        (set! tmp.26 (* tmp.26 880066208))
        (set! rax tmp.26)
        (jump tmp-ra.20 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.21 ball.3.13 tmp-ra.16)))
            (define L.proc.0.1
              ((new-frames ()) (locals (bar.0.4 ball.3.2
                                                bar.4.6
                                                tmp-ra.14
                                                tmp.18
                                                foobar.5.5
                                                bar.0.7
                                                ball.8.1
                                                foo.7.3
                                                tmp.17)))
              (begin
                (set! tmp-ra.14 r15)
                (set! bar.4.6 rdi)
                (set! foobar.5.5 rsi)
                (set! bar.0.4 rdx)
                (set! foo.7.3 rcx)
                (set! ball.3.2 r8)
                (set! ball.8.1 r9)
                (if (not (if (begin
                               (set! tmp.17 0)
                               (> tmp.17 701262944))
                             (!= foo.7.3 9223372036854775807)
                             (< ball.8.1 ball.8.1)))
                    (if (true)
                        (if (begin
                              (set! tmp.18 1779018832)
                              (= tmp.18 ball.8.1))
                            (begin
                              (set! rax -9223372036854775808)
                              (jump tmp-ra.14 rbp rax))
                            (begin
                              (set! rax bar.4.6)
                              (jump tmp-ra.14 rbp rax)))
                        (begin
                          (set! bar.0.7 foo.7.3)
                          (set! rax foobar.5.5)
                          (jump tmp-ra.14 rbp rax)))
                    (begin
                      (set! r9 bar.4.6)
                      (set! r8 ball.3.2)
                      (set! rcx foo.7.3)
                      (set! rdx 9223372036854775807)
                      (set! rsi ball.8.1)
                      (set! rdi 1)
                      (set! r15 tmp-ra.14)
                      (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (define L.proc.1.2
        ((new-frames ())
         (locals (tmp.19 ball.3.11 tmp.20 bar.4.12 foobar.2.8 ball.8.9 bar.1.10 tmp-ra.15)))
        (begin
          (set! tmp-ra.15 r15)
          (set! bar.1.10 rdi)
          (set! ball.8.9 rsi)
          (set! foobar.2.8 rdx)
          (if (begin
                (set! tmp.19 -408033154)
                (<= tmp.19 bar.1.10))
              (begin
                (set! tmp.20 ball.8.9)
                (set! tmp.20 (+ tmp.20 bar.1.10))
                (set! ball.3.11 tmp.20))
              (begin
                (set! bar.4.12 ball.8.9)
                (set! ball.3.11 bar.4.12)))
          (set! rdx ball.8.9)
          (set! rsi bar.1.10)
          (set! rdi ball.8.9)
          (set! r15 tmp-ra.15)
          (jump L.proc.1.2 rbp r15 rdi rsi rdx)))
      (begin
        (set! tmp-ra.16 r15)
        (if (begin
              (set! tmp.21 1)
              (<= tmp.21 899234556))
            (set! ball.3.13 0)
            (set! ball.3.13 0))
        (set! r9 -9223372036854775808)
        (set! r8 1792291800)
        (set! rcx ball.3.13)
        (set! rdx 1961997671)
        (set! rsi ball.3.13)
        (set! rdi ball.3.13)
        (set! r15 tmp-ra.16)
        (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (tmp.17 bat.9.12 tmp.18 bat.2.13 bat.9.11 foo.4.10 tmp-ra.15 bat.8.9)))
            (define L.x.0.1
              ((new-frames ())
               (locals
                (tmp.16 ball.1.6 foo.0.7 foo.4.1 foo.5.4 foo.3.2 tmp-ra.14 foo.0.3 foo.3.8 ball.7.5)))
              (begin
                (set! tmp-ra.14 r15)
                (set! foo.5.4 rdi)
                (set! foo.0.3 rsi)
                (set! foo.3.2 rdx)
                (set! foo.4.1 rcx)
                (if (begin
                      (set! ball.1.6 foo.4.1)
                      (begin
                        (set! tmp.16 -9223372036854775808)
                        (<= tmp.16 -1549190542)))
                    (begin
                      (set! foo.0.7 1)
                      (set! ball.7.5 foo.3.2))
                    (set! ball.7.5 foo.3.2))
                (if (true)
                    (begin
                      (set! foo.3.8 foo.0.3)
                      (set! rax ball.7.5)
                      (jump tmp-ra.14 rbp rax))
                    (begin
                      (set! rcx foo.0.3)
                      (set! rdx -9223372036854775808)
                      (set! rsi foo.3.2)
                      (set! rdi foo.3.2)
                      (set! r15 tmp-ra.14)
                      (jump L.x.0.1 rbp r15 rdi rsi rdx rcx)))))
      (begin
        (set! tmp-ra.15 r15)
        (if (true)
            (set! bat.8.9 480297521)
            (begin
              (set! tmp.17 1)
              (set! tmp.17 (- tmp.17 0))
              (set! bat.8.9 tmp.17)))
        (if (= bat.8.9 0)
            (begin
              (set! bat.9.11 bat.8.9)
              (set! foo.4.10 0)
              (set! rcx foo.4.10)
              (set! rdx 0)
              (set! rsi 9223372036854775807)
              (set! rdi 9223372036854775807)
              (set! r15 tmp-ra.15)
              (jump L.x.0.1 rbp r15 rdi rsi rdx rcx))
            (if (begin
                  (set! bat.9.12 1)
                  (>= bat.8.9 1434817833))
                (begin
                  (set! tmp.18 -9223372036854775808)
                  (set! tmp.18 (* tmp.18 -1655015632))
                  (set! rax tmp.18)
                  (jump tmp-ra.15 rbp rax))
                (begin
                  (set! bat.2.13 -9223372036854775808)
                  (set! rax 1398310587)
                  (jump tmp-ra.15 rbp rax)))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.11 bar.8.9 tmp.13)))
            (define L.func.0.1
              ((new-frames ())
               (locals
                (foo.4.1 bat.1.7 foo.3.8 ball.0.5 ball.2.2 foo.5.3 tmp-ra.10 foo.6.6 foo.9.4 tmp.12)))
              (begin
                (set! tmp-ra.10 r15)
                (set! bat.1.7 rdi)
                (set! foo.6.6 rsi)
                (set! ball.0.5 rdx)
                (set! foo.9.4 rcx)
                (set! foo.5.3 r8)
                (set! ball.2.2 r9)
                (set! foo.4.1 fv0)
                (if (begin
                      (set! tmp.12 9223372036854775807)
                      (> tmp.12 -1225978347))
                    (if (if (> ball.0.5 1)
                            (> ball.2.2 -9223372036854775808)
                            (!= foo.5.3 -847185955))
                        (begin
                          (set! fv0 -260761950)
                          (set! r9 0)
                          (set! r8 -9223372036854775808)
                          (set! rcx foo.9.4)
                          (set! rdx foo.6.6)
                          (set! rsi -144908363)
                          (set! rdi 9223372036854775807)
                          (set! r15 tmp-ra.10)
                          (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0))
                        (if (> foo.9.4 foo.9.4)
                            (begin
                              (set! rax 0)
                              (jump tmp-ra.10 rbp rax))
                            (begin
                              (set! rax 1)
                              (jump tmp-ra.10 rbp rax))))
                    (begin
                      (set! foo.3.8 9223372036854775807)
                      (set! fv0 0)
                      (set! r9 foo.6.6)
                      (set! r8 foo.6.6)
                      (set! rcx 9223372036854775807)
                      (set! rdx -9223372036854775808)
                      (set! rsi -472335653)
                      (set! rdi -9223372036854775808)
                      (set! r15 tmp-ra.10)
                      (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
      (begin
        (set! tmp-ra.11 r15)
        (if (begin
              (set! tmp.13 1)
              (>= tmp.13 9223372036854775807))
            (begin
              (set! bar.8.9 1)
              (set! rax bar.8.9)
              (jump tmp-ra.11 rbp rax))
            (begin
              (set! rax -32529780)
              (jump tmp-ra.11 rbp rax))))))

  ;;

  ;; M6 tests; Added by Trevor on March 6th 2026, multiple bindings allowed per let
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.17 tmp-ra.13 tmp.16 tmp.15 tmp.14)))
            (define L.proc.0.1
              ((new-frames ())
               (locals (foobar.1.1 bat.8.2 foo.0.3 ball.7.4 ball.2.5 foo.5.6 ball.9.7 tmp-ra.10)))
              (begin
                (set! tmp-ra.10 r15)
                (set! ball.9.7 rdi)
                (set! foo.5.6 rsi)
                (set! ball.2.5 rdx)
                (set! ball.7.4 rcx)
                (set! foo.0.3 r8)
                (set! bat.8.2 r9)
                (set! foobar.1.1 fv0)
                (set! r15 tmp-ra.10)
                (jump L.tmp.1.2 rbp r15)))
      (define L.tmp.1.2
        ((new-frames ()) (locals (tmp-ra.11)))
        (begin
          (set! tmp-ra.11 r15)
          (set! rsi 0)
          (set! rdi 0)
          (set! r15 tmp-ra.11)
          (jump L.proc.2.3 rbp r15 rdi rsi)))
      (define L.proc.2.3
        ((new-frames ()) (locals (bat.8.8 foo.6.9 tmp-ra.12)))
        (begin
          (set! tmp-ra.12 r15)
          (set! foo.6.9 rdi)
          (set! bat.8.8 rsi)
          (set! fv0 1635273112)
          (set! r9 foo.6.9)
          (set! r8 bat.8.8)
          (set! rcx foo.6.9)
          (set! rdx 445965252)
          (set! rsi foo.6.9)
          (set! rdi bat.8.8)
          (set! r15 tmp-ra.12)
          (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.13 r15)
        (if (if (begin
                  (set! tmp.14 9223372036854775807)
                  (<= tmp.14 -9223372036854775808))
                (begin
                  (set! tmp.15 692968731)
                  (< tmp.15 0))
                (begin
                  (set! tmp.16 -1490931083)
                  (<= tmp.16 -14809197)))
            (begin
              (set! rax 1275113131)
              (jump tmp-ra.13 rbp rax))
            (if (begin
                  (set! tmp.17 -1702177019)
                  (<= tmp.17 -9223372036854775808))
                (begin
                  (set! rax 0)
                  (jump tmp-ra.13 rbp rax))
                (begin
                  (set! rax 1843455920)
                  (jump tmp-ra.13 rbp rax)))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (ball.0.8 foobar.4.9 bat.6.10 tmp-ra.12)))
            (define L.fn.0.1
              ((new-frames ())
               (locals (bat.7.1 bat.3.2 foobar.4.3 foo.8.4 bar.9.5 foo.2.6 bat.5.7 tmp-ra.11)))
              (begin
                (set! tmp-ra.11 r15)
                (set! bat.5.7 rdi)
                (set! foo.2.6 rsi)
                (set! bar.9.5 rdx)
                (set! foo.8.4 rcx)
                (set! foobar.4.3 r8)
                (set! bat.3.2 r9)
                (set! bat.7.1 fv0)
                (set! fv0 bat.3.2)
                (set! r9 foo.8.4)
                (set! r8 foo.8.4)
                (set! rcx 9223372036854775807)
                (set! rdx bat.5.7)
                (set! rsi -9223372036854775808)
                (set! rdi bat.3.2)
                (set! r15 tmp-ra.11)
                (jump L.fn.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.12 r15)
        (set! bat.6.10 9223372036854775807)
        (set! foobar.4.9 9223372036854775807)
        (set! ball.0.8 9223372036854775807)
        (set! rax foobar.4.9)
        (jump tmp-ra.12 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.13 tmp.17)))
            (define L.func.0.1
              ((new-frames (()))
               (locals
                (ball.4.4 tmp-ra.11 bar.2.5 foo.9.7 foo.9.3 foobar.5.2 bat.0.6 foo.6.1 tmp.14)))
              (begin
                (set! tmp-ra.11 r15)
                (set! bar.2.5 rdi)
                (set! ball.4.4 rsi)
                (set! foo.9.3 rdx)
                (set! foobar.5.2 rcx)
                (set! foo.6.1 r8)
                (if (true)
                    (begin
                      (set! foo.9.7 bar.2.5)
                      (return-point L.rp.3
                                    (begin
                                      (set! rdx -1140169546)
                                      (set! rsi foobar.5.2)
                                      (set! rdi foo.9.3)
                                      (set! r15 L.rp.3)
                                      (jump L.func.1.2 rbp r15 rdi rsi rdx)))
                      (set! bat.0.6 rax)
                      (set! tmp.14 foo.6.1)
                      (set! tmp.14 (+ tmp.14 bat.0.6))
                      (set! rax tmp.14)
                      (jump tmp-ra.11 rbp rax))
                    (begin
                      (set! rdx 9223372036854775807)
                      (set! rsi foobar.5.2)
                      (set! rdi foo.6.1)
                      (set! r15 tmp-ra.11)
                      (jump L.func.1.2 rbp r15 rdi rsi rdx)))))
      (define L.func.1.2
        ((new-frames ()) (locals (tmp.16 foo.6.9 tmp-ra.12 bat.0.10 foo.9.8 tmp.15)))
        (begin
          (set! tmp-ra.12 r15)
          (set! bat.0.10 rdi)
          (set! foo.6.9 rsi)
          (set! foo.9.8 rdx)
          (if (begin
                (set! tmp.15 9223372036854775807)
                (!= tmp.15 -47909185))
              (if (false)
                  (if (< foo.9.8 foo.9.8)
                      (begin
                        (set! rax bat.0.10)
                        (jump tmp-ra.12 rbp rax))
                      (begin
                        (set! rax -9223372036854775808)
                        (jump tmp-ra.12 rbp rax)))
                  (begin
                    (set! rdx foo.9.8)
                    (set! rsi foo.9.8)
                    (set! rdi bat.0.10)
                    (set! r15 tmp-ra.12)
                    (jump L.func.1.2 rbp r15 rdi rsi rdx)))
              (begin
                (set! tmp.16 -9223372036854775808)
                (set! tmp.16 (+ tmp.16 foo.6.9))
                (set! rax tmp.16)
                (jump tmp-ra.12 rbp rax)))))
      (begin
        (set! tmp-ra.13 r15)
        (if (begin
              (set! tmp.17 9223372036854775807)
              (> tmp.17 9223372036854775807))
            (begin
              (set! rax -877748660)
              (jump tmp-ra.13 rbp rax))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.13 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp.2 tmp-ra.1)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (set! tmp.2 -1640821439)
                                 (set! tmp.2 (+ tmp.2 -406700566))
                                 (set! rax tmp.2)
                                 (jump tmp-ra.1 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bar.7.9 bat.9.10 tmp-ra.13)))
            (define L.fn.0.1
              ((new-frames ()) (locals (ball.6.1 foo.2.2 tmp-ra.11)))
              (begin
                (set! tmp-ra.11 r15)
                (set! foo.2.2 rdi)
                (set! ball.6.1 rsi)
                (set! r9 foo.2.2)
                (set! r8 ball.6.1)
                (set! rcx -9223372036854775808)
                (set! rdx ball.6.1)
                (set! rsi foo.2.2)
                (set! rdi ball.6.1)
                (set! r15 tmp-ra.11)
                (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
      (define L.x.1.2
        ((new-frames ()) (locals (bar.7.3 foo.2.4 ball.5.5 foobar.1.6 foo.4.7 ball.0.8 tmp-ra.12)))
        (begin
          (set! tmp-ra.12 r15)
          (set! ball.0.8 rdi)
          (set! foo.4.7 rsi)
          (set! foobar.1.6 rdx)
          (set! ball.5.5 rcx)
          (set! foo.2.4 r8)
          (set! bar.7.3 r9)
          (set! r9 ball.5.5)
          (set! r8 1)
          (set! rcx -984231193)
          (set! rdx bar.7.3)
          (set! rsi bar.7.3)
          (set! rdi 933807622)
          (set! r15 tmp-ra.12)
          (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
      (begin
        (set! tmp-ra.13 r15)
        (set! bat.9.10 -477286222)
        (set! bar.7.9 0)
        (set! rax 643069821)
        (jump tmp-ra.13 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.18 tmp.20)))
            (define L.func.0.1
              ((new-frames ())
               (locals (tmp.19 bat.2.3 bar.9.6 bat.0.5 ball.4.4 bat.0.2 tmp-ra.15 bar.9.1)))
              (begin
                (set! tmp-ra.15 r15)
                (set! bar.9.1 rdi)
                (if (!= bar.9.1 bar.9.1)
                    (begin
                      (set! rdi 2058053814)
                      (set! r15 tmp-ra.15)
                      (jump L.func.0.1 rbp r15 rdi))
                    (begin
                      (set! tmp.19 bar.9.1)
                      (set! tmp.19 (- tmp.19 bar.9.1))
                      (set! bat.2.3 tmp.19)
                      (set! bar.9.6 bar.9.1)
                      (set! bat.0.5 bar.9.1)
                      (set! ball.4.4 bar.9.1)
                      (set! bat.0.2 ball.4.4)
                      (set! rdi bar.9.1)
                      (set! r15 tmp-ra.15)
                      (jump L.x.2.3 rbp r15 rdi)))))
      (define L.tmp.1.2
        ((new-frames ()) (locals (bat.5.7 bat.3.8 bat.8.9 tmp-ra.16)))
        (begin
          (set! tmp-ra.16 r15)
          (set! bat.8.9 rdi)
          (set! bat.3.8 rsi)
          (set! bat.5.7 rdx)
          (set! rdi bat.8.9)
          (set! r15 tmp-ra.16)
          (jump L.x.2.3 rbp r15 rdi)))
      (define L.x.2.3
        ((new-frames (())) (locals (bar.9.10 tmp-ra.17 bat.8.13 foo.1.14 bar.9.11 ball.7.12)))
        (begin
          (set! tmp-ra.17 r15)
          (set! bar.9.10 rdi)
          (return-point L.rp.4
                        (begin
                          (set! rdx -1942673900)
                          (set! rsi bar.9.10)
                          (set! rdi bar.9.10)
                          (set! r15 L.rp.4)
                          (jump L.tmp.1.2 rbp r15 rdi rsi rdx)))
          (set! bar.9.11 rax)
          (if (begin
                (set! foo.1.14 bar.9.11)
                (set! bat.8.13 bar.9.11)
                (set! ball.7.12 bar.9.11)
                (= ball.7.12 bar.9.11))
              (begin
                (set! rdx -1386061378)
                (set! rsi bar.9.11)
                (set! rdi bar.9.11)
                (set! r15 tmp-ra.17)
                (jump L.tmp.1.2 rbp r15 rdi rsi rdx))
              (begin
                (set! rdi bar.9.11)
                (set! r15 tmp-ra.17)
                (jump L.func.0.1 rbp r15 rdi)))))
      (begin
        (set! tmp-ra.18 r15)
        (if (true)
            (begin
              (set! tmp.20 9223372036854775807)
              (set! tmp.20 (+ tmp.20 -9223372036854775808))
              (set! rax tmp.20)
              (jump tmp-ra.18 rbp rax))
            (begin
              (set! rdi -2107846344)
              (set! r15 tmp-ra.18)
              (jump L.func.0.1 rbp r15 rdi))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1 tmp.2)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (begin
                                       (set! tmp.2 1)
                                       (<= tmp.2 -9223372036854775808))
                                     (if (false)
                                         (begin
                                           (set! rax -9223372036854775808)
                                           (jump tmp-ra.1 rbp rax))
                                         (begin
                                           (set! rax 2012039291)
                                           (jump tmp-ra.1 rbp rax)))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.25)))
            (define L.func.0.1
              ((new-frames ())
               (locals (tmp.26 foo.9.1 foo.5.2 foobar.7.3 foo.4.4 ball.1.5 foo.2.6 tmp-ra.22)))
              (begin
                (set! tmp-ra.22 r15)
                (set! foo.2.6 rdi)
                (set! ball.1.5 rsi)
                (set! foo.4.4 rdx)
                (set! foobar.7.3 rcx)
                (set! foo.5.2 r8)
                (set! foo.9.1 r9)
                (set! tmp.26 foo.2.6)
                (set! tmp.26 (- tmp.26 foo.4.4))
                (set! rax tmp.26)
                (jump tmp-ra.22 rbp rax)))
      (define L.proc.1.2
        ((new-frames (()))
         (locals
          (foo.6.11 foobar.7.12 foo.4.13 foo.2.8 foobar.7.9 foo.6.10 foo.6.7 tmp.27 tmp-ra.23)))
        (begin
          (set! tmp-ra.23 r15)
          (set! tmp.27 9223372036854775807)
          (set! tmp.27 (+ tmp.27 1))
          (set! foo.6.7 tmp.27)
          (return-point L.rp.4
                        (begin
                          (set! r9 foo.6.7)
                          (set! r8 foo.6.7)
                          (set! rcx foo.6.7)
                          (set! rdx foo.6.7)
                          (set! rsi foo.6.7)
                          (set! rdi 0)
                          (set! r15 L.rp.4)
                          (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))
          (set! foo.6.10 rax)
          (set! foobar.7.9 foo.6.7)
          (if (>= foo.6.7 foo.6.7)
              (set! foo.2.8 foo.6.7)
              (set! foo.2.8 foo.6.7))
          (set! foo.4.13 foo.6.10)
          (set! foobar.7.12 foo.6.10)
          (set! foo.6.11 -9223372036854775808)
          (set! rax 9223372036854775807)
          (jump tmp-ra.23 rbp rax)))
      (define L.func.2.3
        ((new-frames ())
         (locals
          (foo.4.19 foo.9.20 foo.6.21 foo.4.15 bar.0.17 tmp-ra.24 foobar.7.16 foo.6.14 foo.9.18)))
        (begin
          (set! tmp-ra.24 r15)
          (set! bar.0.17 rdi)
          (set! foobar.7.16 rsi)
          (set! foo.4.15 rdx)
          (set! foo.6.14 rcx)
          (set! foo.9.18 foobar.7.16)
          (set! foo.6.21 foo.6.14)
          (set! foo.9.20 foo.6.14)
          (set! foo.4.19 foobar.7.16)
          (if (>= foo.9.18 foo.6.14)
              (begin
                (set! rax foobar.7.16)
                (jump tmp-ra.24 rbp rax))
              (begin
                (set! rax bar.0.17)
                (jump tmp-ra.24 rbp rax)))))
      (begin
        (set! tmp-ra.25 r15)
        (set! rcx 9223372036854775807)
        (set! rdx -1735352110)
        (set! rsi 9223372036854775807)
        (set! rdi 0)
        (set! r15 tmp-ra.25)
        (jump L.func.2.3 rbp r15 rdi rsi rdx rcx))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.19 tmp.22)))
            (define L.x.0.1
              ((new-frames ((nfv.17))) (locals (nfv.17 foobar.8.1
                                                       bar.0.2
                                                       ball.1.5
                                                       bat.9.7
                                                       foo.2.4
                                                       foobar.7.6
                                                       tmp-ra.16
                                                       ball.6.3
                                                       tmp.21
                                                       ball.1.8
                                                       tmp.20)))
              (begin
                (set! tmp-ra.16 r15)
                (set! bat.9.7 rdi)
                (set! foobar.7.6 rsi)
                (set! ball.1.5 rdx)
                (set! foo.2.4 rcx)
                (set! ball.6.3 r8)
                (set! bar.0.2 r9)
                (set! foobar.8.1 fv0)
                (return-point L.rp.3
                              (begin
                                (set! nfv.17 bar.0.2)
                                (set! r9 bat.9.7)
                                (set! r8 bar.0.2)
                                (set! rcx 0)
                                (set! rdx foobar.8.1)
                                (set! rsi foo.2.4)
                                (set! rdi foo.2.4)
                                (set! r15 L.rp.3)
                                (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9 nfv.17)))
                (set! ball.1.8 rax)
                (if (not (begin
                           (set! tmp.20 0)
                           (< tmp.20 -9223372036854775808)))
                    (begin
                      (set! tmp.21 ball.6.3)
                      (set! tmp.21 (+ tmp.21 ball.1.8))
                      (set! rax tmp.21)
                      (jump tmp-ra.16 rbp rax))
                    (if (<= foo.2.4 0)
                        (begin
                          (set! rax foo.2.4)
                          (jump tmp-ra.16 rbp rax))
                        (begin
                          (set! rax foobar.7.6)
                          (jump tmp-ra.16 rbp rax))))))
      (define L.fn.1.2
        ((new-frames ())
         (locals (foobar.8.9 foobar.7.10 bat.5.11 ball.6.12 foobar.4.13 bar.0.14 bat.9.15 tmp-ra.18)))
        (begin
          (set! tmp-ra.18 r15)
          (set! bat.9.15 rdi)
          (set! bar.0.14 rsi)
          (set! foobar.4.13 rdx)
          (set! ball.6.12 rcx)
          (set! bat.5.11 r8)
          (set! foobar.7.10 r9)
          (set! foobar.8.9 fv0)
          (set! fv0 0)
          (set! r9 bar.0.14)
          (set! r8 foobar.7.10)
          (set! rcx -9223372036854775808)
          (set! rdx bar.0.14)
          (set! rsi foobar.7.10)
          (set! rdi ball.6.12)
          (set! r15 tmp-ra.18)
          (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.19 r15)
        (if (begin
              (set! tmp.22 -9223372036854775808)
              (>= tmp.22 -637253177))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.19 rbp rax))
            (begin
              (set! rax 0)
              (jump tmp-ra.19 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (set! rax 9223372036854775807)
                                 (jump tmp-ra.1 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (foo.0.25 foo.7.26 bar.3.27 tmp-ra.33)))
            (define L.proc.0.1
              ((new-frames ()) (locals (bat.6.1 bat.5.2 bat.1.3 foo.0.4 foo.7.5 bat.8.6 tmp-ra.28)))
              (begin
                (set! tmp-ra.28 r15)
                (set! bat.8.6 rdi)
                (set! foo.7.5 rsi)
                (set! foo.0.4 rdx)
                (set! bat.1.3 rcx)
                (set! bat.5.2 r8)
                (set! bat.6.1 r9)
                (set! r9 bat.1.3)
                (set! r8 bat.8.6)
                (set! rcx -635532414)
                (set! rdx bat.5.2)
                (set! rsi bat.5.2)
                (set! rdi bat.5.2)
                (set! r15 tmp-ra.28)
                (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))
      (define L.tmp.1.2
        ((new-frames ((nfv.31) (nfv.30) ())) (locals (bat.8.16 ball.9.17
                                                               tmp.34
                                                               ball.4.12
                                                               nfv.31
                                                               bar.3.14
                                                               bat.5.15
                                                               nfv.30
                                                               foo.0.13
                                                               foo.7.7
                                                               ball.9.8
                                                               bat.8.9
                                                               foo.0.10
                                                               bat.6.11
                                                               tmp-ra.29)))
        (begin
          (set! tmp-ra.29 r15)
          (set! bat.6.11 rdi)
          (set! foo.0.10 rsi)
          (set! bat.8.9 rdx)
          (set! ball.9.8 rcx)
          (set! foo.7.7 r8)
          (return-point L.rp.4
                        (begin
                          (set! r8 foo.7.7)
                          (set! rcx ball.9.8)
                          (set! rdx bat.6.11)
                          (set! rsi foo.7.7)
                          (set! rdi ball.9.8)
                          (set! r15 L.rp.4)
                          (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8)))
          (set! foo.0.13 rax)
          (return-point L.rp.5
                        (begin
                          (set! nfv.30 foo.7.7)
                          (set! r9 bat.8.9)
                          (set! r8 ball.9.8)
                          (set! rcx -501684781)
                          (set! rdx foo.7.7)
                          (set! rsi 9223372036854775807)
                          (set! rdi foo.0.10)
                          (set! r15 L.rp.5)
                          (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 nfv.30)))
          (set! bat.5.15 rax)
          (set! bar.3.14 foo.0.10)
          (return-point L.rp.6
                        (begin
                          (set! nfv.31 bat.6.11)
                          (set! r9 foo.0.10)
                          (set! r8 bat.8.9)
                          (set! rcx -9223372036854775808)
                          (set! rdx foo.7.7)
                          (set! rsi 1644735104)
                          (set! rdi bat.6.11)
                          (set! r15 L.rp.6)
                          (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 nfv.31)))
          (set! ball.4.12 rax)
          (set! tmp.34 foo.0.13)
          (set! tmp.34 (- tmp.34 foo.0.13))
          (set! ball.9.17 tmp.34)
          (if (= foo.0.13 ball.4.12)
              (set! bat.8.16 ball.4.12)
              (set! bat.8.16 foo.0.13))
          (set! fv0 ball.4.12)
          (set! r9 -9223372036854775808)
          (set! r8 bat.6.11)
          (set! rcx bat.8.16)
          (set! rdx foo.7.7)
          (set! rsi foo.7.7)
          (set! rdi ball.4.12)
          (set! r15 tmp-ra.29)
          (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (define L.func.2.3
        ((new-frames ())
         (locals (ball.4.18 bat.1.19 bar.3.20 foo.0.21 bat.8.22 bat.5.23 foo.2.24 tmp-ra.32)))
        (begin
          (set! tmp-ra.32 r15)
          (set! foo.2.24 rdi)
          (set! bat.5.23 rsi)
          (set! bat.8.22 rdx)
          (set! foo.0.21 rcx)
          (set! bar.3.20 r8)
          (set! bat.1.19 r9)
          (set! ball.4.18 fv0)
          (set! fv0 9223372036854775807)
          (set! r9 foo.0.21)
          (set! r8 ball.4.18)
          (set! rcx ball.4.18)
          (set! rdx foo.0.21)
          (set! rsi -9223372036854775808)
          (set! rdi bar.3.20)
          (set! r15 tmp-ra.32)
          (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.33 r15)
        (set! bar.3.27 -9223372036854775808)
        (set! foo.7.26 9223372036854775807)
        (set! foo.0.25 9223372036854775807)
        (set! rax bar.3.27)
        (jump tmp-ra.33 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bat.7.18 tmp.25 bat.6.19 bat.8.21 bar.2.20 tmp-ra.24)))
            (define L.func.0.1
              ((new-frames (()))
               (locals (ball.5.4 tmp-ra.22 foo.4.5 foo.4.6 bat.3.2 bar.1.1 bat.3.7 bar.1.8 bar.2.3)))
              (begin
                (set! tmp-ra.22 r15)
                (set! foo.4.5 rdi)
                (set! ball.5.4 rsi)
                (set! bar.2.3 rdx)
                (set! bat.3.2 rcx)
                (set! bar.1.1 r8)
                (if (begin
                      (set! bar.1.8 bar.2.3)
                      (if (<= bat.3.2 bar.1.1)
                          (set! bat.3.7 bat.3.2)
                          (set! bat.3.7 bar.1.1))
                      (begin
                        (return-point L.rp.3
                                      (begin
                                        (set! r8 bar.1.1)
                                        (set! rcx foo.4.5)
                                        (set! rdx foo.4.5)
                                        (set! rsi bar.2.3)
                                        (set! rdi 1)
                                        (set! r15 L.rp.3)
                                        (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))
                        (set! foo.4.6 rax))
                      (false))
                    (begin
                      (set! r8 0)
                      (set! rcx bar.2.3)
                      (set! rdx 1603961181)
                      (set! rsi ball.5.4)
                      (set! rdi bar.1.1)
                      (set! r15 tmp-ra.22)
                      (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8))
                    (begin
                      (set! r9 bat.3.2)
                      (set! r8 bar.1.1)
                      (set! rcx ball.5.4)
                      (set! rdx bar.1.1)
                      (set! rsi -9223372036854775808)
                      (set! rdi ball.5.4)
                      (set! r15 tmp-ra.22)
                      (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (define L.fn.1.2
        ((new-frames ()) (locals (foobar.9.9 tmp-ra.23
                                             bar.0.11
                                             bat.7.17
                                             foobar.9.16
                                             bat.8.15
                                             ball.5.12
                                             bat.7.13
                                             bar.1.14
                                             bat.3.10)))
        (begin
          (set! tmp-ra.23 r15)
          (set! bar.1.14 rdi)
          (set! bat.7.13 rsi)
          (set! ball.5.12 rdx)
          (set! bar.0.11 rcx)
          (set! bat.3.10 r8)
          (set! foobar.9.9 r9)
          (if (if (>= bat.3.10 bar.1.14)
                  (> bat.7.13 -9223372036854775808)
                  (>= ball.5.12 bat.3.10))
              (begin
                (set! bat.7.17 bar.0.11)
                (set! foobar.9.16 9223372036854775807)
                (set! bat.8.15 bar.1.14)
                (set! rax bat.3.10)
                (jump tmp-ra.23 rbp rax))
              (if (< bat.3.10 bar.1.14)
                  (begin
                    (set! rax bar.0.11)
                    (jump tmp-ra.23 rbp rax))
                  (begin
                    (set! rax bat.7.13)
                    (jump tmp-ra.23 rbp rax))))))
      (begin
        (set! tmp-ra.24 r15)
        (set! bar.2.20 405359082)
        (if (not (begin
                   (set! tmp.25 -915730633)
                   (>= tmp.25 0)))
            (begin
              (set! bat.8.21 -532660031)
              (set! bat.6.19 -248685178))
            (set! bat.6.19 0))
        (set! bat.7.18 1254220652)
        (set! r9 bar.2.20)
        (set! r8 bat.6.19)
        (set! rcx 9223372036854775807)
        (set! rdx bat.6.19)
        (set! rsi bat.6.19)
        (set! rdi -9223372036854775808)
        (set! r15 tmp-ra.24)
        (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (foo.8.17 bar.0.18 tmp-ra.23)))
            (define L.proc.0.1
              ((new-frames ()) (locals (foo.1.1 foo.5.2 foo.2.3 foobar.7.4 foobar.9.5 tmp-ra.19)))
              (begin
                (set! tmp-ra.19 r15)
                (set! foobar.9.5 rdi)
                (set! foobar.7.4 rsi)
                (set! foo.2.3 rdx)
                (set! foo.5.2 rcx)
                (set! foo.1.1 r8)
                (set! r8 1)
                (set! rcx -1754605622)
                (set! rdx -675715652)
                (set! rsi foo.2.3)
                (set! rdi foo.1.1)
                (set! r15 tmp-ra.19)
                (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8)))
      (define L.func.1.2
        ((new-frames ()) (locals (foo.1.6 foobar.3.7 tmp-ra.20)))
        (begin
          (set! tmp-ra.20 r15)
          (set! foobar.3.7 rdi)
          (set! foo.1.6 rsi)
          (set! r8 foo.1.6)
          (set! rcx foo.1.6)
          (set! rdx foobar.3.7)
          (set! rsi foobar.3.7)
          (set! rdi foo.1.6)
          (set! r15 tmp-ra.20)
          (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8)))
      (define L.x.2.3
        ((new-frames ((nfv.22))) (locals (foo.1.15 tmp.24
                                                   foobar.9.16
                                                   nfv.22
                                                   foobar.7.8
                                                   foo.1.9
                                                   bat.6.10
                                                   bar.4.11
                                                   foo.8.12
                                                   foobar.9.13
                                                   bar.0.14
                                                   tmp-ra.21)))
        (begin
          (set! tmp-ra.21 r15)
          (set! bar.0.14 rdi)
          (set! foobar.9.13 rsi)
          (set! foo.8.12 rdx)
          (set! bar.4.11 rcx)
          (set! bat.6.10 r8)
          (set! foo.1.9 r9)
          (set! foobar.7.8 fv0)
          (if (>= bar.4.11 foobar.7.8)
              (set! foobar.9.16 foobar.9.13)
              (begin
                (return-point L.rp.4
                              (begin
                                (set! nfv.22 1783645727)
                                (set! r9 foo.1.9)
                                (set! r8 bar.4.11)
                                (set! rcx bat.6.10)
                                (set! rdx 0)
                                (set! rsi foo.8.12)
                                (set! rdi 1)
                                (set! r15 L.rp.4)
                                (jump L.x.2.3 rbp r15 rdi rsi rdx rcx r8 r9 nfv.22)))
                (set! foobar.9.16 rax)))
          (set! tmp.24 bar.4.11)
          (set! tmp.24 (* tmp.24 bar.4.11))
          (set! foo.1.15 tmp.24)
          (set! fv0 bar.4.11)
          (set! r9 bar.0.14)
          (set! r8 -922337918)
          (set! rcx foobar.7.8)
          (set! rdx foobar.7.8)
          (set! rsi bar.4.11)
          (set! rdi foobar.7.8)
          (set! r15 tmp-ra.21)
          (jump L.x.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.23 r15)
        (set! bar.0.18 0)
        (set! foo.8.17 1029279872)
        (set! rax bar.0.18)
        (jump tmp-ra.23 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (tmp-ra.6 tmp.8 tmp.7 ball.5.5 bat.1.4 bar.8.3 foobar.0.1 bat.2.2)))
            (begin
              (set! tmp-ra.6 r15)
              (if (if (begin
                        (set! bat.2.2 1)
                        (set! foobar.0.1 -1606724555)
                        (= bat.2.2 bat.2.2))
                      (begin
                        (set! ball.5.5 1)
                        (set! bat.1.4 1)
                        (set! bar.8.3 -9223372036854775808)
                        (<= ball.5.5 ball.5.5))
                      (begin
                        (begin
                          (set! tmp.7 -1879829070)
                          (!= tmp.7 1981475003))))
                  (begin
                    (set! tmp.8 -634246165)
                    (set! tmp.8 (- tmp.8 -684848771))
                    (set! rax tmp.8)
                    (jump tmp-ra.6 rbp rax))
                  (begin
                    (set! rax 0)
                    (jump tmp-ra.6 rbp rax))))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (bar.9.7 tmp-ra.10)))
                               (define L.func.0.1
                                 ((new-frames ()) (locals (bar.6.1 foo.3.2 bat.2.3 tmp-ra.8)))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (set! bat.2.3 rdi)
                                   (set! foo.3.2 rsi)
                                   (set! bar.6.1 rdx)
                                   (set! rdx bat.2.3)
                                   (set! rsi -1803672217)
                                   (set! rdi bat.2.3)
                                   (set! r15 tmp-ra.8)
                                   (jump L.proc.1.2 rbp r15 rdi rsi rdx)))
                         (define L.proc.1.2
                           ((new-frames ()) (locals (bat.1.4 ball.0.5 foo.3.6 tmp-ra.9)))
                           (begin
                             (set! tmp-ra.9 r15)
                             (set! foo.3.6 rdi)
                             (set! ball.0.5 rsi)
                             (set! bat.1.4 rdx)
                             (set! rdx bat.1.4)
                             (set! rsi ball.0.5)
                             (set! rdi 1)
                             (set! r15 tmp-ra.9)
                             (jump L.proc.1.2 rbp r15 rdi rsi rdx)))
                         (begin
                           (set! tmp-ra.10 r15)
                           (set! bar.9.7 0)
                           (set! rax bar.9.7)
                           (jump tmp-ra.10 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.7 ball.0.1 bar.6.2 foobar.7.3 ball.0.4 bat.2.5 tmp-ra.6)))
            (begin
              (set! tmp-ra.6 r15)
              (set! bat.2.5 1550347185)
              (set! ball.0.4 9223372036854775807)
              (set! foobar.7.3 -9223372036854775808)
              (set! bar.6.2 ball.0.4)
              (set! ball.0.1 bar.6.2)
              (set! tmp.7 9223372036854775807)
              (set! tmp.7 (- tmp.7 ball.0.1))
              (set! rax tmp.7)
              (jump tmp-ra.6 rbp rax))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foo.1.12 ball.9.13 tmp-ra.15)))
                               (define L.proc.0.1
                                 ((new-frames (() () () () ())) (locals (foo.8.7 ball.9.8
                                                                                 ball.2.9
                                                                                 bar.3.2
                                                                                 bar.6.3
                                                                                 ball.4.11
                                                                                 foo.8.10
                                                                                 ball.9.5
                                                                                 bar.3.6
                                                                                 tmp-ra.14
                                                                                 foo.1.1
                                                                                 bar.6.4)))
                                 (begin
                                   (set! tmp-ra.14 r15)
                                   (set! bar.6.3 rdi)
                                   (set! bar.3.2 rsi)
                                   (set! foo.1.1 rdx)
                                   (return-point L.rp.2
                                                 (begin
                                                   (set! rdx foo.1.1)
                                                   (set! rsi foo.1.1)
                                                   (set! rdi 9223372036854775807)
                                                   (set! r15 L.rp.2)
                                                   (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                   (set! bar.3.6 rax)
                                   (return-point L.rp.3
                                                 (begin
                                                   (set! rdx bar.6.3)
                                                   (set! rsi foo.1.1)
                                                   (set! rdi bar.6.3)
                                                   (set! r15 L.rp.3)
                                                   (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                   (set! ball.9.5 rax)
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! rdx bar.6.3)
                                                   (set! rsi foo.1.1)
                                                   (set! rdi foo.1.1)
                                                   (set! r15 L.rp.4)
                                                   (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                   (set! ball.2.9 rax)
                                   (set! ball.9.8 bar.3.2)
                                   (return-point L.rp.5
                                                 (begin
                                                   (set! rdx bar.3.2)
                                                   (set! rsi foo.1.1)
                                                   (set! rdi foo.1.1)
                                                   (set! r15 L.rp.5)
                                                   (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                   (set! foo.8.7 rax)
                                   (return-point L.rp.6
                                                 (begin
                                                   (set! rdx ball.2.9)
                                                   (set! rsi foo.8.7)
                                                   (set! rdi foo.8.7)
                                                   (set! r15 L.rp.6)
                                                   (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                   (set! bar.6.4 rax)
                                   (if (> bar.6.4 foo.1.1)
                                       (if (>= bar.3.6 bar.3.6)
                                           (begin
                                             (set! rax foo.1.1)
                                             (jump tmp-ra.14 rbp rax))
                                           (begin
                                             (set! rax bar.6.4)
                                             (jump tmp-ra.14 rbp rax)))
                                       (begin
                                         (set! ball.4.11 -2087609688)
                                         (set! foo.8.10 bar.3.6)
                                         (set! rax ball.9.5)
                                         (jump tmp-ra.14 rbp rax)))))
                         (begin
                           (set! tmp-ra.15 r15)
                           (set! ball.9.13 1)
                           (set! foo.1.12 -9223372036854775808)
                           (set! rax foo.1.12)
                           (jump tmp-ra.15 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bat.4.16 tmp.23 tmp-ra.20)))
            (define L.fn.0.1
              ((new-frames ()) (locals (bar.0.1 tmp-ra.17)))
              (begin
                (set! tmp-ra.17 r15)
                (set! bar.0.1 rdi)
                (if (true)
                    (begin
                      (set! rcx 2099518136)
                      (set! rdx bar.0.1)
                      (set! rsi bar.0.1)
                      (set! rdi bar.0.1)
                      (set! r15 tmp-ra.17)
                      (jump L.func.2.3 rbp r15 rdi rsi rdx rcx))
                    (begin
                      (set! rcx bar.0.1)
                      (set! rdx bar.0.1)
                      (set! rsi bar.0.1)
                      (set! rdi bar.0.1)
                      (set! r15 tmp-ra.17)
                      (jump L.func.2.3 rbp r15 rdi rsi rdx rcx)))))
      (define L.tmp.1.2
        ((new-frames ()) (locals (foobar.6.8 ball.1.11
                                             tmp.22
                                             foo.5.9
                                             tmp.21
                                             bar.0.10
                                             bar.0.2
                                             ball.8.3
                                             bar.2.4
                                             foo.5.5
                                             foobar.3.6
                                             foobar.6.7
                                             tmp-ra.18)))
        (begin
          (set! tmp-ra.18 r15)
          (set! foobar.6.7 rdi)
          (set! foobar.3.6 rsi)
          (set! foo.5.5 rdx)
          (set! bar.2.4 rcx)
          (set! ball.8.3 r8)
          (set! bar.0.2 r9)
          (set! bar.0.10 9223372036854775807)
          (set! tmp.21 foo.5.5)
          (set! tmp.21 (+ tmp.21 foobar.3.6))
          (set! foo.5.9 tmp.21)
          (set! tmp.22 bar.2.4)
          (set! tmp.22 (+ tmp.22 foobar.3.6))
          (set! ball.1.11 tmp.22)
          (set! foobar.6.8 foobar.3.6)
          (set! rdi 0)
          (set! r15 tmp-ra.18)
          (jump L.fn.0.1 rbp r15 rdi)))
      (define L.func.2.3
        ((new-frames ()) (locals (foobar.6.12 bar.0.13 ball.8.14 ball.9.15 tmp-ra.19)))
        (begin
          (set! tmp-ra.19 r15)
          (set! ball.9.15 rdi)
          (set! ball.8.14 rsi)
          (set! bar.0.13 rdx)
          (set! foobar.6.12 rcx)
          (set! r9 9223372036854775807)
          (set! r8 bar.0.13)
          (set! rcx ball.9.15)
          (set! rdx foobar.6.12)
          (set! rsi foobar.6.12)
          (set! rdi 1)
          (set! r15 tmp-ra.19)
          (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
      (begin
        (set! tmp-ra.20 r15)
        (set! tmp.23 1)
        (set! tmp.23 (+ tmp.23 9223372036854775807))
        (set! bat.4.16 tmp.23)
        (set! rax bat.4.16)
        (jump tmp-ra.20 rbp rax))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (bat.0.1 foobar.1.2 tmp-ra.3)))
                               (begin
                                 (set! tmp-ra.3 r15)
                                 (set! foobar.1.2 0)
                                 (set! bat.0.1 1)
                                 (set! rax bat.0.1)
                                 (jump tmp-ra.3 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.9)))
            (define L.func.0.1
              ((new-frames ()) (locals (tmp-ra.7)))
              (begin
                (set! tmp-ra.7 r15)
                (set! r9 0)
                (set! r8 1)
                (set! rcx 9223372036854775807)
                (set! rdx 9223372036854775807)
                (set! rsi 1)
                (set! rdi 38797657)
                (set! r15 tmp-ra.7)
                (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
      (define L.x.1.2
        ((new-frames ())
         (locals (ball.5.5 bat.3.4 foobar.1.2 bar.2.3 bat.7.6 bat.9.1 tmp.10 tmp-ra.8)))
        (begin
          (set! tmp-ra.8 r15)
          (set! bat.7.6 rdi)
          (set! ball.5.5 rsi)
          (set! bat.3.4 rdx)
          (set! bar.2.3 rcx)
          (set! foobar.1.2 r8)
          (set! bat.9.1 r9)
          (if (true)
              (if (if (>= foobar.1.2 foobar.1.2)
                      (< bat.7.6 bar.2.3)
                      (< bat.9.1 812242710))
                  (begin
                    (set! tmp.10 foobar.1.2)
                    (set! tmp.10 (- tmp.10 bar.2.3))
                    (set! rax tmp.10)
                    (jump tmp-ra.8 rbp rax))
                  (begin
                    (set! r15 tmp-ra.8)
                    (jump L.func.0.1 rbp r15)))
              (begin
                (set! r9 bar.2.3)
                (set! r8 bat.9.1)
                (set! rcx bat.9.1)
                (set! rdx bar.2.3)
                (set! rsi foobar.1.2)
                (set! rdi bat.3.4)
                (set! r15 tmp-ra.8)
                (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (begin
        (set! tmp-ra.9 r15)
        (set! r9 -9223372036854775808)
        (set! r8 0)
        (set! rcx -9223372036854775808)
        (set! rdx -9223372036854775808)
        (set! rsi -2062025435)
        (set! rdi 0)
        (set! r15 tmp-ra.9)
        (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.10)))
                               (define L.func.0.1
                                 ((new-frames ()) (locals (foo.9.1 foo.3.2 foo.7.3 foo.4.4 tmp-ra.8)))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (set! foo.4.4 rdi)
                                   (set! foo.7.3 rsi)
                                   (set! foo.3.2 rdx)
                                   (set! foo.9.1 rcx)
                                   (set! rdx foo.3.2)
                                   (set! rsi -9223372036854775808)
                                   (set! rdi foo.4.4)
                                   (set! r15 tmp-ra.8)
                                   (jump L.proc.1.2 rbp r15 rdi rsi rdx)))
                         (define L.proc.1.2
                           ((new-frames ()) (locals (tmp.11 foo.7.5 bat.5.6 foo.9.7 tmp-ra.9)))
                           (begin
                             (set! tmp-ra.9 r15)
                             (set! foo.9.7 rdi)
                             (set! bat.5.6 rsi)
                             (set! foo.7.5 rdx)
                             (set! tmp.11 bat.5.6)
                             (set! tmp.11 (- tmp.11 foo.7.5))
                             (set! rax tmp.11)
                             (jump tmp-ra.9 rbp rax)))
                         (begin
                           (set! tmp-ra.10 r15)
                           (set! rax 1)
                           (jump tmp-ra.10 rbp rax))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foobar.9.1 ball.3.2 tmp-ra.3)))
                               (begin
                                 (set! tmp-ra.3 r15)
                                 (set! ball.3.2 -550916464)
                                 (set! foobar.9.1 9223372036854775807)
                                 (set! rax foobar.9.1)
                                 (jump tmp-ra.3 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.7 tmp.3 tmp.4 tmp.5 tmp-ra.2 tmp.6 bar.1.1)))
            (begin
              (set! tmp-ra.2 r15)
              (if (false)
                  (if (if (begin
                            (set! tmp.3 9223372036854775807)
                            (< tmp.3 1646335033))
                          (begin
                            (set! tmp.4 9223372036854775807)
                            (>= tmp.4 1))
                          (begin
                            (set! tmp.5 9223372036854775807)
                            (!= tmp.5 1)))
                      (if (begin
                            (set! tmp.6 -9223372036854775808)
                            (!= tmp.6 -9223372036854775808))
                          (begin
                            (set! rax -9223372036854775808)
                            (jump tmp-ra.2 rbp rax))
                          (begin
                            (set! rax 1282320164)
                            (jump tmp-ra.2 rbp rax)))
                      (begin
                        (set! bar.1.1 -9223372036854775808)
                        (set! rax bar.1.1)
                        (jump tmp-ra.2 rbp rax)))
                  (begin
                    (set! tmp.7 9223372036854775807)
                    (set! tmp.7 (- tmp.7 1))
                    (set! rax tmp.7)
                    (jump tmp-ra.2 rbp rax))))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.17 tmp.19)))
                               (define L.tmp.0.1
                                 ((new-frames (() ())) (locals (foobar.2.7 bar.0.8
                                                                           foobar.8.9
                                                                           bar.1.10
                                                                           foobar.2.11
                                                                           ball.4.5
                                                                           tmp.18
                                                                           ball.7.6
                                                                           bar.0.1
                                                                           ball.4.2
                                                                           bat.6.3
                                                                           bar.1.4
                                                                           tmp-ra.15)))
                                 (begin
                                   (set! tmp-ra.15 r15)
                                   (set! bar.1.4 rdi)
                                   (set! bat.6.3 rsi)
                                   (set! ball.4.2 rdx)
                                   (set! bar.0.1 rcx)
                                   (return-point L.rp.3
                                                 (begin
                                                   (set! rcx bar.1.4)
                                                   (set! rdx bar.0.1)
                                                   (set! rsi bat.6.3)
                                                   (set! rdi bat.6.3)
                                                   (set! r15 L.rp.3)
                                                   (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx)))
                                   (set! ball.7.6 rax)
                                   (set! tmp.18 bat.6.3)
                                   (set! tmp.18 (- tmp.18 bar.0.1))
                                   (set! ball.4.5 tmp.18)
                                   (set! foobar.2.11 bat.6.3)
                                   (set! bar.1.10 1)
                                   (set! foobar.8.9 bar.0.1)
                                   (set! bar.0.8 bar.1.4)
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! rdx bar.1.4)
                                                   (set! rsi 9223372036854775807)
                                                   (set! rdi bar.0.1)
                                                   (set! r15 L.rp.4)
                                                   (jump L.x.1.2 rbp r15 rdi rsi rdx)))
                                   (set! foobar.2.7 rax)
                                   (set! rdx bat.6.3)
                                   (set! rsi bat.6.3)
                                   (set! rdi -9223372036854775808)
                                   (set! r15 tmp-ra.15)
                                   (jump L.x.1.2 rbp r15 rdi rsi rdx)))
                         (define L.x.1.2
                           ((new-frames ()) (locals (bar.3.14 foobar.8.13 bat.6.12 tmp-ra.16)))
                           (begin
                             (set! tmp-ra.16 r15)
                             (set! bar.3.14 rdi)
                             (set! foobar.8.13 rsi)
                             (set! bat.6.12 rdx)
                             (if (false)
                                 (begin
                                   (set! rdx foobar.8.13)
                                   (set! rsi bat.6.12)
                                   (set! rdi 9223372036854775807)
                                   (set! r15 tmp-ra.16)
                                   (jump L.x.1.2 rbp r15 rdi rsi rdx))
                                 (if (false)
                                     (begin
                                       (set! rcx bar.3.14)
                                       (set! rdx foobar.8.13)
                                       (set! rsi bar.3.14)
                                       (set! rdi foobar.8.13)
                                       (set! r15 tmp-ra.16)
                                       (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx))
                                     (begin
                                       (set! rdx bat.6.12)
                                       (set! rsi 580696126)
                                       (set! rdi bat.6.12)
                                       (set! r15 tmp-ra.16)
                                       (jump L.x.1.2 rbp r15 rdi rsi rdx))))))
                         (begin
                           (set! tmp-ra.17 r15)
                           (if (begin
                                 (set! tmp.19 9223372036854775807)
                                 (<= tmp.19 9223372036854775807))
                               (begin
                                 (set! rax -1677147892)
                                 (jump tmp-ra.17 rbp rax))
                               (begin
                                 (set! rax 874915829)
                                 (jump tmp-ra.17 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.29 tmp.31)))
            (define L.proc.0.1
              ((new-frames (() (nfv.26))) (locals (tmp-ra.25 foo.2.7
                                                             ball.4.10
                                                             foobar.3.3
                                                             ball.4.5
                                                             foo.1.6
                                                             ball.7.4
                                                             nfv.26
                                                             ball.7.9
                                                             foo.2.8
                                                             foo.2.11
                                                             ball.0.2
                                                             foo.6.1)))
              (begin
                (set! tmp-ra.25 r15)
                (set! foo.2.7 rdi)
                (set! foo.1.6 rsi)
                (set! ball.4.5 rdx)
                (set! ball.7.4 rcx)
                (set! foobar.3.3 r8)
                (set! ball.0.2 r9)
                (set! foo.6.1 fv0)
                (if (not (> foo.6.1 -727829088))
                    (begin
                      (set! ball.4.10 foo.2.7)
                      (return-point L.rp.4
                                    (begin
                                      (set! nfv.26 foo.2.7)
                                      (set! r9 foo.2.7)
                                      (set! r8 ball.7.4)
                                      (set! rcx foo.1.6)
                                      (set! rdx ball.4.5)
                                      (set! rsi foobar.3.3)
                                      (set! rdi foo.1.6)
                                      (set! r15 L.rp.4)
                                      (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9 nfv.26)))
                      (set! ball.7.9 rax)
                      (return-point L.rp.5
                                    (begin
                                      (set! r9 foo.6.1)
                                      (set! r8 -9223372036854775808)
                                      (set! rcx foobar.3.3)
                                      (set! rdx 1)
                                      (set! rsi foo.2.7)
                                      (set! rdi ball.4.5)
                                      (set! r15 L.rp.5)
                                      (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
                      (set! foo.2.8 rax)
                      (set! foo.2.11 foo.1.6)
                      (set! rax ball.0.2)
                      (jump tmp-ra.25 rbp rax))
                    (begin
                      (set! rax -774243080)
                      (jump tmp-ra.25 rbp rax)))))
      (define L.fn.1.2
        ((new-frames ())
         (locals
          (tmp.30 ball.9.18 tmp-ra.27 ball.7.12 foo.1.15 ball.4.16 ball.9.14 foo.5.17 foobar.3.13)))
        (begin
          (set! tmp-ra.27 r15)
          (set! foo.5.17 rdi)
          (set! ball.4.16 rsi)
          (set! foo.1.15 rdx)
          (set! ball.9.14 rcx)
          (set! foobar.3.13 r8)
          (set! ball.7.12 r9)
          (if (if (if (< foobar.3.13 foo.5.17)
                      (>= foo.5.17 ball.9.14)
                      (!= ball.4.16 ball.4.16))
                  (if (>= ball.7.12 ball.9.14)
                      (< foo.5.17 foo.5.17)
                      (>= foo.1.15 foobar.3.13))
                  (not (> ball.9.14 ball.7.12)))
              (begin
                (set! tmp.30 -1548357748)
                (set! tmp.30 (- tmp.30 foobar.3.13))
                (set! ball.9.18 tmp.30)
                (set! r9 ball.9.18)
                (set! r8 foo.1.15)
                (set! rcx ball.4.16)
                (set! rdx foo.1.15)
                (set! rsi 0)
                (set! rdi ball.9.18)
                (set! r15 tmp-ra.27)
                (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9))
              (begin
                (set! r9 foo.5.17)
                (set! r8 ball.7.12)
                (set! rcx ball.7.12)
                (set! rdx ball.4.16)
                (set! rsi foobar.3.13)
                (set! rdi ball.9.14)
                (set! r15 tmp-ra.27)
                (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (define L.fn.2.3
        ((new-frames ())
         (locals (ball.9.19 foo.6.20 foo.2.21 foobar.3.22 foo.1.23 foobar.8.24 tmp-ra.28)))
        (begin
          (set! tmp-ra.28 r15)
          (set! foobar.8.24 rdi)
          (set! foo.1.23 rsi)
          (set! foobar.3.22 rdx)
          (set! foo.2.21 rcx)
          (set! foo.6.20 r8)
          (set! ball.9.19 r9)
          (set! r9 0)
          (set! r8 1)
          (set! rcx foo.6.20)
          (set! rdx foo.2.21)
          (set! rsi -9223372036854775808)
          (set! rdi foo.6.20)
          (set! r15 tmp-ra.28)
          (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))
      (begin
        (set! tmp-ra.29 r15)
        (if (begin
              (set! tmp.31 -534391580)
              (< tmp.31 9223372036854775807))
            (begin
              (set! rax 0)
              (jump tmp-ra.29 rbp rax))
            (begin
              (set! rax 0)
              (jump tmp-ra.29 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foobar.1.1 ball.8.2 ball.7.3 tmp-ra.4)))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (set! ball.7.3 -1762920629)
                                 (set! ball.8.2 1)
                                 (set! foobar.1.1 9223372036854775807)
                                 (set! rax 0)
                                 (jump tmp-ra.4 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.8 tmp.9)))
            (define L.proc.0.1
              ((new-frames ())
               (locals (foobar.8.1 bar.4.2 ball.5.3 ball.3.4 ball.2.5 foobar.0.6 tmp-ra.7)))
              (begin
                (set! tmp-ra.7 r15)
                (set! foobar.0.6 rdi)
                (set! ball.2.5 rsi)
                (set! ball.3.4 rdx)
                (set! ball.5.3 rcx)
                (set! bar.4.2 r8)
                (set! foobar.8.1 r9)
                (set! r9 ball.2.5)
                (set! r8 ball.2.5)
                (set! rcx ball.5.3)
                (set! rdx foobar.0.6)
                (set! rsi 15882253)
                (set! rdi ball.2.5)
                (set! r15 tmp-ra.7)
                (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))
      (begin
        (set! tmp-ra.8 r15)
        (if (begin
              (set! tmp.9 1038395452)
              (!= tmp.9 1))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.8 rbp rax))
            (begin
              (set! rax 717010255)
              (jump tmp-ra.8 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bat.6.1 foo.5.2 bat.8.3 tmp.5 tmp-ra.4 tmp.6 tmp.7)))
            (begin
              (set! tmp-ra.4 r15)
              (if (true)
                  (if (not (begin
                             (set! tmp.5 0)
                             (= tmp.5 1)))
                      (if (begin
                            (set! tmp.6 -9223372036854775808)
                            (>= tmp.6 -1744096882))
                          (begin
                            (set! rax 0)
                            (jump tmp-ra.4 rbp rax))
                          (begin
                            (set! rax 9223372036854775807)
                            (jump tmp-ra.4 rbp rax)))
                      (if (begin
                            (set! tmp.7 -9223372036854775808)
                            (< tmp.7 0))
                          (begin
                            (set! rax 1)
                            (jump tmp-ra.4 rbp rax))
                          (begin
                            (set! rax 9223372036854775807)
                            (jump tmp-ra.4 rbp rax))))
                  (if (false)
                      (begin
                        (set! foo.5.2 1032709229)
                        (set! bat.6.1 1)
                        (set! rax foo.5.2)
                        (jump tmp-ra.4 rbp rax))
                      (begin
                        (set! bat.8.3 9223372036854775807)
                        (set! rax bat.8.3)
                        (jump tmp-ra.4 rbp rax)))))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp.3 tmp-ra.1 tmp.2)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (begin
                                       (set! tmp.2 0)
                                       (< tmp.2 9223372036854775807))
                                     (begin
                                       (set! rax 1620518798)
                                       (jump tmp-ra.1 rbp rax))
                                     (if (begin
                                           (set! tmp.3 0)
                                           (!= tmp.3 9223372036854775807))
                                         (begin
                                           (set! rax 0)
                                           (jump tmp-ra.1 rbp rax))
                                         (begin
                                           (set! rax -9223372036854775808)
                                           (jump tmp-ra.1 rbp rax)))))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.15 tmp.16)))
            (define L.func.0.1
              ((new-frames ()) (locals (ball.0.1 foobar.2.2 tmp-ra.12)))
              (begin
                (set! tmp-ra.12 r15)
                (set! foobar.2.2 rdi)
                (set! ball.0.1 rsi)
                (set! rdx 9223372036854775807)
                (set! rsi foobar.2.2)
                (set! rdi foobar.2.2)
                (set! r15 tmp-ra.12)
                (jump L.tmp.1.2 rbp r15 rdi rsi rdx)))
      (define L.tmp.1.2
        ((new-frames ()) (locals (foo.6.3 ball.5.5 foobar.2.4 tmp-ra.13)))
        (begin
          (set! tmp-ra.13 r15)
          (set! ball.5.5 rdi)
          (set! foobar.2.4 rsi)
          (set! foo.6.3 rdx)
          (if (false)
              (begin
                (set! r9 foo.6.3)
                (set! r8 ball.5.5)
                (set! rcx 0)
                (set! rdx foobar.2.4)
                (set! rsi foobar.2.4)
                (set! rdi ball.5.5)
                (set! r15 tmp-ra.13)
                (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9))
              (begin
                (set! rdx ball.5.5)
                (set! rsi 9223372036854775807)
                (set! rdi foobar.2.4)
                (set! r15 tmp-ra.13)
                (jump L.tmp.1.2 rbp r15 rdi rsi rdx)))))
      (define L.tmp.2.3
        ((new-frames ())
         (locals (bat.9.6 bar.1.7 ball.5.8 foobar.7.9 foo.6.10 foobar.2.11 tmp-ra.14)))
        (begin
          (set! tmp-ra.14 r15)
          (set! foobar.2.11 rdi)
          (set! foo.6.10 rsi)
          (set! foobar.7.9 rdx)
          (set! ball.5.8 rcx)
          (set! bar.1.7 r8)
          (set! bat.9.6 r9)
          (set! r9 foo.6.10)
          (set! r8 bar.1.7)
          (set! rcx foobar.2.11)
          (set! rdx bar.1.7)
          (set! rsi 1666412948)
          (set! rdi 273235985)
          (set! r15 tmp-ra.14)
          (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))
      (begin
        (set! tmp-ra.15 r15)
        (if (begin
              (set! tmp.16 -9223372036854775808)
              (= tmp.16 9223372036854775807))
            (begin
              (set! rax 9223372036854775807)
              (jump tmp-ra.15 rbp rax))
            (begin
              (set! rax 1)
              (jump tmp-ra.15 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.7)))
            (define L.fn.0.1
              ((new-frames ()) (locals (foo.8.1 foo.1.2 ball.0.3 ball.4.4 ball.2.5 tmp-ra.6)))
              (begin
                (set! tmp-ra.6 r15)
                (set! ball.2.5 rdi)
                (set! ball.4.4 rsi)
                (set! ball.0.3 rdx)
                (set! foo.1.2 rcx)
                (set! foo.8.1 r8)
                (set! r8 ball.2.5)
                (set! rcx foo.1.2)
                (set! rdx ball.4.4)
                (set! rsi ball.2.5)
                (set! rdi foo.8.1)
                (set! r15 tmp-ra.6)
                (jump L.fn.0.1 rbp r15 rdi rsi rdx rcx r8)))
      (begin
        (set! tmp-ra.7 r15)
        (set! rax -167685894)
        (jump tmp-ra.7 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.25 tmp-ra.23)))
            (define L.func.0.1
              ((new-frames ()) (locals (foobar.8.1 bar.0.2 tmp-ra.20)))
              (begin
                (set! tmp-ra.20 r15)
                (set! bar.0.2 rdi)
                (set! foobar.8.1 rsi)
                (set! r9 foobar.8.1)
                (set! r8 foobar.8.1)
                (set! rcx bar.0.2)
                (set! rdx foobar.8.1)
                (set! rsi bar.0.2)
                (set! rdi foobar.8.1)
                (set! r15 tmp-ra.20)
                (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))
      (define L.fn.1.2
        ((new-frames ()) (locals (bar.0.8 foobar.1.11
                                          bar.9.12
                                          bar.0.13
                                          foobar.2.9
                                          tmp.24
                                          foobar.7.10
                                          foobar.5.3
                                          bat.3.4
                                          foobar.1.5
                                          foobar.2.6
                                          foo.6.7
                                          tmp-ra.21)))
        (begin
          (set! tmp-ra.21 r15)
          (set! foo.6.7 rdi)
          (set! foobar.2.6 rsi)
          (set! foobar.1.5 rdx)
          (set! bat.3.4 rcx)
          (set! foobar.5.3 r8)
          (set! foobar.7.10 foobar.5.3)
          (set! tmp.24 foobar.1.5)
          (set! tmp.24 (- tmp.24 foobar.2.6))
          (set! foobar.2.9 tmp.24)
          (set! bar.0.13 foobar.7.10)
          (set! bar.9.12 foobar.2.9)
          (set! foobar.1.11 foobar.1.5)
          (set! bar.0.8 bat.3.4)
          (set! r8 foobar.5.3)
          (set! rcx bat.3.4)
          (set! rdx foobar.5.3)
          (set! rsi -9223372036854775808)
          (set! rdi bat.3.4)
          (set! r15 tmp-ra.21)
          (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8)))
      (define L.fn.2.3
        ((new-frames ())
         (locals (foobar.7.14 foobar.8.15 ball.4.16 foobar.2.17 foobar.5.18 foobar.1.19 tmp-ra.22)))
        (begin
          (set! tmp-ra.22 r15)
          (set! foobar.1.19 rdi)
          (set! foobar.5.18 rsi)
          (set! foobar.2.17 rdx)
          (set! ball.4.16 rcx)
          (set! foobar.8.15 r8)
          (set! foobar.7.14 r9)
          (set! rsi ball.4.16)
          (set! rdi foobar.1.19)
          (set! r15 tmp-ra.22)
          (jump L.func.0.1 rbp r15 rdi rsi)))
      (begin
        (set! tmp-ra.23 r15)
        (set! tmp.25 1962527269)
        (set! tmp.25 (+ tmp.25 9223372036854775807))
        (set! rax tmp.25)
        (jump tmp-ra.23 rbp rax))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.3)))
                               (define L.func.0.1
                                 ((new-frames ()) (locals (tmp-ra.2 tmp.4 bat.0.1)))
                                 (begin
                                   (set! tmp-ra.2 r15)
                                   (set! bat.0.1 rdi)
                                   (if (if (true)
                                           (not (> bat.0.1 bat.0.1))
                                           (begin
                                             (set! tmp.4 2020417677)
                                             (>= tmp.4 -9223372036854775808)))
                                       (if (true)
                                           (if (= bat.0.1 bat.0.1)
                                               (begin
                                                 (set! rax bat.0.1)
                                                 (jump tmp-ra.2 rbp rax))
                                               (begin
                                                 (set! rax bat.0.1)
                                                 (jump tmp-ra.2 rbp rax)))
                                           (begin
                                             (set! rdi bat.0.1)
                                             (set! r15 tmp-ra.2)
                                             (jump L.func.0.1 rbp r15 rdi)))
                                       (begin
                                         (set! rdi 9223372036854775807)
                                         (set! r15 tmp-ra.2)
                                         (jump L.func.0.1 rbp r15 rdi)))))
                         (begin
                           (set! tmp-ra.3 r15)
                           (set! rdi 733499244)
                           (set! r15 tmp-ra.3)
                           (jump L.func.0.1 rbp r15 rdi))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (foobar.7.19 foo.8.20 ball.3.21 tmp-ra.25)))
            (define L.proc.0.1
              ((new-frames ()) (locals (foobar.1.1 foobar.4.2 foo.8.3 ball.3.4 tmp-ra.22)))
              (begin
                (set! tmp-ra.22 r15)
                (set! ball.3.4 rdi)
                (set! foo.8.3 rsi)
                (set! foobar.4.2 rdx)
                (set! foobar.1.1 rcx)
                (set! r8 foo.8.3)
                (set! rcx 1)
                (set! rdx 0)
                (set! rsi -9223372036854775808)
                (set! rdi 835392363)
                (set! r15 tmp-ra.22)
                (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8)))
      (define L.fn.1.2
        ((new-frames ()) (locals (foobar.4.5 bat.6.6 bar.2.7 foobar.7.8 bat.0.9 tmp-ra.23)))
        (begin
          (set! tmp-ra.23 r15)
          (set! bat.0.9 rdi)
          (set! foobar.7.8 rsi)
          (set! bar.2.7 rdx)
          (set! bat.6.6 rcx)
          (set! foobar.4.5 r8)
          (set! rdi foobar.7.8)
          (set! r15 tmp-ra.23)
          (jump L.x.2.3 rbp r15 rdi)))
      (define L.x.2.3
        ((new-frames (())) (locals (ball.3.13 foobar.7.14
                                              foobar.1.16
                                              foobar.7.17
                                              bat.0.18
                                              foo.9.15
                                              foo.9.11
                                              tmp.26
                                              bat.0.12
                                              foobar.7.10
                                              tmp-ra.24)))
        (begin
          (set! tmp-ra.24 r15)
          (set! foobar.7.10 rdi)
          (return-point L.rp.4
                        (begin
                          (set! rcx foobar.7.10)
                          (set! rdx foobar.7.10)
                          (set! rsi foobar.7.10)
                          (set! rdi foobar.7.10)
                          (set! r15 L.rp.4)
                          (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx)))
          (set! bat.0.12 rax)
          (set! tmp.26 bat.0.12)
          (set! tmp.26 (- tmp.26 bat.0.12))
          (set! foo.9.11 tmp.26)
          (if (<= foo.9.11 foobar.7.10)
              (set! foo.9.15 foo.9.11)
              (set! foo.9.15 foobar.7.10))
          (set! bat.0.18 foo.9.11)
          (set! foobar.7.17 foobar.7.10)
          (set! foobar.1.16 foo.9.11)
          (set! foobar.7.14 bat.0.18)
          (set! ball.3.13 foobar.7.10)
          (set! rdi ball.3.13)
          (set! r15 tmp-ra.24)
          (jump L.x.2.3 rbp r15 rdi)))
      (begin
        (set! tmp-ra.25 r15)
        (set! ball.3.21 1830309714)
        (set! foo.8.20 -9223372036854775808)
        (set! foobar.7.19 -9223372036854775808)
        (set! rax ball.3.21)
        (jump tmp-ra.25 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.13)))
            (define L.func.0.1
              ((new-frames ()) (locals (bar.7.1 bat.3.2 bat.6.3 foo.5.4 foobar.0.5 tmp-ra.10)))
              (begin
                (set! tmp-ra.10 r15)
                (set! foobar.0.5 rdi)
                (set! foo.5.4 rsi)
                (set! bat.6.3 rdx)
                (set! bat.3.2 rcx)
                (set! bar.7.1 r8)
                (set! rax bat.3.2)
                (jump tmp-ra.10 rbp rax)))
      (define L.func.1.2
        ((new-frames (())) (locals (foobar.4.6 bat.3.7 bat.2.8 tmp.14 tmp-ra.11)))
        (begin
          (set! tmp-ra.11 r15)
          (set! tmp.14 -620373304)
          (set! tmp.14 (- tmp.14 -68719063))
          (set! bat.2.8 tmp.14)
          (set! bat.3.7 0)
          (return-point L.rp.4
                        (begin
                          (set! r15 L.rp.4)
                          (jump L.func.1.2 rbp r15)))
          (set! foobar.4.6 rax)
          (set! rax bat.3.7)
          (jump tmp-ra.11 rbp rax)))
      (define L.x.2.3
        ((new-frames ()) (locals (bar.8.9 tmp-ra.12)))
        (begin
          (set! tmp-ra.12 r15)
          (set! bar.8.9 rdi)
          (set! r15 tmp-ra.12)
          (jump L.func.1.2 rbp r15)))
      (begin
        (set! tmp-ra.13 r15)
        (set! rax -575594324)
        (jump tmp-ra.13 rbp rax))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp.16 tmp-ra.14 foo.3.11 bat.6.10 foobar.4.9 tmp.15)))
            (define L.x.0.1
              ((new-frames ())
               (locals (bat.6.1 bar.5.2 bar.7.3 bat.2.4 foobar.0.5 foo.3.6 tmp-ra.12)))
              (begin
                (set! tmp-ra.12 r15)
                (set! foo.3.6 rdi)
                (set! foobar.0.5 rsi)
                (set! bat.2.4 rdx)
                (set! bar.7.3 rcx)
                (set! bar.5.2 r8)
                (set! bat.6.1 r9)
                (set! rsi 1)
                (set! rdi bar.7.3)
                (set! r15 tmp-ra.12)
                (jump L.x.1.2 rbp r15 rdi rsi)))
      (define L.x.1.2
        ((new-frames ()) (locals (foobar.4.8 tmp-ra.13 foobar.0.7)))
        (begin
          (set! tmp-ra.13 r15)
          (set! foobar.4.8 rdi)
          (set! foobar.0.7 rsi)
          (if (<= foobar.0.7 -9223372036854775808)
              (begin
                (set! r9 foobar.4.8)
                (set! r8 foobar.0.7)
                (set! rcx foobar.0.7)
                (set! rdx foobar.0.7)
                (set! rsi foobar.4.8)
                (set! rdi foobar.4.8)
                (set! r15 tmp-ra.13)
                (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9))
              (begin
                (set! rax foobar.0.7)
                (jump tmp-ra.13 rbp rax)))))
      (begin
        (set! tmp-ra.14 r15)
        (if (not (begin
                   (set! tmp.15 0)
                   (= tmp.15 -844906965)))
            (begin
              (set! foo.3.11 996590913)
              (set! bat.6.10 299367411)
              (set! foobar.4.9 -9223372036854775808)
              (set! rax foo.3.11)
              (jump tmp-ra.14 rbp rax))
            (if (begin
                  (set! tmp.16 894536270)
                  (> tmp.16 1910216157))
                (begin
                  (set! rax 1)
                  (jump tmp-ra.14 rbp rax))
                (begin
                  (set! rax 1)
                  (jump tmp-ra.14 rbp rax)))))))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.21 tmp.24)))
            (define L.tmp.0.1
              ((new-frames ())
               (locals
                (bar.3.7 bar.4.6 bat.2.8 tmp-ra.19 bat.6.5 foobar.8.3 bar.3.2 foo.1.1 bat.2.4)))
              (begin
                (set! tmp-ra.19 r15)
                (set! bat.6.5 rdi)
                (set! bat.2.4 rsi)
                (set! foobar.8.3 rdx)
                (set! bar.3.2 rcx)
                (set! foo.1.1 r8)
                (if (<= bat.2.4 9223372036854775807)
                    (if (true)
                        (begin
                          (set! fv0 bar.3.2)
                          (set! r9 -9223372036854775808)
                          (set! r8 1)
                          (set! rcx foobar.8.3)
                          (set! rdx bat.6.5)
                          (set! rsi foobar.8.3)
                          (set! rdi bar.3.2)
                          (set! r15 tmp-ra.19)
                          (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0))
                        (begin
                          (set! fv0 bat.6.5)
                          (set! r9 foo.1.1)
                          (set! r8 bar.3.2)
                          (set! rcx bar.3.2)
                          (set! rdx bat.2.4)
                          (set! rsi foobar.8.3)
                          (set! rdi bat.2.4)
                          (set! r15 tmp-ra.19)
                          (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
                    (begin
                      (set! bar.3.7 foo.1.1)
                      (set! bar.4.6 bat.6.5)
                      (set! bat.2.8 foobar.8.3)
                      (set! rax bat.2.8)
                      (jump tmp-ra.19 rbp rax)))))
      (define L.tmp.1.2
        ((new-frames (() () ())) (locals (bar.3.16 bat.0.17
                                                   tmp.23
                                                   tmp.22
                                                   foobar.8.18
                                                   bat.6.9
                                                   foobar.7.10
                                                   bat.2.11
                                                   bat.0.12
                                                   foobar.8.13
                                                   foo.1.14
                                                   bar.3.15
                                                   tmp-ra.20)))
        (begin
          (set! tmp-ra.20 r15)
          (set! bar.3.15 rdi)
          (set! foo.1.14 rsi)
          (set! foobar.8.13 rdx)
          (set! bat.0.12 rcx)
          (set! bat.2.11 r8)
          (set! foobar.7.10 r9)
          (set! bat.6.9 fv0)
          (if (not (begin
                     (set! tmp.22 1242010444)
                     (> tmp.22 foobar.8.13)))
              (begin
                (return-point L.rp.3
                              (begin
                                (set! r8 foobar.7.10)
                                (set! rcx 1)
                                (set! rdx bat.0.12)
                                (set! rsi foobar.7.10)
                                (set! rdi bat.2.11)
                                (set! r15 L.rp.3)
                                (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
                (set! foobar.8.18 rax))
              (begin
                (return-point L.rp.4
                              (begin
                                (set! r8 bat.0.12)
                                (set! rcx bat.0.12)
                                (set! rdx foo.1.14)
                                (set! rsi foobar.8.13)
                                (set! rdi foobar.8.13)
                                (set! r15 L.rp.4)
                                (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
                (set! foobar.8.18 rax)))
          (set! tmp.23 bat.6.9)
          (set! tmp.23 (* tmp.23 foo.1.14))
          (set! bat.0.17 tmp.23)
          (return-point L.rp.5
                        (begin
                          (set! r8 bat.2.11)
                          (set! rcx bat.2.11)
                          (set! rdx 0)
                          (set! rsi foo.1.14)
                          (set! rdi foo.1.14)
                          (set! r15 L.rp.5)
                          (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
          (set! bar.3.16 rax)
          (set! fv0 foobar.7.10)
          (set! r9 foobar.8.18)
          (set! r8 bat.6.9)
          (set! rcx bar.3.16)
          (set! rdx 1)
          (set! rsi foo.1.14)
          (set! rdi foobar.7.10)
          (set! r15 tmp-ra.20)
          (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))
      (begin
        (set! tmp-ra.21 r15)
        (if (not (begin
                   (set! tmp.24 1973720366)
                   (< tmp.24 1864083813)))
            (begin
              (set! rax 9223372036854775807)
              (jump tmp-ra.21 rbp rax))
            (begin
              (set! fv0 379193781)
              (set! r9 726597669)
              (set! r8 -264137160)
              (set! rcx -1022801227)
              (set! rdx 501537014)
              (set! rsi 9223372036854775807)
              (set! rdi 9223372036854775807)
              (set! r15 tmp-ra.21)
              (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0))))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (ball.8.3 bat.6.2 foo.5.1 tmp-ra.4)))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (set! ball.8.3 1521957632)
                                 (set! bat.6.2 -9223372036854775808)
                                 (set! foo.5.1 -9223372036854775808)
                                 (if (false)
                                     (if (!= bat.6.2 bat.6.2)
                                         (begin
                                           (set! rax foo.5.1)
                                           (jump tmp-ra.4 rbp rax))
                                         (begin
                                           (set! rax bat.6.2)
                                           (jump tmp-ra.4 rbp rax)))
                                     (if (> ball.8.3 -755834168)
                                         (begin
                                           (set! rax 0)
                                           (jump tmp-ra.4 rbp rax))
                                         (begin
                                           (set! rax bat.6.2)
                                           (jump tmp-ra.4 rbp rax)))))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals
              (ball.9.8 foo.4.2 foo.3.3 bar.0.4 ball.9.5 bar.7.6 foobar.8.7 ball.1.1 tmp-ra.9)))
            (begin
              (set! tmp-ra.9 r15)
              (set! ball.1.1 -9223372036854775808)
              (set! foobar.8.7 0)
              (set! bar.7.6 ball.1.1)
              (set! ball.9.5 ball.1.1)
              (set! bar.0.4 ball.9.5)
              (set! foo.3.3 ball.1.1)
              (if (> ball.1.1 ball.1.1)
                  (set! foo.4.2 ball.1.1)
                  (set! foo.4.2 ball.1.1))
              (set! ball.9.8 bar.0.4)
              (set! rax ball.1.1)
              (jump tmp-ra.9 rbp rax))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (foobar.1.10 foobar.3.11
                                                                     foobar.1.2
                                                                     tmp.13
                                                                     foo.8.3
                                                                     foobar.3.4
                                                                     foo.4.5
                                                                     foobar.5.6
                                                                     foo.8.7
                                                                     foobar.1.8
                                                                     foo.4.9
                                                                     foo.7.1
                                                                     tmp-ra.12)))
                               (begin
                                 (set! tmp-ra.12 r15)
                                 (set! foo.7.1 1)
                                 (if (= foo.7.1 foo.7.1)
                                     (begin
                                       (set! foo.8.7 foo.7.1)
                                       (set! foobar.5.6 foo.7.1)
                                       (set! foo.4.5 foo.7.1)
                                       (set! foobar.3.4 foo.7.1))
                                     (begin
                                       (set! foo.4.9 foo.7.1)
                                       (set! foobar.1.8 foo.7.1)
                                       (set! foobar.3.4 foo.7.1)))
                                 (set! foo.8.3 foo.7.1)
                                 (set! tmp.13 foo.7.1)
                                 (set! tmp.13 (+ tmp.13 foo.7.1))
                                 (set! foobar.1.2 tmp.13)
                                 (set! foobar.3.11 foobar.3.4)
                                 (set! foobar.1.10 1648274049)
                                 (set! rax foo.7.1)
                                 (jump tmp-ra.12 rbp rax))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.4)))
                               (define L.func.0.1
                                 ((new-frames ()) (locals (bat.8.1 bat.7.2 tmp-ra.3)))
                                 (begin
                                   (set! tmp-ra.3 r15)
                                   (set! bat.7.2 rdi)
                                   (set! bat.8.1 rsi)
                                   (set! rsi bat.8.1)
                                   (set! rdi 1)
                                   (set! r15 tmp-ra.3)
                                   (jump L.func.0.1 rbp r15 rdi rsi)))
                         (begin
                           (set! tmp-ra.4 r15)
                           (set! rax 0)
                           (jump tmp-ra.4 rbp rax))))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1 tmp.2)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (begin
                                       (set! tmp.2 -9223372036854775808)
                                       (> tmp.2 526950868))
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump tmp-ra.1 rbp rax))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (tmp-ra.18)))
            (define L.fn.0.1
              ((new-frames ()) (locals (bat.4.1 bar.7.2 ball.9.3 ball.3.4 foobar.6.5 tmp-ra.16)))
              (begin
                (set! tmp-ra.16 r15)
                (set! foobar.6.5 rdi)
                (set! ball.3.4 rsi)
                (set! ball.9.3 rdx)
                (set! bar.7.2 rcx)
                (set! bat.4.1 r8)
                (set! r9 ball.3.4)
                (set! r8 bar.7.2)
                (set! rcx bat.4.1)
                (set! rdx 1064830001)
                (set! rsi ball.3.4)
                (set! rdi bat.4.1)
                (set! r15 tmp-ra.16)
                (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
      (define L.func.1.2
        ((new-frames ()) (locals (ball.3.15 ball.1.14
                                            bat.4.12
                                            foo.5.9
                                            foo.8.13
                                            tmp-ra.17
                                            tmp.19
                                            ball.9.8
                                            tmp.20
                                            tmp.21
                                            ball.3.6
                                            bat.4.10
                                            ball.1.11
                                            foo.8.7)))
        (begin
          (set! tmp-ra.17 r15)
          (set! ball.1.11 rdi)
          (set! bat.4.10 rsi)
          (set! foo.5.9 rdx)
          (set! ball.9.8 rcx)
          (set! foo.8.7 r8)
          (set! ball.3.6 r9)
          (if (if (if (< foo.8.7 foo.8.7)
                      (= ball.1.11 ball.1.11)
                      (!= bat.4.10 foo.8.7))
                  (= ball.3.6 0)
                  (if (begin
                        (set! tmp.19 0)
                        (> tmp.19 ball.3.6))
                      (begin
                        (set! tmp.20 1)
                        (<= tmp.20 ball.9.8))
                      (begin
                        (set! tmp.21 529266316)
                        (>= tmp.21 foo.8.7))))
              (if (begin
                    (set! bat.4.12 foo.5.9)
                    (<= ball.9.8 bat.4.12))
                  (begin
                    (set! foo.8.13 ball.3.6)
                    (set! rax ball.3.6)
                    (jump tmp-ra.17 rbp rax))
                  (begin
                    (set! r9 ball.3.6)
                    (set! r8 foo.5.9)
                    (set! rcx bat.4.10)
                    (set! rdx bat.4.10)
                    (set! rsi ball.1.11)
                    (set! rdi foo.5.9)
                    (set! r15 tmp-ra.17)
                    (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
              (begin
                (set! ball.3.15 foo.5.9)
                (set! ball.1.14 ball.3.15)
                (set! r9 foo.5.9)
                (set! r8 ball.1.14)
                (set! rcx foo.5.9)
                (set! rdx ball.3.6)
                (set! rsi ball.3.6)
                (set! rdi ball.1.14)
                (set! r15 tmp-ra.17)
                (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (begin
        (set! tmp-ra.18 r15)
        (set! r9 0)
        (set! r8 0)
        (set! rcx 1)
        (set! rdx 1)
        (set! rsi -1337458253)
        (set! rdi 9223372036854775807)
        (set! r15 tmp-ra.18)
        (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))
  (check-by-interp-v6
   '(module ((new-frames ())
             (locals (bar.9.4 tmp.9 tmp-ra.5 bat.2.3 bat.2.2 tmp.8 bar.8.1 tmp.7 tmp.6)))
            (begin
              (set! tmp-ra.5 r15)
              (if (if (begin
                        (set! tmp.6 9223372036854775807)
                        (!= tmp.6 2124101395))
                      (true)
                      (not (begin
                             (set! tmp.7 9223372036854775807)
                             (<= tmp.7 0))))
                  (begin
                    (set! bat.2.3 -9223372036854775808)
                    (set! bat.2.2 -9223372036854775808)
                    (set! tmp.8 9223372036854775807)
                    (set! tmp.8 (* tmp.8 -9223372036854775808))
                    (set! bar.8.1 tmp.8)
                    (set! rax bat.2.2)
                    (jump tmp-ra.5 rbp rax))
                  (begin
                    (set! tmp.9 1865158198)
                    (set! tmp.9 (+ tmp.9 1))
                    (set! bar.9.4 tmp.9)
                    (if (> bar.9.4 bar.9.4)
                        (begin
                          (set! rax bar.9.4)
                          (jump tmp-ra.5 rbp rax))
                        (begin
                          (set! rax bar.9.4)
                          (jump tmp-ra.5 rbp rax))))))
      ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1 tmp.2)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (begin
                                       (set! tmp.2 1069510162)
                                       (>= tmp.2 -9223372036854775808))
                                     (begin
                                       (set! rax 1)
                                       (jump tmp-ra.1 rbp rax))
                                     (begin
                                       (set! rax 323863587)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp.2 tmp-ra.1)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (set! tmp.2 379335310)
                                 (set! tmp.2 (* tmp.2 0))
                                 (set! rax tmp.2)
                                 (jump tmp-ra.1 rbp rax))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()) (locals (tmp-ra.1)))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (set! rax 0)
                                 (jump tmp-ra.1 rbp rax))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()) (locals (bat.0.3 foo.5.4 ball.3.5 bat.0.1 bat.2.2 tmp.7 tmp-ra.6)))
            (begin
              (set! tmp-ra.6 r15)
              (set! tmp.7 -9223372036854775808)
              (set! tmp.7 (- tmp.7 0))
              (set! bat.2.2 tmp.7)
              (set! bat.0.1 -9223372036854775808)
              (set! ball.3.5 1969620648)
              (set! foo.5.4 bat.2.2)
              (set! bat.0.3 bat.0.1)
              (set! rax foo.5.4)
              (jump tmp-ra.6 rbp rax))
      ))

  ;;

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp '(module ((locals ()))
                            (define L.L.func.0.1.4
                              ((locals ()))
                              (halt 0))
                      (define L.L.tmp.1.2.5
                        ((locals (foo.2.1.5)))
                        (begin
                          (set! foo.2.1.5 rdi)
                          (jump L.L.func.0.1.4 rbp)))
                      (define L.L.func.2.3.6
                        ((locals (tmp.10 foobar.6.4.8 bar.4.2.6 foo.2.3.7 tmp.9)))
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
  (check-by-interp '(module ((locals (tmp.20 ball.0.4.8 tmp.18 tmp.19)))
                            (define L.L.tmp.0.1.4
                              ((locals (tmp.10 tmp.11 tmp.9)))
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
                        ((locals (bar.1.1.5 tmp.12)))
                        (begin
                          (set! bar.1.1.5 -9223372036854775808)
                          (if (not (begin
                                     (set! tmp.12 9223372036854775807)
                                     (> tmp.12 0)))
                              (halt 1309557052)
                              (halt bar.1.1.5))))
                      (define L.L.x.2.3.6
                        ((locals (tmp.17 bar.3.3.7 tmp.16 tmp.14 tmp.15 ball.0.2.6 tmp.13)))
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
  (check-by-interp '(module ((locals ()))
                            (define L.L.proc.0.1.4
                              ((locals (ball.6.1.5)))
                              (begin
                                (set! ball.6.1.5 rdi)
                                (jump L.L.func.1.2.5 rbp)))
                      (define L.L.func.1.2.5
                        ((locals (tmp.10 tmp.9)))
                        (begin
                          (set! tmp.10 1)
                          (set! tmp.10 (* tmp.10 0))
                          (set! tmp.9 tmp.10)
                          (halt tmp.9)))
                      (define L.L.fn.2.3.6
                        ((locals (ball.3.2.6 bat.0.3.7 tmp.11 foo.4.4.8)))
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
  (check-by-interp '(module ((locals (tmp.7)))
                            (define L.fn.0.1
                              ((locals (foo.5.2 foo.5.4 ball.4.3 bat.9.1 tmp.6 tmp.5)))
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
  (check-by-interp '(module ((locals (tmp.2 tmp.1)))
                            (begin
                              (set! tmp.2 -9223372036854775808)
                              (set! tmp.2 (+ tmp.2 -1465538260))
                              (set! tmp.1 tmp.2)
                              (halt tmp.1))
                      ))
  (check-by-interp '(module ((locals (ball.9.9 bat.5.8)))
                            (define L.fn.0.1
                              ((locals (foo.8.2 foo.1.3 tmp.10 bar.2.1)))
                              (begin
                                (set! tmp.10 1)
                                (set! tmp.10 (+ tmp.10 9223372036854775807))
                                (set! bar.2.1 tmp.10)
                                (set! foo.1.3 bar.2.1)
                                (set! foo.8.2 foo.1.3)
                                (halt bar.2.1)))
                      (define L.func.1.2
                        ((locals (tmp.13 tmp.11 foo.8.5 ball.3.4 foo.1.6 foo.8.7 tmp.12)))
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
  (check-by-interp '(module ((locals (tmp.13)))
                            (define L.x.0.1
                              ((locals (foo.0.1 ball.1.2)))
                              (begin
                                (set! ball.1.2 rdi)
                                (set! foo.0.1 rsi)
                                (jump L.tmp.1.2 rbp)))
                      (define L.tmp.1.2
                        ((locals (tmp.12 foobar.9.5 tmp.11 ball.4.3 bar.5.4 tmp.10 tmp.9 tmp.8)))
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
                        ((locals (ball.6.6 ball.4.7)))
                        (begin
                          (set! ball.4.7 rdi)
                          (set! ball.6.6 rsi)
                          (jump L.tmp.1.2 rbp)))
                      (if (begin
                            (set! tmp.13 0)
                            (<= tmp.13 1))
                          (halt -1271132888)
                          (halt 2101306416))))
  (check-by-interp '(module ((locals (tmp.7)))
                            (define L.proc.0.1
                              ((locals (bat.3.5 tmp.6 bat.7.2 bat.4.3 foobar.2.4 bar.8.1)))
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
  (check-by-interp '(module ((locals (ball.1.5 foobar.4.4 tmp.8)))
                            (define L.proc.0.1
                              ((locals (tmp.6 ball.3.1 bat.9.3 foobar.4.2 tmp.7)))
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
                        ((locals ()))
                        (halt 1))
                      (begin
                        (set! ball.1.5 453798193)
                        (set! foobar.4.4 ball.1.5)
                        (if (begin
                              (set! tmp.8 9223372036854775807)
                              (>= tmp.8 foobar.4.4))
                            (halt 0)
                            (halt -1617493587)))))
  (check-by-interp '(module ((locals (tmp.5 tmp.6)))
                            (define L.func.0.1
                              ((locals (tmp.4 tmp.3 bat.8.1 bat.2.2)))
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
                        ((locals ()))
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
  (check-by-interp '(module ((locals ()))
                            (define L.func.0.1
                              ((locals (foobar.4.1 bat.7.2 bar.1.3 foo.2.4 foo.9.5)))
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
  (check-by-interp
   '(module ((locals (ball.6.6)))
            (define L.tmp.0.1
              ((locals (foobar.0.1 bar.8.2 tmp.9 bat.2.5 tmp.10 tmp.8 ball.6.4 bat.5.3 tmp.7)))
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
  (check-by-interp
   '(module ((locals ()))
            (define L.func.0.1
              ((locals (ball.6.2 tmp.16 tmp.15 tmp.17 tmp.13 tmp.14 foobar.3.1 tmp.12)))
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
        ((locals (ball.5.7 bat.9.5 bat.2.6 tmp.18 tmp.19 ball.1.4 bar.0.3 foo.7.8)))
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
        ((locals (tmp.24 ball.1.10 foo.4.11 tmp.22 tmp.23 tmp.20 foobar.8.9 tmp.21)))
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
  (check-by-interp
   '(module ((locals (bat.0.13)))
            (define L.proc.0.1
              ((locals (ball.2.1 foo.7.2 ball.4.3)))
              (begin
                (set! ball.4.3 rdi)
                (set! foo.7.2 rsi)
                (set! ball.2.1 rdx)
                (set! rdx foo.7.2)
                (set! rsi ball.2.1)
                (set! rdi 9223372036854775807)
                (jump L.proc.0.1 rbp rdi rsi rdx)))
      (define L.func.1.2
        ((locals
          (bar.3.10 foobar.5.12 ball.4.11 bar.3.4 foobar.6.5 ball.4.6 foo.7.7 bat.0.8 ball.1.9)))
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
  (check-by-interp '(module ((locals (ball.2.2 bar.5.1)))
                            (begin
                              (set! ball.2.2 9223372036854775807)
                              (set! bar.5.1 -546026276)
                              (if (!= bar.5.1 1)
                                  (halt 9223372036854775807)
                                  (halt 2063023986)))
                      ))
  (check-by-interp
   '(module ((locals (tmp.10)))
            (define L.func.0.1
              ((locals (bat.7.5 bar.2.1 tmp.9 tmp.7 tmp.6 foobar.6.4 tmp.8 foo.8.2 foo.8.3)))
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
  (check-by-interp
   '(module ((locals (tmp.24 tmp.23)))
            (define L.fn.0.1
              ((locals (bat.4.5 tmp.16 bat.4.4 tmp.15 foobar.3.2 ball.7.1 bar.9.3 tmp.17)))
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
        ((locals (tmp.20 foobar.3.7 bat.2.9 bat.4.8 tmp.18 bat.2.6 tmp.19)))
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
        ((locals (tmp.22 foobar.1.14 ball.8.10 foo.0.11 ball.7.12 foo.5.13 tmp.21)))
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
  (check-by-interp '(module ((locals ()))
                            (define L.proc.0.1
                              ((locals (ball.6.9 foo.4.10
                                                 bar.7.8
                                                 bar.9.7
                                                 tmp.11
                                                 bar.5.1
                                                 ball.8.3
                                                 bar.0.5
                                                 foobar.1.6
                                                 bat.3.2
                                                 foobar.2.4)))
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
  (check-by-interp
   '(module ((locals (bar.0.27)))
            (define L.x.0.1
              ((locals
                (ball.2.1 bat.7.7 ball.4.3 bar.0.2 ball.4.8 foobar.3.5 ball.5.4 ball.9.6 tmp.28)))
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
        ((locals (ball.2.9 ball.9.13
                           bat.7.14
                           bar.0.10
                           ball.5.12
                           foobar.3.15
                           ball.9.16
                           bat.7.17
                           tmp.29
                           foo.6.11
                           tmp.30)))
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
        ((locals (ball.2.25 foo.6.26
                            bar.0.18
                            foobar.3.20
                            bat.7.23
                            tmp.32
                            bar.8.19
                            ball.2.22
                            foo.6.21
                            foobar.3.24
                            tmp.31)))
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
  (check-by-interp
   '(module ((locals ()))
            (define L.tmp.0.1
              ((locals (tmp.18 ball.7.1 bat.0.2 ball.8.3 bat.3.4 bar.9.5 ball.6.6 foo.1.7 tmp.17)))
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
        ((locals (bat.3.13 bar.9.8 bat.3.9 foo.5.10 bar.2.11 foo.1.12)))
        (begin
          (set! foo.1.12 rdi)
          (set! bar.2.11 rsi)
          (set! foo.5.10 rdx)
          (set! bat.3.9 rcx)
          (set! bar.9.8 r8)
          (set! bat.3.13 1)
          (halt 9223372036854775807)))
      (define L.fn.2.3
        ((locals (bat.3.16 tmp.19 ball.8.14 ball.7.15)))
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
  (check-by-interp '(module ((locals (tmp.3 tmp.1 tmp.2)))
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
  (check-by-interp
   '(module ((locals
              (tmp.59 foobar.2.41 foobar.2.42 tmp.56 tmp.57 foobar.5.43 tmp.58 foo.6.40 bar.9.44)))
            (define L.x.0.1
              ((locals (ball.8.1 foobar.5.2 foo.6.3 foobar.2.4 foo.3.5 foobar.1.6 ball.0.7)))
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
        ((locals (bar.9.8 foobar.1.9 tmp.45)))
        (begin
          (set! bar.9.8 9223372036854775807)
          (set! foobar.1.9 bar.9.8)
          (if (begin
                (set! tmp.45 -577997854)
                (>= tmp.45 foobar.1.9))
              (halt -9223372036854775808)
              (halt bar.9.8))))
      (define L.fn.2.3
        ((locals (tmp.46 foobar.1.11 ball.7.10)))
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
        ((locals (ball.7.12 foo.3.13 ball.8.14 foobar.2.15 bar.9.16 foobar.5.17 foobar.4.18)))
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
        ((locals (foobar.4.19)))
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
        ((locals (foo.6.28 foobar.1.27
                           foobar.5.20
                           foobar.1.21
                           foobar.5.26
                           foobar.4.23
                           ball.8.29
                           bar.9.22
                           foo.6.25
                           foo.3.24)))
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
        ((locals (foobar.5.30 foobar.1.31
                              foo.3.32
                              ball.8.33
                              ball.0.34
                              foo.6.35
                              foobar.1.39
                              tmp.49
                              ball.8.38
                              tmp.48
                              tmp.47
                              foobar.2.36
                              ball.0.37)))
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
        ((locals (tmp.52 tmp.53 tmp.54 tmp.55 tmp.50 tmp.51)))
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

  (define (set-list=? a b)
    (set=? (list->set a) (list->set b)))

  (check-match (undead-analysis '(module ((locals (x.1)))
                                         (begin
                                           (set! x.1 42)
                                           (halt x.1))
                                   ))
               `(module ((locals (x.1)) (undead-out (,(? (lambda (x) (set-list=? x '(x.1)))) ())))
                        (begin
                          (set! x.1 42)
                          (halt x.1))
                  ))

  (check-equal? (undead-analysis '(module ((locals (x.1)))
                                          (begin
                                            (begin
                                              (set! x.1 1))
                                            (halt x.1))
                                    ))
                `(module ((locals (x.1)) (undead-out (((x.1)) ())))
                         (begin
                           (begin
                             (set! x.1 1))
                           (halt x.1))
                   ))

  (check-equal? (undead-analysis '(module ((locals (x.1)))
                                          (begin
                                            (begin
                                              (begin
                                                (set! x.1 1)))
                                            (halt x.1))
                                    ))
                `(module ((locals (x.1)) (undead-out ((((x.1))) ())))
                         (begin
                           (begin
                             (begin
                               (set! x.1 1)))
                           (halt x.1))
                   ))

  (check-match (undead-analysis '(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1)))
                                         (begin
                                           (set! v.1 1)
                                           (set! w.2 46)
                                           (set! x.3 v.1)
                                           (set! p.1 7)
                                           (set! x.3 (+ x.3 p.1))
                                           (set! y.4 x.3)
                                           (set! p.1 4)
                                           (set! y.4 (+ y.4 p.1))
                                           (set! z.5 x.3)
                                           (set! z.5 (+ z.5 w.2))
                                           (set! t.6 y.4)
                                           (set! p.1 -1)
                                           (set! t.6 (* t.6 p.1))
                                           (set! z.5 (+ z.5 t.6))
                                           (halt z.5))
                                   ))
               `(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
                         (undead-out (,(? (lambda (x) (set-list=? x '(v.1))))
                                      ,(? (lambda (x) (set-list=? x '(v.1 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(x.3 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(p.1 x.3 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(x.3 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(y.4 x.3 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(p.1 y.4 x.3 w.2))))
                                      ,(? (lambda (x) (set-list=? x '(x.3 w.2 y.4))))
                                      ,(? (lambda (x) (set-list=? x '(w.2 z.5 y.4))))
                                      ,(? (lambda (x) (set-list=? x '(y.4 z.5))))
                                      ,(? (lambda (x) (set-list=? x '(t.6 z.5))))
                                      ,(? (lambda (x) (set-list=? x '(p.1 t.6 z.5))))
                                      ,(? (lambda (x) (set-list=? x '(t.6 z.5))))
                                      ,(? (lambda (x) (set-list=? x '(z.5))))
                                      ())))
                        (begin
                          (set! v.1 1)
                          (set! w.2 46)
                          (set! x.3 v.1)
                          (set! p.1 7)
                          (set! x.3 (+ x.3 p.1))
                          (set! y.4 x.3)
                          (set! p.1 4)
                          (set! y.4 (+ y.4 p.1))
                          (set! z.5 x.3)
                          (set! z.5 (+ z.5 w.2))
                          (set! t.6 y.4)
                          (set! p.1 -1)
                          (set! t.6 (* t.6 p.1))
                          (set! z.5 (+ z.5 t.6))
                          (halt z.5))
                  ))

  (check-equal? (undead-analysis `(module ((locals (x.1 y.2 b.3 c.4)))
                                          (begin
                                            (set! x.1 5)
                                            (set! y.2 x.1)
                                            (begin
                                              (set! b.3 x.1)
                                              (set! b.3 (+ b.3 y.2))
                                              (set! c.4 b.3)
                                              (if (= c.4 b.3)
                                                  (halt c.4)
                                                  (begin
                                                    (set! x.1 c.4)
                                                    (halt c.4)))))
                                    ))
                `(module ((locals (x.1 y.2 b.3 c.4))
                          (undead-out ((x.1) (x.1 y.2)
                                             ((y.2 b.3) (b.3) (b.3 c.4) ((c.4) () ((c.4) ()))))))
                         (begin
                           (set! x.1 5)
                           (set! y.2 x.1)
                           (begin
                             (set! b.3 x.1)
                             (set! b.3 (+ b.3 y.2))
                             (set! c.4 b.3)
                             (if (= c.4 b.3)
                                 (halt c.4)
                                 (begin
                                   (set! x.1 c.4)
                                   (halt c.4)))))
                   ))

  (check-equal? (undead-analysis `(module ((locals (x.1 y.2 b.3 c.4)))
                                          (begin
                                            (set! x.1 5)
                                            (set! y.2 x.1)
                                            (begin
                                              (set! b.3 x.1)
                                              (set! b.3 (+ b.3 y.2))
                                              (set! c.4 b.3)
                                              (if (= c.4 b.3)
                                                  (halt c.4)
                                                  (begin
                                                    (set! x.1 c.4)
                                                    (set! x.1 y.2)
                                                    (halt c.4)))))
                                    ))
                `(module ((locals (x.1 y.2 b.3 c.4))
                          (undead-out ((x.1) (x.1 y.2)
                                             ((b.3 y.2) (b.3 y.2)
                                                        (b.3 y.2 c.4)
                                                        ((y.2 c.4) () ((y.2 c.4) (c.4) ()))))))
                         (begin
                           (set! x.1 5)
                           (set! y.2 x.1)
                           (begin
                             (set! b.3 x.1)
                             (set! b.3 (+ b.3 y.2))
                             (set! c.4 b.3)
                             (if (= c.4 b.3)
                                 (halt c.4)
                                 (begin
                                   (set! x.1 c.4)
                                   (set! x.1 y.2)
                                   (halt c.4)))))
                   ))

  (check-equal?
   (undead-analysis `(module ((locals (x.1 y.2 b.3 c.4)))
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
   `(module ((locals (x.1 y.2 b.3 c.4)) (undead-out ((x.1) (x.1 y.2)
                                                           ((b.3 y.2) (b.3 y.2)
                                                                      (y.2 c.4)
                                                                      (((y.2 c.4) (y.2 c.4) (y.2 c.4))
                                                                       ()
                                                                       ((y.2 c.4) (c.4) ()))))))
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
  (check-equal? (undead-analysis `(module ((locals (x.3 y.4 z.4)))
                                          (begin
                                            (begin
                                              (begin
                                                (set! z.4 4)
                                                (set! z.4 (+ z.4 5))
                                                (set! y.4 z.4))
                                              (set! x.3 y.4))
                                            (halt x.3))
                                    ))
                `(module ((locals (x.3 y.4 z.4)) (undead-out ((((((z.4) (z.4) y.4)) x.3)) ())))
                         (begin
                           (begin
                             (begin
                               (set! z.4 4)
                               (set! z.4 (+ z.4 5))
                               (set! y.4 z.4))
                             (set! x.3 y.4))
                           (halt x.3))
                   ))
  (check-equal? (undead-analysis '(module ((locals (x.1)))
                                          (define L.test.1
                                            ((locals (x.1 x.3 y.4 z.4)))
                                            (begin
                                              (begin
                                                (begin
                                                  (set! z.4 x.1)
                                                  (set! z.4 (+ z.4 5))
                                                  (set! y.4 z.4))
                                                (set! x.3 y.4))
                                              (halt x.3)))
                                    (begin
                                      (begin
                                        (set! x.1 1))
                                      (jump L.test.1 x.1))))
                `(module ((locals (x.1)) (undead-out (((x.1)) (x.1))))
                         (define L.test.1
                           ((locals (x.1 x.3 y.4 z.4)) (undead-out ((((((z.4) (z.4) y.4)) x.3)) ())))
                           (begin
                             (begin
                               (begin
                                 (set! z.4 x.1)
                                 (set! z.4 (+ z.4 5))
                                 (set! y.4 z.4))
                               (set! x.3 y.4))
                             (halt x.3)))
                   (begin
                     (begin
                       (set! x.1 1))
                     (jump L.test.1 x.1)))))
