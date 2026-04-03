#lang racket
(require "interrogator-get.rkt"
         )

(provide (all-defined-out))

(define (get-available-passes milestone-num)
  (define xexpr (interrogator-get milestone-num '(module 1) #t))
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
  (define passes/rawstr (apply ~a passes/raw))
  (define (custom-split str)
    (define init-str* (string-split str "\n"))
    (let loop ([src-str* (rest init-str*)]
               [curr-str (first init-str*)]
               [end-str* '()])
      (if (empty? src-str*)
          (reverse (cons curr-str end-str*))
          (if (string-prefix? (first src-str*) "  ")
              (loop (rest src-str*)
                    (string-append curr-str (first src-str*))
                    end-str*)
              (loop (rest src-str*)
                    (first src-str*)
                    (cons curr-str end-str*))))))
  (define passes/rawstrsplit (custom-split passes/rawstr))
  (define passes-with-input (filter (λ(x) (string-prefix? x ">"))
                                    passes/rawstrsplit))
  (map (λ(x) (car (read (open-input-string (substring x 1))))) passes-with-input))
; (pretty-display (get-available-passes 9))