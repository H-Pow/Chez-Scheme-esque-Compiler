#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v7
         "common.rkt")

(provide specify-representation)

;; (exprs-unsafe-data-lang-v7 p) -> (exprs-bits-lang-v7 p)
;; Compiles immediate data and primitive operations into their implementations as
;; ptrs and primitive bitwise operations on ptrs.
(define (specify-representation p)

  (define (specify-triv triv)
    (match triv
      ['empty (current-empty-ptr)]
      ['(void) (current-void-ptr)]
      ['#t (current-true-ptr)]
      ['#f (current-false-ptr)]
      [(? ascii-char-literal?)
       (bitwise-ior (arithmetic-shift (char->integer triv) (current-ascii-char-shift))
                    (current-ascii-char-tag))]
      [(? int61?) (bitwise-ior (arithmetic-shift triv (current-fixnum-shift)) (current-fixnum-tag))]
      [`(error ,(? uint8? error-code))
       (bitwise-ior (arithmetic-shift error-code (current-error-shift)) (current-error-tag))]
      ;; label or aloc
      [_ triv]))

  ;; for add and sub: add then tag both
  ;; for *: tag one, then multiply
  ;; for relop, do nothing?

  (define (specify-binop binop value1 value2)

    (define (unsafe-binop->relop relop)
      (match relop
        [`eq? '=]
        [`unsafe-fx< '<]
        [`unsafe-fx<= '<=]
        [`unsafe-fx> '>]
        [`unsafe-fx>= '>=]))
    ;; (let [a.0 8]
    ;;    (* 8 1)))
    (match binop
      [`unsafe-fx*
       `(* ,(specify-value value1)
           (arithmetic-shift-right ,(specify-value value2) ,(current-fixnum-shift)))]
      [`unsafe-fx+ `(+ ,(specify-value value1) ,(specify-value value2))]
      [`unsafe-fx- `(- ,(specify-value value1) ,(specify-value value2))]
      [_
       `(if (,(unsafe-binop->relop binop) ,(specify-value value1) ,(specify-value value2))
            ,(current-true-ptr)
            ,(current-false-ptr))]))

  ;`(this that) -> (list 'this 'that)
  ; `(,(identity '>)) -> '(>) = (list '>)
  (define (specify-unop unop value)
    (define (evaluate-unop mask tag)
      `(if (= (bitwise-and ,(specify-value value) ,mask) ,tag)
           ,(current-true-ptr)
           ,(current-false-ptr)))

    (match unop
      [`fixnum? (evaluate-unop (current-fixnum-mask) (current-fixnum-tag))]
      [`boolean? (evaluate-unop (current-boolean-mask) (current-boolean-tag))]
      [`empty? (evaluate-unop (current-empty-mask) (current-empty-tag))]
      [`void? (evaluate-unop (current-void-mask) (current-void-tag))]
      [`ascii-char? (evaluate-unop (current-ascii-char-mask) (current-ascii-char-tag))]
      [`error? (evaluate-unop (current-error-mask) (current-error-tag))]
      [`not
       `(if (= ,(specify-value value) ,(current-false-ptr))
            ,(current-true-ptr)
            ,(current-false-ptr))]))

  (define (specify-primop primop values)
    (match primop
      [(? binop/unsafe?) (specify-binop primop (first values) (second values))]
      [(? unop?) (specify-unop primop (first values))]))

  (define (specify-value value)
    (match value
      [`(if ,v1 ,v2 ,v3)
       `(if (!= ,(specify-value v1) ,(current-false-ptr))
            ,(specify-value v2)
            ,(specify-value v3))]
      [`(let ([,alocs ,values] ...) ,body-value)
       ;; don't want to unquote splice the map result, or we lose outer brackets ([]
       ;;                                                                        []
       ;;                                                                        [])
       `(let ,(map (lambda (aloc value) `[,aloc ,(specify-value value)]) alocs values)
          ,(specify-value body-value))]
      [`(call ,values ...) `(call ,@(map specify-value values))]
      [`(,primop ,values ...)
       #:when (primop? primop)
       (specify-primop primop values)]
      [_ (specify-triv value)]))

  (define (specify-definition def)
    (match def
      [`(define ,label (lambda (,alocs ...) ,value))
       `(define ,label (lambda (,@alocs) ,(specify-value value)))]))

  (define (specify-p p)
    (match p
      [`(module ,defs ...
          ,value)
       `(module ,@(map specify-definition defs) ,(specify-value value)
          )]))

  (specify-p p))
