#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../normalize-bind.rkt"))
(define (fail-if-invalid p)
  (when (not (proc-imp-cmf-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "proc-imp-cmf-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-imp-mf-lang-v8 p)
  (interp-proc-imp-cmf-lang-v8 (fail-if-invalid (normalize-bind p))))

(check-by-interp '(module 24894))
(check-by-interp '(module 22))
(check-by-interp
 '(module (define L.fun/void8390.4 (lambda () 30)) (call L.fun/void8390.4)))
(check-by-interp '(module (begin (set! empty0.1 22) 21310)))
(check-by-interp
 '(module (begin (set! void0.2 30) (set! ascii-char1.1 25390) 576)))
(check-by-interp
 '(module
    (define L.fun/void8397.4 (lambda (oprand0.1) 30))
    (begin
      (set! tmp.53 (begin (set! ascii-char0.3 25390) (set! boolean1.2 6) 14))
      (call L.fun/void8397.4 tmp.53))))
(check-by-interp '(module (if (!= 14 6) 18494 57406)))
(check-by-interp '(module (if (!= 6 6) 25390 25390)))
(check-by-interp '(module (if (!= 14 6) 240 224)))
(check-by-interp
 '(module (begin (set! empty0.2 22) (set! ascii-char1.1 25390) 30)))
(check-by-interp
 '(module
    (define L.fun/error8412.4 (lambda (oprand0.1) 29758))
    (begin
      (set! tmp.53 (begin (set! void0.3 30) (set! error1.2 38974) error1.2))
      (call L.fun/error8412.4 tmp.53))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8415.4 (lambda (oprand0.1) 25390))
    (begin
      (set! tmp.53
        (begin (set! ascii-char0.3 25390) (set! error1.2 29502) 25390))
      (call L.fun/ascii-char8415.4 tmp.53))))
(check-by-interp
 '(module
    (define L.-.8
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
    (define L.+.7
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
            (+ tmp.19 tmp.20)
            574)
          574)))
    (define L.fun/empty8418.4 (lambda () 22))
    (define L.fun/ascii-char8419.5 (lambda () 25390))
    (begin
      (set! fixnum0.3 (call L.+.7 760 912))
      (set! fixnum1.2 (call L.-.8 384 1664))
      (set! empty2.1 (call L.fun/empty8418.4))
      (call L.fun/ascii-char8419.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8467.4 (lambda (oprand0.2 oprand1.1) oprand0.2))
    (define L.fun/void8469.5 (lambda (oprand0.4 oprand1.3) 30))
    (define L.fun/empty8468.6 (lambda (oprand0.6 oprand1.5) 22))
    (begin
      (set! tmp.59
        (begin
          (set! ascii-char0.9 25390)
          (set! empty1.8 22)
          (set! error2.7 15166)
          25390))
      (begin
        (set! tmp.60
          (begin
            (set! tmp.61 (call L.fun/void8469.5 30 6))
            (begin
              (set! tmp.62 (if (!= 6 6) 43582 65086))
              (call L.fun/empty8468.6 tmp.61 tmp.62))))
        (call L.fun/ascii-char8467.4 tmp.59 tmp.60)))))
(check-by-interp
 '(module
    (define L.*.6
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
    (define L.-.5
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.58
                (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                  14
                  6))
              (!= tmp.58 6))
          (if (begin
                (set! tmp.60
                  (if (begin (set! tmp.61 (bitwise-and tmp.21 7)) (= tmp.61 0))
                    14
                    6))
                (!= tmp.60 6))
            (- tmp.21 tmp.22)
            830)
          830)))
    (begin
      (set! tmp.62
        (begin
          (set! tmp.63 (if (!= 6 6) 1712 688))
          (begin
            (set! tmp.64 (if (!= 14 6) 1480 128))
            (call L.-.5 tmp.63 tmp.64))))
      (begin
        (set! tmp.65
          (begin
            (set! tmp.66 (if (!= 6 6) 352 264))
            (begin
              (set! tmp.67
                (begin
                  (set! ascii-char0.3 25390)
                  (set! error1.2 13118)
                  (set! empty2.1 22)
                  608))
              (call L.-.5 tmp.66 tmp.67))))
        (call L.*.6 tmp.62 tmp.65)))))
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
    (define L.-.7
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.58
                (if (begin (set! tmp.59 (bitwise-and tmp.22 7)) (= tmp.59 0))
                  14
                  6))
              (!= tmp.58 6))
          (if (begin
                (set! tmp.60
                  (if (begin (set! tmp.61 (bitwise-and tmp.21 7)) (= tmp.61 0))
                    14
                    6))
                (!= tmp.60 6))
            (- tmp.21 tmp.22)
            830)
          830)))
    (define L.vector?.6
      (lambda (tmp.47)
        (if (begin (set! tmp.62 (bitwise-and tmp.47 7)) (= tmp.62 3)) 14 6)))
    (define L.fun/any8734.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 41278))
    (if (begin
          (set! tmp.63
            (begin
              (set! tmp.64 (call L.fun/any8734.4 5950 22 25390))
              (call L.vector?.6 tmp.64)))
          (!= tmp.63 6))
      (begin
        (set! tmp.65 (call L.-.7 1480 528))
        (begin
          (set! tmp.66 (if (!= 14 6) 1488 1392))
          (call L.*.8 tmp.65 tmp.66)))
      (if (!= 14 6) 1552 1376))))
(check-by-interp
 '(module
    (define L.fun/void8780.4 (lambda () 30))
    (define L.fun/ascii-char8782.5 (lambda () 25390))
    (define L.fun/void8781.6 (lambda () 30))
    (define L.fun/error8783.7 (lambda () 35646))
    (define L.fun/void8779.8 (lambda () 30))
    (begin
      (set! void0.4 (call L.fun/void8779.8))
      (set! void1.3 (call L.fun/void8780.4))
      (set! void2.2 (call L.fun/void8781.6))
      (set! ascii-char3.1 (call L.fun/ascii-char8782.5))
      (call L.fun/error8783.7))))
(check-by-interp
 '(module
    (define L.*.10
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
    (define L.+.9
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.59
                (if (begin (set! tmp.60 (bitwise-and tmp.21 7)) (= tmp.60 0))
                  14
                  6))
              (!= tmp.59 6))
          (if (begin
                (set! tmp.61
                  (if (begin (set! tmp.62 (bitwise-and tmp.20 7)) (= tmp.62 0))
                    14
                    6))
                (!= tmp.61 6))
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.-.8
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.63
                (if (begin (set! tmp.64 (bitwise-and tmp.23 7)) (= tmp.64 0))
                  14
                  6))
              (!= tmp.63 6))
          (if (begin
                (set! tmp.65
                  (if (begin (set! tmp.66 (bitwise-and tmp.22 7)) (= tmp.66 0))
                    14
                    6))
                (!= tmp.65 6))
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.fun/empty8806.4 (lambda () 22))
    (define L.fun/void8807.5 (lambda () 30))
    (define L.fun/ascii-char8808.6 (lambda () 25390))
    (begin
      (set! empty0.4 (call L.fun/empty8806.4))
      (set! fixnum1.3
        (begin
          (set! tmp.67 (call L.-.8 1608 864))
          (begin
            (set! tmp.68 (call L.+.9 328 352))
            (call L.-.8 tmp.67 tmp.68))))
      (set! fixnum2.2
        (begin
          (set! tmp.69 (call L.*.10 320 1048))
          (begin
            (set! tmp.70 (call L.*.10 1096 968))
            (call L.-.8 tmp.69 tmp.70))))
      (set! void3.1 (call L.fun/void8807.5))
      (call L.fun/ascii-char8808.6))))
(check-by-interp
 '(module
    (define L.error?.16
      (lambda (tmp.59)
        (if (begin (set! tmp.67 (bitwise-and tmp.59 255)) (= tmp.67 62))
          14
          6)))
    (define L.fixnum?.15
      (lambda (tmp.54)
        (if (begin (set! tmp.68 (bitwise-and tmp.54 7)) (= tmp.68 0)) 14 6)))
    (define L.+.14
      (lambda (tmp.33 tmp.34)
        (if (begin
              (set! tmp.69
                (if (begin (set! tmp.70 (bitwise-and tmp.34 7)) (= tmp.70 0))
                  14
                  6))
              (!= tmp.69 6))
          (if (begin
                (set! tmp.71
                  (if (begin (set! tmp.72 (bitwise-and tmp.33 7)) (= tmp.72 0))
                    14
                    6))
                (!= tmp.71 6))
            (+ tmp.33 tmp.34)
            574)
          574)))
    (define L.vector?.13
      (lambda (tmp.61)
        (if (begin (set! tmp.73 (bitwise-and tmp.61 7)) (= tmp.73 3)) 14 6)))
    (define L.fun/empty9034.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 22))
    (define L.fun/error9036.5 (lambda () 47166))
    (define L.fun/error9035.6 (lambda () 36414))
    (define L.fun/void9037.7 (lambda () 30))
    (define L.fun/ascii-char9032.8 (lambda () 25390))
    (define L.fun/empty9038.9 (lambda () 22))
    (define L.fun/ascii-char9031.10
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call L.fun/ascii-char9032.8)))
    (define L.fun/boolean9033.11 (lambda (oprand0.9 oprand1.8 oprand2.7) 14))
    (begin
      (set! tmp.74
        (if (begin
              (set! tmp.75 (call L.fun/boolean9033.11 25390 44094 25390))
              (!= tmp.75 6))
          (if (!= 6 6) 22 22)
          (call L.fun/empty9034.4 4158 59454 14)))
      (begin
        (set! tmp.76
          (begin
            (set! boolean0.13 (call L.vector?.13 25390))
            (set! fixnum1.12 (call L.+.14 224 192))
            (set! error2.11 (call L.fun/error9035.6))
            (set! error3.10 (call L.fun/error9036.5))
            (call L.fixnum?.15 30)))
        (begin
          (set! tmp.77
            (begin
              (set! ascii-char0.17 (call L.fun/ascii-char9031.10 22 6 14))
              (set! void1.16 (call L.fun/void9037.7))
              (set! ascii-char2.15 (call L.fun/ascii-char9031.10 22 14 6))
              (set! empty3.14 (call L.fun/empty9038.9))
              (call L.error?.16 30)))
          (call L.fun/ascii-char9031.10 tmp.74 tmp.76 tmp.77))))))
