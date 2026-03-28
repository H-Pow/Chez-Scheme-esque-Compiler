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

(check-by-interp '(module 840))
(check-by-interp '(module 26942))
(check-by-interp '(module (if (!= 14 6) 17214 9790)))
(check-by-interp '(module (begin (set! error0.1 28478) 1128)))
(check-by-interp
 '(module (define L.fun/empty8385.4 (lambda () 22)) (call L.fun/empty8385.4)))
(check-by-interp '(module (if (!= 14 6) 25390 25390)))
(check-by-interp '(module (if (!= 14 6) 50238 14398)))
(check-by-interp
 '(module
    (define L.-.6
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.51
                (if (begin (set! tmp.52 (bitwise-and tmp.20 7)) (= tmp.52 0))
                  14
                  6))
              (!= tmp.51 6))
          (if (begin
                (set! tmp.53
                  (if (begin (set! tmp.54 (bitwise-and tmp.19 7)) (= tmp.54 0))
                    14
                    6))
                (!= tmp.53 6))
            (- tmp.19 tmp.20)
            830)
          830)))
    (define L.fun/fixnum8420.4 (lambda (oprand0.1) 400))
    (begin
      (set! tmp.55 (call L.fun/fixnum8420.4 25390))
      (begin (set! tmp.56 (call L.-.6 168 2024)) (call L.-.6 tmp.55 tmp.56)))))
(check-by-interp '(module (if (!= 14 6) 61502 13118)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8428.4 (lambda (oprand0.1) 25390))
    (define L.fun/empty8427.5 (lambda (oprand0.2) 22))
    (begin
      (set! tmp.52 (call L.fun/ascii-char8428.4 22))
      (call L.fun/empty8427.5 tmp.52))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8442.4 (lambda (oprand0.2 oprand1.1) 25390))
    (if (if (!= 14 6) (!= 14 6) (!= 14 6))
      (call L.fun/ascii-char8442.4 25390 22)
      (begin
        (set! fixnum0.5 832)
        (set! fixnum1.4 608)
        (set! void2.3 30)
        25390))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.17 tmp.18)
        (if (begin
              (set! tmp.53
                (if (begin (set! tmp.54 (bitwise-and tmp.18 7)) (= tmp.54 0))
                  14
                  6))
              (!= tmp.53 6))
          (if (begin
                (set! tmp.55
                  (if (begin (set! tmp.56 (bitwise-and tmp.17 7)) (= tmp.56 0))
                    14
                    6))
                (!= tmp.55 6))
            (begin
              (set! tmp.57 (arithmetic-shift-right tmp.18 3))
              (* tmp.17 tmp.57))
            318)
          318)))
    (define L.fun/ascii-char8498.4 (lambda () 25390))
    (define L.fun/void8499.5 (lambda () 30))
    (define L.fun/empty8500.6 (lambda () 22))
    (begin
      (set! fixnum0.3 (call L.*.8 1856 272))
      (set! ascii-char1.2 (call L.fun/ascii-char8498.4))
      (set! void2.1 (call L.fun/void8499.5))
      (call L.fun/empty8500.6))))
(check-by-interp
 '(module
    (define L.-.7
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.53
                (if (begin (set! tmp.54 (bitwise-and tmp.22 7)) (= tmp.54 0))
                  14
                  6))
              (!= tmp.53 6))
          (if (begin
                (set! tmp.55
                  (if (begin (set! tmp.56 (bitwise-and tmp.21 7)) (= tmp.56 0))
                    14
                    6))
                (!= tmp.55 6))
            (- tmp.21 tmp.22)
            830)
          830)))
    (define L.fun/empty8553.4 (lambda () 22))
    (define L.fun/error8554.5 (lambda () 43326))
    (begin
      (set! empty0.3 (call L.fun/empty8553.4))
      (set! error1.2 (call L.fun/error8554.5))
      (set! fixnum2.1 (call L.-.7 1768 144))
      error1.2)))
(check-by-interp
 '(module
    (define L.fun/boolean8597.4 (lambda (oprand0.2 oprand1.1) 6))
    (define L.fun/ascii-char8598.5 (lambda (oprand0.4 oprand1.3) 25390))
    (if (begin (set! tmp.54 (call L.fun/boolean8597.4 22 25390)) (!= tmp.54 6))
      (if (!= 6 6) 25390 25390)
      (call L.fun/ascii-char8598.5 624 22))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.32 tmp.33)
        (if (begin
              (set! tmp.66
                (if (begin (set! tmp.67 (bitwise-and tmp.33 7)) (= tmp.67 0))
                  14
                  6))
              (!= tmp.66 6))
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.32 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (+ tmp.32 tmp.33)
            574)
          574)))
    (define L.fun/fixnum9203.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 1368))
    (define L.fun/fixnum9202.5 (lambda (oprand0.6 oprand1.5 oprand2.4) 568))
    (define L.fun/fixnum9204.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand2.7))
    (define L.fun/boolean9201.7 (lambda (oprand0.12 oprand1.11 oprand2.10) 14))
    (begin
      (set! tmp.70
        (if (begin
              (set! tmp.71 (call L.fun/boolean9201.7 2878 25390 22))
              (!= tmp.71 6))
          (call L.fun/fixnum9202.5 30 22 30)
          (call L.fun/fixnum9203.4 22 6 6)))
      (begin
        (set! tmp.72
          (if (if (!= 14 6) (!= 6 6) (!= 6 6))
            (begin
              (set! boolean0.16 6)
              (set! error1.15 59198)
              (set! fixnum2.14 216)
              (set! void3.13 30)
              fixnum2.14)
            (call L.fun/fixnum9204.6 30 25390 1776)))
        (call L.+.9 tmp.70 tmp.72)))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.54
                (if (begin (set! tmp.55 (bitwise-and tmp.23 7)) (= tmp.55 0))
                  14
                  6))
              (!= tmp.54 6))
          (if (begin
                (set! tmp.56
                  (if (begin (set! tmp.57 (bitwise-and tmp.22 7)) (= tmp.57 0))
                    14
                    6))
                (!= tmp.56 6))
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.+.10
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.58
                (if (begin (set! tmp.59 (bitwise-and tmp.21 7)) (= tmp.59 0))
                  14
                  6))
              (!= tmp.58 6))
          (if (begin
                (set! tmp.60
                  (if (begin (set! tmp.61 (bitwise-and tmp.20 7)) (= tmp.61 0))
                    14
                    6))
                (!= tmp.60 6))
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (begin
              (set! tmp.62
                (if (begin (set! tmp.63 (bitwise-and tmp.19 7)) (= tmp.63 0))
                  14
                  6))
              (!= tmp.62 6))
          (if (begin
                (set! tmp.64
                  (if (begin (set! tmp.65 (bitwise-and tmp.18 7)) (= tmp.65 0))
                    14
                    6))
                (!= tmp.64 6))
            (begin
              (set! tmp.66 (arithmetic-shift-right tmp.19 3))
              (* tmp.18 tmp.66))
            318)
          318)))
    (define L.fun/ascii-char9328.4 (lambda () 25390))
    (define L.fun/void9330.5 (lambda () 30))
    (define L.fun/error9331.6 (lambda () 27198))
    (define L.fun/ascii-char9329.7 (lambda () 25390))
    (begin
      (set! fixnum0.4
        (begin
          (set! tmp.67 (call L.*.9 440 1800))
          (begin
            (set! tmp.68 (call L.+.10 416 224))
            (call L.-.11 tmp.67 tmp.68))))
      (set! ascii-char1.3 (call L.fun/ascii-char9328.4))
      (set! ascii-char2.2 (call L.fun/ascii-char9329.7))
      (set! void3.1 (call L.fun/void9330.5))
      (call L.fun/error9331.6))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.18 tmp.19)
        (if (begin
              (set! tmp.54
                (if (begin (set! tmp.55 (bitwise-and tmp.19 7)) (= tmp.55 0))
                  14
                  6))
              (!= tmp.54 6))
          (if (begin
                (set! tmp.56
                  (if (begin (set! tmp.57 (bitwise-and tmp.18 7)) (= tmp.57 0))
                    14
                    6))
                (!= tmp.56 6))
            (begin
              (set! tmp.58 (arithmetic-shift-right tmp.19 3))
              (* tmp.18 tmp.58))
            318)
          318)))
    (define L.-.7
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
    (define L.fun/ascii-char9350.4 (lambda () 25390))
    (define L.fun/error9349.5 (lambda () 34878))
    (begin
      (set! fixnum0.4
        (begin
          (set! tmp.63 (call L.-.7 1200 1608))
          (begin
            (set! tmp.64 (call L.-.7 760 936))
            (call L.-.7 tmp.63 tmp.64))))
      (set! fixnum1.3
        (begin
          (set! tmp.65 (call L.*.8 1024 856))
          (begin
            (set! tmp.66 (call L.*.8 712 776))
            (call L.-.7 tmp.65 tmp.66))))
      (set! error2.2 (call L.fun/error9349.5))
      (set! fixnum3.1
        (begin
          (set! tmp.67 (call L.-.7 1064 32))
          (begin
            (set! tmp.68 (call L.-.7 1088 1200))
            (call L.*.8 tmp.67 tmp.68))))
      (call L.fun/ascii-char9350.4))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.54
                (if (begin (set! tmp.55 (bitwise-and tmp.23 7)) (= tmp.55 0))
                  14
                  6))
              (!= tmp.54 6))
          (if (begin
                (set! tmp.56
                  (if (begin (set! tmp.57 (bitwise-and tmp.22 7)) (= tmp.57 0))
                    14
                    6))
                (!= tmp.56 6))
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (begin
              (set! tmp.58
                (if (begin (set! tmp.59 (bitwise-and tmp.19 7)) (= tmp.59 0))
                  14
                  6))
              (!= tmp.58 6))
          (if (begin
                (set! tmp.60
                  (if (begin (set! tmp.61 (bitwise-and tmp.18 7)) (= tmp.61 0))
                    14
                    6))
                (!= tmp.60 6))
            (begin
              (set! tmp.62 (arithmetic-shift-right tmp.19 3))
              (* tmp.18 tmp.62))
            318)
          318)))
    (define L.+.8
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.21 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.20 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.fun/empty9463.4 (lambda () 22))
    (define L.fun/empty9462.5 (lambda () 22))
    (define L.fun/void9461.6 (lambda () 30))
    (begin
      (set! void0.4 (call L.fun/void9461.6))
      (set! fixnum1.3
        (begin
          (set! tmp.67 (call L.+.8 1464 1440))
          (begin
            (set! tmp.68 (call L.*.9 1904 944))
            (call L.-.10 tmp.67 tmp.68))))
      (set! empty2.2 (call L.fun/empty9462.5))
      (set! empty3.1 (call L.fun/empty9463.4))
      void0.4)))
