#lang racket

(require cpsc411/compiler-lib)

(provide select-instructions)
; asm-lang-v2
;  p	 	::=	 	(module info tail)

; info	 	::=	 	info?

; tail	 	::=	 	(halt triv)
;  	|	 	(begin effect ... tail)

; effect	 	::=	 	(set! aloc triv)
;  	|	 	(set! aloc_1 (binop aloc_1 triv))
;  	|	 	(begin effect ... effect)

; triv	 	::=	 	int64
;  	|	 	aloc

; binop	 	::=	 	*
;  	|	 	+

; aloc	 	::=	 	aloc?

; int64	 	::=	 	int64?

;imp-cmf-lang-v3  -> Asm-lang-v2
(define (select-instructions p)
  ; (Imp-cmf-lang-v3 value) -> (List-of (Asm-lang-v2 effect)) and (Asm-lang-v2 aloc)
  ; Assigns the value v to a fresh temporary, returning two values: the list of
  ; statements the implement the assignment in Loc-lang, and the aloc that the
  ; value is stored in.
  (define (assign-tmp v)
    (define tmp (fresh 'tmp))
    (match v
      [`(,binop ,triv1 ,triv2)
       (list (list `(set! ,tmp ,triv1) `(set! ,tmp (,binop ,tmp ,triv2))) tmp)]
      [triv (list (list `(set! ,tmp ,triv)) tmp)]))
  ; (imp-cmf-lang-v3 tail) [bool] -> (Asm-lang-v2 tail)
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
      [_
       (match-let ([`(,fxs ,atail) (select-value e)])
         (append (if (not begun)
                     '(begin)
                     '())
                 fxs
                 (list atail)))]))
  ; (Imp-cmf-lang-v3 value) -> (list (listof (Asm-lang-v2 effect)) (Asm-lang-v2 tail))
  (define (select-value e)
    (match e
      [`(,binop ,triv1 ,triv2)
       (match-let ([`(,fxs ,aloc) (assign-tmp e)])
         (list fxs `(halt ,aloc)))]
      [triv `(() (halt ,triv))]))

  ; (Imp-cmf-lang-v3 value) -> (listof (Asm-lang-v2 effect))
  (define (value->effect* e prev-aloc)
    (match e
      [`(,binop ,triv1 ,triv2)
       `((set! ,prev-aloc ,triv1) (set! ,prev-aloc (,binop ,prev-aloc ,triv2)))]
      [_ `((set! ,prev-aloc ,e))]))

  ; (Imp-cmf-lang-v3 effect) -> (listof (Asm-lang-v2 effect))
  (define (select-effect e)
    (match e
      ;special case
      [`(set! ,aloc (,binop ,aloc ,triv)) `(,e)]
      [`(set! ,aloc ,value) (value->effect* value aloc)]
      [`(begin
          ,fxs ...
          ,fx)
       (list (append `(begin) (foldr append '() (map select-effect fxs)) (select-effect fx)))
       ;  (append (foldr append '() (map select-effect fxs))
       ;          (select-effect fx))
       ]))
  (match p
    [`(module ,tail)
     `(module () ,(select-tail tail)
        )]))

(module+ test
  (require rackunit)
  ; adapted example outputs for select-instuctions
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
                   )))
