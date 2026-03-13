#lang racket
(require cpsc411/compiler-lib
         cpsc411/graph-lib)


;; asm-pred-lang-v6/conflicts
#|
p	 	::=	 	(module info (define label info tail) ... tail)
 	 	 	 	 
info	 ::=	(#:from-contract (info/c (new-frames (frame ...)) (locals (aloc ...)) 
                (call-undead (loc ...)) (conflicts ((loc (loc ...)) ...))))
 	 	 	 	 
frame	 ::=	(aloc ...)	 	 	 	
|#

;; asm-pred-lang-v6/pre-framed
#|
p	 	 ::=	 (module info (define label info tail) ... tail)
 	 	 	 	 
info	 ::=	 (#:from-contract (info/c (new-frames (frame ...)) (locals (aloc ...)) 
                 (call-undead (loc ...)) (conflicts ((loc (loc ...)) ...)) 
                 (assignment ((aloc fvar) ...))))
 	 	 	 	 
frame	 ::=	 (aloc ...) 	 	 	 	
|#

;; (asm-pred-lang-v6/conflicts p) -> (asm-pred-lang-v6/pre-framed p)
;; Compiles Asm-pred-lang-v6/conflicts to Asm-pred-lang-v6/pre-framed by pre-assigning 
;; all variables in the call-undead sets to frame variables.
(define (assign-call-undead-variables p)

    (define (assign-call-undead-variables/def def)
        (match def
            [`(define ,label ,info ,tail)
             `(define ,label  
                      ,(info-set info 'assignment (assign-call-undead-variables/info info))
                      ,tail)]))

    (define (assign-call-undead-variables/info info)
        (let ([default-assignment '()]
              [conflicts (info-ref info 'conflicts)]
              [call-undead (info-ref info 'call-undead)])
            (if (empty? info)
                default-assignment
                (assign-call-undead-fvar call-undead conflicts))))

    (define (assign-call-undead-fvar call-undead conflicts)
        (if (empty? call-undead)
            '()
            (let* ([current-variable (car call-undead)]
                   [assignments (assign-call-undead-fvar (cdr call-undead) 
                                                         (remove-vertex conflicts current-variable))]
                   [incompatiable-fvars-set (get-incompatible current-variable assignments conflicts)])
                   (displayln "assign-call-undead")
                   (displayln incompatiable-fvars-set)
                   (displayln (symbol? (cdr (set->list incompatiable-fvars-set))))

              (cons `(,current-variable
                      ,(let/cc return
                        (let loop ([i 0])
                          (let ([current (string->symbol (format "fvar~a" i))])
                            (if (memq current (set->list incompatiable-fvars-set))
                                (loop (+ 1 i))
                                (return current))))))
                      assignments))))

    (define (get-incompatible current-variable assignments conflicts)
      (let* ([directly-conflicting (get-neighbors conflicts current-variable)]
             [incompatiable-fvars-set (mutable-set (filter fvar? directly-conflicting))])
        (for ([assignment assignments]
              #:when (memq (car assignment) directly-conflicting))
          (displayln "get-incompatible")
          (displayln (symbol? (cdr assignment)))
          (set-add! incompatiable-fvars-set (cdr assignment)))
        incompatiable-fvars-set))

    (match p
        [`(module ,info ,defs ... ,tail)
            `(module ,(info-set info 'assignment (assign-call-undead-variables/info info))
                     ,@(map assign-call-undead-variables/def defs)
                     ,tail)]))

(module+ test
  (require rackunit)
    (check-equal? (assign-call-undead-variables 
    `(module
  ((new-frames ())
   (locals (ball.2.3 foobar.3.1 bat.9.2 tmp-ra.4))
   (call-undead ())
   (undead-out
    ((tmp-ra.4 rbp)
     (bat.9.2 tmp-ra.4 rbp)
     (foobar.3.1 tmp-ra.4 rbp)
     (foobar.3.1 tmp-ra.4 rbp)
     (tmp-ra.4 rax rbp)
     (rax rbp)))
   (conflicts
    ((tmp-ra.4 (rax ball.2.3 foobar.3.1 bat.9.2 rbp))
     (bat.9.2 (rbp tmp-ra.4))
     (foobar.3.1 (rbp tmp-ra.4))
     (ball.2.3 (rbp tmp-ra.4))
     (rbp (rax ball.2.3 foobar.3.1 bat.9.2 tmp-ra.4))
     (rax (rbp tmp-ra.4)))))
  (begin
    (set! tmp-ra.4 r15)
    (set! bat.9.2 -422317085)
    (set! foobar.3.1 bat.9.2)
    (set! ball.2.3 foobar.3.1)
    (set! rax foobar.3.1)
    (jump tmp-ra.4 rbp rax))))
    
    `(module
  ((new-frames ())
   (locals (tmp-ra.4 bat.9.2 foobar.3.1 ball.2.3))
   (call-undead ())
   (undead-out
    ((tmp-ra.4 rbp)
     (bat.9.2 tmp-ra.4 rbp)
     (foobar.3.1 tmp-ra.4 rbp)
     (foobar.3.1 tmp-ra.4 rbp)
     (tmp-ra.4 rax rbp)
     (rax rbp)))
   (conflicts
    ((tmp-ra.4 (rax ball.2.3 foobar.3.1 bat.9.2 rbp))
     (bat.9.2 (rbp tmp-ra.4))
     (foobar.3.1 (rbp tmp-ra.4))
     (ball.2.3 (rbp tmp-ra.4))
     (rbp (rax ball.2.3 foobar.3.1 bat.9.2 tmp-ra.4))
     (rax (rbp tmp-ra.4))))
   (assignment ()))
  (begin
    (set! tmp-ra.4 r15)
    (set! bat.9.2 -422317085)
    (set! foobar.3.1 bat.9.2)
    (set! ball.2.3 foobar.3.1)
    (set! rax foobar.3.1)
    (jump tmp-ra.4 rbp rax)))
    
    
    )

  (check-equal? (assign-call-undead-variables '(module
  ((new-frames ())
    (locals (ball.8.9 bar.7.6 bar.7.8 tmp-ra.13 bat.0.7 tmp.15))
    (undead-out
      ((rdi rsi tmp-ra.13 rbp)
       (rsi bat.0.7 tmp-ra.13 rbp)
       (bat.0.7 tmp-ra.13 rbp)
       (bat.0.7 bar.7.8 tmp-ra.13 rbp)
       ((rax bat.0.7 bar.7.8 tmp-ra.13 rbp)
        ((bar.7.8 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (bat.0.7 bar.7.8 tmp-ra.13 rbp)
       (((bat.0.7 tmp.15 bar.7.8 tmp-ra.13 rbp) (bar.7.8 tmp-ra.13 rbp))
        ((tmp-ra.13 rax rbp) (rax rbp))
        ((tmp-ra.13 rax rbp) (rax rbp)))))
     (call-undead (bat.0.7 bar.7.8 tmp-ra.13))
     (conflicts
      ((tmp.15 (rbp tmp-ra.13 bar.7.8 bat.0.7))
       (bat.0.7 (ball.8.9 rax bar.7.6 rbp tmp-ra.13 rsi tmp.15))
       (tmp-ra.13 (ball.8.9 bar.7.8 bar.7.6 bat.0.7 rbp rsi rdi tmp.15 rax))
       (bar.7.8 (ball.8.9 rax rbp tmp-ra.13 tmp.15))
       (bar.7.6 (rbp tmp-ra.13 bat.0.7))
       (ball.8.9 (rbp tmp-ra.13 bar.7.8 bat.0.7))
       (rax (bar.7.8 bat.0.7 rbp tmp-ra.13))
       (rbp
        (ball.8.9 r15 rdi rsi bar.7.8 bar.7.6 bat.0.7 tmp-ra.13 tmp.15 rax))
       (rdi (r15 rbp rsi tmp-ra.13))
       (rsi (r15 rdi rbp bat.0.7 tmp-ra.13))
       (r15 (rbp rdi rsi)))))
    (begin
      (set! tmp-ra.13 r15)
      (set! bat.0.7 rdi)
      (set! bar.7.6 rsi)
      (set! bar.7.8 bat.0.7)
      (return-point
       L.rp.3
       (begin
         (set! rsi bar.7.8)
         (set! rdi bar.7.8)
         (set! r15 L.rp.3)
         (jump L.proc.1.2 rbp r15 rdi rsi)))
      (set! ball.8.9 rax)
      (if (begin (set! tmp.15 -59730991) (= tmp.15 bat.0.7))
        (begin (set! rax 0) (jump tmp-ra.13 rbp rax))
        (begin (set! rax bar.7.8) (jump tmp-ra.13 rbp rax))))))
        
  `(module
  ((new-frames ())
   (locals (tmp.15 bar.7.6 ball.8.9))
   (undead-out
    ((rdi rsi tmp-ra.13 rbp)
     (rsi bat.0.7 tmp-ra.13 rbp)
     (bat.0.7 tmp-ra.13 rbp)
     (bat.0.7 bar.7.8 tmp-ra.13 rbp)
     ((rax bat.0.7 bar.7.8 tmp-ra.13 rbp)
      ((bar.7.8 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
     (bat.0.7 bar.7.8 tmp-ra.13 rbp)
     (((bat.0.7 tmp.15 bar.7.8 tmp-ra.13 rbp) (bar.7.8 tmp-ra.13 rbp))
      ((tmp-ra.13 rax rbp) (rax rbp))
      ((tmp-ra.13 rax rbp) (rax rbp)))))
   (call-undead (bat.0.7 bar.7.8 tmp-ra.13))
   (conflicts
    ((tmp.15 (rbp tmp-ra.13 bar.7.8 bat.0.7))
     (bat.0.7 (ball.8.9 rax bar.7.6 rbp tmp-ra.13 rsi tmp.15))
     (tmp-ra.13 (ball.8.9 bar.7.8 bar.7.6 bat.0.7 rbp rsi rdi tmp.15 rax))
     (bar.7.8 (ball.8.9 rax rbp tmp-ra.13 tmp.15))
     (bar.7.6 (rbp tmp-ra.13 bat.0.7))
     (ball.8.9 (rbp tmp-ra.13 bar.7.8 bat.0.7))
     (rax (bar.7.8 bat.0.7 rbp tmp-ra.13))
     (rbp (ball.8.9 r15 rdi rsi bar.7.8 bar.7.6 bat.0.7 tmp-ra.13 tmp.15 rax))
     (rdi (r15 rbp rsi tmp-ra.13))
     (rsi (r15 rdi rbp bat.0.7 tmp-ra.13))
     (r15 (rbp rdi rsi))))
   (assignment ((tmp-ra.13 fv0) (bar.7.8 fv1) (bat.0.7 fv1))))
  (begin
    (set! tmp-ra.13 r15)
    (set! bat.0.7 rdi)
    (set! bar.7.6 rsi)
    (set! bar.7.8 bat.0.7)
    (return-point
     L.rp.3
     (begin
       (set! rsi bar.7.8)
       (set! rdi bar.7.8)
       (set! r15 L.rp.3)
       (jump L.proc.1.2 rbp r15 rdi rsi)))
    (set! ball.8.9 rax)
    (if (begin (set! tmp.15 -59730991) (= tmp.15 bat.0.7))
      (begin (set! rax 0) (jump tmp-ra.13 rbp rax))
      (begin (set! rax bar.7.8) (jump tmp-ra.13 rbp rax))))))


)
