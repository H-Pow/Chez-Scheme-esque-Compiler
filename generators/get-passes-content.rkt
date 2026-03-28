#lang racket
(require "interrogator-get.rkt"
         "get-available-passes.rkt")

(define (get-passes-content milestone-num prog allowed-passes)
  (define xexpr (interrogator-get milestone-num prog #t))
  ;   (pretty-display webexpr)
  (define passes/raw (let loop ([expr xexpr])
                       (match expr
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
           (if (member (car pass) allowed-passes symbol=?) 
               (begin
                  (loop rest (dict-set passes (car pass) (cadr pass))))
               (loop rest passes))))
       ]
      [`("<" ,_output ,rest ...) (loop rest passes)]
      ['() passes])))
(get-passes-content 8 '(module 1) (get-available-passes 8))