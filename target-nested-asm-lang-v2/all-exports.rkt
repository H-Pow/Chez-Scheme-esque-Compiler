#lang racket
(require cpsc411/compiler-lib)

(provide assign-homes
         assign-homes-opt
         uncover-locals
         assign-fvars
         replace-locations
         undead-analysis
         conflict-analysis
         assign-registers)

(require "assign-fvars.rkt"
         "replace-locations.rkt"
         "uncover-locals.rkt"
         "undead-analysis.rkt"
         "conflict-analysis.rkt"
         "assign-registers.rkt"
         )


(define assign-homes (compose replace-locations assign-fvars uncover-locals))
(define assign-homes-opt (compose replace-locations assign-registers conflict-analysis undead-analysis uncover-locals))
(module+ test
  (require rackunit)
  (require (submod "assign-fvars.rkt" test)
           (submod "replace-locations.rkt" test)
           (submod "uncover-locals.rkt" test)
           (submod "undead-analysis.rkt" test)
           (submod "conflict-analysis.rkt" test)
           (submod "assign-registers.rkt" test)
           )
  (check-match (assign-homes '(module () (begin (set! x.1 2) (set! x.2 2) (set! tmp.2 x.1)
                                                (set! tmp.2 (+ tmp.2 x.2)) (halt tmp.2))))
               `(begin (set! ,rsp 2)
                       (set! ,rbx 2)
                       (set! ,rax ,rsp)
                       (set! ,rax (+ ,rax ,rbx))
                       (halt ,rax))
               (andmap (or/c register? fvar?) `(,rsp ,rax ,rbx)))
  (check-match (assign-homes-opt '(module () (begin (set! x.1 2) (set! x.2 2) (set! tmp.2 x.1)
                                                    (set! tmp.2 (+ tmp.2 x.2)) (halt tmp.2))))
               `(begin (set! ,rsp 2)
                       (set! ,rbx 2)
                       (set! ,rax ,rsp)
                       (set! ,rax (+ ,rax ,rbx))
                       (halt ,rax))
               (andmap (or/c register? fvar?) `(,rsp ,rax ,rbx)))

  ; TODO: check evaluation result equivalence of assign-homes and assign-homes-opt


  )