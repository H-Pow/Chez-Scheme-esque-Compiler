#lang racket
(require cpsc411/compiler-lib)

(provide assign-homes
         assign-homes-opt)

(require "assign-fvars.rkt"
         "replace-locations.rkt"
         "uncover-locals.rkt"
         "undead-analysis.rkt"
         "conflict-analysis.rkt"
         "assign-registers.rkt")

;; asm-lang-v2 -> nested-asm-lang-v2
;; Compiles Asm-lang v2 to Nested-asm-lang v2,
;;     replacing each abstract location with a physical location.
(define assign-homes (compose replace-locations assign-fvars uncover-locals))
;; asm-lang-v2 -> nested-asm-lang-v2
;; Compiles Asm-lang v2 to Nested-asm-lang v2,
;;     replacing each abstract location with a physical location.
;;     This version performs graph-colouring register allocation.
(define assign-homes-opt
  (compose replace-locations assign-registers conflict-analysis undead-analysis uncover-locals))