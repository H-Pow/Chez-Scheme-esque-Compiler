#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../normalize-bind.rkt")
(define (fail-if-invalid p)
  (when (not (proc-imp-cmf-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "proc-imp-cmf-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-imp-mf-lang-v8 p)
  (interp-proc-imp-cmf-lang-v8 (fail-if-invalid (normalize-bind p)))))

(check-by-interp '(module 30))
(check-by-interp
 '(module
    (define L.cons.5
      (lambda (tmp.46 tmp.47)
        (begin
          (set! tmp.50 (begin (set! tmp.51 (alloc 16)) (+ tmp.51 1)))
          (begin (mset! tmp.50 -1 tmp.46) (mset! tmp.50 7 tmp.47) tmp.50))))
    (call L.cons.5 1808 3816)))
(check-by-interp '(module (begin (set! ascii-char0.1 27438) 22)))
(check-by-interp '(module (begin (set! void0.1 30) 31790)))
(check-by-interp
 '(module
    (define L.cons.5
      (lambda (tmp.47 tmp.48)
        (begin
          (set! tmp.51 (begin (set! tmp.52 (alloc 16)) (+ tmp.52 1)))
          (begin (mset! tmp.51 -1 tmp.47) (mset! tmp.51 7 tmp.48) tmp.51))))
    (begin (set! void0.1 30) (call L.cons.5 1624 3704))))
(check-by-interp
 '(module
    (define L.fun/fixnum8389.4 (lambda () 1672))
    (call L.fun/fixnum8389.4)))
(check-by-interp '(module (begin (set! boolean0.2 6) (set! void1.1 30) 30)))
(check-by-interp
 '(module
    (define L.fun/fixnum8394.4 (lambda (oprand0.1) 312))
    (begin
      (set! tmp.51 (if (!= 14 6) 15934 45118))
      (call L.fun/fixnum8394.4 tmp.51))))
(check-by-interp
 '(module
    (define L.fun/error8401.4 (lambda (oprand0.1) 1854))
    (define L.fun/void8402.5 (lambda (oprand0.2) 30))
    (begin
      (set! tmp.52 (call L.fun/void8402.5 22))
      (call L.fun/error8401.4 tmp.52))))
(check-by-interp
 '(module
    (define L.cons.5
      (lambda (tmp.48 tmp.49)
        (begin
          (set! tmp.52 (begin (set! tmp.53 (alloc 16)) (+ tmp.53 1)))
          (begin (mset! tmp.52 -1 tmp.48) (mset! tmp.52 7 tmp.49) tmp.52))))
    (begin
      (set! ascii-char0.2 18222)
      (set! pair1.1 (call L.cons.5 832 2272))
      ascii-char0.2)))
(check-by-interp
 '(module
    (define L.cons.6
      (lambda (tmp.47 tmp.48)
        (begin
          (set! tmp.51 (begin (set! tmp.52 (alloc 16)) (+ tmp.52 1)))
          (begin (mset! tmp.51 -1 tmp.47) (mset! tmp.51 7 tmp.48) tmp.51))))
    (define L.fun/pair8407.4 (lambda (oprand0.1) (call L.cons.6 400 3872)))
    (begin
      (set! tmp.53 (if (!= 14 6) 17454 17966))
      (call L.fun/pair8407.4 tmp.53))))
(check-by-interp
 '(module (begin (set! fixnum0.2 1712) (set! boolean1.1 14) 1864)))
(check-by-interp
 '(module (begin (set! error0.2 13118) (set! boolean1.1 14) boolean1.1)))
(check-by-interp
 '(module
    (define L.cons.8
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.57 (alloc 16)) (+ tmp.57 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/error8419.4 (lambda (oprand0.2 oprand1.1) 47678))
    (define L.fun/boolean8418.5 (lambda (oprand0.4 oprand1.3) 6))
    (define L.fun/error8420.6 (lambda (oprand0.6 oprand1.5) 39998))
    (if (begin (set! tmp.58 (call L.fun/boolean8418.5 14 456)) (!= tmp.58 6))
      (call L.fun/error8419.4 14 22)
      (begin
        (set! tmp.59 (call L.cons.8 208 3240))
        (call L.fun/error8420.6 22 tmp.59)))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.54
                (if (begin (set! tmp.55 (bitwise-and tmp.20 7)) (= tmp.55 0))
                  14
                  6))
              (!= tmp.54 6))
          (if (begin
                (set! tmp.56
                  (if (begin (set! tmp.57 (bitwise-and tmp.19 7)) (= tmp.57 0))
                    14
                    6))
                (!= tmp.56 6))
            (+ tmp.19 tmp.20)
            574)
          574)))
    (define L.cons.8
      (lambda (tmp.49 tmp.50)
        (begin
          (set! tmp.53 (begin (set! tmp.58 (alloc 16)) (+ tmp.58 1)))
          (begin (mset! tmp.53 -1 tmp.49) (mset! tmp.53 7 tmp.50) tmp.53))))
    (define L.fun/ascii-char8439.4 (lambda () 22318))
    (define L.fun/error8440.5 (lambda () 4670))
    (define L.fun/pair8441.6 (lambda () (call L.cons.8 704 2392)))
    (begin
      (set! ascii-char0.3 (call L.fun/ascii-char8439.4))
      (set! error1.2 (call L.fun/error8440.5))
      (set! pair2.1 (call L.fun/pair8441.6))
      (call L.+.9 2024 1064))))
(check-by-interp
 '(module
    (define L.empty?.8
      (lambda (tmp.41)
        (if (begin (set! tmp.53 (bitwise-and tmp.41 255)) (= tmp.53 22))
          14
          6)))
    (define L.cons.7
      (lambda (tmp.48 tmp.49)
        (begin
          (set! tmp.52 (begin (set! tmp.54 (alloc 16)) (+ tmp.54 1)))
          (begin (mset! tmp.52 -1 tmp.48) (mset! tmp.52 7 tmp.49) tmp.52))))
    (define L.fun/pair8459.4 (lambda () (call L.cons.7 704 2824)))
    (define L.fun/pair8458.5
      (lambda (oprand0.2 oprand1.1) (call L.fun/pair8459.4)))
    (begin
      (set! tmp.55
        (begin
          (set! tmp.56 (if (!= 6 6) 54078 38718))
          (call L.empty?.8 tmp.56)))
      (begin
        (set! tmp.57 (if (!= 6 6) 30 30))
        (call L.fun/pair8458.5 tmp.55 tmp.57)))))
