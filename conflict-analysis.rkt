#lang racket


(require 
    cpsc411/compiler-lib
    cpsc411/graph-lib)



;; Asm-lang v2/undead
; p	 	    ::=	 	(module info tail)
 	 	 	 	 
; info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (undead-out undead-set-tree?)))
 	 	 	 	 
; tail	 	::=	 	(halt triv)
;	 	    |	 	(begin effect ... tail)
;	 	 	 	 
; effect	 ::=	(set! aloc triv)
;	 	    |	 	(set! aloc_1 (binop aloc_1 triv))
;	 	    |	 	(begin effect ... effect)
;	 	 	 	 
; triv	 	::=	 	int64
;	 	    |	 	aloc
;	 	 	 	 
; binop	 	::=	 	*
;	 	    |	 	+
;	 	 	 	 
; aloc	 	::=	 	aloc?
;	 	 	 	 
; int64	 	::=	 	int64?


;; Asm-lang v2/conflicts
; p	 	    ::=	 	(module info tail)
;	 	 	 	 
; info	 	::=	 	(#:from-contract (info/c (locals (aloc ...)) (conflicts ((aloc (aloc ...)) ...))))
;	 	 	 	 
; tail	 	::=	 	(halt triv)
;	 	    |	 	(begin effect ... tail)
;	 	 	 	 
; effect	::=	 	(set! aloc triv)
;	 	    |	 	(set! aloc_1 (binop aloc_1 triv))
;	 	    |	 	(begin effect ... effect)
;	 	 	 	 
; triv	 	::=	 	int64
;	 	    |	 	aloc
;	 	 	 	 
; binop	 	::=	 	*
;	 	    |	 	+
;	 	 	 	 
; aloc	 	::=	 	aloc?
;	 	 	 	 
; int64	 	::=	 	int64?

(provide 
 conflict-analysis)


;; WTF
(define (conflict-analysis p)


    (define (in-graph? graph vertex)
        (if (not (empty? (get-neighbors graph vertex)))
            #t
            #f))
    
    (define (update-graph graph-init new-vertex vertices)
        (if (in-graph? graph-init new-vertex)
            (let ([new-vertex-graph 
                    (for/fold ([graph (remove-vertex graph-init new-vertex)])
                              ([vertex vertices])
                        (add-vertex graph vertex))])
                (add-edges new-vertex-graph new-vertex vertices))
            (let ([new-vertex-graph 
                    (for/fold ([graph graph-init])
                              ([vertex vertices])
                        (add-vertex graph vertex))])
                (add-edges new-vertex-graph new-vertex (set-remove vertices new-vertex)))))

    (define (set-remove-triv ust triv)
        (if (aloc? triv)
            (set-remove ust triv)
            ust)
    )

    ;; Undead-search-tree (Asm-lang-v2/undead tail) -> graph
    ;;
    (define (analyze-tree-effect ust effect graph-init)
        (match effect
            [`(begin ,effects ...)
              (for/fold ([graph graph-init])
                        ([effect effects]
                         [ust ust])
                (analyze-tree-effect ust effect graph))]
            [`(set! ,aloc (,binop ,aloc ,triv)) 
              (update-graph graph-init aloc (set-remove-triv ust triv))
            ]
            [`(set! ,aloc ,triv)
              (update-graph graph-init aloc (set-remove-triv ust triv))
            ]
        )
    )

    ;; Undead-search-tree (Asm-lang-v2/undead tail) -> graph
    (define (analyze-tree-tail ust tail graph-init)
        (match* (tail ust)
        [(`(begin ,effects ... ,tail)
          `(,usts ... ,ust))
          (analyze-tree-tail ust tail 
            (for/fold ([graph graph-init])
                      ([effect effects]
                       [ust usts])
             (analyze-tree-effect ust effect graph)))]
        [(`(halt ,triv)
           ust)
           graph-init]))

    (match p
        [`(module ,info ,tail)
         `(module ((locals ,(info-ref info 'locals))
                   (conflicts ,(analyze-tree-tail (info-ref info 'undead-out) tail (new-graph))))
            ,tail)]))

 

(module+ test
    (require rackunit)
    
(check-equal? 
    (conflict-analysis
         '(module 
            ((locals (x.1))
             (undead-out ((x.1) ())))
                (begin
                    (set! x.1 42)
                    (halt x.1))))
    '(module
         ((locals (x.1)) 
          (conflicts ((x.1 ()))))
            (begin 
                (set! x.1 42)   
                (halt x.1))))

(check-equal?
(conflict-analysis
         '(module 
            ((locals (y.1))
             (undead-out ((y.1) (y.1) ())))
                (begin
                    (set! y.1 42)
                    (set! x.1 1)
                    (halt y.1))))
                    
`(module
  ((locals (y.1)) (conflicts ((y.1 (x.1)) (x.1 (y.1)))))
  (begin (set! y.1 42) (set! x.1 1) (halt y.1))))

(check-equal? 
    (conflict-analysis
        '(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
                    (undead-out
                        ((v.1)
                    (v.1 w.2)
                    (w.2 x.3)
                    (p.1 w.2 x.3)
                    (w.2 x.3)
                    (y.4 w.2 x.3)
                    (p.1 y.4 w.2 x.3)
                    (y.4 w.2 x.3)
                    (z.5 y.4 w.2)
                    (z.5 y.4)
                    (t.6 z.5)
                    (t.6 z.5 p.1)
                    (t.6 z.5)
                    (z.5)
                    ())))
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
            (halt z.5))))
    '(module ((locals (v.1 w.2 x.3 y.4 z.5 t.6 p.1))
        (conflicts
        ((p.1 (z.5 t.6 y.4 x.3 w.2))
        (t.6 (p.1 z.5))
        (z.5 (p.1 t.6 w.2 y.4))
        (y.4 (z.5 x.3 p.1 w.2))
        (x.3 (y.4 p.1 w.2))
        (w.2 (z.5 y.4 p.1 x.3 v.1))
        (v.1 (w.2)))))
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
            (halt z.5))))
)