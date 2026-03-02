#lang racket

(require cpsc411/compiler-lib
         cpsc411/langs/v5)

(provide uniquify
         interp-values-lang)

(define (binop? op)
  (or (equal? op '+) (equal? op '*)))

(define (binop->fun op)
  (match op
    ['+ x64-add]
    ['* x64-mul]))
(define triv? (or/c name? int64?))

; values-lang-v5
;   p	 	::=	 	(module (define x (lambda (x ...) tail)) ... tail)

;   pred	 	::=	 	(relop triv triv)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(let ([x value] ...) pred)
;  	 	|	 	(if pred pred pred)

;   tail	 	::=	 	value
;  	 	|	 	(let ([x value] ...) tail)
;  	 	|	 	(if pred tail tail)
;  	 	|	 	(call x triv ...)

;   value	 	::=	 	triv
;  	 	|	 	(binop triv triv)
;  	 	|	 	(let ([x value] ...) value)
;  	 	|	 	(if pred value value)

;   triv	 	::=	 	int64
;  	 	|	 	x

;   x	 	::=	 	name?

;   binop	 	::=	 	*
;  	 	|	 	+

;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=

;   int64	 	::=	 	int64?

(define (interp-values-lang vl3)
  (define (interp-triv triv env)
    (match triv
      [(? name?) (dict-ref env triv (λ () (error "not defined: ~a" triv)))]
      [(? int64?) triv]))
  (define (interp-tail tail env)
    (match tail
      [`(let ([,x* ,value*] ...) ,tail)
       (define val+ (map (λ (val) (interp-tail val env)) value*))
       (define env+ (foldl (λ (x val env) (dict-set env x val)) env x* val+))
       (interp-tail tail env+)]
      [`(,(? binop? binop) ,(? triv? triv) ,(? triv? triv2))
       ((binop->fun binop) (interp-triv triv env) (interp-triv triv2 env))]
      [(? triv?) (interp-triv tail env)]))
  (let _ ([p vl3]
          [env '()])
    (match p
      [`(module ,tail) (interp-tail tail env)])))

;---------------------
; values-unique-lang-v5
;  p	 	::=	 	(module (define label (lambda (aloc ...) tail)) ... tail)
;   pred	 	::=	 	(relop opand opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(let ([aloc value] ...) pred)
;  	 	|	 	(if pred pred pred)
;   tail	 	::=	 	value
;  	 	|	 	(let ([aloc value] ...) tail)
;  	 	|	 	(if pred tail tail)
;  	 	|	 	(call triv opand ...)
;   value	 	::=	 	triv
;  	 	|	 	(binop opand opand)
;  	 	|	 	(let ([aloc value] ...) value)
;  	 	|	 	(if pred value value)
;   opand	 	::=	 	int64
;  	 	|	 	aloc
;   triv	 	::=	 	opand
;  	 	|	 	label
;   binop	 	::=	 	* | +
;   relop	 	::=	 	< | <= | = >= | > | !=
;   aloc	 	::=	 	aloc?
;   label	 	::=	 	label?
;   int64	 	::=	 	int64?

; values-lang-v5 -> values-unique-lang-v5
(define (uniquify vlv5)
  (define proc-env (make-hash))

  ; let env be a dict which maps (procedure-name : label)
  ;; name -> label
  (define (proc-name->label proc-name)
    (dict-ref! proc-env proc-name (fresh-label proc-name)))

  ; let env be a dict which maps name to aloc
  ; name env -> aloc
  (define (name->aloc x arg-env)
    (hash-ref arg-env x (λ () (error (format "undefined: ~a" x)))))

  ;; Takes triv in argument position and assigns aloc if triv is a name, otherwise returns
  ;; triv if triv is int64.
  ;; (values-lang-v5 triv?) -> (values-lang-v5 triv | int64)
  (define (triv->arg arg arg-env)
    (if (int64? arg)
        arg
        (name->aloc arg arg-env)))

  ; values-lang-v5-triv env -> values-unique-lang-v5-triv
  (define (uniquify-triv triv env)
    (match triv
      [(? int64?) triv]
      [(? name?) (hash-ref env triv (λ () (error (format "undefined: ~a" triv))))]))

  ; (listof values-lang-v5-name) (listof value-lang-v5-value) env ->
  ;     (list (listof (list values-unique-lang-v5-name values-unique-lang-v5-value)) env)
  (define (uniquify-pairs xs vals arg-env)
    (when (not (equal? (set-count (list->set xs)) (length xs)))
      (error (format "duplicate declaration in the same let: ~a" xs)))
    (define alocs (map fresh xs))
    (define bindings (map (λ (aloc val) (list aloc (uniquify-value val arg-env))) alocs vals))
    (define new-env
      (for/fold ([env arg-env])
                ([x xs]
                 [aloc alocs])
        (hash-set env x aloc)))
    (values bindings new-env))

  (define (uniquify-pred pred env)
    (match pred
      [`(,relop ,triv1 ,triv2)
       #:when (memq relop '(< <= = >= > !=))
       `(,relop ,(uniquify-triv triv1 env) ,(uniquify-triv triv2 env))]
      [`(not ,pred) `(not ,(uniquify-pred pred env))]
      [`(let ([,xs ,vals] ...) ,pred)
       ;    #:when ((listof name?) xs) ;; isn't it guaranteed to be (listof name) ?
       (let-values ([(bindings new-env) (uniquify-pairs xs vals env)])
         `(let ,bindings ,(uniquify-pred pred new-env)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-pred pred2 env)
            ,(uniquify-pred pred3 env))]
      [_ pred]))

  ; values-lang-v5-value env -> values-unique-lang-v5-value
  (define (uniquify-value value env)
    (match value
      [`(let ([,xs ,vals] ...) ,value)
       (let-values ([(bindings new-env) (uniquify-pairs xs vals env)])
         `(let ,bindings ,(uniquify-value value new-env)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-value pred2 env)
            ,(uniquify-value pred3 env))]
      ;; reordered to disambiguate with (if) instead

      [`(,binop ,triv1 ,triv2)
       #:when (and (binop? binop) (triv? triv1) (triv? triv2))
       `(,binop ,(uniquify-triv triv1 env) ,(uniquify-triv triv2 env))]
      [(? triv?) (uniquify-triv value env)])) ;;

  (define (uniquify-tail tail arg-env)
    (match tail
      [`(let ([,xs ,vals] ...) ,tail)
       ;#:when ((listof name?) xs) ;; is this necessary?
       (let-values ([(bindings new-env) (uniquify-pairs xs vals arg-env)])
         `(let ,bindings ,(uniquify-tail tail new-env)))]
      [`(if ,pred ,t1 ,t2)
       `(if ,(uniquify-pred pred arg-env)
            ,(uniquify-tail t1 arg-env)
            ,(uniquify-tail t2 arg-env))]
      ;; call to function x, with trivs as args
      [`(call ,x ,trivs ...)
       `(call ,(proc-name->label x) ,@(map (λ (arg) (triv->arg arg arg-env)) trivs))]
      [_ (uniquify-value tail arg-env)]))

  (define (uniquify-definitions def)
    (match def
      [`(define ,proc-name (lambda (,args ...) ,tail))
       (define alocs (map fresh args))
       (define arg-env
         (for/fold ([env (hash)])
                   ([arg args]
                    [aloc alocs])
           (hash-set env arg aloc)))
       `(define ,(proc-name->label proc-name)
          (lambda ,alocs ,(uniquify-tail tail arg-env)))]))

  ; (values-lang-v5-p env) -> (values-unique-lang-v5 p)
  (define (uniquify-p p)
    (match p
      [`(module ,defs ...
          ,tail)
       `(module ,@(map (λ (def) (uniquify-definitions def)) defs) ,(uniquify-tail tail (hash))
          )]))

  (uniquify-p vlv5))

(module+ test
  (require rackunit
           cpsc411/langs/v5)
  (define-syntax-rule (check-by-interp vlv5)
    (check-equal? (interp-values-lang-v5 vlv5) (interp-values-unique-lang-v5 (uniquify vlv5))))

  (check-by-interp '(module (define proc.0 (lambda (ball.3) (call proc.0 9223372036854775807)))
                            (define x.1
                              (lambda (ball.3 ball.6)
                                (if (if (if (!= ball.6 ball.6)
                                            (>= ball.3 ball.3)
                                            (<= -763864902 9223372036854775807))
                                        (< 1 1)
                                        (false))
                                    (let ([ball.1 (+ ball.3 -9223372036854775808)]) 598366993)
                                    (* 9223372036854775807 ball.3))))
                      (define tmp.2
                        (lambda (ball.6 foo.9)
                          (if (true)
                              (let ([ball.1 (+ 1 -9223372036854775808)]) 1)
                              (* foo.9 foo.9))))
                      (if (let ([ball.4 2083024360]) (<= 1 ball.4))
                          (+ 0 1)
                          (call x.1 -390453851 1))))

  (check-by-interp '(module (define fn.0 (lambda (foo.3 bat.7) (call tmp.1 0 bat.7)))
                            (define tmp.1
                              (lambda (ball.2 foo.1) (call func.2 9223372036854775807 foo.1)))
                      (define func.2
                        (lambda (foo.6 bat.7)
                          (let ([foobar.9 foo.6])
                            (let ([foobar.8 (if (< 0 9223372036854775807) 0 -1879014922)])
                              (if (= 1 1) foobar.9 foobar.9)))))
                      (if (<= 9223372036854775807 9223372036854775807) 0 0)))

  (check-by-interp '(module (define proc.0
                              (lambda (ball.0 ball.3)
                                (if (if (not (>= 1676206373 ball.0))
                                        (not (>= -9223372036854775808 ball.0))
                                        (false))
                                    (call fn.2)
                                    (+ -679407720 -1670539202))))
                            (define proc.1 (lambda (bat.6 bar.5) (call proc.0 -2030614437 1)))
                      (define fn.2
                        (lambda ()
                          (let ([bat.6 (* -9223372036854775808 -1564619175)])
                            (if (not (<= bat.6 9223372036854775807))
                                (call fn.2)
                                (call proc.1 -9223372036854775808 9223372036854775807)))))
                      (let ([bat.7 760052997]) (+ 9223372036854775807 9223372036854775807))))

  (check-by-interp '(module (define x.0
                              (lambda (ball.3 foobar.2)
                                (let ([foobar.4 -9223372036854775808])
                                  (call x.0 -939287079 foobar.2))))
                            1542811121
                      ))

  (check-by-interp '(module (define x.0
                              (lambda (ball.4 ball.5)
                                (if (>= -663003513 946817357)
                                    (if (if (> -9223372036854775808 0)
                                            (= 9223372036854775807 ball.4)
                                            (< ball.5 -9223372036854775808))
                                        (if (>= ball.5 9223372036854775807) 0 ball.4)
                                        (let ([ball.4 -467213902]) ball.4))
                                    (if (false)
                                        (if (= ball.4 0) -9223372036854775808 -9223372036854775808)
                                        (if (> ball.5 0) 271081552 9223372036854775807)))))
                            (define tmp.1
                              (lambda (ball.5)
                                (let ([ball.9 ball.5])
                                  (let ([bat.6 9223372036854775807]) (call tmp.1 ball.9)))))
                      (define proc.2
                        (lambda ()
                          (let ([foo.1 (if (if (> 1458486403 645932820)
                                               (!= 1 1594860681)
                                               (< -9223372036854775808 -70861590))
                                           (+ 2099071943 -9223372036854775808)
                                           (if (< -9223372036854775808 881673257) 1 -568199062))])
                            1)))
                      (let ([ball.9 -9223372036854775808]) 9223372036854775807)))

  (check-by-interp '(module (define proc.0 (lambda (ball.3) (call proc.0 9223372036854775807)))
                            (define x.1
                              (lambda (ball.3 ball.6)
                                (if (if (if (!= ball.6 ball.6)
                                            (>= ball.3 ball.3)
                                            (<= -763864902 9223372036854775807))
                                        (< 1 1)
                                        (false))
                                    (let ([ball.1 (+ ball.3 -9223372036854775808)]) 598366993)
                                    (* 9223372036854775807 ball.3))))
                      (define tmp.2
                        (lambda (ball.6 foo.9)
                          (if (true)
                              (let ([ball.1 (+ 1 -9223372036854775808)]) 1)
                              (* foo.9 foo.9))))
                      (if (let ([ball.4 2083024360]) (<= 1 ball.4))
                          (+ 0 1)
                          (call x.1 -390453851 1))))
  (check-by-interp '(module (define func.0 (lambda (foobar.1 foo.6) (call x.1 foo.6 foo.6)))
                            (define x.1 (lambda (foobar.1 bar.9) bar.9))
                      (call x.1 9223372036854775807 0)))
  (check-by-interp '(module (define tmp.0
                              (lambda (bat.8 foo.1)
                                (if (if (if (>= bat.8 foo.1)
                                            (< bat.8 0)
                                            (>= bat.8 foo.1))
                                        (not (>= -9223372036854775808 bat.8))
                                        (< 9223372036854775807 9223372036854775807))
                                    (call proc.1 9223372036854775807)
                                    (call tmp.2 bat.8 bat.8))))
                            (define proc.1
                              (lambda (foobar.3)
                                (if (false)
                                    foobar.3
                                    (* foobar.3 foobar.3))))
                      (define tmp.2 (lambda (foo.1 ball.0) (call proc.1 -915763316)))
                      (let ([foo.1 (* -864893154 9223372036854775807)])
                        (if (> 1679313251 -9223372036854775808) foo.1 -9223372036854775808))))

  (check-by-interp
   '(module (define fn.0
              (lambda (bat.1 foo.0)
                (let ([bat.5 (let ([foobar.8
                                    (if (>= 9223372036854775807 -9223372036854775808) bat.1 foo.0)])
                               (let ([ball.4 -9223372036854775808]) foo.0))])
                  (let ([ball.4 (if (<= -1657890681 9223372036854775807) bat.1 bat.1)])
                    (call fn.0 bat.1 bat.1)))))
            (if (<= 1 1) 0 -9223372036854775808)
      ))

  (check-by-interp '(module (define x.0
                              (lambda (bat.1)
                                (let ([ball.5 (let ([bat.6 (+ -1473118393 -9223372036854775808)])
                                                (let ([foo.4 9223372036854775807]) 218975616))])
                                  (* bat.1 bat.1))))
                            (define tmp.1
                              (lambda ()
                                (let ([bat.1 (if (not (<= 1 1))
                                                 (* -753830259 -9223372036854775808)
                                                 0)])
                                  (if (if (>= bat.1 1170112415)
                                          (!= 172014518 bat.1)
                                          (<= bat.1 540373982))
                                      bat.1
                                      (+ bat.1 bat.1)))))
                      (define proc.2 (lambda (ball.9) (+ -499436274 9223372036854775807)))
                      1))

  (check-by-interp '(module (if (> -9223372036854775808 9223372036854775807) 0 -171588084)))

  (check-by-interp '(module (if (< -9223372036854775808 1)
                                (let ([ball.0 -1183539798]) ball.0)
                                (let ([foobar.6 -1081284475]) foobar.6))))
  (check-by-interp '(module (define func.0
                              (lambda (bar.6)
                                (if (false)
                                    bar.6
                                    (call func.0 bar.6))))
                            (if (< 1694312373 9223372036854775807)
                                (if (= 1766930141 9223372036854775807) 1 9223372036854775807)
                                (if (<= 1 530802046) 0 -9223372036854775808))
                      )))
; (module+ test
;   (require rackunit)
;   ; example outputs for uniquify
;   (check-equal? (uniquify '(module (+ 2 2))) '(module (+ 2 2)))
;   (check-match (uniquify '(module (let ([x 5]) x))) `(module (let ([,x 5]) ,x)) (aloc? x))
;   (check-match (uniquify '(module (let ([x (+ 2 2)]) x))) `(module (let ([,x (+ 2 2)]) ,x)) (aloc? x))
;   (check-match (uniquify '(module (let ([x 2]) (let ([y 2]) (+ x y)))))
;                `(module (let ([,x.5 2]) (let ([,y.6 2]) (+ ,x.5 ,y.6))))
;                (andmap aloc? `(,x.5 ,y.6)))
;   (check-match (uniquify '(module (let ([x 2]) (let ([x 2]) (+ x x)))))
;                `(module (let ([,x.7 2]) (let ([,x.8 2]) (+ ,x.8 ,x.8))))
;                (andmap aloc? `(,x.7 ,x.8)))
;   (check-equal? (uniquify '(module 1)) `(module 1))
;   (check-exn exn:fail? (λ () (uniquify '(module x))))
;   (check-match (uniquify '(module (let ([x 5]) 1))) `(module (let ([,x 5]) 1)) (aloc? x))
;   (check-match (uniquify '(module (let ([y 2]
;                                         [x 3])
;                                     (+ x x))))
;                `(module (let ([,x.7 2]
;                               [,x.8 3])
;                           (+ ,x.8 ,x.8)))
;                (andmap aloc? `(,x.7 ,x.8)))
;   (check-match (uniquify '(module (let ([x 2]
;                                         [y 3])
;                                     (let ([y (+ y y)]
;                                           [x 3])
;                                       (+ x x)))))
;                `(module (let ([,x.7 2]
;                               [,x.8 3])
;                           (let ([,x.9 (+ ,x.8 ,x.8)]
;                                 [,x.10 3])
;                             (+ ,x.10 ,x.10))))
;                (andmap aloc? `(,x.7 ,x.8 ,x.9 ,x.10)))
;   (check-match (uniquify '(module (let ([y (let ([x 1]) x)]
;                                         [x 3])
;                                     (let ([y (+ x x)]
;                                           [x 3])
;                                       (+ x x)))))
;                `(module (let ([,x.7 (let ([,x.1 1]) ,x.1)]
;                               [,x.8 3])
;                           (let ([,x.9 (+ ,x.8 ,x.8)]
;                                 [,x.10 3])
;                             (+ ,x.10 ,x.10))))
;                (andmap aloc? `(,x.1 ,x.7 ,x.8 ,x.9 ,x.10)))
;   (check-exn exn:fail?
;              (λ ()
;                (uniquify '(module (let ([t (let ([x 1]) x)]
;                                         [x x])
;                                     (let ([x (+ x x)]
;                                           [x 3])
;                                       (+ x x)))))))
;   (check-match (uniquify '(module (let ([y 2]
;                                         [x 3])
;                                     (if (true)
;                                         (let ([z 3]) z)
;                                         (let ([z 3]) z)))))
;                `(module (let ([,y.2 2]
;                               [,x.1 3])
;                           (if (true)
;                               (let ([,z.3 3]) ,z.3)
;                               (let ([,z.4 3]) ,z.4))))
;                (andmap aloc? `(,x.1 ,y.2 ,z.3 ,z.4))))