(check-by-interp
 '(module
    (define L.-.6
      (lambda (tmp.33 tmp.34)
        (if (begin
              (set! tmp.65
                (if (begin (set! tmp.66 (bitwise-and tmp.34 7)) (= tmp.66 0))
                  14
                  6))
              (!= tmp.65 6))
          (if (begin
                (set! tmp.67
                  (if (begin (set! tmp.68 (bitwise-and tmp.33 7)) (= tmp.68 0))
                    14
                    6))
                (!= tmp.67 6))
            (- tmp.33 tmp.34)
            830)
          830)))
    (define L.fun/ascii-char9530.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) 25390))
    (if (begin
          (set! fixnum0.7 1064)
          (set! empty1.6 22)
          (set! fixnum2.5 680)
          (set! error3.4 28222)
          (!= 6 6))
      (begin
        (set! tmp.69
          (begin
            (set! void0.11 30)
            (set! error1.10 40510)
            (set! void2.9 30)
            (set! boolean3.8 6)
            1440))
        (begin
          (set! tmp.70 (call L.-.6 1288 32))
          (begin
            (set! tmp.71 (if (!= 14 6) 30 30))
            (call L.fun/ascii-char9530.4 tmp.69 tmp.70 tmp.71))))
      (begin
        (set! ascii-char0.15 25390)
        (set! fixnum1.14 1560)
        (set! empty2.13 22)
        (set! void3.12 30)
        25390))))
(check-by-interp
 '(module
    (if (if (!= 14 6) (!= 6 6) (!= 14 6))
      (if (!= 6 6) 46654 42046)
      (if (!= 14 6) 33598 58174))))
(check-by-interp
 '(module
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (begin
              (set! tmp.54
                (if (begin (set! tmp.55 (bitwise-and tmp.19 7)) (= tmp.55 0))
                  14
                  6))
              (!= tmp.54 6))
          (if (begin
                (set! tmp.56
                  (if (begin (set! tmp.57 (bitwise-and tmp.18 7)) (= tmp.57 0))
                    14
                    6))
                (!= tmp.56 6))
            (begin
              (set! tmp.58 (arithmetic-shift-right tmp.19 3))
              (* tmp.18 tmp.58))
            318)
          318)))
    (define L.-.8
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
    (define L.fun/error9595.4 (lambda () 9022))
    (define L.fun/void9594.5 (lambda () 30))
    (define L.fun/empty9593.6 (lambda () 22))
    (begin
      (set! empty0.4 (call L.fun/empty9593.6))
      (set! void1.3 (call L.fun/void9594.5))
      (set! error2.2 (call L.fun/error9595.4))
      (set! fixnum3.1
        (begin
          (set! tmp.63 (call L.-.8 1368 1392))
          (begin
            (set! tmp.64 (call L.*.9 1288 400))
            (call L.*.9 tmp.63 tmp.64))))
      void1.3)))
(check-by-interp
 '(module
    (define L.void?.10
      (lambda (tmp.44)
        (if (begin (set! tmp.54 (bitwise-and tmp.44 255)) (= tmp.54 30))
          14
          6)))
    (define L.fun/error9648.4 (lambda () 2622))
    (define L.fun/error9646.5 (lambda () 58430))
    (define L.fun/any9647.6 (lambda () 6))
    (define L.fun/error9649.7 (lambda () 28222))
    (define L.fun/void9650.8 (lambda () 30))
    (begin
      (set! error0.4 (call L.fun/error9646.5))
      (set! boolean1.3
        (begin (set! tmp.55 (call L.fun/any9647.6)) (call L.void?.10 tmp.55)))
      (set! error2.2 (call L.fun/error9648.4))
      (set! error3.1 (call L.fun/error9649.7))
      (call L.fun/void9650.8))))
(check-by-interp
 '(module
    (define L.ascii-char?.10
      (lambda (tmp.46)
        (if (begin (set! tmp.55 (bitwise-and tmp.46 255)) (= tmp.55 46))
          14
          6)))
    (define L.fun/error10696.4 (lambda () 55102))
    (define L.fun/ascii-char10693.5 (lambda () 25390))
    (define L.fun/void10697.6 (lambda () 30))
    (define L.fun/any10694.7 (lambda () 22))
    (define L.fun/void10695.8 (lambda () 30))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char10693.5))
      (set! boolean1.4
        (begin
          (set! tmp.56 (call L.fun/any10694.7))
          (call L.ascii-char?.10 tmp.56)))
      (set! void2.3 (call L.fun/void10695.8))
      (set! error3.2 (call L.fun/error10696.4))
      (set! void4.1 (call L.fun/void10697.6))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/empty12161.4 (lambda () 22))
    (define L.fun/error12159.5 (lambda () 1854))
    (define L.fun/ascii-char12162.6 (lambda () 25390))
    (define L.fun/error12163.7 (lambda () 10814))
    (define L.fun/error12160.8 (lambda () 27198))
    (begin
      (set! error0.5 (call L.fun/error12159.5))
      (set! error1.4 (call L.fun/error12160.8))
      (set! empty2.3 (call L.fun/empty12161.4))
      (set! ascii-char3.2 (call L.fun/ascii-char12162.6))
      (set! error4.1 (call L.fun/error12163.7))
      empty2.3)))
(check-by-interp
 '(module
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.24 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.23 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.22 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.21 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.19 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.67))
            318)
          318)))
    (define L.empty?.9
      (lambda (tmp.44)
        (if (begin (set! tmp.68 (bitwise-and tmp.44 255)) (= tmp.68 22))
          14
          6)))
    (define L.fun/void12536.4 (lambda () 30))
    (define L.fun/any12537.5 (lambda () 22))
    (define L.fun/error12539.6 (lambda () 29502))
    (define L.fun/error12538.7 (lambda () 24894))
    (begin
      (set! void0.5 (call L.fun/void12536.4))
      (set! boolean1.4
        (begin (set! tmp.69 (call L.fun/any12537.5)) (call L.empty?.9 tmp.69)))
      (set! fixnum2.3
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.*.10 784 384))
              (begin
                (set! tmp.72 (call L.+.11 104 912))
                (call L.+.11 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.-.12 1776 1288))
                (begin
                  (set! tmp.75 (call L.*.10 792 760))
                  (call L.-.12 tmp.74 tmp.75))))
            (call L.-.12 tmp.70 tmp.73))))
      (set! error3.2 (call L.fun/error12538.7))
      (set! error4.1 (call L.fun/error12539.6))
      error4.1)))
(check-by-interp
 '(module
    (define L.pair?.12
      (lambda (tmp.48)
        (if (begin (set! tmp.55 (bitwise-and tmp.48 7)) (= tmp.55 1)) 14 6)))
    (define L.+.11
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
    (define L.*.9
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
    (define L.fun/any13289.4 (lambda () 6))
    (define L.fun/empty13290.5 (lambda () 22))
    (define L.fun/error13288.6 (lambda () 48958))
    (define L.fun/ascii-char13291.7 (lambda () 25390))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70 (call L.*.9 1360 1576))
              (begin
                (set! tmp.71 (call L.-.10 1888 296))
                (call L.-.10 tmp.70 tmp.71))))
          (begin
            (set! tmp.72
              (begin
                (set! tmp.73 (call L.-.10 1880 1808))
                (begin
                  (set! tmp.74 (call L.*.9 2008 704))
                  (call L.-.10 tmp.73 tmp.74))))
            (call L.+.11 tmp.69 tmp.72))))
      (set! error1.4 (call L.fun/error13288.6))
      (set! fixnum2.3
        (begin
          (set! tmp.75
            (begin
              (set! tmp.76 (call L.-.10 1488 1192))
              (begin
                (set! tmp.77 (call L.-.10 1160 1480))
                (call L.-.10 tmp.76 tmp.77))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79 (call L.*.9 24 1240))
                (begin
                  (set! tmp.80 (call L.+.11 1808 1752))
                  (call L.*.9 tmp.79 tmp.80))))
            (call L.-.10 tmp.75 tmp.78))))
      (set! boolean3.2
        (begin (set! tmp.81 (call L.fun/any13289.4)) (call L.pair?.12 tmp.81)))
      (set! empty4.1 (call L.fun/empty13290.5))
      (call L.fun/ascii-char13291.7))))
(check-by-interp
 '(module
    (define L.fixnum?.12
      (lambda (tmp.42)
        (if (begin (set! tmp.55 (bitwise-and tmp.42 7)) (= tmp.55 0)) 14 6)))
    (define L.+.11
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
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.20 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.19 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (begin
              (set! tmp.64 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.64))
            318)
          318)))
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
    (define L.fun/ascii-char13294.4 (lambda () 25390))
    (define L.fun/any13295.5 (lambda () 6))
    (define L.fun/error13297.6 (lambda () 46910))
    (define L.fun/ascii-char13296.7 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char13294.4))
      (set! fixnum1.4
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70 (call L.-.9 272 920))
              (begin
                (set! tmp.71 (call L.*.10 1312 1528))
                (call L.-.9 tmp.70 tmp.71))))
          (begin
            (set! tmp.72
              (begin
                (set! tmp.73 (call L.+.11 928 608))
                (begin
                  (set! tmp.74 (call L.-.9 224 1288))
                  (call L.+.11 tmp.73 tmp.74))))
            (call L.+.11 tmp.69 tmp.72))))
      (set! boolean2.3
        (begin
          (set! tmp.75 (call L.fun/any13295.5))
          (call L.fixnum?.12 tmp.75)))
      (set! ascii-char3.2 (call L.fun/ascii-char13296.7))
      (set! error4.1 (call L.fun/error13297.6))
      ascii-char0.5)))
(check-by-interp
 '(module
    (define L.ascii-char?.10
      (lambda (tmp.46)
        (if (begin (set! tmp.55 (bitwise-and tmp.46 255)) (= tmp.55 46))
          14
          6)))
    (define L.fun/ascii-char13919.4 (lambda () 25390))
    (define L.fun/error13917.5 (lambda () 34878))
    (define L.fun/any13918.6 (lambda () 14))
    (define L.fun/void13916.7 (lambda () 30))
    (define L.fun/ascii-char13915.8 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char13915.8))
      (set! void1.4 (call L.fun/void13916.7))
      (set! error2.3 (call L.fun/error13917.5))
      (set! boolean3.2
        (begin
          (set! tmp.56 (call L.fun/any13918.6))
          (call L.ascii-char?.10 tmp.56)))
      (set! ascii-char4.1 (call L.fun/ascii-char13919.4))
      void1.4)))
