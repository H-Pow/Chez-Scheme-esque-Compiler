#lang racket

(require
  cpsc411/compiler-lib
  cpsc411/2c-run-time)

(provide
 check-values-lang
 uniquify
 sequentialize-let
 normalize-bind
 select-instructions
 uncover-locals
 undead-analysis
 conflict-analysis
 assign-registers
 replace-locations
 assign-homes-opt
 assign-homes
 flatten-begins
 patch-instructions
 implement-fvars
 generate-x64

 compile-m2
 compile-m3)

;; STUBS; delete when you've begun to implement the passes or replaced them with
;; your own stubs.
(define-values (check-values-lang
                ; uniquify
                ; sequentialize-let
                ; normalize-bind
                ; select-instructions
                ; uncover-locals
                ; undead-analysis
                ; conflict-analysis
                ; assign-registers
                ; replace-locations
                assign-homes-opt
                ; assign-homes
                ; flatten-begins
                ; patch-instructions
                ; implement-fvars
                ; generate-x64

                compile-m2
                compile-m3)
  (values
   values
   ;  values
   ;  values
   ;  values
   ;  values
   ;  values
   ;  values
   ; values
   ; values
   ;  values
   values
   ;  values
   ;  values
   ;  values
   ;  values
   ;  values
   values
   values
   ))

(require "uniquify.rkt")
(require "sequentialize-let.rkt")
(require "normalize-bind.rkt")
(require "select-instructions.rkt")
(require "target-nested-asm-lang-v2.rkt")
(require "flatten-begins.rkt")
(require "patch-instructions.rkt")
(require "implement-fvars.rkt")
(require "generate-x64.rkt")
(require "target-nested-asm-lang-v2/undead-analysis.rkt")
(require "target-nested-asm-lang-v2/conflict-analysis.rkt")
(require "target-nested-asm-lang-v2/assign-registers.rkt")
(define paren-x64-fvars-v2->asm
  (compose generate-x64 implement-fvars))
(define para-asm-lang-v2->asm
  (compose paren-x64-fvars-v2->asm patch-instructions))
(define nested-asm-lang-v2->asm
  (compose para-asm-lang-v2->asm flatten-begins))
(define asm-lang-v2->asm1
  (compose nested-asm-lang-v2->asm assign-homes))

; (define asm-lang-v2->asm2
;   (compose uncover-locals assign-fvars replace-locations para-asm-lang-v2->asm))

(define imp-cmf-lang-v3->asm
  (compose asm-lang-v2->asm1 select-instructions))

(define imp-mf-lang-v3->asm
  (compose imp-cmf-lang-v3->asm normalize-bind))

(define values-unique-lang-v3->asm
  (compose imp-mf-lang-v3->asm sequentialize-let))

(define values-lang-v3->asm
  (compose values-unique-lang-v3->asm uniquify))

(define run/x64
  (compose nasm-run/print-number wrap-x64-boilerplate wrap-x64-run-time))

;; (values-lang v3) -> (x64)
;; Compiles values-lang-v3 into x64, represented as a string, stores everything on stack
(define (compile-m2 p)
    (parameterize ([current-pass-list
                    (list uniquify 
                    sequentialize-let 
                    normalize-bind 
                    select-instructions 
                    assign-homes
                    flatten-begins 
                    patch-instructions 
                    implement-fvars 
                    generate-x64)])
    (compile p)
    )
    )

