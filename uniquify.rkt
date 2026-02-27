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
    (dict-ref arg-env x (fresh x)))

  ;; Takes triv in argument position and assigns aloc if triv is a name, otherwise returns
  ;; triv if triv is int64.
  ;; (values-lang-v5 triv?) -> (values-lang-v5 triv | int64)
  (define (triv->arg arg arg-env)
    (if (int64? arg)
        arg
        (name->aloc arg arg-env)))

  ; values-lang-v3-triv env -> values-unique-lang-v3-triv
  (define (uniquify-triv triv env)
    (match triv
      [(? int64?) triv]
      [(? name?) (dict-ref env triv (λ () (error (format "undefined: ~a" triv))))]))

  ; (listof values-lang-v5-name) (listof value-lang-v5-value) env ->
  ;     (list (listof (list values-unique-lang-v5-name values-unique-lang-v5-value)) env)
  (define (uniquify-pairs xs vals env)
    (when (not (equal? (set-count (list->set xs)) (length xs)))
      (error (format "duplicate declaration in the same let: ~a" xs)))
    (define copy-env (set-copy env))
    (values (map (λ (x val)
                   (define new-aloc (fresh x)) ;; always a fresh aloc in this context
                   (dict-set! copy-env x new-aloc)
                   ;; new binding only applies within directly nested values
                   (define unique-value (uniquify-value val (dict-set env x new-aloc)))
                   ;; produce a pair (new-aloc value)
                   (list new-aloc unique-value))
                 xs
                 vals)
            ;; return modified env to apply to the body of let
            copy-env))

  (define (uniquify-pred pred env)
    (match pred
      [`(,relop ,triv1 ,triv2)
       #:when (memq relop '(< <= = >= > !=))
       `(,relop ,(uniquify-triv triv1 env) ,(uniquify-triv triv2 env))]
      [`(not ,pred) `(not ,(uniquify-pred pred env))]
      [`(let ([,xs ,vals] ...) ,pred)
       ;    #:when ((listof name?) xs) ;; isn't it guaranteed to be (listof name) ?
       (define-values (bindings new-env) (uniquify-pairs xs vals env))
       `(let ,bindings ,(uniquify-pred pred new-env))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-pred pred2 env)
            ,(uniquify-pred pred3 env))]
      [_ pred]
      ; [`(true) pred]
      ;   [`(false) pred]
      ))

  ; values-lang-v5-value env -> values-unique-lang-v5-value
  (define (uniquify-value value env)
    (match value
      [`(let ([,xs ,vals] ...) ,val2)
       (define-values (bindings new-env) (uniquify-pairs xs vals env))
       `(let ,bindings ,(uniquify-value value new-env))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-value pred2 env)
            ,(uniquify-value pred3 env))]
      ;; reordered to disambiguate with (if) instead
      ;    #:when (and (binop? binop) (triv? triv1) (triv? triv2))
      [`(,binop ,triv1 ,triv2) `(,binop ,(uniquify-triv triv1 env) ,(uniquify-triv triv2 env))]
      [(? triv?) (uniquify-triv value env)]))

  (define (uniquify-tail tail arg-env)
    (match tail
      [`(let ([,xs ,vals] ...) ,tail)
       ;#:when ((listof name?) xs) ;; is this necessary?
       (define-values (bindings new-env) (uniquify-pairs xs vals arg-env))
       `(let ,bindings ,(uniquify-tail tail new-env))]
      [`(if ,pred ,t1 ,t2)
       `(if ,(uniquify-pred pred arg-env)
            ,(uniquify-tail t1 arg-env)
            ,(uniquify-tail t2 arg-env))]
      ;; call to function x, with trivs as args
      [`(call ,x ,trivs ...)
       `(call ,(proc-name->label x) ,@(map (λ (arg) (triv->arg arg arg-env)) trivs))]
      [_ (uniquify-value tail arg-env)]))

  (define (uniquify-definitions def arg-env)
    (match def
      [`(define ,proc-name (lambda (,args ...) ,tail))
       `(define ,(proc-name->label proc-name)
          (lambda (,@(map (λ (arg) (dict-set arg-env arg (fresh arg))) args))
            ,(uniquify-tail tail arg-env)))]))

  ; (values-lang-v5-p env) -> (values-unique-lang-v5 p)
  (define (uniquify-p p)
    (match p
      [`(module ,defs ...
          ,tail)
       `(module ,@(map (λ (def) (uniquify-definitions def (make-hash))) defs)
                (uniquify-tail tail (make-hash))
          )]))

  (uniquify-p vlv5))

