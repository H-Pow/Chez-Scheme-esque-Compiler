#lang racket

(require cpsc411/compiler-lib)

(provide select-instructions)

;; (imp-cmf-lang-v6 p) -> (asm-pred-lang-v6 p)
;; Compiles imp-cmf-lang-v6 to asm-pred-lang-v6 by selecting appropriate sequences of abstract
;; assembly instructions to implement the operations of the source language.
(define (select-instructions p)

  ; (imp-cmf-lang-v6 value) -> (List-of (asm-pred-lang-v6 effect)) and (asm-pred-lang-v6 aloc)
  ; Assigns the value v to a fresh temporary, returning two values: the list of
  ; statements that implement the assignment in asm-pred-lang, and the aloc that the
  ; value is stored in.
  (define (assign-tmp v)
    (define tmp (fresh 'tmp))
    (match v
      [`(,binop ,triv1 ,triv2)
       (list (list `(set! ,tmp ,triv1) `(set! ,tmp (,binop ,tmp ,triv2))) tmp)]
      [_ (list (list `(set! ,tmp ,v)) tmp)]))

  (define (select-pred pred)
    (match pred
      [`(not ,pred) `(not ,(select-pred pred))]
      [`(begin
          ,fxs ...
          ,pred)
       (append `(begin) (foldr append '() (map select-effect fxs)) (list (select-pred pred)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(select-pred pred1)
            ,(select-pred pred2)
            ,(select-pred pred3))]
      [`(,relop ,triv1 ,triv2)
       #:when (int64? triv1)
       (match-let ([`(,fxs ,aloc) (assign-tmp triv1)])
         `(begin
            ,@fxs
            (,relop ,aloc ,triv2)))]
      [_ pred]))

  ; (imp-cmf-lang-v6 tail) [bool] -> (asm-pred-lang-v6 tail)
  (define (select-tail e [begun #f])
    (match e
      [`(begin
          ,fxs ...
          ,tail)
       (append (if (not begun)
                   '(begin)
                   '())
               (foldr append '() (map select-effect fxs))
               (select-tail tail #t))]
      [`(if ,pred ,tail1 ,tail2)
       (let ([result `(if ,(select-pred pred)
                          ,(select-tail tail1)
                          ,(select-tail tail2))])
         (if (not begun)
             result
             `(,result)))]
      [`(jump ,trg ,loc ...)
       (if begun
           `(,e)
           e)]
      [_
       (match-let ([`(,fxs ,atail) (select-value e)])
         (append (if (not begun)
                     '(begin)
                     '())
                 fxs
                 (list atail)))]))

  ; (imp-cmf-lang-v6 value) -> (list (listof (asm-pred-lang-v6 effect)) (asm-pred-lang-v6 tail))
  (define (select-value e)
    (match e
      [`(,binop ,triv1 ,triv2)
       (match-let ([`(,fxs ,aloc) (assign-tmp e)])
         (list fxs `(halt ,aloc)))]
      [_ `(() (halt ,e))]))

  ; (imp-cmf-lang-v6 value) -> (listof (asm-pred-lang-v6 effect))
  ;; selects appropriate abstract assembly instructions for values in effect position
  (define (value->effect* loc value)
    (match value
      [`(,binop ,opand1 ,opand2)
       #:when (not (equal? opand1 loc))
       `((set! ,loc ,opand1) (set! ,loc (,binop ,loc ,opand2)))]
      [_ `((set! ,loc ,value))]))

  ; (imp-cmf-lang-v6 effect) -> (listof (asm-pred-lang-v6 effect))
  (define (select-effect e)
    (match e
      [`(set! ,loc ,rest) (value->effect* loc rest)]
      [`(begin
          ,fxs ...)
       (list `(begin
                ,@(foldr append '() (map select-effect fxs))))]
      [`(if ,pred ,effect1 ,effect2)
       (define e1 (select-effect effect1))
       (define e2 (select-effect effect2))
       `((if ,(select-pred pred)
             ,(if (null? (rest e1))
                  (first e1)
                  `(begin
                     ,@e1))
             ,(if (null? (rest e1))
                  (first e2)
                  `(begin
                     ,@e2))))]))

  ;; (imp-cmf-lang-v6 definition) -> (imp-cmf-lang-v6 definition)
  (define (select-def def)
    (match def
      [`(define ,label ,tail)
       `(define ,label
          ()
          ,(select-tail tail))]))

  (define (select-p p)
    (match p
      [`(module ,defs ...
          ,tail)
       `(module () ,@(map select-def defs)
          ,(select-tail tail))]))

  (select-p p))

(module+ test

  (require rackunit
           cpsc411/langs/v5
           cpsc411/langs/v6)
  (define-syntax-rule (check-by-interp icmflv5)
    (check-equal? (interp-imp-cmf-lang-v5 icmflv5)
                  (interp-asm-pred-lang-v5 (select-instructions icmflv5))))
  (define-syntax-rule (check-by-interp-v6 p)
    (check-equal? (interp-imp-cmf-lang-v6 p) (interp-asm-pred-lang-v6 (select-instructions p))))

  ;; M6 tests; Added by Trevor on March 6th 2026, at most one binding per let
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (begin
                                   (begin
                                     (set! bat.9.2 -422317085)
                                     (set! foobar.3.1 bat.9.2))
                                   (begin
                                     (set! ball.2.3 foobar.3.1)
                                     (begin
                                       (set! rax foobar.3.1)
                                       (jump tmp-ra.4 rbp rax)))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.12 r15)
                                   (begin
                                     (set! ball.3.5 rdi)
                                     (set! ball.4.4 rsi)
                                     (set! bat.0.3 rdx)
                                     (set! bat.5.2 rcx)
                                     (set! foobar.2.1 r8)
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.12 rbp rax)))))
                         (define L.proc.1.2
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.13 r15)
                             (begin
                               (set! bat.0.7 rdi)
                               (set! bar.7.6 rsi)
                               (begin
                                 (set! bar.7.8 bat.0.7)
                                 (begin
                                   (begin
                                     (return-point L.rp.3
                                                   (begin
                                                     (set! rsi bar.7.8)
                                                     (set! rdi bar.7.8)
                                                     (set! r15 L.rp.3)
                                                     (jump L.proc.1.2 rbp r15 rdi rsi)))
                                     (set! ball.8.9 rax))
                                   (if (= -59730991 bat.0.7)
                                       (begin
                                         (set! rax 0)
                                         (jump tmp-ra.13 rbp rax))
                                       (begin
                                         (set! rax bar.7.8)
                                         (jump tmp-ra.13 rbp rax))))))))
                         (begin
                           (set! tmp-ra.14 r15)
                           (begin
                             (if (false)
                                 (set! foobar.9.10 9223372036854775807)
                                 (set! foobar.9.10 (* 1 -9223372036854775808)))
                             (if (not (> foobar.9.10 foobar.9.10))
                                 (begin
                                   (set! ball.6.11 foobar.9.10)
                                   (begin
                                     (set! rax -1510146984)
                                     (jump tmp-ra.14 rbp rax)))
                                 (begin
                                   (set! rsi foobar.9.10)
                                   (set! rdi -9223372036854775808)
                                   (set! r15 tmp-ra.14)
                                   (jump L.proc.1.2 rbp r15 rdi rsi)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.6 r15)
                                 (begin
                                   (if (begin
                                         (set! bat.8.2 -1418594624)
                                         (false))
                                       (begin
                                         (if (> -1123833745 1)
                                             (set! bat.9.3 1)
                                             (set! bat.9.3 0))
                                         (begin
                                           (set! bat.9.4 767736686)
                                           (set! bat.9.1 bat.9.4)))
                                       (if (true)
                                           (begin
                                             (set! bat.3.5 1942655457)
                                             (set! bat.9.1 bat.3.5))
                                           (set! bat.9.1 (+ -9223372036854775808 1))))
                                   (begin
                                     (set! rax (- bat.9.1 bat.9.1))
                                     (jump tmp-ra.6 rbp rax))))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.func.0.1
              ((new-frames (())))
              (begin
                (set! tmp-ra.8 r15)
                (begin
                  (set! foobar.8.5 rdi)
                  (set! foobar.9.4 rsi)
                  (set! bat.2.3 rdx)
                  (set! foo.7.2 rcx)
                  (set! bat.0.1 r8)
                  (begin
                    (begin
                      (return-point L.rp.2
                                    (begin
                                      (set! r8 bat.0.1)
                                      (set! rcx foo.7.2)
                                      (set! rdx foobar.9.4)
                                      (set! rsi -9223372036854775808)
                                      (set! rdi -1343541856)
                                      (set! r15 L.rp.2)
                                      (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))
                      (set! foo.3.6 rax))
                    (if (!= 0 9223372036854775807)
                        (if (= 1346978436 bat.0.1)
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
                          (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))))))
      (begin
        (set! tmp-ra.9 r15)
        (begin
          (if (< 824269768 9223372036854775807)
              (set! foobar.5.7 -9223372036854775808)
              (set! foobar.5.7 709343632))
          (begin
            (set! rax foobar.5.7)
            (jump tmp-ra.9 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.2 r15)
                                 (begin
                                   (set! foo.6.1 -356902212)
                                   (begin
                                     (set! rax (+ -979281755 9223372036854775807))
                                     (jump tmp-ra.2 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.4 r15)
                                   (begin
                                     (set! ball.6.3 rdi)
                                     (set! foobar.9.2 rsi)
                                     (set! foo.5.1 rdx)
                                     (begin
                                       (set! rdx foo.5.1)
                                       (set! rsi 182548382)
                                       (set! rdi 0)
                                       (set! r15 tmp-ra.4)
                                       (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))))
                         (begin
                           (set! tmp-ra.5 r15)
                           (if (= 1 -444572554)
                               (begin
                                 (set! rax -9223372036854775808)
                                 (jump tmp-ra.5 rbp rax))
                               (begin
                                 (set! rax 0)
                                 (jump tmp-ra.5 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.x.0.1
              ((new-frames (())))
              (begin
                (set! tmp-ra.14 r15)
                (begin
                  (set! ball.3.5 rdi)
                  (set! bar.7.4 rsi)
                  (set! bat.6.3 rdx)
                  (set! ball.4.2 rcx)
                  (set! bat.5.1 r8)
                  (if (not (<= bat.6.3 9223372036854775807))
                      (begin
                        (begin
                          (set! bat.6.7 -18835826)
                          (set! foobar.9.6 bat.6.7))
                        (if (>= bat.6.3 ball.4.2)
                            (begin
                              (set! rax bat.6.3)
                              (jump tmp-ra.14 rbp rax))
                            (begin
                              (set! rax bar.7.4)
                              (jump tmp-ra.14 rbp rax))))
                      (begin
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
                          (set! bat.5.8 rax))
                        (if (<= bar.7.4 -186024487)
                            (begin
                              (set! rax bat.5.8)
                              (jump tmp-ra.14 rbp rax))
                            (begin
                              (set! rax bat.6.3)
                              (jump tmp-ra.14 rbp rax))))))))
      (define L.func.1.2
        ((new-frames ()))
        (begin
          (set! tmp-ra.15 r15)
          (begin
            (set! bar.8.10 rdi)
            (set! ball.4.9 rsi)
            (begin
              (set! bar.7.11 -932453002)
              (begin
                (if (>= -1133252869 9223372036854775807)
                    (set! foobar.9.12 479665611)
                    (set! foobar.9.12 bar.8.10))
                (begin
                  (set! bat.5.13 bar.7.11)
                  (begin
                    (set! rax bar.7.11)
                    (jump tmp-ra.15 rbp rax))))))))
      (begin
        (set! tmp-ra.16 r15)
        (if (>= 1588211020 1)
            (begin
              (set! rax 9223372036854775807)
              (jump tmp-ra.16 rbp rax))
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.16 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! bat.9.1 rdi)
                                     (begin
                                       (set! bar.1.2 (+ 1 bat.9.1))
                                       (begin
                                         (set! rdx 9223372036854775807)
                                         (set! rsi bar.1.2)
                                         (set! rdi 515658026)
                                         (set! r15 tmp-ra.7)
                                         (jump L.func.1.2 rbp r15 rdi rsi rdx))))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.8 r15)
                             (begin
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
                                     (jump L.func.1.2 rbp r15 rdi rsi rdx))))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! bat.2.6 (* 0 -9223372036854775808))
                             (begin
                               (set! rdi -39871347)
                               (set! r15 tmp-ra.9)
                               (jump L.proc.0.1 rbp r15 rdi))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (>= 1 -9223372036854775808)
                                     (begin
                                       (set! rax 234292566)
                                       (jump tmp-ra.1 rbp rax))
                                     (begin
                                       (set! rax -1579825632)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! foo.2.6 rdi)
                                     (set! ball.5.5 rsi)
                                     (set! foobar.9.4 rdx)
                                     (set! ball.4.3 rcx)
                                     (set! bat.3.2 r8)
                                     (set! bar.7.1 r9)
                                     (if (not (not (= 9223372036854775807 foo.2.6)))
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
                                           (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))))
                         (begin
                           (set! tmp-ra.8 r15)
                           (begin
                             (set! r9 1)
                             (set! r8 -1659310511)
                             (set! rcx 671608402)
                             (set! rdx 1)
                             (set! rsi 0)
                             (set! rdi 158605610)
                             (set! r15 tmp-ra.8)
                             (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (begin
                                   (set! rax 1)
                                   (jump tmp-ra.1 rbp rax)))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.18 r15)
                                   (begin
                                     (set! ball.9.2 rdi)
                                     (set! bat.0.1 rsi)
                                     (begin
                                       (set! foobar.4.3 ball.9.2)
                                       (begin
                                         (set! rax (* 0 0))
                                         (jump tmp-ra.18 rbp rax))))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (if (>= -9223372036854775808 9223372036854775807)
                                   (begin
                                     (set! rax -1098447432)
                                     (jump tmp-ra.19 rbp rax))
                                   (begin
                                     (set! ball.9.4 (+ -9223372036854775808 -9223372036854775808))
                                     (if (< 857729561 9223372036854775807)
                                         (begin
                                           (set! rax 9223372036854775807)
                                           (jump tmp-ra.19 rbp rax))
                                         (begin
                                           (set! rax 1)
                                           (jump tmp-ra.19 rbp rax))))))))
                         (define L.fn.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.20 r15)
                             (begin
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
                                     (begin
                                       (set! rsi bar.2.12)
                                       (set! rdi bat.0.10)
                                       (set! r15 tmp-ra.20)
                                       (jump L.fn.0.1 rbp r15 rdi rsi)))
                                   (if (true)
                                       (begin
                                         (set! rax (* bat.3.6 foobar.4.8))
                                         (jump tmp-ra.20 rbp rax))
                                       (begin
                                         (set! bat.6.13 bat.5.11)
                                         (begin
                                           (set! rax 674342291)
                                           (jump tmp-ra.20 rbp rax))))))))
                         (begin
                           (set! tmp-ra.21 r15)
                           (if (begin
                                 (begin
                                   (begin
                                     (set! bar.2.16 1)
                                     (set! bar.2.15 -9223372036854775808))
                                   (begin
                                     (set! foobar.8.17 bar.2.15)
                                     (set! bat.0.14 9223372036854775807)))
                                 (if (true)
                                     (if (= bat.0.14 bat.0.14)
                                         (>= -1195644570 bat.0.14)
                                         (= bat.0.14 bat.0.14))
                                     (if (> bat.0.14 bat.0.14)
                                         (>= bat.0.14 bat.0.14)
                                         (= 0 bat.0.14))))
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
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.5 r15)
                                 (begin
                                   (if (> -9223372036854775808 9223372036854775807)
                                       (begin
                                         (if (!= 1 9223372036854775807)
                                             (set! bar.5.2 9223372036854775807)
                                             (set! bar.5.2 463110926))
                                         (set! bat.4.1 0))
                                       (begin
                                         (set! bar.3.3 0)
                                         (set! bat.4.1 (- -1584028825 -9223372036854775808))))
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
                                           (if (= 1050399943 bat.4.1)
                                               (begin
                                                 (set! rax -1604958676)
                                                 (jump tmp-ra.5 rbp rax))
                                               (begin
                                                 (set! rax bat.4.1)
                                                 (jump tmp-ra.5 rbp rax))))
                                       (begin
                                         (set! rax bat.4.1)
                                         (jump tmp-ra.5 rbp rax)))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! foobar.9.7 rdi)
                                     (set! foo.4.6 rsi)
                                     (set! foobar.7.5 rdx)
                                     (set! bat.1.4 rcx)
                                     (set! bar.5.3 r8)
                                     (set! ball.3.2 r9)
                                     (set! bat.8.1 fv0)
                                     (begin
                                       (set! fv0 ball.3.2)
                                       (set! r9 -1130190811)
                                       (set! r8 -9223372036854775808)
                                       (set! rcx 1751496267)
                                       (set! rdx bat.8.1)
                                       (set! rsi 0)
                                       (set! rdi -9223372036854775808)
                                       (set! r15 tmp-ra.8)
                                       (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! fv0 1)
                             (set! r9 9223372036854775807)
                             (set! r8 -9223372036854775808)
                             (set! rcx -522285902)
                             (set! rdx 754255570)
                             (set! rsi -1704260755)
                             (set! rdi 0)
                             (set! r15 tmp-ra.9)
                             (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.18 r15)
                                   (begin
                                     (set! foo.8.4 rdi)
                                     (set! bat.5.3 rsi)
                                     (set! foo.6.2 rdx)
                                     (set! bar.0.1 rcx)
                                     (begin
                                       (set! r8 foo.6.2)
                                       (set! rcx 9223372036854775807)
                                       (set! rdx bat.5.3)
                                       (set! rsi bar.0.1)
                                       (set! rdi 9223372036854775807)
                                       (set! r15 tmp-ra.18)
                                       (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8)))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (set! bat.3.9 rdi)
                               (set! foo.8.8 rsi)
                               (set! bar.0.7 rdx)
                               (set! foo.9.6 rcx)
                               (set! bat.4.5 r8)
                               (begin
                                 (set! fv0 -9223372036854775808)
                                 (set! r9 bat.4.5)
                                 (set! r8 foo.9.6)
                                 (set! rcx bar.0.7)
                                 (set! rdx foo.8.8)
                                 (set! rsi bar.0.7)
                                 (set! rdi 9223372036854775807)
                                 (set! r15 tmp-ra.19)
                                 (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
                         (define L.tmp.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.20 r15)
                             (begin
                               (set! foo.7.16 rdi)
                               (set! bat.3.15 rsi)
                               (set! bat.5.14 rdx)
                               (set! bat.4.13 rcx)
                               (set! foo.8.12 r8)
                               (set! foo.2.11 r9)
                               (set! foo.6.10 fv0)
                               (begin
                                 (set! rax bat.5.14)
                                 (jump tmp-ra.20 rbp rax)))))
                         (begin
                           (set! tmp-ra.21 r15)
                           (if (false)
                               (begin
                                 (set! foo.9.17 1281469771)
                                 (begin
                                   (set! rax 0)
                                   (jump tmp-ra.21 rbp rax)))
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
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.16 r15)
                                   (begin
                                     (set! bar.8.7 rdi)
                                     (set! bar.4.6 rsi)
                                     (set! foo.7.5 rdx)
                                     (set! foo.6.4 rcx)
                                     (set! bat.3.3 r8)
                                     (set! foobar.2.2 r9)
                                     (set! ball.5.1 fv0)
                                     (begin
                                       (set! rdx foo.6.4)
                                       (set! rsi 946654223)
                                       (set! rdi 9223372036854775807)
                                       (set! r15 tmp-ra.16)
                                       (jump L.func.1.2 rbp r15 rdi rsi rdx)))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.17 r15)
                             (begin
                               (set! ball.1.10 rdi)
                               (set! ball.5.9 rsi)
                               (set! bar.8.8 rdx)
                               (begin
                                 (set! rdx 9223372036854775807)
                                 (set! rsi bar.8.8)
                                 (set! rdi ball.5.9)
                                 (set! r15 tmp-ra.17)
                                 (jump L.func.1.2 rbp r15 rdi rsi rdx)))))
                         (define L.fn.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.18 r15)
                             (begin
                               (set! bar.8.13 rdi)
                               (set! ball.0.12 rsi)
                               (set! ball.5.11 rdx)
                               (begin
                                 (set! ball.5.14 9223372036854775807)
                                 (begin
                                   (set! rdx bar.8.13)
                                   (set! rsi 0)
                                   (set! rdi ball.0.12)
                                   (set! r15 tmp-ra.18)
                                   (jump L.func.1.2 rbp r15 rdi rsi rdx))))))
                         (begin
                           (set! tmp-ra.19 r15)
                           (begin
                             (set! ball.1.15 0)
                             (begin
                               (set! rax 1)
                               (jump tmp-ra.19 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! foo.9.5 rdi)
                                     (set! foo.0.4 rsi)
                                     (set! foobar.7.3 rdx)
                                     (set! bat.2.2 rcx)
                                     (set! foo.1.1 r8)
                                     (if (false)
                                         (begin
                                           (if (!= -9223372036854775808 0)
                                               (set! ball.3.6 1)
                                               (set! ball.3.6 foo.9.5))
                                           (begin
                                             (set! foo.9.7 9223372036854775807)
                                             (begin
                                               (set! rax 9223372036854775807)
                                               (jump tmp-ra.8 rbp rax))))
                                         (begin
                                           (set! rax 1)
                                           (jump tmp-ra.8 rbp rax))))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! r8 1653803490)
                             (set! rcx 1918330809)
                             (set! rdx 1)
                             (set! rsi 9223372036854775807)
                             (set! rdi -9223372036854775808)
                             (set! r15 tmp-ra.9)
                             (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
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
                                           (jump L.tmp.2.3 rbp r15))))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.8 r15)
                             (begin
                               (set! foobar.1.6 rdi)
                               (set! foo.0.5 rsi)
                               (set! foo.5.4 rdx)
                               (begin
                                 (set! r15 tmp-ra.8)
                                 (jump L.tmp.2.3 rbp r15)))))
                         (define L.tmp.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.9 r15)
                             (begin
                               (begin
                                 (set! r15 tmp-ra.9)
                                 (jump L.tmp.2.3 rbp r15)))))
                         (begin
                           (set! tmp-ra.10 r15)
                           (begin
                             (set! rax 1)
                             (jump tmp-ra.10 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! bar.3.4 rdi)
                                     (set! ball.0.3 rsi)
                                     (set! bat.2.2 rdx)
                                     (set! bat.9.1 rcx)
                                     (begin
                                       (if (= ball.0.3 bat.9.1)
                                           (set! bat.2.5 ball.0.3)
                                           (set! bat.2.5 -1012326174))
                                       (begin
                                         (begin
                                           (set! bar.3.7 0)
                                           (set! foobar.7.6 bar.3.7))
                                         (begin
                                           (set! rax (- bar.3.4 0))
                                           (jump tmp-ra.8 rbp rax)))))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! rcx 1259250868)
                             (set! rdx 1097392993)
                             (set! rsi 0)
                             (set! rdi 1)
                             (set! r15 tmp-ra.9)
                             (jump L.x.0.1 rbp r15 rdi rsi rdx rcx)))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.func.0.1
              ((new-frames ()))
              (begin
                (set! tmp-ra.12 r15)
                (begin
                  (set! foo.4.7 rdi)
                  (set! ball.1.6 rsi)
                  (set! bat.0.5 rdx)
                  (set! foobar.6.4 rcx)
                  (set! foobar.7.3 r8)
                  (set! bat.9.2 r9)
                  (set! ball.3.1 fv0)
                  (begin
                    (set! rsi 0)
                    (set! rdi foobar.6.4)
                    (set! r15 tmp-ra.12)
                    (jump L.x.1.2 rbp r15 rdi rsi)))))
      (define L.x.1.2
        ((new-frames ((nfv.14))))
        (begin
          (set! tmp-ra.13 r15)
          (begin
            (set! foobar.7.9 rdi)
            (set! bat.9.8 rsi)
            (begin
              (begin
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
                (set! ball.8.10 rax))
              (begin
                (set! ball.3.11 (+ foobar.7.9 -841927304))
                (if (= -9223372036854775808 bat.9.8)
                    (begin
                      (set! rax ball.8.10)
                      (jump tmp-ra.13 rbp rax))
                    (begin
                      (set! rax -19487548)
                      (jump tmp-ra.13 rbp rax))))))))
      (begin
        (set! tmp-ra.15 r15)
        (begin
          (set! rsi 169577204)
          (set! rdi 1130382988)
          (set! r15 tmp-ra.15)
          (jump L.x.1.2 rbp r15 rdi rsi)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.15 r15)
                                   (begin
                                     (set! bat.0.6 rdi)
                                     (set! bar.8.5 rsi)
                                     (set! foobar.2.4 rdx)
                                     (set! ball.5.3 rcx)
                                     (set! bat.4.2 r8)
                                     (set! ball.7.1 r9)
                                     (if (false)
                                         (begin
                                           (set! bar.1.7 (+ 1763789232 0))
                                           (begin
                                             (set! foobar.2.8 9223372036854775807)
                                             (begin
                                               (set! rax ball.5.3)
                                               (jump tmp-ra.15 rbp rax))))
                                         (begin
                                           (set! r9 bar.8.5)
                                           (set! r8 -9223372036854775808)
                                           (set! rcx bar.8.5)
                                           (set! rdx bat.4.2)
                                           (set! rsi bat.4.2)
                                           (set! rdi 9223372036854775807)
                                           (set! r15 tmp-ra.15)
                                           (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.16 r15)
                             (begin
                               (set! foobar.2.12 rdi)
                               (set! bar.1.11 rsi)
                               (set! bat.4.10 rdx)
                               (set! ball.5.9 rcx)
                               (begin
                                 (set! rcx 1283566420)
                                 (set! rdx ball.5.9)
                                 (set! rsi bat.4.10)
                                 (set! rdi bar.1.11)
                                 (set! r15 tmp-ra.16)
                                 (jump L.func.1.2 rbp r15 rdi rsi rdx rcx)))))
                         (begin
                           (set! tmp-ra.17 r15)
                           (if (begin
                                 (set! foo.6.13 (- -9223372036854775808 9223372036854775807))
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
                                         (begin
                                           (set! rax 1)
                                           (jump tmp-ra.17 rbp rax))))
                                   (if (not (<= -2094891483 -9223372036854775808))
                                       (if (>= -9223372036854775808 -753552692)
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
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.10 r15)
                                   (begin
                                     (set! bar.9.3 rdi)
                                     (set! ball.5.2 rsi)
                                     (set! bar.4.1 rdx)
                                     (begin
                                       (set! r8 bar.4.1)
                                       (set! rcx 1)
                                       (set! rdx ball.5.2)
                                       (set! rsi -1620042780)
                                       (set! rdi 0)
                                       (set! r15 tmp-ra.10)
                                       (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8)))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.11 r15)
                             (begin
                               (set! ball.8.8 rdi)
                               (set! bar.2.7 rsi)
                               (set! bar.9.6 rdx)
                               (set! bat.0.5 rcx)
                               (set! foo.1.4 r8)
                               (begin
                                 (set! foo.6.9 9223372036854775807)
                                 (begin
                                   (set! rax (+ -9223372036854775808 bat.0.5))
                                   (jump tmp-ra.11 rbp rax))))))
                         (begin
                           (set! tmp-ra.12 r15)
                           (begin
                             (set! r8 0)
                             (set! rcx 1)
                             (set! rdx 9223372036854775807)
                             (set! rsi -913438169)
                             (set! rdi -1611188905)
                             (set! r15 tmp-ra.12)
                             (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! bar.1.3 rdi)
                                     (set! foo.3.2 rsi)
                                     (set! foo.4.1 rdx)
                                     (begin
                                       (set! rcx -1370687846)
                                       (set! rdx -9223372036854775808)
                                       (set! rsi foo.4.1)
                                       (set! rdi 346043157)
                                       (set! r15 tmp-ra.8)
                                       (jump L.x.1.2 rbp r15 rdi rsi rdx rcx)))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.9 r15)
                             (begin
                               (set! bar.1.7 rdi)
                               (set! foo.3.6 rsi)
                               (set! bar.0.5 rdx)
                               (set! foo.8.4 rcx)
                               (begin
                                 (set! rcx 1658781620)
                                 (set! rdx 0)
                                 (set! rsi foo.3.6)
                                 (set! rdi -1950262775)
                                 (set! r15 tmp-ra.9)
                                 (jump L.x.1.2 rbp r15 rdi rsi rdx rcx)))))
                         (begin
                           (set! tmp-ra.10 r15)
                           (begin
                             (set! rcx 9223372036854775807)
                             (set! rdx -1844821605)
                             (set! rsi 1)
                             (set! rdi -139919863)
                             (set! r15 tmp-ra.10)
                             (jump L.x.1.2 rbp r15 rdi rsi rdx rcx)))))
  (check-by-interp-v6 '(module ((new-frames (())))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! bar.4.4 rdi)
                                     (set! foobar.9.3 rsi)
                                     (set! ball.5.2 rdx)
                                     (set! bar.8.1 rcx)
                                     (begin
                                       (set! rcx ball.5.2)
                                       (set! rdx ball.5.2)
                                       (set! rsi ball.5.2)
                                       (set! rdi foobar.9.3)
                                       (set! r15 tmp-ra.8)
                                       (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx)))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (if (false)
                               (begin
                                 (if (if (> 9223372036854775807 1428972274)
                                         (!= 0 479631559)
                                         (>= 0 1284385619))
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
                                 (if (if (<= 0 bar.7.5)
                                         (!= bar.7.5 2009350954)
                                         (!= 1170635915 bar.7.5))
                                     (begin
                                       (set! foobar.1.6 bar.7.5)
                                       (begin
                                         (set! rax 0)
                                         (jump tmp-ra.9 rbp rax)))
                                     (begin
                                       (set! foobar.1.7 -378459323)
                                       (begin
                                         (set! rax bar.7.5)
                                         (jump tmp-ra.9 rbp rax)))))
                               (if (false)
                                   (begin
                                     (set! rax 0)
                                     (jump tmp-ra.9 rbp rax))
                                   (begin
                                     (set! rax (- 1326448876 360169641))
                                     (jump tmp-ra.9 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (begin
                                   (begin
                                     (set! foo.5.2 1)
                                     (begin
                                       (set! foo.5.3 foo.5.2)
                                       (set! foo.7.1 foo.5.3)))
                                   (begin
                                     (set! rax foo.7.1)
                                     (jump tmp-ra.4 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames (() ())))
                               (define L.func.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.13 r15)
                                   (begin
                                     (set! foobar.3.3 rdi)
                                     (set! bat.7.2 rsi)
                                     (set! bar.2.1 rdx)
                                     (begin
                                       (set! ball.4.4 (* -529343887 -1285114971))
                                       (begin
                                         (begin
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! rdx bar.2.1)
                                                           (set! rsi ball.4.4)
                                                           (set! rdi ball.4.4)
                                                           (set! r15 L.rp.3)
                                                           (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                                           (set! bat.8.5 rax))
                                         (if (= 1981945067 bar.2.1)
                                             (begin
                                               (set! rax -195961595)
                                               (jump tmp-ra.13 rbp rax))
                                             (begin
                                               (set! rax 9223372036854775807)
                                               (jump tmp-ra.13 rbp rax))))))))
                         (define L.fn.1.2
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.14 r15)
                             (begin
                               (set! bat.8.6 rdi)
                               (begin
                                 (begin
                                   (set! foobar.1.8 (+ -73068505 -9223372036854775808))
                                   (if (<= bat.8.6 -9223372036854775808)
                                       (set! bar.9.7 bat.8.6)
                                       (set! bar.9.7 -241738702)))
                                 (begin
                                   (begin
                                     (return-point L.rp.4
                                                   (begin
                                                     (set! rdx 0)
                                                     (set! rsi 9223372036854775807)
                                                     (set! rdi bat.8.6)
                                                     (set! r15 L.rp.4)
                                                     (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                                     (set! foobar.1.9 rax))
                                   (begin
                                     (set! rax (+ 1 foobar.1.9))
                                     (jump tmp-ra.14 rbp rax)))))))
                         (begin
                           (set! tmp-ra.15 r15)
                           (begin
                             (begin
                               (return-point L.rp.5
                                             (begin
                                               (set! rdx 9223372036854775807)
                                               (set! rsi 9223372036854775807)
                                               (set! rdi 0)
                                               (set! r15 L.rp.5)
                                               (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                               (set! foobar.3.10 rax))
                             (if (not (if (= -9223372036854775808 649827574)
                                          (< -9223372036854775808 foobar.3.10)
                                          (= foobar.3.10 -9223372036854775808)))
                                 (if (< -9223372036854775808 -9223372036854775808)
                                     (begin
                                       (set! rax (- 9223372036854775807 foobar.3.10))
                                       (jump tmp-ra.15 rbp rax))
                                     (begin
                                       (set! bat.8.11 foobar.3.10)
                                       (begin
                                         (set! rax bat.8.11)
                                         (jump tmp-ra.15 rbp rax))))
                                 (begin
                                   (begin
                                     (return-point L.rp.6
                                                   (begin
                                                     (set! rdx 1)
                                                     (set! rsi 9223372036854775807)
                                                     (set! rdi 2001362815)
                                                     (set! r15 L.rp.6)
                                                     (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                                     (set! bat.8.12 rax))
                                   (begin
                                     (set! rax (* bat.8.12 foobar.3.10))
                                     (jump tmp-ra.15 rbp rax))))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.17 r15)
                                   (begin
                                     (begin
                                       (set! r8 1013001136)
                                       (set! rcx 0)
                                       (set! rdx 1)
                                       (set! rsi -9223372036854775808)
                                       (set! rdi -9223372036854775808)
                                       (set! r15 tmp-ra.17)
                                       (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8)))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.18 r15)
                             (begin
                               (set! foo.7.7 rdi)
                               (set! bar.9.6 rsi)
                               (set! bar.0.5 rdx)
                               (set! ball.4.4 rcx)
                               (set! foo.3.3 r8)
                               (set! foobar.5.2 r9)
                               (set! foobar.2.1 fv0)
                               (begin
                                 (if (begin
                                       (set! ball.4.9 foo.7.7)
                                       (< bar.9.6 0))
                                     (begin
                                       (set! foo.3.10 ball.4.4)
                                       (set! foo.3.8 -224488027))
                                     (if (= foobar.2.1 bar.0.5)
                                         (set! foo.3.8 foobar.2.1)
                                         (set! foo.3.8 foobar.2.1)))
                                 (begin
                                   (set! r8 1)
                                   (set! rcx foobar.5.2)
                                   (set! rdx -1015791473)
                                   (set! rsi bar.0.5)
                                   (set! rdi -9223372036854775808)
                                   (set! r15 tmp-ra.18)
                                   (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8))))))
                         (define L.fn.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (set! foo.3.15 rdi)
                               (set! ball.4.14 rsi)
                               (set! bar.6.13 rdx)
                               (set! bar.9.12 rcx)
                               (set! foobar.5.11 r8)
                               (begin
                                 (set! foobar.5.16 bar.9.12)
                                 (begin
                                   (set! r8 1)
                                   (set! rcx 1459656882)
                                   (set! rdx 0)
                                   (set! rsi -9223372036854775808)
                                   (set! rdi 0)
                                   (set! r15 tmp-ra.19)
                                   (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8))))))
                         (begin
                           (set! tmp-ra.20 r15)
                           (begin
                             (set! r8 1)
                             (set! rcx 1648096326)
                             (set! rdx 9223372036854775807)
                             (set! rsi 1)
                             (set! rdi 9223372036854775807)
                             (set! r15 tmp-ra.20)
                             (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.9 r15)
                                   (begin
                                     (set! bat.7.3 rdi)
                                     (set! foo.1.2 rsi)
                                     (set! foobar.8.1 rdx)
                                     (begin
                                       (set! rax (* 1903463490 -9223372036854775808))
                                       (jump tmp-ra.9 rbp rax)))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.10 r15)
                             (begin
                               (set! foobar.9.7 rdi)
                               (set! bat.7.6 rsi)
                               (set! bar.3.5 rdx)
                               (set! bat.0.4 rcx)
                               (begin
                                 (set! foobar.4.8 (- -9223372036854775808 foobar.9.7))
                                 (if (> 9223372036854775807 bar.3.5)
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
                                           (jump tmp-ra.10 rbp rax))))))))
                         (begin
                           (set! tmp-ra.11 r15)
                           (begin
                             (set! rax (* 977777990 900224161))
                             (jump tmp-ra.11 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.5 r15)
                                   (begin
                                     (set! foobar.8.3 rdi)
                                     (set! foobar.1.2 rsi)
                                     (set! foo.9.1 rdx)
                                     (begin
                                       (begin
                                         (return-point L.rp.2
                                                       (begin
                                                         (set! rdx 9223372036854775807)
                                                         (set! rsi -1363029646)
                                                         (set! rdi 9223372036854775807)
                                                         (set! r15 L.rp.2)
                                                         (jump L.func.0.1 rbp r15 rdi rsi rdx)))
                                         (set! bar.6.4 rax))
                                       (if (= 9223372036854775807 0)
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
                                                 (jump tmp-ra.5 rbp rax))))))))
                         (begin
                           (set! tmp-ra.6 r15)
                           (begin
                             (set! rdx 0)
                             (set! rsi 9223372036854775807)
                             (set! rdi -9223372036854775808)
                             (set! r15 tmp-ra.6)
                             (jump L.func.0.1 rbp r15 rdi rsi rdx)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (if (<= 0 1773437967)
                                         (begin
                                           (begin
                                             (return-point L.rp.4
                                                           (begin
                                                             (set! rdi 1456910402)
                                                             (set! r15 L.rp.4)
                                                             (jump L.tmp.2.3 rbp r15 rdi)))
                                             (set! foobar.2.1 rax))
                                           (begin
                                             (set! bar.5.2 -9223372036854775808)
                                             (begin
                                               (set! rax 1)
                                               (jump tmp-ra.8 rbp rax))))
                                         (begin
                                           (set! rdi -9223372036854775808)
                                           (set! r15 tmp-ra.8)
                                           (jump L.tmp.2.3 rbp r15 rdi))))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.9 r15)
                             (begin
                               (set! bat.6.6 rdi)
                               (set! foobar.3.5 rsi)
                               (set! foo.9.4 rdx)
                               (set! bat.1.3 rcx)
                               (begin
                                 (set! rdi foo.9.4)
                                 (set! r15 tmp-ra.9)
                                 (jump L.tmp.2.3 rbp r15 rdi)))))
                         (define L.tmp.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.10 r15)
                             (begin
                               (set! bat.1.7 rdi)
                               (begin
                                 (set! rax bat.1.7)
                                 (jump tmp-ra.10 rbp rax)))))
                         (begin
                           (set! tmp-ra.11 r15)
                           (begin
                             (set! rdi 0)
                             (set! r15 tmp-ra.11)
                             (jump L.tmp.2.3 rbp r15 rdi)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.16 r15)
                                   (begin
                                     (set! foobar.4.2 rdi)
                                     (set! foo.5.1 rsi)
                                     (begin
                                       (begin
                                         (set! foo.5.4 foobar.4.2)
                                         (set! bat.1.3 (+ foobar.4.2 foo.5.4)))
                                       (begin
                                         (set! rsi foo.5.1)
                                         (set! rdi 0)
                                         (set! r15 tmp-ra.16)
                                         (jump L.fn.0.1 rbp r15 rdi rsi))))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.17 r15)
                             (begin
                               (set! bat.0.9 rdi)
                               (set! foo.2.8 rsi)
                               (set! foobar.4.7 rdx)
                               (set! bat.1.6 rcx)
                               (set! bat.9.5 r8)
                               (if (if (true)
                                       (< bat.9.5 bat.0.9)
                                       (begin
                                         (set! bar.7.10 bat.0.9)
                                         (<= 0 -508327908)))
                                   (begin
                                     (if (<= 167876306 bat.0.9)
                                         (set! bat.9.11 44784438)
                                         (set! bat.9.11 -874603706))
                                     (begin
                                       (set! r8 foobar.4.7)
                                       (set! rcx foobar.4.7)
                                       (set! rdx 0)
                                       (set! rsi 696038140)
                                       (set! rdi -9223372036854775808)
                                       (set! r15 tmp-ra.17)
                                       (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8)))
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
                                         (jump L.fn.0.1 rbp r15 rdi rsi)))))))
                         (begin
                           (set! tmp-ra.18 r15)
                           (begin
                             (begin
                               (if (<= 9223372036854775807 0)
                                   (set! bat.0.14 0)
                                   (set! bat.0.14 93609173))
                               (begin
                                 (set! foo.6.15 bat.0.14)
                                 (set! foo.5.13 foo.6.15)))
                             (begin
                               (set! rax foo.5.13)
                               (jump tmp-ra.18 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.6 r15)
                                 (begin
                                   (begin
                                     (set! bat.1.2 -9223372036854775808)
                                     (begin
                                       (set! foobar.4.3 0)
                                       (set! bar.7.1 foobar.4.3)))
                                   (if (begin
                                         (set! foo.0.4 bar.7.1)
                                         (<= 1 -9223372036854775808))
                                       (begin
                                         (set! rax bar.7.1)
                                         (jump tmp-ra.6 rbp rax))
                                       (begin
                                         (set! foobar.4.5 bar.7.1)
                                         (begin
                                           (set! rax 1974766267)
                                           (jump tmp-ra.6 rbp rax))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames (() ())))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.6 r15)
                                   (begin
                                     (set! foobar.5.3 rdi)
                                     (set! foo.8.2 rsi)
                                     (set! foobar.6.1 rdx)
                                     (begin
                                       (set! rdx foobar.5.3)
                                       (set! rsi foobar.5.3)
                                       (set! rdi 0)
                                       (set! r15 tmp-ra.6)
                                       (jump L.x.0.1 rbp r15 rdi rsi rdx)))))
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
                                 (< 9223372036854775807 ball.3.4))
                               (begin
                                 (set! rdx 1)
                                 (set! rsi -9223372036854775808)
                                 (set! rdi 1)
                                 (set! r15 tmp-ra.7)
                                 (jump L.x.0.1 rbp r15 rdi rsi rdx))
                               (begin
                                 (begin
                                   (return-point L.rp.3
                                                 (begin
                                                   (set! rdx -1530356459)
                                                   (set! rsi 9223372036854775807)
                                                   (set! rdi 9223372036854775807)
                                                   (set! r15 L.rp.3)
                                                   (jump L.x.0.1 rbp r15 rdi rsi rdx)))
                                   (set! foobar.6.5 rax))
                                 (if (= foobar.6.5 foobar.6.5)
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.7 rbp rax))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.7 rbp rax))))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (begin
                                     (set! bar.0.6 rdi)
                                     (set! foobar.2.5 rsi)
                                     (set! foo.1.4 rdx)
                                     (set! foobar.9.3 rcx)
                                     (set! bat.5.2 r8)
                                     (set! foobar.8.1 r9)
                                     (begin
                                       (set! bat.6.7 -951184591)
                                       (if (false)
                                           (begin
                                             (set! foo.1.8 -9223372036854775808)
                                             (begin
                                               (set! rax foo.1.8)
                                               (jump tmp-ra.11 rbp rax)))
                                           (begin
                                             (set! foo.1.9 310790521)
                                             (begin
                                               (set! rax foobar.8.1)
                                               (jump tmp-ra.11 rbp rax))))))))
                         (begin
                           (set! tmp-ra.12 r15)
                           (begin
                             (set! foo.1.10 -1379426851)
                             (begin
                               (set! rax 488563830)
                               (jump tmp-ra.12 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! ball.2.3 rdi)
                                     (set! foo.5.2 rsi)
                                     (set! ball.0.1 rdx)
                                     (if (if (= 0 ball.2.3)
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
                                               (begin
                                                 (set! rax foo.5.4)
                                                 (jump tmp-ra.7 rbp rax)))
                                             (begin
                                               (set! rdx 1)
                                               (set! rsi foo.5.2)
                                               (set! rdi foo.5.2)
                                               (set! r15 tmp-ra.7)
                                               (jump L.func.0.1 rbp r15 rdi rsi rdx)))))))
                         (begin
                           (set! tmp-ra.8 r15)
                           (begin
                             (set! foo.5.5 -1766715399)
                             (if (not (not (< foo.5.5 foo.5.5)))
                                 (begin
                                   (if (< foo.5.5 0)
                                       (set! foobar.4.6 9223372036854775807)
                                       (set! foobar.4.6 foo.5.5))
                                   (begin
                                     (set! rax -1170116362)
                                     (jump tmp-ra.8 rbp rax)))
                                 (begin
                                   (set! rax (* 0 0))
                                   (jump tmp-ra.8 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames (())))
                               (define L.tmp.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! foo.8.3 rdi)
                                     (set! ball.3.2 rsi)
                                     (set! foo.2.1 rdx)
                                     (begin
                                       (begin
                                         (set! foo.6.5 1591590730)
                                         (begin
                                           (return-point L.rp.2
                                                         (begin
                                                           (set! rdx foo.2.1)
                                                           (set! rsi foo.2.1)
                                                           (set! rdi 1001483234)
                                                           (set! r15 L.rp.2)
                                                           (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
                                           (set! ball.4.4 rax)))
                                       (begin
                                         (set! rdx ball.3.2)
                                         (set! rsi foo.2.1)
                                         (set! rdi -9223372036854775808)
                                         (set! r15 tmp-ra.7)
                                         (jump L.tmp.0.1 rbp r15 rdi rsi rdx))))))
                         (begin
                           (set! tmp-ra.8 r15)
                           (begin
                             (if (if (!= 1 0)
                                     (<= -9223372036854775808 9223372036854775807)
                                     (= 0 0))
                                 (begin
                                   (return-point L.rp.3
                                                 (begin
                                                   (set! rdx 1)
                                                   (set! rsi 1188321444)
                                                   (set! rdi -1860695803)
                                                   (set! r15 L.rp.3)
                                                   (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))
                                   (set! foo.2.6 rax))
                                 (set! foo.2.6 (+ -9223372036854775808 -335192473)))
                             (if (if (!= foo.2.6 foo.2.6)
                                     (< foo.2.6 foo.2.6)
                                     (= -1823864705 -2078605817))
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
                                   (jump L.tmp.0.1 rbp r15 rdi rsi rdx)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.9 r15)
                                   (begin
                                     (set! bar.0.3 rdi)
                                     (set! bar.4.2 rsi)
                                     (set! bar.9.1 rdx)
                                     (begin
                                       (set! rdi 9223372036854775807)
                                       (set! r15 tmp-ra.9)
                                       (jump L.fn.1.2 rbp r15 rdi)))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.10 r15)
                             (begin
                               (set! bar.9.4 rdi)
                               (if (> 1 1)
                                   (begin
                                     (set! rdx -9223372036854775808)
                                     (set! rsi -9223372036854775808)
                                     (set! rdi bar.9.4)
                                     (set! r15 tmp-ra.10)
                                     (jump L.x.2.3 rbp r15 rdi rsi rdx))
                                   (if (if (> bar.9.4 9223372036854775807)
                                           (<= bar.9.4 2069349298)
                                           (= 327435684 bar.9.4))
                                       (begin
                                         (set! rdx bar.9.4)
                                         (set! rsi bar.9.4)
                                         (set! rdi 937688474)
                                         (set! r15 tmp-ra.10)
                                         (jump L.x.2.3 rbp r15 rdi rsi rdx))
                                       (begin
                                         (set! rax -9223372036854775808)
                                         (jump tmp-ra.10 rbp rax)))))))
                         (define L.x.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.11 r15)
                             (begin
                               (set! foobar.6.7 rdi)
                               (set! ball.8.6 rsi)
                               (set! bar.4.5 rdx)
                               (begin
                                 (set! rdx bar.4.5)
                                 (set! rsi -845528888)
                                 (set! rdi foobar.6.7)
                                 (set! r15 tmp-ra.11)
                                 (jump L.x.2.3 rbp r15 rdi rsi rdx)))))
                         (begin
                           (set! tmp-ra.12 r15)
                           (begin
                             (set! bat.1.8 0)
                             (begin
                               (set! rax bat.1.8)
                               (jump tmp-ra.12 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.18 r15)
                                   (begin
                                     (set! foobar.4.5 rdi)
                                     (set! bar.5.4 rsi)
                                     (set! foobar.6.3 rdx)
                                     (set! ball.7.2 rcx)
                                     (set! bat.1.1 r8)
                                     (if (false)
                                         (if (begin
                                               (set! bar.9.6 foobar.6.3)
                                               (< 0 foobar.6.3))
                                             (begin
                                               (set! rsi -9223372036854775808)
                                               (set! rdi 0)
                                               (set! r15 tmp-ra.18)
                                               (jump L.x.1.2 rbp r15 rdi rsi))
                                             (begin
                                               (set! foobar.2.7 bat.1.1)
                                               (begin
                                                 (set! rax foobar.4.5)
                                                 (jump tmp-ra.18 rbp rax))))
                                         (if (true)
                                             (if (!= -9223372036854775808 1)
                                                 (begin
                                                   (set! rax 0)
                                                   (jump tmp-ra.18 rbp rax))
                                                 (begin
                                                   (set! rax 849007740)
                                                   (jump tmp-ra.18 rbp rax)))
                                             (begin
                                               (set! rax foobar.4.5)
                                               (jump tmp-ra.18 rbp rax)))))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (set! foobar.6.9 rdi)
                               (set! bar.0.8 rsi)
                               (begin
                                 (set! foobar.4.10 bar.0.8)
                                 (begin
                                   (set! r8 9223372036854775807)
                                   (set! rcx 0)
                                   (set! rdx foobar.4.10)
                                   (set! rsi 0)
                                   (set! rdi foobar.6.9)
                                   (set! r15 tmp-ra.19)
                                   (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8))))))
                         (define L.x.2.3
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.20 r15)
                             (begin
                               (set! foobar.2.15 rdi)
                               (set! foobar.4.14 rsi)
                               (set! bar.8.13 rdx)
                               (set! ball.3.12 rcx)
                               (set! bar.5.11 r8)
                               (begin
                                 (begin
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! rsi bar.5.11)
                                                   (set! rdi bar.5.11)
                                                   (set! r15 L.rp.4)
                                                   (jump L.x.1.2 rbp r15 rdi rsi)))
                                   (set! bar.8.16 rax))
                                 (begin
                                   (set! rsi 1)
                                   (set! rdi -1927041153)
                                   (set! r15 tmp-ra.20)
                                   (jump L.x.1.2 rbp r15 rdi rsi))))))
                         (begin
                           (set! tmp-ra.21 r15)
                           (begin
                             (set! ball.3.17 (* 1 -394936001))
                             (begin
                               (set! r8 ball.3.17)
                               (set! rcx -9223372036854775808)
                               (set! rdx 0)
                               (set! rsi ball.3.17)
                               (set! rdi ball.3.17)
                               (set! r15 tmp-ra.21)
                               (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! bat.8.2 rdi)
                                     (set! bar.7.1 rsi)
                                     (begin
                                       (set! rcx 9223372036854775807)
                                       (set! rdx bat.8.2)
                                       (set! rsi bat.8.2)
                                       (set! rdi bat.8.2)
                                       (set! r15 tmp-ra.7)
                                       (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx)))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.8 r15)
                             (begin
                               (set! bar.3.6 rdi)
                               (set! foobar.6.5 rsi)
                               (set! bar.9.4 rdx)
                               (set! bat.8.3 rcx)
                               (begin
                                 (set! rsi bar.9.4)
                                 (set! rdi bat.8.3)
                                 (set! r15 tmp-ra.8)
                                 (jump L.tmp.0.1 rbp r15 rdi rsi)))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! rsi 698097472)
                             (set! rdi -880757424)
                             (set! r15 tmp-ra.9)
                             (jump L.tmp.0.1 rbp r15 rdi rsi)))))
  (check-by-interp-v6 '(module ((new-frames (())))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! bat.3.5 rdi)
                                     (set! bar.8.4 rsi)
                                     (set! ball.4.3 rdx)
                                     (set! bar.2.2 rcx)
                                     (set! foo.6.1 r8)
                                     (begin
                                       (set! rax foo.6.1)
                                       (jump tmp-ra.7 rbp rax)))))
                         (begin
                           (set! tmp-ra.8 r15)
                           (begin
                             (begin
                               (return-point L.rp.2
                                             (begin
                                               (set! r8 -9223372036854775808)
                                               (set! rcx 1)
                                               (set! rdx 0)
                                               (set! rsi -9223372036854775808)
                                               (set! rdi 1)
                                               (set! r15 L.rp.2)
                                               (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
                               (set! foo.5.6 rax))
                             (if (= -9223372036854775808 175566669)
                                 (begin
                                   (set! rax -1855219983)
                                   (jump tmp-ra.8 rbp rax))
                                 (begin
                                   (set! rax foo.5.6)
                                   (jump tmp-ra.8 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames (())))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (begin
                                     (set! ball.1.1 rdi)
                                     (begin
                                       (if (begin
                                             (set! bar.5.3 1541307282)
                                             (= 9223372036854775807 -194099637))
                                           (set! bar.2.2 (- ball.1.1 -1702731989))
                                           (begin
                                             (set! bar.2.4 ball.1.1)
                                             (set! bar.2.2 ball.1.1)))
                                       (if (not (= -9223372036854775808 bar.2.2))
                                           (begin
                                             (set! bar.6.5 1)
                                             (begin
                                               (set! rax bar.2.2)
                                               (jump tmp-ra.11 rbp rax)))
                                           (begin
                                             (set! rdi 0)
                                             (set! r15 tmp-ra.11)
                                             (jump L.proc.0.1 rbp r15 rdi)))))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.12 r15)
                             (begin
                               (begin
                                 (set! rax (+ 9223372036854775807 1))
                                 (jump tmp-ra.12 rbp rax)))))
                         (define L.fn.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.13 r15)
                             (begin
                               (set! bat.9.6 rdi)
                               (begin
                                 (set! bar.6.7 (* 1 0))
                                 (begin
                                   (set! r15 tmp-ra.13)
                                   (jump L.fn.1.2 rbp r15))))))
                         (begin
                           (set! tmp-ra.14 r15)
                           (if (true)
                               (begin
                                 (begin
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! rdi 1)
                                                   (set! r15 L.rp.4)
                                                   (jump L.fn.2.3 rbp r15 rdi)))
                                   (set! bat.3.8 rax))
                                 (begin
                                   (set! bar.7.9 bat.3.8)
                                   (begin
                                     (set! rax 1)
                                     (jump tmp-ra.14 rbp rax))))
                               (begin
                                 (set! bar.5.10 -1579827217)
                                 (begin
                                   (set! rdi bar.5.10)
                                   (set! r15 tmp-ra.14)
                                   (jump L.fn.2.3 rbp r15 rdi)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.17 r15)
                                   (begin
                                     (set! bar.6.5 rdi)
                                     (set! foobar.5.4 rsi)
                                     (set! foo.9.3 rdx)
                                     (set! foobar.7.2 rcx)
                                     (set! ball.4.1 r8)
                                     (begin
                                       (begin
                                         (begin
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! r8 1)
                                                           (set! rcx foo.9.3)
                                                           (set! rdx ball.4.1)
                                                           (set! rsi ball.4.1)
                                                           (set! rdi 0)
                                                           (set! r15 L.rp.4)
                                                           (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))
                                           (set! foobar.7.7 rax))
                                         (set! bat.3.6 (- foobar.7.7 foobar.7.7)))
                                       (if (true)
                                           (begin
                                             (set! rax (* -9223372036854775808 foobar.7.2))
                                             (jump tmp-ra.17 rbp rax))
                                           (if (!= -9223372036854775808 bat.3.6)
                                               (begin
                                                 (set! rax foobar.7.2)
                                                 (jump tmp-ra.17 rbp rax))
                                               (begin
                                                 (set! rax 0)
                                                 (jump tmp-ra.17 rbp rax))))))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.18 r15)
                             (begin
                               (set! foo.2.12 rdi)
                               (set! foobar.1.11 rsi)
                               (set! foo.8.10 rdx)
                               (set! ball.4.9 rcx)
                               (set! foobar.7.8 r8)
                               (if (false)
                                   (begin
                                     (if (!= -1658461695 9223372036854775807)
                                         (set! foo.8.13 -9223372036854775808)
                                         (set! foo.8.13 foobar.1.11))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.18 rbp rax)))
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
                                         (begin
                                           (set! rax 1)
                                           (jump tmp-ra.18 rbp rax))))))))
                         (define L.tmp.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (begin
                                 (begin
                                   (set! foo.8.16 1)
                                   (set! foobar.5.15 foo.8.16))
                                 (if (if (> 9223372036854775807 foobar.5.15)
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
                                       (jump L.x.0.1 rbp r15 rdi rsi rdx rcx r8)))))))
                         (begin
                           (set! tmp-ra.20 r15)
                           (begin
                             (set! rax (* -1293429216 880066208))
                             (jump tmp-ra.20 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.14 r15)
                                   (begin
                                     (set! bar.4.6 rdi)
                                     (set! foobar.5.5 rsi)
                                     (set! bar.0.4 rdx)
                                     (set! foo.7.3 rcx)
                                     (set! ball.3.2 r8)
                                     (set! ball.8.1 r9)
                                     (if (not (if (> 0 701262944)
                                                  (!= foo.7.3 9223372036854775807)
                                                  (< ball.8.1 ball.8.1)))
                                         (if (true)
                                             (if (= 1779018832 ball.8.1)
                                                 (begin
                                                   (set! rax -9223372036854775808)
                                                   (jump tmp-ra.14 rbp rax))
                                                 (begin
                                                   (set! rax bar.4.6)
                                                   (jump tmp-ra.14 rbp rax)))
                                             (begin
                                               (set! bar.0.7 foo.7.3)
                                               (begin
                                                 (set! rax foobar.5.5)
                                                 (jump tmp-ra.14 rbp rax))))
                                         (begin
                                           (set! r9 bar.4.6)
                                           (set! r8 ball.3.2)
                                           (set! rcx foo.7.3)
                                           (set! rdx 9223372036854775807)
                                           (set! rsi ball.8.1)
                                           (set! rdi 1)
                                           (set! r15 tmp-ra.14)
                                           (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))))
                         (define L.proc.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.15 r15)
                             (begin
                               (set! bar.1.10 rdi)
                               (set! ball.8.9 rsi)
                               (set! foobar.2.8 rdx)
                               (begin
                                 (if (<= -408033154 bar.1.10)
                                     (set! ball.3.11 (+ ball.8.9 bar.1.10))
                                     (begin
                                       (set! bar.4.12 ball.8.9)
                                       (set! ball.3.11 bar.4.12)))
                                 (begin
                                   (set! rdx ball.8.9)
                                   (set! rsi bar.1.10)
                                   (set! rdi ball.8.9)
                                   (set! r15 tmp-ra.15)
                                   (jump L.proc.1.2 rbp r15 rdi rsi rdx))))))
                         (begin
                           (set! tmp-ra.16 r15)
                           (begin
                             (if (<= 1 899234556)
                                 (set! ball.3.13 0)
                                 (set! ball.3.13 0))
                             (begin
                               (set! r9 -9223372036854775808)
                               (set! r8 1792291800)
                               (set! rcx ball.3.13)
                               (set! rdx 1961997671)
                               (set! rsi ball.3.13)
                               (set! rdi ball.3.13)
                               (set! r15 tmp-ra.16)
                               (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.14 r15)
                                   (begin
                                     (set! foo.5.4 rdi)
                                     (set! foo.0.3 rsi)
                                     (set! foo.3.2 rdx)
                                     (set! foo.4.1 rcx)
                                     (begin
                                       (if (begin
                                             (set! ball.1.6 foo.4.1)
                                             (<= -9223372036854775808 -1549190542))
                                           (begin
                                             (set! foo.0.7 1)
                                             (set! ball.7.5 foo.3.2))
                                           (set! ball.7.5 foo.3.2))
                                       (if (true)
                                           (begin
                                             (set! foo.3.8 foo.0.3)
                                             (begin
                                               (set! rax ball.7.5)
                                               (jump tmp-ra.14 rbp rax)))
                                           (begin
                                             (set! rcx foo.0.3)
                                             (set! rdx -9223372036854775808)
                                             (set! rsi foo.3.2)
                                             (set! rdi foo.3.2)
                                             (set! r15 tmp-ra.14)
                                             (jump L.x.0.1 rbp r15 rdi rsi rdx rcx)))))))
                         (begin
                           (set! tmp-ra.15 r15)
                           (begin
                             (if (true)
                                 (set! bat.8.9 480297521)
                                 (set! bat.8.9 (- 1 0)))
                             (if (= bat.8.9 0)
                                 (begin
                                   (begin
                                     (set! bat.9.11 bat.8.9)
                                     (set! foo.4.10 0))
                                   (begin
                                     (set! rcx foo.4.10)
                                     (set! rdx 0)
                                     (set! rsi 9223372036854775807)
                                     (set! rdi 9223372036854775807)
                                     (set! r15 tmp-ra.15)
                                     (jump L.x.0.1 rbp r15 rdi rsi rdx rcx)))
                                 (if (begin
                                       (set! bat.9.12 1)
                                       (>= bat.8.9 1434817833))
                                     (begin
                                       (set! rax (* -9223372036854775808 -1655015632))
                                       (jump tmp-ra.15 rbp rax))
                                     (begin
                                       (set! bat.2.13 -9223372036854775808)
                                       (begin
                                         (set! rax 1398310587)
                                         (jump tmp-ra.15 rbp rax)))))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.10 r15)
                                   (begin
                                     (set! bat.1.7 rdi)
                                     (set! foo.6.6 rsi)
                                     (set! ball.0.5 rdx)
                                     (set! foo.9.4 rcx)
                                     (set! foo.5.3 r8)
                                     (set! ball.2.2 r9)
                                     (set! foo.4.1 fv0)
                                     (if (> 9223372036854775807 -1225978347)
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
                                           (begin
                                             (set! fv0 0)
                                             (set! r9 foo.6.6)
                                             (set! r8 foo.6.6)
                                             (set! rcx 9223372036854775807)
                                             (set! rdx -9223372036854775808)
                                             (set! rsi -472335653)
                                             (set! rdi -9223372036854775808)
                                             (set! r15 tmp-ra.10)
                                             (jump L.func.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))))
                         (begin
                           (set! tmp-ra.11 r15)
                           (if (>= 1 9223372036854775807)
                               (begin
                                 (set! bar.8.9 1)
                                 (begin
                                   (set! rax bar.8.9)
                                   (jump tmp-ra.11 rbp rax)))
                               (begin
                                 (set! rax -32529780)
                                 (jump tmp-ra.11 rbp rax))))))

  ;;

  ;; M6 tests; Added by Trevor on March 6th 2026, multiple bindings allowed per let
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.10 r15)
                                   (begin
                                     (set! ball.9.7 rdi)
                                     (set! foo.5.6 rsi)
                                     (set! ball.2.5 rdx)
                                     (set! ball.7.4 rcx)
                                     (set! foo.0.3 r8)
                                     (set! bat.8.2 r9)
                                     (set! foobar.1.1 fv0)
                                     (begin
                                       (set! r15 tmp-ra.10)
                                       (jump L.tmp.1.2 rbp r15)))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.11 r15)
                             (begin
                               (begin
                                 (set! rsi 0)
                                 (set! rdi 0)
                                 (set! r15 tmp-ra.11)
                                 (jump L.proc.2.3 rbp r15 rdi rsi)))))
                         (define L.proc.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.12 r15)
                             (begin
                               (set! foo.6.9 rdi)
                               (set! bat.8.8 rsi)
                               (begin
                                 (set! fv0 1635273112)
                                 (set! r9 foo.6.9)
                                 (set! r8 bat.8.8)
                                 (set! rcx foo.6.9)
                                 (set! rdx 445965252)
                                 (set! rsi foo.6.9)
                                 (set! rdi bat.8.8)
                                 (set! r15 tmp-ra.12)
                                 (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
                         (begin
                           (set! tmp-ra.13 r15)
                           (if (if (<= 9223372036854775807 -9223372036854775808)
                                   (< 692968731 0)
                                   (<= -1490931083 -14809197))
                               (begin
                                 (set! rax 1275113131)
                                 (jump tmp-ra.13 rbp rax))
                               (if (<= -1702177019 -9223372036854775808)
                                   (begin
                                     (set! rax 0)
                                     (jump tmp-ra.13 rbp rax))
                                   (begin
                                     (set! rax 1843455920)
                                     (jump tmp-ra.13 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (begin
                                     (set! bat.5.7 rdi)
                                     (set! foo.2.6 rsi)
                                     (set! bar.9.5 rdx)
                                     (set! foo.8.4 rcx)
                                     (set! foobar.4.3 r8)
                                     (set! bat.3.2 r9)
                                     (set! bat.7.1 fv0)
                                     (begin
                                       (set! fv0 bat.3.2)
                                       (set! r9 foo.8.4)
                                       (set! r8 foo.8.4)
                                       (set! rcx 9223372036854775807)
                                       (set! rdx bat.5.7)
                                       (set! rsi -9223372036854775808)
                                       (set! rdi bat.3.2)
                                       (set! r15 tmp-ra.11)
                                       (jump L.fn.0.1 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
                         (begin
                           (set! tmp-ra.12 r15)
                           (begin
                             (set! bat.6.10 9223372036854775807)
                             (set! foobar.4.9 9223372036854775807)
                             (set! ball.0.8 9223372036854775807)
                             (begin
                               (set! rax foobar.4.9)
                               (jump tmp-ra.12 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames (())))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (begin
                                     (set! bar.2.5 rdi)
                                     (set! ball.4.4 rsi)
                                     (set! foo.9.3 rdx)
                                     (set! foobar.5.2 rcx)
                                     (set! foo.6.1 r8)
                                     (if (true)
                                         (begin
                                           (set! foo.9.7 bar.2.5)
                                           (begin
                                             (return-point L.rp.3
                                                           (begin
                                                             (set! rdx -1140169546)
                                                             (set! rsi foobar.5.2)
                                                             (set! rdi foo.9.3)
                                                             (set! r15 L.rp.3)
                                                             (jump L.func.1.2 rbp r15 rdi rsi rdx)))
                                             (set! bat.0.6 rax))
                                           (begin
                                             (set! rax (+ foo.6.1 bat.0.6))
                                             (jump tmp-ra.11 rbp rax)))
                                         (begin
                                           (set! rdx 9223372036854775807)
                                           (set! rsi foobar.5.2)
                                           (set! rdi foo.6.1)
                                           (set! r15 tmp-ra.11)
                                           (jump L.func.1.2 rbp r15 rdi rsi rdx))))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.12 r15)
                             (begin
                               (set! bat.0.10 rdi)
                               (set! foo.6.9 rsi)
                               (set! foo.9.8 rdx)
                               (if (!= 9223372036854775807 -47909185)
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
                                     (set! rax (+ -9223372036854775808 foo.6.9))
                                     (jump tmp-ra.12 rbp rax))))))
                         (begin
                           (set! tmp-ra.13 r15)
                           (if (> 9223372036854775807 9223372036854775807)
                               (begin
                                 (set! rax -877748660)
                                 (jump tmp-ra.13 rbp rax))
                               (begin
                                 (set! rax -9223372036854775808)
                                 (jump tmp-ra.13 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (begin
                                   (set! rax (+ -1640821439 -406700566))
                                   (jump tmp-ra.1 rbp rax)))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.11 r15)
                                   (begin
                                     (set! foo.2.2 rdi)
                                     (set! ball.6.1 rsi)
                                     (begin
                                       (set! r9 foo.2.2)
                                       (set! r8 ball.6.1)
                                       (set! rcx -9223372036854775808)
                                       (set! rdx ball.6.1)
                                       (set! rsi foo.2.2)
                                       (set! rdi ball.6.1)
                                       (set! r15 tmp-ra.11)
                                       (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.12 r15)
                             (begin
                               (set! ball.0.8 rdi)
                               (set! foo.4.7 rsi)
                               (set! foobar.1.6 rdx)
                               (set! ball.5.5 rcx)
                               (set! foo.2.4 r8)
                               (set! bar.7.3 r9)
                               (begin
                                 (set! r9 ball.5.5)
                                 (set! r8 1)
                                 (set! rcx -984231193)
                                 (set! rdx bar.7.3)
                                 (set! rsi bar.7.3)
                                 (set! rdi 933807622)
                                 (set! r15 tmp-ra.12)
                                 (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (begin
                           (set! tmp-ra.13 r15)
                           (begin
                             (set! bat.9.10 -477286222)
                             (set! bar.7.9 0)
                             (begin
                               (set! rax 643069821)
                               (jump tmp-ra.13 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.15 r15)
                                   (begin
                                     (set! bar.9.1 rdi)
                                     (if (!= bar.9.1 bar.9.1)
                                         (begin
                                           (set! rdi 2058053814)
                                           (set! r15 tmp-ra.15)
                                           (jump L.func.0.1 rbp r15 rdi))
                                         (begin
                                           (set! bat.2.3 (- bar.9.1 bar.9.1))
                                           (begin
                                             (set! bar.9.6 bar.9.1)
                                             (set! bat.0.5 bar.9.1)
                                             (set! ball.4.4 bar.9.1)
                                             (set! bat.0.2 ball.4.4))
                                           (begin
                                             (set! rdi bar.9.1)
                                             (set! r15 tmp-ra.15)
                                             (jump L.x.2.3 rbp r15 rdi)))))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.16 r15)
                             (begin
                               (set! bat.8.9 rdi)
                               (set! bat.3.8 rsi)
                               (set! bat.5.7 rdx)
                               (begin
                                 (set! rdi bat.8.9)
                                 (set! r15 tmp-ra.16)
                                 (jump L.x.2.3 rbp r15 rdi)))))
                         (define L.x.2.3
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.17 r15)
                             (begin
                               (set! bar.9.10 rdi)
                               (begin
                                 (begin
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! rdx -1942673900)
                                                   (set! rsi bar.9.10)
                                                   (set! rdi bar.9.10)
                                                   (set! r15 L.rp.4)
                                                   (jump L.tmp.1.2 rbp r15 rdi rsi rdx)))
                                   (set! bar.9.11 rax))
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
                                       (jump L.func.0.1 rbp r15 rdi)))))))
                         (begin
                           (set! tmp-ra.18 r15)
                           (if (true)
                               (begin
                                 (set! rax (+ 9223372036854775807 -9223372036854775808))
                                 (jump tmp-ra.18 rbp rax))
                               (begin
                                 (set! rdi -2107846344)
                                 (set! r15 tmp-ra.18)
                                 (jump L.func.0.1 rbp r15 rdi))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (<= 1 -9223372036854775808)
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
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.22 r15)
                                   (begin
                                     (set! foo.2.6 rdi)
                                     (set! ball.1.5 rsi)
                                     (set! foo.4.4 rdx)
                                     (set! foobar.7.3 rcx)
                                     (set! foo.5.2 r8)
                                     (set! foo.9.1 r9)
                                     (begin
                                       (set! rax (- foo.2.6 foo.4.4))
                                       (jump tmp-ra.22 rbp rax)))))
                         (define L.proc.1.2
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.23 r15)
                             (begin
                               (begin
                                 (set! foo.6.7 (+ 9223372036854775807 1))
                                 (begin
                                   (begin
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
                                     (set! foo.6.10 rax))
                                   (set! foobar.7.9 foo.6.7)
                                   (if (>= foo.6.7 foo.6.7)
                                       (set! foo.2.8 foo.6.7)
                                       (set! foo.2.8 foo.6.7))
                                   (begin
                                     (set! foo.4.13 foo.6.10)
                                     (set! foobar.7.12 foo.6.10)
                                     (set! foo.6.11 -9223372036854775808)
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.23 rbp rax))))))))
                         (define L.func.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.24 r15)
                             (begin
                               (set! bar.0.17 rdi)
                               (set! foobar.7.16 rsi)
                               (set! foo.4.15 rdx)
                               (set! foo.6.14 rcx)
                               (begin
                                 (set! foo.9.18 foobar.7.16)
                                 (begin
                                   (begin
                                     (set! foo.6.21 foo.6.14)
                                     (set! foo.9.20 foo.6.14)
                                     (set! foo.4.19 foobar.7.16))
                                   (if (>= foo.9.18 foo.6.14)
                                       (begin
                                         (set! rax foobar.7.16)
                                         (jump tmp-ra.24 rbp rax))
                                       (begin
                                         (set! rax bar.0.17)
                                         (jump tmp-ra.24 rbp rax))))))))
                         (begin
                           (set! tmp-ra.25 r15)
                           (begin
                             (set! rcx 9223372036854775807)
                             (set! rdx -1735352110)
                             (set! rsi 9223372036854775807)
                             (set! rdi 0)
                             (set! r15 tmp-ra.25)
                             (jump L.func.2.3 rbp r15 rdi rsi rdx rcx)))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.x.0.1
              ((new-frames ((nfv.17))))
              (begin
                (set! tmp-ra.16 r15)
                (begin
                  (set! bat.9.7 rdi)
                  (set! foobar.7.6 rsi)
                  (set! ball.1.5 rdx)
                  (set! foo.2.4 rcx)
                  (set! ball.6.3 r8)
                  (set! bar.0.2 r9)
                  (set! foobar.8.1 fv0)
                  (begin
                    (begin
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
                      (set! ball.1.8 rax))
                    (if (not (< 0 -9223372036854775808))
                        (begin
                          (set! rax (+ ball.6.3 ball.1.8))
                          (jump tmp-ra.16 rbp rax))
                        (if (<= foo.2.4 0)
                            (begin
                              (set! rax foo.2.4)
                              (jump tmp-ra.16 rbp rax))
                            (begin
                              (set! rax foobar.7.6)
                              (jump tmp-ra.16 rbp rax))))))))
      (define L.fn.1.2
        ((new-frames ()))
        (begin
          (set! tmp-ra.18 r15)
          (begin
            (set! bat.9.15 rdi)
            (set! bar.0.14 rsi)
            (set! foobar.4.13 rdx)
            (set! ball.6.12 rcx)
            (set! bat.5.11 r8)
            (set! foobar.7.10 r9)
            (set! foobar.8.9 fv0)
            (begin
              (set! fv0 0)
              (set! r9 bar.0.14)
              (set! r8 foobar.7.10)
              (set! rcx -9223372036854775808)
              (set! rdx bar.0.14)
              (set! rsi foobar.7.10)
              (set! rdi ball.6.12)
              (set! r15 tmp-ra.18)
              (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
      (begin
        (set! tmp-ra.19 r15)
        (if (>= -9223372036854775808 -637253177)
            (begin
              (set! rax -9223372036854775808)
              (jump tmp-ra.19 rbp rax))
            (begin
              (set! rax 0)
              (jump tmp-ra.19 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (begin
                                   (set! rax 9223372036854775807)
                                   (jump tmp-ra.1 rbp rax)))
                         ))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.proc.0.1
              ((new-frames ()))
              (begin
                (set! tmp-ra.28 r15)
                (begin
                  (set! bat.8.6 rdi)
                  (set! foo.7.5 rsi)
                  (set! foo.0.4 rdx)
                  (set! bat.1.3 rcx)
                  (set! bat.5.2 r8)
                  (set! bat.6.1 r9)
                  (begin
                    (set! r9 bat.1.3)
                    (set! r8 bat.8.6)
                    (set! rcx -635532414)
                    (set! rdx bat.5.2)
                    (set! rsi bat.5.2)
                    (set! rdi bat.5.2)
                    (set! r15 tmp-ra.28)
                    (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (define L.tmp.1.2
        ((new-frames ((nfv.31) (nfv.30) ())))
        (begin
          (set! tmp-ra.29 r15)
          (begin
            (set! bat.6.11 rdi)
            (set! foo.0.10 rsi)
            (set! bat.8.9 rdx)
            (set! ball.9.8 rcx)
            (set! foo.7.7 r8)
            (begin
              (begin
                (return-point L.rp.4
                              (begin
                                (set! r8 foo.7.7)
                                (set! rcx ball.9.8)
                                (set! rdx bat.6.11)
                                (set! rsi foo.7.7)
                                (set! rdi ball.9.8)
                                (set! r15 L.rp.4)
                                (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8)))
                (set! foo.0.13 rax))
              (begin
                (begin
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
                  (set! bat.5.15 rax))
                (set! bar.3.14 foo.0.10)
                (begin
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
                  (set! ball.4.12 rax)))
              (begin
                (set! ball.9.17 (- foo.0.13 foo.0.13))
                (if (= foo.0.13 ball.4.12)
                    (set! bat.8.16 ball.4.12)
                    (set! bat.8.16 foo.0.13))
                (begin
                  (set! fv0 ball.4.12)
                  (set! r9 -9223372036854775808)
                  (set! r8 bat.6.11)
                  (set! rcx bat.8.16)
                  (set! rdx foo.7.7)
                  (set! rsi foo.7.7)
                  (set! rdi ball.4.12)
                  (set! r15 tmp-ra.29)
                  (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))))
      (define L.func.2.3
        ((new-frames ()))
        (begin
          (set! tmp-ra.32 r15)
          (begin
            (set! foo.2.24 rdi)
            (set! bat.5.23 rsi)
            (set! bat.8.22 rdx)
            (set! foo.0.21 rcx)
            (set! bar.3.20 r8)
            (set! bat.1.19 r9)
            (set! ball.4.18 fv0)
            (begin
              (set! fv0 9223372036854775807)
              (set! r9 foo.0.21)
              (set! r8 ball.4.18)
              (set! rcx ball.4.18)
              (set! rdx foo.0.21)
              (set! rsi -9223372036854775808)
              (set! rdi bar.3.20)
              (set! r15 tmp-ra.32)
              (jump L.func.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0)))))
      (begin
        (set! tmp-ra.33 r15)
        (begin
          (set! bar.3.27 -9223372036854775808)
          (set! foo.7.26 9223372036854775807)
          (set! foo.0.25 9223372036854775807)
          (begin
            (set! rax bar.3.27)
            (jump tmp-ra.33 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.func.0.1
              ((new-frames (())))
              (begin
                (set! tmp-ra.22 r15)
                (begin
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
                        (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))))
      (define L.fn.1.2
        ((new-frames ()))
        (begin
          (set! tmp-ra.23 r15)
          (begin
            (set! bar.1.14 rdi)
            (set! bat.7.13 rsi)
            (set! ball.5.12 rdx)
            (set! bar.0.11 rcx)
            (set! bat.3.10 r8)
            (set! foobar.9.9 r9)
            (begin
              (if (if (>= bat.3.10 bar.1.14)
                      (> bat.7.13 -9223372036854775808)
                      (>= ball.5.12 bat.3.10))
                  (begin
                    (set! bat.7.17 bar.0.11)
                    (set! foobar.9.16 9223372036854775807)
                    (set! bat.8.15 bar.1.14)
                    (begin
                      (set! rax bat.3.10)
                      (jump tmp-ra.23 rbp rax)))
                  (if (< bat.3.10 bar.1.14)
                      (begin
                        (set! rax bar.0.11)
                        (jump tmp-ra.23 rbp rax))
                      (begin
                        (set! rax bat.7.13)
                        (jump tmp-ra.23 rbp rax))))))))
      (begin
        (set! tmp-ra.24 r15)
        (begin
          (set! bar.2.20 405359082)
          (if (not (>= -915730633 0))
              (begin
                (set! bat.8.21 -532660031)
                (set! bat.6.19 -248685178))
              (set! bat.6.19 0))
          (set! bat.7.18 1254220652)
          (begin
            (set! r9 bar.2.20)
            (set! r8 bat.6.19)
            (set! rcx 9223372036854775807)
            (set! rdx bat.6.19)
            (set! rsi bat.6.19)
            (set! rdi -9223372036854775808)
            (set! r15 tmp-ra.24)
            (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.proc.0.1
              ((new-frames ()))
              (begin
                (set! tmp-ra.19 r15)
                (begin
                  (set! foobar.9.5 rdi)
                  (set! foobar.7.4 rsi)
                  (set! foo.2.3 rdx)
                  (set! foo.5.2 rcx)
                  (set! foo.1.1 r8)
                  (begin
                    (set! r8 1)
                    (set! rcx -1754605622)
                    (set! rdx -675715652)
                    (set! rsi foo.2.3)
                    (set! rdi foo.1.1)
                    (set! r15 tmp-ra.19)
                    (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8)))))
      (define L.func.1.2
        ((new-frames ()))
        (begin
          (set! tmp-ra.20 r15)
          (begin
            (set! foobar.3.7 rdi)
            (set! foo.1.6 rsi)
            (begin
              (set! r8 foo.1.6)
              (set! rcx foo.1.6)
              (set! rdx foobar.3.7)
              (set! rsi foobar.3.7)
              (set! rdi foo.1.6)
              (set! r15 tmp-ra.20)
              (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8)))))
      (define L.x.2.3
        ((new-frames ((nfv.22))))
        (begin
          (set! tmp-ra.21 r15)
          (begin
            (set! bar.0.14 rdi)
            (set! foobar.9.13 rsi)
            (set! foo.8.12 rdx)
            (set! bar.4.11 rcx)
            (set! bat.6.10 r8)
            (set! foo.1.9 r9)
            (set! foobar.7.8 fv0)
            (begin
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
              (set! foo.1.15 (* bar.4.11 bar.4.11))
              (begin
                (set! fv0 bar.4.11)
                (set! r9 bar.0.14)
                (set! r8 -922337918)
                (set! rcx foobar.7.8)
                (set! rdx foobar.7.8)
                (set! rsi bar.4.11)
                (set! rdi foobar.7.8)
                (set! r15 tmp-ra.21)
                (jump L.x.2.3 rbp r15 rdi rsi rdx rcx r8 r9 fv0))))))
      (begin
        (set! tmp-ra.23 r15)
        (begin
          (set! bar.0.18 0)
          (set! foo.8.17 1029279872)
          (begin
            (set! rax bar.0.18)
            (jump tmp-ra.23 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
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
                                           (!= -1879829070 1981475003)))
                                     (begin
                                       (set! rax (- -634246165 -684848771))
                                       (jump tmp-ra.6 rbp rax))
                                     (begin
                                       (set! rax 0)
                                       (jump tmp-ra.6 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! bat.2.3 rdi)
                                     (set! foo.3.2 rsi)
                                     (set! bar.6.1 rdx)
                                     (begin
                                       (set! rdx bat.2.3)
                                       (set! rsi -1803672217)
                                       (set! rdi bat.2.3)
                                       (set! r15 tmp-ra.8)
                                       (jump L.proc.1.2 rbp r15 rdi rsi rdx)))))
                         (define L.proc.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.9 r15)
                             (begin
                               (set! foo.3.6 rdi)
                               (set! ball.0.5 rsi)
                               (set! bat.1.4 rdx)
                               (begin
                                 (set! rdx bat.1.4)
                                 (set! rsi ball.0.5)
                                 (set! rdi 1)
                                 (set! r15 tmp-ra.9)
                                 (jump L.proc.1.2 rbp r15 rdi rsi rdx)))))
                         (begin
                           (set! tmp-ra.10 r15)
                           (begin
                             (set! bar.9.7 0)
                             (begin
                               (set! rax bar.9.7)
                               (jump tmp-ra.10 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.6 r15)
                                 (begin
                                   (begin
                                     (begin
                                       (begin
                                         (set! bat.2.5 1550347185)
                                         (set! ball.0.4 9223372036854775807)
                                         (set! foobar.7.3 -9223372036854775808)
                                         (set! bar.6.2 ball.0.4))
                                       (set! ball.0.1 bar.6.2))
                                     (begin
                                       (set! rax (- 9223372036854775807 ball.0.1))
                                       (jump tmp-ra.6 rbp rax)))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames (() () () () ())))
                                 (begin
                                   (set! tmp-ra.14 r15)
                                   (begin
                                     (set! bar.6.3 rdi)
                                     (set! bar.3.2 rsi)
                                     (set! foo.1.1 rdx)
                                     (begin
                                       (begin
                                         (return-point L.rp.2
                                                       (begin
                                                         (set! rdx foo.1.1)
                                                         (set! rsi foo.1.1)
                                                         (set! rdi 9223372036854775807)
                                                         (set! r15 L.rp.2)
                                                         (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                         (set! bar.3.6 rax))
                                       (begin
                                         (return-point L.rp.3
                                                       (begin
                                                         (set! rdx bar.6.3)
                                                         (set! rsi foo.1.1)
                                                         (set! rdi bar.6.3)
                                                         (set! r15 L.rp.3)
                                                         (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                         (set! ball.9.5 rax))
                                       (begin
                                         (begin
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! rdx bar.6.3)
                                                           (set! rsi foo.1.1)
                                                           (set! rdi foo.1.1)
                                                           (set! r15 L.rp.4)
                                                           (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                           (set! ball.2.9 rax))
                                         (set! ball.9.8 bar.3.2)
                                         (begin
                                           (return-point L.rp.5
                                                         (begin
                                                           (set! rdx bar.3.2)
                                                           (set! rsi foo.1.1)
                                                           (set! rdi foo.1.1)
                                                           (set! r15 L.rp.5)
                                                           (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                           (set! foo.8.7 rax))
                                         (begin
                                           (return-point L.rp.6
                                                         (begin
                                                           (set! rdx ball.2.9)
                                                           (set! rsi foo.8.7)
                                                           (set! rdi foo.8.7)
                                                           (set! r15 L.rp.6)
                                                           (jump L.proc.0.1 rbp r15 rdi rsi rdx)))
                                           (set! bar.6.4 rax)))
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
                                             (begin
                                               (set! rax ball.9.5)
                                               (jump tmp-ra.14 rbp rax))))))))
                         (begin
                           (set! tmp-ra.15 r15)
                           (begin
                             (set! ball.9.13 1)
                             (set! foo.1.12 -9223372036854775808)
                             (begin
                               (set! rax foo.1.12)
                               (jump tmp-ra.15 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.17 r15)
                                   (begin
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
                                           (jump L.func.2.3 rbp r15 rdi rsi rdx rcx))))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.18 r15)
                             (begin
                               (set! foobar.6.7 rdi)
                               (set! foobar.3.6 rsi)
                               (set! foo.5.5 rdx)
                               (set! bar.2.4 rcx)
                               (set! ball.8.3 r8)
                               (set! bar.0.2 r9)
                               (begin
                                 (set! bar.0.10 9223372036854775807)
                                 (set! foo.5.9 (+ foo.5.5 foobar.3.6))
                                 (begin
                                   (set! ball.1.11 (+ bar.2.4 foobar.3.6))
                                   (set! foobar.6.8 foobar.3.6))
                                 (begin
                                   (set! rdi 0)
                                   (set! r15 tmp-ra.18)
                                   (jump L.fn.0.1 rbp r15 rdi))))))
                         (define L.func.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.19 r15)
                             (begin
                               (set! ball.9.15 rdi)
                               (set! ball.8.14 rsi)
                               (set! bar.0.13 rdx)
                               (set! foobar.6.12 rcx)
                               (begin
                                 (set! r9 9223372036854775807)
                                 (set! r8 bar.0.13)
                                 (set! rcx ball.9.15)
                                 (set! rdx foobar.6.12)
                                 (set! rsi foobar.6.12)
                                 (set! rdi 1)
                                 (set! r15 tmp-ra.19)
                                 (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (begin
                           (set! tmp-ra.20 r15)
                           (begin
                             (set! bat.4.16 (+ 1 9223372036854775807))
                             (begin
                               (set! rax bat.4.16)
                               (jump tmp-ra.20 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.3 r15)
                                 (begin
                                   (set! foobar.1.2 0)
                                   (set! bat.0.1 1)
                                   (begin
                                     (set! rax bat.0.1)
                                     (jump tmp-ra.3 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (begin
                                       (set! r9 0)
                                       (set! r8 1)
                                       (set! rcx 9223372036854775807)
                                       (set! rdx 9223372036854775807)
                                       (set! rsi 1)
                                       (set! rdi 38797657)
                                       (set! r15 tmp-ra.7)
                                       (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.8 r15)
                             (begin
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
                                         (set! rax (- foobar.1.2 bar.2.3))
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
                                     (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9))))))
                         (begin
                           (set! tmp-ra.9 r15)
                           (begin
                             (set! r9 -9223372036854775808)
                             (set! r8 0)
                             (set! rcx -9223372036854775808)
                             (set! rdx -9223372036854775808)
                             (set! rsi -2062025435)
                             (set! rdi 0)
                             (set! r15 tmp-ra.9)
                             (jump L.x.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.8 r15)
                                   (begin
                                     (set! foo.4.4 rdi)
                                     (set! foo.7.3 rsi)
                                     (set! foo.3.2 rdx)
                                     (set! foo.9.1 rcx)
                                     (begin
                                       (set! rdx foo.3.2)
                                       (set! rsi -9223372036854775808)
                                       (set! rdi foo.4.4)
                                       (set! r15 tmp-ra.8)
                                       (jump L.proc.1.2 rbp r15 rdi rsi rdx)))))
                         (define L.proc.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.9 r15)
                             (begin
                               (set! foo.9.7 rdi)
                               (set! bat.5.6 rsi)
                               (set! foo.7.5 rdx)
                               (begin
                                 (set! rax (- bat.5.6 foo.7.5))
                                 (jump tmp-ra.9 rbp rax)))))
                         (begin
                           (set! tmp-ra.10 r15)
                           (begin
                             (begin
                               (set! rax 1)
                               (jump tmp-ra.10 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.3 r15)
                                 (begin
                                   (set! ball.3.2 -550916464)
                                   (set! foobar.9.1 9223372036854775807)
                                   (begin
                                     (set! rax foobar.9.1)
                                     (jump tmp-ra.3 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.2 r15)
                                 (if (false)
                                     (if (if (< 9223372036854775807 1646335033)
                                             (>= 9223372036854775807 1)
                                             (!= 9223372036854775807 1))
                                         (if (!= -9223372036854775808 -9223372036854775808)
                                             (begin
                                               (set! rax -9223372036854775808)
                                               (jump tmp-ra.2 rbp rax))
                                             (begin
                                               (set! rax 1282320164)
                                               (jump tmp-ra.2 rbp rax)))
                                         (begin
                                           (set! bar.1.1 -9223372036854775808)
                                           (begin
                                             (set! rax bar.1.1)
                                             (jump tmp-ra.2 rbp rax))))
                                     (begin
                                       (set! rax (- 9223372036854775807 1))
                                       (jump tmp-ra.2 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames (() ())))
                                 (begin
                                   (set! tmp-ra.15 r15)
                                   (begin
                                     (set! bar.1.4 rdi)
                                     (set! bat.6.3 rsi)
                                     (set! ball.4.2 rdx)
                                     (set! bar.0.1 rcx)
                                     (begin
                                       (begin
                                         (return-point L.rp.3
                                                       (begin
                                                         (set! rcx bar.1.4)
                                                         (set! rdx bar.0.1)
                                                         (set! rsi bat.6.3)
                                                         (set! rdi bat.6.3)
                                                         (set! r15 L.rp.3)
                                                         (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx)))
                                         (set! ball.7.6 rax))
                                       (begin
                                         (set! ball.4.5 (- bat.6.3 bar.0.1)))
                                       (begin
                                         (begin
                                           (set! foobar.2.11 bat.6.3)
                                           (set! bar.1.10 1)
                                           (set! foobar.8.9 bar.0.1))
                                         (set! bar.0.8 bar.1.4)
                                         (begin
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! rdx bar.1.4)
                                                           (set! rsi 9223372036854775807)
                                                           (set! rdi bar.0.1)
                                                           (set! r15 L.rp.4)
                                                           (jump L.x.1.2 rbp r15 rdi rsi rdx)))
                                           (set! foobar.2.7 rax))
                                         (begin
                                           (set! rdx bat.6.3)
                                           (set! rsi bat.6.3)
                                           (set! rdi -9223372036854775808)
                                           (set! r15 tmp-ra.15)
                                           (jump L.x.1.2 rbp r15 rdi rsi rdx)))))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.16 r15)
                             (begin
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
                                         (jump L.x.1.2 rbp r15 rdi rsi rdx)))))))
                         (begin
                           (set! tmp-ra.17 r15)
                           (if (<= 9223372036854775807 9223372036854775807)
                               (begin
                                 (set! rax -1677147892)
                                 (jump tmp-ra.17 rbp rax))
                               (begin
                                 (set! rax 874915829)
                                 (jump tmp-ra.17 rbp rax))))))
  (check-by-interp-v6
   '(module ((new-frames ()))
            (define L.proc.0.1
              ((new-frames (() (nfv.26))))
              (begin
                (set! tmp-ra.25 r15)
                (begin
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
                        (begin
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
                          (set! ball.7.9 rax))
                        (begin
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
                          (set! foo.2.8 rax))
                        (begin
                          (set! foo.2.11 foo.1.6)
                          (begin
                            (set! rax ball.0.2)
                            (jump tmp-ra.25 rbp rax))))
                      (begin
                        (begin
                          (set! rax -774243080)
                          (jump tmp-ra.25 rbp rax)))))))
      (define L.fn.1.2
        ((new-frames ()))
        (begin
          (set! tmp-ra.27 r15)
          (begin
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
                  (set! ball.9.18 (- -1548357748 foobar.3.13))
                  (begin
                    (set! r9 ball.9.18)
                    (set! r8 foo.1.15)
                    (set! rcx ball.4.16)
                    (set! rdx foo.1.15)
                    (set! rsi 0)
                    (set! rdi ball.9.18)
                    (set! r15 tmp-ra.27)
                    (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))
                (begin
                  (set! r9 foo.5.17)
                  (set! r8 ball.7.12)
                  (set! rcx ball.7.12)
                  (set! rdx ball.4.16)
                  (set! rsi foobar.3.13)
                  (set! rdi ball.9.14)
                  (set! r15 tmp-ra.27)
                  (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9))))))
      (define L.fn.2.3
        ((new-frames ()))
        (begin
          (set! tmp-ra.28 r15)
          (begin
            (set! foobar.8.24 rdi)
            (set! foo.1.23 rsi)
            (set! foobar.3.22 rdx)
            (set! foo.2.21 rcx)
            (set! foo.6.20 r8)
            (set! ball.9.19 r9)
            (begin
              (set! r9 0)
              (set! r8 1)
              (set! rcx foo.6.20)
              (set! rdx foo.2.21)
              (set! rsi -9223372036854775808)
              (set! rdi foo.6.20)
              (set! r15 tmp-ra.28)
              (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))))
      (begin
        (set! tmp-ra.29 r15)
        (if (< -534391580 9223372036854775807)
            (begin
              (set! rax 0)
              (jump tmp-ra.29 rbp rax))
            (begin
              (set! rax 0)
              (jump tmp-ra.29 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (begin
                                   (begin
                                     (set! ball.7.3 -1762920629)
                                     (set! ball.8.2 1)
                                     (set! foobar.1.1 9223372036854775807)
                                     (begin
                                       (set! rax 0)
                                       (jump tmp-ra.4 rbp rax)))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.7 r15)
                                   (begin
                                     (set! foobar.0.6 rdi)
                                     (set! ball.2.5 rsi)
                                     (set! ball.3.4 rdx)
                                     (set! ball.5.3 rcx)
                                     (set! bar.4.2 r8)
                                     (set! foobar.8.1 r9)
                                     (begin
                                       (set! r9 ball.2.5)
                                       (set! r8 ball.2.5)
                                       (set! rcx ball.5.3)
                                       (set! rdx foobar.0.6)
                                       (set! rsi 15882253)
                                       (set! rdi ball.2.5)
                                       (set! r15 tmp-ra.7)
                                       (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (begin
                           (set! tmp-ra.8 r15)
                           (if (!= 1038395452 1)
                               (begin
                                 (set! rax -9223372036854775808)
                                 (jump tmp-ra.8 rbp rax))
                               (begin
                                 (set! rax 717010255)
                                 (jump tmp-ra.8 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (if (true)
                                     (if (not (= 0 1))
                                         (if (>= -9223372036854775808 -1744096882)
                                             (begin
                                               (set! rax 0)
                                               (jump tmp-ra.4 rbp rax))
                                             (begin
                                               (set! rax 9223372036854775807)
                                               (jump tmp-ra.4 rbp rax)))
                                         (if (< -9223372036854775808 0)
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
                                           (begin
                                             (set! rax foo.5.2)
                                             (jump tmp-ra.4 rbp rax)))
                                         (begin
                                           (set! bat.8.3 9223372036854775807)
                                           (begin
                                             (set! rax bat.8.3)
                                             (jump tmp-ra.4 rbp rax))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (< 0 9223372036854775807)
                                     (begin
                                       (set! rax 1620518798)
                                       (jump tmp-ra.1 rbp rax))
                                     (if (!= 0 9223372036854775807)
                                         (begin
                                           (set! rax 0)
                                           (jump tmp-ra.1 rbp rax))
                                         (begin
                                           (set! rax -9223372036854775808)
                                           (jump tmp-ra.1 rbp rax)))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.12 r15)
                                   (begin
                                     (set! foobar.2.2 rdi)
                                     (set! ball.0.1 rsi)
                                     (begin
                                       (set! rdx 9223372036854775807)
                                       (set! rsi foobar.2.2)
                                       (set! rdi foobar.2.2)
                                       (set! r15 tmp-ra.12)
                                       (jump L.tmp.1.2 rbp r15 rdi rsi rdx)))))
                         (define L.tmp.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.13 r15)
                             (begin
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
                                     (jump L.tmp.1.2 rbp r15 rdi rsi rdx))))))
                         (define L.tmp.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.14 r15)
                             (begin
                               (set! foobar.2.11 rdi)
                               (set! foo.6.10 rsi)
                               (set! foobar.7.9 rdx)
                               (set! ball.5.8 rcx)
                               (set! bar.1.7 r8)
                               (set! bat.9.6 r9)
                               (begin
                                 (set! r9 foo.6.10)
                                 (set! r8 bar.1.7)
                                 (set! rcx foobar.2.11)
                                 (set! rdx bar.1.7)
                                 (set! rsi 1666412948)
                                 (set! rdi 273235985)
                                 (set! r15 tmp-ra.14)
                                 (jump L.tmp.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (begin
                           (set! tmp-ra.15 r15)
                           (if (= -9223372036854775808 9223372036854775807)
                               (begin
                                 (set! rax 9223372036854775807)
                                 (jump tmp-ra.15 rbp rax))
                               (begin
                                 (set! rax 1)
                                 (jump tmp-ra.15 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.6 r15)
                                   (begin
                                     (set! ball.2.5 rdi)
                                     (set! ball.4.4 rsi)
                                     (set! ball.0.3 rdx)
                                     (set! foo.1.2 rcx)
                                     (set! foo.8.1 r8)
                                     (begin
                                       (set! r8 ball.2.5)
                                       (set! rcx foo.1.2)
                                       (set! rdx ball.4.4)
                                       (set! rsi ball.2.5)
                                       (set! rdi foo.8.1)
                                       (set! r15 tmp-ra.6)
                                       (jump L.fn.0.1 rbp r15 rdi rsi rdx rcx r8)))))
                         (begin
                           (set! tmp-ra.7 r15)
                           (begin
                             (begin
                               (set! rax -167685894)
                               (jump tmp-ra.7 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.20 r15)
                                   (begin
                                     (set! bar.0.2 rdi)
                                     (set! foobar.8.1 rsi)
                                     (begin
                                       (set! r9 foobar.8.1)
                                       (set! r8 foobar.8.1)
                                       (set! rcx bar.0.2)
                                       (set! rdx foobar.8.1)
                                       (set! rsi bar.0.2)
                                       (set! rdi foobar.8.1)
                                       (set! r15 tmp-ra.20)
                                       (jump L.fn.2.3 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.21 r15)
                             (begin
                               (set! foo.6.7 rdi)
                               (set! foobar.2.6 rsi)
                               (set! foobar.1.5 rdx)
                               (set! bat.3.4 rcx)
                               (set! foobar.5.3 r8)
                               (begin
                                 (begin
                                   (begin
                                     (set! foobar.7.10 foobar.5.3))
                                   (set! foobar.2.9 (- foobar.1.5 foobar.2.6))
                                   (begin
                                     (set! bar.0.13 foobar.7.10)
                                     (set! bar.9.12 foobar.2.9)
                                     (set! foobar.1.11 foobar.1.5)
                                     (set! bar.0.8 bat.3.4)))
                                 (begin
                                   (set! r8 foobar.5.3)
                                   (set! rcx bat.3.4)
                                   (set! rdx foobar.5.3)
                                   (set! rsi -9223372036854775808)
                                   (set! rdi bat.3.4)
                                   (set! r15 tmp-ra.21)
                                   (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8))))))
                         (define L.fn.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.22 r15)
                             (begin
                               (set! foobar.1.19 rdi)
                               (set! foobar.5.18 rsi)
                               (set! foobar.2.17 rdx)
                               (set! ball.4.16 rcx)
                               (set! foobar.8.15 r8)
                               (set! foobar.7.14 r9)
                               (begin
                                 (set! rsi ball.4.16)
                                 (set! rdi foobar.1.19)
                                 (set! r15 tmp-ra.22)
                                 (jump L.func.0.1 rbp r15 rdi rsi)))))
                         (begin
                           (set! tmp-ra.23 r15)
                           (begin
                             (set! rax (+ 1962527269 9223372036854775807))
                             (jump tmp-ra.23 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.2 r15)
                                   (begin
                                     (set! bat.0.1 rdi)
                                     (if (if (true)
                                             (not (> bat.0.1 bat.0.1))
                                             (>= 2020417677 -9223372036854775808))
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
                                           (jump L.func.0.1 rbp r15 rdi))))))
                         (begin
                           (set! tmp-ra.3 r15)
                           (begin
                             (set! rdi 733499244)
                             (set! r15 tmp-ra.3)
                             (jump L.func.0.1 rbp r15 rdi)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.proc.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.22 r15)
                                   (begin
                                     (set! ball.3.4 rdi)
                                     (set! foo.8.3 rsi)
                                     (set! foobar.4.2 rdx)
                                     (set! foobar.1.1 rcx)
                                     (begin
                                       (set! r8 foo.8.3)
                                       (set! rcx 1)
                                       (set! rdx 0)
                                       (set! rsi -9223372036854775808)
                                       (set! rdi 835392363)
                                       (set! r15 tmp-ra.22)
                                       (jump L.fn.1.2 rbp r15 rdi rsi rdx rcx r8)))))
                         (define L.fn.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.23 r15)
                             (begin
                               (set! bat.0.9 rdi)
                               (set! foobar.7.8 rsi)
                               (set! bar.2.7 rdx)
                               (set! bat.6.6 rcx)
                               (set! foobar.4.5 r8)
                               (begin
                                 (set! rdi foobar.7.8)
                                 (set! r15 tmp-ra.23)
                                 (jump L.x.2.3 rbp r15 rdi)))))
                         (define L.x.2.3
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.24 r15)
                             (begin
                               (set! foobar.7.10 rdi)
                               (begin
                                 (begin
                                   (begin
                                     (return-point L.rp.4
                                                   (begin
                                                     (set! rcx foobar.7.10)
                                                     (set! rdx foobar.7.10)
                                                     (set! rsi foobar.7.10)
                                                     (set! rdi foobar.7.10)
                                                     (set! r15 L.rp.4)
                                                     (jump L.proc.0.1 rbp r15 rdi rsi rdx rcx)))
                                     (set! bat.0.12 rax))
                                   (set! foo.9.11 (- bat.0.12 bat.0.12)))
                                 (begin
                                   (if (<= foo.9.11 foobar.7.10)
                                       (set! foo.9.15 foo.9.11)
                                       (set! foo.9.15 foobar.7.10))
                                   (begin
                                     (set! bat.0.18 foo.9.11)
                                     (set! foobar.7.17 foobar.7.10)
                                     (set! foobar.1.16 foo.9.11)
                                     (set! foobar.7.14 bat.0.18))
                                   (set! ball.3.13 foobar.7.10)
                                   (begin
                                     (set! rdi ball.3.13)
                                     (set! r15 tmp-ra.24)
                                     (jump L.x.2.3 rbp r15 rdi)))))))
                         (begin
                           (set! tmp-ra.25 r15)
                           (begin
                             (set! ball.3.21 1830309714)
                             (set! foo.8.20 -9223372036854775808)
                             (set! foobar.7.19 -9223372036854775808)
                             (begin
                               (set! rax ball.3.21)
                               (jump tmp-ra.25 rbp rax))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.10 r15)
                                   (begin
                                     (set! foobar.0.5 rdi)
                                     (set! foo.5.4 rsi)
                                     (set! bat.6.3 rdx)
                                     (set! bat.3.2 rcx)
                                     (set! bar.7.1 r8)
                                     (begin
                                       (set! rax bat.3.2)
                                       (jump tmp-ra.10 rbp rax)))))
                         (define L.func.1.2
                           ((new-frames (())))
                           (begin
                             (set! tmp-ra.11 r15)
                             (begin
                               (begin
                                 (set! bat.2.8 (- -620373304 -68719063))
                                 (set! bat.3.7 0)
                                 (begin
                                   (return-point L.rp.4
                                                 (begin
                                                   (set! r15 L.rp.4)
                                                   (jump L.func.1.2 rbp r15)))
                                   (set! foobar.4.6 rax))
                                 (begin
                                   (set! rax bat.3.7)
                                   (jump tmp-ra.11 rbp rax))))))
                         (define L.x.2.3
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.12 r15)
                             (begin
                               (set! bar.8.9 rdi)
                               (begin
                                 (set! r15 tmp-ra.12)
                                 (jump L.func.1.2 rbp r15)))))
                         (begin
                           (set! tmp-ra.13 r15)
                           (begin
                             (set! rax -575594324)
                             (jump tmp-ra.13 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.x.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.12 r15)
                                   (begin
                                     (set! foo.3.6 rdi)
                                     (set! foobar.0.5 rsi)
                                     (set! bat.2.4 rdx)
                                     (set! bar.7.3 rcx)
                                     (set! bar.5.2 r8)
                                     (set! bat.6.1 r9)
                                     (begin
                                       (set! rsi 1)
                                       (set! rdi bar.7.3)
                                       (set! r15 tmp-ra.12)
                                       (jump L.x.1.2 rbp r15 rdi rsi)))))
                         (define L.x.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.13 r15)
                             (begin
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
                                     (jump tmp-ra.13 rbp rax))))))
                         (begin
                           (set! tmp-ra.14 r15)
                           (if (not (= 0 -844906965))
                               (begin
                                 (set! foo.3.11 996590913)
                                 (set! bat.6.10 299367411)
                                 (set! foobar.4.9 -9223372036854775808)
                                 (begin
                                   (set! rax foo.3.11)
                                   (jump tmp-ra.14 rbp rax)))
                               (if (> 894536270 1910216157)
                                   (begin
                                     (set! rax 1)
                                     (jump tmp-ra.14 rbp rax))
                                   (begin
                                     (set! rax 1)
                                     (jump tmp-ra.14 rbp rax)))))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.tmp.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.19 r15)
                                   (begin
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
                                           (begin
                                             (set! bar.4.6 bat.6.5))
                                           (begin
                                             (set! bat.2.8 foobar.8.3)
                                             (begin
                                               (set! rax bat.2.8)
                                               (jump tmp-ra.19 rbp rax))))))))
                         (define L.tmp.1.2
                           ((new-frames (() () ())))
                           (begin
                             (set! tmp-ra.20 r15)
                             (begin
                               (set! bar.3.15 rdi)
                               (set! foo.1.14 rsi)
                               (set! foobar.8.13 rdx)
                               (set! bat.0.12 rcx)
                               (set! bat.2.11 r8)
                               (set! foobar.7.10 r9)
                               (set! bat.6.9 fv0)
                               (begin
                                 (if (not (> 1242010444 foobar.8.13))
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
                                 (set! bat.0.17 (* bat.6.9 foo.1.14))
                                 (begin
                                   (return-point L.rp.5
                                                 (begin
                                                   (set! r8 bat.2.11)
                                                   (set! rcx bat.2.11)
                                                   (set! rdx 0)
                                                   (set! rsi foo.1.14)
                                                   (set! rdi foo.1.14)
                                                   (set! r15 L.rp.5)
                                                   (jump L.tmp.0.1 rbp r15 rdi rsi rdx rcx r8)))
                                   (set! bar.3.16 rax))
                                 (begin
                                   (set! fv0 foobar.7.10)
                                   (set! r9 foobar.8.18)
                                   (set! r8 bat.6.9)
                                   (set! rcx bar.3.16)
                                   (set! rdx 1)
                                   (set! rsi foo.1.14)
                                   (set! rdi foobar.7.10)
                                   (set! r15 tmp-ra.20)
                                   (jump L.tmp.1.2 rbp r15 rdi rsi rdx rcx r8 r9 fv0))))))
                         (begin
                           (set! tmp-ra.21 r15)
                           (if (not (< 1973720366 1864083813))
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
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.4 r15)
                                 (begin
                                   (set! ball.8.3 1521957632)
                                   (begin
                                     (set! bat.6.2 -9223372036854775808))
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
                                             (jump tmp-ra.4 rbp rax))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.9 r15)
                                 (begin
                                   (set! ball.1.1 -9223372036854775808)
                                   (begin
                                     (begin
                                       (set! foobar.8.7 0)
                                       (set! bar.7.6 ball.1.1)
                                       (set! ball.9.5 ball.1.1)
                                       (set! bar.0.4 ball.9.5))
                                     (set! foo.3.3 ball.1.1)
                                     (if (> ball.1.1 ball.1.1)
                                         (set! foo.4.2 ball.1.1)
                                         (set! foo.4.2 ball.1.1))
                                     (begin
                                       (set! ball.9.8 bar.0.4)
                                       (begin
                                         (set! rax ball.1.1)
                                         (jump tmp-ra.9 rbp rax))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.12 r15)
                                 (begin
                                   (set! foo.7.1 1)
                                   (begin
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
                                     (set! foobar.1.2 (+ foo.7.1 foo.7.1))
                                     (begin
                                       (begin
                                         (set! foobar.3.11 foobar.3.4)
                                         (set! foobar.1.10 1648274049)
                                         (begin
                                           (set! rax foo.7.1)
                                           (jump tmp-ra.12 rbp rax)))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.func.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.3 r15)
                                   (begin
                                     (set! bat.7.2 rdi)
                                     (set! bat.8.1 rsi)
                                     (begin
                                       (set! rsi bat.8.1)
                                       (set! rdi 1)
                                       (set! r15 tmp-ra.3)
                                       (jump L.func.0.1 rbp r15 rdi rsi)))))
                         (begin
                           (set! tmp-ra.4 r15)
                           (begin
                             (set! rax 0)
                             (jump tmp-ra.4 rbp rax)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (> -9223372036854775808 526950868)
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump tmp-ra.1 rbp rax))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (define L.fn.0.1
                                 ((new-frames ()))
                                 (begin
                                   (set! tmp-ra.16 r15)
                                   (begin
                                     (set! foobar.6.5 rdi)
                                     (set! ball.3.4 rsi)
                                     (set! ball.9.3 rdx)
                                     (set! bar.7.2 rcx)
                                     (set! bat.4.1 r8)
                                     (begin
                                       (set! r9 ball.3.4)
                                       (set! r8 bar.7.2)
                                       (set! rcx bat.4.1)
                                       (set! rdx 1064830001)
                                       (set! rsi ball.3.4)
                                       (set! rdi bat.4.1)
                                       (set! r15 tmp-ra.16)
                                       (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
                         (define L.func.1.2
                           ((new-frames ()))
                           (begin
                             (set! tmp-ra.17 r15)
                             (begin
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
                                       (if (> 0 ball.3.6)
                                           (<= 1 ball.9.8)
                                           (>= 529266316 foo.8.7)))
                                   (if (begin
                                         (set! bat.4.12 foo.5.9)
                                         (<= ball.9.8 bat.4.12))
                                       (begin
                                         (set! foo.8.13 ball.3.6)
                                         (begin
                                           (set! rax ball.3.6)
                                           (jump tmp-ra.17 rbp rax)))
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
                                     (begin
                                       (set! ball.3.15 foo.5.9)
                                       (set! ball.1.14 ball.3.15))
                                     (begin
                                       (set! r9 foo.5.9)
                                       (set! r8 ball.1.14)
                                       (set! rcx foo.5.9)
                                       (set! rdx ball.3.6)
                                       (set! rsi ball.3.6)
                                       (set! rdi ball.1.14)
                                       (set! r15 tmp-ra.17)
                                       (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))))
                         (begin
                           (set! tmp-ra.18 r15)
                           (begin
                             (set! r9 0)
                             (set! r8 0)
                             (set! rcx 1)
                             (set! rdx 1)
                             (set! rsi -1337458253)
                             (set! rdi 9223372036854775807)
                             (set! r15 tmp-ra.18)
                             (jump L.func.1.2 rbp r15 rdi rsi rdx rcx r8 r9)))))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.5 r15)
                                 (if (if (!= 9223372036854775807 2124101395)
                                         (true)
                                         (not (<= 9223372036854775807 0)))
                                     (begin
                                       (begin
                                         (set! bat.2.3 -9223372036854775808)
                                         (set! bat.2.2 -9223372036854775808))
                                       (set! bar.8.1 (* 9223372036854775807 -9223372036854775808))
                                       (begin
                                         (set! rax bat.2.2)
                                         (jump tmp-ra.5 rbp rax)))
                                     (begin
                                       (set! bar.9.4 (+ 1865158198 1))
                                       (if (> bar.9.4 bar.9.4)
                                           (begin
                                             (set! rax bar.9.4)
                                             (jump tmp-ra.5 rbp rax))
                                           (begin
                                             (set! rax bar.9.4)
                                             (jump tmp-ra.5 rbp rax))))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (if (>= 1069510162 -9223372036854775808)
                                     (begin
                                       (set! rax 1)
                                       (jump tmp-ra.1 rbp rax))
                                     (begin
                                       (set! rax 323863587)
                                       (jump tmp-ra.1 rbp rax))))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (begin
                                   (set! rax (* 379335310 0))
                                   (jump tmp-ra.1 rbp rax)))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.1 r15)
                                 (begin
                                   (set! rax 0)
                                   (jump tmp-ra.1 rbp rax)))
                         ))
  (check-by-interp-v6 '(module ((new-frames ()))
                               (begin
                                 (set! tmp-ra.6 r15)
                                 (begin
                                   (set! bat.2.2 (- -9223372036854775808 0))
                                   (set! bat.0.1 -9223372036854775808)
                                   (begin
                                     (set! ball.3.5 1969620648)
                                     (set! foo.5.4 bat.2.2)
                                     (set! bat.0.3 bat.0.1)
                                     (begin
                                       (set! rax foo.5.4)
                                       (jump tmp-ra.6 rbp rax)))))
                         ))

  ;;

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp '(module (define L.L.func.0.1.4
                              (begin
                                0))
                            (define L.L.tmp.1.2.5
                              (begin
                                (set! foo.2.1.5 rdi)
                                (begin
                                  (jump L.L.func.0.1.4 rbp))))
                      (define L.L.func.2.3.6
                        (begin
                          (begin
                            (if (true)
                                (begin
                                  (set! foo.2.3.7 1)
                                  (set! bar.4.2.6 foo.2.3.7))
                                (set! bar.4.2.6 (* -9223372036854775808 1806293504)))
                            (begin
                              (if (> 1 0)
                                  (set! foobar.6.4.8 156890122)
                                  (set! foobar.6.4.8 bar.4.2.6))
                              0))))
                      (begin
                        (set! rdi -1860620182)
                        (jump L.L.tmp.1.2.5 rbp rdi))))
  (check-by-interp
   '(module (define L.L.tmp.0.1.4
              (begin
                (if (>= 9223372036854775807 -1020514810)
                    (begin
                      (jump L.L.x.2.3.6 rbp))
                    (* 1 0))))
            (define L.L.func.1.2.5
              (begin
                (begin
                  (set! bar.1.1.5 -9223372036854775808)
                  (if (not (> 9223372036854775807 0)) 1309557052 bar.1.1.5))))
      (define L.L.x.2.3.6
        (begin
          (if (if (true)
                  (not (> 0 1))
                  (true))
              (if (> 0 0)
                  (if (< 9223372036854775807 9223372036854775807) 9223372036854775807 -260353756)
                  (begin
                    (set! ball.0.2.6 0)
                    ball.0.2.6))
              (begin
                (if (!= -302047143 0)
                    (set! bar.3.3.7 9223372036854775807)
                    (set! bar.3.3.7 102036653))
                (if (= 0 bar.3.3.7) bar.3.3.7 -362331747)))))
      (begin
        (set! ball.0.4.8 (* -9223372036854775808 -9223372036854775808))
        (+ ball.0.4.8 0))))
  (check-by-interp '(module (define L.L.proc.0.1.4
                              (begin
                                (set! ball.6.1.5 rdi)
                                (begin
                                  (jump L.L.func.1.2.5 rbp))))
                            (define L.L.func.1.2.5
                              (begin
                                (* 1 0)))
                      (define L.L.fn.2.3.6
                        (begin
                          (set! ball.3.2.6 rdi)
                          (if (true)
                              (begin
                                (if (<= -2033705372 965540822)
                                    (set! bat.0.3.7 -1853172774)
                                    (set! bat.0.3.7 1133506028))
                                (begin
                                  (set! foo.4.4.8 1)
                                  1236904416))
                              (begin
                                (jump L.L.func.1.2.5 rbp)))))
                      (begin
                        (set! rdi 1)
                        (jump L.L.proc.0.1.4 rbp rdi))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (begin
                                  (if (false)
                                      (set! bat.9.1 1)
                                      (begin
                                        (set! foo.5.2 1)
                                        (set! bat.9.1 1)))
                                  (if (if (>= 9223372036854775807 -9223372036854775808)
                                          (= -248968641 9223372036854775807)
                                          (!= bat.9.1 -9223372036854775808))
                                      (begin
                                        (set! ball.4.3 bat.9.1)
                                        1622965009)
                                      (begin
                                        (set! foo.5.4 bat.9.1)
                                        bat.9.1)))))
                            (if (false)
                                (if (>= 995853130 1) 1 -9223372036854775808)
                                (begin
                                  (jump L.fn.0.1 rbp)))
                      ))
  (check-by-interp '(module (+ -9223372036854775808 -1465538260)))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (begin
                                  (set! bar.2.1 (+ 1 9223372036854775807))
                                  (begin
                                    (begin
                                      (set! foo.1.3 bar.2.1)
                                      (set! foo.8.2 foo.1.3))
                                    bar.2.1))))
                            (define L.func.1.2
                              (begin
                                (begin
                                  (if (begin
                                        (set! foo.8.5 1)
                                        (< 1 foo.8.5))
                                      (begin
                                        (set! foo.1.6 406779451)
                                        (set! ball.3.4 1200977699))
                                      (begin
                                        (set! foo.8.7 0)
                                        (set! ball.3.4 foo.8.7)))
                                  (* ball.3.4 ball.3.4))))
                      (begin
                        (set! bat.5.8 1)
                        (begin
                          (set! ball.9.9 0)
                          bat.5.8))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! ball.1.2 rdi)
                                (set! foo.0.1 rsi)
                                (begin
                                  (jump L.tmp.1.2 rbp))))
                            (define L.tmp.1.2
                              (begin
                                (if (if (if (<= -765445006 0)
                                            (!= 0 -7399083)
                                            (<= 9223372036854775807 1))
                                        (false)
                                        (true))
                                    (begin
                                      (begin
                                        (set! bar.5.4 -9223372036854775808)
                                        (set! ball.4.3 bar.5.4))
                                      (if (> ball.4.3 ball.4.3) -9223372036854775808 ball.4.3))
                                    (begin
                                      (if (>= 1 0)
                                          (set! foobar.9.5 -9223372036854775808)
                                          (set! foobar.9.5 -9223372036854775808))
                                      (if (= 0 foobar.9.5) 0 9223372036854775807)))))
                      (define L.func.2.3
                        (begin
                          (set! ball.4.7 rdi)
                          (set! ball.6.6 rsi)
                          (begin
                            (jump L.tmp.1.2 rbp))))
                      (if (<= 0 1) -1271132888 2101306416)))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! bar.8.1 rdi)
                                (begin
                                  (if (false)
                                      (begin
                                        (set! bat.4.3 bar.8.1)
                                        (set! bat.7.2 1733388107))
                                      (begin
                                        (set! foobar.2.4 -818241658)
                                        (set! bat.7.2 foobar.2.4)))
                                  (begin
                                    (set! bat.3.5 (* -1769976594 bat.7.2))
                                    (if (!= bar.8.1 bar.8.1) 1 bar.8.1)))))
                            (if (<= 0 0) 1764584349 -9223372036854775808)
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! ball.3.1 rdi)
                                (if (not (false))
                                    (begin
                                      (jump L.x.1.2 rbp))
                                    (begin
                                      (begin
                                        (set! bat.9.3 ball.3.1)
                                        (set! foobar.4.2 9223372036854775807))
                                      (+ -9223372036854775808 ball.3.1)))))
                            (define L.x.1.2
                              (begin
                                1))
                      (begin
                        (begin
                          (set! ball.1.5 453798193)
                          (set! foobar.4.4 ball.1.5))
                        (if (>= 9223372036854775807 foobar.4.4) 0 -1617493587))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! bat.8.1 rdi)
                                (if (begin
                                      (set! bat.2.2 (* 9223372036854775807 bat.8.1))
                                      (true))
                                    (if (true)
                                        (if (< bat.8.1 -9223372036854775808) bat.8.1 bat.8.1)
                                        (if (= -9223372036854775808 bat.8.1) bat.8.1 bat.8.1))
                                    (begin
                                      (jump L.proc.1.2 rbp)))))
                            (define L.proc.1.2
                              (begin
                                (begin
                                  (set! rdi 954069433)
                                  (jump L.func.0.1 rbp rdi))))
                      (if (false)
                          (* 1337690701 9223372036854775807)
                          (begin
                            (jump L.proc.1.2 rbp)))))
  (check-by-interp '(module ()
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
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! foo.9.5 rdi)
                                (set! foo.2.4 rsi)
                                (set! bar.1.3 rdx)
                                (set! bat.7.2 rcx)
                                (set! foobar.4.1 r8)
                                -1458025903))
                            (begin
                              (set! r8 0)
                              (set! rcx -9223372036854775808)
                              (set! rdx -808937821)
                              (set! rsi 1)
                              (set! rdi -9223372036854775808)
                              (jump L.func.0.1 rbp rdi rsi rdx rcx r8))
                      ))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! ball.6.4 rdi)
                                (set! bat.5.3 rsi)
                                (set! bar.8.2 rdx)
                                (set! foobar.0.1 rcx)
                                (begin
                                  (set! bat.2.5 ball.6.4)
                                  (if (if (<= -9223372036854775808 bat.5.3)
                                          (>= -9223372036854775808 ball.6.4)
                                          (>= bat.5.3 2025307007))
                                      (+ bat.2.5 9223372036854775807)
                                      (if (<= bat.5.3 -9223372036854775808) 9223372036854775807 0)))))
                            (begin
                              (set! ball.6.6 0)
                              ball.6.6)
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! ball.6.2 rdi)
                                (set! foobar.3.1 rsi)
                                (if (= 0 foobar.3.1)
                                    (+ -9223372036854775808 -9223372036854775808)
                                    (if (if (< ball.6.2 ball.6.2)
                                            (<= foobar.3.1 foobar.3.1)
                                            (= foobar.3.1 ball.6.2))
                                        (+ foobar.3.1 foobar.3.1)
                                        (if (= 1 foobar.3.1) ball.6.2 foobar.3.1)))))
                            (define L.x.1.2
                              (begin
                                (set! bar.0.3 rdi)
                                (begin
                                  (begin
                                    (begin
                                      (set! bat.2.6 1757280127)
                                      (set! bat.9.5 bat.2.6))
                                    (begin
                                      (set! ball.5.7 1)
                                      (set! ball.1.4 -1128483887)))
                                  (if (begin
                                        (set! foo.7.8 bar.0.3)
                                        (> foo.7.8 foo.7.8))
                                      ball.1.4
                                      (+ ball.1.4 bar.0.3)))))
                      (define L.fn.2.3
                        (begin
                          (if (begin
                                (set! foobar.8.9 (+ -9223372036854775808 -1421853645))
                                (not (>= 0 -1400373009)))
                              (+ -167927521 1)
                              (begin
                                (set! ball.1.10 (* 1041085683 9223372036854775807))
                                (begin
                                  (set! foo.4.11 ball.1.10)
                                  770292232)))))
                      (begin
                        (set! rdi 1840464414)
                        (jump L.x.1.2 rbp rdi))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! ball.4.3 rdi)
                                (set! foo.7.2 rsi)
                                (set! ball.2.1 rdx)
                                (begin
                                  (set! rdx foo.7.2)
                                  (set! rsi ball.2.1)
                                  (set! rdi 9223372036854775807)
                                  (jump L.proc.0.1 rbp rdi rsi rdx))))
                            (define L.func.1.2
                              (begin
                                (set! ball.1.9 rdi)
                                (set! bat.0.8 rsi)
                                (set! foo.7.7 rdx)
                                (set! ball.4.6 rcx)
                                (set! foobar.6.5 r8)
                                (set! bar.3.4 r9)
                                (begin
                                  (begin
                                    (set! ball.4.11 foo.7.7)
                                    (begin
                                      (set! foobar.5.12 ball.1.9)
                                      (set! bar.3.10 -9223372036854775808)))
                                  (begin
                                    (set! rdx bar.3.10)
                                    (set! rsi -780648786)
                                    (set! rdi bar.3.10)
                                    (jump L.proc.0.1 rbp rdi rsi rdx)))))
                      (begin
                        (set! bat.0.13 -579691794)
                        953357957)))
  (check-by-interp '(module (begin
                              (begin
                                (set! ball.2.2 9223372036854775807)
                                (set! bar.5.1 -546026276))
                              (if (!= bar.5.1 1) 9223372036854775807 2063023986))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! foo.8.2 rdi)
                                (set! bar.2.1 rsi)
                                (if (not (begin
                                           (set! foo.8.3 foo.8.2)
                                           (= foo.8.3 0)))
                                    (begin
                                      (set! foobar.6.4 (+ foo.8.2 0))
                                      (* 0 9223372036854775807))
                                    (begin
                                      (set! bat.7.5 (* 0 bar.2.1))
                                      (if (!= bat.7.5 -9223372036854775808) bar.2.1 0)))))
                            (if (= 9223372036854775807 -315897602) 1 -9223372036854775808)
                      ))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! foobar.3.2 rdi)
                                (set! ball.7.1 rsi)
                                (begin
                                  (begin
                                    (set! bat.4.4 (* 1 9223372036854775807))
                                    (set! bar.9.3 (+ -9223372036854775808 bat.4.4)))
                                  (begin
                                    (set! bat.4.5 9223372036854775807)
                                    (if (!= 1 bar.9.3) 9223372036854775807 ball.7.1)))))
                            (define L.x.1.2
                              (begin
                                (set! bat.2.6 rdi)
                                (begin
                                  (begin
                                    (set! bat.4.8 (+ -1410706204 bat.2.6))
                                    (begin
                                      (set! bat.2.9 1)
                                      (set! foobar.3.7 -9223372036854775808)))
                                  (* -152436426 0))))
                      (define L.proc.2.3
                        (begin
                          (set! foo.5.13 rdi)
                          (set! ball.7.12 rsi)
                          (set! foo.0.11 rdx)
                          (set! ball.8.10 rcx)
                          (begin
                            (set! foobar.1.14 foo.5.13)
                            (+ 956544411 1))))
                      (+ 979460199 -1697959716)))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! foobar.1.6 rdi)
                                (set! bar.0.5 rsi)
                                (set! foobar.2.4 rdx)
                                (set! ball.8.3 rcx)
                                (set! bat.3.2 r8)
                                (set! bar.5.1 r9)
                                (begin
                                  (if (begin
                                        (set! bar.7.8 -669410514)
                                        (< bat.3.2 bat.3.2))
                                      (set! bar.9.7 (+ bar.5.1 ball.8.3))
                                      (set! bar.9.7 foobar.2.4))
                                  (begin
                                    (begin
                                      (set! foo.4.10 ball.8.3)
                                      (set! ball.6.9 1))
                                    (if (<= foobar.2.4 1) 9223372036854775807 bat.3.2)))))
                            (begin
                              (set! r9 9223372036854775807)
                              (set! r8 -1891086346)
                              (set! rcx -1371550930)
                              (set! rdx 0)
                              (set! rsi 9223372036854775807)
                              (set! rdi 0)
                              (jump L.proc.0.1 rbp rdi rsi rdx rcx r8 r9))
                      ))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! bat.7.7 rdi)
                                (set! ball.9.6 rsi)
                                (set! foobar.3.5 rdx)
                                (set! ball.5.4 rcx)
                                (set! ball.4.3 r8)
                                (set! bar.0.2 r9)
                                (set! ball.2.1 fv0)
                                (if (not (if (>= 388494724 ball.9.6)
                                             (> ball.5.4 -9223372036854775808)
                                             (< foobar.3.5 ball.5.4)))
                                    (if (<= ball.4.3 bar.0.2)
                                        0
                                        (begin
                                          (set! ball.4.8 ball.5.4)
                                          1887946265))
                                    foobar.3.5)))
                            (define L.tmp.1.2
                              (begin
                                (set! bat.7.14 rdi)
                                (set! ball.9.13 rsi)
                                (set! ball.5.12 rdx)
                                (set! foo.6.11 rcx)
                                (set! bar.0.10 r8)
                                (set! ball.2.9 r9)
                                (if (true)
                                    (* foo.6.11 9223372036854775807)
                                    (if (begin
                                          (set! foobar.3.15 1)
                                          (<= bar.0.10 ball.5.12))
                                        (begin
                                          (set! ball.9.16 -9223372036854775808)
                                          ball.9.16)
                                        (begin
                                          (set! bat.7.17 1)
                                          1)))))
                      (define L.tmp.2.3
                        (begin
                          (set! bat.7.23 rdi)
                          (set! ball.2.22 rsi)
                          (set! foo.6.21 rdx)
                          (set! foobar.3.20 rcx)
                          (set! bar.8.19 r8)
                          (set! bar.0.18 r9)
                          (begin
                            (if (begin
                                  (set! ball.2.25 258314756)
                                  (!= bar.8.19 0))
                                (set! foobar.3.24 bar.8.19)
                                (begin
                                  (set! foo.6.26 -1809848824)
                                  (set! foobar.3.24 9223372036854775807)))
                            (if (< 1525021420 1)
                                (begin
                                  (set! r9 1067478227)
                                  (set! r8 -768559462)
                                  (set! rcx foo.6.21)
                                  (set! rdx -1256996529)
                                  (set! rsi 1)
                                  (set! rdi foobar.3.24)
                                  (jump L.tmp.1.2 rbp rdi rsi rdx rcx r8 r9))
                                (if (> 389818959 882297114) bar.8.19 ball.2.22)))))
                      (begin
                        (set! bar.0.27 1)
                        1)))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! foo.1.7 rdi)
                                (set! ball.6.6 rsi)
                                (set! bar.9.5 rdx)
                                (set! bat.3.4 rcx)
                                (set! ball.8.3 r8)
                                (set! bat.0.2 r9)
                                (set! ball.7.1 fv0)
                                (* bat.3.4 bat.0.2)))
                            (define L.func.1.2
                              (begin
                                (set! foo.1.12 rdi)
                                (set! bar.2.11 rsi)
                                (set! foo.5.10 rdx)
                                (set! bat.3.9 rcx)
                                (set! bar.9.8 r8)
                                (begin
                                  (set! bat.3.13 1)
                                  9223372036854775807)))
                      (define L.fn.2.3
                        (begin
                          (set! ball.7.15 rdi)
                          (set! ball.8.14 rsi)
                          (begin
                            (if (>= ball.7.15 1)
                                (if (= ball.7.15 ball.7.15)
                                    (set! bat.3.16 ball.8.14)
                                    (set! bat.3.16 214741259))
                                (set! bat.3.16 (+ 1683358713 ball.8.14)))
                            (begin
                              (set! fv0 -2043460455)
                              (set! r9 ball.7.15)
                              (set! r8 9223372036854775807)
                              (set! rcx ball.7.15)
                              (set! rdx 0)
                              (set! rsi ball.8.14)
                              (set! rdi bat.3.16)
                              (jump L.tmp.0.1 rbp rdi rsi rdx rcx r8 r9 fv0)))))
                      (begin
                        (set! fv0 -9223372036854775808)
                        (set! r9 1)
                        (set! r8 -9223372036854775808)
                        (set! rcx 9223372036854775807)
                        (set! rdx -9223372036854775808)
                        (set! rsi -9223372036854775808)
                        (set! rdi -9223372036854775808)
                        (jump L.tmp.0.1 rbp rdi rsi rdx rcx r8 r9 fv0))))
  (check-by-interp '(module (if (true)
                                (+ 1 -9223372036854775808)
                                (if (> 1383245321 0) 0 1))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! ball.0.7 rdi)
                                (set! foobar.1.6 rsi)
                                (set! foo.3.5 rdx)
                                (set! foobar.2.4 rcx)
                                (set! foo.6.3 r8)
                                (set! foobar.5.2 r9)
                                (set! ball.8.1 fv0)
                                (begin
                                  (set! rdi 1)
                                  (jump L.x.4.5 rbp rdi))))
                            (define L.func.1.2
                              (begin
                                (begin
                                  (set! bar.9.8 9223372036854775807)
                                  (begin
                                    (set! foobar.1.9 bar.9.8)
                                    (if (>= -577997854 foobar.1.9) -9223372036854775808 bar.9.8)))))
                      (define L.fn.2.3
                        (begin
                          (begin
                            (set! ball.7.10 (+ 1 1))
                            (if (false)
                                ball.7.10
                                (begin
                                  (set! foobar.1.11 ball.7.10)
                                  1969054361)))))
                      (define L.x.3.4
                        (begin
                          (set! foobar.4.18 rdi)
                          (set! foobar.5.17 rsi)
                          (set! bar.9.16 rdx)
                          (set! foobar.2.15 rcx)
                          (set! ball.8.14 r8)
                          (set! foo.3.13 r9)
                          (set! ball.7.12 fv0)
                          (begin
                            (set! fv0 -9223372036854775808)
                            (set! r9 foobar.4.18)
                            (set! r8 9223372036854775807)
                            (set! rcx 25911444)
                            (set! rdx 9223372036854775807)
                            (set! rsi -9223372036854775808)
                            (set! rdi 0)
                            (jump L.func.6.7 rbp rdi rsi rdx rcx r8 r9 fv0))))
                      (define L.x.4.5
                        (begin
                          (set! foobar.4.19 rdi)
                          (begin
                            (set! fv0 foobar.4.19)
                            (set! r9 foobar.4.19)
                            (set! r8 foobar.4.19)
                            (set! rcx 1)
                            (set! rdx foobar.4.19)
                            (set! rsi foobar.4.19)
                            (set! rdi 0)
                            (jump L.x.3.4 rbp rdi rsi rdx rcx r8 r9 fv0))))
                      (define L.x.5.6
                        (begin
                          (set! foo.6.25 rdi)
                          (set! foo.3.24 rsi)
                          (set! foobar.4.23 rdx)
                          (set! bar.9.22 rcx)
                          (set! foobar.1.21 r8)
                          (set! foobar.5.20 r9)
                          (begin
                            (begin
                              (set! foobar.1.27 bar.9.22)
                              (begin
                                (set! foo.6.28 foo.3.24)
                                (set! foobar.5.26 foobar.1.27)))
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
                                1))))
                      (define L.func.6.7
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
                                    (> -1497437069 -9223372036854775808))
                                  (not (!= -1101838227 -1416967818)))
                              (begin
                                (set! ball.8.38 (+ foobar.2.36 foobar.2.36))
                                (begin
                                  (set! foobar.1.39 0)
                                  foobar.1.39))
                              1)))
                      (define L.fn.7.8
                        (begin
                          (if (true)
                              (if (not (> 0 100011461))
                                  (begin
                                    (set! r9 -1579752260)
                                    (set! r8 0)
                                    (set! rcx -1248542300)
                                    (set! rdx 0)
                                    (set! rsi 16140507)
                                    (set! rdi -9223372036854775808)
                                    (jump L.x.5.6 rbp rdi rsi rdx rcx r8 r9))
                                  (if (= -9223372036854775808 471889533) 1 0))
                              (if (if (>= 1 0)
                                      (>= 0 -9223372036854775808)
                                      (> 9223372036854775807 0))
                                  (begin
                                    (jump L.fn.7.8 rbp))
                                  (if (> 1 1) -444155079 9223372036854775807)))))
                      (if (begin
                            (if (begin
                                  (set! foobar.2.41 -9223372036854775808)
                                  (true))
                                (begin
                                  (if (> 9223372036854775807 0)
                                      (set! foobar.2.42 -1444900091)
                                      (set! foobar.2.42 -9223372036854775808))
                                  (set! foo.6.40 foobar.2.42))
                                (if (true)
                                    (begin
                                      (set! foobar.5.43 9223372036854775807)
                                      (set! foo.6.40 foobar.5.43))
                                    (if (= -9223372036854775808 1173781558)
                                        (set! foo.6.40 0)
                                        (set! foo.6.40 1))))
                            (if (true)
                                (begin
                                  (set! bar.9.44 0)
                                  (true))
                                (< 858519747 foo.6.40)))
                          1
                          (if (< 1 -1323259230)
                              (begin
                                (jump L.fn.2.3 rbp))
                              (begin
                                (jump L.fn.2.3 rbp))))))

  ;; !!!
  (check-match (select-instructions '(module (+ 2 2)))
               `(module ()
                        (begin
                          (set! ,tmp.1 2)
                          (set! ,tmp.1 (+ ,tmp.1 2))
                          (halt ,tmp.1))
                  )
               (aloc? tmp.1))
  (check-equal? (select-instructions '(module (begin
                                                (set! x.1 5)
                                                x.1)))
                '(module ()
                         (begin
                           (set! x.1 5)
                           (halt x.1))
                   ))
  (check-equal? (select-instructions '(module (begin
                                                (set! x.1 (+ 2 2))
                                                x.1)))
                '(module ()
                         (begin
                           (set! x.1 2)
                           (set! x.1 (+ x.1 2))
                           (halt x.1))
                   ))
  (check-match (select-instructions '(module (begin
                                               (set! x.1 2)
                                               (set! x.2 2)
                                               (+ x.1 x.2))))
               `(module ()
                        (begin
                          (set! x.1 2)
                          (set! x.2 2)
                          (set! ,tmp.2 x.1)
                          (set! ,tmp.2 (+ ,tmp.2 x.2))
                          (halt ,tmp.2))
                  )
               (aloc? tmp.2))
  ; custom select-instructions test
  ; This test carries on to the v4 tests
  ;; Begins are not flattened like in the interrogator, we have a seperate pass to flatten.
  (check-equal? (select-instructions '(module 5))
                '(module ()
                         (begin
                           (halt 5))
                   ))
  (check-match (select-instructions '(module (begin
                                               (set! x.1 1)
                                               (set! x.2 2)
                                               (set! x.3 3)
                                               x.1)))
               '(module ()
                        (begin
                          (set! x.1 1)
                          (set! x.2 2)
                          (set! x.3 3)
                          (halt x.1))
                  ))
  (check-equal? (select-instructions '(module (begin
                                                (set! x.1 1)
                                                (begin
                                                  (set! x.2 2)
                                                  (set! x.3 3))
                                                x.1)))
                '(module ()
                         (begin
                           (set! x.1 1)
                           (begin
                             (set! x.2 2)
                             (set! x.3 3))
                           (halt x.1))
                   ))
  (check-equal? (select-instructions '(module (begin
                                                (set! x.1 1)
                                                (begin
                                                  (set! x.2 2)
                                                  (set! x.3 1)
                                                  (set! x.3 (+ x.3 x.2)))
                                                x.1)))
                '(module ()
                         (begin
                           (set! x.1 1)
                           (begin
                             (set! x.2 2)
                             (set! x.3 1)
                             (set! x.3 (+ x.3 x.2)))
                           (halt x.1))
                   ))

  (check-equal? (select-instructions '(module (begin
                                                (set! x.1 1)
                                                (begin
                                                  (set! x.2 2)
                                                  (set! x.3 1)
                                                  (set! x.3 (+ x.3 x.2)))
                                                (if (true) x.1 x.3))))
                `(module ()
                         (begin
                           (set! x.1 1)
                           (begin
                             (set! x.2 2)
                             (set! x.3 1)
                             (set! x.3 (+ x.3 x.2)))
                           (if (true)
                               (begin
                                 (halt x.1))
                               (begin
                                 (halt x.3))))
                   ))

  (check-equal? (select-instructions '(module (if (true) 3 2)))
                `(module ()
                         (if (true)
                             (begin
                               (halt 3))
                             (begin
                               (halt 2)))
                   ))

  (check-equal? (select-instructions '(module (if (true)
                                                  (begin
                                                    (if (if (false)
                                                            (true)
                                                            (not (false)))
                                                        (begin
                                                          (set! x.1 3)
                                                          x.1)
                                                        (begin
                                                          (set! x.1 4)
                                                          x.1)))
                                                  2)))
                `(module ()
                         (if (true)
                             (begin
                               (if (if (false)
                                       (true)
                                       (not (false)))
                                   (begin
                                     (set! x.1 3)
                                     (halt x.1))
                                   (begin
                                     (set! x.1 4)
                                     (halt x.1))))
                             (begin
                               (halt 2)))
                   ))

  (check-match (select-instructions `(module (if (begin
                                                   (set! x.1 3)
                                                   (< 12 13))
                                                 2
                                                 3)))
               `(module ()
                        (if (begin
                              (set! x.1 3)
                              (begin
                                (set! ,tmp.1 12)
                                (< ,tmp.1 13)))
                            (begin
                              (halt 2))
                            (begin
                              (halt 3)))
                  ))

  (check-equal? (select-instructions '(module (if (begin
                                                    (set! x.1 3)
                                                    (< x.1 13))
                                                  2
                                                  3)))
                `(module ()
                         (if (begin
                               (set! x.1 3)
                               (< x.1 13))
                             (begin
                               (halt 2))
                             (begin
                               (halt 3)))
                   )))
