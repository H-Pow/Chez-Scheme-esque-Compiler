#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../remove-complex-opera*.rkt"))
(define (fail-if-invalid p)
  (when (not (values-bits-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "values-bits-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-exprs-bits-lang-v8 p)
  (interp-values-bits-lang-v8 (fail-if-invalid (remove-complex-opera* p))))

(check-by-interp '(module 24894))
(check-by-interp '(module 22))
(check-by-interp
 '(module (define L.fun/void8390.4 (lambda () 30)) (call L.fun/void8390.4)))
(check-by-interp '(module (let ((empty0.1 22)) 21310)))
(check-by-interp '(module (let ((void0.2 30) (ascii-char1.1 25390)) 576)))
(check-by-interp
 '(module
    (define L.fun/void8397.4 (lambda (oprand0.1) 30))
    (call L.fun/void8397.4 (let ((ascii-char0.3 25390) (boolean1.2 6)) 14))))
(check-by-interp '(module (if (!= 14 6) 18494 57406)))
(check-by-interp '(module (if (!= 6 6) 25390 25390)))
(check-by-interp '(module (if (!= 14 6) 240 224)))
(check-by-interp '(module (let ((empty0.2 22) (ascii-char1.1 25390)) 30)))
(check-by-interp
 '(module
    (define L.fun/error8412.4 (lambda (oprand0.1) 29758))
    (call L.fun/error8412.4 (let ((void0.3 30) (error1.2 38974)) error1.2))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8415.4 (lambda (oprand0.1) 25390))
    (call
     L.fun/ascii-char8415.4
     (let ((ascii-char0.3 25390) (error1.2 29502)) 25390))))
(check-by-interp
 '(module
    (define L.-.8
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (- tmp.21 tmp.22)
            830)
          830)))
    (define L.+.7
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (+ tmp.19 tmp.20)
            574)
          574)))
    (define L.fun/empty8418.4 (lambda () 22))
    (define L.fun/ascii-char8419.5 (lambda () 25390))
    (let ((fixnum0.3 (call L.+.7 760 912))
          (fixnum1.2 (call L.-.8 384 1664))
          (empty2.1 (call L.fun/empty8418.4)))
      (call L.fun/ascii-char8419.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8467.4 (lambda (oprand0.2 oprand1.1) oprand0.2))
    (define L.fun/void8469.5 (lambda (oprand0.4 oprand1.3) 30))
    (define L.fun/empty8468.6 (lambda (oprand0.6 oprand1.5) 22))
    (call
     L.fun/ascii-char8467.4
     (let ((ascii-char0.9 25390) (empty1.8 22) (error2.7 15166)) 25390)
     (call
      L.fun/empty8468.6
      (call L.fun/void8469.5 30 6)
      (if (!= 6 6) 43582 65086)))))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.17 tmp.18)
        (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.17 7) 0) 14 6) 6)
            (* tmp.17 (arithmetic-shift-right tmp.18 3))
            318)
          318)))
    (define L.-.5
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (- tmp.21 tmp.22)
            830)
          830)))
    (call
     L.*.6
     (call L.-.5 (if (!= 6 6) 1712 688) (if (!= 14 6) 1480 128))
     (call
      L.-.5
      (if (!= 6 6) 352 264)
      (let ((ascii-char0.3 25390) (error1.2 13118) (empty2.1 22)) 608)))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.17 tmp.18)
        (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.17 7) 0) 14 6) 6)
            (* tmp.17 (arithmetic-shift-right tmp.18 3))
            318)
          318)))
    (define L.-.7
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (- tmp.21 tmp.22)
            830)
          830)))
    (define L.vector?.6
      (lambda (tmp.47) (if (= (bitwise-and tmp.47 7) 3) 14 6)))
    (define L.fun/any8734.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 41278))
    (if (!= (call L.vector?.6 (call L.fun/any8734.4 5950 22 25390)) 6)
      (call L.*.8 (call L.-.7 1480 528) (if (!= 14 6) 1488 1392))
      (if (!= 14 6) 1552 1376))))
(check-by-interp
 '(module
    (define L.fun/void8780.4 (lambda () 30))
    (define L.fun/ascii-char8782.5 (lambda () 25390))
    (define L.fun/void8781.6 (lambda () 30))
    (define L.fun/error8783.7 (lambda () 35646))
    (define L.fun/void8779.8 (lambda () 30))
    (let ((void0.4 (call L.fun/void8779.8))
          (void1.3 (call L.fun/void8780.4))
          (void2.2 (call L.fun/void8781.6))
          (ascii-char3.1 (call L.fun/ascii-char8782.5)))
      (call L.fun/error8783.7))))
