#lang racket
(require cpsc411/compiler-lib)
(provide binop
         binop?
         binop->fun
         binop/unsafe
         binop/unsafe?
         binop/ptr
         binop/ptr?
         unop
         unop?
         prim-f
         prim-f?
         primop
         primop?
         fixnum?
         fixnum/tagged?
         boolean/tagged?
         empty/tagged?
         void/tagged?
         ascii-char/tagged?
         error/tagged?
         pair/tagged?)

(define binop '(+ - * eq? < <= > >=))
(define binop? (compose not false? (curryr memq binop)))
; NOTE: please make sure the unsafe variants are at the same order as the safe ones so it doesn't
;    break implement-safe-primop
(define binop/unsafe
  '(unsafe-fx+ unsafe-fx- unsafe-fx* eq? unsafe-fx< unsafe-fx<= unsafe-fx> unsafe-fx>=))
(define binop/unsafe? (compose not false? (curryr memq binop/unsafe)))

(define binop/ptr '(+ - * bitwise-and bitwise-ior bitwise-xor arithmetic-shift-right))

(define binop/ptr? (compose not false? (curryr memq binop/ptr)))

(define unop '(fixnum? boolean? empty? void? ascii-char? error? not))
(define unop? (compose not false? (curryr memq unop)))

(define prim-f `(,@binop ,@unop))
(define prim-f? (compose not false? (curryr memq prim-f)))

(define (binop->fun op)
  (match op
    ['+ x64-add]
    ['* x64-mul]
    ['- x64-sub]
    ['bitwise-and bitwise-and]
    ['bitwise-xor bitwise-xor]
    ['bitwise-ior bitwise-ior]
    ['arithmetic-shift-right (λ (x) (arithmetic-shift (- x)))]))

;; alias for int61?
(define (fixnum? n)
  (int61? n))
(define (fixnum/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-fixnum-mask) fn) (current-fixnum-tag))))

(define (boolean/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-boolean-mask) fn) (current-boolean-tag))))

(define (empty/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-empty-mask) fn) (current-empty-tag))))

(define (void/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-void-mask) fn) (current-void-tag))))

(define (ascii-char/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-ascii-char-mask) fn) (current-ascii-char-tag))))

(define (error/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-error-mask) fn) (current-error-tag))))

(define (pair/tagged? fn)
  (and (int64? fn) (eq? (bitwise-and (current-pair-mask) fn) (current-pair-tag))))

(define primop `(,@binop/unsafe ,@unop))
(define primop? (compose not false? (curryr memq primop)))

(module+ test
  (require rackunit)
  (check-true (binop? '+))
  (check-true (binop? '-))
  (check-true (binop? '*))
  (check-true (binop? 'eq?))
  (check-true (binop? '>))
  (check-true (binop? '>=))
  (check-true (binop? '<=))
  (check-true (binop? '<))

  (check-true (unop? 'fixnum?))
  (check-true (unop? 'boolean?))
  (check-true (unop? 'empty?))
  (check-true (unop? 'void?))
  (check-true (unop? 'ascii-char?))
  (check-true (unop? 'error?))
  (check-true (unop? 'not))

  (let ([binop? prim-f?]
        [unop? prim-f?])
    (check-true (binop? '+))
    (check-true (binop? '-))
    (check-true (binop? '*))
    (check-true (binop? 'eq?))
    (check-true (binop? '>))
    (check-true (binop? '>=))
    (check-true (binop? '<=))
    (check-true (binop? '<))

    (check-true (unop? 'fixnum?))
    (check-true (unop? 'boolean?))
    (check-true (unop? 'empty?))
    (check-true (unop? 'void?))
    (check-true (unop? 'ascii-char?))
    (check-true (unop? 'error?))
    (check-true (unop? 'not)))
  (check-true (primop? 'unsafe-fx+))
  (check-true (primop? 'unsafe-fx-))
  (check-true (primop? 'unsafe-fx*))
  (check-true (primop? 'unsafe-fx<))
  (check-true (primop? 'unsafe-fx<=))
  (check-true (primop? 'unsafe-fx>))
  (check-true (primop? 'unsafe-fx>=)))