(check-by-interp
 '(module
    (define L.pair?.8
      (lambda (tmp.46)
        (if (begin (set! tmp.53 (bitwise-and tmp.46 7)) (= tmp.53 1)) 14 6)))
    (define L.fun/ascii-char8463.4 (lambda () 22574))
    (define L.fun/ascii-char8462.5 (lambda () 10286))
    (define L.fun/error8464.6 (lambda () 5694))
    (begin
      (set! ascii-char0.3 (call L.fun/ascii-char8462.5))
      (set! ascii-char1.2 (call L.fun/ascii-char8463.4))
      (set! boolean2.1 (call L.pair?.8 14))
      (call L.fun/error8464.6))))
(check-by-interp
 '(module
    (if (begin
          (set! boolean0.3 6)
          (set! fixnum1.2 1448)
          (set! boolean2.1 6)
          (!= boolean0.3 6))
      (begin
        (set! fixnum0.6 1104)
        (set! boolean1.5 14)
        (set! error2.4 64318)
        fixnum0.6)
      (if (!= 14 6) 416 664))))
(check-by-interp
 '(module
    (define L.cons.9
      (lambda (tmp.50 tmp.51)
        (begin
          (set! tmp.54 (begin (set! tmp.55 (alloc 16)) (+ tmp.55 1)))
          (begin (mset! tmp.54 -1 tmp.50) (mset! tmp.54 7 tmp.51) tmp.54))))
    (define L.fun/void8484.4 (lambda () 30))
    (define L.fun/empty8485.5 (lambda () 22))
    (define L.fun/pair8483.6 (lambda () (call L.cons.9 712 2640)))
    (define L.fun/empty8482.7 (lambda () 22))
    (begin
      (set! empty0.4 (call L.fun/empty8482.7))
      (set! pair1.3 (call L.fun/pair8483.6))
      (set! void2.2 (call L.fun/void8484.4))
      (set! empty3.1 (call L.fun/empty8485.5))
      pair1.3)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.21 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.20 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.-.11
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.23 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.22 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.18 tmp.19)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.19 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.18 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.19 3))
              (* tmp.18 tmp.67))
            318)
          318)))
    (define L.cons.9
      (lambda (tmp.50 tmp.51)
        (begin
          (set! tmp.54 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 1)))
          (begin (mset! tmp.54 -1 tmp.50) (mset! tmp.54 7 tmp.51) tmp.54))))
    (define L.fun/error8501.4 (lambda () 1342))
    (define L.fun/pair8499.5 (lambda () (call L.cons.9 592 2072)))
    (define L.fun/void8500.6 (lambda () 30))
    (define L.fun/void8498.7 (lambda () 30))
    (begin
      (set! fixnum0.4
        (begin
          (set! tmp.69 (call L.*.10 1400 1784))
          (begin
            (set! tmp.70 (call L.-.11 1776 2024))
            (call L.+.12 tmp.69 tmp.70))))
      (set! void1.3 (call L.fun/void8498.7))
      (set! pair2.2 (call L.fun/pair8499.5))
      (set! void3.1 (call L.fun/void8500.6))
      (call L.fun/error8501.4))))
(check-by-interp
 '(module
    (define L.pair?.10
      (lambda (tmp.59)
        (if (begin (set! tmp.67 (bitwise-and tmp.59 7)) (= tmp.67 1)) 14 6)))
    (define L.cons.9
      (lambda (tmp.62 tmp.63)
        (begin
          (set! tmp.66 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 1)))
          (begin (mset! tmp.66 -1 tmp.62) (mset! tmp.66 7 tmp.63) tmp.66))))
    (define L.fun/ascii-char8512.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) 18734))
    (define L.fun/ascii-char8510.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand0.6))
    (define L.fun/ascii-char8511.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) 12334))
    (define L.fun/boolean8513.7 (lambda (oprand0.12 oprand1.11 oprand2.10) 6))
    (begin
      (set! tmp.69
        (if (begin
              (set! ascii-char0.16 30510)
              (set! void1.15 30)
              (set! empty2.14 22)
              (set! error3.13 28222)
              (!= 14 6))
          (call L.fun/ascii-char8511.6 28974 23870 12078)
          (call L.fun/ascii-char8512.4 25134 13102 11838)))
      (begin
        (set! tmp.70
          (if (begin
                (set! tmp.71
                  (begin
                    (set! tmp.72 (call L.cons.9 688 3600))
                    (call L.pair?.10 tmp.72)))
                (!= tmp.71 6))
            (if (!= 14 6) 58942 23102)
            (if (!= 6 6) 54078 19774)))
        (begin
          (set! tmp.73
            (if (begin
                  (set! tmp.74 (call L.fun/boolean8513.7 416 1968 320))
                  (!= tmp.74 6))
              (if (!= 6 6) 18478 19246)
              (if (!= 14 6) 26414 18990)))
          (call L.fun/ascii-char8510.5 tmp.69 tmp.70 tmp.73))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8546.4 (lambda () 29486))
    (define L.fun/empty8547.5 (lambda () 22))
    (define L.fun/error8544.6 (lambda () 17982))
    (define L.fun/ascii-char8545.7 (lambda () 12334))
    (begin
      (set! error0.4 (call L.fun/error8544.6))
      (set! ascii-char1.3 (call L.fun/ascii-char8545.7))
      (set! ascii-char2.2 (call L.fun/ascii-char8546.4))
      (set! empty3.1 (call L.fun/empty8547.5))
      ascii-char1.3)))
