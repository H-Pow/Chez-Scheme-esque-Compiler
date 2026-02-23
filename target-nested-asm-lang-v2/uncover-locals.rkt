#lang racket

(require cpsc411/compiler-lib)
(provide uncover-locals)

(define (uncover-locals al2)
  ; (displayln "running uncover-locals")
  (define locals '())
  (define (uncover-aloc aloc)
    (set! locals (set-union locals `(,aloc)))
    aloc)
  (define (uncover-triv triv)
    (match triv
      [(? int64?) triv]
      [(? aloc?) (uncover-aloc triv)]))
  (define (uncover-pred pred)
    (match pred
      [`(,relop ,aloc ,triv)
       #:when (memq relop '(< <= = >= > !=))
       `(,relop ,(uncover-aloc aloc) ,(uncover-triv triv))]
      [`(true) pred]
      [`(false) pred]
      [`(not ,pred) `(not ,(uncover-pred pred))]
      [`(begin
          ,fxs ...
          ,pred)
       (append '(begin) (map uncover-effect fxs) (list (uncover-pred pred)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(uncover-pred pred1)
            ,(uncover-pred pred2)
            ,(uncover-pred pred3))]))

  (define (uncover-effect effect)
    (match effect
      [`(set! ,aloc (,binop ,aloc ,triv))
       `(set! ,(uncover-aloc aloc) (,binop ,aloc ,(uncover-triv triv)))]
      [`(set! ,aloc ,triv) `(set! ,(uncover-aloc aloc) ,(uncover-triv triv))]
      [`(begin
          ,fxs ...
          ,fx)
       (append '(begin) (map uncover-effect fxs) (list (uncover-effect fx)))]
      [`(if ,pred ,effect1 ,effect2)
       `(if ,(uncover-pred pred)
            ,(uncover-effect effect1)
            ,(uncover-effect effect2))]))
  (define (uncover-tail tail)
    (match tail
      [`(begin
          ,fxs ...
          ,tail)
       (append '(begin) (map uncover-effect fxs) (list (uncover-tail tail)))]
      [`(halt ,triv) `(halt ,(uncover-triv triv))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(uncover-pred pred)
            ,(uncover-tail tail1)
            ,(uncover-tail tail2))]))
  (define (uncover-p p)
    (match p
      [`(module ,info ,tail
          )
       (define utail (uncover-tail tail))
       `(module ,(info-set info 'locals locals) ,utail
          )]))
  (uncover-p al2))

(module+ test
  (require rackunit)
  ; example output for uncover-locals

  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (halt x.1))
                                  ))
               '(module ((locals (x.1)))
                        (begin
                          (set! x.1 0)
                          (halt x.1))
                  ))
  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (set! y.1 x.1)
                                          (set! y.1 (+ y.1 x.1))
                                          (halt y.1))
                                  ))
               `(module ((locals ,locals))
                        (begin
                          (set! x.1 0)
                          (set! y.1 x.1)
                          (set! y.1 (+ y.1 x.1))
                          (halt y.1))
                  )
               (equal? (list->seteq locals) (seteq 'x.1 'y.1)))

  ;; works, just in different order
  #;(check-equal? (uncover-locals `(module ()
                                           (begin
                                             (set! x.1 5)
                                             (set! y.2 x.1)
                                             (begin
                                               (set! b.3 x.1)
                                               (set! b.3 (+ b.3 y.2))
                                               (set! c.4 b.3)
                                               (if (if (true)
                                                       (false)
                                                       (not (false)))
                                                   (halt c.4)
                                                   (begin
                                                     (set! x.1 c.4)
                                                     (set! x.1 y.2)
                                                     (halt c.4)))))
                                     ))
                  `(module ((locals (b.3 x.1 y.2 c.4)))
                           (begin
                             (set! x.1 5)
                             (set! y.2 x.1)
                             (begin
                               (set! b.3 x.1)
                               (set! b.3 (+ b.3 y.2))
                               (set! c.4 b.3)
                               (if (if (true)
                                       (false)
                                       (not (false)))
                                   (halt c.4)
                                   (begin
                                     (set! x.1 c.4)
                                     (set! x.1 y.2)
                                     (halt c.4)))))
                     )))
