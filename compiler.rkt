#lang racket

(require cpsc411/compiler-lib
         cpsc411/2c-run-time)

(provide check-values-lang
         uniquify
         sequentialize-let
         normalize-bind
         impose-calling-conventions
         select-instructions
         assign-homes-opt
         uncover-locals
         undead-analysis
         conflict-analysis
         assign-registers
         replace-locations
         optimize-predicates
         expose-basic-blocks
         resolve-predicates
         flatten-program
         patch-instructions
         implement-fvars
         generate-x64)

;; Template support macro; feel free to delete
(define-syntax-rule (.... stx ...)
  (error "Unfinished template"))

(require "uniquify.rkt")
(require "sequentialize-let.rkt")
(require "normalize-bind.rkt")
(require "select-instructions.rkt")
(require "target-nested-asm-lang-v2/all-exports.rkt")
(require "flatten-begins.rkt")
(require "patch-instructions.rkt")
(require "implement-fvars.rkt")
(require "resolve-predicates.rkt")
(require "generate-x64.rkt")
(require "expose-basic-blocks.rkt")
(require "flatten-program.rkt")
(require "impose-calling-conventions.rkt")

(define paren-x64-fvars-v2->asm (compose generate-x64 implement-fvars))
(define para-asm-lang-v2->asm (compose paren-x64-fvars-v2->asm patch-instructions))
(define nested-asm-lang-v2->asm (compose para-asm-lang-v2->asm flatten-begins))
(define asm-lang-v2->asm1 (compose nested-asm-lang-v2->asm assign-homes))

; (define asm-lang-v2->asm2
;   (compose uncover-locals assign-fvars replace-locations para-asm-lang-v2->asm))

(define imp-cmf-lang-v3->asm (compose asm-lang-v2->asm1 select-instructions))

(define imp-mf-lang-v3->asm (compose imp-cmf-lang-v3->asm normalize-bind))

(define values-unique-lang-v3->asm (compose imp-mf-lang-v3->asm sequentialize-let))

(define values-lang-v3->asm (compose values-unique-lang-v3->asm uniquify))

(define run/x64 (compose nasm-run/print-number wrap-x64-boilerplate wrap-x64-run-time))

;; (values-lang v3) -> (x64)
;; Compiles values-lang-v3 into x64, represented as a string, stores everything on stack
(define (compile-m2 p)
  (parameterize ([current-pass-list (list uniquify
                                          sequentialize-let
                                          normalize-bind
                                          select-instructions
                                          assign-homes
                                          flatten-begins
                                          patch-instructions
                                          implement-fvars
                                          generate-x64)])
    (compile p)))

;; (values-lang v3) -> (x64)
;; Compiles values-lang-v3 into x64, represented as a string, tries to use registers
(define (compile-m3 p)
  (parameterize ([current-pass-list (list uniquify
                                          sequentialize-let
                                          normalize-bind
                                          select-instructions
                                          assign-homes-opt
                                          flatten-begins
                                          patch-instructions
                                          implement-fvars
                                          generate-x64)])
    (compile p)))

;; TODO: Fill in.
;; You'll want to merge milestone-4 code in

;; Stubs; remove or replace with your definitions.
(define-values (check-values-lang)
  (values values))