(check-by-interp
 '(module
    (define L.fun/void9076.4 (lambda () 30))
    (define L.fun/ascii-char9078.5 (lambda () 25390))
    (define L.fun/error9075.6 (lambda () 57662))
    (define L.fun/empty9077.7 (lambda () 22))
    (begin
      (set! error0.4 (call L.fun/error9075.6))
      (set! void1.3 (call L.fun/void9076.4))
      (set! empty2.2 (call L.fun/empty9077.7))
      (set! ascii-char3.1 (call L.fun/ascii-char9078.5))
      empty2.2)))
(check-by-interp
 '(module
    (if (if (!= 6 6) (!= 14 6) (!= 14 6))
      (begin
        (set! fixnum0.4 1720)
        (set! fixnum1.3 984)
        (set! void2.2 30)
        (set! ascii-char3.1 25390)
        fixnum0.4)
      (if (!= 6 6) 1448 1416))))
(check-by-interp
 '(module
    (define L.boolean?.10
      (lambda (tmp.42)
        (if (begin (set! tmp.54 (bitwise-and tmp.42 247)) (= tmp.54 6)) 14 6)))
    (define L.fun/error9365.4 (lambda () 62014))
    (define L.fun/error9364.5 (lambda () 63806))
    (define L.fun/any9366.6 (lambda () 14))
    (define L.fun/error9363.7 (lambda () 60990))
    (define L.fun/empty9362.8 (lambda () 22))
    (begin
      (set! empty0.4 (call L.fun/empty9362.8))
      (set! error1.3 (call L.fun/error9363.7))
      (set! error2.2 (call L.fun/error9364.5))
      (set! error3.1 (call L.fun/error9365.4))
      (begin
        (set! tmp.55 (call L.fun/any9366.6))
        (call L.boolean?.10 tmp.55)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9574.4 (lambda () 25390))
    (define L.fun/void9575.5 (lambda () 30))
    (define L.fun/void9573.6 (lambda () 30))
    (define L.fun/empty9572.7 (lambda () 22))
    (begin
      (set! empty0.4 (call L.fun/empty9572.7))
      (set! void1.3 (call L.fun/void9573.6))
      (set! ascii-char2.2 (call L.fun/ascii-char9574.4))
      (set! void3.1 (call L.fun/void9575.5))
      void1.3)))
(check-by-interp
 '(module
    (if (begin
          (set! empty0.4 22)
          (set! fixnum1.3 968)
          (set! void2.2 30)
          (set! fixnum3.1 896)
          (!= 6 6))
      (if (!= 14 6) 22 22)
      (begin
        (set! empty0.8 22)
        (set! error1.7 42302)
        (set! void2.6 30)
        (set! fixnum3.5 992)
        22))))
(check-by-interp
 '(module
    (define L.-.9
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
    (define L.*.8
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
    (define L.fun/ascii-char9904.4 (lambda () 25390))
    (define L.fun/void9902.5 (lambda () 30))
    (define L.fun/ascii-char9903.6 (lambda () 25390))
    (begin
      (set! void0.4 (call L.fun/void9902.5))
      (set! ascii-char1.3 (call L.fun/ascii-char9903.6))
      (set! fixnum2.2
        (begin
          (set! tmp.63 (call L.*.8 504 1592))
          (begin
            (set! tmp.64 (call L.*.8 552 1320))
            (call L.-.9 tmp.63 tmp.64))))
      (set! ascii-char3.1 (call L.fun/ascii-char9904.4))
      void0.4)))
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
    (define L.fun/void10674.4 (lambda () 30))
    (define L.fun/error10675.5 (lambda () 64318))
    (define L.fun/void10672.6 (lambda () 30))
    (define L.fun/empty10673.7 (lambda () 22))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.+.9 1112 1560))
              (begin
                (set! tmp.70 (call L.-.10 904 704))
                (call L.+.9 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.+.9 216 744))
                (begin
                  (set! tmp.73 (call L.-.10 1832 1952))
                  (call L.-.10 tmp.72 tmp.73))))
            (call L.-.10 tmp.68 tmp.71))))
      (set! void1.4 (call L.fun/void10672.6))
      (set! empty2.3 (call L.fun/empty10673.7))
      (set! void3.2 (call L.fun/void10674.4))
      (set! fixnum4.1
        (begin
          (set! tmp.74
            (begin
              (set! tmp.75 (call L.*.11 760 1024))
              (begin
                (set! tmp.76 (call L.+.9 1344 160))
                (call L.-.10 tmp.75 tmp.76))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78 (call L.*.11 1136 648))
                (begin
                  (set! tmp.79 (call L.*.11 736 224))
                  (call L.-.10 tmp.78 tmp.79))))
            (call L.-.10 tmp.74 tmp.77))))
      (call L.fun/error10675.5))))
(check-by-interp
 '(module
    (define L.-.11
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
    (define L.+.10
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
    (define L.ascii-char?.9
      (lambda (tmp.46)
        (if (begin (set! tmp.63 (bitwise-and tmp.46 255)) (= tmp.63 46))
          14
          6)))
    (define L.fun/any10855.4 (lambda () 25390))
    (define L.fun/ascii-char10854.5 (lambda () 25390))
    (define L.fun/empty10856.6 (lambda () 22))
    (define L.fun/void10857.7 (lambda () 30))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char10854.5))
      (set! boolean1.4
        (begin
          (set! tmp.64 (call L.fun/any10855.4))
          (call L.ascii-char?.9 tmp.64)))
      (set! empty2.3 (call L.fun/empty10856.6))
      (set! fixnum3.2
        (begin
          (set! tmp.65
            (begin
              (set! tmp.66 (call L.+.10 1352 784))
              (begin
                (set! tmp.67 (call L.-.11 8 1792))
                (call L.-.11 tmp.66 tmp.67))))
          (begin
            (set! tmp.68
              (begin
                (set! tmp.69 (call L.-.11 112 992))
                (begin
                  (set! tmp.70 (call L.+.10 1104 48))
                  (call L.+.10 tmp.69 tmp.70))))
            (call L.+.10 tmp.65 tmp.68))))
      (set! void4.1 (call L.fun/void10857.7))
      empty2.3)))
(check-by-interp
 '(module
    (define L.fun/void11402.4 (lambda () 30))
    (define L.fun/ascii-char11403.5 (lambda () 25390))
    (define L.fun/ascii-char11400.6 (lambda () 25390))
    (define L.fun/error11401.7 (lambda () 15166))
    (define L.fun/ascii-char11399.8 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char11399.8))
      (set! ascii-char1.4 (call L.fun/ascii-char11400.6))
      (set! error2.3 (call L.fun/error11401.7))
      (set! void3.2 (call L.fun/void11402.4))
      (set! ascii-char4.1 (call L.fun/ascii-char11403.5))
      void3.2)))