(check-by-interp
 '(module
    (define L.*.10
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.+.9
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.-.8
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.fun/empty8806.4 (lambda () 22))
    (define L.fun/void8807.5 (lambda () 30))
    (define L.fun/ascii-char8808.6 (lambda () 25390))
    (let ((empty0.4 (call L.fun/empty8806.4))
          (fixnum1.3 (call L.-.8 (call L.-.8 1608 864) (call L.+.9 328 352)))
          (fixnum2.2
           (call L.-.8 (call L.*.10 320 1048) (call L.*.10 1096 968)))
          (void3.1 (call L.fun/void8807.5)))
      (call L.fun/ascii-char8808.6))))
(check-by-interp
 '(module
    (define L.error?.16
      (lambda (tmp.59) (if (= (bitwise-and tmp.59 255) 62) 14 6)))
    (define L.fixnum?.15
      (lambda (tmp.54) (if (= (bitwise-and tmp.54 7) 0) 14 6)))
    (define L.+.14
      (lambda (tmp.33 tmp.34)
        (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.33 7) 0) 14 6) 6)
            (+ tmp.33 tmp.34)
            574)
          574)))
    (define L.vector?.13
      (lambda (tmp.61) (if (= (bitwise-and tmp.61 7) 3) 14 6)))
    (define L.fun/empty9034.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 22))
    (define L.fun/error9036.5 (lambda () 47166))
    (define L.fun/error9035.6 (lambda () 36414))
    (define L.fun/void9037.7 (lambda () 30))
    (define L.fun/ascii-char9032.8 (lambda () 25390))
    (define L.fun/empty9038.9 (lambda () 22))
    (define L.fun/ascii-char9031.10
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call L.fun/ascii-char9032.8)))
    (define L.fun/boolean9033.11 (lambda (oprand0.9 oprand1.8 oprand2.7) 14))
    (call
     L.fun/ascii-char9031.10
     (if (!= (call L.fun/boolean9033.11 25390 44094 25390) 6)
       (if (!= 6 6) 22 22)
       (call L.fun/empty9034.4 4158 59454 14))
     (let ((boolean0.13 (call L.vector?.13 25390))
           (fixnum1.12 (call L.+.14 224 192))
           (error2.11 (call L.fun/error9035.6))
           (error3.10 (call L.fun/error9036.5)))
       (call L.fixnum?.15 30))
     (let ((ascii-char0.17 (call L.fun/ascii-char9031.10 22 6 14))
           (void1.16 (call L.fun/void9037.7))
           (ascii-char2.15 (call L.fun/ascii-char9031.10 22 14 6))
           (empty3.14 (call L.fun/empty9038.9)))
       (call L.error?.16 30)))))
(check-by-interp
 '(module
    (define L.fun/void9076.4 (lambda () 30))
    (define L.fun/ascii-char9078.5 (lambda () 25390))
    (define L.fun/error9075.6 (lambda () 57662))
    (define L.fun/empty9077.7 (lambda () 22))
    (let ((error0.4 (call L.fun/error9075.6))
          (void1.3 (call L.fun/void9076.4))
          (empty2.2 (call L.fun/empty9077.7))
          (ascii-char3.1 (call L.fun/ascii-char9078.5)))
      empty2.2)))
(check-by-interp
 '(module
    (if (if (!= 6 6) (!= 14 6) (!= 14 6))
      (let ((fixnum0.4 1720)
            (fixnum1.3 984)
            (void2.2 30)
            (ascii-char3.1 25390))
        fixnum0.4)
      (if (!= 6 6) 1448 1416))))
(check-by-interp
 '(module
    (define L.boolean?.10
      (lambda (tmp.42) (if (= (bitwise-and tmp.42 247) 6) 14 6)))
    (define L.fun/error9365.4 (lambda () 62014))
    (define L.fun/error9364.5 (lambda () 63806))
    (define L.fun/any9366.6 (lambda () 14))
    (define L.fun/error9363.7 (lambda () 60990))
    (define L.fun/empty9362.8 (lambda () 22))
    (let ((empty0.4 (call L.fun/empty9362.8))
          (error1.3 (call L.fun/error9363.7))
          (error2.2 (call L.fun/error9364.5))
          (error3.1 (call L.fun/error9365.4)))
      (call L.boolean?.10 (call L.fun/any9366.6)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9574.4 (lambda () 25390))
    (define L.fun/void9575.5 (lambda () 30))
    (define L.fun/void9573.6 (lambda () 30))
    (define L.fun/empty9572.7 (lambda () 22))
    (let ((empty0.4 (call L.fun/empty9572.7))
          (void1.3 (call L.fun/void9573.6))
          (ascii-char2.2 (call L.fun/ascii-char9574.4))
          (void3.1 (call L.fun/void9575.5)))
      void1.3)))
(check-by-interp
 '(module
    (if (let ((empty0.4 22) (fixnum1.3 968) (void2.2 30) (fixnum3.1 896))
          (!= 6 6))
      (if (!= 14 6) 22 22)
      (let ((empty0.8 22) (error1.7 42302) (void2.6 30) (fixnum3.5 992)) 22))))
