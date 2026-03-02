#lang racket

(require cpsc411/compiler-lib)
; Asm-lang-v2/conflicts
; p	 	::=	 	(module info tail)
;   info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (conflicts ((aloc (aloc ...)) ...))))
;----------------
; Asm-lang-v2/assignments
; p	 	::=	 	(module info tail)
;  info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (assignment ((aloc loc) ...))))

;; same as v4
(provide assign-registers)

;; (Listof X) (X -> Number) (X -> Y) -> Y
;; returns the (k x) with x as the least value item of the list given the evaluation function
; did I really need the continuation? no. But is it funny? sure.
(define (minimum& x* valueof [k identity])
  (let ([valueof (λ (x)
                   (if (void? x)
                       +inf.f
                       (valueof x)))])
    (define (min-of x y)
      (if (> (valueof x) (valueof y)) y x))
    (let loop ([x* x*]
               [cur-min (void)])
      (if (empty? x*)
          (k cur-min)
          (loop (rest x*) (min-of (first x*) cur-min))))))

;; (list X (listof Y)) -> Number
;; returns the number of Y in the given pair
(define (num-values pair)
  ; list traversal in Racket moment
  (length (cadr pair)))

;; (list X (listof Y)) Y -> (list X (listof Y))
;; remove one occurence the given Y from the list of Y
;;     if given Y does not exists in the list of Y, do nothing
(define (remove-from-loy pair val)
  (list (car pair) (remove val (cadr pair))))