(check-by-interp
 '(module
    (define L.fun/void13621.4 (lambda () 30))
    (define L.fun/ascii-char13620.5 (lambda () 25390))
    (define L.fun/empty13623.6 (lambda () 22))
    (define L.fun/error13618.7 (lambda () 22846))
    (define L.fun/void13619.8 (lambda () 30))
    (define L.fun/error13622.9 (lambda () 25150))
    (begin
      (set! error0.5 (call L.fun/error13618.7))
      (set! void1.4 (call L.fun/void13619.8))
      (set! ascii-char2.3 (call L.fun/ascii-char13620.5))
      (set! void3.2 (call L.fun/void13621.4))
      (set! error4.1 (call L.fun/error13622.9))
      (call L.fun/empty13623.6))))
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
    (define L.fun/void14228.4 (lambda () 30))
    (define L.fun/empty14229.5 (lambda () 22))
    (define L.fun/ascii-char14227.6 (lambda () 25390))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.8 1512 1328))
              (begin
                (set! tmp.70 (call L.*.8 1088 1096))
                (call L.+.9 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.-.10 1528 832))
                (begin
                  (set! tmp.73 (call L.*.8 192 1744))
                  (call L.*.8 tmp.72 tmp.73))))
            (call L.+.9 tmp.68 tmp.71))))
      (set! ascii-char1.4 (call L.fun/ascii-char14227.6))
      (set! fixnum2.3
        (begin
          (set! tmp.74
            (begin
              (set! tmp.75 (call L.+.9 880 1440))
              (begin
                (set! tmp.76 (call L.-.10 632 320))
                (call L.-.10 tmp.75 tmp.76))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78 (call L.-.10 1688 360))
                (begin
                  (set! tmp.79 (call L.+.9 1800 1952))
                  (call L.-.10 tmp.78 tmp.79))))
            (call L.*.8 tmp.74 tmp.77))))
      (set! void3.2 (call L.fun/void14228.4))
      (set! empty4.1 (call L.fun/empty14229.5))
      empty4.1)))
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
    (define L.fun/void14544.4 (lambda () 30))
    (define L.fun/empty14543.5 (lambda () 22))
    (define L.fun/ascii-char14546.6 (lambda () 25390))
    (define L.fun/error14545.7 (lambda () 62))
    (define L.fun/error14542.8 (lambda () 38462))
    (begin
      (set! error0.5 (call L.fun/error14542.8))
      (set! empty1.4 (call L.fun/empty14543.5))
      (set! fixnum2.3
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.*.10 1248 288))
              (begin
                (set! tmp.70 (call L.*.10 856 552))
                (call L.*.10 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.*.10 824 1056))
                (begin
                  (set! tmp.73 (call L.+.11 608 1720))
                  (call L.+.11 tmp.72 tmp.73))))
            (call L.-.12 tmp.68 tmp.71))))
      (set! void3.2 (call L.fun/void14544.4))
      (set! error4.1 (call L.fun/error14545.7))
      (call L.fun/ascii-char14546.6))))
(check-by-interp
 '(module
    (define L.-.11
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
    (define L.*.10
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
    (define L.fun/empty15112.4 (lambda () 22))
    (define L.fun/error15114.5 (lambda () 11326))
    (define L.fun/empty15111.6 (lambda () 22))
    (define L.fun/ascii-char15115.7 (lambda () 25390))
    (define L.fun/void15113.8 (lambda () 30))
    (begin
      (set! fixnum0.5
        (begin
          (set! tmp.64
            (begin
              (set! tmp.65 (call L.*.10 1304 1392))
              (begin
                (set! tmp.66 (call L.*.10 1800 368))
                (call L.-.11 tmp.65 tmp.66))))
          (begin
            (set! tmp.67
              (begin
                (set! tmp.68 (call L.*.10 1672 1944))
                (begin
                  (set! tmp.69 (call L.-.11 1184 1864))
                  (call L.-.11 tmp.68 tmp.69))))
            (call L.*.10 tmp.64 tmp.67))))
      (set! empty1.4 (call L.fun/empty15111.6))
      (set! empty2.3 (call L.fun/empty15112.4))
      (set! void3.2 (call L.fun/void15113.8))
      (set! error4.1 (call L.fun/error15114.5))
      (call L.fun/ascii-char15115.7))))
(check-by-interp
 '(module
    (define L.fixnum?.11
      (lambda (tmp.42)
        (if (begin (set! tmp.55 (bitwise-and tmp.42 7)) (= tmp.55 0)) 14 6)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (begin
              (set! tmp.56
                (if (begin (set! tmp.57 (bitwise-and tmp.24 7)) (= tmp.57 0))
                  14
                  6))
              (!= tmp.56 6))
          (if (begin
                (set! tmp.58
                  (if (begin (set! tmp.59 (bitwise-and tmp.23 7)) (= tmp.59 0))
                    14
                    6))
                (!= tmp.58 6))
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.22 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.21 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.8
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
    (define L.fun/empty16025.4 (lambda () 22))
    (define L.fun/ascii-char16027.5 (lambda () 25390))
    (define L.fun/any16026.6 (lambda () 30))
    (begin
      (set! empty0.5 (call L.fun/empty16025.4))
      (set! fixnum1.4
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70 (call L.*.8 56 224))
              (begin
                (set! tmp.71 (call L.+.9 336 384))
                (call L.-.10 tmp.70 tmp.71))))
          (begin
            (set! tmp.72
              (begin
                (set! tmp.73 (call L.-.10 1936 672))
                (begin
                  (set! tmp.74 (call L.-.10 1096 1760))
                  (call L.*.8 tmp.73 tmp.74))))
            (call L.-.10 tmp.69 tmp.72))))
      (set! fixnum2.3
        (begin
          (set! tmp.75
            (begin
              (set! tmp.76 (call L.*.8 56 1408))
              (begin
                (set! tmp.77 (call L.*.8 8 528))
                (call L.*.8 tmp.76 tmp.77))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79 (call L.+.9 472 376))
                (begin
                  (set! tmp.80 (call L.-.10 1000 656))
                  (call L.*.8 tmp.79 tmp.80))))
            (call L.*.8 tmp.75 tmp.78))))
      (set! fixnum3.2
        (begin
          (set! tmp.81
            (begin
              (set! tmp.82 (call L.*.8 1064 464))
              (begin
                (set! tmp.83 (call L.*.8 1088 1504))
                (call L.*.8 tmp.82 tmp.83))))
          (begin
            (set! tmp.84
              (begin
                (set! tmp.85 (call L.+.9 1328 1048))
                (begin
                  (set! tmp.86 (call L.*.8 1832 560))
                  (call L.*.8 tmp.85 tmp.86))))
            (call L.+.9 tmp.81 tmp.84))))
      (set! boolean4.1
        (begin
          (set! tmp.87 (call L.fun/any16026.6))
          (call L.fixnum?.11 tmp.87)))
      (call L.fun/ascii-char16027.5))))
(check-by-interp
 '(module
    (define L.*.12
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
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.22 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.21 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
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
    (define L.fun/ascii-char19237.4 (lambda () 25390))
    (define L.fun/ascii-char19236.5 (lambda () 25390))
    (define L.fun/error19239.6 (lambda () 55358))
    (define L.fun/void19235.7 (lambda () 30))
    (define L.fun/error19238.8 (lambda () 21566))
    (begin
      (set! void0.5 (call L.fun/void19235.7))
      (set! ascii-char1.4 (call L.fun/ascii-char19236.5))
      (set! ascii-char2.3 (call L.fun/ascii-char19237.4))
      (set! error3.2 (call L.fun/error19238.8))
      (set! error4.1 (call L.fun/error19239.6))
      (begin
        (set! tmp.68
          (begin
            (set! tmp.69 (call L.-.10 1752 160))
            (begin
              (set! tmp.70 (call L.+.11 456 1232))
              (call L.-.10 tmp.69 tmp.70))))
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72 (call L.-.10 792 1432))
              (begin
                (set! tmp.73 (call L.-.10 1848 1552))
                (call L.*.12 tmp.72 tmp.73))))
          (call L.-.10 tmp.68 tmp.71))))))
(check-by-interp
 '(module
    (define L.*.12
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
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (begin
              (set! tmp.60
                (if (begin (set! tmp.61 (bitwise-and tmp.22 7)) (= tmp.61 0))
                  14
                  6))
              (!= tmp.60 6))
          (if (begin
                (set! tmp.62
                  (if (begin (set! tmp.63 (bitwise-and tmp.21 7)) (= tmp.63 0))
                    14
                    6))
                (!= tmp.62 6))
            (+ tmp.21 tmp.22)
            574)
          574)))
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
    (define L.fun/empty20765.4 (lambda () 22))
    (define L.fun/ascii-char20767.5 (lambda () 25390))
    (define L.fun/ascii-char20768.6 (lambda () 25390))
    (define L.fun/empty20764.7 (lambda () 22))
    (define L.fun/error20766.8 (lambda () 64574))
    (begin
      (set! empty0.5 (call L.fun/empty20764.7))
      (set! empty1.4 (call L.fun/empty20765.4))
      (set! error2.3 (call L.fun/error20766.8))
      (set! ascii-char3.2 (call L.fun/ascii-char20767.5))
      (set! ascii-char4.1 (call L.fun/ascii-char20768.6))
      (begin
        (set! tmp.68
          (begin
            (set! tmp.69 (call L.-.10 1504 1184))
            (begin
              (set! tmp.70 (call L.+.11 1616 1296))
              (call L.-.10 tmp.69 tmp.70))))
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72 (call L.-.10 8 1272))
              (begin
                (set! tmp.73 (call L.*.12 888 528))
                (call L.*.12 tmp.72 tmp.73))))
          (call L.*.12 tmp.68 tmp.71))))))