(check-by-interp
 '(module
    (define L.void?.11
      (lambda (tmp.44)
        (if (begin (set! tmp.55 (bitwise-and tmp.44 255)) (= tmp.55 30))
          14
          6)))
    (define L.cons.10
      (lambda (tmp.50 tmp.51)
        (begin
          (set! tmp.54 (begin (set! tmp.56 (alloc 16)) (+ tmp.56 1)))
          (begin (mset! tmp.54 -1 tmp.50) (mset! tmp.54 7 tmp.51) tmp.54))))
    (define L.fun/any8685.4 (lambda () 30))
    (define L.fun/pair8681.5 (lambda () (call L.cons.10 856 3104)))
    (define L.fun/error8683.6 (lambda () 21310))
    (define L.fun/pair8684.7 (lambda () (call L.cons.10 936 2576)))
    (define L.fun/error8682.8 (lambda () 51774))
    (begin
      (set! tmp.57
        (begin
          (set! pair0.4 (call L.fun/pair8681.5))
          (set! error1.3 (call L.fun/error8682.8))
          (set! error2.2 (call L.fun/error8683.6))
          (set! pair3.1 (call L.fun/pair8684.7))
          (call L.fun/any8685.4)))
      (call L.void?.11 tmp.57))))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.22 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.21 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.24 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.23 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.20 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.19 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.68))
            318)
          318)))
    (define L.cons.9
      (lambda (tmp.51 tmp.52)
        (begin
          (set! tmp.55 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 1)))
          (begin (mset! tmp.55 -1 tmp.51) (mset! tmp.55 7 tmp.52) tmp.55))))
    (define L.fun/empty8893.4 (lambda () 22))
    (define L.fun/empty8894.5 (lambda () 22))
    (define L.fun/pair8895.6 (lambda () (call L.cons.9 1160 2344)))
    (define L.fun/void8896.7 (lambda () 30))
    (begin
      (set! empty0.5 (call L.fun/empty8893.4))
      (set! empty1.4 (call L.fun/empty8894.5))
      (set! fixnum2.3
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.*.10 1632 200))
              (begin
                (set! tmp.72 (call L.*.10 320 904))
                (call L.*.10 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.-.11 712 320))
                (begin
                  (set! tmp.75 (call L.+.12 896 928))
                  (call L.-.11 tmp.74 tmp.75))))
            (call L.-.11 tmp.70 tmp.73))))
      (set! pair3.2 (call L.fun/pair8895.6))
      (set! void4.1 (call L.fun/void8896.7))
      pair3.2)))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.20 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.19 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (begin
              (set! tmp.60 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.60))
            318)
          318)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.24 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.23 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.22 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.21 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.cons.9
      (lambda (tmp.51 tmp.52)
        (begin
          (set! tmp.55 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 1)))
          (begin (mset! tmp.55 -1 tmp.51) (mset! tmp.55 7 tmp.52) tmp.55))))
    (define L.fun/empty8907.4 (lambda () 22))
    (define L.fun/error8906.5 (lambda () 18238))
    (define L.fun/pair8908.6 (lambda () (call L.cons.9 1360 3040)))
    (define L.fun/void8909.7 (lambda () 30))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.+.10 864 1560))
              (begin
                (set! tmp.72 (call L.-.11 1632 1832))
                (call L.*.12 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.+.10 408 408))
                (begin
                  (set! tmp.75 (call L.+.10 1168 88))
                  (call L.*.12 tmp.74 tmp.75))))
            (call L.-.11 tmp.70 tmp.73))))
      (set! error1.4 (call L.fun/error8906.5))
      (set! fixnum2.3
        (begin
          (set! tmp.76
            (begin
              (set! tmp.77 (call L.+.10 1752 512))
              (begin
                (set! tmp.78 (call L.-.11 1728 1392))
                (call L.*.12 tmp.77 tmp.78))))
          (begin
            (set! tmp.79
              (begin
                (set! tmp.80 (call L.*.12 136 560))
                (begin
                  (set! tmp.81 (call L.-.11 176 984))
                  (call L.-.11 tmp.80 tmp.81))))
            (call L.+.10 tmp.76 tmp.79))))
      (set! empty3.2 (call L.fun/empty8907.4))
      (set! pair4.1 (call L.fun/pair8908.6))
      (call L.fun/void8909.7))))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.20 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.19 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (begin
              (set! tmp.60 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.60))
            318)
          318)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.24 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.23 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.22 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.21 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.cons.9
      (lambda (tmp.51 tmp.52)
        (begin
          (set! tmp.55 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 1)))
          (begin (mset! tmp.55 -1 tmp.51) (mset! tmp.55 7 tmp.52) tmp.55))))
    (define L.fun/pair9174.4 (lambda () (call L.cons.9 1016 3672)))
    (define L.fun/ascii-char9175.5 (lambda () 23598))
    (define L.fun/empty9176.6 (lambda () 22))
    (define L.fun/error9177.7 (lambda () 17470))
    (begin
      (set! pair0.5 (call L.fun/pair9174.4))
      (set! ascii-char1.4 (call L.fun/ascii-char9175.5))
      (set! empty2.3 (call L.fun/empty9176.6))
      (set! error3.2 (call L.fun/error9177.7))
      (set! fixnum4.1
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.+.10 1312 256))
              (begin
                (set! tmp.72 (call L.-.11 1592 320))
                (call L.+.10 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.*.12 1512 456))
                (begin
                  (set! tmp.75 (call L.+.10 280 1776))
                  (call L.-.11 tmp.74 tmp.75))))
            (call L.*.12 tmp.70 tmp.73))))
      error3.2)))
(check-by-interp
 '(module
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.20 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.19 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (begin
              (set! tmp.59 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.59))
            318)
          318)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.24 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.23 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.22 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.21 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/error9704.4 (lambda () 56382))
    (define L.fun/void9703.5 (lambda () 30))
    (define L.fun/void9702.6 (lambda () 30))
    (define L.fun/empty9705.7 (lambda () 22))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.+.9 904 992))
              (begin
                (set! tmp.70 (call L.-.10 1656 1512))
                (call L.-.10 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.+.9 1080 1624))
                (begin
                  (set! tmp.73 (call L.*.11 296 240))
                  (call L.+.9 tmp.72 tmp.73))))
            (call L.-.10 tmp.68 tmp.71))))
      (set! void1.4 (call L.fun/void9702.6))
      (set! void2.3 (call L.fun/void9703.5))
      (set! error3.2 (call L.fun/error9704.4))
      (set! empty4.1 (call L.fun/empty9705.7))
      error3.2)))
(check-by-interp
 '(module
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.20 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.19 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (begin
              (set! tmp.60 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.60))
            318)
          318)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.22 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.21 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.24 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.23 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.cons.8
      (lambda (tmp.51 tmp.52)
        (begin
          (set! tmp.55 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 1)))
          (begin (mset! tmp.55 -1 tmp.51) (mset! tmp.55 7 tmp.52) tmp.55))))
    (define L.fun/pair9710.4 (lambda () (call L.cons.8 792 2640)))
    (define L.fun/error9708.5 (lambda () 54846))
    (define L.fun/void9709.6 (lambda () 30))
    (begin
      (set! error0.5 (call L.fun/error9708.5))
      (set! void1.4 (call L.fun/void9709.6))
      (set! fixnum2.3
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.-.9 2000 152))
              (begin
                (set! tmp.72 (call L.-.9 784 416))
                (call L.-.9 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.-.9 1824 240))
                (begin
                  (set! tmp.75 (call L.+.10 320 312))
                  (call L.+.10 tmp.74 tmp.75))))
            (call L.+.10 tmp.70 tmp.73))))
      (set! fixnum3.2
        (begin
          (set! tmp.76
            (begin
              (set! tmp.77 (call L.*.11 216 992))
              (begin
                (set! tmp.78 (call L.*.11 168 568))
                (call L.+.10 tmp.77 tmp.78))))
          (begin
            (set! tmp.79
              (begin
                (set! tmp.80 (call L.+.10 1248 1352))
                (begin
                  (set! tmp.81 (call L.-.9 168 1632))
                  (call L.+.10 tmp.80 tmp.81))))
            (call L.*.11 tmp.76 tmp.79))))
      (set! pair4.1 (call L.fun/pair9710.4))
      void1.4)))
