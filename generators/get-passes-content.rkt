#lang racket
(require "interrogator-get.rkt"
         "get-available-passes.rkt")

(provide (all-defined-out))

(define (get-passes-content milestone-num prog allowed-passes)
  ; (define xexpr (interrogator-get milestone-num prog #t))
  (define xexpr (interrogator-post milestone-num prog #t))
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
  (define sanitzed-passes
    (map (λ(x) (read (open-input-string (substring x 1)))) passes-with-input))
  (map (λ(pass) (cons (car pass) (cadr pass)))
       (filter (λ(pass) (member (car pass) allowed-passes symbol=?))
               sanitzed-passes)))

; (get-passes-content 9 '(module 1) (get-available-passes 8))