(check-by-interp
 '(module
    (define L.-.11
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
    (define L.*.10
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
    (define L.fun/ascii-char21096.4 (lambda () 25390))
    (define L.fun/ascii-char21098.5 (lambda () 25390))
    (define L.fun/error21099.6 (lambda () 33086))
    (define L.fun/ascii-char21097.7 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char21096.4))
      (set! fixnum1.4
        (begin
          (set! tmp.68
            (begin
              (set! tmp.69 (call L.+.9 1208 1976))
              (begin
                (set! tmp.70 (call L.*.10 1432 32))
                (call L.+.9 tmp.69 tmp.70))))
          (begin
            (set! tmp.71
              (begin
                (set! tmp.72 (call L.*.10 1400 456))
                (begin
                  (set! tmp.73 (call L.-.11 888 1672))
                  (call L.+.9 tmp.72 tmp.73))))
            (call L.+.9 tmp.68 tmp.71))))
      (set! ascii-char2.3 (call L.fun/ascii-char21097.7))
      (set! ascii-char3.2 (call L.fun/ascii-char21098.5))
      (set! fixnum4.1
        (begin
          (set! tmp.74
            (begin
              (set! tmp.75 (call L.*.10 1032 1800))
              (begin
                (set! tmp.76 (call L.+.9 552 560))
                (call L.-.11 tmp.75 tmp.76))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78 (call L.-.11 1424 368))
                (begin
                  (set! tmp.79 (call L.-.11 864 296))
                  (call L.-.11 tmp.78 tmp.79))))
            (call L.-.11 tmp.74 tmp.77))))
      (call L.fun/error21099.6))))
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
    (define L.fun/void21257.4 (lambda () 30))
    (define L.fun/void21255.5 (lambda () 30))
    (define L.fun/void21256.6 (lambda () 30))
    (define L.fun/ascii-char21254.7 (lambda () 25390))
    (begin
      (set! ascii-char0.5 (call L.fun/ascii-char21254.7))
      (set! void1.4 (call L.fun/void21255.5))
      (set! fixnum2.3
        (begin
          (set! tmp.63
            (begin
              (set! tmp.64 (call L.+.9 1728 736))
              (begin
                (set! tmp.65 (call L.-.10 1624 192))
                (call L.-.10 tmp.64 tmp.65))))
          (begin
            (set! tmp.66
              (begin
                (set! tmp.67 (call L.-.10 160 888))
                (begin
                  (set! tmp.68 (call L.-.10 1968 1920))
                  (call L.+.9 tmp.67 tmp.68))))
            (call L.-.10 tmp.63 tmp.66))))
      (set! void3.2 (call L.fun/void21256.6))
      (set! void4.1 (call L.fun/void21257.4))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/error21502.4 (lambda () 12606))
    (define L.fun/empty21506.5 (lambda () 22))
    (define L.fun/empty21503.6 (lambda () 22))
    (define L.fun/error21505.7 (lambda () 45630))
    (define L.fun/empty21504.8 (lambda () 22))
    (begin
      (set! error0.5 (call L.fun/error21502.4))
      (set! empty1.4 (call L.fun/empty21503.6))
      (set! empty2.3 (call L.fun/empty21504.8))
      (set! error3.2 (call L.fun/error21505.7))
      (set! empty4.1 (call L.fun/empty21506.5))
      error0.5)))
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
    (define L.fun/empty21523.4 (lambda () 22))
    (define L.fun/void21525.5 (lambda () 30))
    (define L.fun/void21524.6 (lambda () 30))
    (define L.fun/void21527.7 (lambda () 30))
    (define L.fun/ascii-char21526.8 (lambda () 25390))
    (begin
      (set! empty0.5 (call L.fun/empty21523.4))
      (set! void1.4 (call L.fun/void21524.6))
      (set! void2.3 (call L.fun/void21525.5))
      (set! ascii-char3.2 (call L.fun/ascii-char21526.8))
      (set! void4.1 (call L.fun/void21527.7))
      (begin
        (set! tmp.68
          (begin
            (set! tmp.69 (call L.*.10 1072 1448))
            (begin
              (set! tmp.70 (call L.-.11 496 1416))
              (call L.-.11 tmp.69 tmp.70))))
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72 (call L.-.11 80 1208))
              (begin
                (set! tmp.73 (call L.-.11 888 1032))
                (call L.+.12 tmp.72 tmp.73))))
          (call L.+.12 tmp.68 tmp.71))))))
(check-by-interp
 '(module
    (define L.fun/void22132.4 (lambda () 30))
    (define L.fun/void22129.5 (lambda () 30))
    (define L.fun/void22131.6 (lambda () 30))
    (define L.fun/empty22130.7 (lambda () 22))
    (define L.fun/ascii-char22133.8 (lambda () 25390))
    (begin
      (set! void0.5 (call L.fun/void22129.5))
      (set! empty1.4 (call L.fun/empty22130.7))
      (set! void2.3 (call L.fun/void22131.6))
      (set! void3.2 (call L.fun/void22132.4))
      (set! ascii-char4.1 (call L.fun/ascii-char22133.8))
      ascii-char4.1)))
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
    (define L.fun/ascii-char35206.4 (lambda () (call L.fun/ascii-char35207.9)))
    (define L.fun/ascii-char35208.5
      (lambda () (call L.fun/ascii-char35209.10)))
    (define L.fun/empty35210.6 (lambda () (call L.fun/empty35211.13)))
    (define L.fun/error35213.7 (lambda () 36414))
    (define L.fun/void35214.8 (lambda () (call L.fun/void35215.11)))
    (define L.fun/ascii-char35207.9 (lambda () 25390))
    (define L.fun/ascii-char35209.10 (lambda () 25390))
    (define L.fun/void35215.11 (lambda () 30))
    (define L.fun/error35212.12 (lambda () (call L.fun/error35213.7)))
    (define L.fun/empty35211.13 (lambda () 22))
    (begin
      (set! ascii-char0.6 (call L.fun/ascii-char35206.4))
      (set! ascii-char1.5 (call L.fun/ascii-char35208.5))
      (set! empty2.4 (call L.fun/empty35210.6))
      (set! error3.3 (call L.fun/error35212.12))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.15 24 112))
                  (begin
                    (set! tmp.72 (call L.+.16 1176 808))
                    (call L.+.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.17 1752 1560))
                    (begin
                      (set! tmp.75 (call L.*.15 40 1400))
                      (call L.+.16 tmp.74 tmp.75))))
                (call L.-.17 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.17 680 1136))
                    (begin
                      (set! tmp.79 (call L.-.17 1016 1040))
                      (call L.-.17 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.17 256 288))
                      (begin
                        (set! tmp.82 (call L.+.16 280 1544))
                        (call L.+.16 tmp.81 tmp.82))))
                  (call L.-.17 tmp.77 tmp.80))))
            (call L.+.16 tmp.69 tmp.76))))
      (set! void5.1 (call L.fun/void35214.8))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.error?.19
      (lambda (tmp.48)
        (if (begin (set! tmp.56 (bitwise-and tmp.48 255)) (= tmp.56 62))
          14
          6)))
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
    (define L.void?.15
      (lambda (tmp.46)
        (if (begin (set! tmp.70 (bitwise-and tmp.46 255)) (= tmp.70 30))
          14
          6)))
    (define L.fun/void43341.4 (lambda () (call L.fun/void43342.11)))
    (define L.fun/empty43339.5 (lambda () 22))
    (define L.fun/any43337.6 (lambda () 13630))
    (define L.fun/any43340.7 (lambda () 480))
    (define L.fun/empty43335.8 (lambda () (call L.fun/empty43336.13)))
    (define L.fun/empty43333.9 (lambda () (call L.fun/empty43334.12)))
    (define L.fun/empty43338.10 (lambda () (call L.fun/empty43339.5)))
    (define L.fun/void43342.11 (lambda () 30))
    (define L.fun/empty43334.12 (lambda () 22))
    (define L.fun/empty43336.13 (lambda () 22))
    (begin
      (set! empty0.6 (call L.fun/empty43333.9))
      (set! empty1.5 (call L.fun/empty43335.8))
      (set! boolean2.4
        (begin (set! tmp.71 (call L.fun/any43337.6)) (call L.void?.15 tmp.71)))
      (set! fixnum3.3
        (begin
          (set! tmp.72
            (begin
              (set! tmp.73
                (begin
                  (set! tmp.74 (call L.*.16 832 704))
                  (begin
                    (set! tmp.75 (call L.-.17 1040 1832))
                    (call L.*.16 tmp.74 tmp.75))))
              (begin
                (set! tmp.76
                  (begin
                    (set! tmp.77 (call L.-.17 952 568))
                    (begin
                      (set! tmp.78 (call L.+.18 1392 1880))
                      (call L.+.18 tmp.77 tmp.78))))
                (call L.+.18 tmp.73 tmp.76))))
          (begin
            (set! tmp.79
              (begin
                (set! tmp.80
                  (begin
                    (set! tmp.81 (call L.*.16 616 456))
                    (begin
                      (set! tmp.82 (call L.-.17 1928 432))
                      (call L.+.18 tmp.81 tmp.82))))
                (begin
                  (set! tmp.83
                    (begin
                      (set! tmp.84 (call L.+.18 400 1376))
                      (begin
                        (set! tmp.85 (call L.*.16 576 1920))
                        (call L.*.16 tmp.84 tmp.85))))
                  (call L.*.16 tmp.80 tmp.83))))
            (call L.+.18 tmp.72 tmp.79))))
      (set! empty4.2 (call L.fun/empty43338.10))
      (set! boolean5.1
        (begin
          (set! tmp.86 (call L.fun/any43340.7))
          (call L.error?.19 tmp.86)))
      (call L.fun/void43341.4))))
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
    (define L.fun/ascii-char44115.4
      (lambda () (call L.fun/ascii-char44116.11)))
    (define L.fun/ascii-char44119.5
      (lambda () (call L.fun/ascii-char44120.10)))
    (define L.fun/empty44111.6 (lambda () (call L.fun/empty44112.13)))
    (define L.fun/void44117.7 (lambda () (call L.fun/void44118.9)))
    (define L.fun/ascii-char44114.8 (lambda () 25390))
    (define L.fun/void44118.9 (lambda () 30))
    (define L.fun/ascii-char44120.10 (lambda () 25390))
    (define L.fun/ascii-char44116.11 (lambda () 25390))
    (define L.fun/ascii-char44113.12
      (lambda () (call L.fun/ascii-char44114.8)))
    (define L.fun/empty44112.13 (lambda () 22))
    (begin
      (set! empty0.6 (call L.fun/empty44111.6))
      (set! ascii-char1.5 (call L.fun/ascii-char44113.12))
      (set! ascii-char2.4 (call L.fun/ascii-char44115.4))
      (set! void3.3 (call L.fun/void44117.7))
      (set! fixnum4.2
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.15 488 1768))
                  (begin
                    (set! tmp.72 (call L.*.15 992 1968))
                    (call L.+.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.15 1304 120))
                    (begin
                      (set! tmp.75 (call L.*.15 296 336))
                      (call L.+.16 tmp.74 tmp.75))))
                (call L.+.16 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.15 200 136))
                    (begin
                      (set! tmp.79 (call L.*.15 544 1016))
                      (call L.*.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.15 1440 712))
                      (begin
                        (set! tmp.82 (call L.-.17 1984 1408))
                        (call L.-.17 tmp.81 tmp.82))))
                  (call L.-.17 tmp.77 tmp.80))))
            (call L.+.16 tmp.69 tmp.76))))
      (set! ascii-char5.1 (call L.fun/ascii-char44119.5))
      (begin
        (set! tmp.83
          (begin
            (set! tmp.84
              (begin
                (set! tmp.85 (call L.+.16 416 736))
                (begin
                  (set! tmp.86 (call L.-.17 fixnum4.2 136))
                  (call L.-.17 tmp.85 tmp.86))))
            (begin
              (set! tmp.87
                (begin
                  (set! tmp.88 (call L.+.16 520 192))
                  (begin
                    (set! tmp.89 (call L.*.15 fixnum4.2 fixnum4.2))
                    (call L.-.17 tmp.88 tmp.89))))
              (call L.+.16 tmp.84 tmp.87))))
        (begin
          (set! tmp.90
            (begin
              (set! tmp.91
                (begin
                  (set! tmp.92 (call L.*.15 440 fixnum4.2))
                  (call L.*.15 fixnum4.2 tmp.92)))
              (call L.*.15 fixnum4.2 tmp.91)))
          (call L.-.17 tmp.83 tmp.90))))))