(module+ test
  (require rackunit)
  ; example outputs for uniquify
  (check-equal? (uniquify '(module (+ 2 2))) '(module (+ 2 2)))
  (check-match (uniquify '(module (let ([x 5]) x))) `(module (let ([,x 5]) ,x)) (aloc? x))
  (check-match (uniquify '(module (let ([x (+ 2 2)]) x))) `(module (let ([,x (+ 2 2)]) ,x)) (aloc? x))
  (check-match (uniquify '(module (let ([x 2]) (let ([y 2]) (+ x y)))))
               `(module (let ([,x.5 2]) (let ([,y.6 2]) (+ ,x.5 ,y.6))))
               (andmap aloc? `(,x.5 ,y.6)))
  (check-match (uniquify '(module (let ([x 2]) (let ([x 2]) (+ x x)))))
               `(module (let ([,x.7 2]) (let ([,x.8 2]) (+ ,x.8 ,x.8))))
               (andmap aloc? `(,x.7 ,x.8)))
  (check-equal? (uniquify '(module 1)) `(module 1))
  (check-exn exn:fail? (λ () (uniquify '(module x))))
  (check-match (uniquify '(module (let ([x 5]) 1))) `(module (let ([,x 5]) 1)) (aloc? x))
  (check-match (uniquify '(module (let ([y 2]
                                        [x 3])
                                    (+ x x))))
               `(module (let ([,x.7 2]
                              [,x.8 3])
                          (+ ,x.8 ,x.8)))
               (andmap aloc? `(,x.7 ,x.8)))
  (check-match (uniquify '(module (let ([x 2]
                                        [y 3])
                                    (let ([y (+ y y)]
                                          [x 3])
                                      (+ x x)))))
               `(module (let ([,x.7 2]
                              [,x.8 3])
                          (let ([,x.9 (+ ,x.8 ,x.8)]
                                [,x.10 3])
                            (+ ,x.10 ,x.10))))
               (andmap aloc? `(,x.7 ,x.8 ,x.9 ,x.10)))
  (check-match (uniquify '(module (let ([y (let ([x 1]) x)]
                                        [x 3])
                                    (let ([y (+ x x)]
                                          [x 3])
                                      (+ x x)))))
               `(module (let ([,x.7 (let ([,x.1 1]) ,x.1)]
                              [,x.8 3])
                          (let ([,x.9 (+ ,x.8 ,x.8)]
                                [,x.10 3])
                            (+ ,x.10 ,x.10))))
               (andmap aloc? `(,x.1 ,x.7 ,x.8 ,x.9 ,x.10)))
  (check-exn exn:fail?
             (λ ()
               (uniquify '(module (let ([t (let ([x 1]) x)]
                                        [x x])
                                    (let ([x (+ x x)]
                                          [x 3])
                                      (+ x x)))))))
  (check-match (uniquify '(module (let ([y 2]
                                        [x 3])
                                    (if (true)
                                        (let ([z 3]) z)
                                        (let ([z 3]) z)))))
               `(module (let ([,y.2 2]
                              [,x.1 3])
                          (if (true)
                              (let ([,z.3 3]) ,z.3)
                              (let ([,z.4 3]) ,z.4))))
               (andmap aloc? `(,x.1 ,y.2 ,z.3 ,z.4))))