(check-by-interp
 '(module
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.22 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.21 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.24 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.23 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.19 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.67))
            318)
          318)))
    (define L.fun/empty14259.4 (lambda () 22))
    (define L.fun/ascii-char14257.5 (lambda () 25390))
    (define L.fun/error14258.6 (lambda () 21310))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char14257.5))
      (set! fixnum1.4
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.8 1648 1776))
              (begin
                (set! tmp.70 (call L.*.8 1808 1328))
                (call L.-.9 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.-.9 1456 1872))
                (begin
                  (set! tmp.73 (call L.+.10 432 624))
                  (call L.-.9 tmp.72 tmp.73))))
            (call L.*.8 tmp.68 tmp.71))))
      (set! error2.3 (call L.fun/error14258.6))
      (set! empty3.2 (call L.fun/empty14259.4))
      (set! fixnum4.1
        (begin
          (set! tmp.74
            (begin
              (set! tmp.75 (call L.+.10 1448 544))
              (begin
                (set! tmp.76 (call L.+.10 504 1936))
                (call L.-.9 tmp.75 tmp.76))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78 (call L.*.8 832 624))
                (begin
                  (set! tmp.79 (call L.*.8 816 256))
                  (call L.+.10 tmp.78 tmp.79))))
            (call L.-.9 tmp.74 tmp.77))))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/empty15571.4 (lambda () 22))
    (define L.fun/ascii-char15572.5 (lambda () 25390))
    (define L.fun/ascii-char15569.6 (lambda () 25390))
    (define L.fun/empty15570.7 (lambda () 22))
    (define L.fun/void15568.8 (lambda () 30))
    (begin
      (set! void0.5 (call L.fun/void15568.8))
      (set! ascii-char1.4 (call L.fun/ascii-char15569.6))
      (set! empty2.3 (call L.fun/empty15570.7))
      (set! empty3.2 (call L.fun/empty15571.4))
      (set! ascii-char4.1 (call L.fun/ascii-char15572.5))
      empty3.2)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.22 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.21 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.24 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.23 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.19 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.67))
            318)
          318)))
    (define L.fun/ascii-char15704.4 (lambda () 25390))
    (define L.fun/void15705.5 (lambda () 30))
    (define L.fun/ascii-char15707.6 (lambda () 25390))
    (define L.fun/error15708.7 (lambda () 36158))
    (define L.fun/empty15706.8 (lambda () 22))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char15704.4))
      (set! void1.4 (call L.fun/void15705.5))
      (set! fixnum2.3
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.10 1192 424))
              (begin
                (set! tmp.70 (call L.-.11 1600 1368))
                (call L.*.10 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.+.12 1936 536))
                (begin
                  (set! tmp.73 (call L.*.10 112 1704))
                  (call L.*.10 tmp.72 tmp.73))))
            (call L.*.10 tmp.68 tmp.71))))
      (set! empty3.2 (call L.fun/empty15706.8))
      (set! ascii-char4.1 (call L.fun/ascii-char15707.6))
      (call L.fun/error15708.7))))
(check-by-interp
 '(module
    (define L.empty?.13
      (lambda (tmp.44)
        (if (begin (set! tmp.55 (bitwise-and tmp.44 255)) (= tmp.55 22))
          14
          6)))
    (define L.ascii-char?.12
      (lambda (tmp.46)
        (if (begin (set! tmp.56 (bitwise-and tmp.46 255)) (= tmp.56 46))
          14
          6)))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.57
                (if (begin (set! tmp.58 (bitwise-and tmp.20 7)) (= tmp.58 0))
                  14
                  6))
              (!= tmp.57 6))
          (if (begin
                (set! tmp.59
                  (if (begin (set! tmp.60 (bitwise-and tmp.19 7)) (= tmp.60 0))
                    14
                    6))
                (!= tmp.59 6))
            (begin
              (set! tmp.61 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.61))
            318)
          318)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.62
                (if (begin (set! tmp.63 (bitwise-and tmp.24 7)) (= tmp.63 0))
                  14
                  6))
              (!= tmp.62 6))
          (if (begin
                (set! tmp.64
                  (if (begin (set! tmp.65 (bitwise-and tmp.23 7)) (= tmp.65 0))
                    14
                    6))
                (!= tmp.64 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.66
                (if (begin (set! tmp.67 (bitwise-and tmp.22 7)) (= tmp.67 0))
                  14
                  6))
              (!= tmp.66 6))
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.21 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/void15911.4 (lambda () 30))
    (define L.fun/any15910.5 (lambda () 25390))
    (define L.fun/any15908.6 (lambda () 25390))
    (define L.fun/ascii-char15909.7 (lambda () 25390))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71 (call L.+.9 1608 152))
              (begin
                (set! tmp.72 (call L.+.9 1064 256))
                (call L.+.9 tmp.71 tmp.72))))
          (begin
            (set! tmp.73
              (begin
                (set! tmp.74 (call L.-.10 2032 1016))
                (begin
                  (set! tmp.75 (call L.-.10 544 1496))
                  (call L.-.10 tmp.74 tmp.75))))
            (call L.*.11 tmp.70 tmp.73))))
      (set! boolean1.4
        (begin
          (set! tmp.76 (call L.fun/any15908.6))
          (call L.ascii-char?.12 tmp.76)))
      (set! ascii-char2.3 (call L.fun/ascii-char15909.7))
      (set! boolean3.2
        (begin
          (set! tmp.77 (call L.fun/any15910.5))
          (call L.empty?.13 tmp.77)))
      (set! void4.1 (call L.fun/void15911.4))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/error16257.4 (lambda () 57150))
    (define L.fun/ascii-char16255.5 (lambda () 25390))
    (define L.fun/empty16258.6 (lambda () 22))
    (define L.fun/empty16256.7 (lambda () 22))
    (define L.fun/ascii-char16259.8 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char16255.5))
      (set! empty1.4 (call L.fun/empty16256.7))
      (set! error2.3 (call L.fun/error16257.4))
      (set! empty3.2 (call L.fun/empty16258.6))
      (set! ascii-char4.1 (call L.fun/ascii-char16259.8))
      error2.3)))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.24 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.23 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.22 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.21 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.19 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.67))
            318)
          318)))
    (define L.fun/void17748.4 (lambda () 30))
    (define L.fun/ascii-char17750.5 (lambda () 25390))
    (define L.fun/error17749.6 (lambda () 36158))
    (begin
      (set! void0.5 (call L.fun/void17748.4))
      (set! fixnum1.4
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.8 2000 1496))
              (begin
                (set! tmp.70 (call L.+.9 1416 464))
                (call L.+.9 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.*.8 912 1352))
                (begin
                  (set! tmp.73 (call L.+.9 1176 1184))
                  (call L.+.9 tmp.72 tmp.73))))
            (call L.+.9 tmp.68 tmp.71))))
      (set! error2.3 (call L.fun/error17749.6))
      (set! ascii-char3.2 (call L.fun/ascii-char17750.5))
      (set! fixnum4.1
        (begin
          (set! tmp.74
            (begin
              (set! tmp.75 (call L.*.8 1920 608))
              (begin
                (set! tmp.76 (call L.+.9 1400 1456))
                (call L.-.10 tmp.75 tmp.76))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78 (call L.*.8 1480 400))
                (begin
                  (set! tmp.79 (call L.-.10 848 1320))
                  (call L.+.9 tmp.78 tmp.79))))
            (call L.-.10 tmp.74 tmp.77))))
      void0.5)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.22 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.21 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.20 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.19 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (begin
              (set! tmp.63 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.63))
            318)
          318)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.24 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.23 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.fun/empty17803.4 (lambda () 22))
    (define L.fun/error17806.5 (lambda () 38462))
    (define L.fun/void17802.6 (lambda () 30))
    (define L.fun/void17805.7 (lambda () 30))
    (define L.fun/empty17804.8 (lambda () 22))
    (begin
      (set! void0.5 (call L.fun/void17802.6))
      (set! empty1.4 (call L.fun/empty17803.4))
      (set! empty2.3 (call L.fun/empty17804.8))
      (set! void3.2 (call L.fun/void17805.7))
      (set! fixnum4.1
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.-.10 936 992))
              (begin
                (set! tmp.70 (call L.*.11 792 416))
                (call L.*.11 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.+.12 1936 792))
                (begin
                  (set! tmp.73 (call L.*.11 472 1904))
                  (call L.*.11 tmp.72 tmp.73))))
            (call L.-.10 tmp.68 tmp.71))))
      (call L.fun/error17806.5))))
(check-by-interp
 '(module
    (define L.*.6
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
    (define L.void?.5
      (lambda (tmp.45)
        (if (begin (set! tmp.60 (bitwise-and tmp.45 255)) (= tmp.60 30))
          14
          6)))
    (if (begin
          (set! tmp.61
            (begin
              (set! tmp.62
                (begin
                  (set! boolean0.5 14)
                  (set! error1.4 830)
                  (set! void2.3 30)
                  (set! fixnum3.2 1512)
                  (set! fixnum4.1 88)
                  30))
              (call L.void?.5 tmp.62)))
          (!= tmp.61 6))
      (begin
        (set! tmp.63 (if (!= 14 6) 400 1200))
        (begin
          (set! tmp.64 (if (!= 14 6) 1000 1256))
          (call L.*.6 tmp.63 tmp.64)))
      (begin
        (set! tmp.65 (if (!= 6 6) 1464 360))
        (begin
          (set! tmp.66 (if (!= 14 6) 72 816))
          (call L.*.6 tmp.65 tmp.66))))))
(check-by-interp
 '(module
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.55
                (if (begin (set! tmp.56 (bitwise-and tmp.22 7)) (= tmp.56 0))
                  14
                  6))
              (!= tmp.55 6))
          (if (begin
                (set! tmp.57
                  (if (begin (set! tmp.58 (bitwise-and tmp.21 7)) (= tmp.58 0))
                    14
                    6))
                (!= tmp.57 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.24 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.23 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.9
      (lambda (tmp.19 tmp.20)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.20 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.19 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (begin
              (set! tmp.67 (arithmetic-shift-right tmp.20 3))
              (* tmp.19 tmp.67))
            318)
          318)))
    (define L.fun/void20503.4 (lambda () 30))
    (define L.fun/empty20501.5 (lambda () 22))
    (define L.fun/ascii-char20504.6 (lambda () 25390))
    (define L.fun/void20502.7 (lambda () 30))
    (begin
      (set! empty0.5 (call L.fun/empty20501.5))
      (set! void1.4 (call L.fun/void20502.7))
      (set! void2.3 (call L.fun/void20503.4))
      (set! ascii-char3.2 (call L.fun/ascii-char20504.6))
      (set! fixnum4.1
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.9 144 1000))
              (begin
                (set! tmp.70 (call L.*.9 1248 1840))
                (call L.-.10 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.*.9 88 1216))
                (begin
                  (set! tmp.73 (call L.+.11 512 784))
                  (call L.*.9 tmp.72 tmp.73))))
            (call L.*.9 tmp.68 tmp.71))))
      ascii-char3.2)))