(check-by-interp
 '(module
    (define L.*.13
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.20 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.19 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (begin
              (set! tmp.60 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.60))
            318)
          318)))
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.24 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.23 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.22 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.21 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.cons.10
      (lambda (tmp.51 tmp.52)
        (begin
          (set! tmp.55 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 1)))
          (begin (mset! tmp.55 -1 tmp.51) (mset! tmp.55 7 tmp.52) tmp.55))))
    (define L.fun/void9976.4 (lambda () 30))
    (define L.fun/pair9973.5 (lambda () (call L.cons.10 1352 3448)))
    (define L.fun/empty9975.6 (lambda () 22))
    (define L.fun/void9974.7 (lambda () 30))
    (define L.fun/ascii-char9977.8 (lambda () 20782))
    (begin
      (set! pair0.5 (call L.fun/pair9973.5))
      (set! void1.4 (call L.fun/void9974.7))
      (set! empty2.3 (call L.fun/empty9975.6))
      (set! void3.2 (call L.fun/void9976.4))
      (set! fixnum4.1
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.+.11 1608 1288))
              (begin
                (set! tmp.72 (call L.-.12 1992 1528))
                (call L.+.11 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.-.12 688 1152))
                (begin
                  (set! tmp.75 (call L.*.13 1048 1848))
                  (call L.+.11 tmp.74 tmp.75))))
            (call L.-.12 tmp.70 tmp.73))))
      (call L.fun/ascii-char9977.8))))
(check-by-interp
 '(module
    (define L.fun/void15785.4 (lambda () (call L.fun/void15786.9)))
    (define L.fun/empty15784.5 (lambda () 22))
    (define L.fun/error15778.6 (lambda () 4670))
    (define L.fun/ascii-char15782.7 (lambda () 29742))
    (define L.fun/error15777.8 (lambda () (call L.fun/error15778.6)))
    (define L.fun/void15786.9 (lambda () 30))
    (define L.fun/ascii-char15781.10
      (lambda () (call L.fun/ascii-char15782.7)))
    (define L.fun/ascii-char15779.11
      (lambda () (call L.fun/ascii-char15780.14)))
    (define L.fun/empty15775.12 (lambda () (call L.fun/empty15776.15)))
    (define L.fun/empty15783.13 (lambda () (call L.fun/empty15784.5)))
    (define L.fun/ascii-char15780.14 (lambda () 21038))
    (define L.fun/empty15776.15 (lambda () 22))
    (begin
      (set! empty0.6 (call L.fun/empty15775.12))
      (set! error1.5 (call L.fun/error15777.8))
      (set! ascii-char2.4 (call L.fun/ascii-char15779.11))
      (set! ascii-char3.3 (call L.fun/ascii-char15781.10))
      (set! empty4.2 (call L.fun/empty15783.13))
      (set! void5.1 (call L.fun/void15785.4))
      void5.1)))
(check-by-interp
 '(module
    (define L.void?.16
      (lambda (tmp.46)
        (if (begin (set! tmp.56 (bitwise-and tmp.46 255)) (= tmp.56 30))
          14
          6)))
    (define L.boolean?.15
      (lambda (tmp.44)
        (if (begin (set! tmp.57 (bitwise-and tmp.44 247)) (= tmp.57 6)) 14 6)))
    (define L.fun/any18974.4 (lambda () 30))
    (define L.fun/void18977.5 (lambda () (call L.fun/void18978.12)))
    (define L.fun/ascii-char18970.6 (lambda () 23854))
    (define L.fun/ascii-char18969.7 (lambda () (call L.fun/ascii-char18970.6)))
    (define L.fun/error18976.8 (lambda () 39742))
    (define L.fun/void18971.9 (lambda () (call L.fun/void18972.10)))
    (define L.fun/void18972.10 (lambda () 30))
    (define L.fun/error18975.11 (lambda () (call L.fun/error18976.8)))
    (define L.fun/void18978.12 (lambda () 30))
    (define L.fun/any18973.13 (lambda () 60990))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char18969.7))
      (set! void1.5 (call L.fun/void18971.9))
      (set! boolean2.4
        (begin
          (set! tmp.58 (call L.fun/any18973.13))
          (call L.boolean?.15 tmp.58)))
      (set! boolean3.3
        (begin (set! tmp.59 (call L.fun/any18974.4)) (call L.void?.16 tmp.59)))
      (set! error4.2 (call L.fun/error18975.11))
      (set! void5.1 (call L.fun/void18977.5))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.cons.17
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.57 (alloc 16)) (+ tmp.57 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/error19375.4 (lambda () 5438))
    (define L.fun/empty19379.5 (lambda () 22))
    (define L.fun/error19373.6 (lambda () 1086))
    (define L.fun/pair19383.7 (lambda () (call L.cons.17 1696 3048)))
    (define L.fun/ascii-char19377.8 (lambda () 28718))
    (define L.fun/pair19382.9 (lambda () (call L.fun/pair19383.7)))
    (define L.fun/ascii-char19376.10
      (lambda () (call L.fun/ascii-char19377.8)))
    (define L.fun/empty19378.11 (lambda () (call L.fun/empty19379.5)))
    (define L.fun/empty19381.12 (lambda () 22))
    (define L.fun/empty19380.13 (lambda () (call L.fun/empty19381.12)))
    (define L.fun/error19372.14 (lambda () (call L.fun/error19373.6)))
    (define L.fun/error19374.15 (lambda () (call L.fun/error19375.4)))
    (begin
      (set! error0.6 (call L.fun/error19372.14))
      (set! error1.5 (call L.fun/error19374.15))
      (set! ascii-char2.4 (call L.fun/ascii-char19376.10))
      (set! empty3.3 (call L.fun/empty19378.11))
      (set! empty4.2 (call L.fun/empty19380.13))
      (set! pair5.1 (call L.fun/pair19382.9))
      pair5.1)))
