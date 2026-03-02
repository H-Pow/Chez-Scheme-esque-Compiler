#lang racket

(require cpsc411/compiler-lib)
(provide impose-calling-conventions)

; proc-imp-cmf-lang-v5 :
;   p	 	::=
; (module (define label (lambda (aloc ...) tail)) ...
;         tail)
;   pred	 	::=	 	(relop opand opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(begin effect ... pred)
;  	 	|	 	(if pred pred pred)
;   tail	 	::=	 	value
;  	 	|	 	(call triv opand ...)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if pred tail tail)
;   value	 	::=	 	triv
;  	 	|	 	(binop opand opand)
;   effect	 	::=	 	(set! aloc value)
;  	 	|	 	(begin effect ... effect)
;  	 	|	 	(if pred effect effect)
;   opand	 	::=	 	int64
;  	 	|	 	aloc
;   triv	 	::=	 	opand
;  	 	|	 	label
;   binop	 	::=	 	*
;  	 	|	 	+
;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=
;   aloc	 	::=	 	aloc?
;   label	 	::=	 	label?
;   int64	 	::=	 	int64?
;; ---------------------------------
;   imp-cmf-lang-v5 : grammar?
;   p	 	::=	 	(module (define label tail) ... tail)
;   pred	 	::=	 	(relop opand opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(begin effect ... pred)
;  	 	|	 	(if pred pred pred)
;   tail	 	::=	 	value
;  	 	|	 	(jump trg loc ...)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if pred tail tail)
;   value	 	::=	 	triv
;  	 	|	 	(binop opand opand)
;   effect	 	::=	 	(set! loc value)
;  	 	|	 	(begin effect ... effect)
;  	 	|	 	(if pred effect effect)
;   opand	 	::=	 	int64
;  	 	|	 	loc
;   triv	 	::=	 	opand
;  	 	|	 	label
;   loc	 	::=	 	rloc
;  	 	|	 	aloc
;   trg	 	::=	 	label
;  	 	|	 	loc
;   binop	 	::=	 	*
;  	 	|	 	+
;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=
;   aloc	 	::=	 	aloc?
;   label	 	::=	 	label?
;   rloc	 	::=	 	register?
;  	 	|	 	fvar?
;   int64	 	::=	 	int64?

(define rloc? (or/c register? fvar?))
(define opand/proc-imp-cmf-lang-v5? (or/c int64? aloc?))
(define opand/imp-cmf-lang-v5? (or/c int64? aloc? rloc?))
(define triv/proc-imp-cmf-lang-v5? (or/c opand/proc-imp-cmf-lang-v5? label?))
(define triv/imp-cmf-lang-v5? (or/c opand/imp-cmf-lang-v5? label?))