(check-by-interp
 '(module
    (define L.-.17
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
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.23 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.22 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.21 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.20 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.68))
            318)
          318)))
    (define L.fun/error28491.4 (lambda () 45118))
    (define L.fun/empty28492.5 (lambda () (call L.fun/empty28493.6)))
    (define L.fun/empty28493.6 (lambda () 22))
    (define L.fun/empty28494.7 (lambda () (call L.fun/empty28495.12)))
    (define L.fun/ascii-char28488.8
      (lambda () (call L.fun/ascii-char28489.13)))
    (define L.fun/error28490.9 (lambda () (call L.fun/error28491.4)))
    (define L.fun/void28497.10 (lambda () 30))
    (define L.fun/void28496.11 (lambda () (call L.fun/void28497.10)))
    (define L.fun/empty28495.12 (lambda () 22))
    (define L.fun/ascii-char28489.13 (lambda () 25390))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.15 456 1616))
                  (begin
                    (set! tmp.72 (call L.+.16 912 144))
                    (call L.-.17 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.15 1048 928))
                    (begin
                      (set! tmp.75 (call L.*.15 1272 224))
                      (call L.-.17 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.15 1872 224))
                    (begin
                      (set! tmp.79 (call L.+.16 912 1528))
                      (call L.*.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.16 1672 320))
                      (begin
                        (set! tmp.82 (call L.-.17 1352 1280))
                        (call L.+.16 tmp.81 tmp.82))))
                  (call L.-.17 tmp.77 tmp.80))))
            (call L.-.17 tmp.69 tmp.76))))
      (set! ascii-char1.5 (call L.fun/ascii-char28488.8))
      (set! error2.4 (call L.fun/error28490.9))
      (set! empty3.3 (call L.fun/empty28492.5))
      (set! empty4.2 (call L.fun/empty28494.7))
      (set! void5.1 (call L.fun/void28496.11))
      error2.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char28930.4
      (lambda () (call L.fun/ascii-char28931.10)))
    (define L.fun/error28940.5 (lambda () (call L.fun/error28941.15)))
    (define L.fun/ascii-char28935.6 (lambda () 25390))
    (define L.fun/void28936.7 (lambda () (call L.fun/void28937.11)))
    (define L.fun/void28938.8 (lambda () (call L.fun/void28939.14)))
    (define L.fun/error28933.9 (lambda () 44606))
    (define L.fun/ascii-char28931.10 (lambda () 25390))
    (define L.fun/void28937.11 (lambda () 30))
    (define L.fun/ascii-char28934.12
      (lambda () (call L.fun/ascii-char28935.6)))
    (define L.fun/error28932.13 (lambda () (call L.fun/error28933.9)))
    (define L.fun/void28939.14 (lambda () 30))
    (define L.fun/error28941.15 (lambda () 62526))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char28930.4))
      (set! error1.5 (call L.fun/error28932.13))
      (set! ascii-char2.4 (call L.fun/ascii-char28934.12))
      (set! void3.3 (call L.fun/void28936.7))
      (set! void4.2 (call L.fun/void28938.8))
      (set! error5.1 (call L.fun/error28940.5))
      void4.2)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.16
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
    (define L.fun/empty30828.4 (lambda () 22))
    (define L.fun/empty30827.5 (lambda () (call L.fun/empty30828.4)))
    (define L.fun/void30829.6 (lambda () (call L.fun/void30830.12)))
    (define L.fun/error30825.7 (lambda () (call L.fun/error30826.11)))
    (define L.fun/error30824.8 (lambda () 31294))
    (define L.fun/empty30822.9 (lambda () 22))
    (define L.fun/error30823.10 (lambda () (call L.fun/error30824.8)))
    (define L.fun/error30826.11 (lambda () 28734))
    (define L.fun/void30830.12 (lambda () 30))
    (define L.fun/empty30821.13 (lambda () (call L.fun/empty30822.9)))
    (begin
      (set! empty0.6 (call L.fun/empty30821.13))
      (set! error1.5 (call L.fun/error30823.10))
      (set! error2.4 (call L.fun/error30825.7))
      (set! empty3.3 (call L.fun/empty30827.5))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.15 1560 1424))
                  (begin
                    (set! tmp.72 (call L.-.15 488 1440))
                    (call L.*.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.17 1008 432))
                    (begin
                      (set! tmp.75 (call L.+.17 760 664))
                      (call L.*.16 tmp.74 tmp.75))))
                (call L.+.17 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.17 1368 408))
                    (begin
                      (set! tmp.79 (call L.*.16 552 2016))
                      (call L.+.17 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.16 528 1168))
                      (begin
                        (set! tmp.82 (call L.+.17 1872 1424))
                        (call L.+.17 tmp.81 tmp.82))))
                  (call L.+.17 tmp.77 tmp.80))))
            (call L.-.15 tmp.69 tmp.76))))
      (set! void5.1 (call L.fun/void30829.6))
      void5.1)))
(check-by-interp
 '(module
    (define L.-.13
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
    (define L.*.12
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
    (define L.+.11
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
    (define L.fun/void31698.4 (lambda () (call L.fun/void31699.8)))
    (define L.fun/void31701.5 (lambda () 30))
    (define L.fun/void31700.6 (lambda () (call L.fun/void31701.5)))
    (define L.fun/empty31697.7 (lambda () 22))
    (define L.fun/void31699.8 (lambda () 30))
    (define L.fun/empty31696.9 (lambda () (call L.fun/empty31697.7)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.11 608 1264))
                  (begin
                    (set! tmp.72 (call L.*.12 800 1424))
                    (call L.+.11 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.13 1392 360))
                    (begin
                      (set! tmp.75 (call L.*.12 1416 1936))
                      (call L.*.12 tmp.74 tmp.75))))
                (call L.*.12 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.11 760 1840))
                    (begin
                      (set! tmp.79 (call L.*.12 1616 1968))
                      (call L.*.12 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.11 360 1792))
                      (begin
                        (set! tmp.82 (call L.*.12 896 1480))
                        (call L.+.11 tmp.81 tmp.82))))
                  (call L.+.11 tmp.77 tmp.80))))
            (call L.*.12 tmp.69 tmp.76))))
      (set! fixnum1.5
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.12 1584 968))
                  (begin
                    (set! tmp.86 (call L.+.11 928 1624))
                    (call L.*.12 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.*.12 656 1432))
                    (begin
                      (set! tmp.89 (call L.+.11 784 208))
                      (call L.-.13 tmp.88 tmp.89))))
                (call L.*.12 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.-.13 192 1192))
                    (begin
                      (set! tmp.93 (call L.-.13 1424 1872))
                      (call L.-.13 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.*.12 176 88))
                      (begin
                        (set! tmp.96 (call L.*.12 912 1120))
                        (call L.-.13 tmp.95 tmp.96))))
                  (call L.*.12 tmp.91 tmp.94))))
            (call L.+.11 tmp.83 tmp.90))))
      (set! empty2.4 (call L.fun/empty31696.9))
      (set! void3.3 (call L.fun/void31698.4))
      (set! void4.2 (call L.fun/void31700.6))
      (set! fixnum5.1
        (begin
          (set! tmp.97
            (begin
              (set! tmp.98
                (begin
                  (set! tmp.99 (call L.-.13 640 896))
                  (begin
                    (set! tmp.100 (call L.-.13 1112 88))
                    (call L.+.11 tmp.99 tmp.100))))
              (begin
                (set! tmp.101
                  (begin
                    (set! tmp.102 (call L.+.11 1952 1928))
                    (begin
                      (set! tmp.103 (call L.*.12 1552 1384))
                      (call L.+.11 tmp.102 tmp.103))))
                (call L.+.11 tmp.98 tmp.101))))
          (begin
            (set! tmp.104
              (begin
                (set! tmp.105
                  (begin
                    (set! tmp.106 (call L.-.13 272 960))
                    (begin
                      (set! tmp.107 (call L.*.12 1216 1392))
                      (call L.+.11 tmp.106 tmp.107))))
                (begin
                  (set! tmp.108
                    (begin
                      (set! tmp.109 (call L.*.12 1152 1432))
                      (begin
                        (set! tmp.110 (call L.-.13 1216 832))
                        (call L.+.11 tmp.109 tmp.110))))
                  (call L.*.12 tmp.105 tmp.108))))
            (call L.*.12 tmp.97 tmp.104))))
      void3.3)))
(check-by-interp
 '(module
    (define L.pair?.15
      (lambda (tmp.49)
        (if (begin (set! tmp.56 (bitwise-and tmp.49 7)) (= tmp.56 1)) 14 6)))
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
    (define L.+.13
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
    (define L.*.12
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
    (define L.fun/void46565.4 (lambda () (call L.fun/void46566.6)))
    (define L.fun/error46563.5 (lambda () (call L.fun/error46564.8)))
    (define L.fun/void46566.6 (lambda () 30))
    (define L.fun/empty46562.7 (lambda () 22))
    (define L.fun/error46564.8 (lambda () 49982))
    (define L.fun/empty46561.9 (lambda () (call L.fun/empty46562.7)))
    (define L.fun/any46567.10 (lambda () 1696))
    (begin
      (set! empty0.6 (call L.fun/empty46561.9))
      (set! error1.5 (call L.fun/error46563.5))
      (set! fixnum2.4
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71
                (begin
                  (set! tmp.72 (call L.*.12 152 1432))
                  (begin
                    (set! tmp.73 (call L.+.13 640 288))
                    (call L.+.13 tmp.72 tmp.73))))
              (begin
                (set! tmp.74
                  (begin
                    (set! tmp.75 (call L.-.14 608 424))
                    (begin
                      (set! tmp.76 (call L.*.12 1656 1016))
                      (call L.*.12 tmp.75 tmp.76))))
                (call L.-.14 tmp.71 tmp.74))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79 (call L.*.12 1392 600))
                    (begin
                      (set! tmp.80 (call L.-.14 280 856))
                      (call L.-.14 tmp.79 tmp.80))))
                (begin
                  (set! tmp.81
                    (begin
                      (set! tmp.82 (call L.-.14 760 344))
                      (begin
                        (set! tmp.83 (call L.+.13 704 1496))
                        (call L.+.13 tmp.82 tmp.83))))
                  (call L.+.13 tmp.78 tmp.81))))
            (call L.*.12 tmp.70 tmp.77))))
      (set! void3.3 (call L.fun/void46565.4))
      (set! fixnum4.2
        (begin
          (set! tmp.84
            (begin
              (set! tmp.85
                (begin
                  (set! tmp.86 (call L.*.12 1784 544))
                  (begin
                    (set! tmp.87 (call L.-.14 1800 352))
                    (call L.-.14 tmp.86 tmp.87))))
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.89 (call L.+.13 592 392))
                    (begin
                      (set! tmp.90 (call L.-.14 1544 520))
                      (call L.-.14 tmp.89 tmp.90))))
                (call L.-.14 tmp.85 tmp.88))))
          (begin
            (set! tmp.91
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.93 (call L.*.12 1288 896))
                    (begin
                      (set! tmp.94 (call L.*.12 912 384))
                      (call L.-.14 tmp.93 tmp.94))))
                (begin
                  (set! tmp.95
                    (begin
                      (set! tmp.96 (call L.*.12 680 400))
                      (begin
                        (set! tmp.97 (call L.+.13 664 480))
                        (call L.-.14 tmp.96 tmp.97))))
                  (call L.*.12 tmp.92 tmp.95))))
            (call L.*.12 tmp.84 tmp.91))))
      (set! boolean5.1
        (begin
          (set! tmp.98 (call L.fun/any46567.10))
          (call L.pair?.15 tmp.98)))
      void3.3)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.25 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.24 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.21 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.20 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.68))
            318)
          318)))
    (define L.fun/error50281.4 (lambda () 16446))
    (define L.fun/error50280.5 (lambda () (call L.fun/error50281.4)))
    (define L.fun/void50283.6 (lambda () 30))
    (define L.fun/ascii-char50284.7 (lambda () (call L.fun/ascii-char50285.9)))
    (define L.fun/void50278.8 (lambda () (call L.fun/void50279.10)))
    (define L.fun/ascii-char50285.9 (lambda () 25390))
    (define L.fun/void50279.10 (lambda () 30))
    (define L.fun/void50282.11 (lambda () (call L.fun/void50283.6)))
    (begin
      (set! void0.6 (call L.fun/void50278.8))
      (set! error1.5 (call L.fun/error50280.5))
      (set! fixnum2.4
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.13 616 1120))
                  (begin
                    (set! tmp.72 (call L.-.14 1456 192))
                    (call L.-.14 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.15 1400 424))
                    (begin
                      (set! tmp.75 (call L.+.15 1416 1392))
                      (call L.-.14 tmp.74 tmp.75))))
                (call L.*.13 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.14 1960 1424))
                    (begin
                      (set! tmp.79 (call L.-.14 336 128))
                      (call L.-.14 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.15 1152 1640))
                      (begin
                        (set! tmp.82 (call L.+.15 1088 312))
                        (call L.-.14 tmp.81 tmp.82))))
                  (call L.-.14 tmp.77 tmp.80))))
            (call L.+.15 tmp.69 tmp.76))))
      (set! void3.3 (call L.fun/void50282.11))
      (set! fixnum4.2
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.-.14 1672 608))
                  (begin
                    (set! tmp.86 (call L.+.15 1736 400))
                    (call L.-.14 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.+.15 1496 1520))
                    (begin
                      (set! tmp.89 (call L.-.14 304 1136))
                      (call L.-.14 tmp.88 tmp.89))))
                (call L.-.14 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.-.14 1640 192))
                    (begin
                      (set! tmp.93 (call L.-.14 1816 1224))
                      (call L.-.14 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.-.14 520 1312))
                      (begin
                        (set! tmp.96 (call L.*.13 120 1176))
                        (call L.-.14 tmp.95 tmp.96))))
                  (call L.+.15 tmp.91 tmp.94))))
            (call L.*.13 tmp.83 tmp.90))))
      (set! ascii-char5.1 (call L.fun/ascii-char50284.7))
      fixnum2.4)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
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
    (define L.-.13
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
    (define L.fun/ascii-char51656.4 (lambda () (call L.fun/ascii-char51657.5)))
    (define L.fun/ascii-char51657.5 (lambda () 25390))
    (define L.fun/error51658.6 (lambda () (call L.fun/error51659.11)))
    (define L.fun/void51654.7 (lambda () (call L.fun/void51655.9)))
    (define L.fun/error51653.8 (lambda () 20030))
    (define L.fun/void51655.9 (lambda () 30))
    (define L.fun/error51652.10 (lambda () (call L.fun/error51653.8)))
    (define L.fun/error51659.11 (lambda () 45374))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.13 696 32))
                  (begin
                    (set! tmp.72 (call L.*.14 1576 1768))
                    (call L.-.13 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.15 1632 408))
                    (begin
                      (set! tmp.75 (call L.-.13 632 976))
                      (call L.-.13 tmp.74 tmp.75))))
                (call L.*.14 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.15 168 608))
                    (begin
                      (set! tmp.79 (call L.+.15 1912 400))
                      (call L.+.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.14 992 1256))
                      (begin
                        (set! tmp.82 (call L.*.14 1144 424))
                        (call L.+.15 tmp.81 tmp.82))))
                  (call L.*.14 tmp.77 tmp.80))))
            (call L.*.14 tmp.69 tmp.76))))
      (set! error1.5 (call L.fun/error51652.10))
      (set! void2.4 (call L.fun/void51654.7))
      (set! fixnum3.3
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.14 1472 1560))
                  (begin
                    (set! tmp.86 (call L.*.14 592 1624))
                    (call L.*.14 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.*.14 536 1352))
                    (begin
                      (set! tmp.89 (call L.*.14 888 848))
                      (call L.*.14 tmp.88 tmp.89))))
                (call L.-.13 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.*.14 1120 56))
                    (begin
                      (set! tmp.93 (call L.+.15 824 1016))
                      (call L.-.13 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.*.14 16 1056))
                      (begin
                        (set! tmp.96 (call L.+.15 904 144))
                        (call L.+.15 tmp.95 tmp.96))))
                  (call L.-.13 tmp.91 tmp.94))))
            (call L.*.14 tmp.83 tmp.90))))
      (set! ascii-char4.2 (call L.fun/ascii-char51656.4))
      (set! error5.1 (call L.fun/error51658.6))
      void2.4)))
