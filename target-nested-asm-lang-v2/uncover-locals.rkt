#lang racket

(require cpsc411/compiler-lib
         "../common.rkt")
(provide uncover-locals)

;; asm-pred-lang-v6 p -> asm-pred-lang-v6/locals p
;; Compiles Asm-pred-lang v6 to Asm-pred-lang v6/locals,
;; analysing which abstract locations are used in each block,
;; and updating each block and the module with the set of variables
;; in an info? fields.
(define (uncover-locals p)

  (define (uncover-definitions def)
    (match def
      [`(define ,label
          ,info
          ,tail)
       `(define ,label
          ,(info-set info 'locals (set->list (uncover-tail tail)))
          ,tail)]))

  (define (uncover-triv triv)
    (match triv
      [(? (or/c register? fvar? label? int64?)) (set)]
      [(? aloc?) (set triv)]))

  (define (uncover-loc loc)
    (match loc
      [(? aloc?) (set loc)]
      [_ (set)]))

  (define (uncover-pred pred)
    (match pred
      [`(,relop ,loc ,triv)
       #:when (memq relop '(< <= = >= > !=))
       (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(true) (set)]
      [`(false) (set)]
      [`(not ,p) (uncover-pred p)]
      [`(begin
          ,fxs ...
          ,p)
       (set-union (uncover-effects fxs) (uncover-pred p))]
      [`(if ,p1 ,p2 ,p3) (set-union (uncover-pred p1) (uncover-pred p2) (uncover-pred p3))]))

  (define (uncover-effect effect)
    (match effect
      [`(set! ,loc (,binop ,loc ,triv)) 
        #:when (binop/ptr? binop)
      (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(set! ,loc ,triv) (set-union (uncover-loc loc) (uncover-triv triv))]
      [`(begin
          ,fxs ...
          ,fx)
       (set-union (uncover-effects fxs) (uncover-effect fx))]
      [`(if ,pred ,e1 ,e2) (set-union (uncover-pred pred) (uncover-effect e1) (uncover-effect e2))]
      [`(return-point ,_ ,tail) (uncover-tail tail)]))

  (define (uncover-effects fxs)
    (for/fold ([locals (set)]) ([fx fxs])
      (set-union locals (uncover-effect fx))))

  (define (uncover-tail tail)
    (match tail
      [`(begin
          ,fxs ...
          ,t)
       (set-union (uncover-effects fxs) (uncover-tail t))]
      [`(halt ,triv) (uncover-triv triv)]
      [`(if ,pred ,t1 ,t2) (set-union (uncover-pred pred) (uncover-tail t1) (uncover-tail t2))]
      [`(jump ,trg ,loc ...) (foldr (lambda (cur acc) (set-union (uncover-loc cur) acc)) (set) loc)]))

  (define (uncover-p p)
    (match p
      [`(module ,info ,definitions
          ...
          ,tail)
       `(module ,(info-set info 'locals (set->list (uncover-tail tail)))
                ,@(map uncover-definitions definitions)
          ,tail)]))
  (uncover-p p))

(module+ test
  (require rackunit
           cpsc411/langs/v5
           cpsc411/langs/v6)
  (define-syntax-rule (check-by-interp asmplv5)
    (check-equal? (interp-asm-pred-lang-v5 asmplv5)
                  (interp-asm-pred-lang-v5/locals (uncover-locals asmplv5))))
  (define-syntax-rule (check-by-interp-v6 p)
    (check-equal? (interp-asm-pred-lang-v6 p) (interp-asm-pred-lang-v6/locals (uncover-locals p))))

  ; example output for uncover-locals

  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (halt x.1))
                                  ))
               '(module ((locals (x.1)))
                        (begin
                          (set! x.1 0)
                          (halt x.1))
                  ))
  (check-match (uncover-locals '(module ()
                                        (begin
                                          (set! x.1 0)
                                          (set! y.1 x.1)
                                          (set! y.1 (+ y.1 x.1))
                                          (halt y.1))
                                  ))
               `(module ((locals ,locals))
                        (begin
                          (set! x.1 0)
                          (set! y.1 x.1)
                          (set! y.1 (+ y.1 x.1))
                          (halt y.1))
                  )
               (equal? (list->seteq locals) (seteq 'x.1 'y.1)))

  ;; works, just in different order
  #;(check-equal? (uncover-locals `(module ()
                                           (begin
                                             (set! x.1 5)
                                             (set! y.2 x.1)
                                             (begin
                                               (set! b.3 x.1)
                                               (set! b.3 (+ b.3 y.2))
                                               (set! c.4 b.3)
                                               (if (if (true)
                                                       (false)
                                                       (not (false)))
                                                   (halt c.4)
                                                   (begin
                                                     (set! x.1 c.4)
                                                     (set! x.1 y.2)
                                                     (halt c.4)))))
                                     ))
                  `(module ((locals (b.3 x.1 y.2 c.4)))
                           (begin
                             (set! x.1 5)
                             (set! y.2 x.1)
                             (begin
                               (set! b.3 x.1)
                               (set! b.3 (+ b.3 y.2))
                               (set! c.4 b.3)
                               (if (if (true)
                                       (false)
                                       (not (false)))
                                   (halt c.4)
                                   (begin
                                     (set! x.1 c.4)
                                     (set! x.1 y.2)
                                     (halt c.4)))))
                     ))
  (check-match (uncover-locals '(module ()
                                        (define L.newlabel.1
                                          ()
                                          (begin
                                            (set! x.1 0)
                                            (halt x.1)))
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1)))
                        (define L.newlabel.1
                          ((locals (x.1)))
                          (begin
                            (set! x.1 0)
                            (halt x.1)))
                  (begin
                    (set! x.1 0)
                    (halt x.1))))

  (check-match (uncover-locals '(module ()
                                        (define L.newlabel.1
                                          ()
                                          (begin
                                            (set! x.1 0)
                                            (halt x.1)))
                                  (define L.newlabel.2
                                    ()
                                    (begin
                                      (set! x.1 5)
                                      (set! y.2 x.1)
                                      (begin
                                        (set! b.3 x.1)
                                        (set! b.3 (+ b.3 y.2))
                                        (set! c.4 b.3)
                                        (if (if (true)
                                                (false)
                                                (not (false)))
                                            (halt c.4)
                                            (begin
                                              (set! x.1 c.4)
                                              (set! x.1 y.2)
                                              (halt c.4))))))
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1)))
                        (define L.newlabel.1
                          ((locals (x.1)))
                          (begin
                            (set! x.1 0)
                            (halt x.1)))
                  (define L.newlabel.2
                    ((locals (c.4 x.1 b.3 y.2)))
                    (begin
                      (set! x.1 5)
                      (set! y.2 x.1)
                      (begin
                        (set! b.3 x.1)
                        (set! b.3 (+ b.3 y.2))
                        (set! c.4 b.3)
                        (if (if (true)
                                (false)
                                (not (false)))
                            (halt c.4)
                            (begin
                              (set! x.1 c.4)
                              (set! x.1 y.2)
                              (halt c.4))))))
                  (begin
                    (set! x.1 0)
                    (halt x.1))))

  #; 
  (check-match (uncover-locals 
  `(module ((new-frames ())) 
  (define L.<.4 ((new-frames ())) 
    (begin (set! opand1.7 rdi) 
            (set! opand2.8 rsi) 
            (set! tmp-ra.1013 r15) 
        (if (!= (if (= (bitwise-and opand1.7 7) 0) 14 6) 6) 
        (if (!= (if (= (bitwise-and opand2.8 7) 0) 14 6) 6) 
        (if (< opand1.7 opand2.8) (begin (set! rax 14) 
        (jump tmp-ra.1013 rbp rax)) 
        (begin (set! rax 6) 
        (jump tmp-ra.1013 rbp rax))) 
        (begin (set! rax 574) 
        (jump tmp-ra.1013 rbp rax))) 
        (begin (set! rax 574) 
        (jump tmp-ra.1013 rbp rax))))) 
  (define L.+.1 ((new-frames ())) 
        (begin (set! opand1.1 rdi) 
        (set! opand2.2 rsi) 
        (set! tmp-ra.1014 r15) 
        (if (!= (if (= (bitwise-and opand1.1 7) 0) 14 6) 6) 
        (if (!= (if (= (bitwise-and opand2.2 7) 0) 14 6) 6) 
        (begin (set! rax opand1.1) 
              (set! rax (+ rax opand2.2)) 
              (jump tmp-ra.1014 rbp rax)) 
              (begin (set! rax 574) 
              (jump tmp-ra.1014 rbp rax))) 
        (begin (set! rax 574) (jump tmp-ra.1014 rbp rax))))) 
  (define L.<=.5 ((new-frames ())) (begin (set! opand1.9 rdi) 
      (set! opand2.10 rsi) (set! tmp-ra.1015 r15) 
      (if (!= (if (= (bitwise-and opand1.9 7) 0) 14 6) 6) 
      (if (!= (if (= (bitwise-and opand2.10 7) 0) 14 6) 6) 
      (if (<= opand1.9 opand2.10) (begin (set! rax 14) 
      (jump tmp-ra.1015 rbp rax)) (begin (set! rax 6) 
      (jump tmp-ra.1015 rbp rax))) (begin (set! rax 574) 
      (jump tmp-ra.1015 rbp rax))) (begin (set! rax 574) 
      (jump tmp-ra.1015 rbp rax))))) 
  (define L.*.3 ((new-frames ())) 
      (begin (set! opand1.5 rdi) 
        (set! opand2.6 rsi) 
        (set! tmp-ra.1016 r15) 
        (if (!= (if (= (bitwise-and opand1.5 7) 0) 14 6) 6) 
        (if (!= (if (= (bitwise-and opand2.6 7) 0) 14 6) 6) 
        (begin (set! rax opand1.5) 
              (set! rax (* rax (arithmetic-shift-right opand2.6 3))) 
        (jump tmp-ra.1016 rbp rax)) 
        (begin (set! rax 574) (jump tmp-ra.1016 rbp rax))) 
        (begin (set! rax 574) (jump tmp-ra.1016 rbp rax))))) 
  (define L.-.2 ((new-frames ())) (begin (set! opand1.3 rdi) 
      (set! opand2.4 rsi) (set! tmp-ra.1017 r15) 
      (if (!= (if (= (bitwise-and opand1.3 7) 0) 14 6) 6) 
      (if (!= (if (= (bitwise-and opand2.4 7) 0) 14 6) 6) 
      (begin (set! rax opand1.3) (set! rax (- rax opand2.4))
      (jump tmp-ra.1017 rbp rax)) (begin (set! rax 574) (jump tmp-ra.1017 rbp rax))) 
      (begin (set! rax 574) (jump tmp-ra.1017 rbp rax))))) 
    (begin (set! tmp-ra.1012 r15) (set! rax 14) (jump tmp-ra.1012 rbp rax))))
  )
#;
  `(module ((new-frames ())) (define L.*.3 ((new-frames ())) 
      (begin (set! opand1.5 rdi) 
        (set! opand2.6 rsi) 
        (set! tmp-ra.1016 r15) 
        (if (!= (if (= (bitwise-and opand1.5 7) 0) 14 6) 6) 
        (if (!= (if (= (bitwise-and opand2.6 7) 0) 14 6) 6) 
        (begin (set! rax opand1.5) 
              (set! rax (* rax (arithmetic-shift-right opand2.6 3))) 
        (jump tmp-ra.1016 rbp rax)) 
        (begin (set! rax 574) (jump tmp-ra.1016 rbp rax))) 
        (begin (set! rax 574) (jump tmp-ra.1016 rbp rax))))) 
      (begin (set! tmp-ra.1012 r15) (set! rax 14) (jump tmp-ra.1012 rbp rax)))
  
)
