#lang racket

(require cpsc411/compiler-lib
         "common.rkt")

(provide normalize-bind)

;; (Imp-mf-lang v8 p) -> (Proc-imp-cmf-lang v8 p)
;; Compiles Imp-mf-lang v8 to Imp-cmf-lang v8, pushing set!
;; under begin and if so that the right-hand-side of each set!
;;is a simple value-producing operation.
(define (normalize-bind mf)
  (define opand? (or/c int64? aloc?) )
  (define triv? (or/c opand? label?))
  ;; let nvalue represent a value in Proc-imp-cmf-lang-v8
  ;; let ntail represent a tail in Proc-imp-cmf-lang-v8

  ;; join-begin so that the effects take place after the given tail's effect
  ;; this is necessary due to the use of continuations
  ;; (listof effect) tail -> tail
  (define (join-begin fx* tail)
    (match tail
      [`(begin
          ,fx2* ...
          ,tail)
       (make-begin (append fx2* fx*) tail)]
      [_ (make-begin fx* tail)]))
  (define (normalize-definitions definition)
    (match definition
      [`(define ,label (lambda ,alocs ,tail))
       `(define ,label (lambda ,alocs ,(normalize-tail tail)))]))

  (define (normalize-triv triv)
    triv)
  ;; value (nvalue -> ntail) -> ntail
  (define (normalize-value value [k identity])
    (match value
      [`(begin
          ,effects ...
          ,value2)
       (normalize-value value2 (λ (nvalue) (join-begin (map normalize-effect effects) (k nvalue))))]
      [`(if ,pred ,value1 ,value2)
       (normalize-value value1
                        (λ (nvalue1)
                          (normalize-value value2
                                           (λ (nvalue2)
                                             `(if ,(normalize-pred pred)
                                                  ,(k nvalue1)
                                                  ,(k nvalue2))))))]
      [`(mref ,aloc ,opand) (k `(mref ,aloc ,opand))]
      [`(alloc ,opand) (k `(alloc ,opand))]
      [`(,binop ,triv1 ,triv2)
       (k `(,binop ,(normalize-triv triv1) ,(normalize-triv triv2)))]
      [`(call ,_ ,_ ...) (k value)]
      [triv
       (k (normalize-triv triv))]))
  (define (normalize-pred pred)
    (match pred
      [`(not ,pred) `(not ,(normalize-pred pred))]
      [`(begin
          ,fxs ...
          ,pred)
       `(begin
          ,@(map normalize-effect fxs)
          ,(normalize-pred pred))]
      [`(if ,pred1 ,pred2 ,pred3)
       `(if ,(normalize-pred pred1)
            ,(normalize-pred pred2)
            ,(normalize-pred pred3))]
      [_ pred]))
  (define (normalize-effect effect)
    (match effect
      ; need to convert value to triv or (binop triv triv) with begin isolated out
      [`(set! ,aloc ,value) (normalize-value value (λ (nvalue) `(set! ,aloc ,nvalue)))]
      [`(begin
          ,effects ...
          ,effect2)
       `(begin
          ,@(map normalize-effect effects)
          ,(normalize-effect effect2))]
      [`(mset! ,aloc ,opand ,value)
       (normalize-value value (λ (nvalue)
                                (if (not (triv? nvalue))
                                    (let ([ntriv (fresh 'mset-tmp)])
                                      (make-begin-effect
                                       `((set! ,ntriv ,nvalue)
                                         (mset! ,aloc ,opand ,ntriv))))
                                    `(mset! ,aloc ,opand ,nvalue))))]
      [`(if ,pred ,effect1 ,effect2)
       `(if ,(normalize-pred pred)
            ,(normalize-effect effect1)
            ,(normalize-effect effect2))]))

  (define (normalize-tail tail)
    (match tail
      [`(begin
          ,effects ...
          ,tail)
       `(begin
          ,@(map normalize-effect effects)
          ,(normalize-tail tail))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(normalize-pred pred)
            ,(normalize-tail tail1)
            ,(normalize-tail tail2))]
      ;; nothing special happens
      [`(call ,_ ,_ ...) tail]
      [`(,binop ,triv1 ,triv2)
       ;  #:when (binop/ptr? binop)
       `(,binop ,(normalize-triv triv1) ,(normalize-triv triv2))]
      [value (normalize-value value)]))
  (define (normalize-p p)
    (match p
      [`(module ,definitions ...
          ,tail)
       `(module ,@(map normalize-definitions definitions) ,(normalize-tail tail)
          )]))

  (normalize-p mf))

(module+ test
  (require rackunit)
  (check-match (normalize-bind `(module 
        (define L.id.157.70 (lambda (c.361 x.158) x.158)) 
          (begin (set! id.157 
            (begin (set! tmp.438 
              (begin (set! tmp.1335 
                (begin (set! tmp.1336 (+ 16 0)) 
                (alloc tmp.1336))) (+ tmp.1335 2))) 
                (mset! tmp.438 -2 L.id.157.70) 
                (mset! tmp.438 6 8) tmp.438)) 
                (set! x.159 
        (begin (set! lambda.229 id.157) 
          (if (begin (set! tmp.1337 
          (if (begin (set! tmp.1338 (bitwise-and lambda.229 7)) 
                (= tmp.1338 2)) 14 6)) (!= tmp.1337 6)) 
                  (if (begin (set! tmp.1339 
                    (if (begin (set! tmp.1340 (mref lambda.229 6)) 
                          (= tmp.1340 8)) 14 6)) (!= tmp.1339 6)) 
                          (begin (set! tmp.1341 (mref lambda.229 -2)) 
                          (call tmp.1341 lambda.229 40)) 17726) 17214))) 
                          (set! lambda.230 id.157) 
                          (if (begin (set! tmp.1342 (if (begin (set! tmp.1343 (bitwise-and lambda.230 7)) 
                          (= tmp.1343 2)) 14 6)) (!= tmp.1342 6)) 
                          (if (begin (set! tmp.1344 
                          (if (begin (set! tmp.1345 (mref lambda.230 6)) 
                          (= tmp.1345 8)) 14 6)) (!= tmp.1344 6)) 
                          (begin (set! tmp.1346 (mref lambda.230 -2)) 
                          (call tmp.1346 lambda.230 x.159)) 17726) 17214))))
  
  `(module
  (define L.id.157.70 (lambda (c.361 x.158) x.158))
  (begin
    (begin
      (begin
        (begin 
          (set! tmp.1336 (+ 16 0)) 
          (set! tmp.1335 (alloc tmp.1336)))
        (set! tmp.438 (+ tmp.1335 2)))
      (mset! tmp.438 -2 L.id.157.70)
      (mset! tmp.438 6 8)
      (set! id.157 tmp.438))
    (begin
      (set! lambda.229 id.157)
      (if (begin
            (if (begin
                  (set! tmp.1338 (bitwise-and lambda.229 7))
                  (= tmp.1338 2))
              (set! tmp.1337 14)
              (set! tmp.1337 6))
            (!= tmp.1337 6))
        (if (begin
              (if (begin (set! tmp.1340 (mref lambda.229 6)) (= tmp.1340 8))
                (set! tmp.1339 14)
                (set! tmp.1339 6))
              (!= tmp.1339 6))
          (begin
            (set! tmp.1341 (mref lambda.229 -2))
            (set! x.159 (call tmp.1341 lambda.229 40)))
          (set! x.159 17726))
        (set! x.159 17214)))
    (set! lambda.230 id.157)
    (if (begin
          (if (begin (set! tmp.1343 (bitwise-and lambda.230 7)) (= tmp.1343 2))
            (set! tmp.1342 14)
            (set! tmp.1342 6))
          (!= tmp.1342 6))
      (if (begin
            (if (begin (set! tmp.1345 (mref lambda.230 6)) (= tmp.1345 8))
              (set! tmp.1344 14)
              (set! tmp.1344 6))
            (!= tmp.1344 6))
        (begin
          (set! tmp.1346 (mref lambda.230 -2))
          (call tmp.1346 lambda.230 x.159))
        17726)
      17214))))


  (check-match (normalize-bind '(module (begin
                                          (mset! x.1
                                                 y.1
                                                 (begin
                                                   (set! a.1 1)
                                                   (set! b.1 2)
                                                   42))
                                          0)))
               `(module (begin
                          (begin
                            (set! a.1 1)
                            (set! b.1 2)
                            (mset! x.1 y.1 42))
                          0)))

  (check-match (normalize-bind '(module (begin
                                          (mset! x.1 y.1 (if (true) 1 2))
                                          0)))
               `(module (begin
                          (if (true)
                              (mset! x.1 y.1 1)
                              (mset! x.1 y.1 2))
                          0)))

  ;; interpretation is correct, but were duplicating code.
  #;(check-match (normalize-bind '(module (begin
                                            (mset! x.1
                                                   y.1
                                                   (begin
                                                     (set! a.1 1)
                                                     (if (false) 10 20)))
                                            0)))
                 ;; interrogator response, pulling the set! out
                 `(module (begin
                            (begin
                              (set! a.1 1)
                              (if (false)
                                  (mset! x.1 y.1 10)
                                  (mset! x.1 y.1 20)))
                            0)))

  (check-match (normalize-bind '(module (begin
                                          (set! x.1
                                                (begin
                                                  (set! a.1 1)
                                                  (alloc y.1)))
                                          0)))
               `(module (begin
                          (begin
                            (set! a.1 1)
                            (set! x.1 (alloc y.1)))
                          0)))

  (check-match (normalize-bind '(module (begin
                                          (set! x.1
                                                (begin
                                                  (set! a.1 1)
                                                  (mref y.1 z.1)))
                                          0)))
               `(module (begin
                          (begin
                            (set! a.1 1)
                            (set! x.1 (mref y.1 z.1)))
                          0))))