(check-by-interp
 '(module
    (define L.vector?.16
      (lambda (tmp.50)
        (if (begin (set! tmp.56 (bitwise-and tmp.50 7)) (= tmp.56 3)) 14 6)))
    (define L.fun/error54326.4 (lambda () (call L.fun/error54327.8)))
    (define L.fun/error54322.5 (lambda () 18238))
    (define L.fun/empty54331.6 (lambda () 22))
    (define L.fun/void54329.7 (lambda () 30))
    (define L.fun/error54327.8 (lambda () 17214))
    (define L.fun/error54325.9 (lambda () 8766))
    (define L.fun/error54321.10 (lambda () (call L.fun/error54322.5)))
    (define L.fun/any54323.11 (lambda () 25390))
    (define L.fun/void54328.12 (lambda () (call L.fun/void54329.7)))
    (define L.fun/error54324.13 (lambda () (call L.fun/error54325.9)))
    (define L.fun/empty54330.14 (lambda () (call L.fun/empty54331.6)))
    (begin
      (set! error0.6 (call L.fun/error54321.10))
      (set! boolean1.5
        (begin
          (set! tmp.57 (call L.fun/any54323.11))
          (call L.vector?.16 tmp.57)))
      (set! error2.4 (call L.fun/error54324.13))
      (set! error3.3 (call L.fun/error54326.4))
      (set! void4.2 (call L.fun/void54328.12))
      (set! empty5.1 (call L.fun/empty54330.14))
      void4.2)))
(check-by-interp
 '(module
    (define L.*.19
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
    (define L.+.18
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
    (define L.-.17
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
    (define L.boolean?.16
      (lambda (tmp.44)
        (if (begin (set! tmp.69 (bitwise-and tmp.44 247)) (= tmp.69 6)) 14 6)))
    (define L.fun/ascii-char64319.4 (lambda () 25390))
    (define L.fun/error64313.5 (lambda () 26430))
    (define L.fun/empty64317.6 (lambda () 22))
    (define L.fun/ascii-char64318.7 (lambda () (call L.fun/ascii-char64319.4)))
    (define L.fun/void64310.8 (lambda () 30))
    (define L.fun/empty64315.9 (lambda () 22))
    (define L.fun/any64311.10 (lambda () 40766))
    (define L.fun/error64312.11 (lambda () (call L.fun/error64313.5)))
    (define L.fun/empty64316.12 (lambda () (call L.fun/empty64317.6)))
    (define L.fun/empty64314.13 (lambda () (call L.fun/empty64315.9)))
    (define L.fun/void64309.14 (lambda () (call L.fun/void64310.8)))
    (begin
      (set! void0.6 (call L.fun/void64309.14))
      (set! boolean1.5
        (begin
          (set! tmp.70 (call L.fun/any64311.10))
          (call L.boolean?.16 tmp.70)))
      (set! error2.4 (call L.fun/error64312.11))
      (set! empty3.3 (call L.fun/empty64314.13))
      (set! empty4.2 (call L.fun/empty64316.12))
      (set! fixnum5.1
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.17 1160 1520))
                  (begin
                    (set! tmp.74 (call L.+.18 1104 512))
                    (call L.+.18 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.*.19 1440 1808))
                    (begin
                      (set! tmp.77 (call L.-.17 696 1592))
                      (call L.-.17 tmp.76 tmp.77))))
                (call L.-.17 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.-.17 184 976))
                    (begin
                      (set! tmp.81 (call L.*.19 8 880))
                      (call L.*.19 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.*.19 1112 1104))
                      (begin
                        (set! tmp.84 (call L.+.18 992 1528))
                        (call L.-.17 tmp.83 tmp.84))))
                  (call L.*.19 tmp.79 tmp.82))))
            (call L.+.18 tmp.71 tmp.78))))
      (call L.fun/ascii-char64318.7))))
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
    (define L.fun/void75654.4 (lambda () 30))
    (define L.fun/empty75657.5 (lambda () (call L.fun/empty75658.10)))
    (define L.fun/ascii-char75662.6 (lambda () 25390))
    (define L.fun/ascii-char75660.7 (lambda () 25390))
    (define L.fun/empty75656.8 (lambda () 22))
    (define L.fun/ascii-char75661.9 (lambda () (call L.fun/ascii-char75662.6)))
    (define L.fun/empty75658.10 (lambda () 22))
    (define L.fun/empty75655.11 (lambda () (call L.fun/empty75656.8)))
    (define L.fun/void75653.12 (lambda () (call L.fun/void75654.4)))
    (define L.fun/ascii-char75659.13
      (lambda () (call L.fun/ascii-char75660.7)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.15 1632 8))
                  (begin
                    (set! tmp.72 (call L.-.15 824 448))
                    (call L.+.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.15 1680 8))
                    (begin
                      (set! tmp.75 (call L.*.17 1912 1232))
                      (call L.+.16 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.16 552 1320))
                    (begin
                      (set! tmp.79 (call L.-.15 1744 1840))
                      (call L.+.16 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.15 1744 1096))
                      (begin
                        (set! tmp.82 (call L.*.17 1680 408))
                        (call L.-.15 tmp.81 tmp.82))))
                  (call L.*.17 tmp.77 tmp.80))))
            (call L.-.15 tmp.69 tmp.76))))
      (set! void1.5 (call L.fun/void75653.12))
      (set! empty2.4 (call L.fun/empty75655.11))
      (set! empty3.3 (call L.fun/empty75657.5))
      (set! ascii-char4.2 (call L.fun/ascii-char75659.13))
      (set! ascii-char5.1 (call L.fun/ascii-char75661.9))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.16
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
    (define L.error?.14
      (lambda (tmp.48)
        (if (begin (set! tmp.69 (bitwise-and tmp.48 255)) (= tmp.69 62))
          14
          6)))
    (define L.fun/error83230.4 (lambda () (call L.fun/error83231.10)))
    (define L.fun/empty83233.5 (lambda () (call L.fun/empty83234.9)))
    (define L.fun/void83236.6 (lambda () 30))
    (define L.fun/ascii-char83229.7 (lambda () 25390))
    (define L.fun/void83235.8 (lambda () (call L.fun/void83236.6)))
    (define L.fun/empty83234.9 (lambda () 22))
    (define L.fun/error83231.10 (lambda () 6974))
    (define L.fun/any83232.11 (lambda () 25390))
    (define L.fun/ascii-char83228.12
      (lambda () (call L.fun/ascii-char83229.7)))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char83228.12))
      (set! error1.5 (call L.fun/error83230.4))
      (set! boolean2.4
        (begin
          (set! tmp.70 (call L.fun/any83232.11))
          (call L.error?.14 tmp.70)))
      (set! empty3.3 (call L.fun/empty83233.5))
      (set! void4.2 (call L.fun/void83235.8))
      (set! fixnum5.1
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.15 72 1816))
                  (begin
                    (set! tmp.74 (call L.*.16 1344 440))
                    (call L.+.17 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.-.15 912 192))
                    (begin
                      (set! tmp.77 (call L.-.15 608 88))
                      (call L.*.16 tmp.76 tmp.77))))
                (call L.*.16 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.+.17 1432 136))
                    (begin
                      (set! tmp.81 (call L.+.17 824 984))
                      (call L.+.17 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.+.17 208 504))
                      (begin
                        (set! tmp.84 (call L.+.17 1128 720))
                        (call L.*.16 tmp.83 tmp.84))))
                  (call L.+.17 tmp.79 tmp.82))))
            (call L.-.15 tmp.71 tmp.78))))
      void4.2)))