(check-by-interp
 '(module
    (define L.-.9
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.*.8
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.fun/ascii-char9904.4 (lambda () 25390))
    (define L.fun/void9902.5 (lambda () 30))
    (define L.fun/ascii-char9903.6 (lambda () 25390))
    (let ((void0.4 (call L.fun/void9902.5))
          (ascii-char1.3 (call L.fun/ascii-char9903.6))
          (fixnum2.2 (call L.-.9 (call L.*.8 504 1592) (call L.*.8 552 1320)))
          (ascii-char3.1 (call L.fun/ascii-char9904.4)))
      void0.4)))
(check-by-interp
 '(module
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/void10674.4 (lambda () 30))
    (define L.fun/error10675.5 (lambda () 64318))
    (define L.fun/void10672.6 (lambda () 30))
    (define L.fun/empty10673.7 (lambda () 22))
    (let ((fixnum0.5
           (call
            L.-.10
            (call L.+.9 (call L.+.9 1112 1560) (call L.-.10 904 704))
            (call L.-.10 (call L.+.9 216 744) (call L.-.10 1832 1952))))
          (void1.4 (call L.fun/void10672.6))
          (empty2.3 (call L.fun/empty10673.7))
          (void3.2 (call L.fun/void10674.4))
          (fixnum4.1
           (call
            L.-.10
            (call L.-.10 (call L.*.11 760 1024) (call L.+.9 1344 160))
            (call L.-.10 (call L.*.11 1136 648) (call L.*.11 736 224)))))
      (call L.fun/error10675.5))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.ascii-char?.9
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 46) 14 6)))
    (define L.fun/any10855.4 (lambda () 25390))
    (define L.fun/ascii-char10854.5 (lambda () 25390))
    (define L.fun/empty10856.6 (lambda () 22))
    (define L.fun/void10857.7 (lambda () 30))
    (let ((ascii-char0.5 (call L.fun/ascii-char10854.5))
          (boolean1.4 (call L.ascii-char?.9 (call L.fun/any10855.4)))
          (empty2.3 (call L.fun/empty10856.6))
          (fixnum3.2
           (call
            L.+.10
            (call L.-.11 (call L.+.10 1352 784) (call L.-.11 8 1792))
            (call L.+.10 (call L.-.11 112 992) (call L.+.10 1104 48))))
          (void4.1 (call L.fun/void10857.7)))
      empty2.3)))
(check-by-interp
 '(module
    (define L.fun/void11402.4 (lambda () 30))
    (define L.fun/ascii-char11403.5 (lambda () 25390))
    (define L.fun/ascii-char11400.6 (lambda () 25390))
    (define L.fun/error11401.7 (lambda () 15166))
    (define L.fun/ascii-char11399.8 (lambda () 25390))
    (let ((ascii-char0.5 (call L.fun/ascii-char11399.8))
          (ascii-char1.4 (call L.fun/ascii-char11400.6))
          (error2.3 (call L.fun/error11401.7))
          (void3.2 (call L.fun/void11402.4))
          (ascii-char4.1 (call L.fun/ascii-char11403.5)))
      void3.2)))
(check-by-interp
 '(module
    (define L.fun/void13621.4 (lambda () 30))
    (define L.fun/ascii-char13620.5 (lambda () 25390))
    (define L.fun/empty13623.6 (lambda () 22))
    (define L.fun/error13618.7 (lambda () 22846))
    (define L.fun/void13619.8 (lambda () 30))
    (define L.fun/error13622.9 (lambda () 25150))
    (let ((error0.5 (call L.fun/error13618.7))
          (void1.4 (call L.fun/void13619.8))
          (ascii-char2.3 (call L.fun/ascii-char13620.5))
          (void3.2 (call L.fun/void13621.4))
          (error4.1 (call L.fun/error13622.9)))
      (call L.fun/empty13623.6))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/void14228.4 (lambda () 30))
    (define L.fun/empty14229.5 (lambda () 22))
    (define L.fun/ascii-char14227.6 (lambda () 25390))
    (let ((fixnum0.5
           (call
            L.+.9
            (call L.+.9 (call L.*.8 1512 1328) (call L.*.8 1088 1096))
            (call L.*.8 (call L.-.10 1528 832) (call L.*.8 192 1744))))
          (ascii-char1.4 (call L.fun/ascii-char14227.6))
          (fixnum2.3
           (call
            L.*.8
            (call L.-.10 (call L.+.9 880 1440) (call L.-.10 632 320))
            (call L.-.10 (call L.-.10 1688 360) (call L.+.9 1800 1952))))
          (void3.2 (call L.fun/void14228.4))
          (empty4.1 (call L.fun/empty14229.5)))
      empty4.1)))
