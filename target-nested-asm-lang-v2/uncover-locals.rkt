#lang racket

(require cpsc411/compiler-lib)
(provide uncover-locals)

(define (uncover-locals al2)
  ; (displayln "running uncover-locals")
  (define locals '())
  (define (uncover-aloc aloc)
    (set! locals (cons aloc locals))
    aloc)
  (define (uncover-triv triv)
    (match triv
      [(? int64?) triv]
      [(? aloc?) (uncover-aloc triv)]))
  (define (uncover-effect effect)
    (match effect
      [`(set! ,aloc (,binop ,aloc ,triv))
       `(set! ,(uncover-aloc aloc) (,binop ,aloc ,(uncover-triv triv)))]
      [`(set! ,aloc ,triv)
       `(set! ,(uncover-aloc aloc) ,(uncover-triv triv))]
      [`(begin ,fxs ... ,fx)
       (append '(begin)
               (map uncover-effect fxs)
               (list (uncover-effect fx)))]))
  (define (uncover-tail tail)
    (match tail
      [`(begin ,fxs ... ,tail)
       (append '(begin)
               (map uncover-effect fxs)
               (list (uncover-tail tail)))]
      [`(halt ,triv) `(halt ,(uncover-triv triv))]))
  (define (uncover-p p)
    (match p
      [`(module ,info ,tail)
       (define utail (uncover-tail tail))
       `(module ,(cons `(locals ,(reverse (set->list (list->set locals)))) info)
          ,utail)]))
  (uncover-p al2)
  )

(module+ test
  (require rackunit)
  ; example output for uncover-locals

  (check-match (uncover-locals '(module ()
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1))) (begin (set! x.1 0) (halt x.1))))
  (check-match (uncover-locals '(module ()
                                  (begin
                                    (set! x.1 0)
                                    (set! y.1 x.1)
                                    (set! y.1 (+ y.1 x.1))
                                    (halt y.1))))
               '(module
                    ((locals (x.1 y.1)))
                  (begin (set! x.1 0) (set! y.1 x.1) (set! y.1 (+ y.1 x.1)) (halt y.1)))))