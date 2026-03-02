#lang racket

(require cpsc411/compiler-lib)
(provide replace-locations)

; asm-pred-lang-v5/assignments -> nested-asm-lang-v5
;; Replaces all abstract locations with physical locations, and removes register-allocation metadata
;; Precondition: all abstract locations have a corresponding physical location in the info metadata
(define (replace-locations al2a)

  ;; (asm-pred-lang-v5/assignments loc) -> (asm-pred-lang-v5/assignments rloc)
  ;; Iff loc is abstract, replaces it with its corresponding physical location
  (define (replace-loc loc assignments)
    (if (aloc? loc)
        (info-ref assignments loc)
        loc))

  (define (replace-triv triv assignments)
    (match triv
      [(? aloc?) (info-ref assignments triv)]
      [_ triv]))

  (define (replace-pred pred assignments)
    (match pred
      [`(,relop ,loc ,triv)
       #:when (memq relop '(< <= = >= > !=))
       `(,relop ,(replace-loc loc assignments) ,(replace-triv triv assignments))]
      [`(not ,pred) `(not ,(replace-pred pred assignments))]
      [`(begin
          ,fxs ...
          ,pred)
       `(begin
          ,@(map (λ (fx) (replace-effect fx assignments)) fxs)
          ,(replace-pred pred assignments))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(replace-pred pred1 assignments)
            ,(replace-pred pred2 assignments)
            ,(replace-pred pred3 assignments))]
      [_ pred]))

  (define (replace-effect fx assignments)
    (match fx
      [`(set! ,loc (,binop ,loc ,triv))
       (define rloc (replace-loc loc assignments))
       `(set! ,rloc (,binop ,rloc ,(replace-triv triv assignments)))]
      [`(set! ,loc ,triv) `(set! ,(replace-loc loc assignments) ,(replace-triv triv assignments))]
      [`(begin
          ,fxs ...
          ,fx)
       `(begin
          ,@(map (λ (fx) (replace-effect fx assignments)) fxs)
          ,(replace-effect fx assignments))]
      [`(if ,pred ,effect1 ,effect2)
       `(if ,(replace-pred pred assignments)
            ,(replace-effect effect1 assignments)
            ,(replace-effect effect2 assignments))]))

  (define (replace-tail tail assignments)
    (match tail
      [`(halt ,triv) `(halt ,(replace-triv triv assignments))]
      [`(jump ,trg ,locs ...) `(jump ,trg)]
      [`(begin
          ,fxs ...
          ,tail)
       `(begin
          ,@(map (λ (fx) (replace-effect fx assignments)) fxs)
          ,(replace-tail tail assignments))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(replace-pred pred assignments)
            ,(replace-tail tail1 assignments)
            ,(replace-tail tail2 assignments))]))

  ;; (nested-asm-lang-v5/assignments definition) -> (nested-asm-lang-v5/assignments definition)
  ;; replaces abstract locations with physical locations within an top level procedure definition
  (define (replace-def def)
    (match def
      [`(define ,label
          ,info
          ,tail)
       (define assignments (info-ref info 'assignment))
       `(define ,label ,(replace-tail tail assignments))]))

  (define (replace-p p)
    (match p
      [`(module ,info ,defs
          ...
          ,tail)
       (define assignments (info-ref info 'assignment))
       `(module ,@(map replace-def defs) ,(replace-tail tail assignments)
          )]))

  (replace-p al2a))

(module+ test
  (require rackunit)

  ; example output for replace-locations
  ;; v2
  #;(check-equal? (replace-locations '(module ((locals (x.1)) (assignment ((x.1 rax))))
                                              (begin
                                                (set! x.1 0)
                                                (halt x.1))
                                        ))
                  '(begin
                     (set! rax 0)
                     (halt rax)))
  ;; v4
  (check-equal? (replace-locations '(module ((locals (x.1)) (assignment ((x.1 rax))))
                                            (begin
                                              (set! x.1 0)
                                              (halt x.1))
                                      ))
                '(module (begin
                           (set! rax 0)
                           (halt rax))))

  ;; v2
  #;(check-equal?
     (replace-locations '(module ((locals (x.1 y.1 w.1)) (assignment ((x.1 rax) (y.1 rbx) (w.1 r9))))
                                 (begin
                                   (set! x.1 0)
                                   (set! y.1 x.1)
                                   (set! w.1 1)
                                   (set! w.1 (+ w.1 y.1))
                                   (halt w.1))
                           ))
     '(begin
        (set! rax 0)
        (set! rbx rax)
        (set! r9 1)
        (set! r9 (+ r9 rbx))
        (halt r9)))

  ;; v4
  (check-equal? (replace-locations '(module ((locals (x.1 y.1 w.1)) (assignment ((x.1 rax) (y.1 rbx)
                                                                                           (w.1 r9))))
                                            (begin
                                              (set! x.1 0)
                                              (set! y.1 x.1)
                                              (set! w.1 1)
                                              (set! w.1 (+ w.1 y.1))
                                              (halt w.1))
                                      ))
                '(module (begin
                           (set! rax 0)
                           (set! rbx rax)
                           (set! r9 1)
                           (set! r9 (+ r9 rbx))
                           (halt r9))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1)) (assignment ((x.1 rax) (y.1 rbx))))
                                            (begin
                                              (set! x.1 0)
                                              (set! y.1 x.1)
                                              (if (< x.1 10)
                                                  (halt y.1)
                                                  (halt x.1)))
                                      ))
                `(module (begin
                           (set! rax 0)
                           (set! rbx rax)
                           (if (< rax 10)
                               (halt rbx)
                               (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1)) (assignment ((x.1 rax) (y.1 rbx))))
                                            (begin
                                              (set! x.1 0)
                                              (set! y.1 x.1)
                                              (if (not (>= x.1 5))
                                                  (halt y.1)
                                                  (halt x.1)))
                                      ))
                `(module (begin
                           (set! rax 0)
                           (set! rbx rax)
                           (if (not (>= rax 5))
                               (halt rbx)
                               (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1 z.1)) (assignment ((x.1 rax) (y.1 rbx)
                                                                                           (z.1 r9))))
                                            (begin
                                              (set! x.1 0)
                                              (set! y.1 x.1)
                                              (if (begin
                                                    (set! z.1 5)
                                                    (< z.1 10))
                                                  (halt y.1)
                                                  (halt x.1)))
                                      ))
                `(module (begin
                           (set! rax 0)
                           (set! rbx rax)
                           (if (begin
                                 (set! r9 5)
                                 (< r9 10))
                               (halt rbx)
                               (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1 z.1)) (assignment ((x.1 rax) (y.1 rbx)
                                                                                           (z.1 r9))))
                                            (begin
                                              (set! x.1 0)
                                              (set! y.1 x.1)
                                              (if (if (< z.1 0)
                                                      (true)
                                                      (false))
                                                  (halt y.1)
                                                  (halt x.1)))
                                      ))
                `(module (begin
                           (set! rax 0)
                           (set! rbx rax)
                           (if (if (< r9 0)
                                   (true)
                                   (false))
                               (halt rbx)
                               (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1)) (assignment ((x.1 rax) (y.1 rbx))))
                                            (if (true)
                                                (begin
                                                  (set! x.1 1)
                                                  (halt x.1))
                                                (begin
                                                  (set! y.1 2)
                                                  (halt y.1)))
                                      ))
                `(module (if (true)
                             (begin
                               (set! rax 1)
                               (halt rax))
                             (begin
                               (set! rbx 2)
                               (halt rbx))))))