(check-by-interp
 '(module
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/void14544.4 (lambda () 30))
    (define L.fun/empty14543.5 (lambda () 22))
    (define L.fun/ascii-char14546.6 (lambda () 25390))
    (define L.fun/error14545.7 (lambda () 62))
    (define L.fun/error14542.8 (lambda () 38462))
    (let ((error0.5 (call L.fun/error14542.8))
          (empty1.4 (call L.fun/empty14543.5))
          (fixnum2.3
           (call
            L.-.12
            (call L.*.10 (call L.*.10 1248 288) (call L.*.10 856 552))
            (call L.+.11 (call L.*.10 824 1056) (call L.+.11 608 1720))))
          (void3.2 (call L.fun/void14544.4))
          (error4.1 (call L.fun/error14545.7)))
      (call L.fun/ascii-char14546.6))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/empty15112.4 (lambda () 22))
    (define L.fun/error15114.5 (lambda () 11326))
    (define L.fun/empty15111.6 (lambda () 22))
    (define L.fun/ascii-char15115.7 (lambda () 25390))
    (define L.fun/void15113.8 (lambda () 30))
    (let ((fixnum0.5
           (call
            L.*.10
            (call L.-.11 (call L.*.10 1304 1392) (call L.*.10 1800 368))
            (call L.-.11 (call L.*.10 1672 1944) (call L.-.11 1184 1864))))
          (empty1.4 (call L.fun/empty15111.6))
          (empty2.3 (call L.fun/empty15112.4))
          (void3.2 (call L.fun/void15113.8))
          (error4.1 (call L.fun/error15114.5)))
      (call L.fun/ascii-char15115.7))))
(check-by-interp
 '(module
    (define L.fixnum?.11
      (lambda (tmp.42) (if (= (bitwise-and tmp.42 7) 0) 14 6)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/empty16025.4 (lambda () 22))
    (define L.fun/ascii-char16027.5 (lambda () 25390))
    (define L.fun/any16026.6 (lambda () 30))
    (let ((empty0.5 (call L.fun/empty16025.4))
          (fixnum1.4
           (call
            L.-.10
            (call L.-.10 (call L.*.8 56 224) (call L.+.9 336 384))
            (call L.*.8 (call L.-.10 1936 672) (call L.-.10 1096 1760))))
          (fixnum2.3
           (call
            L.*.8
            (call L.*.8 (call L.*.8 56 1408) (call L.*.8 8 528))
            (call L.*.8 (call L.+.9 472 376) (call L.-.10 1000 656))))
          (fixnum3.2
           (call
            L.+.9
            (call L.*.8 (call L.*.8 1064 464) (call L.*.8 1088 1504))
            (call L.*.8 (call L.+.9 1328 1048) (call L.*.8 1832 560))))
          (boolean4.1 (call L.fixnum?.11 (call L.fun/any16026.6))))
      (call L.fun/ascii-char16027.5))))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.fun/ascii-char19237.4 (lambda () 25390))
    (define L.fun/ascii-char19236.5 (lambda () 25390))
    (define L.fun/error19239.6 (lambda () 55358))
    (define L.fun/void19235.7 (lambda () 30))
    (define L.fun/error19238.8 (lambda () 21566))
    (let ((void0.5 (call L.fun/void19235.7))
          (ascii-char1.4 (call L.fun/ascii-char19236.5))
          (ascii-char2.3 (call L.fun/ascii-char19237.4))
          (error3.2 (call L.fun/error19238.8))
          (error4.1 (call L.fun/error19239.6)))
      (call
       L.-.10
       (call L.-.10 (call L.-.10 1752 160) (call L.+.11 456 1232))
       (call L.*.12 (call L.-.10 792 1432) (call L.-.10 1848 1552))))))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.fun/empty20765.4 (lambda () 22))
    (define L.fun/ascii-char20767.5 (lambda () 25390))
    (define L.fun/ascii-char20768.6 (lambda () 25390))
    (define L.fun/empty20764.7 (lambda () 22))
    (define L.fun/error20766.8 (lambda () 64574))
    (let ((empty0.5 (call L.fun/empty20764.7))
          (empty1.4 (call L.fun/empty20765.4))
          (error2.3 (call L.fun/error20766.8))
          (ascii-char3.2 (call L.fun/ascii-char20767.5))
          (ascii-char4.1 (call L.fun/ascii-char20768.6)))
      (call
       L.*.12
       (call L.-.10 (call L.-.10 1504 1184) (call L.+.11 1616 1296))
       (call L.*.12 (call L.-.10 8 1272) (call L.*.12 888 528))))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/ascii-char21096.4 (lambda () 25390))
    (define L.fun/ascii-char21098.5 (lambda () 25390))
    (define L.fun/error21099.6 (lambda () 33086))
    (define L.fun/ascii-char21097.7 (lambda () 25390))
    (let ((ascii-char0.5 (call L.fun/ascii-char21096.4))
          (fixnum1.4
           (call
            L.+.9
            (call L.+.9 (call L.+.9 1208 1976) (call L.*.10 1432 32))
            (call L.+.9 (call L.*.10 1400 456) (call L.-.11 888 1672))))
          (ascii-char2.3 (call L.fun/ascii-char21097.7))
          (ascii-char3.2 (call L.fun/ascii-char21098.5))
          (fixnum4.1
           (call
            L.-.11
            (call L.-.11 (call L.*.10 1032 1800) (call L.+.9 552 560))
            (call L.-.11 (call L.-.11 1424 368) (call L.-.11 864 296)))))
      (call L.fun/error21099.6))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/void21257.4 (lambda () 30))
    (define L.fun/void21255.5 (lambda () 30))
    (define L.fun/void21256.6 (lambda () 30))
    (define L.fun/ascii-char21254.7 (lambda () 25390))
    (let ((ascii-char0.5 (call L.fun/ascii-char21254.7))
          (void1.4 (call L.fun/void21255.5))
          (fixnum2.3
           (call
            L.-.10
            (call L.-.10 (call L.+.9 1728 736) (call L.-.10 1624 192))
            (call L.+.9 (call L.-.10 160 888) (call L.-.10 1968 1920))))
          (void3.2 (call L.fun/void21256.6))
          (void4.1 (call L.fun/void21257.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/error21502.4 (lambda () 12606))
    (define L.fun/empty21506.5 (lambda () 22))
    (define L.fun/empty21503.6 (lambda () 22))
    (define L.fun/error21505.7 (lambda () 45630))
    (define L.fun/empty21504.8 (lambda () 22))
    (let ((error0.5 (call L.fun/error21502.4))
          (empty1.4 (call L.fun/empty21503.6))
          (empty2.3 (call L.fun/empty21504.8))
          (error3.2 (call L.fun/error21505.7))
          (empty4.1 (call L.fun/empty21506.5)))
      error0.5)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/empty21523.4 (lambda () 22))
    (define L.fun/void21525.5 (lambda () 30))
    (define L.fun/void21524.6 (lambda () 30))
    (define L.fun/void21527.7 (lambda () 30))
    (define L.fun/ascii-char21526.8 (lambda () 25390))
    (let ((empty0.5 (call L.fun/empty21523.4))
          (void1.4 (call L.fun/void21524.6))
          (void2.3 (call L.fun/void21525.5))
          (ascii-char3.2 (call L.fun/ascii-char21526.8))
          (void4.1 (call L.fun/void21527.7)))
      (call
       L.+.12
       (call L.-.11 (call L.*.10 1072 1448) (call L.-.11 496 1416))
       (call L.+.12 (call L.-.11 80 1208) (call L.-.11 888 1032))))))
