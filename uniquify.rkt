#lang racket

(require cpsc411/compiler-lib)

(provide uniquify
         interp-values-lang)

(define (binop? op) (or (equal? op '+)
                        (equal? op '*)))

(define (binop->fun op)
  (match op
    ['+ x64-add]
    ['* x64-mul]
    ))
(define triv? (or/c name? int64?))

; values-lang-v3
; p	 	::=	 	(module tail)
; tail	 	::=	 	value
;  	|	 	(let ([x value] ...) tail)
; value	 	::=	 	triv
;  	|	 	(binop triv triv)
;  	|	 	(let ([x value] ...) value)
; triv	 	::=	 	int64
;  	|	 	x
; x	 	::=	 	name?
; binop	 	::=	 	*
;  	|	 	+
; int64	 	::=	 	int64?

(define (interp-values-lang vl3)
  (define (interp-triv triv env)
    (match triv
      [(? name?) (dict-ref env triv (λ() (error "not defined: ~a" triv)))]
      [(? int64?) triv]))
  (define (interp-tail tail env)
    (match tail
      [`(let ([,x* ,value*] ... ) ,tail)
       (define val+ (map (λ(val) (interp-tail val env)) value*))
       (define env+ (foldl (λ(x val env) (dict-set env x val)) env x* val+))
       (interp-tail tail env+)]
      [`(,(? binop? binop) ,(? triv? triv) ,(? triv? triv2))
       ((binop->fun binop)
        (interp-triv triv env)
        (interp-triv triv2 env))]
      [(? triv?) (interp-triv tail env)])
    )
  (let _ ([p vl3] [env '()])
    (match p
      [`(module ,tail) (interp-tail tail env)])))

;---------------------
; values-unique-lang-v3
; p	 	::=	 	(module tail)
;   tail	 	::=	 	value
;  	 	|	 	(let ([aloc value] ...) tail)
;   value	 	::=	 	triv
;  	 	|	 	(binop triv triv)
;  	 	|	 	(let ([aloc value] ...) value)
;   triv	 	::=	 	int64
;  	 	|	 	aloc
;   binop	 	::=	 	*
;  	 	|	 	+
;   aloc	 	::=	  aloc?
;   int64	 	::=	 	int64?

; values-lang-v3 -> values-unique-lang-v3
(define (uniquify vlv3)
  ; let env be a dict when maps name to aloc
  ; name env -> aloc
  (define (name->aloc x env)
    (dict-ref env x (fresh x)))
  ; values-lang-v3-triv env -> values-unique-lang-v3-triv
  (define (uniquify-triv triv env)
    (match triv
      [(? int64?) triv]
      [(? name?) (dict-ref env triv (λ() (error (format "undefined: ~a" triv))))]))
  ; (listof values-lang-v3-name) (listof value-lang-v3-value) env ->
  ;     (list (listof (list values-unique-lang-v3-name values-unique-lang-v3-value)) env)
  (define (uniquify-pairs xs vals env)
    (if (not (equal? (set-count (list->set xs)) (length xs)))
        (error (format "duplicate declaration in the same let: ~a" xs))
        (void))
    (let ([unialocs (map (λ(x) (name->aloc x env)) xs)]
          [univals (map (λ(val) (uniquify-value val env)) vals)])
      (list (map list unialocs univals)
            (foldl (λ(x aloc env)
                     (dict-set env x aloc)) env xs unialocs))))
  
  (define (uniquify-pred pred env)
    (match pred
      [`(,relop ,triv ,triv)
        #:when (memq relop '(< <= = >= > !=))
        `(,relop ,(uniquify-triv triv env) ,(uniquify-triv triv env))]
      [`(true) pred]
      [`(false) pred]
      [`(not ,pred) `(not ,(uniquify-pred pred env))]
      [`(let ([,xs ,vals] ...) ,pred1) #:when((listof name?) xs)
        (match-let ([`(,pairs ,env2) (uniquify-pairs xs vals env)])
                                    `(let ,pairs ,(uniquify-pred pred1 env2)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-pred pred2 env)
            ,(uniquify-pred pred3 env))]))

  ; values-lang-v3-value env -> values-unique-lang-v3-value
  (define (uniquify-value value env)
    (match value
      [`(let ([,xs ,vals] ...) ,val2) #:when((listof name?) xs)
                                      (match-let ([`(,pairs ,env2) (uniquify-pairs xs vals env)])
                                        `(let ,pairs ,(uniquify-value val2 env2)))]
      [`(,binop ,triv1 ,triv2) #:when(and (binop? binop)
                                          (triv? triv1)
                                          (triv? triv2))
                               `(,binop ,(uniquify-triv triv1 env)
                                        ,(uniquify-triv triv2 env))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uniquify-pred pred1 env)
            ,(uniquify-value pred2 env)
            ,(uniquify-value pred3 env))]
      [(? triv?) (uniquify-triv value env)]))
  ; tail = value, no need for a separate function
  ; values-lang-v3-p env -> values-unique-lang-v3-p
  (define (uniquify-p p env)
    (match p
      [`(module ,tail) `(module ,(uniquify-value tail env))]))
  (uniquify-p vlv3 '()))

(module+ test
  (require rackunit)
  ; example outputs for uniquify
  (check-equal? (uniquify '(module (+ 2 2))) '(module (+ 2 2)))
  (check-match (uniquify '(module (let ([x 5]) x)))
               `(module (let ([,x 5]) ,x))
               (aloc? x))
  (check-match (uniquify '(module (let ([x (+ 2 2)]) x)))
               `(module (let ([,x (+ 2 2)]) ,x))
               (aloc? x))
  (check-match (uniquify '(module (let ([x 2]) (let ([y 2]) (+ x y)))))
               `(module (let ([,x.5 2]) (let ([,y.6 2]) (+ ,x.5 ,y.6))))
               (andmap aloc? `(,x.5 ,y.6)))
  (check-match (uniquify '(module (let ([x 2]) (let ([x 2]) (+ x x)))))
               `(module (let ([,x.7 2]) (let ([,x.8 2]) (+ ,x.8 ,x.8))))
               (andmap aloc? `(,x.7 ,x.8)))
  (check-equal? (uniquify '(module 1)) `(module 1))
  (check-exn exn:fail? (λ() (uniquify '(module x))))
  (check-match (uniquify '(module (let ([x 5]) 1)))
               `(module (let ([,x 5]) 1))
               (aloc? x))
  (check-match (uniquify '(module (let ([y 2] [x 3]) (+ x x))))
               `(module (let ([,x.7 2][,x.8 3]) (+ ,x.8 ,x.8)))
               (andmap aloc? `(,x.7 ,x.8)))
  (check-match (uniquify '(module (let ([x 2] [y 3]) (let ([y (+ y y)] [x 3]) (+ x x)))))
               `(module (let ([,x.7 2][,x.8 3]) (let ([,x.9 (+ ,x.8 ,x.8)] [,x.10 3]) (+ ,x.10 ,x.10))))
               (andmap aloc? `(,x.7 ,x.8 ,x.9 ,x.10)))
  (check-match (uniquify '(module (let ([y (let ([x 1]) x)] [x 3]) (let ([y (+ x x)] [x 3]) (+ x x)))))
               `(module (let ([,x.7 (let ([,x.1 1]) ,x.1)][,x.8 3]) (let ([,x.9 (+ ,x.8 ,x.8)] [,x.10 3]) (+ ,x.10 ,x.10))))
               (andmap aloc? `(,x.1 ,x.7 ,x.8 ,x.9 ,x.10)))
  (check-exn exn:fail?
             (λ() (uniquify '(module (let ([t (let ([x 1]) x)] [x x]) (let ([x (+ x x)] [x 3]) (+ x x)))))))
  (check-match (uniquify '(module (let ([y 2] [x 3]) 
        (if (true)
            (let ([z 3]) z)
            (let ([z 3]) z)))))
    `(module
  (let ((,y.2 2) (,x.1 3)) (if (true) (let ((,z.3 3)) ,z.3) (let ((,z.4 3)) ,z.4))))
  (andmap aloc? `(,x.1 ,y.2 ,z.3 ,z.4)))
  )