(check-by-interp
 '(module
    (define L.error?.16
      (lambda (tmp.48)
        (if (begin (set! tmp.56 (bitwise-and tmp.48 255)) (= tmp.56 62))
          14
          6)))
    (define L.fun/ascii-char87923.4
      (lambda () (call L.fun/ascii-char87924.13)))
    (define L.fun/empty87931.5 (lambda () 22))
    (define L.fun/ascii-char87928.6 (lambda () (call L.fun/ascii-char87929.7)))
    (define L.fun/ascii-char87929.7 (lambda () 25390))
    (define L.fun/ascii-char87926.8 (lambda () 25390))
    (define L.fun/empty87930.9 (lambda () (call L.fun/empty87931.5)))
    (define L.fun/void87922.10 (lambda () 30))
    (define L.fun/any87927.11 (lambda () 30))
    (define L.fun/ascii-char87925.12
      (lambda () (call L.fun/ascii-char87926.8)))
    (define L.fun/ascii-char87924.13 (lambda () 25390))
    (define L.fun/void87921.14 (lambda () (call L.fun/void87922.10)))
    (begin
      (set! void0.6 (call L.fun/void87921.14))
      (set! ascii-char1.5 (call L.fun/ascii-char87923.4))
      (set! ascii-char2.4 (call L.fun/ascii-char87925.12))
      (set! boolean3.3
        (begin
          (set! tmp.57 (call L.fun/any87927.11))
          (call L.error?.16 tmp.57)))
      (set! ascii-char4.2 (call L.fun/ascii-char87928.6))
      (set! empty5.1 (call L.fun/empty87930.9))
      empty5.1)))
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
    (define L.-.16
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
    (define L.+.15
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
    (define L.fun/void88023.4 (lambda () 30))
    (define L.fun/empty88027.5 (lambda () 22))
    (define L.fun/error88024.6 (lambda () (call L.fun/error88025.11)))
    (define L.fun/error88021.7 (lambda () 56894))
    (define L.fun/empty88026.8 (lambda () (call L.fun/empty88027.5)))
    (define L.fun/error88029.9 (lambda () 50494))
    (define L.fun/error88020.10 (lambda () (call L.fun/error88021.7)))
    (define L.fun/error88025.11 (lambda () 54334))
    (define L.fun/void88022.12 (lambda () (call L.fun/void88023.4)))
    (define L.fun/error88028.13 (lambda () (call L.fun/error88029.9)))
    (begin
      (set! error0.6 (call L.fun/error88020.10))
      (set! void1.5 (call L.fun/void88022.12))
      (set! error2.4 (call L.fun/error88024.6))
      (set! fixnum3.3
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.15 440 608))
                  (begin
                    (set! tmp.72 (call L.+.15 184 0))
                    (call L.-.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.15 144 168))
                    (begin
                      (set! tmp.75 (call L.+.15 1224 1448))
                      (call L.*.17 tmp.74 tmp.75))))
                (call L.-.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.16 32 864))
                    (begin
                      (set! tmp.79 (call L.+.15 752 872))
                      (call L.-.16 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.16 1912 1912))
                      (begin
                        (set! tmp.82 (call L.*.17 1704 784))
                        (call L.+.15 tmp.81 tmp.82))))
                  (call L.-.16 tmp.77 tmp.80))))
            (call L.+.15 tmp.69 tmp.76))))
      (set! empty4.2 (call L.fun/empty88026.8))
      (set! error5.1 (call L.fun/error88028.13))
      error0.6)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
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
    (define L.-.13
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
    (define L.pair?.12
      (lambda (tmp.49)
        (if (begin (set! tmp.69 (bitwise-and tmp.49 7)) (= tmp.69 1)) 14 6)))
    (define L.fun/ascii-char95245.4 (lambda () 25390))
    (define L.fun/empty95247.5 (lambda () 22))
    (define L.fun/void95242.6 (lambda () 30))
    (define L.fun/void95241.7 (lambda () (call L.fun/void95242.6)))
    (define L.fun/any95243.8 (lambda () 30))
    (define L.fun/ascii-char95244.9 (lambda () (call L.fun/ascii-char95245.4)))
    (define L.fun/empty95246.10 (lambda () (call L.fun/empty95247.5)))
    (begin
      (set! void0.6 (call L.fun/void95241.7))
      (set! boolean1.5
        (begin (set! tmp.70 (call L.fun/any95243.8)) (call L.pair?.12 tmp.70)))
      (set! ascii-char2.4 (call L.fun/ascii-char95244.9))
      (set! fixnum3.3
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.13 336 1928))
                  (begin
                    (set! tmp.74 (call L.*.14 776 1904))
                    (call L.-.13 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.*.14 1720 376))
                    (begin
                      (set! tmp.77 (call L.*.14 912 256))
                      (call L.-.13 tmp.76 tmp.77))))
                (call L.-.13 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.-.13 136 1400))
                    (begin
                      (set! tmp.81 (call L.-.13 1472 1648))
                      (call L.*.14 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.-.13 1240 528))
                      (begin
                        (set! tmp.84 (call L.+.15 1200 728))
                        (call L.+.15 tmp.83 tmp.84))))
                  (call L.*.14 tmp.79 tmp.82))))
            (call L.*.14 tmp.71 tmp.78))))
      (set! empty4.2 (call L.fun/empty95246.10))
      (set! fixnum5.1
        (begin
          (set! tmp.85
            (begin
              (set! tmp.86
                (begin
                  (set! tmp.87 (call L.-.13 168 1368))
                  (begin
                    (set! tmp.88 (call L.+.15 1368 1400))
                    (call L.*.14 tmp.87 tmp.88))))
              (begin
                (set! tmp.89
                  (begin
                    (set! tmp.90 (call L.*.14 696 72))
                    (begin
                      (set! tmp.91 (call L.*.14 1616 128))
                      (call L.*.14 tmp.90 tmp.91))))
                (call L.+.15 tmp.86 tmp.89))))
          (begin
            (set! tmp.92
              (begin
                (set! tmp.93
                  (begin
                    (set! tmp.94 (call L.+.15 360 896))
                    (begin
                      (set! tmp.95 (call L.*.14 1968 1472))
                      (call L.*.14 tmp.94 tmp.95))))
                (begin
                  (set! tmp.96
                    (begin
                      (set! tmp.97 (call L.+.15 1360 1136))
                      (begin
                        (set! tmp.98 (call L.*.14 1096 728))
                        (call L.*.14 tmp.97 tmp.98))))
                  (call L.-.13 tmp.93 tmp.96))))
            (call L.-.13 tmp.85 tmp.92))))
      ascii-char2.4)))
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
    (define L.fun/ascii-char101002.4 (lambda () 25390))
    (define L.fun/void101005.5 (lambda () (call L.fun/void101006.12)))
    (define L.fun/ascii-char101007.6
      (lambda () (call L.fun/ascii-char101008.10)))
    (define L.fun/ascii-char101000.7 (lambda () 25390))
    (define L.fun/void101004.8 (lambda () 30))
    (define L.fun/ascii-char100999.9
      (lambda () (call L.fun/ascii-char101000.7)))
    (define L.fun/ascii-char101008.10 (lambda () 25390))
    (define L.fun/void101003.11 (lambda () (call L.fun/void101004.8)))
    (define L.fun/void101006.12 (lambda () 30))
    (define L.fun/ascii-char101001.13
      (lambda () (call L.fun/ascii-char101002.4)))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char100999.9))
      (set! fixnum1.5
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.15 1032 720))
                  (begin
                    (set! tmp.72 (call L.-.15 1368 1568))
                    (call L.+.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.17 576 952))
                    (begin
                      (set! tmp.75 (call L.*.17 112 976))
                      (call L.-.15 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.17 1704 1048))
                    (begin
                      (set! tmp.79 (call L.+.16 728 16))
                      (call L.*.17 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.16 784 1072))
                      (begin
                        (set! tmp.82 (call L.*.17 1656 1152))
                        (call L.*.17 tmp.81 tmp.82))))
                  (call L.+.16 tmp.77 tmp.80))))
            (call L.+.16 tmp.69 tmp.76))))
      (set! ascii-char2.4 (call L.fun/ascii-char101001.13))
      (set! void3.3 (call L.fun/void101003.11))
      (set! void4.2 (call L.fun/void101005.5))
      (set! ascii-char5.1 (call L.fun/ascii-char101007.6))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.-.17
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
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.23 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.22 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.21 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.20 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.68))
            318)
          318)))
    (define L.fun/error102221.4 (lambda () 2110))
    (define L.fun/void102218.5 (lambda () (call L.fun/void102219.11)))
    (define L.fun/empty102216.6 (lambda () (call L.fun/empty102217.9)))
    (define L.fun/ascii-char102223.7 (lambda () 25390))
    (define L.fun/void102214.8 (lambda () (call L.fun/void102215.13)))
    (define L.fun/empty102217.9 (lambda () 22))
    (define L.fun/error102220.10 (lambda () (call L.fun/error102221.4)))
    (define L.fun/void102219.11 (lambda () 30))
    (define L.fun/ascii-char102222.12
      (lambda () (call L.fun/ascii-char102223.7)))
    (define L.fun/void102215.13 (lambda () 30))
    (begin
      (set! void0.6 (call L.fun/void102214.8))
      (set! empty1.5 (call L.fun/empty102216.6))
      (set! void2.4 (call L.fun/void102218.5))
      (set! error3.3 (call L.fun/error102220.10))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.15 1688 184))
                  (begin
                    (set! tmp.72 (call L.*.15 1192 936))
                    (call L.*.15 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.15 1264 1936))
                    (begin
                      (set! tmp.75 (call L.*.15 656 1968))
                      (call L.*.15 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.15 632 1256))
                    (begin
                      (set! tmp.79 (call L.+.16 1456 520))
                      (call L.*.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.15 568 1832))
                      (begin
                        (set! tmp.82 (call L.-.17 1672 24))
                        (call L.+.16 tmp.81 tmp.82))))
                  (call L.-.17 tmp.77 tmp.80))))
            (call L.-.17 tmp.69 tmp.76))))
      (set! ascii-char5.1 (call L.fun/ascii-char102222.12))
      error3.3)))