(module+ test
  (require rackunit
           rackunit/text-ui
           cpsc411/langs/v5
           cpsc411/test-suite/utils
           cpsc411/test-suite/public/v5
           errortrace)

  (require (submod "uniquify.rkt" test))
  (require (submod "sequentialize-let.rkt" test))
  (require (submod "normalize-bind.rkt" test))
  (require (submod "select-instructions.rkt" test))
  (require (submod "flatten-begins.rkt" test))
  (require (submod "flatten-program.rkt" test))
  (require (submod "patch-instructions.rkt" test))
  (require (submod "resolve-predicates.rkt" test))
  (require (submod "implement-fvars.rkt" test))
  (require (submod "generate-x64.rkt" test))
  (require (submod "expose-basic-blocks.rkt" test))
  (require (submod "target-nested-asm-lang-v2/all-exports.rkt" test))
  (require (submod "impose-calling-conventions.rkt" test))

  (define values-lang-progs
    (list '(module 1)
          '(module (let ([x 5]) 1))
          '(module (let ([x 5]) x))
          '(module (let ([x 5]
                         [y 24])
                     (+ x y)))
          `(module (let ([x ,(max-int 32)]
                         [y ,(max-int 32)])
                     (+ x y)))
          `(module (let ([x ,(max-int 32)]
                         [y ,(max-int 33)])
                     (+ x y)))
          `(module (let ([x ,(max-int 64)]
                         [y ,(max-int 33)])
                     (* x y)))
          `(module (let ([x ,(min-int 32)]
                         [y ,(min-int 33)])
                     (+ x y)))
          `(module (let ([x (let ([z -42]) (+ 0 z))]
                         [y ,(min-int 33)])
                     (* x y)))
          `(module (let ([x (let ([z -42]) (+ 0 z))]
                         [y ,(min-int 33)])
                     (let ([x2 (+ x y)]) (+ x2 y))))
          '(module (let ([y 2]
                         [x 3])
                     (+ x x)))
          '(module (let ([x 2]
                         [y 3])
                     (let ([x (+ y y)]) (+ x x))))
          '(module (let ([y (let ([x 1]) x)]
                         [x 3])
                     (let ([y (+ x x)]
                           [x 3])
                       (+ x x))))
          '(module (let ([y (let ([x 1]) x)]
                         [x 3])
                     (let ([y (+ x x)]
                           [x 3])
                       (* x x))))
          `(module ,(max-int 64))))
  (define (integration-test val-lang-prog)
    (check-equal? (run/x64 (values-lang-v3->asm val-lang-prog))
                  (interp-values-lang val-lang-prog)
                  (format "values-lang: \n ~a" val-lang-prog))
    (check-equal? (interp-values-lang val-lang-prog)
                  (interp-values-unique-lang (uniquify val-lang-prog)))
    (define val-uni-prog (uniquify val-lang-prog))
    (check-equal? (run/x64 (values-unique-lang-v3->asm val-uni-prog))
                  (interp-values-unique-lang val-uni-prog)
                  (format "values-unique-lang: \n ~a" val-lang-prog))
    (define imp-mf-prog (sequentialize-let val-uni-prog))
    ; (pretty-display (format "imp-mf: \n ~a" imp-mf-prog))

    (check-equal? (run/x64 (imp-mf-lang-v3->asm imp-mf-prog))
                  (interp-imp-mf-lang imp-mf-prog)
                  (format "imp-mf: \n ~a" imp-mf-prog))
    (define imp-cmf-prog (normalize-bind imp-mf-prog))
    ; (pretty-display (format "imp-cmf: \n ~a" imp-cmf-prog))
    ; (check-equal? (run
    ;                (imp-cmf-lang-v3->asm imp-cmf-prog))
    ;               1)
    (define asm-lang-prog (select-instructions imp-cmf-prog))
    ; (pretty-display (format "asm-lang: \n ~a" asm-lang-prog))
    ; (check-equal? (run
    ;                (asm-lang-v2->asm1 asm-lang-prog))
    ;               1)

    ; (pretty-display (uncover-locals asm-lang-prog))
    ; (pretty-display ((compose assign-fvars uncover-locals) asm-lang-prog))
    ; (pretty-display ((compose replace-locations assign-fvars uncover-locals) asm-lang-prog))

    (define nested-asm-lang-prog (assign-homes asm-lang-prog))
    ; (pretty-display (format "nested-asm: \n ~a" nested-asm-lang-prog))
    ; (check-equal? (run
    ;                (nested-asm-lang-v2->asm nested-asm-lang-prog))
    ; 1)
    (define para-asm-lang-prog (flatten-begins nested-asm-lang-prog))
    ; (pretty-display (format "para-asm \n ~a" para-asm-lang-prog))
    ; (check-equal? (run
    ;                (para-asm-lang-v2->asm para-asm-lang-prog))
    ;               1)

    (define paren-fvar-prog (patch-instructions para-asm-lang-prog))
    ; (pretty-display (format "paren-fvar \n ~a" paren-fvar-prog))
    ; (check-equal? (run
    ;                (paren-x64-fvars-v2->asm paren-fvar-prog))
    ;               1)
    (define paren-prog (implement-fvars paren-fvar-prog))
    ; (pretty-display (format "paren-x64 \n ~a" paren-prog))
    ; (pretty-display (format "nasm: \n ~a" (generate-x64 paren-prog)))
    (check-equal? (run/x64 (generate-x64 paren-prog)) (interp-paren-x64 paren-prog)))
  (for-each integration-test values-lang-progs)
  ;; You can modify this pass list, e.g., by adding check-assignment, or other
  ;; debugging and validation passes.
  ;; Doing this may provide additional debugging info when running the rest
  ;; suite.
  (define pass-map
    (list (cons check-values-lang interp-values-lang-v5)
          (cons uniquify interp-values-lang-v5)
          (cons sequentialize-let interp-values-unique-lang-v5)
          (cons normalize-bind interp-imp-mf-lang-v5)
          (cons impose-calling-conventions interp-proc-imp-cmf-lang-v5)
          (cons select-instructions interp-imp-cmf-lang-v5)
          (cons uncover-locals interp-asm-pred-lang-v5)
          (cons undead-analysis interp-asm-pred-lang-v5/locals)
          (cons conflict-analysis interp-asm-pred-lang-v5/undead)
          (cons assign-registers interp-asm-pred-lang-v5/conflicts)
          (cons replace-locations interp-asm-pred-lang-v5/assignments)
          (cons optimize-predicates interp-nested-asm-lang-v5)
          (cons expose-basic-blocks interp-nested-asm-lang-v5)
          (cons resolve-predicates interp-block-pred-lang-v5)
          (cons flatten-program interp-block-asm-lang-v5)
          (cons patch-instructions interp-para-asm-lang-v5)
          (cons implement-fvars interp-paren-x64-fvars-v5)
          (cons generate-x64 interp-paren-x64-v5)
          (cons wrap-x64-run-time #f)
          (cons wrap-x64-boilerplate #f)))

  (current-pass-list (map car pass-map))

  (run-tests (v5-public-test-suite (current-pass-list) (map cdr pass-map) check-values-lang)))