(check-by-interp
 '(module
    (define L.boolean?.15
      (lambda (tmp.44)
        (if (begin (set! tmp.56 (bitwise-and tmp.44 247)) (= tmp.56 6)) 14 6)))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.57
                (if (begin (set! tmp.58 (bitwise-and tmp.25 7)) (= tmp.58 0))
                  14
                  6))
              (!= tmp.57 6))
          (if (begin
                (set! tmp.59
                  (if (begin (set! tmp.60 (bitwise-and tmp.24 7)) (= tmp.60 0))
                    14
                    6))
                (!= tmp.59 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.21 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (begin
              (set! tmp.65 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.65))
            318)
          318)))
    (define L.+.12
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.66
                (if (begin (set! tmp.67 (bitwise-and tmp.23 7)) (= tmp.67 0))
                  14
                  6))
              (!= tmp.66 6))
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.22 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.fun/void20855.4 (lambda () 30))
    (define L.fun/ascii-char20850.5 (lambda () (call L.fun/ascii-char20851.8)))
    (define L.fun/void20854.6 (lambda () (call L.fun/void20855.4)))
    (define L.fun/any20856.7 (lambda () 14))
    (define L.fun/ascii-char20851.8 (lambda () 29742))
    (define L.fun/ascii-char20853.9 (lambda () 24366))
    (define L.fun/ascii-char20852.10
      (lambda () (call L.fun/ascii-char20853.9)))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char20850.5))
      (set! fixnum1.5
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71
                (begin
                  (set! tmp.72 (call L.+.12 1200 456))
                  (begin
                    (set! tmp.73 (call L.+.12 336 616))
                    (call L.+.12 tmp.72 tmp.73))))
              (begin
                (set! tmp.74
                  (begin
                    (set! tmp.75 (call L.*.13 352 480))
                    (begin
                      (set! tmp.76 (call L.-.14 456 1240))
                      (call L.-.14 tmp.75 tmp.76))))
                (call L.-.14 tmp.71 tmp.74))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79 (call L.+.12 1264 640))
                    (begin
                      (set! tmp.80 (call L.-.14 504 400))
                      (call L.*.13 tmp.79 tmp.80))))
                (begin
                  (set! tmp.81
                    (begin
                      (set! tmp.82 (call L.+.12 1024 664))
                      (begin
                        (set! tmp.83 (call L.-.14 112 936))
                        (call L.-.14 tmp.82 tmp.83))))
                  (call L.-.14 tmp.78 tmp.81))))
            (call L.+.12 tmp.70 tmp.77))))
      (set! ascii-char2.4 (call L.fun/ascii-char20852.10))
      (set! fixnum3.3
        (begin
          (set! tmp.84
            (begin
              (set! tmp.85
                (begin
                  (set! tmp.86 (call L.*.13 376 672))
                  (begin
                    (set! tmp.87 (call L.*.13 1128 352))
                    (call L.-.14 tmp.86 tmp.87))))
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.89 (call L.-.14 1360 1896))
                    (begin
                      (set! tmp.90 (call L.+.12 1848 1680))
                      (call L.+.12 tmp.89 tmp.90))))
                (call L.+.12 tmp.85 tmp.88))))
          (begin
            (set! tmp.91
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.93 (call L.+.12 248 440))
                    (begin
                      (set! tmp.94 (call L.-.14 960 1952))
                      (call L.-.14 tmp.93 tmp.94))))
                (begin
                  (set! tmp.95
                    (begin
                      (set! tmp.96 (call L.+.12 504 248))
                      (begin
                        (set! tmp.97 (call L.-.14 696 1768))
                        (call L.+.12 tmp.96 tmp.97))))
                  (call L.*.13 tmp.92 tmp.95))))
            (call L.-.14 tmp.84 tmp.91))))
      (set! void4.2 (call L.fun/void20854.6))
      (set! fixnum5.1
        (begin
          (set! tmp.98
            (begin
              (set! tmp.99
                (begin
                  (set! tmp.100 (call L.-.14 424 1552))
                  (begin
                    (set! tmp.101 (call L.-.14 1264 144))
                    (call L.-.14 tmp.100 tmp.101))))
              (begin
                (set! tmp.102
                  (begin
                    (set! tmp.103 (call L.-.14 640 1256))
                    (begin
                      (set! tmp.104 (call L.+.12 712 1904))
                      (call L.*.13 tmp.103 tmp.104))))
                (call L.-.14 tmp.99 tmp.102))))
          (begin
            (set! tmp.105
              (begin
                (set! tmp.106
                  (begin
                    (set! tmp.107 (call L.+.12 1080 1304))
                    (begin
                      (set! tmp.108 (call L.*.13 1000 1928))
                      (call L.+.12 tmp.107 tmp.108))))
                (begin
                  (set! tmp.109
                    (begin
                      (set! tmp.110 (call L.*.13 1720 416))
                      (begin
                        (set! tmp.111 (call L.-.14 1344 1112))
                        (call L.-.14 tmp.110 tmp.111))))
                  (call L.+.12 tmp.106 tmp.109))))
            (call L.*.13 tmp.98 tmp.105))))
      (begin
        (set! tmp.112 (call L.fun/any20856.7))
        (call L.boolean?.15 tmp.112)))))
(check-by-interp
 '(module
    (define L.-.18
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.57
                (if (begin (set! tmp.58 (bitwise-and tmp.25 7)) (= tmp.58 0))
                  14
                  6))
              (!= tmp.57 6))
          (if (begin
                (set! tmp.59
                  (if (begin (set! tmp.60 (bitwise-and tmp.24 7)) (= tmp.60 0))
                    14
                    6))
                (!= tmp.59 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.21 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (begin
              (set! tmp.65 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.65))
            318)
          318)))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.66
                (if (begin (set! tmp.67 (bitwise-and tmp.23 7)) (= tmp.67 0))
                  14
                  6))
              (!= tmp.66 6))
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.22 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.cons.15
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.70 (alloc 16)) (+ tmp.70 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/ascii-char22195.4 (lambda () 31278))
    (define L.fun/empty22197.5 (lambda () 22))
    (define L.fun/pair22193.6 (lambda () (call L.cons.15 640 2320)))
    (define L.fun/pair22192.7 (lambda () (call L.fun/pair22193.6)))
    (define L.fun/empty22199.8 (lambda () 22))
    (define L.fun/empty22198.9 (lambda () (call L.fun/empty22199.8)))
    (define L.fun/empty22196.10 (lambda () (call L.fun/empty22197.5)))
    (define L.fun/error22191.11 (lambda () 19262))
    (define L.fun/error22190.12 (lambda () (call L.fun/error22191.11)))
    (define L.fun/ascii-char22194.13
      (lambda () (call L.fun/ascii-char22195.4)))
    (begin
      (set! error0.6 (call L.fun/error22190.12))
      (set! pair1.5 (call L.fun/pair22192.7))
      (set! ascii-char2.4 (call L.fun/ascii-char22194.13))
      (set! empty3.3 (call L.fun/empty22196.10))
      (set! empty4.2 (call L.fun/empty22198.9))
      (set! fixnum5.1
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.+.16 1072 1408))
                  (begin
                    (set! tmp.74 (call L.*.17 1232 784))
                    (call L.-.18 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.*.17 1496 1688))
                    (begin
                      (set! tmp.77 (call L.+.16 832 824))
                      (call L.-.18 tmp.76 tmp.77))))
                (call L.*.17 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.*.17 392 880))
                    (begin
                      (set! tmp.81 (call L.*.17 312 192))
                      (call L.+.16 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.*.17 1728 576))
                      (begin
                        (set! tmp.84 (call L.-.18 160 848))
                        (call L.*.17 tmp.83 tmp.84))))
                  (call L.-.18 tmp.79 tmp.82))))
            (call L.+.16 tmp.71 tmp.78))))
      error0.6)))