;; proc-imp-cmf-lang-v5 -> imp-cmf-lang-v5
;; Compiles Proc-imp-cmf-lang v5 to Imp-cmf-lang v5
;;     by imposing calling conventions on all calls and procedure definitions.
;;     The parameter registers are defined by the list current-parameter-registers.
(define (impose-calling-conventions picl5)
  ; (listof opand) -> (listof rloc)
  ;  generates a list of rlocs to for each aloc, following the calling convention
  (define (generate-param-list aloc*)
    (define num-param-reg (length (current-parameter-registers)))
    (define (get-reg-or-fvar idx)
      (if (< idx num-param-reg)
          (list-ref (current-parameter-registers) idx)
          (make-fvar (- idx num-param-reg))))
    (map get-reg-or-fvar (range (length aloc*))))

  ; (listof X) (listof Y) -> (listof `(set ,X ,Y))
  ;  generates a list of set! expressions given X and Y
  (define (generate-sets X* Y*)
    (map (λ (x y) `(set! ,x ,y)) X* Y*))

  (define (impose-define label aloc* tail)
    `(define ,label
       (begin
         ,@(generate-sets aloc* (generate-param-list aloc*))
         ,(impose-tail tail))))

  (define (impose-tail tail)
    (match tail
      [`(call ,(? triv/proc-imp-cmf-lang-v5? triv) ,(? opand/proc-imp-cmf-lang-v5? opand*) ...)
       (define loc* (generate-param-list opand*))
       `(begin
          ,@(generate-sets loc* opand*)
          (jump ,triv rbp ,@loc*))]
      [`(begin
          ,fx* ...
          ,tail)
       `(begin
          ,@fx*
          ,(impose-tail tail))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,pred
            ,(impose-tail tail1)
            ,(impose-tail tail2))]
      [value value]))

  (define (impose-p p)
    (match p
      [`(module (define ,(? label? label*)
                  (lambda (,(? aloc? aloc**) ...) ,tail*))
                ...
          ,tail)
       `(module ,@(map impose-define label* aloc** tail*) ,(impose-tail tail)
          )]))

  (impose-p picl5))

(module+ test
  (require rackunit
           cpsc411/langs/v5)

  (define-syntax-rule (check picl5 icl5)
    (check-equal? (impose-calling-conventions picl5) icl5))
  (define-syntax-rule (check-by-interp picl5)
    (check-eq? (interp-proc-imp-cmf-lang-v5 picl5)
               (interp-imp-cmf-lang-v5 (impose-calling-conventions picl5))))
  (define-syntax-rule (check/full picl5 icl5)
    (begin
      (check picl5 icl5)
      (check-by-interp picl5)))

  ;; !!! Added by Trevor on March 2nd 2026

  (check-by-interp '(module (define L.L.func.0.1.4 (lambda () 0))
                            (define L.L.tmp.1.2.5 (lambda (foo.2.1.5) (call L.L.func.0.1.4)))
                      (define L.L.func.2.3.6
                        (lambda ()
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
                (if (!= -302047143 0)
                    (set! bar.3.3.7 9223372036854775807)
                    (set! bar.3.3.7 102036653))
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
                                (if (<= -2033705372 965540822)
                                    (set! bat.0.3.7 -1853172774)
                                    (set! bat.0.3.7 1133506028))
                                (begin
                                  (set! foo.4.4.8 1)
                                  1236904416))
                              (call L.L.func.1.2.5))))
                      (call L.L.proc.0.1.4 1)))
  (check-by-interp '(module (define L.fn.0.1
                              (lambda ()
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
                                (call L.fn.0.1))
                      ))
  (check-by-interp '(module (+ -9223372036854775808 -1465538260)))
  (check-by-interp '(module (define L.fn.0.1
                              (lambda ()
                                (begin
                                  (set! bar.2.1 (+ 1 9223372036854775807))
                                  (begin
                                    (begin
                                      (set! foo.1.3 bar.2.1)
                                      (set! foo.8.2 foo.1.3))
                                    bar.2.1))))
                            (define L.func.1.2
                              (lambda ()
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
  (check-by-interp '(module (define L.x.0.1 (lambda (ball.1.2 foo.0.1) (call L.tmp.1.2)))
                            (define L.tmp.1.2
                              (lambda ()
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
                      (define L.func.2.3 (lambda (ball.4.7 ball.6.6) (call L.tmp.1.2)))
                      (if (<= 0 1) -1271132888 2101306416)))
  (check-by-interp '(module (define L.proc.0.1
                              (lambda (bar.8.1)
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
                              (lambda (ball.3.1)
                                (if (not (false))
                                    (call L.x.1.2)
                                    (begin
                                      (begin
                                        (set! bat.9.3 ball.3.1)
                                        (set! foobar.4.2 9223372036854775807))
                                      (+ -9223372036854775808 ball.3.1)))))
                            (define L.x.1.2 (lambda () 1))
                      (begin
                        (begin
                          (set! ball.1.5 453798193)
                          (set! foobar.4.4 ball.1.5))
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
                                  (begin
                                    (set! ball.4.11 foo.7.7)
                                    (begin
                                      (set! foobar.5.12 ball.1.9)
                                      (set! bar.3.10 -9223372036854775808)))
                                  (call L.proc.0.1 bar.3.10 -780648786 bar.3.10))))
                      (begin
                        (set! bat.0.13 -579691794)
                        953357957)))
  (check-by-interp '(module (begin
                              (begin
                                (set! ball.2.2 9223372036854775807)
                                (set! bar.5.1 -546026276))
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
                                  (begin
                                    (set! bat.4.4 (* 1 9223372036854775807))
                                    (set! bar.9.3 (+ -9223372036854775808 bat.4.4)))
                                  (begin
                                    (set! bat.4.5 9223372036854775807)
                                    (if (!= 1 bar.9.3) 9223372036854775807 ball.7.1)))))
                            (define L.x.1.2
                              (lambda (bat.2.6)
                                (begin
                                  (begin
                                    (set! bat.4.8 (+ -1410706204 bat.2.6))
                                    (begin
                                      (set! bat.2.9 1)
                                      (set! foobar.3.7 -9223372036854775808)))
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
            (if (begin
                  (set! ball.2.25 258314756)
                  (!= bar.8.19 0))
                (set! foobar.3.24 bar.8.19)
                (begin
                  (set! foo.6.26 -1809848824)
                  (set! foobar.3.24 9223372036854775807)))
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
                            (if (>= ball.7.15 1)
                                (if (= ball.7.15 ball.7.15)
                                    (set! bat.3.16 ball.8.14)
                                    (set! bat.3.16 214741259))
                                (set! bat.3.16 (+ 1683358713 ball.8.14)))
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
            (begin
              (set! foobar.1.27 bar.9.22)
              (begin
                (set! foo.6.28 foo.3.24)
                (set! foobar.5.26 foobar.1.27)))
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
              (call L.fn.2.3)
              (call L.fn.2.3)))))
  ;; !!!

  (parameterize ([current-parameter-registers '(r9)])
    (check/full `(module (define L.a.0 (lambda (x.1) x.1)) (call L.a.0 1)
                   )
                `(module (define L.a.0
                           (begin
                             (set! x.1 r9)
                             x.1))
                         (begin
                           (set! r9 1)
                           (jump L.a.0 rbp r9))
                   )))
  (parameterize ([current-parameter-registers '()])
    (check/full `(module (define L.a.0 (lambda (x.1) x.1)) (call L.a.0 1)
                   )
                `(module (define L.a.0
                           (begin
                             (set! x.1 fv0)
                             x.1))
                         (begin
                           (set! fv0 1)
                           (jump L.a.0 rbp fv0))
                   )))

  (parameterize ([current-parameter-registers '(rdi rsi rdx)])
    (check/full `(module (define L.fact.0
                           (lambda (x.1 acc.1)
                             (if (> acc.1 0)
                                 (begin
                                   (set! acc.1 (* acc.1 x.1))
                                   (set! x.1 (+ x.1 -1))
                                   (call L.fact.0 x.1 acc.1))
                                 acc.1)))
                         (call L.fact.0 5 1)
                   )
                `(module (define L.fact.0
                           (begin
                             (set! x.1 rdi)
                             (set! acc.1 rsi)
                             (if (> acc.1 0)
                                 (begin
                                   (set! acc.1 (* acc.1 x.1))
                                   (set! x.1 (+ x.1 -1))
                                   (begin
                                     (set! rdi x.1)
                                     (set! rsi acc.1)
                                     (jump L.fact.0 rbp rdi rsi)))
                                 acc.1)))
                         (begin
                           (set! rdi 5)
                           (set! rsi 1)
                           (jump L.fact.0 rbp rdi rsi))
                   ))))