;; asm-lang-v4/conflicts -> asm-lang-v4/assignments
;; Performs graph-colouring register allocation. The pass attempts to fit each of
;;     the abstract location declared in the locals set into a register,
;;     and if one cannot be found, assigns it a frame variable instead.
(define (assign-registers p)
  (define assignables (current-assignable-registers))
  (define num-fvars 0)

  (define (assign-definition def)
    (match def
      [`(define ,label
          ,info
          ,tail)
       `(define ,label
          ,(assign-registers/info info)
          ,tail)]))

  ;let cinfo represent asm-lang-v4/conflicts-info
  ;let clocals represent asm-lang-v4/conflicts-info-locals
  ;let conflicts represent asm-lang-v4/conflicts-info-conflicts
  ;let ainfo represent asm-lang-v4/assignments-info
  ;let alocals represent asm-lang-v4/assignments-info-locals
  ;let assignments represent asm-lang-v4/assignment-info-assignments

  ;; (listof aloc) assignments -> (register or fvar)
  ;; produce a register that is not assigned by any aloc in the 'self-conflicts' list
  ;;     if no registers are available, produce a fvar instead.
  ;; EFFECT: increments the number of fvar allocated for the runtime of the 'assign-registers'
  ;;     function
  (define (get-assignment! self-conflicts assignments)
    (define assigned (map (λ (aloc) (info-ref assignments aloc)) self-conflicts))
    (define registers (filter (λ (reg) (not (memq reg assigned))) assignables))
    (if (empty? registers)
        (let ([fvar (make-fvar num-fvars)])
          (set! num-fvars (+ 1 num-fvars))
          fvar)
        ;; effects on assignment needs to be processed elsewhere
        (first registers)))

  ;; cinfo (assignments -> ainfo) -> ainfo
  (define (assign-registers/info info)
    (define conflicts (info-ref info 'conflicts))
    (let loop ([conflicts conflicts]
               [k (λ (assignments) (info-set info 'assignment assignments))])
      (if (empty? conflicts)
          (k '())
          (match-let ([`(,reg ,reg-conflicts) (minimum& conflicts num-values)])
            (loop (map (λ (conflict) (remove-from-loy conflict reg)) (info-remove conflicts reg))
                  (λ (assignments)
                    (k (info-set assignments reg (get-assignment! reg-conflicts assignments)))))))))

  (match p
    [`(module ,info ,definitions
        ...
        ,tail)
     `(module ,(assign-registers/info info) ,@(map assign-definition definitions)
        ,tail)]))

(module+ test
  ; oooooooh boy
  (require rackunit
           cpsc411/langs/v5)
  (define-syntax-rule (check-by-interp asmplv5c)
    (check-equal? (interp-asm-pred-lang-v5/conflicts asmplv5c)
                  (interp-asm-pred-lang-v5/assignments (assign-registers asmplv5c))))

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp
   '(module ((locals ()) (undead-out ((rdi rbp) (rdi rbp))) (conflicts ((rdi (rbp)) (rbp (rdi)))))
            (define L.L.func.0.1.4
              ((locals ()) (undead-out ()) (conflicts ()))
              (halt 0))
      (define L.L.tmp.1.2.5
        ((locals (foo.2.1.5)) (undead-out ((rbp) (rbp)))
                              (conflicts ((foo.2.1.5 (rbp)) (rbp (foo.2.1.5)))))
        (begin
          (set! foo.2.1.5 rdi)
          (jump L.L.func.0.1.4 rbp)))
      (define L.L.func.2.3.6
        ((locals (tmp.10 foobar.6.4.8 bar.4.2.6 foo.2.3.7 tmp.9))
         (undead-out ((() ((foo.2.3.7) (bar.4.2.6)) ((tmp.9) (tmp.9) (bar.4.2.6)))
                      (((tmp.10 bar.4.2.6) (bar.4.2.6)) () ())
                      ()))
         (conflicts
          ((tmp.9 ()) (foo.2.3.7 ()) (bar.4.2.6 (tmp.10)) (foobar.6.4.8 ()) (tmp.10 (bar.4.2.6)))))
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
  (check-by-interp
   '(module ((locals (tmp.20 ball.0.4.8 tmp.18 tmp.19))
             (undead-out ((tmp.18) (tmp.18) (ball.0.4.8) (tmp.20) (tmp.20) (tmp.19) ()))
             (conflicts ((tmp.19 ()) (tmp.18 ()) (ball.0.4.8 ()) (tmp.20 ()))))
            (define L.L.tmp.0.1.4
              ((locals (tmp.10 tmp.11 tmp.9))
               (undead-out (((tmp.9 rbp) (rbp)) (rbp) ((tmp.11) (tmp.11) (tmp.10) ())))
               (conflicts ((tmp.9 (rbp)) (tmp.11 ()) (tmp.10 ()) (rbp (tmp.9)))))
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
        ((locals (bar.1.1.5 tmp.12)) (undead-out ((bar.1.1.5) (((tmp.12 bar.1.1.5) (bar.1.1.5)) ()
                                                                                                ())))
                                     (conflicts ((tmp.12 (bar.1.1.5)) (bar.1.1.5 (tmp.12)))))
        (begin
          (set! bar.1.1.5 -9223372036854775808)
          (if (not (begin
                     (set! tmp.12 9223372036854775807)
                     (> tmp.12 0)))
              (halt 1309557052)
              (halt bar.1.1.5))))
      (define L.L.x.2.3.6
        ((locals (tmp.17 bar.3.3.7 tmp.16 tmp.14 tmp.15 ball.0.2.6 tmp.13))
         (undead-out ((() ((tmp.13) ()) ()) (((tmp.14) ()) (((tmp.15) ()) () ()) ((ball.0.2.6) ()))
                                            ((((tmp.16) ()) (bar.3.3.7) (bar.3.3.7))
                                             (((tmp.17 bar.3.3.7) (bar.3.3.7)) () ()))))
         (conflicts ((tmp.13 ()) (ball.0.2.6 ())
                                 (tmp.15 ())
                                 (tmp.14 ())
                                 (tmp.16 ())
                                 (bar.3.3.7 (tmp.17))
                                 (tmp.17 (bar.3.3.7)))))
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
  (check-by-interp
   '(module ((locals ()) (undead-out ((rdi rbp) (rdi rbp))) (conflicts ((rdi (rbp)) (rbp (rdi)))))
            (define L.L.proc.0.1.4
              ((locals (ball.6.1.5)) (undead-out ((rbp) (rbp)))
                                     (conflicts ((ball.6.1.5 (rbp)) (rbp (ball.6.1.5)))))
              (begin
                (set! ball.6.1.5 rdi)
                (jump L.L.func.1.2.5 rbp)))
      (define L.L.func.1.2.5
        ((locals (tmp.10 tmp.9)) (undead-out ((tmp.10) (tmp.10) (tmp.9) ()))
                                 (conflicts ((tmp.9 ()) (tmp.10 ()))))
        (begin
          (set! tmp.10 1)
          (set! tmp.10 (* tmp.10 0))
          (set! tmp.9 tmp.10)
          (halt tmp.9)))
      (define L.L.fn.2.3.6
        ((locals (ball.3.2.6 bat.0.3.7 tmp.11 foo.4.4.8))
         (undead-out ((rbp) ((rbp) ((((tmp.11) ()) () ()) () ()) (rbp))))
         (conflicts
          ((foo.4.4.8 ()) (tmp.11 ()) (bat.0.3.7 ()) (ball.3.2.6 (rbp)) (rbp (ball.3.2.6)))))
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
  (check-by-interp '(module ((locals (tmp.7)) (undead-out ((rbp) (((tmp.7) ()) () ()) (rbp)))
                                              (conflicts ((tmp.7 ()))))
                            (define L.fn.0.1
                              ((locals (foo.5.2 foo.5.4 ball.4.3 bat.9.1 tmp.6 tmp.5))
                               (undead-out ((() (bat.9.1) (() (bat.9.1)))
                                            ((((tmp.5 bat.9.1) (bat.9.1)) ((tmp.6 bat.9.1) (bat.9.1))
                                                                          (bat.9.1))
                                             (() ())
                                             ((bat.9.1) ()))))
                               (conflicts ((tmp.5 (bat.9.1)) (tmp.6 (bat.9.1))
                                                             (bat.9.1 (tmp.5 tmp.6))
                                                             (ball.4.3 ())
                                                             (foo.5.4 ())
                                                             (foo.5.2 ()))))
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
  (check-by-interp '(module ((locals (tmp.2 tmp.1)) (undead-out ((tmp.2) (tmp.2) (tmp.1) ()))
                                                    (conflicts ((tmp.1 ()) (tmp.2 ()))))
                            (begin
                              (set! tmp.2 -9223372036854775808)
                              (set! tmp.2 (+ tmp.2 -1465538260))
                              (set! tmp.1 tmp.2)
                              (halt tmp.1))
                      ))
  (check-by-interp
   '(module ((locals (ball.9.9 bat.5.8)) (undead-out ((bat.5.8) (bat.5.8) ()))
                                         (conflicts ((bat.5.8 (ball.9.9)) (ball.9.9 (bat.5.8)))))
            (define L.fn.0.1
              ((locals (foo.8.2 foo.1.3 tmp.10 bar.2.1))
               (undead-out ((tmp.10) (tmp.10) (bar.2.1) (foo.1.3 bar.2.1) (bar.2.1) ()))
               (conflicts ((bar.2.1 (foo.8.2)) (tmp.10 ()) (foo.1.3 ()) (foo.8.2 (bar.2.1)))))
              (begin
                (set! tmp.10 1)
                (set! tmp.10 (+ tmp.10 9223372036854775807))
                (set! bar.2.1 tmp.10)
                (set! foo.1.3 bar.2.1)
                (set! foo.8.2 foo.1.3)
                (halt bar.2.1)))
      (define L.func.1.2
        ((locals (tmp.13 tmp.11 foo.8.5 ball.3.4 foo.1.6 foo.8.7 tmp.12))
         (undead-out ((((foo.8.5) ((foo.8.5 tmp.11) ())) (() (ball.3.4)) ((foo.8.7) (ball.3.4)))
                      (ball.3.4 tmp.13)
                      (tmp.13)
                      (tmp.12)
                      ()))
         (conflicts ((tmp.12 ()) (foo.8.7 ())
                                 (foo.1.6 ())
                                 (ball.3.4 ())
                                 (foo.8.5 (tmp.11))
                                 (tmp.11 (foo.8.5))
                                 (tmp.13 ()))))
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
  (check-by-interp
   '(module ((locals (tmp.13)) (undead-out (((tmp.13) ()) () ())) (conflicts ((tmp.13 ()))))
            (define L.x.0.1
              ((locals (foo.0.1 ball.1.2))
               (undead-out ((rsi rbp) (rbp) (rbp)))
               (conflicts
                ((ball.1.2 (rbp rsi)) (foo.0.1 (rbp)) (rsi (ball.1.2)) (rbp (foo.0.1 ball.1.2)))))
              (begin
                (set! ball.1.2 rdi)
                (set! foo.0.1 rsi)
                (jump L.tmp.1.2 rbp)))
      (define L.tmp.1.2
        ((locals (tmp.12 foobar.9.5 tmp.11 ball.4.3 bar.5.4 tmp.10 tmp.9 tmp.8))
         (undead-out (((((tmp.8) ()) ((tmp.9) ()) ((tmp.10) ())) () ())
                      ((bar.5.4) (ball.4.3) ((ball.4.3) () ()))
                      ((((tmp.11) ()) (foobar.9.5) (foobar.9.5)) (((foobar.9.5 tmp.12) ()) () ()))))
         (conflicts ((tmp.8 ()) (tmp.9 ())
                                (tmp.10 ())
                                (bar.5.4 ())
                                (ball.4.3 ())
                                (tmp.11 ())
                                (foobar.9.5 (tmp.12))
                                (tmp.12 (foobar.9.5)))))
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
        ((locals (ball.6.6 ball.4.7)) (undead-out ((rsi rbp) (rbp) (rbp)))
                                      (conflicts ((ball.4.7 (rbp rsi)) (ball.6.6 (rbp))
                                                                       (rsi (ball.4.7))
                                                                       (rbp (ball.6.6 ball.4.7)))))
        (begin
          (set! ball.4.7 rdi)
          (set! ball.6.6 rsi)
          (jump L.tmp.1.2 rbp)))
      (if (begin
            (set! tmp.13 0)
            (<= tmp.13 1))
          (halt -1271132888)
          (halt 2101306416))))
  (check-by-interp
   '(module ((locals (tmp.7)) (undead-out (((tmp.7) ()) () ())) (conflicts ((tmp.7 ()))))
            (define L.proc.0.1
              ((locals (bat.3.5 tmp.6 bat.7.2 bat.4.3 foobar.2.4 bar.8.1))
               (undead-out ((bar.8.1) ((bar.8.1) ((bar.8.1) (bat.7.2 bar.8.1))
                                                 ((foobar.2.4 bar.8.1) (bat.7.2 bar.8.1)))
                                      (bat.7.2 tmp.6 bar.8.1)
                                      (tmp.6 bar.8.1)
                                      (bar.8.1)
                                      ((bar.8.1) () ())))
               (conflicts ((bar.8.1 (bat.3.5 tmp.6 foobar.2.4 bat.7.2)) (foobar.2.4 (bar.8.1))
                                                                        (bat.4.3 ())
                                                                        (bat.7.2 (tmp.6 bar.8.1))
                                                                        (tmp.6 (bar.8.1 bat.7.2))
                                                                        (bat.3.5 (bar.8.1)))))
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
  (check-by-interp
   '(module ((locals (ball.1.5 foobar.4.4 tmp.8))
             (undead-out ((ball.1.5) (foobar.4.4) (((foobar.4.4 tmp.8) ()) () ())))
             (conflicts ((tmp.8 (foobar.4.4)) (foobar.4.4 (tmp.8)) (ball.1.5 ()))))
            (define L.proc.0.1
              ((locals (tmp.6 ball.3.1 bat.9.3 foobar.4.2 tmp.7))
               (undead-out
                ((ball.3.1 rbp)
                 ((ball.3.1 rbp) (rbp) ((ball.3.1) (ball.3.1) (ball.3.1 tmp.7) (tmp.7) (tmp.6) ()))))
               (conflicts ((tmp.7 (ball.3.1)) (foobar.4.2 (ball.3.1))
                                              (bat.9.3 ())
                                              (ball.3.1 (rbp tmp.7 foobar.4.2))
                                              (tmp.6 ())
                                              (rbp (ball.3.1)))))
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
        ((locals ()) (undead-out ()) (conflicts ()))
        (halt 1))
      (begin
        (set! ball.1.5 453798193)
        (set! foobar.4.4 ball.1.5)
        (if (begin
              (set! tmp.8 9223372036854775807)
              (>= tmp.8 foobar.4.4))
            (halt 0)
            (halt -1617493587)))))
  (check-by-interp
   '(module ((locals (tmp.5 tmp.6)) (undead-out ((rbp) ((tmp.6) (tmp.6) (tmp.5) ()) (rbp)))
                                    (conflicts ((tmp.6 ()) (tmp.5 ()))))
            (define L.func.0.1
              ((locals (tmp.4 tmp.3 bat.8.1 bat.2.2))
               (undead-out ((rbp bat.8.1)
                            ((((tmp.3 rbp bat.8.1) (tmp.3 rbp bat.8.1) (rbp bat.8.1)) (rbp bat.8.1))
                             ((bat.8.1) ((bat.8.1) () ()) (((tmp.4 bat.8.1) (bat.8.1)) () ()))
                             (rbp))))
               (conflicts ((bat.2.2 (bat.8.1 rbp)) (bat.8.1 (rbp tmp.3 bat.2.2 tmp.4))
                                                   (tmp.3 (bat.8.1 rbp))
                                                   (tmp.4 (bat.8.1))
                                                   (rbp (bat.8.1 tmp.3 bat.2.2)))))
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
        ((locals ()) (undead-out ((rdi rbp) (rdi rbp))) (conflicts ((rdi (rbp)) (rbp (rdi)))))
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
  (check-by-interp '(module ((locals (tmp.2 tmp.1)) (undead-out (((tmp.1) ()) (((tmp.2) ()) () ())
                                                                              ()))
                                                    (conflicts ((tmp.1 ()) (tmp.2 ()))))
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
  (check-by-interp
   '(module ((locals ()) (undead-out ((r8 rbp) (r8 rcx rbp)
                                               (r8 rcx rdx rbp)
                                               (r8 rcx rdx rsi rbp)
                                               (r8 rcx rdx rsi rdi rbp)
                                               (r8 rcx rdx rsi rdi rbp)))
                         (conflicts ((r8 (rdi rsi rdx rcx rbp)) (rbp (rdi rsi rdx rcx r8))
                                                                (rcx (rdi rsi rdx rbp r8))
                                                                (rdx (rdi rsi rbp rcx r8))
                                                                (rsi (rdi rbp rdx rcx r8))
                                                                (rdi (rbp rsi rdx rcx r8)))))
            (define L.func.0.1
              ((locals (foobar.4.1 bat.7.2 bar.1.3 foo.2.4 foo.9.5))
               (undead-out ((rsi rdx rcx r8) (rdx rcx r8) (rcx r8) (r8) () ()))
               (conflicts ((foo.9.5 (r8 rcx rdx rsi)) (foo.2.4 (r8 rcx rdx))
                                                      (bar.1.3 (r8 rcx))
                                                      (bat.7.2 (r8))
                                                      (foobar.4.1 ())
                                                      (rsi (foo.9.5))
                                                      (rdx (foo.2.4 foo.9.5))
                                                      (rcx (bar.1.3 foo.2.4 foo.9.5))
                                                      (r8 (bat.7.2 bar.1.3 foo.2.4 foo.9.5)))))
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
   '(module ((locals (ball.6.6)) (undead-out ((ball.6.6) ())) (conflicts ((ball.6.6 ()))))
            (define L.tmp.0.1
              ((locals (foobar.0.1 bar.8.2 tmp.9 bat.2.5 tmp.10 tmp.8 ball.6.4 bat.5.3 tmp.7))
               (undead-out ((rsi rdx rcx ball.6.4)
                            (rdx rcx ball.6.4 bat.5.3)
                            (rcx ball.6.4 bat.5.3)
                            (ball.6.4 bat.5.3)
                            (ball.6.4 bat.5.3 bat.2.5)
                            ((((tmp.7 ball.6.4 bat.5.3 bat.2.5) (ball.6.4 bat.5.3 bat.2.5))
                              ((ball.6.4 tmp.8 bat.5.3 bat.2.5) (bat.5.3 bat.2.5))
                              (bat.5.3 bat.2.5))
                             ((tmp.10) (tmp.10) (tmp.9) ())
                             (() () ()))))
               (conflicts ((tmp.7 (bat.2.5 bat.5.3 ball.6.4))
                           (bat.5.3 (bat.2.5 foobar.0.1 bar.8.2 ball.6.4 rcx rdx tmp.7 tmp.8))
                           (ball.6.4 (foobar.0.1 bar.8.2 bat.5.3 rcx rdx rsi tmp.7 tmp.8))
                           (tmp.8 (bat.2.5 bat.5.3 ball.6.4))
                           (tmp.10 ())
                           (bat.2.5 (bat.5.3 tmp.7 tmp.8))
                           (tmp.9 ())
                           (bar.8.2 (bat.5.3 ball.6.4 rcx))
                           (foobar.0.1 (bat.5.3 ball.6.4))
                           (rsi (ball.6.4))
                           (rdx (bat.5.3 ball.6.4))
                           (rcx (bar.8.2 bat.5.3 ball.6.4)))))
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
   '(module ((locals ()) (undead-out ((rdi rbp) (rdi rbp))) (conflicts ((rdi (rbp)) (rbp (rdi)))))
            (define L.func.0.1
              ((locals (ball.6.2 tmp.16 tmp.15 tmp.17 tmp.13 tmp.14 foobar.3.1 tmp.12))
               (undead-out ((rsi ball.6.2)
                            (foobar.3.1 ball.6.2)
                            (((tmp.12 foobar.3.1 ball.6.2) (foobar.3.1 ball.6.2))
                             ((tmp.14) (tmp.14) (tmp.13) ())
                             (((ball.6.2 foobar.3.1) (ball.6.2 foobar.3.1) (ball.6.2 foobar.3.1))
                              ((foobar.3.1 tmp.16) (tmp.16) (tmp.15) ())
                              (((tmp.17 foobar.3.1 ball.6.2) (foobar.3.1 ball.6.2)) () ())))))
               (conflicts ((tmp.12 (ball.6.2 foobar.3.1)) (foobar.3.1 (ball.6.2 tmp.12 tmp.17))
                                                          (tmp.14 ())
                                                          (tmp.13 ())
                                                          (tmp.17 (ball.6.2 foobar.3.1))
                                                          (tmp.15 ())
                                                          (tmp.16 ())
                                                          (ball.6.2 (foobar.3.1 rsi tmp.12 tmp.17))
                                                          (rsi (ball.6.2)))))
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
        ((locals (ball.5.7 bat.9.5 bat.2.6 tmp.18 tmp.19 ball.1.4 bar.0.3 foo.7.8))
         (undead-out ((bar.0.3) (bat.2.6 bar.0.3)
                                (bar.0.3)
                                (bar.0.3)
                                (bar.0.3 ball.1.4)
                                (((foo.7.8 bar.0.3 ball.1.4) (bar.0.3 ball.1.4))
                                 ()
                                 ((bar.0.3 tmp.19) (tmp.19) (tmp.18) ()))))
         (conflicts ((foo.7.8 (ball.1.4)) (bar.0.3 (ball.1.4 ball.5.7 bat.9.5 bat.2.6 tmp.19))
                                          (ball.1.4 (bar.0.3 foo.7.8))
                                          (tmp.19 (bar.0.3))
                                          (tmp.18 ())
                                          (bat.2.6 (bar.0.3))
                                          (bat.9.5 (bar.0.3))
                                          (ball.5.7 (bar.0.3)))))
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
        ((locals (tmp.24 ball.1.10 foo.4.11 tmp.22 tmp.23 tmp.20 foobar.8.9 tmp.21))
         (undead-out ((((tmp.20) (tmp.20) ()) ((tmp.21) ())) ((tmp.23) (tmp.23) (tmp.22) ())
                                                             ((tmp.24) (tmp.24) (ball.1.10) () ())))
         (conflicts ((tmp.21 ()) (foobar.8.9 ())
                                 (tmp.20 ())
                                 (tmp.23 ())
                                 (tmp.22 ())
                                 (foo.4.11 ())
                                 (ball.1.10 ())
                                 (tmp.24 ()))))
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
   '(module ((locals (bat.0.13)) (undead-out (() ())) (conflicts ((bat.0.13 ()))))
            (define L.proc.0.1
              ((locals (ball.2.1 foo.7.2 ball.4.3))
               (undead-out ((rsi rdx rbp) (rdx foo.7.2 rbp)
                                          (foo.7.2 ball.2.1 rbp)
                                          (ball.2.1 rdx rbp)
                                          (rdx rsi rbp)
                                          (rdx rsi rdi rbp)
                                          (rdx rsi rdi rbp)))
               (conflicts ((ball.4.3 (rbp rdx rsi)) (foo.7.2 (ball.2.1 rbp rdx))
                                                    (ball.2.1 (rdx rbp foo.7.2))
                                                    (rsi (rdi rbp rdx ball.4.3))
                                                    (rdx (rdi rsi rbp ball.2.1 foo.7.2 ball.4.3))
                                                    (rbp (rdi rsi rdx ball.2.1 foo.7.2 ball.4.3))
                                                    (rdi (rbp rsi rdx)))))
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
          (bar.3.10 foobar.5.12 ball.4.11 bar.3.4 foobar.6.5 ball.4.6 foo.7.7 bat.0.8 ball.1.9))
         (undead-out ((rsi rdx rcx r8 r9 ball.1.9 rbp) (rdx rcx r8 r9 ball.1.9 rbp)
                                                       (rcx r8 r9 foo.7.7 ball.1.9 rbp)
                                                       (r8 r9 foo.7.7 ball.1.9 rbp)
                                                       (r9 foo.7.7 ball.1.9 rbp)
                                                       (foo.7.7 ball.1.9 rbp)
                                                       (ball.1.9 rbp)
                                                       (rbp)
                                                       (bar.3.10 rbp)
                                                       (bar.3.10 rdx rbp)
                                                       (bar.3.10 rdx rsi rbp)
                                                       (rdx rsi rdi rbp)
                                                       (rdx rsi rdi rbp)))
         (conflicts
          ((ball.1.9 (ball.4.11 bar.3.4 foobar.6.5 ball.4.6 foo.7.7 bat.0.8 rbp r9 r8 rcx rdx rsi))
           (bat.0.8 (rbp ball.1.9 r9 r8 rcx rdx))
           (foo.7.7 (bar.3.4 foobar.6.5 ball.4.6 rbp ball.1.9 r9 r8 rcx))
           (ball.4.6 (rbp ball.1.9 foo.7.7 r9 r8))
           (foobar.6.5 (rbp ball.1.9 foo.7.7 r9))
           (bar.3.4 (rbp ball.1.9 foo.7.7))
           (ball.4.11 (rbp ball.1.9))
           (foobar.5.12 (rbp))
           (bar.3.10 (rsi rbp))
           (rsi (rdi rbp rdx bar.3.10 ball.1.9))
           (rdx (rdi rsi rbp bat.0.8 ball.1.9))
           (rcx (foo.7.7 bat.0.8 ball.1.9))
           (r8 (ball.4.6 foo.7.7 bat.0.8 ball.1.9))
           (r9 (foobar.6.5 ball.4.6 foo.7.7 bat.0.8 ball.1.9))
           (rbp (rdi rsi
                     rdx
                     bar.3.10
                     foobar.5.12
                     ball.4.11
                     bar.3.4
                     foobar.6.5
                     ball.4.6
                     foo.7.7
                     bat.0.8
                     ball.1.9))
           (rdi (rbp rsi rdx)))))
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
  (check-by-interp '(module ((locals (ball.2.2 bar.5.1)) (undead-out (() (bar.5.1) (() () ())))
                                                         (conflicts ((bar.5.1 ()) (ball.2.2 ()))))
                            (begin
                              (set! ball.2.2 9223372036854775807)
                              (set! bar.5.1 -546026276)
                              (if (!= bar.5.1 1)
                                  (halt 9223372036854775807)
                                  (halt 2063023986)))
                      ))
  (check-by-interp
   '(module ((locals (tmp.10)) (undead-out (((tmp.10) ()) () ())) (conflicts ((tmp.10 ()))))
            (define L.func.0.1
              ((locals (bat.7.5 bar.2.1 tmp.9 tmp.7 tmp.6 foobar.6.4 tmp.8 foo.8.2 foo.8.3))
               (undead-out ((rsi foo.8.2)
                            (bar.2.1 foo.8.2)
                            (((foo.8.3 bar.2.1 foo.8.2) (bar.2.1 foo.8.2))
                             ((tmp.6) (tmp.6) () (tmp.8) (tmp.8) (tmp.7) ())
                             ((tmp.9 bar.2.1) (tmp.9 bar.2.1) (bat.7.5 bar.2.1) ((bar.2.1) () ())))))
               (conflicts ((foo.8.3 (bar.2.1)) (foo.8.2 (bar.2.1 rsi))
                                               (tmp.8 ())
                                               (foobar.6.4 ())
                                               (tmp.6 ())
                                               (tmp.7 ())
                                               (tmp.9 (bar.2.1))
                                               (bar.2.1 (foo.8.2 foo.8.3 bat.7.5 tmp.9))
                                               (bat.7.5 (bar.2.1))
                                               (rsi (foo.8.2)))))
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
   '(module ((locals (tmp.24 tmp.23)) (undead-out ((tmp.24) (tmp.24) (tmp.23) ()))
                                      (conflicts ((tmp.23 ()) (tmp.24 ()))))
            (define L.fn.0.1
              ((locals (bat.4.5 tmp.16 bat.4.4 tmp.15 foobar.3.2 ball.7.1 bar.9.3 tmp.17))
               (undead-out ((rsi) (ball.7.1)
                                  (tmp.15 ball.7.1)
                                  (tmp.15 ball.7.1)
                                  (bat.4.4 ball.7.1)
                                  (bat.4.4 tmp.16 ball.7.1)
                                  (tmp.16 ball.7.1)
                                  (bar.9.3 ball.7.1)
                                  (bar.9.3 ball.7.1)
                                  (((bar.9.3 tmp.17 ball.7.1) (ball.7.1)) () ())))
               (conflicts ((tmp.17 (ball.7.1 bar.9.3))
                           (bar.9.3 (bat.4.5 ball.7.1 tmp.17))
                           (ball.7.1 (bat.4.5 bar.9.3 tmp.16 bat.4.4 tmp.15 tmp.17))
                           (foobar.3.2 (rsi))
                           (tmp.15 (ball.7.1))
                           (bat.4.4 (tmp.16 ball.7.1))
                           (tmp.16 (ball.7.1 bat.4.4))
                           (bat.4.5 (ball.7.1 bar.9.3))
                           (rsi (foobar.3.2)))))
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
        ((locals (tmp.20 foobar.3.7 bat.2.9 bat.4.8 tmp.18 bat.2.6 tmp.19))
         (undead-out ((bat.2.6) (bat.2.6 tmp.18) (tmp.18) () () () (tmp.20) (tmp.20) (tmp.19) ()))
         (conflicts ((tmp.19 ()) (bat.2.6 (tmp.18))
                                 (tmp.18 (bat.2.6))
                                 (bat.4.8 ())
                                 (bat.2.9 ())
                                 (foobar.3.7 ())
                                 (tmp.20 ()))))
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
        ((locals (tmp.22 foobar.1.14 ball.8.10 foo.0.11 ball.7.12 foo.5.13 tmp.21))
         (undead-out ((rsi rdx rcx foo.5.13) (rdx rcx foo.5.13)
                                             (rcx foo.5.13)
                                             (foo.5.13)
                                             ()
                                             (tmp.22)
                                             (tmp.22)
                                             (tmp.21)
                                             ()))
         (conflicts ((tmp.21 ()) (foo.5.13 (ball.8.10 foo.0.11 ball.7.12 rcx rdx rsi))
                                 (ball.7.12 (foo.5.13 rcx rdx))
                                 (foo.0.11 (foo.5.13 rcx))
                                 (ball.8.10 (foo.5.13))
                                 (foobar.1.14 ())
                                 (tmp.22 ())
                                 (rsi (foo.5.13))
                                 (rdx (ball.7.12 foo.5.13))
                                 (rcx (foo.0.11 ball.7.12 foo.5.13)))))
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
  (check-by-interp
   '(module ((locals ()) (undead-out ((r9 rbp) (r9 r8 rbp)
                                               (r9 r8 rcx rbp)
                                               (r9 r8 rcx rdx rbp)
                                               (r9 r8 rcx rdx rsi rbp)
                                               (r9 r8 rcx rdx rsi rdi rbp)
                                               (r9 r8 rcx rdx rsi rdi rbp)))
                         (conflicts ((r9 (rdi rsi rdx rcx r8 rbp)) (rbp (rdi rsi rdx rcx r8 r9))
                                                                   (r8 (rdi rsi rdx rcx rbp r9))
                                                                   (rcx (rdi rsi rdx rbp r8 r9))
                                                                   (rdx (rdi rsi rbp rcx r8 r9))
                                                                   (rsi (rdi rbp rdx rcx r8 r9))
                                                                   (rdi (rbp rsi rdx rcx r8 r9)))))
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
                                 foobar.2.4))
               (undead-out
                ((rsi rdx rcx r8 r9)
                 (rdx rcx r8 r9)
                 (rcx r8 r9 foobar.2.4)
                 (r8 r9 ball.8.3 foobar.2.4)
                 (r9 ball.8.3 foobar.2.4 bat.3.2)
                 (bar.5.1 ball.8.3 foobar.2.4 bat.3.2)
                 (((bar.5.1 ball.8.3 foobar.2.4 bat.3.2) (bar.5.1 ball.8.3 foobar.2.4 bat.3.2))
                  ((tmp.11 ball.8.3 foobar.2.4 bat.3.2) (tmp.11 ball.8.3 foobar.2.4 bat.3.2)
                                                        (ball.8.3 foobar.2.4 bat.3.2))
                  (ball.8.3 foobar.2.4 bat.3.2))
                 (foobar.2.4 bat.3.2)
                 (foobar.2.4 bat.3.2)
                 ((bat.3.2) () ())))
               (conflicts
                ((foobar.2.4
                  (ball.6.9 foo.4.10 bar.7.8 tmp.11 bar.9.7 bar.5.1 bat.3.2 ball.8.3 r9 r8 rcx))
                 (bat.3.2 (ball.6.9 foo.4.10 bar.7.8 tmp.11 bar.9.7 bar.5.1 foobar.2.4 ball.8.3 r9))
                 (foobar.1.6 (r9 r8 rcx rdx rsi))
                 (bar.0.5 (r9 r8 rcx rdx))
                 (ball.8.3 (bar.7.8 tmp.11 bar.9.7 bar.5.1 bat.3.2 foobar.2.4 r9 r8))
                 (bar.5.1 (bar.7.8 bat.3.2 foobar.2.4 ball.8.3))
                 (tmp.11 (bat.3.2 foobar.2.4 ball.8.3))
                 (bar.9.7 (foobar.2.4 bat.3.2 ball.8.3))
                 (bar.7.8 (bat.3.2 foobar.2.4 ball.8.3 bar.5.1))
                 (foo.4.10 (bat.3.2 foobar.2.4))
                 (ball.6.9 (bat.3.2 foobar.2.4))
                 (rsi (foobar.1.6))
                 (rdx (bar.0.5 foobar.1.6))
                 (rcx (foobar.2.4 bar.0.5 foobar.1.6))
                 (r8 (ball.8.3 foobar.2.4 bar.0.5 foobar.1.6))
                 (r9 (bat.3.2 ball.8.3 foobar.2.4 bar.0.5 foobar.1.6)))))
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
   '(module ((locals (bar.0.27)) (undead-out (() ())) (conflicts ((bar.0.27 ()))))
            (define L.x.0.1
              ((locals
                (ball.2.1 bat.7.7 ball.4.3 bar.0.2 ball.4.8 foobar.3.5 ball.5.4 ball.9.6 tmp.28))
               (undead-out ((rsi rdx rcx r8 r9 fv0)
                            (rdx rcx r8 r9 fv0 ball.9.6)
                            (rcx r8 r9 fv0 ball.9.6 foobar.3.5)
                            (r8 r9 fv0 ball.9.6 foobar.3.5 ball.5.4)
                            (r9 fv0 ball.9.6 foobar.3.5 ball.4.3 ball.5.4)
                            (fv0 ball.9.6 foobar.3.5 bar.0.2 ball.4.3 ball.5.4)
                            (ball.9.6 foobar.3.5 bar.0.2 ball.4.3 ball.5.4)
                            ((((ball.9.6 tmp.28 foobar.3.5 bar.0.2 ball.4.3 ball.5.4)
                               (foobar.3.5 bar.0.2 ball.4.3 ball.5.4))
                              (foobar.3.5 bar.0.2 ball.4.3 ball.5.4)
                              (foobar.3.5 bar.0.2 ball.4.3 ball.5.4))
                             ((ball.5.4) () (() ()))
                             ())))
               (conflicts
                ((tmp.28 (ball.5.4 ball.4.3 bar.0.2 foobar.3.5 ball.9.6))
                 (ball.9.6 (ball.2.1 bar.0.2 ball.4.3 ball.5.4 foobar.3.5 fv0 r9 r8 rcx rdx tmp.28))
                 (ball.5.4 (ball.2.1 bar.0.2 ball.4.3 foobar.3.5 ball.9.6 fv0 r9 r8 tmp.28))
                 (foobar.3.5 (ball.2.1 bar.0.2 ball.4.3 ball.5.4 ball.9.6 fv0 r9 r8 rcx tmp.28))
                 (ball.4.8 ())
                 (bar.0.2 (ball.2.1 ball.5.4 ball.4.3 foobar.3.5 ball.9.6 fv0 tmp.28))
                 (ball.4.3 (ball.2.1 bar.0.2 ball.5.4 foobar.3.5 ball.9.6 fv0 r9 tmp.28))
                 (bat.7.7 (fv0 r9 r8 rcx rdx rsi))
                 (ball.2.1 (ball.5.4 ball.4.3 bar.0.2 foobar.3.5 ball.9.6))
                 (rsi (bat.7.7))
                 (rdx (ball.9.6 bat.7.7))
                 (rcx (foobar.3.5 ball.9.6 bat.7.7))
                 (r8 (ball.5.4 foobar.3.5 ball.9.6 bat.7.7))
                 (r9 (ball.4.3 ball.5.4 foobar.3.5 ball.9.6 bat.7.7))
                 (fv0 (bar.0.2 ball.4.3 ball.5.4 foobar.3.5 ball.9.6 bat.7.7)))))
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
                           tmp.30))
         (undead-out ((rsi rdx rcx r8 r9) (rdx rcx r8 r9)
                                          (rcx r8 r9 ball.5.12)
                                          (r8 r9 ball.5.12 foo.6.11)
                                          (r9 bar.0.10 ball.5.12 foo.6.11)
                                          (bar.0.10 ball.5.12 foo.6.11)
                                          ((bar.0.10 ball.5.12 foo.6.11)
                                           ((tmp.30) (tmp.30) (tmp.29) ())
                                           (((ball.5.12 bar.0.10) ()) ((ball.9.16) ()) (() ())))))
         (conflicts ((tmp.30 ()) (foo.6.11 (ball.2.9 bar.0.10 ball.5.12 r9 r8))
                                 (tmp.29 ())
                                 (bat.7.17 ())
                                 (ball.9.16 ())
                                 (foobar.3.15 (bar.0.10 ball.5.12))
                                 (ball.5.12 (ball.2.9 bar.0.10 foo.6.11 r9 r8 rcx foobar.3.15))
                                 (bar.0.10 (ball.2.9 foo.6.11 ball.5.12 r9 foobar.3.15))
                                 (bat.7.14 (r9 r8 rcx rdx rsi))
                                 (ball.9.13 (r9 r8 rcx rdx))
                                 (ball.2.9 (foo.6.11 ball.5.12 bar.0.10))
                                 (rsi (bat.7.14))
                                 (rdx (ball.9.13 bat.7.14))
                                 (rcx (ball.5.12 ball.9.13 bat.7.14))
                                 (r8 (foo.6.11 ball.5.12 ball.9.13 bat.7.14))
                                 (r9 (bar.0.10 foo.6.11 ball.5.12 ball.9.13 bat.7.14)))))
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
                            tmp.31))
         (undead-out
          ((rsi rdx rcx r8 r9 rbp)
           (rdx rcx r8 r9 ball.2.22 rbp)
           (rcx r8 r9 ball.2.22 foo.6.21 rbp)
           (r8 r9 ball.2.22 foo.6.21 rbp)
           (r9 bar.8.19 ball.2.22 foo.6.21 rbp)
           (bar.8.19 ball.2.22 foo.6.21 rbp)
           (((bar.8.19 ball.2.22 foo.6.21 rbp) (bar.8.19 ball.2.22 foo.6.21 rbp))
            (bar.8.19 ball.2.22 foo.6.21 foobar.3.24 rbp)
            ((bar.8.19 ball.2.22 foo.6.21 rbp) (bar.8.19 ball.2.22 foo.6.21 foobar.3.24 rbp)))
           (((tmp.31 bar.8.19 ball.2.22 foo.6.21 foobar.3.24 rbp)
             (bar.8.19 ball.2.22 foo.6.21 foobar.3.24 rbp))
            ((foo.6.21 foobar.3.24 r9 rbp) (foo.6.21 foobar.3.24 r9 r8 rbp)
                                           (foobar.3.24 r9 r8 rcx rbp)
                                           (foobar.3.24 r9 r8 rcx rdx rbp)
                                           (foobar.3.24 r9 r8 rcx rdx rsi rbp)
                                           (r9 r8 rcx rdx rsi rdi rbp)
                                           (r9 r8 rcx rdx rsi rdi rbp))
            (((tmp.32 ball.2.22 bar.8.19) (ball.2.22 bar.8.19)) () ()))))
         (conflicts
          ((tmp.31 (rbp foobar.3.24 foo.6.21 ball.2.22 bar.8.19))
           (foobar.3.24 (rbp foo.6.21 ball.2.22 bar.8.19 tmp.31 rsi rdx rcx r8 r9))
           (foo.6.21 (ball.2.25 foo.6.26
                                foobar.3.24
                                bar.0.18
                                bar.8.19
                                foobar.3.20
                                rbp
                                ball.2.22
                                rcx
                                tmp.31
                                r8
                                r9))
           (ball.2.22 (ball.2.25 foo.6.26
                                 foobar.3.24
                                 bar.0.18
                                 bar.8.19
                                 foobar.3.20
                                 foo.6.21
                                 rbp
                                 r9
                                 r8
                                 rcx
                                 rdx
                                 tmp.31
                                 tmp.32))
           (bar.8.19
            (ball.2.25 foo.6.26 foobar.3.24 bar.0.18 rbp foo.6.21 ball.2.22 r9 tmp.31 tmp.32))
           (tmp.32 (bar.8.19 ball.2.22))
           (bat.7.23 (rbp r9 r8 rcx rdx rsi))
           (foobar.3.20 (rbp foo.6.21 ball.2.22 r9 r8))
           (bar.0.18 (rbp foo.6.21 ball.2.22 bar.8.19))
           (foo.6.26 (rbp foo.6.21 ball.2.22 bar.8.19))
           (ball.2.25 (rbp foo.6.21 ball.2.22 bar.8.19))
           (r9 (bar.8.19 foobar.3.20 ball.2.22 bat.7.23 rdi rsi rdx rcx r8 rbp foobar.3.24 foo.6.21))
           (rbp (ball.2.25 foo.6.26
                           foobar.3.24
                           bar.0.18
                           bar.8.19
                           foobar.3.20
                           foo.6.21
                           ball.2.22
                           bat.7.23
                           tmp.31
                           rdi
                           rsi
                           rdx
                           rcx
                           r8
                           r9))
           (r8 (foobar.3.20 ball.2.22 bat.7.23 rdi rsi rdx rcx rbp r9 foobar.3.24 foo.6.21))
           (rcx (foo.6.21 ball.2.22 bat.7.23 rdi rsi rdx rbp r8 r9 foobar.3.24))
           (rdx (ball.2.22 bat.7.23 rdi rsi rbp rcx r8 r9 foobar.3.24))
           (rsi (bat.7.23 rdi rbp rdx rcx r8 r9 foobar.3.24))
           (rdi (rbp rsi rdx rcx r8 r9)))))
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
   '(module ((locals ()) (undead-out ((fv0 rbp) (fv0 r9 rbp)
                                                (fv0 r9 r8 rbp)
                                                (fv0 r9 r8 rcx rbp)
                                                (fv0 r9 r8 rcx rdx rbp)
                                                (fv0 r9 r8 rcx rdx rsi rbp)
                                                (fv0 r9 r8 rcx rdx rsi rdi rbp)
                                                (fv0 r9 r8 rcx rdx rsi rdi rbp)))
                         (conflicts ((fv0 (rdi rsi rdx rcx r8 r9 rbp))
                                     (rbp (rdi rsi rdx rcx r8 r9 fv0))
                                     (r9 (rdi rsi rdx rcx r8 rbp fv0))
                                     (r8 (rdi rsi rdx rcx rbp r9 fv0))
                                     (rcx (rdi rsi rdx rbp r8 r9 fv0))
                                     (rdx (rdi rsi rbp rcx r8 r9 fv0))
                                     (rsi (rdi rbp rdx rcx r8 r9 fv0))
                                     (rdi (rbp rsi rdx rcx r8 r9 fv0)))))
            (define L.tmp.0.1
              ((locals (tmp.18 ball.7.1 bat.0.2 ball.8.3 bat.3.4 bar.9.5 ball.6.6 foo.1.7 tmp.17))
               (undead-out ((rsi rdx rcx r8 r9 fv0) (rdx rcx r8 r9 fv0)
                                                    (rcx r8 r9 fv0)
                                                    (r8 r9 fv0 bat.3.4)
                                                    (r9 fv0 bat.3.4)
                                                    (fv0 bat.3.4 bat.0.2)
                                                    (bat.3.4 bat.0.2)
                                                    (bat.0.2 tmp.18)
                                                    (tmp.18)
                                                    (tmp.17)
                                                    ()))
               (conflicts ((tmp.17 ()) (foo.1.7 (fv0 r9 r8 rcx rdx rsi))
                                       (ball.6.6 (fv0 r9 r8 rcx rdx))
                                       (bar.9.5 (fv0 r9 r8 rcx))
                                       (bat.3.4 (ball.7.1 bat.0.2 ball.8.3 fv0 r9 r8))
                                       (ball.8.3 (bat.3.4 fv0 r9))
                                       (bat.0.2 (tmp.18 ball.7.1 bat.3.4 fv0))
                                       (ball.7.1 (bat.0.2 bat.3.4))
                                       (tmp.18 (bat.0.2))
                                       (rsi (foo.1.7))
                                       (rdx (ball.6.6 foo.1.7))
                                       (rcx (bar.9.5 ball.6.6 foo.1.7))
                                       (r8 (bat.3.4 bar.9.5 ball.6.6 foo.1.7))
                                       (r9 (ball.8.3 bat.3.4 bar.9.5 ball.6.6 foo.1.7))
                                       (fv0 (bat.0.2 ball.8.3 bat.3.4 bar.9.5 ball.6.6 foo.1.7)))))
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
        ((locals (bat.3.13 bar.9.8 bat.3.9 foo.5.10 bar.2.11 foo.1.12))
         (undead-out ((rsi rdx rcx r8) (rdx rcx r8) (rcx r8) (r8) () () ()))
         (conflicts ((foo.1.12 (r8 rcx rdx rsi)) (bar.2.11 (r8 rcx rdx))
                                                 (foo.5.10 (r8 rcx))
                                                 (bat.3.9 (r8))
                                                 (bar.9.8 ())
                                                 (bat.3.13 ())
                                                 (rsi (foo.1.12))
                                                 (rdx (bar.2.11 foo.1.12))
                                                 (rcx (foo.5.10 bar.2.11 foo.1.12))
                                                 (r8 (bat.3.9 foo.5.10 bar.2.11 foo.1.12)))))
        (begin
          (set! foo.1.12 rdi)
          (set! bar.2.11 rsi)
          (set! foo.5.10 rdx)
          (set! bat.3.9 rcx)
          (set! bar.9.8 r8)
          (set! bat.3.13 1)
          (halt 9223372036854775807)))
      (define L.fn.2.3
        ((locals (bat.3.16 tmp.19 ball.8.14 ball.7.15))
         (undead-out ((rsi ball.7.15 rbp)
                      (ball.7.15 ball.8.14 rbp)
                      ((ball.7.15 ball.8.14 rbp)
                       ((ball.7.15 ball.8.14 rbp) (ball.7.15 ball.8.14 bat.3.16 rbp)
                                                  (ball.7.15 ball.8.14 bat.3.16 rbp))
                       ((tmp.19 ball.7.15 ball.8.14 rbp) (tmp.19 ball.7.15 ball.8.14 rbp)
                                                         (ball.7.15 ball.8.14 bat.3.16 rbp)))
                      (ball.7.15 ball.8.14 bat.3.16 fv0 rbp)
                      (ball.7.15 ball.8.14 bat.3.16 fv0 r9 rbp)
                      (ball.7.15 ball.8.14 bat.3.16 fv0 r9 r8 rbp)
                      (ball.8.14 bat.3.16 fv0 r9 r8 rcx rbp)
                      (ball.8.14 bat.3.16 fv0 r9 r8 rcx rdx rbp)
                      (bat.3.16 fv0 r9 r8 rcx rdx rsi rbp)
                      (fv0 r9 r8 rcx rdx rsi rdi rbp)
                      (fv0 r9 r8 rcx rdx rsi rdi rbp)))
         (conflicts ((ball.7.15 (r8 fv0 tmp.19 bat.3.16 ball.8.14 rbp rsi))
                     (ball.8.14 (rdx rcx r8 r9 fv0 tmp.19 bat.3.16 rbp ball.7.15))
                     (tmp.19 (rbp ball.8.14 ball.7.15))
                     (bat.3.16 (rsi rdx rcx r8 r9 fv0 rbp ball.8.14 ball.7.15))
                     (rsi (rdi rbp rdx rcx r8 r9 fv0 bat.3.16 ball.7.15))
                     (rbp (rdi rsi rdx rcx r8 r9 fv0 tmp.19 bat.3.16 ball.8.14 ball.7.15))
                     (fv0 (rdi rsi rdx rcx r8 r9 rbp bat.3.16 ball.8.14 ball.7.15))
                     (r9 (rdi rsi rdx rcx r8 rbp fv0 bat.3.16 ball.8.14))
                     (r8 (rdi rsi rdx rcx rbp r9 fv0 bat.3.16 ball.8.14 ball.7.15))
                     (rcx (rdi rsi rdx rbp r8 r9 fv0 bat.3.16 ball.8.14))
                     (rdx (rdi rsi rbp rcx r8 r9 fv0 bat.3.16 ball.8.14))
                     (rdi (rbp rsi rdx rcx r8 r9 fv0)))))
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
  (check-by-interp '(module ((locals (tmp.3 tmp.1 tmp.2))
                             (undead-out (() ((tmp.2) (tmp.2) (tmp.1) ()) (((tmp.3) ()) () ())))
                             (conflicts ((tmp.2 ()) (tmp.1 ()) (tmp.3 ()))))
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
              (tmp.59 foobar.2.41 foobar.2.42 tmp.56 tmp.57 foobar.5.43 tmp.58 foo.6.40 bar.9.44))
             (undead-out (((((rbp) (rbp)) ((((tmp.56 rbp) (rbp)) (foobar.2.42 rbp) (foobar.2.42 rbp))
                                           (foo.6.40 rbp))
                                          ((rbp) ((foobar.5.43 rbp) (foo.6.40 rbp))
                                                 (((tmp.57 rbp) (rbp)) (foo.6.40 rbp)
                                                                       (foo.6.40 rbp))))
                           ((foo.6.40 rbp) ((rbp) (rbp)) ((foo.6.40 tmp.58 rbp) (rbp))))
                          ()
                          (((tmp.59 rbp) (rbp)) (rbp) (rbp))))
             (conflicts ((bar.9.44 (rbp)) (foo.6.40 (rbp tmp.58))
                                          (tmp.58 (rbp foo.6.40))
                                          (foobar.5.43 (rbp))
                                          (tmp.57 (rbp))
                                          (tmp.56 (rbp))
                                          (foobar.2.42 (rbp))
                                          (foobar.2.41 (rbp))
                                          (tmp.59 (rbp))
                                          (rbp (foobar.2.41 tmp.56
                                                            foobar.2.42
                                                            foobar.5.43
                                                            tmp.57
                                                            foo.6.40
                                                            bar.9.44
                                                            tmp.58
                                                            tmp.59)))))
            (define L.x.0.1
              ((locals (ball.8.1 foobar.5.2 foo.6.3 foobar.2.4 foo.3.5 foobar.1.6 ball.0.7))
               (undead-out ((rsi rdx rcx r8 r9 fv0 rbp) (rdx rcx r8 r9 fv0 rbp)
                                                        (rcx r8 r9 fv0 rbp)
                                                        (r8 r9 fv0 rbp)
                                                        (r9 fv0 rbp)
                                                        (fv0 rbp)
                                                        (rbp)
                                                        (rdi rbp)
                                                        (rdi rbp)))
               (conflicts
                ((ball.0.7 (rbp fv0 r9 r8 rcx rdx rsi))
                 (foobar.1.6 (rbp fv0 r9 r8 rcx rdx))
                 (foo.3.5 (rbp fv0 r9 r8 rcx))
                 (foobar.2.4 (rbp fv0 r9 r8))
                 (foo.6.3 (rbp fv0 r9))
                 (foobar.5.2 (rbp fv0))
                 (ball.8.1 (rbp))
                 (rsi (ball.0.7))
                 (rdx (foobar.1.6 ball.0.7))
                 (rcx (foo.3.5 foobar.1.6 ball.0.7))
                 (r8 (foobar.2.4 foo.3.5 foobar.1.6 ball.0.7))
                 (r9 (foo.6.3 foobar.2.4 foo.3.5 foobar.1.6 ball.0.7))
                 (fv0 (foobar.5.2 foo.6.3 foobar.2.4 foo.3.5 foobar.1.6 ball.0.7))
                 (rbp (rdi ball.8.1 foobar.5.2 foo.6.3 foobar.2.4 foo.3.5 foobar.1.6 ball.0.7))
                 (rdi (rbp)))))
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
        ((locals (bar.9.8 foobar.1.9 tmp.45))
         (undead-out ((bar.9.8) (foobar.1.9 bar.9.8) (((foobar.1.9 tmp.45 bar.9.8) (bar.9.8)) () ())))
         (conflicts ((tmp.45 (bar.9.8 foobar.1.9)) (foobar.1.9 (tmp.45)) (bar.9.8 (tmp.45)))))
        (begin
          (set! bar.9.8 9223372036854775807)
          (set! foobar.1.9 bar.9.8)
          (if (begin
                (set! tmp.45 -577997854)
                (>= tmp.45 foobar.1.9))
              (halt -9223372036854775808)
              (halt bar.9.8))))
      (define L.fn.2.3
        ((locals (tmp.46 foobar.1.11 ball.7.10))
         (undead-out ((tmp.46) (tmp.46) (ball.7.10) ((ball.7.10) () (() ()))))
         (conflicts ((ball.7.10 ()) (foobar.1.11 ()) (tmp.46 ()))))
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
        ((locals (ball.7.12 foo.3.13 ball.8.14 foobar.2.15 bar.9.16 foobar.5.17 foobar.4.18))
         (undead-out ((rsi rdx rcx r8 r9 fv0 foobar.4.18 rbp) (rdx rcx r8 r9 fv0 foobar.4.18 rbp)
                                                              (rcx r8 r9 fv0 foobar.4.18 rbp)
                                                              (r8 r9 fv0 foobar.4.18 rbp)
                                                              (r9 fv0 foobar.4.18 rbp)
                                                              (fv0 foobar.4.18 rbp)
                                                              (foobar.4.18 rbp)
                                                              (foobar.4.18 fv0 rbp)
                                                              (fv0 r9 rbp)
                                                              (fv0 r9 r8 rbp)
                                                              (fv0 r9 r8 rcx rbp)
                                                              (fv0 r9 r8 rcx rdx rbp)
                                                              (fv0 r9 r8 rcx rdx rsi rbp)
                                                              (fv0 r9 r8 rcx rdx rsi rdi rbp)
                                                              (fv0 r9 r8 rcx rdx rsi rdi rbp)))
         (conflicts
          ((foobar.4.18
            (ball.7.12 foo.3.13 ball.8.14 foobar.2.15 bar.9.16 foobar.5.17 rbp fv0 r9 r8 rcx rdx rsi))
           (foobar.5.17 (rbp foobar.4.18 fv0 r9 r8 rcx rdx))
           (bar.9.16 (rbp foobar.4.18 fv0 r9 r8 rcx))
           (foobar.2.15 (rbp foobar.4.18 fv0 r9 r8))
           (ball.8.14 (rbp foobar.4.18 fv0 r9))
           (foo.3.13 (rbp foobar.4.18 fv0))
           (ball.7.12 (rbp foobar.4.18))
           (rsi (rdi rbp rdx rcx r8 r9 fv0 foobar.4.18))
           (rdx (rdi rsi rbp rcx r8 r9 fv0 foobar.5.17 foobar.4.18))
           (rcx (rdi rsi rdx rbp r8 r9 fv0 bar.9.16 foobar.5.17 foobar.4.18))
           (r8 (rdi rsi rdx rcx rbp r9 fv0 foobar.2.15 bar.9.16 foobar.5.17 foobar.4.18))
           (r9 (rdi rsi rdx rcx r8 rbp fv0 ball.8.14 foobar.2.15 bar.9.16 foobar.5.17 foobar.4.18))
           (fv0 (rdi rsi
                     rdx
                     rcx
                     r8
                     r9
                     rbp
                     foo.3.13
                     ball.8.14
                     foobar.2.15
                     bar.9.16
                     foobar.5.17
                     foobar.4.18))
           (rbp (rdi rsi
                     rdx
                     rcx
                     r8
                     r9
                     fv0
                     ball.7.12
                     foo.3.13
                     ball.8.14
                     foobar.2.15
                     bar.9.16
                     foobar.5.17
                     foobar.4.18))
           (rdi (rbp rsi rdx rcx r8 r9 fv0)))))
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
        ((locals (foobar.4.19)) (undead-out ((foobar.4.19 rbp) (foobar.4.19 fv0 rbp)
                                                               (foobar.4.19 fv0 r9 rbp)
                                                               (foobar.4.19 fv0 r9 r8 rbp)
                                                               (foobar.4.19 fv0 r9 r8 rcx rbp)
                                                               (foobar.4.19 fv0 r9 r8 rcx rdx rbp)
                                                               (fv0 r9 r8 rcx rdx rsi rbp)
                                                               (fv0 r9 r8 rcx rdx rsi rdi rbp)
                                                               (fv0 r9 r8 rcx rdx rsi rdi rbp)))
                                (conflicts ((foobar.4.19 (rcx rbp))
                                            (rbp (rdi rsi rdx rcx r8 r9 fv0 foobar.4.19))
                                            (fv0 (rdi rsi rdx rcx r8 r9 rbp))
                                            (r9 (rdi rsi rdx rcx r8 rbp fv0))
                                            (r8 (rdi rsi rdx rcx rbp r9 fv0))
                                            (rcx (rdi rsi rdx rbp r8 r9 fv0 foobar.4.19))
                                            (rdx (rdi rsi rbp rcx r8 r9 fv0))
                                            (rsi (rdi rbp rdx rcx r8 r9 fv0))
                                            (rdi (rbp rsi rdx rcx r8 r9 fv0)))))
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
                           foo.3.24))
         (undead-out
          ((rsi rdx rcx r8 r9 foo.6.25 rbp)
           (rdx rcx r8 r9 foo.6.25 foo.3.24 rbp)
           (rcx r8 r9 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (r8 r9 bar.9.22 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (r9 bar.9.22 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (bar.9.22 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (foobar.1.27 bar.9.22 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (foobar.1.27 bar.9.22 foo.6.25 foo.3.24 foobar.4.23 rbp)
           (bar.9.22 foo.6.25 foo.3.24 foobar.5.26 foobar.4.23 rbp)
           (((foo.6.25 foo.3.24 foobar.5.26 foobar.4.23 rbp) (foo.3.24 foobar.5.26 foobar.4.23 rbp))
            ((foo.3.24 foobar.5.26 foobar.4.23 fv0 rbp) (foo.3.24 foobar.5.26 foobar.4.23 fv0 r9 rbp)
                                                        (foobar.5.26 foobar.4.23 fv0 r9 r8 rbp)
                                                        (foobar.4.23 fv0 r9 r8 rcx rbp)
                                                        (fv0 r9 r8 rcx rdx rbp)
                                                        (fv0 r9 r8 rcx rdx rsi rbp)
                                                        (fv0 r9 r8 rcx rdx rsi rdi rbp)
                                                        (fv0 r9 r8 rcx rdx rsi rdi rbp))
            ())))
         (conflicts
          ((foo.3.24 (foobar.5.26 foobar.1.27
                                  foobar.5.20
                                  foobar.1.21
                                  bar.9.22
                                  foobar.4.23
                                  rbp
                                  foo.6.25
                                  r8
                                  rcx
                                  rdx
                                  ball.8.29
                                  r9
                                  fv0))
           (foo.6.25 (foobar.5.26 foo.6.28
                                  foobar.1.27
                                  foobar.5.20
                                  foobar.1.21
                                  bar.9.22
                                  foobar.4.23
                                  foo.3.24
                                  rbp
                                  r9
                                  r8
                                  rcx
                                  rdx
                                  rsi
                                  ball.8.29))
           (bar.9.22
            (foobar.5.26 foo.6.28 foobar.5.20 foobar.1.21 rbp foobar.4.23 foo.3.24 foo.6.25 r9 r8))
           (ball.8.29 (rbp foobar.4.23 foobar.5.26 foo.3.24 foo.6.25))
           (foobar.4.23 (foobar.5.26 foo.6.28
                                     foobar.1.27
                                     foobar.5.20
                                     foobar.1.21
                                     bar.9.22
                                     rbp
                                     foo.3.24
                                     foo.6.25
                                     ball.8.29
                                     rcx
                                     r8
                                     r9
                                     fv0))
           (foobar.5.26 (rbp foobar.4.23 foo.3.24 foo.6.25 bar.9.22 ball.8.29 r8 fv0))
           (foobar.1.21 (rbp foobar.4.23 foo.3.24 foo.6.25 bar.9.22 r9))
           (foobar.5.20 (rbp foobar.4.23 foo.3.24 foo.6.25 bar.9.22))
           (foobar.1.27 (foo.6.28 rbp foobar.4.23 foo.3.24 foo.6.25))
           (foo.6.28 (rbp foobar.4.23 foo.6.25 bar.9.22 foobar.1.27))
           (fv0 (rdi rsi rdx rcx r8 r9 rbp foobar.4.23 foobar.5.26 foo.3.24))
           (rbp (foobar.5.26 foo.6.28
                             foobar.1.27
                             foobar.5.20
                             foobar.1.21
                             bar.9.22
                             foobar.4.23
                             foo.3.24
                             foo.6.25
                             ball.8.29
                             rdi
                             rsi
                             rdx
                             rcx
                             r8
                             r9
                             fv0))
           (r9 (foobar.1.21 bar.9.22 foo.6.25 rdi rsi rdx rcx r8 rbp fv0 foobar.4.23 foo.3.24))
           (r8 (bar.9.22 foo.3.24 foo.6.25 rdi rsi rdx rcx rbp r9 fv0 foobar.4.23 foobar.5.26))
           (rcx (foo.3.24 foo.6.25 rdi rsi rdx rbp r8 r9 fv0 foobar.4.23))
           (rdx (foo.3.24 foo.6.25 rdi rsi rbp rcx r8 r9 fv0))
           (rsi (foo.6.25 rdi rbp rdx rcx r8 r9 fv0))
           (rdi (rbp rsi rdx rcx r8 r9 fv0)))))
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
                              ball.0.37))
         (undead-out ((rsi rdx rcx r8 r9 fv0 foobar.2.36)
                      (rdx rcx r8 r9 fv0 foobar.2.36)
                      (rcx r8 r9 fv0 foobar.2.36)
                      (r8 r9 fv0 foobar.2.36)
                      (r9 fv0 foobar.2.36)
                      (fv0 foobar.2.36)
                      (foobar.2.36)
                      (((foobar.2.36) ((foobar.2.36) ((tmp.47 foobar.2.36) (foobar.2.36)))
                                      ((tmp.48 foobar.2.36) (foobar.2.36)))
                       ((foobar.2.36 tmp.49) (tmp.49) () (foobar.1.39) ())
                       ())))
         (conflicts ((ball.0.37 ())
                     (foobar.2.36 (foobar.5.30 foobar.1.31
                                               foo.3.32
                                               ball.8.33
                                               ball.0.34
                                               foo.6.35
                                               fv0
                                               r9
                                               r8
                                               rcx
                                               rdx
                                               rsi
                                               tmp.47
                                               tmp.48))
                     (tmp.47 (foobar.2.36))
                     (tmp.48 (foobar.2.36))
                     (ball.8.38 ())
                     (tmp.49 ())
                     (foobar.1.39 ())
                     (foo.6.35 (foobar.2.36 fv0 r9 r8 rcx rdx))
                     (ball.0.34 (foobar.2.36 fv0 r9 r8 rcx))
                     (ball.8.33 (foobar.2.36 fv0 r9 r8))
                     (foo.3.32 (foobar.2.36 fv0 r9))
                     (foobar.1.31 (foobar.2.36 fv0))
                     (foobar.5.30 (foobar.2.36))
                     (rsi (foobar.2.36))
                     (rdx (foo.6.35 foobar.2.36))
                     (rcx (ball.0.34 foo.6.35 foobar.2.36))
                     (r8 (ball.8.33 ball.0.34 foo.6.35 foobar.2.36))
                     (r9 (foo.3.32 ball.8.33 ball.0.34 foo.6.35 foobar.2.36))
                     (fv0 (foobar.1.31 foo.3.32 ball.8.33 ball.0.34 foo.6.35 foobar.2.36)))))
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
        ((locals (tmp.52 tmp.53 tmp.54 tmp.55 tmp.50 tmp.51))
         (undead-out ((rbp) (((tmp.50 rbp) (rbp)) ((r9 rbp) (r9 r8 rbp)
                                                            (r9 r8 rcx rbp)
                                                            (r9 r8 rcx rdx rbp)
                                                            (r9 r8 rcx rdx rsi rbp)
                                                            (r9 r8 rcx rdx rsi rdi rbp)
                                                            (r9 r8 rcx rdx rsi rdi rbp))
                                                  (((tmp.51) ()) () ()))
                            ((((tmp.52 rbp) (rbp)) ((tmp.53 rbp) (rbp)) ((tmp.54 rbp) (rbp)))
                             (rbp)
                             (((tmp.55) ()) () ()))))
         (conflicts ((tmp.51 ()) (tmp.50 (rbp))
                                 (tmp.55 ())
                                 (tmp.54 (rbp))
                                 (tmp.53 (rbp))
                                 (tmp.52 (rbp))
                                 (rbp (tmp.50 rdi rsi rdx rcx r8 r9 tmp.52 tmp.53 tmp.54))
                                 (r9 (rdi rsi rdx rcx r8 rbp))
                                 (r8 (rdi rsi rdx rcx rbp r9))
                                 (rcx (rdi rsi rdx rbp r8 r9))
                                 (rdx (rdi rsi rbp rcx r8 r9))
                                 (rsi (rdi rbp rdx rcx r8 r9))
                                 (rdi (rbp rsi rdx rcx r8 r9)))))
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

  (define-syntax-rule (check-minimum& lst valueof kont expected)
    (check-equal? (minimum& lst valueof kont)
                  expected
                  (format "checking minimum&: \n (check-equal? (minimum& ~a ~a ~a) ~a)"
                          lst
                          valueof
                          kont
                          expected)))

  (check-minimum& '() identity identity (void))
  (check-minimum& '(1) identity identity 1)
  (check-minimum& '(1 2 3) - identity 3)
  (check-minimum& '(1 2 3) - add1 4)
  (check-minimum& '(1 2 3) sub1 identity 1)

  (define-syntax-rule (check-num-values lst expected)
    (check-equal? (num-values lst)
                  expected
                  (format "checking num-values: \n (check-equal? (num-values ~a) ~a)" lst expected)))

  (check-num-values `(x ()) 0)
  (check-num-values `(x (1)) 1)
  (check-num-values `(x (1 2)) 2)
  (check-num-values `(x (1 2 3)) 3)
  (check-num-values `(x (x y z)) 3)
  (check-num-values (list ":)"
                          (list "We are no stranger to love"
                                "You know the rules and so do I"
                                "a full commitment's what I'm thinking of"
                                "You wouldn't get this from any other guy"
                                "I / Just want to tell you how I am feeling"
                                "Gotta make you understand"
                                "Never gonna give you up"
                                "Never gonna let you down"
                                "Never gonna run around and"
                                "desert you."))
                    10)

  (define (check-remove-from-loy pair val expected)
    (check-equal?
     (remove-from-loy pair val)
     expected
     (format "checking remove-from-loy: (remove-from-loy ~a ~a) = ~a" pair val expected)))

  (check-remove-from-loy '(x ()) 'x '(x ()))
  (check-remove-from-loy '(x (x y)) 'x '(x (y)))
  (check-remove-from-loy '(x (x x)) 'x '(x (x)))
  (check-remove-from-loy '(x (x y)) 'z '(x (x y)))

  (define-syntax-rule (check-assign-registers p expected pred)
    (check-match (assign-registers p) expected pred))

  (parameterize ([current-assignable-registers '(r15)])
    (check-assign-registers '(module ((locals (x.1)) (conflicts ((x.1 ()))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            `(module ((locals (x.1)) (conflicts ((x.1 ()))) (assignment ((x.1 r15))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            #t))
  (parameterize ([current-assignable-registers '(r9)])
    (check-assign-registers '(module ((locals (x.1)) (conflicts ((x.1 ()))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            '(module ((locals (x.1)) (conflicts ((x.1 ()))) (assignment ((x.1 r9))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            #t))
  (parameterize ([current-assignable-registers '()])
    (check-assign-registers '(module ((locals (x.1)) (conflicts ((x.1 ()))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            '(module ((locals (x.1)) (conflicts ((x.1 ()))) (assignment ((x.1 fv0))))
                                     (begin
                                       (set! x.1 42)
                                       (halt x.1))
                               )
                            #t))

  ;; it is hard to use example output as there are multiple valid outputs
  ;; conflict assignments -> boolean
  ;; returns true if the aloc does not share a register with its conflicting alocs.
  (define (no-conflicts? conflict assignments)
    (define (lookup aloc)
      (info-ref assignments aloc))
    (match-let ([`(,aloc ,aloc-conflict) conflict])
      (not (memq (lookup aloc) (map lookup aloc-conflict)))))

  (check-assign-registers
   '(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
             (conflicts ((x.3 (z.5 p.1 y.4 v.1 w.2)) (w.2 (z.5 p.1 y.4 v.1 x.3))
                                                     (v.1 (w.2 x.3))
                                                     (y.4 (t.6 z.5 p.1 w.2 x.3))
                                                     (p.1 (t.6 z.5 y.4 w.2 x.3))
                                                     (z.5 (t.6 p.1 y.4 w.2 x.3))
                                                     (t.6 (z.5 p.1 y.4)))))
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
      )
   `(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1)) (conflicts ,conflicts) (assignment ,a2))
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
      )
   (andmap (λ (conflict) (no-conflicts? conflict a2)) conflicts))
  ; fully connected graph(ie. full conflicts)
  (parameterize ([current-assignable-registers '(rax rdx rcx)])
    (check-assign-registers
     '(module ((locals (x.1 x.2 x.3)) (conflicts ((x.1 (x.2 x.3)) (x.2 (x.1 x.3)) (x.3 (x.2 x.1)))))
              (begin
                (halt 1))
        )
     `(module ((locals (x.1 x.2 x.3)) (conflicts ((x.1 (x.2 x.3)) (x.2 (x.1 x.3)) (x.3 (x.2 x.1))))
                                      (assignment ,a2))
              (begin
                (halt 1))
        )
     (andmap (not/c fvar?) (map cadr a2)))))