(check-by-interp
 '(module
    (define L.*.20
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.57
                (if (begin (set! tmp.58 (bitwise-and tmp.21 7)) (= tmp.58 0))
                  14
                  6))
              (!= tmp.57 6))
          (if (begin
                (set! tmp.59
                  (if (begin (set! tmp.60 (bitwise-and tmp.20 7)) (= tmp.60 0))
                    14
                    6))
                (!= tmp.59 6))
            (begin
              (set! tmp.61 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.61))
            318)
          318)))
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.62
                (if (begin (set! tmp.63 (bitwise-and tmp.23 7)) (= tmp.63 0))
                  14
                  6))
              (!= tmp.62 6))
          (if (begin
                (set! tmp.64
                  (if (begin (set! tmp.65 (bitwise-and tmp.22 7)) (= tmp.65 0))
                    14
                    6))
                (!= tmp.64 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.18
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.66
                (if (begin (set! tmp.67 (bitwise-and tmp.25 7)) (= tmp.67 0))
                  14
                  6))
              (!= tmp.66 6))
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.24 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.vector?.17
      (lambda (tmp.50)
        (if (begin (set! tmp.70 (bitwise-and tmp.50 7)) (= tmp.70 3)) 14 6)))
    (define L.cons.16
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.71 (alloc 16)) (+ tmp.71 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/pair23550.4 (lambda () (call L.fun/pair23551.8)))
    (define L.fun/void23549.5 (lambda () 30))
    (define L.fun/void23541.6 (lambda () (call L.fun/void23542.14)))
    (define L.fun/void23548.7 (lambda () (call L.fun/void23549.5)))
    (define L.fun/pair23551.8 (lambda () (call L.cons.16 664 3872)))
    (define L.fun/error23546.9 (lambda () (call L.fun/error23547.11)))
    (define L.fun/empty23544.10 (lambda () 22))
    (define L.fun/error23547.11 (lambda () 53822))
    (define L.fun/any23545.12 (lambda () 6))
    (define L.fun/empty23543.13 (lambda () (call L.fun/empty23544.10)))
    (define L.fun/void23542.14 (lambda () 30))
    (begin
      (set! void0.6 (call L.fun/void23541.6))
      (set! empty1.5 (call L.fun/empty23543.13))
      (set! boolean2.4
        (begin
          (set! tmp.72 (call L.fun/any23545.12))
          (call L.vector?.17 tmp.72)))
      (set! fixnum3.3
        (begin
          (set! tmp.73
            (begin
              (set! tmp.74
                (begin
                  (set! tmp.75 (call L.-.18 1448 368))
                  (begin
                    (set! tmp.76 (call L.-.18 672 1528))
                    (call L.+.19 tmp.75 tmp.76))))
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.19 1808 464))
                    (begin
                      (set! tmp.79 (call L.-.18 104 520))
                      (call L.*.20 tmp.78 tmp.79))))
                (call L.-.18 tmp.74 tmp.77))))
          (begin
            (set! tmp.80
              (begin
                (set! tmp.81
                  (begin
                    (set! tmp.82 (call L.*.20 1264 104))
                    (begin
                      (set! tmp.83 (call L.-.18 448 448))
                      (call L.+.19 tmp.82 tmp.83))))
                (begin
                  (set! tmp.84
                    (begin
                      (set! tmp.85 (call L.+.19 1664 320))
                      (begin
                        (set! tmp.86 (call L.*.20 1296 112))
                        (call L.+.19 tmp.85 tmp.86))))
                  (call L.*.20 tmp.81 tmp.84))))
            (call L.+.19 tmp.73 tmp.80))))
      (set! error4.2 (call L.fun/error23546.9))
      (set! void5.1 (call L.fun/void23548.7))
      (call L.fun/pair23550.4))))
(check-by-interp
 '(module
    (define L.fun/error24539.4 (lambda () 15934))
    (define L.fun/ascii-char24535.5 (lambda () 18734))
    (define L.fun/ascii-char24529.6 (lambda () 24622))
    (define L.fun/empty24537.7 (lambda () 22))
    (define L.fun/ascii-char24534.8 (lambda () (call L.fun/ascii-char24535.5)))
    (define L.fun/error24531.9 (lambda () 2622))
    (define L.fun/error24538.10 (lambda () (call L.fun/error24539.4)))
    (define L.fun/empty24536.11 (lambda () (call L.fun/empty24537.7)))
    (define L.fun/void24532.12 (lambda () (call L.fun/void24533.14)))
    (define L.fun/error24530.13 (lambda () (call L.fun/error24531.9)))
    (define L.fun/void24533.14 (lambda () 30))
    (define L.fun/ascii-char24528.15
      (lambda () (call L.fun/ascii-char24529.6)))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char24528.15))
      (set! error1.5 (call L.fun/error24530.13))
      (set! void2.4 (call L.fun/void24532.12))
      (set! ascii-char3.3 (call L.fun/ascii-char24534.8))
      (set! empty4.2 (call L.fun/empty24536.11))
      (set! error5.1 (call L.fun/error24538.10))
      empty4.2)))