(check-by-interp
 '(module
    (define L.fixnum?.15
      (lambda (tmp.43)
        (if (begin (set! tmp.56 (bitwise-and tmp.43 7)) (= tmp.56 0)) 14 6)))
    (define L.+.14
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
    (define L.-.12
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
    (define L.fun/empty58877.4 (lambda () 22))
    (define L.fun/error58875.5 (lambda () 38462))
    (define L.fun/ascii-char58879.6 (lambda () 25390))
    (define L.fun/any58880.7 (lambda () 6))
    (define L.fun/empty58876.8 (lambda () (call L.fun/empty58877.4)))
    (define L.fun/ascii-char58878.9 (lambda () (call L.fun/ascii-char58879.6)))
    (define L.fun/error58874.10 (lambda () (call L.fun/error58875.5)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71
                (begin
                  (set! tmp.72 (call L.-.12 2024 1192))
                  (begin
                    (set! tmp.73 (call L.*.13 472 1848))
                    (call L.-.12 tmp.72 tmp.73))))
              (begin
                (set! tmp.74
                  (begin
                    (set! tmp.75 (call L.-.12 1496 200))
                    (begin
                      (set! tmp.76 (call L.*.13 936 400))
                      (call L.-.12 tmp.75 tmp.76))))
                (call L.-.12 tmp.71 tmp.74))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79 (call L.-.12 1400 512))
                    (begin
                      (set! tmp.80 (call L.+.14 304 568))
                      (call L.*.13 tmp.79 tmp.80))))
                (begin
                  (set! tmp.81
                    (begin
                      (set! tmp.82 (call L.-.12 1000 1904))
                      (begin
                        (set! tmp.83 (call L.*.13 528 448))
                        (call L.-.12 tmp.82 tmp.83))))
                  (call L.*.13 tmp.78 tmp.81))))
            (call L.+.14 tmp.70 tmp.77))))
      (set! fixnum1.5
        (begin
          (set! tmp.84
            (begin
              (set! tmp.85
                (begin
                  (set! tmp.86 (call L.-.12 888 8))
                  (begin
                    (set! tmp.87 (call L.*.13 1576 1296))
                    (call L.+.14 tmp.86 tmp.87))))
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.89 (call L.-.12 1288 2000))
                    (begin
                      (set! tmp.90 (call L.+.14 488 1088))
                      (call L.*.13 tmp.89 tmp.90))))
                (call L.+.14 tmp.85 tmp.88))))
          (begin
            (set! tmp.91
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.93 (call L.-.12 1392 1032))
                    (begin
                      (set! tmp.94 (call L.+.14 1776 536))
                      (call L.+.14 tmp.93 tmp.94))))
                (begin
                  (set! tmp.95
                    (begin
                      (set! tmp.96 (call L.*.13 1016 2016))
                      (begin
                        (set! tmp.97 (call L.-.12 1680 1736))
                        (call L.-.12 tmp.96 tmp.97))))
                  (call L.+.14 tmp.92 tmp.95))))
            (call L.*.13 tmp.84 tmp.91))))
      (set! error2.4 (call L.fun/error58874.10))
      (set! empty3.3 (call L.fun/empty58876.8))
      (set! ascii-char4.2 (call L.fun/ascii-char58878.9))
      (set! boolean5.1
        (begin
          (set! tmp.98 (call L.fun/any58880.7))
          (call L.fixnum?.15 tmp.98)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.void?.13
      (lambda (tmp.46)
        (if (begin (set! tmp.56 (bitwise-and tmp.46 255)) (= tmp.56 30))
          14
          6)))
    (define L.-.12
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
    (define L.+.11
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
    (define L.*.10
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
    (define L.fun/ascii-char63953.4 (lambda () 25390))
    (define L.fun/error63956.5 (lambda () 20030))
    (define L.fun/ascii-char63952.6 (lambda () (call L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7 (lambda () (call L.fun/error63956.5)))
    (define L.fun/any63954.8 (lambda () 1784))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71
                (begin
                  (set! tmp.72 (call L.*.10 224 2024))
                  (begin
                    (set! tmp.73 (call L.*.10 1520 1720))
                    (call L.+.11 tmp.72 tmp.73))))
              (begin
                (set! tmp.74
                  (begin
                    (set! tmp.75 (call L.+.11 1768 680))
                    (begin
                      (set! tmp.76 (call L.-.12 1488 840))
                      (call L.*.10 tmp.75 tmp.76))))
                (call L.+.11 tmp.71 tmp.74))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79 (call L.-.12 1920 1392))
                    (begin
                      (set! tmp.80 (call L.+.11 1632 1024))
                      (call L.-.12 tmp.79 tmp.80))))
                (begin
                  (set! tmp.81
                    (begin
                      (set! tmp.82 (call L.*.10 1096 1008))
                      (begin
                        (set! tmp.83 (call L.+.11 416 416))
                        (call L.*.10 tmp.82 tmp.83))))
                  (call L.+.11 tmp.78 tmp.81))))
            (call L.+.11 tmp.70 tmp.77))))
      (set! ascii-char1.5 (call L.fun/ascii-char63952.6))
      (set! fixnum2.4
        (begin
          (set! tmp.84
            (begin
              (set! tmp.85
                (begin
                  (set! tmp.86 (call L.+.11 424 120))
                  (begin
                    (set! tmp.87 (call L.-.12 792 64))
                    (call L.+.11 tmp.86 tmp.87))))
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.89 (call L.*.10 936 240))
                    (begin
                      (set! tmp.90 (call L.*.10 1192 376))
                      (call L.*.10 tmp.89 tmp.90))))
                (call L.-.12 tmp.85 tmp.88))))
          (begin
            (set! tmp.91
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.93 (call L.-.12 1392 1872))
                    (begin
                      (set! tmp.94 (call L.+.11 1024 304))
                      (call L.-.12 tmp.93 tmp.94))))
                (begin
                  (set! tmp.95
                    (begin
                      (set! tmp.96 (call L.-.12 1776 688))
                      (begin
                        (set! tmp.97 (call L.+.11 552 1240))
                        (call L.+.11 tmp.96 tmp.97))))
                  (call L.*.10 tmp.92 tmp.95))))
            (call L.-.12 tmp.84 tmp.91))))
      (set! fixnum3.3
        (begin
          (set! tmp.98
            (begin
              (set! tmp.99
                (begin
                  (set! tmp.100 (call L.+.11 872 1848))
                  (begin
                    (set! tmp.101 (call L.+.11 128 1936))
                    (call L.+.11 tmp.100 tmp.101))))
              (begin
                (set! tmp.102
                  (begin
                    (set! tmp.103 (call L.-.12 1336 256))
                    (begin
                      (set! tmp.104 (call L.*.10 2000 1576))
                      (call L.*.10 tmp.103 tmp.104))))
                (call L.*.10 tmp.99 tmp.102))))
          (begin
            (set! tmp.105
              (begin
                (set! tmp.106
                  (begin
                    (set! tmp.107 (call L.+.11 1528 1152))
                    (begin
                      (set! tmp.108 (call L.+.11 1792 816))
                      (call L.+.11 tmp.107 tmp.108))))
                (begin
                  (set! tmp.109
                    (begin
                      (set! tmp.110 (call L.+.11 512 2032))
                      (begin
                        (set! tmp.111 (call L.*.10 1032 360))
                        (call L.*.10 tmp.110 tmp.111))))
                  (call L.*.10 tmp.106 tmp.109))))
            (call L.-.12 tmp.98 tmp.105))))
      (set! boolean4.2
        (begin
          (set! tmp.112 (call L.fun/any63954.8))
          (call L.void?.13 tmp.112)))
      (set! error5.1 (call L.fun/error63955.7))
      ascii-char1.5)))
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
    (define L.fun/ascii-char71274.4 (lambda () 25390))
    (define L.fun/void71278.5 (lambda () 30))
    (define L.fun/ascii-char71271.6 (lambda () (call L.fun/ascii-char71272.9)))
    (define L.fun/ascii-char71273.7 (lambda () (call L.fun/ascii-char71274.4)))
    (define L.fun/empty71270.8 (lambda () 22))
    (define L.fun/ascii-char71272.9 (lambda () 25390))
    (define L.fun/ascii-char71275.10
      (lambda () (call L.fun/ascii-char71276.13)))
    (define L.fun/void71277.11 (lambda () (call L.fun/void71278.5)))
    (define L.fun/empty71269.12 (lambda () (call L.fun/empty71270.8)))
    (define L.fun/ascii-char71276.13 (lambda () 25390))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.15 104 336))
                  (begin
                    (set! tmp.72 (call L.+.15 888 1800))
                    (call L.*.16 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.17 872 1344))
                    (begin
                      (set! tmp.75 (call L.+.15 1360 680))
                      (call L.-.17 tmp.74 tmp.75))))
                (call L.+.15 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.+.15 72 1248))
                    (begin
                      (set! tmp.79 (call L.+.15 896 1360))
                      (call L.-.17 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.*.16 680 152))
                      (begin
                        (set! tmp.82 (call L.-.17 1104 1392))
                        (call L.+.15 tmp.81 tmp.82))))
                  (call L.-.17 tmp.77 tmp.80))))
            (call L.*.16 tmp.69 tmp.76))))
      (set! empty1.5 (call L.fun/empty71269.12))
      (set! ascii-char2.4 (call L.fun/ascii-char71271.6))
      (set! ascii-char3.3 (call L.fun/ascii-char71273.7))
      (set! ascii-char4.2 (call L.fun/ascii-char71275.10))
      (set! void5.1 (call L.fun/void71277.11))
      empty1.5)))
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
    (define L.fun/empty73456.4 (lambda () (call L.fun/empty73457.8)))
    (define L.fun/ascii-char73458.5
      (lambda () (call L.fun/ascii-char73459.10)))
    (define L.fun/empty73463.6 (lambda () 22))
    (define L.fun/error73460.7 (lambda () (call L.fun/error73461.9)))
    (define L.fun/empty73457.8 (lambda () 22))
    (define L.fun/error73461.9 (lambda () 20542))
    (define L.fun/ascii-char73459.10 (lambda () 25390))
    (define L.fun/empty73462.11 (lambda () (call L.fun/empty73463.6)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.13 1888 2024))
                  (begin
                    (set! tmp.72 (call L.*.13 696 1464))
                    (call L.-.14 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.13 1344 416))
                    (begin
                      (set! tmp.75 (call L.-.14 464 88))
                      (call L.+.15 tmp.74 tmp.75))))
                (call L.-.14 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.13 40 1760))
                    (begin
                      (set! tmp.79 (call L.-.14 104 1688))
                      (call L.+.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.15 1952 952))
                      (begin
                        (set! tmp.82 (call L.*.13 1264 584))
                        (call L.-.14 tmp.81 tmp.82))))
                  (call L.-.14 tmp.77 tmp.80))))
            (call L.+.15 tmp.69 tmp.76))))
      (set! empty1.5 (call L.fun/empty73456.4))
      (set! ascii-char2.4 (call L.fun/ascii-char73458.5))
      (set! error3.3 (call L.fun/error73460.7))
      (set! fixnum4.2
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.-.14 2008 1504))
                  (begin
                    (set! tmp.86 (call L.+.15 1768 1856))
                    (call L.-.14 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.-.14 880 1728))
                    (begin
                      (set! tmp.89 (call L.*.13 1992 152))
                      (call L.-.14 tmp.88 tmp.89))))
                (call L.*.13 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.*.13 840 672))
                    (begin
                      (set! tmp.93 (call L.+.15 1704 368))
                      (call L.*.13 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.*.13 624 1992))
                      (begin
                        (set! tmp.96 (call L.-.14 1976 920))
                        (call L.*.13 tmp.95 tmp.96))))
                  (call L.-.14 tmp.91 tmp.94))))
            (call L.-.14 tmp.83 tmp.90))))
      (set! empty5.1 (call L.fun/empty73462.11))
      error3.3)))
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
    (define L.-.16
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
    (define L.fun/void77842.4 (lambda () (call L.fun/void77843.9)))
    (define L.fun/void77838.5 (lambda () (call L.fun/void77839.10)))
    (define L.fun/error77846.6 (lambda () (call L.fun/error77847.13)))
    (define L.fun/error77845.7 (lambda () 62014))
    (define L.fun/empty77840.8 (lambda () (call L.fun/empty77841.11)))
    (define L.fun/void77843.9 (lambda () 30))
    (define L.fun/void77839.10 (lambda () 30))
    (define L.fun/empty77841.11 (lambda () 22))
    (define L.fun/error77844.12 (lambda () (call L.fun/error77845.7)))
    (define L.fun/error77847.13 (lambda () 48702))
    (begin
      (set! void0.6 (call L.fun/void77838.5))
      (set! fixnum1.5
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.15 1560 800))
                  (begin
                    (set! tmp.72 (call L.-.16 1880 1936))
                    (call L.+.17 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.*.15 216 752))
                    (begin
                      (set! tmp.75 (call L.-.16 1208 800))
                      (call L.*.15 tmp.74 tmp.75))))
                (call L.+.17 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.-.16 8 752))
                    (begin
                      (set! tmp.79 (call L.-.16 1448 1208))
                      (call L.-.16 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.17 1232 1784))
                      (begin
                        (set! tmp.82 (call L.-.16 1288 1256))
                        (call L.*.15 tmp.81 tmp.82))))
                  (call L.-.16 tmp.77 tmp.80))))
            (call L.+.17 tmp.69 tmp.76))))
      (set! empty2.4 (call L.fun/empty77840.8))
      (set! void3.3 (call L.fun/void77842.4))
      (set! error4.2 (call L.fun/error77844.12))
      (set! error5.1 (call L.fun/error77846.6))
      empty2.4)))
