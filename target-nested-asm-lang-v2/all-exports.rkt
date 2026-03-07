#lang racket
(require cpsc411/compiler-lib)

(provide uncover-locals
         assign-fvars
         replace-locations
         undead-analysis
         conflict-analysis
         assign-registers
         interp-nested-asm-lang
         asm-lang-progs
         optimize-predicates)

(require "assign-fvars.rkt"
         "replace-locations.rkt"
         "uncover-locals.rkt"
         "undead-analysis.rkt"
         "conflict-analysis.rkt"
         "assign-registers.rkt"
         "interp-nested-asm-lang.rkt"
         "optimize-predicates.rkt")

(define asm-lang-progs
  '((module () (halt 1)
      )
    (module ()
            (begin
              (halt 1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1))
              (halt x.1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1)
                (set! x.1 (+ x.1 1)))
              (halt x.1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1)
                (set! x.1 (+ x.1 1)))
              (set! x.1 1)
              (halt x.1))
      )
    (module ()
            (begin
              (set! x.1 1)
              (set! x.2 2)
              (set! x.3 3)
              (halt x.3))
      )))

#;
;; X -> X
;; debug function, displays X and returns X
(define (peek datum)
  (displayln datum)
  datum)

(module+ test
  (require rackunit)
  (require (submod "assign-fvars.rkt" test)
           (submod "replace-locations.rkt" test)
           (submod "uncover-locals.rkt" test)
           (submod "undead-analysis.rkt" test)
           (submod "conflict-analysis.rkt" test)
           (submod "assign-registers.rkt" test)))