(check-by-interp
 '(module
    (define L.-.19
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
    (define L.*.18
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
    (define L.+.17
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
    (define L.vector?.16
      (lambda (tmp.50)
        (if (begin (set! tmp.69 (bitwise-and tmp.50 7)) (= tmp.69 3)) 14 6)))
    (define L.fun/void102243.4 (lambda () (call L.fun/void102244.10)))
    (define L.fun/any102238.5 (lambda () 6))
    (define L.fun/ascii-char102236.6
      (lambda () (call L.fun/ascii-char102237.13)))
    (define L.fun/void102241.7 (lambda () (call L.fun/void102242.11)))
    (define L.fun/ascii-char102239.8
      (lambda () (call L.fun/ascii-char102240.12)))
    (define L.fun/ascii-char102234.9
      (lambda () (call L.fun/ascii-char102235.14)))
    (define L.fun/void102244.10 (lambda () 30))
    (define L.fun/void102242.11 (lambda () 30))
    (define L.fun/ascii-char102240.12 (lambda () 25390))
    (define L.fun/ascii-char102237.13 (lambda () 25390))
    (define L.fun/ascii-char102235.14 (lambda () 25390))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char102234.9))
      (set! ascii-char1.5 (call L.fun/ascii-char102236.6))
      (set! boolean2.4
        (begin
          (set! tmp.70 (call L.fun/any102238.5))
          (call L.vector?.16 tmp.70)))
      (set! ascii-char3.3 (call L.fun/ascii-char102239.8))
      (set! void4.2 (call L.fun/void102241.7))
      (set! void5.1 (call L.fun/void102243.4))
      (begin
        (set! tmp.71
          (begin
            (set! tmp.72
              (begin
                (set! tmp.73 (call L.+.17 1848 1032))
                (begin
                  (set! tmp.74 (call L.+.17 488 1088))
                  (call L.*.18 tmp.73 tmp.74))))
            (begin
              (set! tmp.75
                (begin
                  (set! tmp.76 (call L.-.19 1440 264))
                  (begin
                    (set! tmp.77 (call L.+.17 1976 1248))
                    (call L.*.18 tmp.76 tmp.77))))
              (call L.*.18 tmp.72 tmp.75))))
        (begin
          (set! tmp.78
            (begin
              (set! tmp.79
                (begin
                  (set! tmp.80 (call L.+.17 1904 1616))
                  (begin
                    (set! tmp.81 (call L.+.17 576 312))
                    (call L.-.19 tmp.80 tmp.81))))
              (begin
                (set! tmp.82
                  (begin
                    (set! tmp.83 (call L.+.17 784 1400))
                    (begin
                      (set! tmp.84 (call L.*.18 592 1936))
                      (call L.-.19 tmp.83 tmp.84))))
                (call L.-.19 tmp.79 tmp.82))))
          (call L.*.18 tmp.71 tmp.78))))))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.18
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.25 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.24 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.21 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.20 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.68))
            318)
          318)))
    (define L.fun/empty104399.4 (lambda () (call L.fun/empty104400.8)))
    (define L.fun/void104397.5 (lambda () (call L.fun/void104398.12)))
    (define L.fun/error104406.6 (lambda () 52798))
    (define L.fun/empty104404.7 (lambda () 22))
    (define L.fun/empty104400.8 (lambda () 22))
    (define L.fun/error104405.9 (lambda () (call L.fun/error104406.6)))
    (define L.fun/empty104395.10 (lambda () (call L.fun/empty104396.14)))
    (define L.fun/void104401.11 (lambda () (call L.fun/void104402.13)))
    (define L.fun/void104398.12 (lambda () 30))
    (define L.fun/void104402.13 (lambda () 30))
    (define L.fun/empty104396.14 (lambda () 22))
    (define L.fun/empty104403.15 (lambda () (call L.fun/empty104404.7)))
    (begin
      (set! empty0.6 (call L.fun/empty104395.10))
      (set! void1.5 (call L.fun/void104397.5))
      (set! empty2.4 (call L.fun/empty104399.4))
      (set! void3.3 (call L.fun/void104401.11))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.17 1080 984))
                  (begin
                    (set! tmp.72 (call L.*.17 128 1576))
                    (call L.-.18 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.18 1344 576))
                    (begin
                      (set! tmp.75 (call L.*.17 832 560))
                      (call L.*.17 tmp.74 tmp.75))))
                (call L.*.17 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.19 1424 568))
                    (begin
                      (set! tmp.79 (call L.+.19 1512 776))
                      (call L.-.18 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.17 208 1344))
                      (begin
                        (set! tmp.82 (call L.-.18 608 1296))
                        (call L.+.19 tmp.81 tmp.82))))
                  (call L.*.17 tmp.77 tmp.80))))
            (call L.*.17 tmp.69 tmp.76))))
      (set! empty5.1 (call L.fun/empty104403.15))
      (call L.fun/error104405.9))))
(check-by-interp
 '(module
    (define L.boolean?.16
      (lambda (tmp.44)
        (if (begin (set! tmp.56 (bitwise-and tmp.44 247)) (= tmp.56 6)) 14 6)))
    (define L.fun/any105578.4 (lambda () 1504))
    (define L.fun/error105579.5 (lambda () (call L.fun/error105580.11)))
    (define L.fun/error105575.6 (lambda () 18494))
    (define L.fun/ascii-char105573.7 (lambda () 25390))
    (define L.fun/error105576.8 (lambda () (call L.fun/error105577.13)))
    (define L.fun/ascii-char105572.9
      (lambda () (call L.fun/ascii-char105573.7)))
    (define L.fun/void105581.10 (lambda () (call L.fun/void105582.14)))
    (define L.fun/error105580.11 (lambda () 31038))
    (define L.fun/error105574.12 (lambda () (call L.fun/error105575.6)))
    (define L.fun/error105577.13 (lambda () 55358))
    (define L.fun/void105582.14 (lambda () 30))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char105572.9))
      (set! error1.5 (call L.fun/error105574.12))
      (set! error2.4 (call L.fun/error105576.8))
      (set! boolean3.3
        (begin
          (set! tmp.57 (call L.fun/any105578.4))
          (call L.boolean?.16 tmp.57)))
      (set! error4.2 (call L.fun/error105579.5))
      (set! void5.1 (call L.fun/void105581.10))
      void5.1)))
(check-by-interp
 '(module
    (define L.ascii-char?.16
      (lambda (tmp.47)
        (if (begin (set! tmp.56 (bitwise-and tmp.47 255)) (= tmp.56 46))
          14
          6)))
    (define L.fun/void121813.4 (lambda () 30))
    (define L.fun/ascii-char121818.5
      (lambda () (call L.fun/ascii-char121819.11)))
    (define L.fun/void121814.6 (lambda () (call L.fun/void121815.12)))
    (define L.fun/ascii-char121816.7
      (lambda () (call L.fun/ascii-char121817.9)))
    (define L.fun/void121812.8 (lambda () (call L.fun/void121813.4)))
    (define L.fun/ascii-char121817.9 (lambda () 25390))
    (define L.fun/ascii-char121811.10 (lambda () 25390))
    (define L.fun/ascii-char121819.11 (lambda () 25390))
    (define L.fun/void121815.12 (lambda () 30))
    (define L.fun/ascii-char121810.13
      (lambda () (call L.fun/ascii-char121811.10)))
    (define L.fun/any121809.14 (lambda () 6))
    (begin
      (set! boolean0.6
        (begin
          (set! tmp.57 (call L.fun/any121809.14))
          (call L.ascii-char?.16 tmp.57)))
      (set! ascii-char1.5 (call L.fun/ascii-char121810.13))
      (set! void2.4 (call L.fun/void121812.8))
      (set! void3.3 (call L.fun/void121814.6))
      (set! ascii-char4.2 (call L.fun/ascii-char121816.7))
      (set! ascii-char5.1 (call L.fun/ascii-char121818.5))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
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
    (define L.-.13
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
    (define L.fun/error128005.4 (lambda () (call L.fun/error128006.9)))
    (define L.fun/empty128002.5 (lambda () 22))
    (define L.fun/void128004.6 (lambda () 30))
    (define L.fun/empty128001.7 (lambda () (call L.fun/empty128002.5)))
    (define L.fun/empty128008.8 (lambda () 22))
    (define L.fun/error128006.9 (lambda () 9278))
    (define L.fun/empty128007.10 (lambda () (call L.fun/empty128008.8)))
    (define L.fun/void128003.11 (lambda () (call L.fun/void128004.6)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.13 1312 1144))
                  (begin
                    (set! tmp.72 (call L.*.14 1080 2016))
                    (call L.*.14 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.15 40 1384))
                    (begin
                      (set! tmp.75 (call L.*.14 1872 1832))
                      (call L.*.14 tmp.74 tmp.75))))
                (call L.*.14 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.13 1008 264))
                    (begin
                      (set! tmp.79 (call L.-.13 1376 952))
                      (call L.*.14 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.13 1376 464))
                      (begin
                        (set! tmp.82 (call L.-.13 776 656))
                        (call L.*.14 tmp.81 tmp.82))))
                  (call L.*.14 tmp.77 tmp.80))))
            (call L.-.13 tmp.69 tmp.76))))
      (set! empty1.5 (call L.fun/empty128001.7))
      (set! void2.4 (call L.fun/void128003.11))
      (set! error3.3 (call L.fun/error128005.4))
      (set! fixnum4.2
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.14 816 928))
                  (begin
                    (set! tmp.86 (call L.+.15 1728 824))
                    (call L.*.14 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.+.15 1480 1736))
                    (begin
                      (set! tmp.89 (call L.*.14 1816 776))
                      (call L.*.14 tmp.88 tmp.89))))
                (call L.+.15 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.+.15 1272 1104))
                    (begin
                      (set! tmp.93 (call L.-.13 1912 1264))
                      (call L.-.13 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.-.13 1968 848))
                      (begin
                        (set! tmp.96 (call L.-.13 1560 8))
                        (call L.*.14 tmp.95 tmp.96))))
                  (call L.-.13 tmp.91 tmp.94))))
            (call L.-.13 tmp.83 tmp.90))))
      (set! empty5.1 (call L.fun/empty128007.10))
      empty5.1)))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.23 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.18
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
    (define L.-.17
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
    (define L.fun/ascii-char138303.4 (lambda () 25390))
    (define L.fun/empty138301.5 (lambda () 22))
    (define L.fun/empty138304.6 (lambda () (call L.fun/empty138305.13)))
    (define L.fun/empty138307.7 (lambda () 22))
    (define L.fun/empty138306.8 (lambda () (call L.fun/empty138307.7)))
    (define L.fun/ascii-char138302.9
      (lambda () (call L.fun/ascii-char138303.4)))
    (define L.fun/ascii-char138308.10
      (lambda () (call L.fun/ascii-char138309.12)))
    (define L.fun/error138310.11 (lambda () (call L.fun/error138311.15)))
    (define L.fun/ascii-char138309.12 (lambda () 25390))
    (define L.fun/empty138305.13 (lambda () 22))
    (define L.fun/empty138300.14 (lambda () (call L.fun/empty138301.5)))
    (define L.fun/error138311.15 (lambda () 28990))
    (begin
      (set! empty0.6 (call L.fun/empty138300.14))
      (set! ascii-char1.5 (call L.fun/ascii-char138302.9))
      (set! empty2.4 (call L.fun/empty138304.6))
      (set! empty3.3 (call L.fun/empty138306.8))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.-.17 2024 1600))
                  (begin
                    (set! tmp.72 (call L.*.18 1728 376))
                    (call L.+.19 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.18 1504 272))
                    (begin
                      (set! tmp.75 (call L.*.18 360 72))
                      (call L.-.17 tmp.74 tmp.75))))
                (call L.*.18 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.17 1984 1448))
                    (begin
                      (set! tmp.79 (call L.*.18 1992 24))
                      (call L.*.18 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.19 856 1576))
                      (begin
                        (set! tmp.82 (call L.-.17 1424 256))
                        (call L.*.18 tmp.81 tmp.82))))
                  (call L.+.19 tmp.77 tmp.80))))
            (call L.*.18 tmp.69 tmp.76))))
      (set! ascii-char5.1 (call L.fun/ascii-char138308.10))
      (call L.fun/error138310.11))))
