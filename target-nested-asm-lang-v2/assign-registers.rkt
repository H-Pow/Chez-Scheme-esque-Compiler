#lang racket

(require cpsc411/compiler-lib)
; Asm-lang-v2/conflicts
; p	 	::=	 	(module info tail)
;   info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (conflicts ((aloc (aloc ...)) ...))))
;----------------
; Asm-lang-v2/assignments
; p	 	::=	 	(module info tail)
;  info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (assignment ((aloc loc) ...))))


;; same as v4
(provide
 assign-registers)

;; (Listof X) (X -> Number) (X -> Y) -> Y
;; returns the (k x) with x as the least value item of the list given the evaluation function
; did I really need the continuation? no. But is it funny? sure.
(define (minimum& x* valueof [k identity])
  (let [(valueof (λ(x) (if (void? x)
                           +inf.f
                           (valueof x))))]
    (define (min-of x y)
      (if (> (valueof x)
             (valueof y))
          y
          x))
    (let loop ([x* x*]
               [cur-min (void)])
      (if (empty? x*) (k cur-min)
          (loop (rest x*) (min-of (first x*) cur-min))))))

;; (list X (listof Y)) -> Number
;; returns the number of Y in the given pair
(define (num-values pair)
  ; list traversal in Racket moment
  (length (cadr pair)))

;; (list X (listof Y)) Y -> (list X (listof Y))
;; remove one occurence the given Y from the list of Y
;;     if given Y does not exists in the list of Y, do nothing
(define (remove-from-loy pair val)
  (list (car pair) (remove val (cadr pair))))
