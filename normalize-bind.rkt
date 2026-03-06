#lang racket

(require cpsc411/compiler-lib)

(provide normalize-bind
         interp-imp-mf-lang)

(define (binop? op)
  (or (equal? op '+) (equal? op '*)))

(define (binop->fun op)
  (match op
    ['+ x64-add]
    ['* x64-mul]))
(define triv? (or/c aloc? int64?))

; imp-mf-lang-v3
; p	 	::=	 	(module tail)

; tail	 	::=	 	value
;  	|	 	(begin effect ... tail)

; value	 	::=	 	triv
;  	|	 	(binop triv triv)
;  	|	 	(begin effect ... value)

; effect	 	::=	 	(set! aloc value)
;  	|	 	(begin effect ... effect)

; triv	 	::=	 	int64
;  	|	 	aloc

; binop	 	::=	 	*
;  	|	 	+

; aloc	 	::=	 	aloc?

; int64	 	::=	 	int64?
(define (interp-imp-mf-lang iml)
  (define env (make-hash))
  (define (interp-triv triv)
    (match triv
      [(? int64?) triv]
      [(? aloc?) (hash-ref env triv)]))
  (define (interp-effect fx)
    (match fx
      [`(set! ,a ,val)
       #:when (aloc? a)
       (hash-set! env a (interp-value val))]
      [`(begin
          ,fxs ...
          ,fx)
       (for-each interp-effect fxs)
       (interp-effect fx)]))
  (define (interp-value val)
    (match val
      [`(begin
          ,fxs ...
          ,val)
       (for-each interp-effect fxs)
       (interp-value val)]
      [`(,(? binop? binop) ,(? triv? triv) ,(? triv? triv2))
       ((binop->fun binop) (interp-triv triv) (interp-triv triv2))]
      [(? triv?) (interp-triv val)]))
  (define (interp-tail tail)
    (match tail
      [`(begin
          ,fxs ...
          ,tail)
       (for-each interp-effect fxs)
       (interp-tail tail)]
      [_ (interp-value tail)]))
  (match iml
    [`(module ,tail) (interp-tail tail)]))
; --------------------
; Imp-cmf-lang-v3
; p	 	::=	 	(module tail)

; tail	 	::=	 	value
;  	|	 	(begin effect ... tail)

; value	 	::=	 	triv
;  	|	 	(binop triv triv)

; effect	 	::=	 	(set! aloc value)
;  	|	 	(begin effect ... effect)

; triv	 	::=	 	int64
;  	|	 	aloc

; binop	 	::=	 	*
;  	|	 	+

; aloc	 	::=	 	aloc?

; int64	 	::=	 	int64?

; imp-mf-lang-v4 -> imp-cmf-lang-v4
;; converts all `(set! aloc (begin ... val)) to `(begin ... (set! aloc val))
(define (normalize-bind mf)

  (define (normalize-definitions definition)
    (match definition
      [`(define ,label (lambda ,alocs ,tail))
       `(define ,label (lambda ,alocs ,(normalize-tail tail)))]))

  (define (normalize-triv triv)
    triv)

  (define (normalize-value value [k identity])
    (match value
      [`(begin
          ,effects ...
          ,value2)
       (normalize-value value2
                        (λ (nvalue)
                          `(begin
                             ,@(map normalize-effect effects)
                             ,(k nvalue))))]
      [`(,binop ,triv1 ,triv2) (k `(,binop ,(normalize-triv triv1) ,(normalize-triv triv2)))]
      [`(if ,pred ,value1 ,value2)
       (normalize-value value1
                        (λ (nvalue1)
                          (normalize-value value2
                                           (λ (nvalue2)
                                             `(if ,(normalize-pred pred)
                                                  ,(k nvalue1)
                                                  ,(k nvalue2))))))]
      [triv (k (normalize-triv triv))]))
  (define (normalize-pred pred)
    (match pred
      [`(not ,pred) `(not ,(normalize-pred pred))]
      [`(begin
          ,fxs ...
          ,pred)
       `(begin
          ,@(map normalize-effect fxs)
          ,(normalize-pred pred))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(normalize-pred pred1)
            ,(normalize-pred pred2)
            ,(normalize-pred pred3))]
      [_ pred]))
  (define (normalize-effect effect)
    (match effect
      ; need to convert value to triv or (binop triv triv) with begin isolated out
      [`(set! ,aloc ,value) (normalize-value value (λ (nvalue) `(set! ,aloc ,nvalue)))]
      [`(begin
          ,effects ...
          ,effect2)
       `(begin
          ,@(map normalize-effect effects)
          ,(normalize-effect effect2))]
      [`(if ,pred ,effect1 ,effect2)
       `(if ,(normalize-pred pred)
            ,(normalize-effect effect1)
            ,(normalize-effect effect2))]))
  ;; NOTE: tail = value in imp-mf-lang-v3
  (define (normalize-tail tail)
    (match tail
      [`(begin
          ,effects ...
          ,tail)
       `(begin
          ,@(map normalize-effect effects)
          ,(normalize-tail tail))]
      [`(,binop ,triv1 ,triv2) `(,binop ,(normalize-triv triv1) ,(normalize-triv triv2))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(normalize-pred pred)
            ,(normalize-tail tail1)
            ,(normalize-tail tail2))]
      ;; nothing special happens
      [`(call ,triv ,opand ...) tail]
      [triv (normalize-triv triv)]))
  (define (normalize-p p)
    (match p
      [`(module ,definitions ...
          ,tail)
       (append `(module) (map normalize-definitions definitions) (list (normalize-tail tail)))]))

  (normalize-p mf))

(module+ test
  (require rackunit
           cpsc411/langs/v5)
  (define-syntax-rule (check-by-interp imfl5)
    (check-equal? (interp-imp-mf-lang-v5 imfl5) (interp-proc-imp-cmf-lang-v5 (normalize-bind imfl5))))

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp '(module (define L.L.func.0.1.4 (lambda () 0))
                            (define L.L.tmp.1.2.5 (lambda (foo.2.1.5) (call L.L.func.0.1.4)))
                      (define L.L.func.2.3.6
                        (lambda ()
                          (begin
                            (set! bar.4.2.6
                                  (if (true)
                                      (begin
                                        (set! foo.2.3.7 1)
                                        foo.2.3.7)
                                      (* -9223372036854775808 1806293504)))
                            (begin
                              (set! foobar.6.4.8 (if (> 1 0) 156890122 bar.4.2.6))
                              0))))
                      (call L.L.tmp.1.2.5 -1860620182)))
  (check-by-interp
   '(module (define L.L.tmp.0.1.4
              (lambda ()
                (if (>= 9223372036854775807 -1020514810)
                    (call L.L.x.2.3.6)
                    (* 1 0))))
            (define L.L.func.1.2.5
              (lambda ()
                (begin
                  (set! bar.1.1.5 -9223372036854775808)
                  (if (not (> 9223372036854775807 0)) 1309557052 bar.1.1.5))))
      (define L.L.x.2.3.6
        (lambda ()
          (if (if (true)
                  (not (> 0 1))
                  (true))
              (if (> 0 0)
                  (if (< 9223372036854775807 9223372036854775807) 9223372036854775807 -260353756)
                  (begin
                    (set! ball.0.2.6 0)
                    ball.0.2.6))
              (begin
                (set! bar.3.3.7 (if (!= -302047143 0) 9223372036854775807 102036653))
                (if (= 0 bar.3.3.7) bar.3.3.7 -362331747)))))
      (begin
        (set! ball.0.4.8 (* -9223372036854775808 -9223372036854775808))
        (+ ball.0.4.8 0))))
  (check-by-interp '(module (define L.L.proc.0.1.4 (lambda (ball.6.1.5) (call L.L.func.1.2.5)))
                            (define L.L.func.1.2.5 (lambda () (* 1 0)))
                      (define L.L.fn.2.3.6
                        (lambda (ball.3.2.6)
                          (if (true)
                              (begin
                                (set! bat.0.3.7
                                      (if (<= -2033705372 965540822) -1853172774 1133506028))
                                (begin
                                  (set! foo.4.4.8 1)
                                  1236904416))
                              (call L.L.func.1.2.5))))
                      (call L.L.proc.0.1.4 1)))
  (check-by-interp '(module (define L.fn.0.1
                              (lambda ()
                                (begin
                                  (set! bat.9.1
                                        (if (false)
                                            1
                                            (begin
                                              (set! foo.5.2 1)
                                              1)))
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
                                (call L.fn.0.1))
                      ))
  (check-by-interp '(module (+ -9223372036854775808 -1465538260)))
  (check-by-interp '(module (define L.fn.0.1
                              (lambda ()
                                (begin
                                  (set! bar.2.1 (+ 1 9223372036854775807))
                                  (begin
                                    (set! foo.8.2
                                          (begin
                                            (set! foo.1.3 bar.2.1)
                                            foo.1.3))
                                    bar.2.1))))
                            (define L.func.1.2
                              (lambda ()
                                (begin
                                  (set! ball.3.4
                                        (if (begin
                                              (set! foo.8.5 1)
                                              (< 1 foo.8.5))
                                            (begin
                                              (set! foo.1.6 406779451)
                                              1200977699)
                                            (begin
                                              (set! foo.8.7 0)
                                              foo.8.7)))
                                  (* ball.3.4 ball.3.4))))
                      (begin
                        (set! bat.5.8 1)
                        (begin
                          (set! ball.9.9 0)
                          bat.5.8))))
  (check-by-interp '(module (define L.x.0.1 (lambda (ball.1.2 foo.0.1) (call L.tmp.1.2)))
                            (define L.tmp.1.2
                              (lambda ()
                                (if (if (if (<= -765445006 0)
                                            (!= 0 -7399083)
                                            (<= 9223372036854775807 1))
                                        (false)
                                        (true))
                                    (begin
                                      (set! ball.4.3
                                            (begin
                                              (set! bar.5.4 -9223372036854775808)
                                              bar.5.4))
                                      (if (> ball.4.3 ball.4.3) -9223372036854775808 ball.4.3))
                                    (begin
                                      (set! foobar.9.5
                                            (if (>= 1 0) -9223372036854775808 -9223372036854775808))
                                      (if (= 0 foobar.9.5) 0 9223372036854775807)))))
                      (define L.func.2.3 (lambda (ball.4.7 ball.6.6) (call L.tmp.1.2)))
                      (if (<= 0 1) -1271132888 2101306416)))
  (check-by-interp '(module (define L.proc.0.1
                              (lambda (bar.8.1)
                                (begin
                                  (set! bat.7.2
                                        (if (false)
                                            (begin
                                              (set! bat.4.3 bar.8.1)
                                              1733388107)
                                            (begin
                                              (set! foobar.2.4 -818241658)
                                              foobar.2.4)))
                                  (begin
                                    (set! bat.3.5 (* -1769976594 bat.7.2))
                                    (if (!= bar.8.1 bar.8.1) 1 bar.8.1)))))
                            (if (<= 0 0) 1764584349 -9223372036854775808)
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (lambda (ball.3.1)
                                (if (not (false))
                                    (call L.x.1.2)
                                    (begin
                                      (set! foobar.4.2
                                            (begin
                                              (set! bat.9.3 ball.3.1)
                                              9223372036854775807))
                                      (+ -9223372036854775808 ball.3.1)))))
                            (define L.x.1.2 (lambda () 1))
                      (begin
                        (set! foobar.4.4
                              (begin
                                (set! ball.1.5 453798193)
                                ball.1.5))
                        (if (>= 9223372036854775807 foobar.4.4) 0 -1617493587))))
  (check-by-interp '(module (define L.func.0.1
                              (lambda (bat.8.1)
                                (if (begin
                                      (set! bat.2.2 (* 9223372036854775807 bat.8.1))
                                      (true))
                                    (if (true)
                                        (if (< bat.8.1 -9223372036854775808) bat.8.1 bat.8.1)
                                        (if (= -9223372036854775808 bat.8.1) bat.8.1 bat.8.1))
                                    (call L.proc.1.2))))
                            (define L.proc.1.2 (lambda () (call L.func.0.1 954069433)))
                      (if (false)
                          (* 1337690701 9223372036854775807)
                          (call L.proc.1.2))))
  (check-by-interp '(module (if (not (> 1 9223372036854775807))
                                (if (>= 1 1197468889) 9223372036854775807 1)
                                1)))
  (check-by-interp '(module (define L.func.0.1
                              (lambda (foo.9.5 foo.2.4 bar.1.3 bat.7.2 foobar.4.1) -1458025903))
                            (call L.func.0.1 -9223372036854775808 1 -808937821 -9223372036854775808 0)
                      ))
  (check-by-interp '(module (define L.tmp.0.1
                              (lambda (ball.6.4 bat.5.3 bar.8.2 foobar.0.1)
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
                              (lambda (ball.6.2 foobar.3.1)
                                (if (= 0 foobar.3.1)
                                    (+ -9223372036854775808 -9223372036854775808)
                                    (if (if (< ball.6.2 ball.6.2)
                                            (<= foobar.3.1 foobar.3.1)
                                            (= foobar.3.1 ball.6.2))
                                        (+ foobar.3.1 foobar.3.1)
                                        (if (= 1 foobar.3.1) ball.6.2 foobar.3.1)))))
                            (define L.x.1.2
                              (lambda (bar.0.3)
                                (begin
                                  (set! ball.1.4
                                        (begin
                                          (set! bat.9.5
                                                (begin
                                                  (set! bat.2.6 1757280127)
                                                  bat.2.6))
                                          (begin
                                            (set! ball.5.7 1)
                                            -1128483887)))
                                  (if (begin
                                        (set! foo.7.8 bar.0.3)
                                        (> foo.7.8 foo.7.8))
                                      ball.1.4
                                      (+ ball.1.4 bar.0.3)))))
                      (define L.fn.2.3
                        (lambda ()
                          (if (begin
                                (set! foobar.8.9 (+ -9223372036854775808 -1421853645))
                                (not (>= 0 -1400373009)))
                              (+ -167927521 1)
                              (begin
                                (set! ball.1.10 (* 1041085683 9223372036854775807))
                                (begin
                                  (set! foo.4.11 ball.1.10)
                                  770292232)))))
                      (call L.x.1.2 1840464414)))
  (check-by-interp '(module (define L.proc.0.1
                              (lambda (ball.4.3 foo.7.2 ball.2.1)
                                (call L.proc.0.1 9223372036854775807 ball.2.1 foo.7.2)))
                            (define L.func.1.2
                              (lambda (ball.1.9 bat.0.8 foo.7.7 ball.4.6 foobar.6.5 bar.3.4)
                                (begin
                                  (set! bar.3.10
                                        (begin
                                          (set! ball.4.11 foo.7.7)
                                          (begin
                                            (set! foobar.5.12 ball.1.9)
                                            -9223372036854775808)))
                                  (call L.proc.0.1 bar.3.10 -780648786 bar.3.10))))
                      (begin
                        (set! bat.0.13 -579691794)
                        953357957)))
  (check-by-interp '(module (begin
                              (set! bar.5.1
                                    (begin
                                      (set! ball.2.2 9223372036854775807)
                                      -546026276))
                              (if (!= bar.5.1 1) 9223372036854775807 2063023986))))
  (check-by-interp '(module (define L.func.0.1
                              (lambda (foo.8.2 bar.2.1)
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
                              (lambda (foobar.3.2 ball.7.1)
                                (begin
                                  (set! bar.9.3
                                        (begin
                                          (set! bat.4.4 (* 1 9223372036854775807))
                                          (+ -9223372036854775808 bat.4.4)))
                                  (begin
                                    (set! bat.4.5 9223372036854775807)
                                    (if (!= 1 bar.9.3) 9223372036854775807 ball.7.1)))))
                            (define L.x.1.2
                              (lambda (bat.2.6)
                                (begin
                                  (set! foobar.3.7
                                        (begin
                                          (set! bat.4.8 (+ -1410706204 bat.2.6))
                                          (begin
                                            (set! bat.2.9 1)
                                            -9223372036854775808)))
                                  (* -152436426 0))))
                      (define L.proc.2.3
                        (lambda (foo.5.13 ball.7.12 foo.0.11 ball.8.10)
                          (begin
                            (set! foobar.1.14 foo.5.13)
                            (+ 956544411 1))))
                      (+ 979460199 -1697959716)))
  (check-by-interp
   '(module (define L.proc.0.1
              (lambda (foobar.1.6 bar.0.5 foobar.2.4 ball.8.3 bat.3.2 bar.5.1)
                (begin
                  (set! bar.9.7
                        (if (begin
                              (set! bar.7.8 -669410514)
                              (< bat.3.2 bat.3.2))
                            (+ bar.5.1 ball.8.3)
                            foobar.2.4))
                  (begin
                    (set! ball.6.9
                          (begin
                            (set! foo.4.10 ball.8.3)
                            1))
                    (if (<= foobar.2.4 1) 9223372036854775807 bat.3.2)))))
            (call L.proc.0.1 0 9223372036854775807 0 -1371550930 -1891086346 9223372036854775807)
      ))
  (check-by-interp
   '(module (define L.x.0.1
              (lambda (bat.7.7 ball.9.6 foobar.3.5 ball.5.4 ball.4.3 bar.0.2 ball.2.1)
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
              (lambda (bat.7.14 ball.9.13 ball.5.12 foo.6.11 bar.0.10 ball.2.9)
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
        (lambda (bat.7.23 ball.2.22 foo.6.21 foobar.3.20 bar.8.19 bar.0.18)
          (begin
            (set! foobar.3.24
                  (if (begin
                        (set! ball.2.25 258314756)
                        (!= bar.8.19 0))
                      bar.8.19
                      (begin
                        (set! foo.6.26 -1809848824)
                        9223372036854775807)))
            (if (< 1525021420 1)
                (call L.tmp.1.2 foobar.3.24 1 -1256996529 foo.6.21 -768559462 1067478227)
                (if (> 389818959 882297114) bar.8.19 ball.2.22)))))
      (begin
        (set! bar.0.27 1)
        1)))
  (check-by-interp '(module (define L.tmp.0.1
                              (lambda (foo.1.7 ball.6.6 bar.9.5 bat.3.4 ball.8.3 bat.0.2 ball.7.1)
                                (* bat.3.4 bat.0.2)))
                            (define L.func.1.2
                              (lambda (foo.1.12 bar.2.11 foo.5.10 bat.3.9 bar.9.8)
                                (begin
                                  (set! bat.3.13 1)
                                  9223372036854775807)))
                      (define L.fn.2.3
                        (lambda (ball.7.15 ball.8.14)
                          (begin
                            (set! bat.3.16
                                  (if (>= ball.7.15 1)
                                      (if (= ball.7.15 ball.7.15) ball.8.14 214741259)
                                      (+ 1683358713 ball.8.14)))
                            (call L.tmp.0.1
                                  bat.3.16
                                  ball.8.14
                                  0
                                  ball.7.15
                                  9223372036854775807
                                  ball.7.15
                                  -2043460455))))
                      (call L.tmp.0.1
                            -9223372036854775808
                            -9223372036854775808
                            -9223372036854775808
                            9223372036854775807
                            -9223372036854775808
                            1
                            -9223372036854775808)))
  (check-by-interp '(module (if (true)
                                (+ 1 -9223372036854775808)
                                (if (> 1383245321 0) 0 1))))
  (check-by-interp
   '(module (define L.x.0.1
              (lambda (ball.0.7 foobar.1.6 foo.3.5 foobar.2.4 foo.6.3 foobar.5.2 ball.8.1)
                (call L.x.4.5 1)))
            (define L.func.1.2
              (lambda ()
                (begin
                  (set! bar.9.8 9223372036854775807)
                  (begin
                    (set! foobar.1.9 bar.9.8)
                    (if (>= -577997854 foobar.1.9) -9223372036854775808 bar.9.8)))))
      (define L.fn.2.3
        (lambda ()
          (begin
            (set! ball.7.10 (+ 1 1))
            (if (false)
                ball.7.10
                (begin
                  (set! foobar.1.11 ball.7.10)
                  1969054361)))))
      (define L.x.3.4
        (lambda (foobar.4.18 foobar.5.17 bar.9.16 foobar.2.15 ball.8.14 foo.3.13 ball.7.12)
          (call L.func.6.7
                0
                -9223372036854775808
                9223372036854775807
                25911444
                9223372036854775807
                foobar.4.18
                -9223372036854775808)))
      (define L.x.4.5
        (lambda (foobar.4.19)
          (call L.x.3.4 0 foobar.4.19 foobar.4.19 1 foobar.4.19 foobar.4.19 foobar.4.19)))
      (define L.x.5.6
        (lambda (foo.6.25 foo.3.24 foobar.4.23 bar.9.22 foobar.1.21 foobar.5.20)
          (begin
            (set! foobar.5.26
                  (begin
                    (set! foobar.1.27 bar.9.22)
                    (begin
                      (set! foo.6.28 foo.3.24)
                      foobar.1.27)))
            (if (begin
                  (set! ball.8.29 bar.9.22)
                  (> foo.3.24 foo.6.25))
                (call L.x.0.1
                      -1863740769
                      9223372036854775807
                      foobar.4.23
                      foobar.5.26
                      foo.3.24
                      foobar.5.26
                      -1819248150)
                1))))
      (define L.func.6.7
        (lambda (foobar.2.36 foo.6.35 ball.0.34 ball.8.33 foo.3.32 foobar.1.31 foobar.5.30)
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
        (lambda ()
          (if (true)
              (if (not (> 0 100011461))
                  (call L.x.5.6 -9223372036854775808 16140507 0 -1248542300 0 -1579752260)
                  (if (= -9223372036854775808 471889533) 1 0))
              (if (if (>= 1 0)
                      (>= 0 -9223372036854775808)
                      (> 9223372036854775807 0))
                  (call L.fn.7.8)
                  (if (> 1 1) -444155079 9223372036854775807)))))
      (if (begin
            (set! foo.6.40
                  (if (begin
                        (set! foobar.2.41 -9223372036854775808)
                        (true))
                      (begin
                        (set! foobar.2.42
                              (if (> 9223372036854775807 0) -1444900091 -9223372036854775808))
                        foobar.2.42)
                      (if (true)
                          (begin
                            (set! foobar.5.43 9223372036854775807)
                            foobar.5.43)
                          (if (= -9223372036854775808 1173781558) 0 1))))
            (if (true)
                (begin
                  (set! bar.9.44 0)
                  (true))
                (< 858519747 foo.6.40)))
          1
          (if (< 1 -1323259230)
              (call L.fn.2.3)
              (call L.fn.2.3)))))
  ;; !!!

  ; adapted example outputs for normalize-bind
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1
                                                 (begin
                                                   (set! x.2 2)
                                                   x.2))
                                           x.1)))
                `(module (begin
                           (begin
                             (set! x.2 2)
                             (set! x.1 x.2))
                           x.1)))
  ; a few normalize-bind test for sanity
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1 0)
                                           (+ 1 1))))
                `(module (begin
                           (set! x.1 0)
                           (+ 1 1))))
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1 1)
                                           (+ x.1 0))))
                `(module (begin
                           (set! x.1 1)
                           (+ x.1 0))))
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1
                                                 (begin
                                                   (set! x.2
                                                         (begin
                                                           (set! x.3 3)
                                                           x.3))
                                                   x.2))
                                           x.1)))
                `(module (begin
                           (begin
                             (begin
                               (set! x.3 3)
                               (set! x.2 x.3))
                             (set! x.1 x.2))
                           x.1)))
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1 (if (true) 1 3))
                                           x.1)))
                `(module (begin
                           (if (true)
                               (set! x.1 1)
                               (set! x.1 3))
                           x.1)))
  (check-equal? (normalize-bind `(module (begin
                                           (set! x.1
                                                 (if (begin
                                                       (set! x.2
                                                             (begin
                                                               (set! x.4 1)
                                                               5))
                                                       (true))
                                                     1
                                                     3))
                                           x.1)))
                `(module (begin
                           (if (begin
                                 (begin
                                   (set! x.4 1)
                                   (set! x.2 5))
                                 (true))
                               (set! x.1 1)
                               (set! x.1 3))
                           x.1)))

  (check-equal? (normalize-bind `(module (define L.label.1 (lambda (x.1 x.2) 3))
                                         (begin
                                           (set! y.1 5)
                                           (set! y.2 6)
                                           (call L.label.1 y.1 y.2))
                                   ))
                `(module (define L.label.1 (lambda (x.1 x.2) 3))
                         (begin
                           (set! y.1 5)
                           (set! y.2 6)
                           (call L.label.1 y.1 y.2))
                   ))

  (check-equal? (normalize-bind `(module (define L.label.2
                                           (lambda ()
                                             (begin
                                               (set! x.1
                                                     (begin
                                                       (set! x.2 2)
                                                       x.2))
                                               x.1)))
                                         (call L.label.2)
                                   ))
                `(module (define L.label.2
                           (lambda ()
                             (begin
                               (begin
                                 (set! x.2 2)
                                 (set! x.1 x.2))
                               x.1)))
                         (call L.label.2)
                   )))