(check-by-interp
 '(module
    (define L.boolean?.19
      (lambda (tmp.44)
        (if (begin (set! tmp.56 (bitwise-and tmp.44 247)) (= tmp.56 6)) 14 6)))
    (define L.+.18
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
    (define L.-.17
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
    (define L.*.16
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
    (define L.fixnum?.15
      (lambda (tmp.43)
        (if (begin (set! tmp.70 (bitwise-and tmp.43 7)) (= tmp.70 0)) 14 6)))
    (define L.fun/error139284.4 (lambda () 15934))
    (define L.fun/ascii-char139281.5
      (lambda () (call L.fun/ascii-char139282.10)))
    (define L.fun/error139283.6 (lambda () (call L.fun/error139284.4)))
    (define L.fun/void139290.7 (lambda () 30))
    (define L.fun/any139288.8 (lambda () 13886))
    (define L.fun/empty139287.9 (lambda () 22))
    (define L.fun/ascii-char139282.10 (lambda () 25390))
    (define L.fun/any139285.11 (lambda () 22))
    (define L.fun/void139289.12 (lambda () (call L.fun/void139290.7)))
    (define L.fun/empty139286.13 (lambda () (call L.fun/empty139287.9)))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char139281.5))
      (set! error1.5 (call L.fun/error139283.6))
      (set! boolean2.4
        (begin
          (set! tmp.71 (call L.fun/any139285.11))
          (call L.fixnum?.15 tmp.71)))
      (set! empty3.3 (call L.fun/empty139286.13))
      (set! fixnum4.2
        (begin
          (set! tmp.72
            (begin
              (set! tmp.73
                (begin
                  (set! tmp.74 (call L.*.16 1960 1832))
                  (begin
                    (set! tmp.75 (call L.-.17 1680 768))
                    (call L.-.17 tmp.74 tmp.75))))
              (begin
                (set! tmp.76
                  (begin
                    (set! tmp.77 (call L.-.17 856 1520))
                    (begin
                      (set! tmp.78 (call L.*.16 1264 1096))
                      (call L.-.17 tmp.77 tmp.78))))
                (call L.+.18 tmp.73 tmp.76))))
          (begin
            (set! tmp.79
              (begin
                (set! tmp.80
                  (begin
                    (set! tmp.81 (call L.+.18 160 96))
                    (begin
                      (set! tmp.82 (call L.-.17 696 240))
                      (call L.*.16 tmp.81 tmp.82))))
                (begin
                  (set! tmp.83
                    (begin
                      (set! tmp.84 (call L.*.16 880 1704))
                      (begin
                        (set! tmp.85 (call L.*.16 1696 1640))
                        (call L.-.17 tmp.84 tmp.85))))
                  (call L.+.18 tmp.80 tmp.83))))
            (call L.+.18 tmp.72 tmp.79))))
      (set! boolean5.1
        (begin
          (set! tmp.86 (call L.fun/any139288.8))
          (call L.boolean?.19 tmp.86)))
      (call L.fun/void139289.12))))
(check-by-interp
 '(module
    (define L.-.11
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
    (define L.+.10
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.23 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.22 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.9
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.64
                (if (begin (set! tmp.65 (bitwise-and tmp.21 7)) (= tmp.65 0))
                  14
                  6))
              (!= tmp.64 6))
          (if (begin
                (set! tmp.66
                  (if (begin (set! tmp.67 (bitwise-and tmp.20 7)) (= tmp.67 0))
                    14
                    6))
                (!= tmp.66 6))
            (begin
              (set! tmp.68 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.68))
            318)
          318)))
    (define L.fun/void140574.4 (lambda () 30))
    (define L.fun/empty140576.5 (lambda () 22))
    (define L.fun/empty140575.6 (lambda () (call L.fun/empty140576.5)))
    (define L.fun/void140573.7 (lambda () (call L.fun/void140574.4)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.9 1776 336))
                  (begin
                    (set! tmp.72 (call L.+.10 728 728))
                    (call L.*.9 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.10 1176 1264))
                    (begin
                      (set! tmp.75 (call L.-.11 496 984))
                      (call L.*.9 tmp.74 tmp.75))))
                (call L.-.11 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.10 1520 1616))
                    (begin
                      (set! tmp.79 (call L.+.10 24 1392))
                      (call L.+.10 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.10 824 1456))
                      (begin
                        (set! tmp.82 (call L.+.10 1952 240))
                        (call L.-.11 tmp.81 tmp.82))))
                  (call L.-.11 tmp.77 tmp.80))))
            (call L.*.9 tmp.69 tmp.76))))
      (set! fixnum1.5
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.9 1424 816))
                  (begin
                    (set! tmp.86 (call L.-.11 784 1520))
                    (call L.+.10 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.-.11 2032 1680))
                    (begin
                      (set! tmp.89 (call L.*.9 1776 328))
                      (call L.+.10 tmp.88 tmp.89))))
                (call L.*.9 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.+.10 2000 1216))
                    (begin
                      (set! tmp.93 (call L.+.10 1928 1280))
                      (call L.-.11 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.-.11 120 488))
                      (begin
                        (set! tmp.96 (call L.-.11 1032 280))
                        (call L.-.11 tmp.95 tmp.96))))
                  (call L.+.10 tmp.91 tmp.94))))
            (call L.+.10 tmp.83 tmp.90))))
      (set! fixnum2.4
        (begin
          (set! tmp.97
            (begin
              (set! tmp.98
                (begin
                  (set! tmp.99 (call L.+.10 888 1984))
                  (begin
                    (set! tmp.100 (call L.-.11 1024 888))
                    (call L.*.9 tmp.99 tmp.100))))
              (begin
                (set! tmp.101
                  (begin
                    (set! tmp.102 (call L.+.10 504 8))
                    (begin
                      (set! tmp.103 (call L.*.9 512 1544))
                      (call L.+.10 tmp.102 tmp.103))))
                (call L.-.11 tmp.98 tmp.101))))
          (begin
            (set! tmp.104
              (begin
                (set! tmp.105
                  (begin
                    (set! tmp.106 (call L.*.9 288 760))
                    (begin
                      (set! tmp.107 (call L.-.11 880 960))
                      (call L.+.10 tmp.106 tmp.107))))
                (begin
                  (set! tmp.108
                    (begin
                      (set! tmp.109 (call L.+.10 1000 1288))
                      (begin
                        (set! tmp.110 (call L.+.10 1744 48))
                        (call L.*.9 tmp.109 tmp.110))))
                  (call L.-.11 tmp.105 tmp.108))))
            (call L.*.9 tmp.97 tmp.104))))
      (set! void3.3 (call L.fun/void140573.7))
      (set! fixnum4.2
        (begin
          (set! tmp.111
            (begin
              (set! tmp.112
                (begin
                  (set! tmp.113 (call L.-.11 1272 1960))
                  (begin
                    (set! tmp.114 (call L.-.11 1632 648))
                    (call L.-.11 tmp.113 tmp.114))))
              (begin
                (set! tmp.115
                  (begin
                    (set! tmp.116 (call L.-.11 712 1632))
                    (begin
                      (set! tmp.117 (call L.*.9 216 552))
                      (call L.-.11 tmp.116 tmp.117))))
                (call L.-.11 tmp.112 tmp.115))))
          (begin
            (set! tmp.118
              (begin
                (set! tmp.119
                  (begin
                    (set! tmp.120 (call L.-.11 1944 1296))
                    (begin
                      (set! tmp.121 (call L.+.10 1872 1872))
                      (call L.+.10 tmp.120 tmp.121))))
                (begin
                  (set! tmp.122
                    (begin
                      (set! tmp.123 (call L.+.10 1128 1744))
                      (begin
                        (set! tmp.124 (call L.*.9 944 480))
                        (call L.-.11 tmp.123 tmp.124))))
                  (call L.-.11 tmp.119 tmp.122))))
            (call L.-.11 tmp.111 tmp.118))))
      (set! empty5.1 (call L.fun/empty140575.6))
      void3.3)))
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
    (define L.fun/error143927.4 (lambda () (call L.fun/error143928.6)))
    (define L.fun/ascii-char143929.5
      (lambda () (call L.fun/ascii-char143930.11)))
    (define L.fun/error143928.6 (lambda () 10814))
    (define L.fun/void143926.7 (lambda () 30))
    (define L.fun/void143924.8 (lambda () 30))
    (define L.fun/void143923.9 (lambda () (call L.fun/void143924.8)))
    (define L.fun/void143925.10 (lambda () (call L.fun/void143926.7)))
    (define L.fun/ascii-char143930.11 (lambda () 25390))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.13 544 1392))
                  (begin
                    (set! tmp.72 (call L.*.14 360 1344))
                    (call L.-.15 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.15 1888 288))
                    (begin
                      (set! tmp.75 (call L.-.15 968 800))
                      (call L.*.14 tmp.74 tmp.75))))
                (call L.*.14 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.14 32 912))
                    (begin
                      (set! tmp.79 (call L.+.13 688 1744))
                      (call L.-.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.15 304 568))
                      (begin
                        (set! tmp.82 (call L.*.14 1344 256))
                        (call L.*.14 tmp.81 tmp.82))))
                  (call L.+.13 tmp.77 tmp.80))))
            (call L.*.14 tmp.69 tmp.76))))
      (set! fixnum1.5
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.+.13 1648 1384))
                  (begin
                    (set! tmp.86 (call L.*.14 1664 488))
                    (call L.*.14 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.+.13 1624 192))
                    (begin
                      (set! tmp.89 (call L.*.14 1080 416))
                      (call L.+.13 tmp.88 tmp.89))))
                (call L.+.13 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.+.13 1936 1496))
                    (begin
                      (set! tmp.93 (call L.+.13 344 80))
                      (call L.-.15 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.*.14 1728 1656))
                      (begin
                        (set! tmp.96 (call L.*.14 1040 1408))
                        (call L.-.15 tmp.95 tmp.96))))
                  (call L.+.13 tmp.91 tmp.94))))
            (call L.*.14 tmp.83 tmp.90))))
      (set! void2.4 (call L.fun/void143923.9))
      (set! void3.3 (call L.fun/void143925.10))
      (set! error4.2 (call L.fun/error143927.4))
      (set! fixnum5.1
        (begin
          (set! tmp.97
            (begin
              (set! tmp.98
                (begin
                  (set! tmp.99 (call L.-.15 464 1064))
                  (begin
                    (set! tmp.100 (call L.*.14 664 1200))
                    (call L.-.15 tmp.99 tmp.100))))
              (begin
                (set! tmp.101
                  (begin
                    (set! tmp.102 (call L.*.14 1152 848))
                    (begin
                      (set! tmp.103 (call L.*.14 448 1976))
                      (call L.+.13 tmp.102 tmp.103))))
                (call L.-.15 tmp.98 tmp.101))))
          (begin
            (set! tmp.104
              (begin
                (set! tmp.105
                  (begin
                    (set! tmp.106 (call L.+.13 16 128))
                    (begin
                      (set! tmp.107 (call L.+.13 1704 88))
                      (call L.-.15 tmp.106 tmp.107))))
                (begin
                  (set! tmp.108
                    (begin
                      (set! tmp.109 (call L.*.14 1280 472))
                      (begin
                        (set! tmp.110 (call L.+.13 472 752))
                        (call L.-.15 tmp.109 tmp.110))))
                  (call L.+.13 tmp.105 tmp.108))))
            (call L.+.13 tmp.97 tmp.104))))
      (call L.fun/ascii-char143929.5))))