(check-by-interp
 '(module
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.25 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.24 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.21 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.20 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (begin
              (set! tmp.64 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.64))
            318)
          318)))
    (define L.+.13
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.23 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.22 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.fun/empty24788.4 (lambda () 22))
    (define L.fun/error24789.5 (lambda () (call L.fun/error24790.10)))
    (define L.fun/error24786.6 (lambda () 34622))
    (define L.fun/error24785.7 (lambda () (call L.fun/error24786.6)))
    (define L.fun/empty24792.8 (lambda () 22))
    (define L.fun/empty24787.9 (lambda () (call L.fun/empty24788.4)))
    (define L.fun/error24790.10 (lambda () 11070))
    (define L.fun/empty24791.11 (lambda () (call L.fun/empty24792.8)))
    (begin
      (set! error0.6 (call L.fun/error24785.7))
      (set! fixnum1.5
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.13 1392 1112))
                  (begin
                    (set! tmp.72 (call L.*.14 1104 1584))
                    (call L.+.13 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.14 88 1024))
                    (begin
                      (set! tmp.75 (call L.+.13 680 32))
                      (call L.-.15 tmp.74 tmp.75))))
                (call L.-.15 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.15 1648 1672))
                    (begin
                      (set! tmp.79 (call L.*.14 2016 1616))
                      (call L.+.13 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.15 1040 1512))
                      (begin
                        (set! tmp.82 (call L.+.13 2024 1256))
                        (call L.*.14 tmp.81 tmp.82))))
                  (call L.+.13 tmp.77 tmp.80))))
            (call L.-.15 tmp.69 tmp.76))))
      (set! empty2.4 (call L.fun/empty24787.9))
      (set! error3.3 (call L.fun/error24789.5))
      (set! fixnum4.2
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.14 640 608))
                  (begin
                    (set! tmp.86 (call L.*.14 88 1840))
                    (call L.-.15 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.+.13 1992 2008))
                    (begin
                      (set! tmp.89 (call L.*.14 632 1960))
                      (call L.+.13 tmp.88 tmp.89))))
                (call L.-.15 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.*.14 744 1392))
                    (begin
                      (set! tmp.93 (call L.*.14 808 440))
                      (call L.+.13 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.-.15 1368 920))
                      (begin
                        (set! tmp.96 (call L.-.15 912 920))
                        (call L.*.14 tmp.95 tmp.96))))
                  (call L.*.14 tmp.91 tmp.94))))
            (call L.*.14 tmp.83 tmp.90))))
      (set! empty5.1 (call L.fun/empty24791.11))
      (begin
        (set! tmp.97
          (begin
            (set! tmp.98
              (begin
                (set! tmp.99 (call L.-.15 56 fixnum4.2))
                (call L.-.15 tmp.99 fixnum4.2)))
            (begin
              (set! tmp.100
                (begin
                  (set! tmp.101 (call L.*.14 144 fixnum1.5))
                  (call L.*.14 fixnum1.5 tmp.101)))
              (call L.+.13 tmp.98 tmp.100))))
        (begin
          (set! tmp.102 (call L.-.15 fixnum4.2 fixnum1.5))
          (call L.+.13 tmp.97 tmp.102))))))
(check-by-interp
 '(module
    (define L.error?.19
      (lambda (tmp.48)
        (if (begin (set! tmp.57 (bitwise-and tmp.48 255)) (= tmp.57 62))
          14
          6)))
    (define L.cons.18
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.58 (alloc 16)) (+ tmp.58 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/pair24832.4 (lambda () (call L.fun/pair24833.15)))
    (define L.fun/error24829.5 (lambda () 2110))
    (define L.fun/pair24835.6 (lambda () (call L.fun/pair24836.7)))
    (define L.fun/pair24836.7 (lambda () (call L.cons.18 1040 4056)))
    (define L.fun/any24834.8 (lambda () 40766))
    (define L.fun/ascii-char24839.9
      (lambda () (call L.fun/ascii-char24840.12)))
    (define L.fun/void24831.10 (lambda () 30))
    (define L.fun/void24830.11 (lambda () (call L.fun/void24831.10)))
    (define L.fun/ascii-char24840.12 (lambda () 26414))
    (define L.fun/empty24838.13 (lambda () 22))
    (define L.fun/empty24837.14 (lambda () (call L.fun/empty24838.13)))
    (define L.fun/pair24833.15 (lambda () (call L.cons.18 1856 3544)))
    (define L.fun/error24828.16 (lambda () (call L.fun/error24829.5)))
    (begin
      (set! error0.6 (call L.fun/error24828.16))
      (set! void1.5 (call L.fun/void24830.11))
      (set! pair2.4 (call L.fun/pair24832.4))
      (set! boolean3.3
        (begin
          (set! tmp.59 (call L.fun/any24834.8))
          (call L.error?.19 tmp.59)))
      (set! pair4.2 (call L.fun/pair24835.6))
      (set! empty5.1 (call L.fun/empty24837.14))
      (call L.fun/ascii-char24839.9))))
(check-by-interp
 '(module
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.57
                (if (begin (set! tmp.58 (bitwise-and tmp.23 7)) (= tmp.58 0))
                  14
                  6))
              (!= tmp.57 6))
          (if (begin
                (set! tmp.59
                  (if (begin (set! tmp.60 (bitwise-and tmp.22 7)) (= tmp.60 0))
                    14
                    6))
                (!= tmp.59 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.25 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.24 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.21 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.20 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (begin
              (set! tmp.69 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.69))
            318)
          318)))
    (define L.cons.13
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.70 (alloc 16)) (+ tmp.70 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/empty27006.4 (lambda () (call L.fun/empty27007.9)))
    (define L.fun/pair27009.5 (lambda () (call L.cons.13 1768 2952)))
    (define L.fun/void27004.6 (lambda () (call L.fun/void27005.11)))
    (define L.fun/ascii-char27003.7 (lambda () 29998))
    (define L.fun/pair27008.8 (lambda () (call L.fun/pair27009.5)))
    (define L.fun/empty27007.9 (lambda () 22))
    (define L.fun/ascii-char27002.10
      (lambda () (call L.fun/ascii-char27003.7)))
    (define L.fun/void27005.11 (lambda () 30))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.*.14 264 1480))
                  (begin
                    (set! tmp.74 (call L.-.15 1256 408))
                    (call L.-.15 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.-.15 384 1408))
                    (begin
                      (set! tmp.77 (call L.-.15 2016 1384))
                      (call L.+.16 tmp.76 tmp.77))))
                (call L.+.16 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.-.15 168 1384))
                    (begin
                      (set! tmp.81 (call L.*.14 872 808))
                      (call L.*.14 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.+.16 560 608))
                      (begin
                        (set! tmp.84 (call L.-.15 520 872))
                        (call L.-.15 tmp.83 tmp.84))))
                  (call L.-.15 tmp.79 tmp.82))))
            (call L.-.15 tmp.71 tmp.78))))
      (set! fixnum1.5
        (begin
          (set! tmp.85
            (begin
              (set! tmp.86
                (begin
                  (set! tmp.87 (call L.+.16 776 488))
                  (begin
                    (set! tmp.88 (call L.*.14 704 1368))
                    (call L.+.16 tmp.87 tmp.88))))
              (begin
                (set! tmp.89
                  (begin
                    (set! tmp.90 (call L.-.15 1880 1592))
                    (begin
                      (set! tmp.91 (call L.*.14 1080 1824))
                      (call L.+.16 tmp.90 tmp.91))))
                (call L.*.14 tmp.86 tmp.89))))
          (begin
            (set! tmp.92
              (begin
                (set! tmp.93
                  (begin
                    (set! tmp.94 (call L.-.15 1312 1800))
                    (begin
                      (set! tmp.95 (call L.*.14 792 1856))
                      (call L.-.15 tmp.94 tmp.95))))
                (begin
                  (set! tmp.96
                    (begin
                      (set! tmp.97 (call L.*.14 608 408))
                      (begin
                        (set! tmp.98 (call L.-.15 16 904))
                        (call L.-.15 tmp.97 tmp.98))))
                  (call L.-.15 tmp.93 tmp.96))))
            (call L.*.14 tmp.85 tmp.92))))
      (set! ascii-char2.4 (call L.fun/ascii-char27002.10))
      (set! void3.3 (call L.fun/void27004.6))
      (set! empty4.2 (call L.fun/empty27006.4))
      (set! fixnum5.1
        (begin
          (set! tmp.99
            (begin
              (set! tmp.100
                (begin
                  (set! tmp.101 (call L.*.14 704 48))
                  (begin
                    (set! tmp.102 (call L.-.15 1448 1168))
                    (call L.*.14 tmp.101 tmp.102))))
              (begin
                (set! tmp.103
                  (begin
                    (set! tmp.104 (call L.-.15 1016 784))
                    (begin
                      (set! tmp.105 (call L.*.14 240 2016))
                      (call L.-.15 tmp.104 tmp.105))))
                (call L.*.14 tmp.100 tmp.103))))
          (begin
            (set! tmp.106
              (begin
                (set! tmp.107
                  (begin
                    (set! tmp.108 (call L.-.15 496 1968))
                    (begin
                      (set! tmp.109 (call L.+.16 1672 1688))
                      (call L.-.15 tmp.108 tmp.109))))
                (begin
                  (set! tmp.110
                    (begin
                      (set! tmp.111 (call L.*.14 880 992))
                      (begin
                        (set! tmp.112 (call L.-.15 1176 1000))
                        (call L.-.15 tmp.111 tmp.112))))
                  (call L.*.14 tmp.107 tmp.110))))
            (call L.+.16 tmp.99 tmp.106))))
      (call L.fun/pair27008.8))))
