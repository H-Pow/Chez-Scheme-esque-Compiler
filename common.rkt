#lang racket
(provide binop binop? binop/unsafe binop/unsafe? unop unop? prim-f prim-f? primop primop?)

(define binop '(+ - * eq? < <= > >=))
(define binop? (compose not false? (curryr memq binop)))
; NOTE: please make sure the unsafe variants are at the same order as the safe ones so it doesn't 
;    break implement-safe-primop
(define binop/unsafe '(unsafe-fx+ unsafe-fx- unsafe-fx* eq? unsafe-fx< unsafe-fx<= unsafe-fx> unsafe-fx>=))
(define binop/unsafe? (compose not false? (curryr memq binop/unsafe)))
(define unop '(fixnum?
               boolean?
               empty?
               void?
               ascii-char?
               error?
               not))
(define unop? (compose not false? (curryr memq unop)))

(define prim-f `(,@binop ,@unop))
(define prim-f? (compose not false? (curryr memq prim-f)))

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
    (check-true (unop? 'not))
    )
  )