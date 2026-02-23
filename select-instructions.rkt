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

;imp-cmf-lang-v4  -> Asm-pred-lang-v4
(define (select-instructions p)
  ; (Imp-cmf-lang-v4 value) -> (List-of (Asm-pred-lang-v4 effect)) and (Asm-pred-lang-v4 aloc)
  ; Assigns the value v to a fresh temporary, returning two values: the list of
  ; statements the implement the assignment in Loc-lang, and the aloc that the
  ; value is stored in.
  (define (assign-tmp v)
    (define tmp (fresh 'tmp))
    (match v
      [`(,binop ,triv1 ,triv2)
       (list (list `(set! ,tmp ,triv1) `(set! ,tmp (,binop ,tmp ,triv2))) tmp)]
      [triv (list (list `(set! ,tmp ,triv)) tmp)]))

  (define (select-pred pred [begun #f])
    (match pred
      [`(,relop ,triv1 ,triv2)
       #:when (memq relop '(< <= = >= > !=))
       (if (not (aloc? triv1))
           (match-let ([`(,fxs ,aloc) (assign-tmp triv1)])
             `(begin
                ,@fxs
                (,relop ,aloc ,triv2)))
           pred)]
      [`(true) pred]
      [`(false) pred]
      [`(not ,pred) `(not ,(select-pred pred))]
      [`(begin
          ,fxs ...
          ,pred)
       (append `(begin) (foldr append '() (map select-effect fxs)) (list (select-pred pred #t)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(select-pred pred1)
            ,(select-pred pred2)
            ,(select-pred pred3))]))

  ; (imp-cmf-lang-v4 tail) [bool] -> (Asm-pred-lang-v4 tail)
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
      [_
       (match-let ([`(,fxs ,atail) (select-value e)])
         (append (if (not begun)
                     '(begin)
                     '())
                 fxs
                 (list atail)))]))
  ; (Imp-cmf-lang-v4 value) -> (list (listof (Asm-pred-lang-v4 effect)) (Asm-pred-lang-v4 tail))
  (define (select-value e)
    (match e
      [`(,binop ,triv1 ,triv2)
       (match-let ([`(,fxs ,aloc) (assign-tmp e)])
         (list fxs `(halt ,aloc)))]
      [triv `(() (halt ,triv))]))

  ; (Imp-cmf-lang-v4 value) -> (listof (Asm-pred-lang-v4 effect))
  (define (value->effect* e prev-aloc)
    (match e
      [`(,binop ,triv1 ,triv2)
       `((set! ,prev-aloc ,triv1) (set! ,prev-aloc (,binop ,prev-aloc ,triv2)))]
      [_ `((set! ,prev-aloc ,e))]))

  ; (Imp-cmf-lang-v4 effect) -> (listof (Asm-pred-lang-v4 effect))
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
       ]
      [`(if ,pred ,effect1 ,effect2)
       `((if ,(select-pred pred)
             ,(select-effect effect1)
             ,(select-effect effect2)))]))

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