(check-by-interp
 '(module
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.21 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.20 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (begin
              (set! tmp.60 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.60))
            318)
          318)))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.61
                (if (begin (set! tmp.62 (bitwise-and tmp.23 7)) (= tmp.62 0))
                  14
                  6))
              (!= tmp.61 6))
          (if (begin
                (set! tmp.63
                  (if (begin (set! tmp.64 (bitwise-and tmp.22 7)) (= tmp.64 0))
                    14
                    6))
                (!= tmp.63 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.25 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.24 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.fun/ascii-char27114.4 (lambda () (call L.fun/ascii-char27115.8)))
    (define L.fun/empty27120.5 (lambda () (call L.fun/empty27121.11)))
    (define L.fun/error27116.6 (lambda () (call L.fun/error27117.7)))
    (define L.fun/error27117.7 (lambda () 34622))
    (define L.fun/ascii-char27115.8 (lambda () 23342))
    (define L.fun/ascii-char27123.9 (lambda () 27694))
    (define L.fun/ascii-char27122.10
      (lambda () (call L.fun/ascii-char27123.9)))
    (define L.fun/empty27121.11 (lambda () 22))
    (define L.fun/empty27118.12 (lambda () (call L.fun/empty27119.13)))
    (define L.fun/empty27119.13 (lambda () 22))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char27114.4))
      (set! error1.5 (call L.fun/error27116.6))
      (set! empty2.4 (call L.fun/empty27118.12))
      (set! empty3.3 (call L.fun/empty27120.5))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.15 608 584))
                  (begin
                    (set! tmp.72 (call L.-.15 1776 1304))
                    (call L.-.15 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.16 1456 1824))
                    (begin
                      (set! tmp.75 (call L.+.16 1832 312))
                      (call L.+.16 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.15 1536 8))
                    (begin
                      (set! tmp.79 (call L.-.15 648 912))
                      (call L.*.17 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.16 688 1304))
                      (begin
                        (set! tmp.82 (call L.-.15 1544 1096))
                        (call L.+.16 tmp.81 tmp.82))))
                  (call L.*.17 tmp.77 tmp.80))))
            (call L.+.16 tmp.69 tmp.76))))
      (set! ascii-char5.1 (call L.fun/ascii-char27122.10))
      (begin
        (set! tmp.83
          (begin
            (set! tmp.84
              (begin
                (set! tmp.85 (call L.*.17 fixnum4.2 1928))
                (call L.-.15 fixnum4.2 tmp.85)))
            (begin
              (set! tmp.86
                (begin
                  (set! tmp.87 (call L.+.16 184 fixnum4.2))
                  (call L.+.16 fixnum4.2 tmp.87)))
              (call L.*.17 tmp.84 tmp.86))))
        (begin
          (set! tmp.88
            (begin
              (set! tmp.89
                (begin
                  (set! tmp.90 (call L.-.15 920 912))
                  (call L.+.16 tmp.90 fixnum4.2)))
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.-.15 792 1752))
                    (call L.-.15 tmp.92 fixnum4.2)))
                (call L.-.15 tmp.89 tmp.91))))
          (call L.-.15 tmp.83 tmp.88))))))
(check-by-interp
 '(module
    (define L.pair?.19
      (lambda (tmp.49)
        (if (begin (set! tmp.57 (bitwise-and tmp.49 7)) (= tmp.57 1)) 14 6)))
    (define L.cons.18
      (lambda (tmp.52 tmp.53)
        (begin
          (set! tmp.56 (begin (set! tmp.58 (alloc 16)) (+ tmp.58 1)))
          (begin (mset! tmp.56 -1 tmp.52) (mset! tmp.56 7 tmp.53) tmp.56))))
    (define L.fun/pair27447.4 (lambda () (call L.fun/pair27448.11)))
    (define L.fun/ascii-char27445.5
      (lambda () (call L.fun/ascii-char27446.13)))
    (define L.fun/ascii-char27438.6 (lambda () 18222))
    (define L.fun/error27440.7 (lambda () 33342))
    (define L.fun/ascii-char27443.8
      (lambda () (call L.fun/ascii-char27444.14)))
    (define L.fun/void27441.9 (lambda () (call L.fun/void27442.12)))
    (define L.fun/error27439.10 (lambda () (call L.fun/error27440.7)))
    (define L.fun/pair27448.11 (lambda () (call L.cons.18 1488 3512)))
    (define L.fun/void27442.12 (lambda () 30))
    (define L.fun/ascii-char27446.13 (lambda () 29230))
    (define L.fun/ascii-char27444.14 (lambda () 25134))
    (define L.fun/ascii-char27437.15
      (lambda () (call L.fun/ascii-char27438.6)))
    (define L.fun/any27436.16 (lambda () (call L.cons.18 1488 3104)))
    (begin
      (set! boolean0.6
        (begin
          (set! tmp.59 (call L.fun/any27436.16))
          (call L.pair?.19 tmp.59)))
      (set! ascii-char1.5 (call L.fun/ascii-char27437.15))
      (set! error2.4 (call L.fun/error27439.10))
      (set! void3.3 (call L.fun/void27441.9))
      (set! ascii-char4.2 (call L.fun/ascii-char27443.8))
      (set! ascii-char5.1 (call L.fun/ascii-char27445.5))
      (call L.fun/pair27447.4))))
