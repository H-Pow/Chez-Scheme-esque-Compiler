#lang racket
(provide all-defined-out)
(define binop '(+ - * eq? < <= > >=))
(define binop? (compose not false? (curryr memq binop)))
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