(check-by-interp
 '(module
    (define L.ascii-char?.17
      (lambda (tmp.47)
        (if (begin (set! tmp.56 (bitwise-and tmp.47 255)) (= tmp.56 46))
          14
          6)))
    (define L.boolean?.16
      (lambda (tmp.44)
        (if (begin (set! tmp.57 (bitwise-and tmp.44 247)) (= tmp.57 6)) 14 6)))
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (begin
              (set! tmp.58
                (if (begin (set! tmp.59 (bitwise-and tmp.23 7)) (= tmp.59 0))
                  14
                  6))
              (!= tmp.58 6))
          (if (begin
                (set! tmp.60
                  (if (begin (set! tmp.61 (bitwise-and tmp.22 7)) (= tmp.61 0))
                    14
                    6))
                (!= tmp.60 6))
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (begin
              (set! tmp.62
                (if (begin (set! tmp.63 (bitwise-and tmp.21 7)) (= tmp.63 0))
                  14
                  6))
              (!= tmp.62 6))
          (if (begin
                (set! tmp.64
                  (if (begin (set! tmp.65 (bitwise-and tmp.20 7)) (= tmp.65 0))
                    14
                    6))
                (!= tmp.64 6))
            (begin
              (set! tmp.66 (arithmetic-shift-right tmp.21 3))
              (* tmp.20 tmp.66))
            318)
          318)))
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (begin
              (set! tmp.67
                (if (begin (set! tmp.68 (bitwise-and tmp.25 7)) (= tmp.68 0))
                  14
                  6))
              (!= tmp.67 6))
          (if (begin
                (set! tmp.69
                  (if (begin (set! tmp.70 (bitwise-and tmp.24 7)) (= tmp.70 0))
                    14
                    6))
                (!= tmp.69 6))
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.fun/any78095.4 (lambda () 6))
    (define L.fun/void78099.5 (lambda () 30))
    (define L.fun/error78092.6 (lambda () (call L.fun/error78093.9)))
    (define L.fun/any78094.7 (lambda () 6))
    (define L.fun/error78097.8 (lambda () 36670))
    (define L.fun/error78093.9 (lambda () 24126))
    (define L.fun/error78096.10 (lambda () (call L.fun/error78097.8)))
    (define L.fun/void78098.11 (lambda () (call L.fun/void78099.5)))
    (begin
      (set! error0.6 (call L.fun/error78092.6))
      (set! fixnum1.5
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.13 1192 480))
                  (begin
                    (set! tmp.74 (call L.*.14 1584 56))
                    (call L.-.13 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.+.15 1488 128))
                    (begin
                      (set! tmp.77 (call L.+.15 488 1720))
                      (call L.-.13 tmp.76 tmp.77))))
                (call L.+.15 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.*.14 1312 1640))
                    (begin
                      (set! tmp.81 (call L.*.14 1184 864))
                      (call L.-.13 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.*.14 208 296))
                      (begin
                        (set! tmp.84 (call L.*.14 800 32))
                        (call L.*.14 tmp.83 tmp.84))))
                  (call L.-.13 tmp.79 tmp.82))))
            (call L.-.13 tmp.71 tmp.78))))
      (set! boolean2.4
        (begin
          (set! tmp.85 (call L.fun/any78094.7))
          (call L.boolean?.16 tmp.85)))
      (set! boolean3.3
        (begin
          (set! tmp.86 (call L.fun/any78095.4))
          (call L.ascii-char?.17 tmp.86)))
      (set! fixnum4.2
        (begin
          (set! tmp.87
            (begin
              (set! tmp.88
                (begin
                  (set! tmp.89 (call L.*.14 136 1384))
                  (begin
                    (set! tmp.90 (call L.-.13 1784 592))
                    (call L.+.15 tmp.89 tmp.90))))
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.+.15 1536 584))
                    (begin
                      (set! tmp.93 (call L.*.14 1528 1504))
                      (call L.*.14 tmp.92 tmp.93))))
                (call L.+.15 tmp.88 tmp.91))))
          (begin
            (set! tmp.94
              (begin
                (set! tmp.95
                  (begin
                    (set! tmp.96 (call L.*.14 1536 1824))
                    (begin
                      (set! tmp.97 (call L.*.14 1760 840))
                      (call L.-.13 tmp.96 tmp.97))))
                (begin
                  (set! tmp.98
                    (begin
                      (set! tmp.99 (call L.-.13 1864 1032))
                      (begin
                        (set! tmp.100 (call L.-.13 88 688))
                        (call L.-.13 tmp.99 tmp.100))))
                  (call L.+.15 tmp.95 tmp.98))))
            (call L.-.13 tmp.87 tmp.94))))
      (set! error5.1 (call L.fun/error78096.10))
      (call L.fun/void78098.11))))
