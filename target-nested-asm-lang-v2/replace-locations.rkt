#lang racket

(require cpsc411/compiler-lib)
(provide replace-locations)

; asm-lang-v2/assignments -> nested-asm-lang-v2
(define (replace-locations al2a)
  ; (displayln "running replace-locations")
  (define (replace-aloc aloc assignment)
    (first (dict-ref assignment aloc (λ() (error (format "unassigned aloc ~a" aloc))))))
  (define (replace-triv triv assignment) (match triv
                                           [(? aloc?) (replace-aloc triv assignment)]
                                           [_ triv]))
  (define (replace-effect fx assignment)
    (match fx
      [`(set! ,aloc (,binop ,aloc ,triv))
       (define loc (replace-aloc aloc assignment))
       `(set! ,loc (,binop ,loc , (replace-triv triv assignment)))]
      [`(set! ,aloc ,triv) `(set! ,(replace-aloc aloc assignment)
                                  ,(replace-triv triv assignment))]
      [`(begin ,fxs ... ,fx) (append `(begin)
                                     (map (λ(fx) (replace-effect fx assignment)) fxs)
                                     (list (replace-effect fx assignment)))]))
  (define (replace-tail tail assignment)
    (match tail
      [`(halt ,triv) `((halt ,(replace-triv triv assignment)))]
      [`(begin ,fxs ... ,tail2) (append (map (λ(fx) (replace-effect fx assignment)) fxs)
                                        (replace-tail tail2 assignment))]
      ))
  (define (replace-p p)
    (match p
      [`(module ,info ,tail)
       `(begin ,@(replace-tail tail (first (dict-ref info 'assignment (λ() (error "missing assignment"))))))]))
  (replace-p al2a)
  )

(module+ test
  (require rackunit)

  ; example output for replace-locations
  (check-equal? (replace-locations
                 '(module ((locals (x.1)) (assignment ((x.1 rax))))
                    (begin
                      (set! x.1 0)
                      (halt x.1))))

                '(begin (set! rax 0) (halt rax)))

  (check-equal? (replace-locations
                 '(module ((locals (x.1 y.1 w.1))
                           (assignment ((x.1 rax) (y.1 rbx) (w.1 r9))))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))

                '(begin (set! rax 0) (set! rbx rax) (set! r9 1) (set! r9 (+ r9 rbx)) (halt r9))))