;; (values-lang v3) -> (x64)
;; Compiles values-lang-v3 into x64, represented as a string, tries to use registers 
(define (compile-m3 p)
    (parameterize ([current-pass-list
                    (list uniquify 
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
;; You'll want to merge milestone-2 code in

(module+ test
  (require
    rackunit
    rackunit/text-ui
    cpsc411/langs/v3
    cpsc411/langs/v2-reg-alloc
    cpsc411/langs/v2
    cpsc411/test-suite/public/v3
    cpsc411/test-suite/public/v2-reg-alloc)

  (require (submod "uniquify.rkt" test))
  (require (submod "sequentialize-let.rkt" test))
  (require (submod "normalize-bind.rkt" test))
  (require (submod "select-instructions.rkt" test))
  (require (submod "target-nested-asm-lang-v2.rkt" test))
  (require (submod "flatten-begins.rkt" test))
  (require (submod "patch-instructions.rkt" test))
  (require (submod "implement-fvars.rkt" test))
  (require (submod "generate-x64.rkt" test))
  (require (submod "target-nested-asm-lang-v2/undead-analysis.rkt" test))
  (require (submod "target-nested-asm-lang-v2/conflict-analysis.rkt" test))
  (require (submod "target-nested-asm-lang-v2/assign-registers.rkt" test))


  (define values-lang-progs
    (list
     '(module 1)
     '(module (let ([x 5]) 1))
     '(module (let ([x 5]) x))
     '(module (let ([x 5] [y 24]) (+ x y)))
     `(module (let ([x ,(max-int 32)] [y ,(max-int 32)]) (+ x y)))
     `(module (let ([x ,(max-int 32)] [y ,(max-int 33)]) (+ x y)))
     `(module (let ([x ,(max-int 64)] [y ,(max-int 33)]) (* x y)))
     `(module (let ([x ,(min-int 32)] [y ,(min-int 33)]) (+ x y)))
     `(module (let ([x (let ([z -42]) (+ 0 z))] [y ,(min-int 33)]) (* x y)))
     `(module (let ([x (let ([z -42]) (+ 0 z))] [y ,(min-int 33)]) (let [(x2 (+ x y))] (+ x2 y))))
     '(module (let ([y 2] [x 3]) (+ x x)))
     '(module (let ([x 2] [y 3]) (let ([x (+ y y)]) (+ x x))))
     '(module (let ([y (let ([x 1]) x)] [x 3]) (let ([y (+ x x)] [x 3]) (+ x x))))
     '(module (let ([y (let ([x 1]) x)] [x 3]) (let ([y (+ x x)] [x 3]) (* x x))))
     `(module ,(max-int 64))
     ))
  (define (integration-test val-lang-prog)
    (check-equal? (run/x64
                   (values-lang-v3->asm val-lang-prog))
                  (interp-values-lang val-lang-prog)
                  (format "values-lang: \n ~a" val-lang-prog))
    (check-equal? (interp-values-lang val-lang-prog)
                  (interp-values-unique-lang (uniquify val-lang-prog)))
    (define val-uni-prog (uniquify val-lang-prog))
    (check-equal? (run/x64
                   (values-unique-lang-v3->asm val-uni-prog))
                  (interp-values-unique-lang val-uni-prog)
                  (format "values-unique-lang: \n ~a" val-lang-prog))
    (define imp-mf-prog (sequentialize-let val-uni-prog))
    ; (pretty-display (format "imp-mf: \n ~a" imp-mf-prog))

    (check-equal? (run/x64
                   (imp-mf-lang-v3->asm imp-mf-prog))
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
    (check-equal? (run/x64
                   (generate-x64 paren-prog))
                  (interp-paren-x64 paren-prog))
    )
  (for-each integration-test values-lang-progs)
  ;; You can modify this pass list, e.g., by adding check-assignment, or other
  ;; debugging and validation passes.
  ;; Doing this may provide additional debugging info when running the rest
  ;; suite.
  ;; If you modify, you must modify the corresponding interpreter in the
  ;; interp-ls, at least by interesting #f as the interpreter for the new pass.
  ;; See the documentation for v3-public-test-suite for details on the structure
  ;; of the interpreter list.
  (current-pass-list (list
                      check-values-lang
                      uniquify
                      sequentialize-let
                      normalize-bind
                      select-instructions
                      assign-homes-opt
                      flatten-begins
                      patch-instructions
                      implement-fvars
                      generate-x64
                      wrap-x64-run-time
                      wrap-x64-boilerplate))

  (define interp-ls (list
                     interp-values-lang-v3
                     interp-values-lang-v3
                     interp-values-unique-lang-v3
                     interp-imp-mf-lang-v3
                     interp-imp-cmf-lang-v3
                     interp-asm-lang-v2
                     interp-nested-asm-lang-v2
                     interp-para-asm-lang-v2
                     interp-paren-x64-fvars-v2
                     interp-paren-x64-v2
                     #f #f))

  (run-tests (v3-public-test-sutie (current-pass-list) interp-ls))
  (run-tests (v2-reg-alloc-public-test-suite undead-analysis conflict-analysis assign-registers)))
