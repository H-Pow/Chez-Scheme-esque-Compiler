#lang racket

(require cpsc411/compiler-lib)
(provide sequentialize-let
         interp-values-unique-lang)

(define (binop? op)
  (or (equal? op '+) (equal? op '*)))

(define (binop->fun op)
  (match op
    ['+ x64-add]
    ['* x64-mul]))
(define triv? (or/c aloc? int64?))
; values-unique lang-v3
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
(define (interp-values-unique-lang vlu)
  (define (interp-triv triv env)
    (match triv
      [(? aloc?) (dict-ref env triv)]
      [(? int64?) triv]))
  (define (interp-tail tail env)
    (match tail
      [`(let ([,alocs ,vals] ...) ,tail2)
       (interp-tail tail2
                    (foldl (λ (aloc val env) (dict-set env aloc val))
                           env
                           alocs
                           (map (λ (val) (interp-tail val env)) vals)))]
      [`(,(? binop? binop) ,(? triv? triv) ,(? triv? triv2))
       ((binop->fun binop) (interp-triv triv env) (interp-triv triv2 env))]
      [(? triv?) (interp-triv tail env)]))
  (let _ ([p vlu]
          [env '()])
    (match p
      [`(module ,tail) (interp-tail tail env)])))
;-----------------------------
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

; values-unique-lang-v3 -> imp-mf-lang-v3
(define (sequentialize-let vulv3)
  ;; let assignment be (list values-unique-lang-v3-aloc values-unique-lang-v3-value)
  ;; let k be continuation (imp-mf-lang-v3-effect ... imp-mf-lang-v3-tail) -> imp-mf-lang-v3-tail)
  (define (seq-let-assignment* a* k)
    (if (empty? a*)
        (k '())
        (seq-let-assignment
         (first a*)
         (λ (tail*) (seq-let-assignment* (rest a*) (λ (tail*2) (k (append tail* tail*2))))))))

  (define (seq-let-assignment a k)
    (match a
      [`(,aloc ,val)
       (seq-let-tail val
                     (λ (tail*)
                       (k (append (remove (last tail*) tail*) `((set! ,aloc ,(last tail*)))))))]))
  (define (seq-let-tail tail k)
    (match tail
      [`(let (,assignments ...) ,tail2)
       (seq-let-assignment* assignments
                            (λ (tail*) (seq-let-tail tail2 (λ (tail*2) (k (append tail* tail*2))))))]
      [_ (k (list tail))]))
  (define (seq-let-p p)
    (match p
      [`(module ,tail)
       (seq-let-tail tail
                     (λ (tail*)
                       `(module ,@(if (= 1 (length tail*))
                                      tail*
                                      (list `(begin
                                               ,@tail*))))))]))
  (seq-let-p vulv3))

(module+ test
  (require rackunit)
  ; adapted example outputs for sequentialize-let
  (check-equal? (sequentialize-let `(module (let ([x.1 5]
                                                  [y.2 6])
                                              (+ x.1 y.2))))
                `(module (begin
                           (set! x.1 5)
                           (set! y.2 6)
                           (+ x.1 y.2))))
  (check-equal? (sequentialize-let `(module (let ([y.2 6]
                                                  [x.1 5])
                                              (+ x.1 y.2))))
                `(module (begin
                           (set! y.2 6)
                           (set! x.1 5)
                           (+ x.1 y.2))))
  ; custom seq-let tests
  (check-equal? (sequentialize-let `(module 5)) `(module 5))
  (check-equal? (sequentialize-let `(module (let ([x.1 1]
                                                  [y.1 2])
                                              x.1)))
                `(module (begin
                           (set! x.1 1)
                           (set! y.1 2)
                           x.1)))
  (check-equal? (sequentialize-let `(module (let ([x.1 1]
                                                  [y.1 2])
                                              (let ([x.2 x.1]) x.2))))
                `(module (begin
                           (set! x.1 1)
                           (set! y.1 2)
                           (set! x.2 x.1)
                           x.2))))