;; asm-lang-v4/conflicts -> asm-lang-v4/assignments
;; Performs graph-colouring register allocation. The pass attempts to fit each of
;;     the abstract location declared in the locals set into a register,
;;     and if one cannot be found, assigns it a frame variable instead.
(define (assign-registers p)
  (define assignables (current-assignable-registers))
  (define num-fvars 0)

  ;let cinfo represent asm-lang-v4/conflicts-info
  ;let clocals represent asm-lang-v4/conflicts-info-locals
  ;let conflicts represent asm-lang-v4/conflicts-info-conflicts
  ;let ainfo represent asm-lang-v4/assignments-info
  ;let alocals represent asm-lang-v4/assignments-info-locals
  ;let assignments represent asm-lang-v4/assignment-info-assignments

  ;; (listof aloc) assignments -> (register or fvar)
  ;; produce a register that is not assigned by any aloc in the 'self-conflicts' list
  ;;     if no registers are available, produce a fvar instead.
  ;; EFFECT: increments the number of fvar allocated for the runtime of the 'assign-registers'
  ;;     function
  (define (get-assignment! self-conflicts assignments)
    (define assigned (map (λ(aloc) (info-ref assignments aloc)) self-conflicts))
    (define registers (filter (λ(reg) (not (memq reg assigned))) assignables))
    (if (empty? registers)
        (let [(fvar (make-fvar num-fvars))]
          (set! num-fvars (+ 1 num-fvars))
          fvar)
        ;; effects on assignment needs to be processed elsewhere
        (first registers)
        ))

  ;; cinfo (assignments -> ainfo) -> ainfo
  (define (assign-registers/info info)
    (define conflicts (info-ref info 'conflicts))
    (let loop ([conflicts conflicts]
               [k (λ (assignments)
                    (info-set info 'assignment assignments))])
      (if (empty? conflicts)
          (k '())
          (match-let [(`(,reg ,reg-conflicts) (minimum& conflicts num-values))]
            (loop (map (λ(conflict) (remove-from-loy conflict reg)) (info-remove conflicts reg))
                  (λ(assignments) (k (info-set assignments reg
                                               (get-assignment! reg-conflicts assignments)))))))))

  (match p
    [`(module ,info ,tail)
     `(module ,(assign-registers/info info) ,tail)]))

(module+ test
  ; oooooooh boy
  (require rackunit)
  (define-syntax-rule (check-minimum& lst valueof kont expected)
    (check-equal? (minimum& lst valueof kont) expected
                  (format "checking minimum&: \n (check-equal? (minimum& ~a ~a ~a) ~a)"
                          lst valueof kont expected)))

  (check-minimum& '() identity identity (void))
  (check-minimum& '(1) identity identity 1)
  (check-minimum& '(1 2 3) - identity 3)
  (check-minimum& '(1 2 3) - add1 4)
  (check-minimum& '(1 2 3) sub1 identity 1)

  (define-syntax-rule (check-num-values lst expected)
    (check-equal? (num-values lst) expected
                  (format "checking num-values: \n (check-equal? (num-values ~a) ~a)" lst expected)))

  (check-num-values `(x ()) 0)
  (check-num-values `(x (1)) 1)
  (check-num-values `(x (1 2)) 2)
  (check-num-values `(x (1 2 3)) 3)
  (check-num-values `(x (x y z)) 3)
  (check-num-values  (list ":)" (list "We are no stranger to love"
                                      "You know the rules and so do I"
                                      "a full commitment's what I'm thinking of"
                                      "You wouldn't get this from any other guy"
                                      "I / Just want to tell you how I am feeling"
                                      "Gotta make you understand"
                                      "Never gonna give you up"
                                      "Never gonna let you down"
                                      "Never gonna run around and"
                                      "desert you.")) 10)

  (define (check-remove-from-loy pair val expected)
    (check-equal? (remove-from-loy pair val) expected
                  (format "checking remove-from-loy: (remove-from-loy ~a ~a) = ~a" pair val expected)))

  (check-remove-from-loy '(x ()) 'x '(x ()))
  (check-remove-from-loy '(x (x y)) 'x '(x (y)))
  (check-remove-from-loy '(x (x x)) 'x '(x (x)))
  (check-remove-from-loy '(x (x y)) 'z '(x (x y)))

  (define-syntax-rule (check-assign-registers p expected pred)
    (check-match (assign-registers p)
                 expected
                 pred))

  (parameterize [(current-assignable-registers '(r15))]
    (check-assign-registers '(module ((locals (x.1))
                                      (conflicts ((x.1 ()))))
                               (begin
                                 (set! x.1 42)
                                 (halt x.1)))
                            `(module
                                 ((locals (x.1)) (conflicts ((x.1 ())))  (assignment ((x.1 r15))))
                               (begin (set! x.1 42) (halt x.1))) #t)
    )
  (parameterize ([current-assignable-registers '(r9)])
    (check-assign-registers
     '(module ((locals (x.1))
               (conflicts ((x.1 ()))))
        (begin
          (set! x.1 42)
          (halt x.1)))
     '(module
          ((locals (x.1)) (conflicts ((x.1 ()))) (assignment ((x.1 r9))))
        (begin (set! x.1 42) (halt x.1)))
     #t))
  (parameterize ([current-assignable-registers '()])
    (check-assign-registers
     '(module ((locals (x.1))
               (conflicts ((x.1 ()))))
        (begin
          (set! x.1 42)
          (halt x.1)))
     '(module
          ((locals (x.1)) (conflicts ((x.1 ()))) (assignment ((x.1 fv0))))
        (begin (set! x.1 42) (halt x.1)))
     #t))

  ;; it is hard to use example output as there are multiple valid outputs
  ;; conflict assignments -> boolean
  ;; returns true if the aloc does not share a register with its conflicting alocs.
  (define (no-conflicts? conflict assignments)
    (define (lookup aloc) (info-ref assignments aloc))
    (match-let ([`(,aloc ,aloc-conflict) conflict])
      (not (memq (lookup aloc) (map lookup aloc-conflict)))))

  (check-assign-registers
   '(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
             (conflicts
              ((x.3 (z.5 p.1 y.4 v.1 w.2))
               (w.2 (z.5 p.1 y.4 v.1 x.3))
               (v.1 (w.2 x.3))
               (y.4 (t.6 z.5 p.1 w.2 x.3))
               (p.1 (t.6 z.5 y.4 w.2 x.3))
               (z.5 (t.6 p.1 y.4 w.2 x.3))
               (t.6 (z.5 p.1 y.4)))))
      (begin
        (set! v.1 1)
        (set! w.2 46)
        (set! x.3 v.1)
        (set! p.1 7)
        (set! x.3 (+ x.3 p.1))
        (set! y.4 x.3)
        (set! p.1 4)
        (set! y.4 (+ y.4 p.1))
        (set! z.5 x.3)
        (set! z.5 (+ z.5 w.2))
        (set! t.6 y.4)
        (set! p.1 -1)
        (set! t.6 (* t.6 p.1))
        (set! z.5 (+ z.5 t.6))
        (halt z.5)))
   `(module
        ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
         (conflicts
          ,conflicts)
         (assignment
          ,a2))
      (begin
        (set! v.1 1)
        (set! w.2 46)
        (set! x.3 v.1)
        (set! p.1 7)
        (set! x.3 (+ x.3 p.1))
        (set! y.4 x.3)
        (set! p.1 4)
        (set! y.4 (+ y.4 p.1))
        (set! z.5 x.3)
        (set! z.5 (+ z.5 w.2))
        (set! t.6 y.4)
        (set! p.1 -1)
        (set! t.6 (* t.6 p.1))
        (set! z.5 (+ z.5 t.6))
        (halt z.5)))
   (andmap (λ(conflict)(no-conflicts? conflict a2)) conflicts)
   )
  ; fully connected graph(ie. full conflicts)
  (parameterize [(current-assignable-registers '(rax rdx rcx))]
    (check-assign-registers
     '(module ((locals (x.1 x.2 x.3))
               (conflicts
                ((x.1 (x.2 x.3))
                 (x.2 (x.1 x.3))
                 (x.3 (x.2 x.1)))))
        (begin (halt 1)))
     `(module ((locals (x.1 x.2 x.3))
               (conflicts
                ((x.1 (x.2 x.3))
                 (x.2 (x.1 x.3))
                 (x.3 (x.2 x.1))))
               (assignment ,a2))
        (begin (halt 1)))
     (andmap (not/c fvar?) (map cadr a2))
     ))
  )