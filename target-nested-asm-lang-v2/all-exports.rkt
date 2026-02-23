#lang racket
(require cpsc411/compiler-lib)

(provide assign-homes
         assign-homes-opt
         uncover-locals
         assign-fvars
         replace-locations
         undead-analysis
         conflict-analysis
         assign-registers
         interp-nested-asm-lang
         asm-lang-progs
         optimize-predicates)

(require "assign-homes.rkt"
         "assign-fvars.rkt"
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
           (submod "assign-registers.rkt" test))
  (check-match (assign-homes '(module ()
                                      (begin
                                        (set! x.1 2)
                                        (set! x.2 2)
                                        (set! tmp.2 x.1)
                                        (set! tmp.2 (+ tmp.2 x.2))
                                        (halt tmp.2))
                                ))
               `(module (begin
                  (set! ,rsp 2)
                  (set! ,rbx 2)
                  (set! ,rax ,rsp)
                  (set! ,rax (+ ,rax ,rbx))
                  (halt ,rax)))
               (andmap (or/c register? fvar?) `(,rsp ,rax ,rbx)))
  (check-match (assign-homes-opt '(module ()
                                          (begin
                                            (set! x.1 2)
                                            (set! x.2 2)
                                            (set! tmp.2 x.1)
                                            (set! tmp.2 (+ tmp.2 x.2))
                                            (halt tmp.2))
                                    ))
               `(module (begin
                  (set! ,rsp 2)
                  (set! ,rbx 2)
                  (set! ,rax ,rsp)
                  (set! ,rax (+ ,rax ,rbx))
                  (halt ,rax)))
               (andmap (or/c register? fvar?) `(,rsp ,rax ,rbx)))

  ;check evaluation result equivalence of assign-homes and assign-homes-opt
  (for-each check-equal?
            (map (compose interp-nested-asm-lang assign-homes-opt) asm-lang-progs)
            (map (compose interp-nested-asm-lang assign-homes) asm-lang-progs)))
