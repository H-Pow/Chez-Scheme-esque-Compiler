#lang racket

(require cpsc411/compiler-lib)
(provide assign-fvars)
;asm-lang-v2/locals -> asm-lang-v2/assignments
(define (assign-fvars alv2/l)
  ; (displayln "running assign-fvars")
  (define assignment '())
  (define (assign-info info)
    (define locals (first (dict-ref info 'locals)))
    (for-each (λ(i aloc) (set! assignment (cons `(,aloc ,(make-fvar i)) assignment)))
              (range (length locals)) locals)
    (dict-set info 'assignment `(,(reverse assignment))))
  (match alv2/l
    [`(module ,info ,tail)
     `(module ,(assign-info info) ,tail)]))

(module+ test
    (require rackunit)
      ; example output for assign-fvars
  (check-equal? (assign-fvars '(module
                                   ((locals (x.1)))
                                 (begin
                                   (set! x.1 0)
                                   (halt x.1))))
                '(module
                     ((locals (x.1)) (assignment ((x.1 fv0))))
                   (begin (set! x.1 0) (halt x.1))))

  (check-equal? (assign-fvars
                 '(module
                      ((locals (x.1 y.1 w.1)))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))
                '(module
                     ((locals (x.1 y.1 w.1)) (assignment ((x.1 fv0) (y.1 fv1) (w.1 fv2))))
                   (begin
                     (set! x.1 0)
                     (set! y.1 x.1)
                     (set! w.1 1)
                     (set! w.1 (+ w.1 y.1))
                     (halt w.1))) ))