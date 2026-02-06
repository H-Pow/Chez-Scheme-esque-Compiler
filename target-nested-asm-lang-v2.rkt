#lang racket
(require cpsc411/compiler-lib)

(provide assign-homes
         uncover-locals
         assign-fvars
         replace-locations)


; asm-lang-v2 -> nested-asm-lang-v2
(define (assign-homes al2)
  ; registers is a list of reg which is allowed in nested-asm-lang-v2
  ; rbp is allowed in nested-asm-lang-v2
  (define registers (current-assignable-registers))
  (define avail-reg registers)
  (define num-fvars 0)
  (define (get-loc!)
    (if (empty? avail-reg)
        (begin (set! num-fvars (add1 num-fvars))
               (make-fvar (sub1 num-fvars)))
        (let [(reg (first avail-reg))]
          (set! avail-reg (rest avail-reg))
          reg
          )
        )
    )
  (define env (make-hash))
  (define (assign-aloc aloc)
    (define reg (dict-ref env aloc (get-loc!)))
    (dict-set! env aloc reg)
    reg)
  (define (assign-triv triv)
    (match triv
      [(? int64?) triv]
      [(? aloc?) (assign-aloc triv)]))
  (define (assign-effect effect)
    (match effect
      [`(set! ,aloc (,binop ,aloc ,triv))
       `(set! ,(assign-aloc aloc) (,binop ,(assign-aloc aloc) ,(assign-triv triv)))]
      [`(set! ,aloc ,triv)
       `(set! ,(assign-aloc aloc) ,(assign-triv triv))]
      [`(begin ,fxs ... ,fx)
       (append '(begin)
               (map assign-effect fxs)
               (list (assign-effect fx)))]))
  (define (assign-tail tail)
    (match tail
      [`(begin ,fxs ... ,tail)
       (append (map assign-effect fxs)
               (assign-tail tail))]
      [`(halt ,triv) `((halt ,(assign-triv triv)))]))
  (define (assign-p p)
    (match p
      [`(module ,_ ,tail) (cons 'begin (assign-tail tail))]))
  (assign-p al2)
  )
; asm-lang-v2 -> asm-lang-v2/locals
(define (uncover-locals al2)
  ; (displayln "running uncover-locals")
  (define locals '())
  (define (uncover-aloc aloc)
    (set! locals (cons aloc locals))
    aloc)
  (define (uncover-triv triv)
    (match triv
      [(? int64?) triv]
      [(? aloc?) (uncover-aloc triv)]))
  (define (uncover-effect effect)
    (match effect
      [`(set! ,aloc (,binop ,aloc ,triv))
       `(set! ,(uncover-aloc aloc) (,binop ,aloc ,(uncover-triv triv)))]
      [`(set! ,aloc ,triv)
       `(set! ,(uncover-aloc aloc) ,(uncover-triv triv))]
      [`(begin ,fxs ... ,fx)
       (append '(begin)
               (map uncover-effect fxs)
               (list (uncover-effect fx)))]))
  (define (uncover-tail tail)
    (match tail
      [`(begin ,fxs ... ,tail)
       (append '(begin)
               (map uncover-effect fxs)
               (list (uncover-tail tail)))]
      [`(halt ,triv) `(halt ,(uncover-triv triv))]))
  (define (uncover-p p)
    (match p
      [`(module ,info ,tail)
       (define utail (uncover-tail tail))
       `(module ,(cons `(locals ,(reverse (set->list (list->set locals)))) info)
          ,utail)]))
  (uncover-p al2)
  )