(check-by-interp
 '(module
    (define L.boolean?.17
      (lambda (tmp.44)
        (if (begin (set! tmp.56 (bitwise-and tmp.44 247)) (= tmp.56 6)) 14 6)))
    (define L.-.16
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
    (define L.*.15
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
    (define L.+.14
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
    (define L.fun/void101999.4 (lambda () 30))
    (define L.fun/empty101997.5 (lambda () 22))
    (define L.fun/ascii-char101994.6
      (lambda () (call L.fun/ascii-char101995.11)))
    (define L.fun/void101992.7 (lambda () (call L.fun/void101993.12)))
    (define L.fun/void101998.8 (lambda () (call L.fun/void101999.4)))
    (define L.fun/empty101996.9 (lambda () (call L.fun/empty101997.5)))
    (define L.fun/any101991.10 (lambda () 30))
    (define L.fun/ascii-char101995.11 (lambda () 25390))
    (define L.fun/void101993.12 (lambda () 30))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.70
            (begin
              (set! tmp.71
                (begin
                  (set! tmp.72 (call L.+.14 1216 248))
                  (begin
                    (set! tmp.73 (call L.+.14 1128 528))
                    (call L.*.15 tmp.72 tmp.73))))
              (begin
                (set! tmp.74
                  (begin
                    (set! tmp.75 (call L.-.16 176 1032))
                    (begin
                      (set! tmp.76 (call L.-.16 968 1320))
                      (call L.-.16 tmp.75 tmp.76))))
                (call L.*.15 tmp.71 tmp.74))))
          (begin
            (set! tmp.77
              (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79 (call L.-.16 424 1872))
                    (begin
                      (set! tmp.80 (call L.+.14 480 1288))
                      (call L.+.14 tmp.79 tmp.80))))
                (begin
                  (set! tmp.81
                    (begin
                      (set! tmp.82 (call L.-.16 1368 1400))
                      (begin
                        (set! tmp.83 (call L.+.14 704 544))
                        (call L.-.16 tmp.82 tmp.83))))
                  (call L.-.16 tmp.78 tmp.81))))
            (call L.+.14 tmp.70 tmp.77))))
      (set! boolean1.5
        (begin
          (set! tmp.84 (call L.fun/any101991.10))
          (call L.boolean?.17 tmp.84)))
      (set! void2.4 (call L.fun/void101992.7))
      (set! ascii-char3.3 (call L.fun/ascii-char101994.6))
      (set! empty4.2 (call L.fun/empty101996.9))
      (set! void5.1 (call L.fun/void101998.8))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/void102362.4 (lambda () (call L.fun/void102363.9)))
    (define L.fun/empty102356.5 (lambda () (call L.fun/empty102357.12)))
    (define L.fun/error102354.6 (lambda () (call L.fun/error102355.10)))
    (define L.fun/void102358.7 (lambda () (call L.fun/void102359.13)))
    (define L.fun/void102353.8 (lambda () 30))
    (define L.fun/void102363.9 (lambda () 30))
    (define L.fun/error102355.10 (lambda () 37694))
    (define L.fun/void102352.11 (lambda () (call L.fun/void102353.8)))
    (define L.fun/empty102357.12 (lambda () 22))
    (define L.fun/void102359.13 (lambda () 30))
    (define L.fun/void102360.14 (lambda () (call L.fun/void102361.15)))
    (define L.fun/void102361.15 (lambda () 30))
    (begin
      (set! void0.6 (call L.fun/void102352.11))
      (set! error1.5 (call L.fun/error102354.6))
      (set! empty2.4 (call L.fun/empty102356.5))
      (set! void3.3 (call L.fun/void102358.7))
      (set! void4.2 (call L.fun/void102360.14))
      (set! void5.1 (call L.fun/void102362.4))
      error1.5)))
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
    (define L.boolean?.16
      (lambda (tmp.44)
        (if (begin (set! tmp.69 (bitwise-and tmp.44 247)) (= tmp.69 6)) 14 6)))
    (define L.fun/void122163.4 (lambda () (call L.fun/void122164.13)))
    (define L.fun/ascii-char122159.5
      (lambda () (call L.fun/ascii-char122160.6)))
    (define L.fun/ascii-char122160.6 (lambda () 25390))
    (define L.fun/ascii-char122162.7 (lambda () 25390))
    (define L.fun/empty122158.8 (lambda () 22))
    (define L.fun/error122165.9 (lambda () (call L.fun/error122166.10)))
    (define L.fun/error122166.10 (lambda () 46910))
    (define L.fun/any122156.11 (lambda () 22))
    (define L.fun/empty122157.12 (lambda () (call L.fun/empty122158.8)))
    (define L.fun/void122164.13 (lambda () 30))
    (define L.fun/ascii-char122161.14
      (lambda () (call L.fun/ascii-char122162.7)))
    (begin
      (set! boolean0.6
        (begin
          (set! tmp.70 (call L.fun/any122156.11))
          (call L.boolean?.16 tmp.70)))
      (set! empty1.5 (call L.fun/empty122157.12))
      (set! fixnum2.4
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.17 1368 96))
                  (begin
                    (set! tmp.74 (call L.-.17 1560 448))
                    (call L.-.17 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.-.17 952 224))
                    (begin
                      (set! tmp.77 (call L.*.18 1856 1680))
                      (call L.+.19 tmp.76 tmp.77))))
                (call L.-.17 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.-.17 104 304))
                    (begin
                      (set! tmp.81 (call L.*.18 1432 1296))
                      (call L.+.19 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.+.19 728 1160))
                      (begin
                        (set! tmp.84 (call L.-.17 416 464))
                        (call L.*.18 tmp.83 tmp.84))))
                  (call L.+.19 tmp.79 tmp.82))))
            (call L.-.17 tmp.71 tmp.78))))
      (set! ascii-char3.3 (call L.fun/ascii-char122159.5))
      (set! ascii-char4.2 (call L.fun/ascii-char122161.14))
      (set! void5.1 (call L.fun/void122163.4))
      (call L.fun/error122165.9))))
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
    (define L.fun/void124216.4 (lambda () 30))
    (define L.fun/ascii-char124211.5
      (lambda () (call L.fun/ascii-char124212.10)))
    (define L.fun/error124206.6 (lambda () 8766))
    (define L.fun/error124213.7 (lambda () (call L.fun/error124214.11)))
    (define L.fun/ascii-char124207.8
      (lambda () (call L.fun/ascii-char124208.14)))
    (define L.fun/void124215.9 (lambda () (call L.fun/void124216.4)))
    (define L.fun/ascii-char124212.10 (lambda () 25390))
    (define L.fun/error124214.11 (lambda () 1598))
    (define L.fun/error124209.12 (lambda () (call L.fun/error124210.13)))
    (define L.fun/error124210.13 (lambda () 830))
    (define L.fun/ascii-char124208.14 (lambda () 25390))
    (define L.fun/error124205.15 (lambda () (call L.fun/error124206.6)))
    (begin
      (set! error0.6 (call L.fun/error124205.15))
      (set! ascii-char1.5 (call L.fun/ascii-char124207.8))
      (set! error2.4 (call L.fun/error124209.12))
      (set! ascii-char3.3 (call L.fun/ascii-char124211.5))
      (set! error4.2 (call L.fun/error124213.7))
      (set! fixnum5.1
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.+.17 1640 16))
                  (begin
                    (set! tmp.72 (call L.+.17 1384 120))
                    (call L.*.18 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.+.17 712 1400))
                    (begin
                      (set! tmp.75 (call L.+.17 936 912))
                      (call L.+.17 tmp.74 tmp.75))))
                (call L.+.17 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.18 1344 952))
                    (begin
                      (set! tmp.79 (call L.-.19 648 264))
                      (call L.*.18 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.-.19 560 1552))
                      (begin
                        (set! tmp.82 (call L.+.17 592 952))
                        (call L.+.17 tmp.81 tmp.82))))
                  (call L.+.17 tmp.77 tmp.80))))
            (call L.*.18 tmp.69 tmp.76))))
      (call L.fun/void124215.9))))
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
    (define L.pair?.14
      (lambda (tmp.49)
        (if (begin (set! tmp.69 (bitwise-and tmp.49 7)) (= tmp.69 1)) 14 6)))
    (define L.fun/ascii-char156382.4
      (lambda () (call L.fun/ascii-char156383.11)))
    (define L.fun/void156379.5 (lambda () (call L.fun/void156380.6)))
    (define L.fun/void156380.6 (lambda () 30))
    (define L.fun/void156387.7 (lambda () 30))
    (define L.fun/any156381.8 (lambda () 11326))
    (define L.fun/void156386.9 (lambda () (call L.fun/void156387.7)))
    (define L.fun/ascii-char156384.10
      (lambda () (call L.fun/ascii-char156385.12)))
    (define L.fun/ascii-char156383.11 (lambda () 25390))
    (define L.fun/ascii-char156385.12 (lambda () 25390))
    (begin
      (set! void0.6 (call L.fun/void156379.5))
      (set! boolean1.5
        (begin
          (set! tmp.70 (call L.fun/any156381.8))
          (call L.pair?.14 tmp.70)))
      (set! fixnum2.4
        (begin
          (set! tmp.71
            (begin
              (set! tmp.72
                (begin
                  (set! tmp.73 (call L.-.15 232 2016))
                  (begin
                    (set! tmp.74 (call L.-.15 504 304))
                    (call L.-.15 tmp.73 tmp.74))))
              (begin
                (set! tmp.75
                  (begin
                    (set! tmp.76 (call L.-.15 368 1152))
                    (begin
                      (set! tmp.77 (call L.-.15 1752 424))
                      (call L.-.15 tmp.76 tmp.77))))
                (call L.-.15 tmp.72 tmp.75))))
          (begin
            (set! tmp.78
              (begin
                (set! tmp.79
                  (begin
                    (set! tmp.80 (call L.-.15 1736 1616))
                    (begin
                      (set! tmp.81 (call L.*.16 320 568))
                      (call L.-.15 tmp.80 tmp.81))))
                (begin
                  (set! tmp.82
                    (begin
                      (set! tmp.83 (call L.+.17 192 1224))
                      (begin
                        (set! tmp.84 (call L.-.15 1976 2016))
                        (call L.+.17 tmp.83 tmp.84))))
                  (call L.*.16 tmp.79 tmp.82))))
            (call L.+.17 tmp.71 tmp.78))))
      (set! ascii-char3.3 (call L.fun/ascii-char156382.4))
      (set! ascii-char4.2 (call L.fun/ascii-char156384.10))
      (set! void5.1 (call L.fun/void156386.9))
      (begin
        (set! tmp.85
          (begin
            (set! tmp.86
              (begin
                (set! tmp.87 (call L.+.17 912 1944))
                (begin
                  (set! tmp.88 (call L.+.17 1896 fixnum2.4))
                  (call L.-.15 tmp.87 tmp.88))))
            (call L.*.16 fixnum2.4 tmp.86)))
        (call L.-.15 fixnum2.4 tmp.85)))))
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
    (define L.+.14
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
    (define L.fun/empty171686.4 (lambda () (call L.fun/empty171687.10)))
    (define L.fun/void171689.5 (lambda () 30))
    (define L.fun/ascii-char171684.6
      (lambda () (call L.fun/ascii-char171685.9)))
    (define L.fun/void171688.7 (lambda () (call L.fun/void171689.5)))
    (define L.fun/void171691.8 (lambda () 30))
    (define L.fun/ascii-char171685.9 (lambda () 25390))
    (define L.fun/empty171687.10 (lambda () 22))
    (define L.fun/void171690.11 (lambda () (call L.fun/void171691.8)))
    (begin
      (set! fixnum0.6
        (begin
          (set! tmp.69
            (begin
              (set! tmp.70
                (begin
                  (set! tmp.71 (call L.*.13 2008 1576))
                  (begin
                    (set! tmp.72 (call L.*.13 1088 1128))
                    (call L.+.14 tmp.71 tmp.72))))
              (begin
                (set! tmp.73
                  (begin
                    (set! tmp.74 (call L.-.15 1968 48))
                    (begin
                      (set! tmp.75 (call L.*.13 592 624))
                      (call L.+.14 tmp.74 tmp.75))))
                (call L.-.15 tmp.70 tmp.73))))
          (begin
            (set! tmp.76
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78 (call L.*.13 1184 672))
                    (begin
                      (set! tmp.79 (call L.+.14 1320 1584))
                      (call L.-.15 tmp.78 tmp.79))))
                (begin
                  (set! tmp.80
                    (begin
                      (set! tmp.81 (call L.+.14 1768 904))
                      (begin
                        (set! tmp.82 (call L.*.13 928 104))
                        (call L.-.15 tmp.81 tmp.82))))
                  (call L.+.14 tmp.77 tmp.80))))
            (call L.-.15 tmp.69 tmp.76))))
      (set! fixnum1.5
        (begin
          (set! tmp.83
            (begin
              (set! tmp.84
                (begin
                  (set! tmp.85 (call L.*.13 1160 240))
                  (begin
                    (set! tmp.86 (call L.-.15 1520 256))
                    (call L.*.13 tmp.85 tmp.86))))
              (begin
                (set! tmp.87
                  (begin
                    (set! tmp.88 (call L.+.14 960 240))
                    (begin
                      (set! tmp.89 (call L.+.14 624 728))
                      (call L.+.14 tmp.88 tmp.89))))
                (call L.-.15 tmp.84 tmp.87))))
          (begin
            (set! tmp.90
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.92 (call L.-.15 1880 1080))
                    (begin
                      (set! tmp.93 (call L.*.13 440 1000))
                      (call L.+.14 tmp.92 tmp.93))))
                (begin
                  (set! tmp.94
                    (begin
                      (set! tmp.95 (call L.-.15 936 608))
                      (begin
                        (set! tmp.96 (call L.-.15 568 984))
                        (call L.-.15 tmp.95 tmp.96))))
                  (call L.-.15 tmp.91 tmp.94))))
            (call L.-.15 tmp.83 tmp.90))))
      (set! ascii-char2.4 (call L.fun/ascii-char171684.6))
      (set! empty3.3 (call L.fun/empty171686.4))
      (set! void4.2 (call L.fun/void171688.7))
      (set! void5.1 (call L.fun/void171690.11))
      fixnum1.5)))
