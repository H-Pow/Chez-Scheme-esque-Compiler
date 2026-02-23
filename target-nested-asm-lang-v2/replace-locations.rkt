#lang racket

(require cpsc411/compiler-lib)
(provide replace-locations)

; asm-pred-lang-v4/assignments -> nested-asm-lang-v4
(define (replace-locations al2a)
  ; (displayln "running replace-locations")
  (define (replace-aloc aloc assignment)
    (first (dict-ref assignment aloc (λ() (error (format "unassigned aloc ~a" aloc))))))
  (define (replace-triv triv assignment) (match triv
                                           [(? aloc?) (replace-aloc triv assignment)]
                                           [_ triv]))

  (define (replace-pred pred assignment)
    (match pred
      [`(,relop ,aloc ,triv)
        #:when (memq relop '(< <= = >= > !=))
       `(,relop ,(replace-aloc aloc assignment) ,(replace-triv triv assignment))]
      [`(true) `(true)]
      [`(false) `(false)]
      [`(not ,pred)
       `(not ,(replace-pred pred assignment))]
      [`(begin ,fxs ... ,pred)
        (append `(begin)
                  (map (λ(fx) (replace-effect fx assignment)) fxs)
                  (list (replace-pred pred assignment)))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(replace-pred pred1 assignment)
            ,(replace-pred pred2 assignment)
            ,(replace-pred pred3 assignment))]))

  (define (replace-effect fx assignment)
    (match fx
      [`(set! ,aloc (,binop ,aloc ,triv))
       (define loc (replace-aloc aloc assignment))
       `(set! ,loc (,binop ,loc , (replace-triv triv assignment)))]
      [`(set! ,aloc ,triv) `(set! ,(replace-aloc aloc assignment)
                                  ,(replace-triv triv assignment))]
      [`(begin ,fxs ... ,fx) (append `(begin)
                                     (map (λ(fx) (replace-effect fx assignment)) fxs)
                                     (list (replace-effect fx assignment)))]
      [`(if ,pred ,effect1 ,effect2)
       `(if ,(replace-pred pred assignment)
            ,(replace-effect effect1 assignment)
            ,(replace-effect effect2 assignment))]))
  (define (replace-tail tail assignment)
    (match tail
      [`(halt ,triv) `(halt ,(replace-triv triv assignment))]
      [`(begin ,fxs ... ,tail2) (append  `(begin)
                                          (map (λ(fx) (replace-effect fx assignment)) fxs)
                                          (list (replace-tail tail2 assignment)))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(replace-pred pred assignment)
            ,(replace-tail tail1 assignment)
            ,(replace-tail tail2 assignment))]
      ))
  (define (replace-p p)
    (match p
      [`(module ,info ,tail)
       `(module ,(replace-tail tail (first (dict-ref info 'assignment (λ() (error "missing assignment"))))))]))
  (replace-p al2a)
  )

(module+ test
  (require rackunit)

  ; example output for replace-locations
  ;; v2
  #;
  (check-equal? (replace-locations
                 '(module ((locals (x.1)) (assignment ((x.1 rax))))
                    (begin
                      (set! x.1 0)
                      (halt x.1))))

                '(begin (set! rax 0) (halt rax)))
  ;; v4
  (check-equal? (replace-locations
                 '(module ((locals (x.1)) (assignment ((x.1 rax))))
                    (begin
                      (set! x.1 0)
                      (halt x.1))))

                '(module (begin (set! rax 0) (halt rax))))

  ;; v2
  #;
  (check-equal? (replace-locations
                 '(module ((locals (x.1 y.1 w.1))
                           (assignment ((x.1 rax) (y.1 rbx) (w.1 r9))))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))

                '(begin (set! rax 0) (set! rbx rax) (set! r9 1) (set! r9 (+ r9 rbx)) (halt r9)))
  
  ;; v4
  (check-equal? (replace-locations
                 '(module ((locals (x.1 y.1 w.1))
                           (assignment ((x.1 rax) (y.1 rbx) (w.1 r9))))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))

                '(module (begin (set! rax 0) (set! rbx rax) (set! r9 1) (set! r9 (+ r9 rbx)) (halt r9))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1))
                                             (assignment ((x.1 rax) (y.1 rbx))))
                    (begin 
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (if (< x.1 10)
                          (halt y.1)
                          (halt x.1)))))
          
    `(module
        (begin (set! rax 0) (set! rbx rax) (if (< rax 10) (halt rbx) (halt rax)))))
  
  (check-equal? (replace-locations `(module ((locals (x.1 y.1))
                                             (assignment ((x.1 rax) (y.1 rbx))))
                    (begin 
                    (set! x.1 0)
                    (set! y.1 x.1)
                    (if (not (>= x.1 5))
                        (halt y.1)
                        (halt x.1)))))
    `(module
      (begin
        (set! rax 0)
        (set! rbx rax)
        (if (not (>= rax 5)) (halt rbx) (halt rax)))))
  
  (check-equal? (replace-locations `(module ((locals (x.1 y.1 z.1))
                           (assignment ((x.1 rax) (y.1 rbx) (z.1 r9))))
                    (begin 
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (if (begin
                            (set! z.1 5)
                            (< z.1 10))
                          (halt y.1)
                          (halt x.1)))))
  `(module
    (begin
      (set! rax 0)
      (set! rbx rax)
      (if (begin (set! r9 5) (< r9 10)) (halt rbx) (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1 z.1))
                           (assignment ((x.1 rax) (y.1 rbx) (z.1 r9))))
                    (begin 
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (if (if (< z.1 0)
                              (true)
                              (false))
                          (halt y.1)
                          (halt x.1)))))
                          
  `(module
    (begin
      (set! rax 0)
      (set! rbx rax)
      (if (if (< r9 0) (true) (false)) (halt rbx) (halt rax)))))

  (check-equal? (replace-locations `(module ((locals (x.1 y.1))
                           (assignment ((x.1 rax) (y.1 rbx))))
                  (if (true)
                      (begin (set! x.1 1) (halt x.1))
                      (begin (set! y.1 2) (halt y.1)))))
                      
                      
  `(module
  (if (true) (begin (set! rax 1) (halt rax)) (begin (set! rbx 2) (halt rbx))))))
  