(check-by-interp
 '(module
    (define L.fun/void22132.4 (lambda () 30))
    (define L.fun/void22129.5 (lambda () 30))
    (define L.fun/void22131.6 (lambda () 30))
    (define L.fun/empty22130.7 (lambda () 22))
    (define L.fun/ascii-char22133.8 (lambda () 25390))
    (let ((void0.5 (call L.fun/void22129.5))
          (empty1.4 (call L.fun/empty22130.7))
          (void2.3 (call L.fun/void22131.6))
          (void3.2 (call L.fun/void22132.4))
          (ascii-char4.1 (call L.fun/ascii-char22133.8)))
      ascii-char4.1)))
(check-by-interp
 '(module
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
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
    (let ((ascii-char0.6 (call L.fun/ascii-char35206.4))
          (ascii-char1.5 (call L.fun/ascii-char35208.5))
          (empty2.4 (call L.fun/empty35210.6))
          (error3.3 (call L.fun/error35212.12))
          (fixnum4.2
           (call
            L.+.16
            (call
             L.-.17
             (call L.+.16 (call L.*.15 24 112) (call L.+.16 1176 808))
             (call L.+.16 (call L.-.17 1752 1560) (call L.*.15 40 1400)))
            (call
             L.-.17
             (call L.-.17 (call L.-.17 680 1136) (call L.-.17 1016 1040))
             (call L.+.16 (call L.-.17 256 288) (call L.+.16 280 1544)))))
          (void5.1 (call L.fun/void35214.8)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.error?.19
      (lambda (tmp.48) (if (= (bitwise-and tmp.48 255) 62) 14 6)))
    (define L.+.18
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.void?.15
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
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
    (let ((empty0.6 (call L.fun/empty43333.9))
          (empty1.5 (call L.fun/empty43335.8))
          (boolean2.4 (call L.void?.15 (call L.fun/any43337.6)))
          (fixnum3.3
           (call
            L.+.18
            (call
             L.+.18
             (call L.*.16 (call L.*.16 832 704) (call L.-.17 1040 1832))
             (call L.+.18 (call L.-.17 952 568) (call L.+.18 1392 1880)))
            (call
             L.*.16
             (call L.+.18 (call L.*.16 616 456) (call L.-.17 1928 432))
             (call L.*.16 (call L.+.18 400 1376) (call L.*.16 576 1920)))))
          (empty4.2 (call L.fun/empty43338.10))
          (boolean5.1 (call L.error?.19 (call L.fun/any43340.7))))
      (call L.fun/void43341.4))))
(check-by-interp
 '(module
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
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
    (let ((empty0.6 (call L.fun/empty44111.6))
          (ascii-char1.5 (call L.fun/ascii-char44113.12))
          (ascii-char2.4 (call L.fun/ascii-char44115.4))
          (void3.3 (call L.fun/void44117.7))
          (fixnum4.2
           (call
            L.+.16
            (call
             L.+.16
             (call L.+.16 (call L.*.15 488 1768) (call L.*.15 992 1968))
             (call L.+.16 (call L.*.15 1304 120) (call L.*.15 296 336)))
            (call
             L.-.17
             (call L.*.15 (call L.*.15 200 136) (call L.*.15 544 1016))
             (call L.-.17 (call L.*.15 1440 712) (call L.-.17 1984 1408)))))
          (ascii-char5.1 (call L.fun/ascii-char44119.5)))
      (call
       L.-.17
       (call
        L.+.16
        (call L.-.17 (call L.+.16 416 736) (call L.-.17 fixnum4.2 136))
        (call L.-.17 (call L.+.16 520 192) (call L.*.15 fixnum4.2 fixnum4.2)))
       (call
        L.*.15
        fixnum4.2
        (call L.*.15 fixnum4.2 (call L.*.15 440 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.fixnum?.15
      (lambda (tmp.43) (if (= (bitwise-and tmp.43 7) 0) 14 6)))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
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
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.-.12
             (call L.-.12 (call L.-.12 2024 1192) (call L.*.13 472 1848))
             (call L.-.12 (call L.-.12 1496 200) (call L.*.13 936 400)))
            (call
             L.*.13
             (call L.*.13 (call L.-.12 1400 512) (call L.+.14 304 568))
             (call L.-.12 (call L.-.12 1000 1904) (call L.*.13 528 448)))))
          (fixnum1.5
           (call
            L.*.13
            (call
             L.+.14
             (call L.+.14 (call L.-.12 888 8) (call L.*.13 1576 1296))
             (call L.*.13 (call L.-.12 1288 2000) (call L.+.14 488 1088)))
            (call
             L.+.14
             (call L.+.14 (call L.-.12 1392 1032) (call L.+.14 1776 536))
             (call L.-.12 (call L.*.13 1016 2016) (call L.-.12 1680 1736)))))
          (error2.4 (call L.fun/error58874.10))
          (empty3.3 (call L.fun/empty58876.8))
          (ascii-char4.2 (call L.fun/ascii-char58878.9))
          (boolean5.1 (call L.fixnum?.15 (call L.fun/any58880.7))))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.void?.13
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.11
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.10
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.fun/ascii-char63953.4 (lambda () 25390))
    (define L.fun/error63956.5 (lambda () 20030))
    (define L.fun/ascii-char63952.6 (lambda () (call L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7 (lambda () (call L.fun/error63956.5)))
    (define L.fun/any63954.8 (lambda () 1784))
    (let ((fixnum0.6
           (call
            L.+.11
            (call
             L.+.11
             (call L.+.11 (call L.*.10 224 2024) (call L.*.10 1520 1720))
             (call L.*.10 (call L.+.11 1768 680) (call L.-.12 1488 840)))
            (call
             L.+.11
             (call L.-.12 (call L.-.12 1920 1392) (call L.+.11 1632 1024))
             (call L.*.10 (call L.*.10 1096 1008) (call L.+.11 416 416)))))
          (ascii-char1.5 (call L.fun/ascii-char63952.6))
          (fixnum2.4
           (call
            L.-.12
            (call
             L.-.12
             (call L.+.11 (call L.+.11 424 120) (call L.-.12 792 64))
             (call L.*.10 (call L.*.10 936 240) (call L.*.10 1192 376)))
            (call
             L.*.10
             (call L.-.12 (call L.-.12 1392 1872) (call L.+.11 1024 304))
             (call L.+.11 (call L.-.12 1776 688) (call L.+.11 552 1240)))))
          (fixnum3.3
           (call
            L.-.12
            (call
             L.*.10
             (call L.+.11 (call L.+.11 872 1848) (call L.+.11 128 1936))
             (call L.*.10 (call L.-.12 1336 256) (call L.*.10 2000 1576)))
            (call
             L.*.10
             (call L.+.11 (call L.+.11 1528 1152) (call L.+.11 1792 816))
             (call L.*.10 (call L.+.11 512 2032) (call L.*.10 1032 360)))))
          (boolean4.2 (call L.void?.13 (call L.fun/any63954.8)))
          (error5.1 (call L.fun/error63955.7)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
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
    (let ((fixnum0.6
           (call
            L.*.16
            (call
             L.+.15
             (call L.*.16 (call L.+.15 104 336) (call L.+.15 888 1800))
             (call L.-.17 (call L.-.17 872 1344) (call L.+.15 1360 680)))
            (call
             L.-.17
             (call L.-.17 (call L.+.15 72 1248) (call L.+.15 896 1360))
             (call L.+.15 (call L.*.16 680 152) (call L.-.17 1104 1392)))))
          (empty1.5 (call L.fun/empty71269.12))
          (ascii-char2.4 (call L.fun/ascii-char71271.6))
          (ascii-char3.3 (call L.fun/ascii-char71273.7))
          (ascii-char4.2 (call L.fun/ascii-char71275.10))
          (void5.1 (call L.fun/void71277.11)))
      empty1.5)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
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
    (let ((fixnum0.6
           (call
            L.+.15
            (call
             L.-.14
             (call L.-.14 (call L.*.13 1888 2024) (call L.*.13 696 1464))
             (call L.+.15 (call L.*.13 1344 416) (call L.-.14 464 88)))
            (call
             L.-.14
             (call L.+.15 (call L.*.13 40 1760) (call L.-.14 104 1688))
             (call L.-.14 (call L.+.15 1952 952) (call L.*.13 1264 584)))))
          (empty1.5 (call L.fun/empty73456.4))
          (ascii-char2.4 (call L.fun/ascii-char73458.5))
          (error3.3 (call L.fun/error73460.7))
          (fixnum4.2
           (call
            L.-.14
            (call
             L.*.13
             (call L.-.14 (call L.-.14 2008 1504) (call L.+.15 1768 1856))
             (call L.-.14 (call L.-.14 880 1728) (call L.*.13 1992 152)))
            (call
             L.-.14
             (call L.*.13 (call L.*.13 840 672) (call L.+.15 1704 368))
             (call L.*.13 (call L.*.13 624 1992) (call L.-.14 1976 920)))))
          (empty5.1 (call L.fun/empty73462.11)))
      error3.3)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
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
    (let ((void0.6 (call L.fun/void77838.5))
          (fixnum1.5
           (call
            L.+.17
            (call
             L.+.17
             (call L.+.17 (call L.*.15 1560 800) (call L.-.16 1880 1936))
             (call L.*.15 (call L.*.15 216 752) (call L.-.16 1208 800)))
            (call
             L.-.16
             (call L.-.16 (call L.-.16 8 752) (call L.-.16 1448 1208))
             (call L.*.15 (call L.+.17 1232 1784) (call L.-.16 1288 1256)))))
          (empty2.4 (call L.fun/empty77840.8))
          (void3.3 (call L.fun/void77842.4))
          (error4.2 (call L.fun/error77844.12))
          (error5.1 (call L.fun/error77846.6)))
      empty2.4)))
(check-by-interp
 '(module
    (define L.ascii-char?.17
      (lambda (tmp.47) (if (= (bitwise-and tmp.47 255) 46) 14 6)))
    (define L.boolean?.16
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
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
    (let ((error0.6 (call L.fun/error78092.6))
          (fixnum1.5
           (call
            L.-.13
            (call
             L.+.15
             (call L.-.13 (call L.-.13 1192 480) (call L.*.14 1584 56))
             (call L.-.13 (call L.+.15 1488 128) (call L.+.15 488 1720)))
            (call
             L.-.13
             (call L.-.13 (call L.*.14 1312 1640) (call L.*.14 1184 864))
             (call L.*.14 (call L.*.14 208 296) (call L.*.14 800 32)))))
          (boolean2.4 (call L.boolean?.16 (call L.fun/any78094.7)))
          (boolean3.3 (call L.ascii-char?.17 (call L.fun/any78095.4)))
          (fixnum4.2
           (call
            L.-.13
            (call
             L.+.15
             (call L.+.15 (call L.*.14 136 1384) (call L.-.13 1784 592))
             (call L.*.14 (call L.+.15 1536 584) (call L.*.14 1528 1504)))
            (call
             L.+.15
             (call L.-.13 (call L.*.14 1536 1824) (call L.*.14 1760 840))
             (call L.-.13 (call L.-.13 1864 1032) (call L.-.13 88 688)))))
          (error5.1 (call L.fun/error78096.10)))
      (call L.fun/void78098.11))))
(check-by-interp
 '(module
    (define L.boolean?.17
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
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
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.*.15
             (call L.*.15 (call L.+.14 1216 248) (call L.+.14 1128 528))
             (call L.-.16 (call L.-.16 176 1032) (call L.-.16 968 1320)))
            (call
             L.-.16
             (call L.+.14 (call L.-.16 424 1872) (call L.+.14 480 1288))
             (call L.-.16 (call L.-.16 1368 1400) (call L.+.14 704 544)))))
          (boolean1.5 (call L.boolean?.17 (call L.fun/any101991.10)))
          (void2.4 (call L.fun/void101992.7))
          (ascii-char3.3 (call L.fun/ascii-char101994.6))
          (empty4.2 (call L.fun/empty101996.9))
          (void5.1 (call L.fun/void101998.8)))
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
    (let ((void0.6 (call L.fun/void102352.11))
          (error1.5 (call L.fun/error102354.6))
          (empty2.4 (call L.fun/empty102356.5))
          (void3.3 (call L.fun/void102358.7))
          (void4.2 (call L.fun/void102360.14))
          (void5.1 (call L.fun/void102362.4)))
      error1.5)))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.18
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.boolean?.16
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
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
    (let ((boolean0.6 (call L.boolean?.16 (call L.fun/any122156.11)))
          (empty1.5 (call L.fun/empty122157.12))
          (fixnum2.4
           (call
            L.-.17
            (call
             L.-.17
             (call L.-.17 (call L.-.17 1368 96) (call L.-.17 1560 448))
             (call L.+.19 (call L.-.17 952 224) (call L.*.18 1856 1680)))
            (call
             L.+.19
             (call L.+.19 (call L.-.17 104 304) (call L.*.18 1432 1296))
             (call L.*.18 (call L.+.19 728 1160) (call L.-.17 416 464)))))
          (ascii-char3.3 (call L.fun/ascii-char122159.5))
          (ascii-char4.2 (call L.fun/ascii-char122161.14))
          (void5.1 (call L.fun/void122163.4)))
      (call L.fun/error122165.9))))
