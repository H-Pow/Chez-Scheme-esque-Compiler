#lang racket

(require cpsc411/compiler-lib)
(provide resolve-predicates)


;;
;   p	 	::=	 	(module b ... b)

;   b	 	::=	 	(define label tail)

;   pred	 	::=	 	(relop loc opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)

;   tail	 	::=	 	(halt opand)
;  	 	|	 	(jump trg)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if -pred +(relop loc opand) (jump trg) (jump trg))

;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))

;   opand	 	::=	 	int64
;  	 	|	 	loc

;   loc	 	::=	 	reg
;  	 	|	 	fvar
;; block-pred-lang-v4 ->  block-asm-lang-v4
;; Compile the Block-pred-lang v4 to Block-asm-lang v4 by manipulating the branches of
;; if statements to resolve branches.
(define (resolve-predicates p)
  (match p
    [`(module ,b* ... ,b)
     `(module ,@(map resolve-b b*) ,(resolve-b b))])
  )
(define (resolve-pred pred truecase falsecase)
  (match pred
    [`(,_ ,_ ,_) `(if ,pred ,truecase ,falsecase)]
    [`(true) truecase]
    [`(false) falsecase]
    [`(not ,pred) (resolve-pred pred falsecase truecase)]))
(define (resolve-tail tail)
  (match tail
    [`(halt ,_) tail]
    [`(jump ,_) tail]
    [`(begin ,fx* ... ,tail)
     `(begin ,@fx* ,(resolve-tail tail))]
    [`(if ,pred
          (jump ,trg1)
          (jump ,trg2))
     (resolve-pred pred
                   `(jump ,trg1)
                   `(jump ,trg2))] ))
(define (resolve-b b)
  (match b
    [`(define ,(? label? label) ,tail)
     `(define ,label ,(resolve-tail tail))]))

(module+ test
  (require rackunit
           cpsc411/langs/v4)
  (define-syntax-rule (check func in expected)
    (check-equal? (func in) expected))
  (define-syntax-rule (check-resolve-predicates bpl4 expected)
    (check resolve-predicates bpl4 expected))
  (define-syntax-rule (check-by-interp bpl4)
    (check-equal? (interp-block-pred-lang-v4 bpl4)
                  (interp-block-asm-lang-v4 (resolve-predicates bpl4))))

  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5)))
                            `(module (define L.start.1
                                       (halt 5))))

  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1)))
                            `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))))

  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (if (not (true))
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (jump L.start.1))))
  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (if (true)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (jump L.start.2))))
  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (if (false)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (jump L.start.1))
                               (define L.start.3
                                 (jump L.start.1))))

  (check-resolve-predicates `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (begin
                                   (set! rax 5)
                                   (jump L.start.1)))
                               (define L.start.3
                                 (if (> rax 2)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1
                                       (halt 5))
                               (define L.start.2
                                 (begin
                                   (set! rax 5)
                                   (jump L.start.1)))
                               (define L.start.3
                                 (if (> rax 2)
                                     (jump L.start.2)
                                     (jump L.start.1)))))

  )