#lang racket
(require "interrogator-utils.rkt"
         )

(define (get-available-passes milestone-num)
  (define webexpr (interrogator-get milestone-num '(module 1) #t))
  ;   (pretty-display webexpr)
  (define passes/raw (let loop ([webexpr webexpr])
                       (match webexpr
                         [`(pre ,_ ,content ...) content]
                         [`(,_elem ,_ ,child* ...) (define result (filter-map loop child*))
                                                   (if (pair? result) (car result)
                                                       #f)]
                         [_ #f]
                         )
                       ))
  ;  (pretty-display passes/raw)
  (let loop ([passes/raw passes/raw]
             [passes '()])
    (match passes/raw
      [`(">" ,do-something ,rest ...)
       (with-handlers ([exn:fail? (λ (_) (loop rest passes))])
         (let ([pass (read (open-input-string do-something))])
           (when (eq? (car pass) 'quote) (error pass))
           (loop rest (cons (car pass) passes))))
       ]
      [`("<" ,_output ,rest ...) (loop rest passes)]
      ['() (reverse passes)])))
(get-available-passes 8)