(check-by-interp
 '(module
    (define L.-.19
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.18
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
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
    (let ((error0.6 (call L.fun/error124205.15))
          (ascii-char1.5 (call L.fun/ascii-char124207.8))
          (error2.4 (call L.fun/error124209.12))
          (ascii-char3.3 (call L.fun/ascii-char124211.5))
          (error4.2 (call L.fun/error124213.7))
          (fixnum5.1
           (call
            L.*.18
            (call
             L.+.17
             (call L.*.18 (call L.+.17 1640 16) (call L.+.17 1384 120))
             (call L.+.17 (call L.+.17 712 1400) (call L.+.17 936 912)))
            (call
             L.+.17
             (call L.*.18 (call L.*.18 1344 952) (call L.-.19 648 264))
             (call L.+.17 (call L.-.19 560 1552) (call L.+.17 592 952))))))
      (call L.fun/void124215.9))))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.pair?.14
      (lambda (tmp.49) (if (= (bitwise-and tmp.49 7) 1) 14 6)))
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
    (let ((void0.6 (call L.fun/void156379.5))
          (boolean1.5 (call L.pair?.14 (call L.fun/any156381.8)))
          (fixnum2.4
           (call
            L.+.17
            (call
             L.-.15
             (call L.-.15 (call L.-.15 232 2016) (call L.-.15 504 304))
             (call L.-.15 (call L.-.15 368 1152) (call L.-.15 1752 424)))
            (call
             L.*.16
             (call L.-.15 (call L.-.15 1736 1616) (call L.*.16 320 568))
             (call L.+.17 (call L.+.17 192 1224) (call L.-.15 1976 2016)))))
          (ascii-char3.3 (call L.fun/ascii-char156382.4))
          (ascii-char4.2 (call L.fun/ascii-char156384.10))
          (void5.1 (call L.fun/void156386.9)))
      (call
       L.-.15
       fixnum2.4
       (call
        L.*.16
        fixnum2.4
        (call L.-.15 (call L.+.17 912 1944) (call L.+.17 1896 fixnum2.4)))))))
(check-by-interp
 '(module
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
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
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.-.15
             (call L.+.14 (call L.*.13 2008 1576) (call L.*.13 1088 1128))
             (call L.+.14 (call L.-.15 1968 48) (call L.*.13 592 624)))
            (call
             L.+.14
             (call L.-.15 (call L.*.13 1184 672) (call L.+.14 1320 1584))
             (call L.-.15 (call L.+.14 1768 904) (call L.*.13 928 104)))))
          (fixnum1.5
           (call
            L.-.15
            (call
             L.-.15
             (call L.*.13 (call L.*.13 1160 240) (call L.-.15 1520 256))
             (call L.+.14 (call L.+.14 960 240) (call L.+.14 624 728)))
            (call
             L.-.15
             (call L.+.14 (call L.-.15 1880 1080) (call L.*.13 440 1000))
             (call L.-.15 (call L.-.15 936 608) (call L.-.15 568 984)))))
          (ascii-char2.4 (call L.fun/ascii-char171684.6))
          (empty3.3 (call L.fun/empty171686.4))
          (void4.2 (call L.fun/void171688.7))
          (void5.1 (call L.fun/void171690.11)))
      fixnum1.5)))