;asm-lang-v2/locals -> asm-lang-v2/assignments
(define (assign-fvars alv2/l)
  ; (displayln "running assign-fvars")
  (define assignment '())
  (define (assign-info info)
    (define locals (first (dict-ref info 'locals)))
    (for-each (λ(i aloc) (set! assignment (cons `(,aloc ,(make-fvar i)) assignment)))
              (range (length locals)) locals)
    (dict-set info 'assignment `(,(reverse assignment))))
  (match alv2/l
    [`(module ,info ,tail)
     `(module ,(assign-info info) ,tail)]))

; asm-lang-v2/assignments -> nested-asm-lang-v2
(define (replace-locations al2a)
  ; (displayln "running replace-locations")
  (define (replace-aloc aloc assignment)
    (first (dict-ref assignment aloc (λ() (error (format "unassigned aloc ~a" aloc))))))
  (define (replace-triv triv assignment) (match triv
                                           [(? aloc?) (replace-aloc triv assignment)]
                                           [_ triv]))
  (define (replace-effect fx assignment)
    (match fx
      [`(set! ,aloc (,binop ,aloc ,triv))
       (define loc (replace-aloc aloc assignment))
       `(set! ,loc (,binop ,loc , (replace-triv triv assignment)))]
      [`(set! ,aloc ,triv) `(set! ,(replace-aloc aloc assignment)
                                  ,(replace-triv triv assignment))]
      [`(begin ,fxs ... ,fx) (append `(begin)
                                     (map (λ(fx) (replace-effect fx assignment)) fxs)
                                     (list (replace-effect fx assignment)))]))
  (define (replace-tail tail assignment)
    (match tail
      [`(halt ,triv) `((halt ,(replace-triv triv assignment)))]
      [`(begin ,fxs ... ,tail2) (append (map (λ(fx) (replace-effect fx assignment)) fxs)
                                        (replace-tail tail2 assignment))]
      ))
  (define (replace-p p)
    (match p
      [`(module ,info ,tail)
       `(begin ,@(replace-tail tail (first (dict-ref info 'assignment (λ() (error "missing assignment"))))))]))
  (replace-p al2a)
  )

; (define assign-homes (compose replace-locations assign-fvars uncover-locals))

(module+ test
  (require rackunit)

  (check-match (assign-homes '(module () (begin (set! x.1 2) (set! x.2 2) (set! tmp.2 x.1)
                                                (set! tmp.2 (+ tmp.2 x.2)) (halt tmp.2))))
              `(begin (set! ,rsp 2)
                      (set! ,rbx 2)
                      (set! ,rax ,rsp)
                      (set! ,rax (+ ,rax ,rbx))
                      (halt ,rax))
              (andmap (or/c register? fvar?) `(,rsp ,rax ,rbx)))
  
  ; example output for uncover-locals

  (check-match (uncover-locals '(module ()
                                  (begin
                                    (set! x.1 0)
                                    (halt x.1))))
               '(module ((locals (x.1))) (begin (set! x.1 0) (halt x.1))))
  (check-match (uncover-locals '(module ()
                                  (begin
                                    (set! x.1 0)
                                    (set! y.1 x.1)
                                    (set! y.1 (+ y.1 x.1))
                                    (halt y.1))))
               '(module
                    ((locals (x.1 y.1)))
                  (begin (set! x.1 0) (set! y.1 x.1) (set! y.1 (+ y.1 x.1)) (halt y.1))))

  ; example output for assign-fvars
  (check-equal? (assign-fvars '(module
                                   ((locals (x.1)))
                                 (begin
                                   (set! x.1 0)
                                   (halt x.1))))
                '(module
                     ((locals (x.1)) (assignment ((x.1 fv0))))
                   (begin (set! x.1 0) (halt x.1))))

  (check-equal? (assign-fvars
                 '(module
                      ((locals (x.1 y.1 w.1)))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))
                '(module
                     ((locals (x.1 y.1 w.1)) (assignment ((x.1 fv0) (y.1 fv1) (w.1 fv2))))
                   (begin
                     (set! x.1 0)
                     (set! y.1 x.1)
                     (set! w.1 1)
                     (set! w.1 (+ w.1 y.1))
                     (halt w.1))) )
  ; example output for replace-locations
  (check-equal? (replace-locations
                 '(module ((locals (x.1)) (assignment ((x.1 rax))))
                    (begin
                      (set! x.1 0)
                      (halt x.1))))

                '(begin (set! rax 0) (halt rax)))

  (check-equal? (replace-locations
                 '(module ((locals (x.1 y.1 w.1))
                           (assignment ((x.1 rax) (y.1 rbx) (w.1 r9))))
                    (begin
                      (set! x.1 0)
                      (set! y.1 x.1)
                      (set! w.1 1)
                      (set! w.1 (+ w.1 y.1))
                      (halt w.1))))

                '(begin (set! rax 0) (set! rbx rax) (set! r9 1) (set! r9 (+ r9 rbx)) (halt r9)))


  )