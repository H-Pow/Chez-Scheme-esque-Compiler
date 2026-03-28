#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 "../remove-complex-opera*.rkt")
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

(check-by-interp '(module 25390))
(check-by-interp '(module 48958))
(check-by-interp
 '(module
    (define L.fun/ascii-char8383.4 (lambda () 25390))
    (call L.fun/ascii-char8383.4)))
(check-by-interp
 '(module
    (define L.fun/error8386.4 (lambda () 20030))
    (call L.fun/error8386.4)))
(check-by-interp '(module (let ((empty0.1 22)) 30)))
(check-by-interp '(module (if (!= 6 6) 50494 57662)))
(check-by-interp
 '(module
    (define L.fun/boolean8393.4 (lambda (oprand0.1) 14))
    (call L.fun/boolean8393.4 (if (!= 14 6) 928 1456))))
(check-by-interp
 '(module
    (define L.+.6
      (lambda (tmp.17 tmp.18)
        (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.17 7) 0) 14 6) 6)
            (+ tmp.17 tmp.18)
            574)
          574)))
    (define L.fun/fixnum8396.4 (lambda (oprand0.1) 1928))
    (call L.+.6 (if (!= 14 6) 592 776) (call L.fun/fixnum8396.4 30))))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.15 tmp.16)
        (if (!= (if (= (bitwise-and tmp.16 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.15 7) 0) 14 6) 6)
            (* tmp.15 (arithmetic-shift-right tmp.16 3))
            318)
          318)))
    (define L.fun/void8399.4 (lambda (oprand0.1) 30))
    (call L.fun/void8399.4 (call L.*.6 1080 1200))))
(check-by-interp '(module (let ((empty0.2 22) (empty1.1 22)) 30)))
(check-by-interp '(module (if (!= 6 6) 48 1600)))
(check-by-interp
 '(module
    (define L.fun/error8463.4 (lambda (oprand0.2 oprand1.1) oprand1.1))
    (call
     L.fun/error8463.4
     (let ((ascii-char0.5 25390) (ascii-char1.4 25390) (error2.3 62782))
       error2.3)
     (call
      L.fun/error8463.4
      (let ((ascii-char0.8 25390) (boolean1.7 6) (void2.6 30)) 56894)
      (if (!= 6 6) 318 37182)))))
(check-by-interp
 '(module
    (define L.*.7
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.fun/fixnum8490.4 (lambda (oprand0.2 oprand1.1) 168))
    (define L.fun/boolean8489.5 (lambda (oprand0.4 oprand1.3) 6))
    (if (!= (call L.fun/boolean8489.5 63550 608) 6)
      (call L.fun/fixnum8490.4 30 14)
      (call L.*.7 1712 2008))))
(check-by-interp
 '(module
    (define L.fun/empty8497.4 (lambda () 22))
    (define L.fun/void8496.5 (lambda () 30))
    (define L.fun/ascii-char8498.6 (lambda () 25390))
    (let ((void0.3 (call L.fun/void8496.5))
          (empty1.2 (call L.fun/empty8497.4))
          (ascii-char2.1 (call L.fun/ascii-char8498.6)))
      void0.3)))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/fixnum8501.4 (lambda (oprand0.2 oprand1.1) 184))
    (if (let ((void0.5 30) (error1.4 41534) (empty2.3 22)) (!= 14 6))
      (call L.*.6 208 984)
      (call L.fun/fixnum8501.4 14 30))))
(check-by-interp
 '(module
    (define L.+.5
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (+ tmp.19 tmp.20)
            574)
          574)))
    (if (let ((void0.3 30) (ascii-char1.2 25390) (fixnum2.1 1616)) (!= 14 6))
      (call L.+.5 520 1640)
      (call L.+.5 24 392))))
(check-by-interp
 '(module
    (define L.+.8
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (+ tmp.19 tmp.20)
            574)
          574)))
    (define L.pair?.7 (lambda (tmp.46) (if (= (bitwise-and tmp.46 7) 1) 14 6)))
    (define L.fun/ascii-char8555.4 (lambda () 25390))
    (define L.fun/void8554.5 (lambda () 30))
    (let ((boolean0.3 (call L.pair?.7 12606))
          (void1.2 (call L.fun/void8554.5))
          (fixnum2.1 (call L.+.8 736 1552)))
      (call L.fun/ascii-char8555.4))))
(check-by-interp
 '(module
    (define L.+.7
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (+ tmp.19 tmp.20)
            574)
          574)))
    (define L.error?.6
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 62) 14 6)))
    (define L.fun/empty8590.4 (lambda () 22))
    (let ((empty0.3 (call L.fun/empty8590.4))
          (boolean1.2 (call L.error?.6 30))
          (fixnum2.1 (call L.+.7 1392 1496)))
      fixnum2.1)))
(check-by-interp
 '(module
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.-.8
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.fun/void8641.4 (lambda () 30))
    (define L.fun/empty8642.5 (lambda () 22))
    (define L.fun/void8643.6 (lambda () 30))
    (let ((void0.4 (call L.fun/void8641.4))
          (empty1.3 (call L.fun/empty8642.5))
          (fixnum2.2 (call L.-.8 (call L.-.8 1640 1936) (call L.*.9 1640 904)))
          (void3.1 (call L.fun/void8643.6)))
      void3.1)))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.fun/error9361.4 (lambda () 14142))
    (define L.fun/empty9358.5 (lambda () 22))
    (define L.fun/void9360.6 (lambda () 30))
    (define L.fun/empty9359.7 (lambda () 22))
    (let ((empty0.4 (call L.fun/empty9358.5))
          (fixnum1.3 (call L.-.10 (call L.*.9 1456 1320) (call L.*.9 104 8)))
          (empty2.2 (call L.fun/empty9359.7))
          (void3.1 (call L.fun/void9360.6)))
      (call L.fun/error9361.4))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.39 tmp.40)
        (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (- tmp.39 tmp.40)
            830)
          830)))
    (define L.+.9
      (lambda (tmp.37 tmp.38)
        (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (+ tmp.37 tmp.38)
            574)
          574)))
    (define L.*.8
      (lambda (tmp.35 tmp.36)
        (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (* tmp.35 (arithmetic-shift-right tmp.36 3))
            318)
          318)))
    (define L.fun/void10119.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 30))
    (define L.fun/fixnum10117.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand1.5))
    (define L.fun/fixnum10118.6 (lambda (oprand0.9 oprand1.8 oprand2.7) 1640))
    (call
     L.-.10
     (call
      L.fun/fixnum10117.5
      (if (!= 14 6) 27710 36158)
      (let ((void0.13 30) (fixnum1.12 232) (boolean2.11 14) (fixnum3.10 128))
        fixnum1.12)
      (let ((empty0.17 22) (boolean1.16 6) (void2.15 30) (void3.14 30)) 30))
     (call
      L.+.9
      (if (!= 6 6) 760 424)
      (call
       L.fun/fixnum10118.6
       (call L.fun/void10119.4 6 25390 22)
       (let ((boolean0.21 14) (empty1.20 22) (boolean2.19 14) (boolean3.18 14))
         26942)
       (call L.*.8 296 1496))))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (+ tmp.20 tmp.21)
            574)
          574)))
    (define L.*.8
      (lambda (tmp.18 tmp.19)
        (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.18 7) 0) 14 6) 6)
            (* tmp.18 (arithmetic-shift-right tmp.19 3))
            318)
          318)))
    (define L.-.7
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (- tmp.22 tmp.23)
            830)
          830)))
    (define L.fun/error10153.4 (lambda () 3134))
    (define L.fun/error10154.5 (lambda () 4926))
    (let ((error0.4 (call L.fun/error10153.4))
          (fixnum1.3
           (call L.*.8 (call L.-.7 1080 1480) (call L.*.8 1896 1336)))
          (error2.2 (call L.fun/error10154.5))
          (fixnum3.1
           (call L.+.9 (call L.+.9 1968 392) (call L.*.8 1408 1208))))
      error2.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char11508.4 (lambda () 25390))
    (define L.fun/void11512.5 (lambda () 30))
    (define L.fun/ascii-char11511.6 (lambda () 25390))
    (define L.fun/empty11507.7 (lambda () 22))
    (define L.fun/empty11509.8 (lambda () 22))
    (define L.fun/error11510.9 (lambda () 31294))
    (let ((empty0.5 (call L.fun/empty11507.7))
          (ascii-char1.4 (call L.fun/ascii-char11508.4))
          (empty2.3 (call L.fun/empty11509.8))
          (error3.2 (call L.fun/error11510.9))
          (ascii-char4.1 (call L.fun/ascii-char11511.6)))
      (call L.fun/void11512.5))))
(check-by-interp
 '(module
    (define L.boolean?.11
      (lambda (tmp.43) (if (= (bitwise-and tmp.43 247) 6) 14 6)))
    (define L.fun/any11902.4 (lambda () 6))
    (define L.fun/ascii-char11900.5 (lambda () 25390))
    (define L.fun/ascii-char11901.6 (lambda () 25390))
    (define L.fun/ascii-char11903.7 (lambda () 25390))
    (define L.fun/void11904.8 (lambda () 30))
    (define L.fun/empty11899.9 (lambda () 22))
    (let ((empty0.5 (call L.fun/empty11899.9))
          (ascii-char1.4 (call L.fun/ascii-char11900.5))
          (ascii-char2.3 (call L.fun/ascii-char11901.6))
          (boolean3.2 (call L.boolean?.11 (call L.fun/any11902.4)))
          (ascii-char4.1 (call L.fun/ascii-char11903.7)))
      (call L.fun/void11904.8))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.9
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.8
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/void11995.4 (lambda () 30))
    (define L.fun/ascii-char11994.5 (lambda () 25390))
    (define L.fun/void11996.6 (lambda () 30))
    (let ((ascii-char0.5 (call L.fun/ascii-char11994.5))
          (void1.4 (call L.fun/void11995.4))
          (void2.3 (call L.fun/void11996.6))
          (fixnum3.2
           (call
            L.-.10
            (call L.+.8 (call L.+.8 2000 40) (call L.*.9 752 128))
            (call L.+.8 (call L.+.8 304 1888) (call L.-.10 1440 368))))
          (fixnum4.1
           (call
            L.*.9
            (call L.*.9 (call L.-.10 1384 1800) (call L.*.9 96 1096))
            (call L.+.8 (call L.+.8 1112 360) (call L.*.9 1344 1272)))))
      (call L.+.8 fixnum4.1 fixnum3.2))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.8
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.7
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/void11999.4 (lambda () 30))
    (define L.fun/ascii-char12000.5 (lambda () 25390))
    (let ((fixnum0.5
           (call
            L.+.9
            (call L.*.7 (call L.*.7 1984 448) (call L.-.8 1248 656))
            (call L.-.8 (call L.+.9 456 1400) (call L.+.9 1048 1120))))
          (fixnum1.4
           (call
            L.+.9
            (call L.+.9 (call L.-.8 360 1576) (call L.*.7 1768 1448))
            (call L.*.7 (call L.*.7 1120 1936) (call L.*.7 1416 1048))))
          (void2.3 (call L.fun/void11999.4))
          (fixnum3.2
           (call
            L.+.9
            (call L.*.7 (call L.+.9 680 1680) (call L.*.7 784 1904))
            (call L.-.8 (call L.*.7 1624 1672) (call L.*.7 2008 1032))))
          (ascii-char4.1 (call L.fun/ascii-char12000.5)))
      ascii-char4.1)))
(check-by-interp
 '(module
    (define L.fun/empty12004.4 (lambda () 22))
    (define L.fun/void12007.5 (lambda () 30))
    (define L.fun/empty12006.6 (lambda () 22))
    (define L.fun/ascii-char12003.7 (lambda () 25390))
    (define L.fun/void12005.8 (lambda () 30))
    (let ((ascii-char0.5 (call L.fun/ascii-char12003.7))
          (empty1.4 (call L.fun/empty12004.4))
          (void2.3 (call L.fun/void12005.8))
          (empty3.2 (call L.fun/empty12006.6))
          (void4.1 (call L.fun/void12007.5)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char12857.4 (lambda () 25390))
    (define L.fun/void12858.5 (lambda () 30))
    (define L.fun/error12860.6 (lambda () 36926))
    (define L.fun/error12859.7 (lambda () 30526))
    (define L.fun/empty12861.8 (lambda () 22))
    (let ((ascii-char0.5 (call L.fun/ascii-char12857.4))
          (void1.4 (call L.fun/void12858.5))
          (error2.3 (call L.fun/error12859.7))
          (error3.2 (call L.fun/error12860.6))
          (empty4.1 (call L.fun/empty12861.8)))
      empty4.1)))
(check-by-interp
 '(module
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.fun/ascii-char14008.4 (lambda () 25390))
    (define L.fun/error14007.5 (lambda () 32830))
    (define L.fun/void14006.6 (lambda () 30))
    (let ((fixnum0.5
           (call
            L.-.9
            (call L.+.10 (call L.*.8 1536 712) (call L.-.9 1672 160))
            (call L.*.8 (call L.-.9 240 1824) (call L.*.8 1440 1720))))
          (void1.4 (call L.fun/void14006.6))
          (fixnum2.3
           (call
            L.*.8
            (call L.-.9 (call L.+.10 280 592) (call L.*.8 440 536))
            (call L.+.10 (call L.-.9 400 744) (call L.-.9 1592 1080))))
          (error3.2 (call L.fun/error14007.5))
          (ascii-char4.1 (call L.fun/ascii-char14008.4)))
      (call L.*.8 fixnum0.5 fixnum0.5))))
(check-by-interp
 '(module
    (define L.fun/void15239.4 (lambda () 30))
    (define L.fun/ascii-char15242.5 (lambda () 25390))
    (define L.fun/error15237.6 (lambda () 11070))
    (define L.fun/error15240.7 (lambda () 4158))
    (define L.fun/error15238.8 (lambda () 57406))
    (define L.fun/empty15241.9 (lambda () 22))
    (let ((error0.5 (call L.fun/error15237.6))
          (error1.4 (call L.fun/error15238.8))
          (void2.3 (call L.fun/void15239.4))
          (error3.2 (call L.fun/error15240.7))
          (empty4.1 (call L.fun/empty15241.9)))
      (call L.fun/ascii-char15242.5))))
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
    (define L.fun/void15268.4 (lambda () 30))
    (define L.fun/void15269.5 (lambda () 30))
    (define L.fun/empty15270.6 (lambda () 22))
    (define L.fun/void15267.7 (lambda () 30))
    (let ((void0.5 (call L.fun/void15267.7))
          (void1.4 (call L.fun/void15268.4))
          (void2.3 (call L.fun/void15269.5))
          (empty3.2 (call L.fun/empty15270.6))
          (fixnum4.1
           (call
            L.*.10
            (call L.+.9 (call L.+.9 880 1256) (call L.*.10 1136 1568))
            (call L.-.11 (call L.-.11 280 1176) (call L.+.9 1208 1232)))))
      void0.5)))
(check-by-interp
 '(module
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.ascii-char?.9
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 46) 14 6)))
    (define L.fun/ascii-char15482.4 (lambda () 25390))
    (define L.fun/void15483.5 (lambda () 30))
    (define L.fun/any15480.6 (lambda () 22))
    (define L.fun/void15481.7 (lambda () 30))
    (let ((boolean0.5 (call L.ascii-char?.9 (call L.fun/any15480.6)))
          (void1.4 (call L.fun/void15481.7))
          (ascii-char2.3 (call L.fun/ascii-char15482.4))
          (fixnum3.2
           (call
            L.+.10
            (call L.+.10 (call L.+.10 1136 1976) (call L.+.10 96 1296))
            (call L.-.12 (call L.*.11 680 1192) (call L.+.10 608 632))))
          (void4.1 (call L.fun/void15483.5)))
      void4.1)))
(check-by-interp
 '(module
    (define L.vector?.12
      (lambda (tmp.49) (if (= (bitwise-and tmp.49 7) 3) 14 6)))
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
    (define L.empty?.9
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 255) 22) 14 6)))
    (define L.fun/any17793.4 (lambda () 25390))
    (define L.fun/error17796.5 (lambda () 19518))
    (define L.fun/any17795.6 (lambda () 46910))
    (define L.fun/empty17794.7 (lambda () 22))
    (let ((boolean0.5 (call L.empty?.9 (call L.fun/any17793.4)))
          (empty1.4 (call L.fun/empty17794.7))
          (fixnum2.3
           (call
            L.*.10
            (call L.*.10 (call L.*.10 1952 1936) (call L.-.11 16 1120))
            (call L.*.10 (call L.-.11 1544 1520) (call L.-.11 1768 1568))))
          (boolean3.2 (call L.vector?.12 (call L.fun/any17795.6)))
          (error4.1 (call L.fun/error17796.5)))
      error4.1)))
(check-by-interp
 '(module
    (define L.boolean?.13
      (lambda (tmp.43) (if (= (bitwise-and tmp.43 247) 6) 14 6)))
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.fixnum?.10
      (lambda (tmp.42) (if (= (bitwise-and tmp.42 7) 0) 14 6)))
    (define L.fun/any20781.4 (lambda () 30))
    (define L.fun/error20783.5 (lambda () 45374))
    (define L.fun/empty20785.6 (lambda () 22))
    (define L.fun/error20782.7 (lambda () 42046))
    (define L.fun/any20784.8 (lambda () 14))
    (let ((boolean0.5 (call L.fixnum?.10 (call L.fun/any20781.4)))
          (fixnum1.4
           (call
            L.-.11
            (call L.*.12 (call L.-.11 1808 1976) (call L.*.12 1992 1104))
            (call L.*.12 (call L.-.11 1536 392) (call L.*.12 552 1576))))
          (error2.3 (call L.fun/error20782.7))
          (error3.2 (call L.fun/error20783.5))
          (boolean4.1 (call L.boolean?.13 (call L.fun/any20784.8))))
      (call L.fun/empty20785.6))))
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
    (define L.fun/ascii-char22127.4 (lambda () 25390))
    (define L.fun/error22124.5 (lambda () 41022))
    (define L.fun/error22126.6 (lambda () 2622))
    (define L.fun/void22125.7 (lambda () 30))
    (let ((error0.5 (call L.fun/error22124.5))
          (fixnum1.4
           (call
            L.-.10
            (call L.+.9 (call L.+.9 528 184) (call L.-.10 1232 152))
            (call L.-.10 (call L.-.10 448 640) (call L.+.9 744 232))))
          (void2.3 (call L.fun/void22125.7))
          (error3.2 (call L.fun/error22126.6))
          (ascii-char4.1 (call L.fun/ascii-char22127.4)))
      void2.3)))
(check-by-interp
 '(module
    (define L.ascii-char?.11
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 46) 14 6)))
    (define L.void?.10
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 30) 14 6)))
    (define L.fun/any22156.4 (lambda () 30))
    (define L.fun/ascii-char22153.5 (lambda () 25390))
    (define L.fun/ascii-char22152.6 (lambda () 25390))
    (define L.fun/void22154.7 (lambda () 30))
    (define L.fun/any22155.8 (lambda () 30))
    (let ((ascii-char0.5 (call L.fun/ascii-char22152.6))
          (ascii-char1.4 (call L.fun/ascii-char22153.5))
          (void2.3 (call L.fun/void22154.7))
          (boolean3.2 (call L.void?.10 (call L.fun/any22155.8)))
          (boolean4.1 (call L.ascii-char?.11 (call L.fun/any22156.4))))
      ascii-char1.4)))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
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
    (define L.fun/error22341.4 (lambda () 39998))
    (define L.fun/void22343.5 (lambda () 30))
    (define L.fun/empty22340.6 (lambda () 22))
    (define L.fun/empty22342.7 (lambda () 22))
    (define L.fun/void22344.8 (lambda () 30))
    (let ((empty0.5 (call L.fun/empty22340.6))
          (error1.4 (call L.fun/error22341.4))
          (empty2.3 (call L.fun/empty22342.7))
          (void3.2 (call L.fun/void22343.5))
          (void4.1 (call L.fun/void22344.8)))
      (call
       L.+.10
       (call L.-.11 (call L.+.10 1896 1696) (call L.+.10 544 1152))
       (call L.-.11 (call L.*.12 1576 384) (call L.*.12 1272 1816))))))
(check-by-interp
 '(module
    (define L.empty?.13
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 255) 22) 14 6)))
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
            (- tmp.23 tmp.24)
            830)
          830)))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.19 7) 0) 14 6) 6)
            (* tmp.19 (arithmetic-shift-right tmp.20 3))
            318)
          318)))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
            (+ tmp.21 tmp.22)
            574)
          574)))
    (define L.fun/ascii-char22583.4 (lambda () 25390))
    (define L.fun/any22584.5 (lambda () 22))
    (define L.fun/any22585.6 (lambda () 22))
    (define L.fun/empty22581.7 (lambda () 22))
    (define L.fun/ascii-char22582.8 (lambda () 25390))
    (let ((empty0.5 (call L.fun/empty22581.7))
          (fixnum1.4
           (call
            L.*.11
            (call L.*.11 (call L.+.10 800 368) (call L.+.10 1096 176))
            (call L.-.12 (call L.-.12 1480 1328) (call L.-.12 1552 792))))
          (ascii-char2.3 (call L.fun/ascii-char22582.8))
          (ascii-char3.2 (call L.fun/ascii-char22583.4))
          (boolean4.1 (call L.empty?.13 (call L.fun/any22584.5))))
      (call L.empty?.13 (call L.fun/any22585.6)))))
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
    (define L.empty?.8
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 255) 22) 14 6)))
    (define L.fun/void22702.4 (lambda () 30))
    (define L.fun/error22701.5 (lambda () 32062))
    (define L.fun/any22703.6 (lambda () 22))
    (let ((error0.5 (call L.fun/error22701.5))
          (void1.4 (call L.fun/void22702.4))
          (boolean2.3 (call L.empty?.8 (call L.fun/any22703.6)))
          (fixnum3.2
           (call
            L.*.10
            (call L.+.9 (call L.+.9 392 1776) (call L.*.10 1080 1216))
            (call L.*.10 (call L.+.9 232 1112) (call L.-.11 1536 1680))))
          (fixnum4.1
           (call
            L.*.10
            (call L.+.9 (call L.*.10 336 1376) (call L.+.9 528 200))
            (call L.*.10 (call L.+.9 128 584) (call L.-.11 648 176)))))
      void1.4)))
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
    (define L.fun/ascii-char23153.4 (lambda () 25390))
    (define L.fun/error23159.5 (lambda () 44862))
    (define L.fun/ascii-char23157.6 (lambda () 25390))
    (define L.fun/void23154.7 (lambda () (call L.fun/void23155.10)))
    (define L.fun/error23151.8 (lambda () 22846))
    (define L.fun/ascii-char23156.9 (lambda () (call L.fun/ascii-char23157.6)))
    (define L.fun/void23155.10 (lambda () 30))
    (define L.fun/error23150.11 (lambda () (call L.fun/error23151.8)))
    (define L.fun/error23158.12 (lambda () (call L.fun/error23159.5)))
    (define L.fun/ascii-char23152.13
      (lambda () (call L.fun/ascii-char23153.4)))
    (let ((error0.6 (call L.fun/error23150.11))
          (ascii-char1.5 (call L.fun/ascii-char23152.13))
          (void2.4 (call L.fun/void23154.7))
          (fixnum3.3
           (call
            L.+.15
            (call
             L.+.15
             (call L.+.15 (call L.+.15 1552 528) (call L.+.15 2008 1856))
             (call L.+.15 (call L.*.16 864 920) (call L.+.15 184 1752)))
            (call
             L.-.17
             (call L.-.17 (call L.*.16 1104 584) (call L.+.15 16 1432))
             (call L.-.17 (call L.*.16 736 1120) (call L.*.16 1952 1008)))))
          (ascii-char4.2 (call L.fun/ascii-char23156.9))
          (error5.1 (call L.fun/error23158.12)))
      error5.1)))
(check-by-interp
 '(module
    (define L.empty?.18
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 22) 14 6)))
    (define L.ascii-char?.17
      (lambda (tmp.47) (if (= (bitwise-and tmp.47 255) 46) 14 6)))
    (define L.fun/empty24557.4 (lambda () 22))
    (define L.fun/any24558.5 (lambda () 14))
    (define L.fun/error24555.6 (lambda () 56894))
    (define L.fun/ascii-char24562.7
      (lambda () (call L.fun/ascii-char24563.13)))
    (define L.fun/empty24560.8 (lambda () (call L.fun/empty24561.9)))
    (define L.fun/empty24561.9 (lambda () 22))
    (define L.fun/empty24556.10 (lambda () (call L.fun/empty24557.4)))
    (define L.fun/any24559.11 (lambda () 30))
    (define L.fun/error24552.12 (lambda () (call L.fun/error24553.14)))
    (define L.fun/ascii-char24563.13 (lambda () 25390))
    (define L.fun/error24553.14 (lambda () 52030))
    (define L.fun/error24554.15 (lambda () (call L.fun/error24555.6)))
    (let ((error0.6 (call L.fun/error24552.12))
          (error1.5 (call L.fun/error24554.15))
          (empty2.4 (call L.fun/empty24556.10))
          (boolean3.3 (call L.ascii-char?.17 (call L.fun/any24558.5)))
          (boolean4.2 (call L.empty?.18 (call L.fun/any24559.11)))
          (empty5.1 (call L.fun/empty24560.8)))
      (call L.fun/ascii-char24562.7))))
(check-by-interp
 '(module
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.13
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.fun/ascii-char29402.4 (lambda () 25390))
    (define L.fun/empty29399.5 (lambda () (call L.fun/empty29400.10)))
    (define L.fun/ascii-char29401.6 (lambda () (call L.fun/ascii-char29402.4)))
    (define L.fun/empty29404.7 (lambda () 22))
    (define L.fun/ascii-char29406.8 (lambda () 25390))
    (define L.fun/ascii-char29405.9 (lambda () (call L.fun/ascii-char29406.8)))
    (define L.fun/empty29400.10 (lambda () 22))
    (define L.fun/empty29403.11 (lambda () (call L.fun/empty29404.7)))
    (let ((empty0.6 (call L.fun/empty29399.5))
          (ascii-char1.5 (call L.fun/ascii-char29401.6))
          (empty2.4 (call L.fun/empty29403.11))
          (fixnum3.3
           (call
            L.-.14
            (call
             L.+.13
             (call L.*.15 (call L.+.13 1888 1096) (call L.-.14 1056 216))
             (call L.*.15 (call L.-.14 888 184) (call L.-.14 0 960)))
            (call
             L.-.14
             (call L.*.15 (call L.-.14 1976 856) (call L.-.14 1616 1960))
             (call L.+.13 (call L.-.14 1592 392) (call L.*.15 1152 416)))))
          (fixnum4.2
           (call
            L.-.14
            (call
             L.+.13
             (call L.*.15 (call L.+.13 1160 784) (call L.-.14 400 288))
             (call L.-.14 (call L.*.15 640 360) (call L.*.15 912 1856)))
            (call
             L.*.15
             (call L.-.14 (call L.*.15 360 1936) (call L.-.14 512 296))
             (call L.+.13 (call L.*.15 120 704) (call L.*.15 328 936)))))
          (ascii-char5.1 (call L.fun/ascii-char29405.9)))
      (call
       L.*.15
       (call
        L.*.15
        (call L.+.13 (call L.-.14 fixnum4.2 fixnum3.3) fixnum3.3)
        fixnum3.3)
       (call
        L.-.14
        fixnum4.2
        (call L.-.14 fixnum4.2 (call L.-.14 344 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.empty?.17
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 22) 14 6)))
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
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.fun/void31691.4 (lambda () 30))
    (define L.fun/void31695.5 (lambda () (call L.fun/void31696.11)))
    (define L.fun/any31694.6 (lambda () 25390))
    (define L.fun/empty31692.7 (lambda () (call L.fun/empty31693.9)))
    (define L.fun/void31690.8 (lambda () (call L.fun/void31691.4)))
    (define L.fun/empty31693.9 (lambda () 22))
    (define L.fun/empty31688.10 (lambda () (call L.fun/empty31689.12)))
    (define L.fun/void31696.11 (lambda () 30))
    (define L.fun/empty31689.12 (lambda () 22))
    (let ((empty0.6 (call L.fun/empty31688.10))
          (fixnum1.5
           (call
            L.-.14
            (call
             L.-.14
             (call L.+.16 (call L.-.14 272 624) (call L.*.15 264 920))
             (call L.+.16 (call L.*.15 904 24) (call L.*.15 1856 1768)))
            (call
             L.-.14
             (call L.+.16 (call L.*.15 1264 1680) (call L.*.15 704 104))
             (call L.-.14 (call L.*.15 1456 752) (call L.-.14 640 2024)))))
          (void2.4 (call L.fun/void31690.8))
          (empty3.3 (call L.fun/empty31692.7))
          (boolean4.2 (call L.empty?.17 (call L.fun/any31694.6)))
          (void5.1 (call L.fun/void31695.5)))
      empty0.6)))
(check-by-interp
 '(module
    (define L.fun/error41241.4 (lambda () (call L.fun/error41242.12)))
    (define L.fun/void41237.5 (lambda () (call L.fun/void41238.13)))
    (define L.fun/error41233.6 (lambda () (call L.fun/error41234.9)))
    (define L.fun/void41232.7 (lambda () 30))
    (define L.fun/error41236.8 (lambda () 574))
    (define L.fun/error41234.9 (lambda () 8510))
    (define L.fun/ascii-char41240.10 (lambda () 25390))
    (define L.fun/void41231.11 (lambda () (call L.fun/void41232.7)))
    (define L.fun/error41242.12 (lambda () 28222))
    (define L.fun/void41238.13 (lambda () 30))
    (define L.fun/empty41244.14 (lambda () 22))
    (define L.fun/error41235.15 (lambda () (call L.fun/error41236.8)))
    (define L.fun/empty41243.16 (lambda () (call L.fun/empty41244.14)))
    (define L.fun/ascii-char41239.17
      (lambda () (call L.fun/ascii-char41240.10)))
    (let ((void0.6 (call L.fun/void41231.11))
          (error1.5 (call L.fun/error41233.6))
          (error2.4 (call L.fun/error41235.15))
          (void3.3 (call L.fun/void41237.5))
          (ascii-char4.2 (call L.fun/ascii-char41239.17))
          (error5.1 (call L.fun/error41241.4)))
      (call L.fun/empty41243.16))))
(check-by-interp
 '(module
    (define L.void?.17
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
    (define L.fixnum?.16
      (lambda (tmp.43) (if (= (bitwise-and tmp.43 7) 0) 14 6)))
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
    (define L.fun/void44609.4 (lambda () (call L.fun/void44610.9)))
    (define L.fun/error44607.5 (lambda () 64830))
    (define L.fun/any44605.6 (lambda () 22))
    (define L.fun/error44606.7 (lambda () (call L.fun/error44607.5)))
    (define L.fun/any44608.8 (lambda () 30))
    (define L.fun/void44610.9 (lambda () 30))
    (define L.fun/ascii-char44603.10
      (lambda () (call L.fun/ascii-char44604.11)))
    (define L.fun/ascii-char44604.11 (lambda () 25390))
    (let ((fixnum0.6
           (call
            L.+.15
            (call
             L.+.15
             (call L.-.13 (call L.-.13 1640 824) (call L.*.14 1256 16))
             (call L.+.15 (call L.+.15 768 1552) (call L.*.14 1352 1336)))
            (call
             L.*.14
             (call L.*.14 (call L.*.14 1408 1032) (call L.+.15 944 160))
             (call L.-.13 (call L.*.14 1280 736) (call L.*.14 648 848)))))
          (ascii-char1.5 (call L.fun/ascii-char44603.10))
          (boolean2.4 (call L.fixnum?.16 (call L.fun/any44605.6)))
          (error3.3 (call L.fun/error44606.7))
          (boolean4.2 (call L.void?.17 (call L.fun/any44608.8)))
          (void5.1 (call L.fun/void44609.4)))
      void5.1)))
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
    (define L.fun/error47015.4 (lambda () (call L.fun/error47016.10)))
    (define L.fun/empty47018.5 (lambda () 22))
    (define L.fun/void47024.6 (lambda () 30))
    (define L.fun/void47023.7 (lambda () (call L.fun/void47024.6)))
    (define L.fun/empty47020.8 (lambda () 22))
    (define L.fun/empty47017.9 (lambda () (call L.fun/empty47018.5)))
    (define L.fun/error47016.10 (lambda () 30270))
    (define L.fun/ascii-char47022.11 (lambda () 25390))
    (define L.fun/ascii-char47021.12
      (lambda () (call L.fun/ascii-char47022.11)))
    (define L.fun/empty47019.13 (lambda () (call L.fun/empty47020.8)))
    (let ((error0.6 (call L.fun/error47015.4))
          (empty1.5 (call L.fun/empty47017.9))
          (empty2.4 (call L.fun/empty47019.13))
          (ascii-char3.3 (call L.fun/ascii-char47021.12))
          (fixnum4.2
           (call
            L.+.17
            (call
             L.*.15
             (call L.+.17 (call L.*.15 1032 1632) (call L.-.16 48 264))
             (call L.*.15 (call L.+.17 664 1320) (call L.*.15 1672 1736)))
            (call
             L.*.15
             (call L.*.15 (call L.*.15 1344 704) (call L.+.17 1584 1992))
             (call L.+.17 (call L.-.16 1248 1016) (call L.*.15 656 1552)))))
          (fixnum5.1
           (call
            L.*.15
            (call
             L.-.16
             (call L.-.16 (call L.+.17 1864 592) (call L.*.15 392 2016))
             (call L.+.17 (call L.*.15 1408 496) (call L.+.17 96 1344)))
            (call
             L.*.15
             (call L.+.17 (call L.-.16 1096 464) (call L.+.17 1792 1896))
             (call L.+.17 (call L.*.15 480 160) (call L.-.16 496 600))))))
      (call L.fun/void47023.7))))
(check-by-interp
 '(module
    (define L.void?.15
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.13
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.fun/error48429.4 (lambda () 31550))
    (define L.fun/void48432.5 (lambda () (call L.fun/void48433.10)))
    (define L.fun/empty48430.6 (lambda () (call L.fun/empty48431.7)))
    (define L.fun/empty48431.7 (lambda () 22))
    (define L.fun/any48434.8 (lambda () 22))
    (define L.fun/error48428.9 (lambda () (call L.fun/error48429.4)))
    (define L.fun/void48433.10 (lambda () 30))
    (let ((fixnum0.6
           (call
            L.+.13
            (call
             L.+.13
             (call L.-.12 (call L.-.12 1920 2016) (call L.+.13 1576 1296))
             (call L.-.12 (call L.*.14 1344 1384) (call L.-.12 1360 376)))
            (call
             L.-.12
             (call L.*.14 (call L.+.13 8 1448) (call L.*.14 1912 1976))
             (call L.+.13 (call L.-.12 1376 1176) (call L.-.12 64 392)))))
          (fixnum1.5
           (call
            L.-.12
            (call
             L.*.14
             (call L.+.13 (call L.*.14 520 1584) (call L.+.13 1424 1912))
             (call L.+.13 (call L.-.12 1416 56) (call L.-.12 1928 496)))
            (call
             L.-.12
             (call L.-.12 (call L.*.14 1672 1336) (call L.-.12 432 1496))
             (call L.-.12 (call L.*.14 1000 2008) (call L.*.14 1152 1552)))))
          (error2.4 (call L.fun/error48428.9))
          (empty3.3 (call L.fun/empty48430.6))
          (void4.2 (call L.fun/void48432.5))
          (boolean5.1 (call L.void?.15 (call L.fun/any48434.8))))
      fixnum0.6)))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.18
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.fun/ascii-char52445.4 (lambda () 25390))
    (define L.fun/void52451.5 (lambda () 30))
    (define L.fun/ascii-char52442.6
      (lambda () (call L.fun/ascii-char52443.14)))
    (define L.fun/error52440.7 (lambda () (call L.fun/error52441.15)))
    (define L.fun/ascii-char52449.8 (lambda () 25390))
    (define L.fun/ascii-char52448.9 (lambda () (call L.fun/ascii-char52449.8)))
    (define L.fun/void52450.10 (lambda () (call L.fun/void52451.5)))
    (define L.fun/empty52447.11 (lambda () 22))
    (define L.fun/empty52446.12 (lambda () (call L.fun/empty52447.11)))
    (define L.fun/ascii-char52444.13
      (lambda () (call L.fun/ascii-char52445.4)))
    (define L.fun/ascii-char52443.14 (lambda () 25390))
    (define L.fun/error52441.15 (lambda () 62782))
    (let ((error0.6 (call L.fun/error52440.7))
          (ascii-char1.5 (call L.fun/ascii-char52442.6))
          (ascii-char2.4 (call L.fun/ascii-char52444.13))
          (empty3.3 (call L.fun/empty52446.12))
          (ascii-char4.2 (call L.fun/ascii-char52448.9))
          (fixnum5.1
           (call
            L.+.19
            (call
             L.-.18
             (call L.-.18 (call L.*.17 1688 1200) (call L.-.18 936 1136))
             (call L.+.19 (call L.+.19 648 1344) (call L.-.18 1760 696)))
            (call
             L.*.17
             (call L.*.17 (call L.*.17 440 1136) (call L.+.19 1032 1608))
             (call L.*.17 (call L.-.18 1032 8) (call L.-.18 0 1704))))))
      (call L.fun/void52450.10))))
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
    (define L.boolean?.14
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
    (define L.fun/ascii-char59064.4 (lambda () (call L.fun/ascii-char59065.9)))
    (define L.fun/ascii-char59068.5
      (lambda () (call L.fun/ascii-char59069.12)))
    (define L.fun/any59063.6 (lambda () 30))
    (define L.fun/ascii-char59070.7
      (lambda () (call L.fun/ascii-char59071.11)))
    (define L.fun/empty59066.8 (lambda () (call L.fun/empty59067.10)))
    (define L.fun/ascii-char59065.9 (lambda () 25390))
    (define L.fun/empty59067.10 (lambda () 22))
    (define L.fun/ascii-char59071.11 (lambda () 25390))
    (define L.fun/ascii-char59069.12 (lambda () 25390))
    (let ((boolean0.6 (call L.boolean?.14 (call L.fun/any59063.6)))
          (fixnum1.5
           (call
            L.-.17
            (call
             L.+.16
             (call L.+.16 (call L.*.15 168 48) (call L.+.16 1464 352))
             (call L.+.16 (call L.*.15 504 1888) (call L.+.16 368 544)))
            (call
             L.*.15
             (call L.+.16 (call L.+.16 1848 1952) (call L.+.16 1928 1568))
             (call L.-.17 (call L.+.16 504 720) (call L.-.17 1264 8)))))
          (ascii-char2.4 (call L.fun/ascii-char59064.4))
          (empty3.3 (call L.fun/empty59066.8))
          (ascii-char4.2 (call L.fun/ascii-char59068.5))
          (ascii-char5.1 (call L.fun/ascii-char59070.7)))
      fixnum1.5)))
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
    (define L.fun/empty59449.4 (lambda () (call L.fun/empty59450.8)))
    (define L.fun/ascii-char59447.5
      (lambda () (call L.fun/ascii-char59448.13)))
    (define L.fun/error59452.6 (lambda () 6718))
    (define L.fun/void59454.7 (lambda () 30))
    (define L.fun/empty59450.8 (lambda () 22))
    (define L.fun/ascii-char59445.9
      (lambda () (call L.fun/ascii-char59446.10)))
    (define L.fun/ascii-char59446.10 (lambda () 25390))
    (define L.fun/void59453.11 (lambda () (call L.fun/void59454.7)))
    (define L.fun/error59451.12 (lambda () (call L.fun/error59452.6)))
    (define L.fun/ascii-char59448.13 (lambda () 25390))
    (let ((ascii-char0.6 (call L.fun/ascii-char59445.9))
          (ascii-char1.5 (call L.fun/ascii-char59447.5))
          (empty2.4 (call L.fun/empty59449.4))
          (error3.3 (call L.fun/error59451.12))
          (fixnum4.2
           (call
            L.-.17
            (call
             L.*.15
             (call L.*.15 (call L.*.15 976 1688) (call L.+.16 880 648))
             (call L.*.15 (call L.*.15 2024 760) (call L.-.17 432 248)))
            (call
             L.+.16
             (call L.+.16 (call L.-.17 256 1456) (call L.+.16 880 408))
             (call L.+.16 (call L.+.16 832 640) (call L.-.17 0 1232)))))
          (void5.1 (call L.fun/void59453.11)))
      error3.3)))
(check-by-interp
 '(module
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.boolean?.14
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
    (define L.void?.13
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
    (define L.fun/ascii-char72180.4 (lambda () (call L.fun/ascii-char72181.7)))
    (define L.fun/ascii-char72175.5
      (lambda () (call L.fun/ascii-char72176.11)))
    (define L.fun/void72177.6 (lambda () (call L.fun/void72178.8)))
    (define L.fun/ascii-char72181.7 (lambda () 25390))
    (define L.fun/void72178.8 (lambda () 30))
    (define L.fun/any72179.9 (lambda () 25390))
    (define L.fun/any72182.10 (lambda () 19774))
    (define L.fun/ascii-char72176.11 (lambda () 25390))
    (let ((ascii-char0.6 (call L.fun/ascii-char72175.5))
          (void1.5 (call L.fun/void72177.6))
          (boolean2.4 (call L.void?.13 (call L.fun/any72179.9)))
          (ascii-char3.3 (call L.fun/ascii-char72180.4))
          (boolean4.2 (call L.boolean?.14 (call L.fun/any72182.10)))
          (fixnum5.1
           (call
            L.+.16
            (call
             L.-.15
             (call L.+.16 (call L.-.15 256 264) (call L.-.15 968 1384))
             (call L.-.15 (call L.*.17 1672 1272) (call L.+.16 1976 1896)))
            (call
             L.+.16
             (call L.+.16 (call L.-.15 1976 1272) (call L.-.15 112 872))
             (call L.+.16 (call L.*.17 304 1464) (call L.+.16 1424 1920))))))
      ascii-char3.3)))
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
    (define L.fun/empty76147.4 (lambda () (call L.fun/empty76148.12)))
    (define L.fun/empty76144.5 (lambda () 22))
    (define L.fun/ascii-char76150.6 (lambda () 25390))
    (define L.fun/void76152.7 (lambda () 30))
    (define L.fun/void76145.8 (lambda () (call L.fun/void76146.11)))
    (define L.fun/ascii-char76149.9 (lambda () (call L.fun/ascii-char76150.6)))
    (define L.fun/empty76143.10 (lambda () (call L.fun/empty76144.5)))
    (define L.fun/void76146.11 (lambda () 30))
    (define L.fun/empty76148.12 (lambda () 22))
    (define L.fun/void76151.13 (lambda () (call L.fun/void76152.7)))
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.-.15
             (call L.+.17 (call L.-.15 1240 1880) (call L.*.16 760 864))
             (call L.*.16 (call L.+.17 224 1384) (call L.-.15 1824 232)))
            (call
             L.*.16
             (call L.*.16 (call L.+.17 536 744) (call L.+.17 1920 128))
             (call L.+.17 (call L.-.15 512 688) (call L.+.17 408 1176)))))
          (empty1.5 (call L.fun/empty76143.10))
          (void2.4 (call L.fun/void76145.8))
          (empty3.3 (call L.fun/empty76147.4))
          (ascii-char4.2 (call L.fun/ascii-char76149.9))
          (void5.1 (call L.fun/void76151.13)))
      (call
       L.*.16
       (call L.*.16 fixnum0.6 fixnum0.6)
       (call
        L.-.15
        (call L.+.17 (call L.-.15 fixnum0.6 fixnum0.6) fixnum0.6)
        (call L.-.15 fixnum0.6 (call L.-.15 688 fixnum0.6)))))))
(check-by-interp
 '(module
    (define L.fun/empty82623.4 (lambda () 22))
    (define L.fun/void82617.5 (lambda () 30))
    (define L.fun/error82624.6 (lambda () (call L.fun/error82625.7)))
    (define L.fun/error82625.7 (lambda () 59454))
    (define L.fun/ascii-char82621.8 (lambda () 25390))
    (define L.fun/error82619.9 (lambda () 39998))
    (define L.fun/error82618.10 (lambda () (call L.fun/error82619.9)))
    (define L.fun/ascii-char82627.11 (lambda () 25390))
    (define L.fun/empty82622.12 (lambda () (call L.fun/empty82623.4)))
    (define L.fun/ascii-char82620.13
      (lambda () (call L.fun/ascii-char82621.8)))
    (define L.fun/ascii-char82626.14
      (lambda () (call L.fun/ascii-char82627.11)))
    (define L.fun/void82616.15 (lambda () (call L.fun/void82617.5)))
    (let ((void0.6 (call L.fun/void82616.15))
          (error1.5 (call L.fun/error82618.10))
          (ascii-char2.4 (call L.fun/ascii-char82620.13))
          (empty3.3 (call L.fun/empty82622.12))
          (error4.2 (call L.fun/error82624.6))
          (ascii-char5.1 (call L.fun/ascii-char82626.14)))
      empty3.3)))
(check-by-interp
 '(module
    (define L.fun/empty86209.4 (lambda () (call L.fun/empty86210.13)))
    (define L.fun/void86206.5 (lambda () 30))
    (define L.fun/ascii-char86207.6
      (lambda () (call L.fun/ascii-char86208.15)))
    (define L.fun/empty86211.7 (lambda () (call L.fun/empty86212.16)))
    (define L.fun/empty86201.8 (lambda () (call L.fun/empty86202.12)))
    (define L.fun/error86214.9 (lambda () 21310))
    (define L.fun/void86205.10 (lambda () (call L.fun/void86206.5)))
    (define L.fun/empty86203.11 (lambda () (call L.fun/empty86204.14)))
    (define L.fun/empty86202.12 (lambda () 22))
    (define L.fun/empty86210.13 (lambda () 22))
    (define L.fun/empty86204.14 (lambda () 22))
    (define L.fun/ascii-char86208.15 (lambda () 25390))
    (define L.fun/empty86212.16 (lambda () 22))
    (define L.fun/error86213.17 (lambda () (call L.fun/error86214.9)))
    (let ((empty0.6 (call L.fun/empty86201.8))
          (empty1.5 (call L.fun/empty86203.11))
          (void2.4 (call L.fun/void86205.10))
          (ascii-char3.3 (call L.fun/ascii-char86207.6))
          (empty4.2 (call L.fun/empty86209.4))
          (empty5.1 (call L.fun/empty86211.7)))
      (call L.fun/error86213.17))))
(check-by-interp
 '(module
    (define L.-.19
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.+.18
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.empty?.16
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 22) 14 6)))
    (define L.fun/any89588.4 (lambda () 1840))
    (define L.fun/void89590.5 (lambda () 30))
    (define L.fun/void89587.6 (lambda () 30))
    (define L.fun/error89592.7 (lambda () 5438))
    (define L.fun/void89594.8 (lambda () 30))
    (define L.fun/void89595.9 (lambda () (call L.fun/void89596.11)))
    (define L.fun/void89586.10 (lambda () (call L.fun/void89587.6)))
    (define L.fun/void89596.11 (lambda () 30))
    (define L.fun/error89591.12 (lambda () (call L.fun/error89592.7)))
    (define L.fun/void89593.13 (lambda () (call L.fun/void89594.8)))
    (define L.fun/void89589.14 (lambda () (call L.fun/void89590.5)))
    (let ((void0.6 (call L.fun/void89586.10))
          (boolean1.5 (call L.empty?.16 (call L.fun/any89588.4)))
          (void2.4 (call L.fun/void89589.14))
          (error3.3 (call L.fun/error89591.12))
          (void4.2 (call L.fun/void89593.13))
          (void5.1 (call L.fun/void89595.9)))
      (call
       L.*.17
       (call
        L.*.17
        (call L.+.18 (call L.*.17 144 1632) (call L.*.17 1464 1416))
        (call L.-.19 (call L.+.18 1152 1064) (call L.-.19 1096 832)))
       (call
        L.*.17
        (call L.*.17 (call L.+.18 688 248) (call L.*.17 2000 240))
        (call L.+.18 (call L.+.18 800 1040) (call L.*.17 1224 312)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char91899.4 (lambda () 25390))
    (define L.fun/ascii-char91896.5
      (lambda () (call L.fun/ascii-char91897.12)))
    (define L.fun/empty91891.6 (lambda () 22))
    (define L.fun/empty91890.7 (lambda () (call L.fun/empty91891.6)))
    (define L.fun/ascii-char91892.8
      (lambda () (call L.fun/ascii-char91893.15)))
    (define L.fun/ascii-char91898.9 (lambda () (call L.fun/ascii-char91899.4)))
    (define L.fun/ascii-char91894.10
      (lambda () (call L.fun/ascii-char91895.14)))
    (define L.fun/error91900.11 (lambda () (call L.fun/error91901.13)))
    (define L.fun/ascii-char91897.12 (lambda () 25390))
    (define L.fun/error91901.13 (lambda () 33086))
    (define L.fun/ascii-char91895.14 (lambda () 25390))
    (define L.fun/ascii-char91893.15 (lambda () 25390))
    (let ((empty0.6 (call L.fun/empty91890.7))
          (ascii-char1.5 (call L.fun/ascii-char91892.8))
          (ascii-char2.4 (call L.fun/ascii-char91894.10))
          (ascii-char3.3 (call L.fun/ascii-char91896.5))
          (ascii-char4.2 (call L.fun/ascii-char91898.9))
          (error5.1 (call L.fun/error91900.11)))
      empty0.6)))
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
    (define L.fun/empty93185.4 (lambda () (call L.fun/empty93186.9)))
    (define L.fun/void93187.5 (lambda () (call L.fun/void93188.11)))
    (define L.fun/error93189.6 (lambda () (call L.fun/error93190.7)))
    (define L.fun/error93190.7 (lambda () 9790))
    (define L.fun/void93193.8 (lambda () (call L.fun/void93194.12)))
    (define L.fun/empty93186.9 (lambda () 22))
    (define L.fun/error93192.10 (lambda () 19774))
    (define L.fun/void93188.11 (lambda () 30))
    (define L.fun/void93194.12 (lambda () 30))
    (define L.fun/error93191.13 (lambda () (call L.fun/error93192.10)))
    (let ((empty0.6 (call L.fun/empty93185.4))
          (void1.5 (call L.fun/void93187.5))
          (fixnum2.4
           (call
            L.*.15
            (call
             L.*.15
             (call L.+.17 (call L.*.15 1832 1640) (call L.-.16 1376 208))
             (call L.+.17 (call L.-.16 816 40) (call L.*.15 1728 1448)))
            (call
             L.-.16
             (call L.-.16 (call L.+.17 752 1096) (call L.-.16 592 1592))
             (call L.-.16 (call L.+.17 200 2000) (call L.-.16 1136 192)))))
          (error3.3 (call L.fun/error93189.6))
          (error4.2 (call L.fun/error93191.13))
          (void5.1 (call L.fun/void93193.8)))
      (call
       L.+.17
       (call
        L.-.16
        (call L.+.17 fixnum2.4 fixnum2.4)
        (call
         L.+.17
         (call L.*.15 fixnum2.4 1464)
         (call L.*.15 fixnum2.4 1752)))
       (call L.-.16 fixnum2.4 fixnum2.4)))))
(check-by-interp
 '(module
    (define L.vector?.17
      (lambda (tmp.50) (if (= (bitwise-and tmp.50 7) 3) 14 6)))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
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
    (define L.fun/ascii-char103343.4 (lambda () 25390))
    (define L.fun/error103339.5 (lambda () (call L.fun/error103340.7)))
    (define L.fun/ascii-char103337.6
      (lambda () (call L.fun/ascii-char103338.12)))
    (define L.fun/error103340.7 (lambda () 41534))
    (define L.fun/ascii-char103342.8
      (lambda () (call L.fun/ascii-char103343.4)))
    (define L.fun/empty103336.9 (lambda () 22))
    (define L.fun/any103341.10 (lambda () 14))
    (define L.fun/empty103335.11 (lambda () (call L.fun/empty103336.9)))
    (define L.fun/ascii-char103338.12 (lambda () 25390))
    (let ((empty0.6 (call L.fun/empty103335.11))
          (ascii-char1.5 (call L.fun/ascii-char103337.6))
          (fixnum2.4
           (call
            L.+.15
            (call
             L.-.16
             (call L.+.15 (call L.*.14 1880 168) (call L.+.15 104 136))
             (call L.*.14 (call L.*.14 352 744) (call L.+.15 456 1920)))
            (call
             L.+.15
             (call L.*.14 (call L.+.15 1888 168) (call L.*.14 464 64))
             (call L.+.15 (call L.+.15 352 160) (call L.+.15 1152 1512)))))
          (error3.3 (call L.fun/error103339.5))
          (boolean4.2 (call L.vector?.17 (call L.fun/any103341.10)))
          (ascii-char5.1 (call L.fun/ascii-char103342.8)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fixnum?.16
      (lambda (tmp.43) (if (= (bitwise-and tmp.43 7) 0) 14 6)))
    (define L.fun/void111249.4 (lambda () (call L.fun/void111250.14)))
    (define L.fun/error111259.5 (lambda () 36670))
    (define L.fun/error111258.6 (lambda () (call L.fun/error111259.5)))
    (define L.fun/any111257.7 (lambda () 22))
    (define L.fun/ascii-char111255.8
      (lambda () (call L.fun/ascii-char111256.12)))
    (define L.fun/error111254.9 (lambda () 58430))
    (define L.fun/error111253.10 (lambda () (call L.fun/error111254.9)))
    (define L.fun/ascii-char111251.11
      (lambda () (call L.fun/ascii-char111252.13)))
    (define L.fun/ascii-char111256.12 (lambda () 25390))
    (define L.fun/ascii-char111252.13 (lambda () 25390))
    (define L.fun/void111250.14 (lambda () 30))
    (let ((void0.6 (call L.fun/void111249.4))
          (ascii-char1.5 (call L.fun/ascii-char111251.11))
          (error2.4 (call L.fun/error111253.10))
          (ascii-char3.3 (call L.fun/ascii-char111255.8))
          (boolean4.2 (call L.fixnum?.16 (call L.fun/any111257.7)))
          (error5.1 (call L.fun/error111258.6)))
      error2.4)))
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
    (define L.fun/void112730.4 (lambda () (call L.fun/void112731.8)))
    (define L.fun/ascii-char112724.5
      (lambda () (call L.fun/ascii-char112725.9)))
    (define L.fun/void112726.6 (lambda () (call L.fun/void112727.13)))
    (define L.fun/empty112733.7 (lambda () 22))
    (define L.fun/void112731.8 (lambda () 30))
    (define L.fun/ascii-char112725.9 (lambda () 25390))
    (define L.fun/void112728.10 (lambda () (call L.fun/void112729.12)))
    (define L.fun/empty112732.11 (lambda () (call L.fun/empty112733.7)))
    (define L.fun/void112729.12 (lambda () 30))
    (define L.fun/void112727.13 (lambda () 30))
    (let ((ascii-char0.6 (call L.fun/ascii-char112724.5))
          (void1.5 (call L.fun/void112726.6))
          (void2.4 (call L.fun/void112728.10))
          (fixnum3.3
           (call
            L.+.17
            (call
             L.-.16
             (call L.-.16 (call L.*.15 984 328) (call L.*.15 728 888))
             (call L.-.16 (call L.-.16 600 1776) (call L.*.15 1904 1456)))
            (call
             L.-.16
             (call L.+.17 (call L.-.16 1272 1536) (call L.*.15 1056 912))
             (call L.-.16 (call L.+.17 1448 1496) (call L.-.16 568 344)))))
          (void4.2 (call L.fun/void112730.4))
          (empty5.1 (call L.fun/empty112732.11)))
      (call
       L.+.17
       (call
        L.*.15
        (call L.+.17 fixnum3.3 (call L.-.16 fixnum3.3 1192))
        fixnum3.3)
       (call
        L.*.15
        fixnum3.3
        (call L.*.15 (call L.+.17 fixnum3.3 312) fixnum3.3))))))
(check-by-interp
 '(module
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.*.12
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.11
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.fun/ascii-char117132.4
      (lambda () (call L.fun/ascii-char117133.9)))
    (define L.fun/ascii-char117129.5 (lambda () 25390))
    (define L.fun/ascii-char117130.6
      (lambda () (call L.fun/ascii-char117131.8)))
    (define L.fun/ascii-char117128.7
      (lambda () (call L.fun/ascii-char117129.5)))
    (define L.fun/ascii-char117131.8 (lambda () 25390))
    (define L.fun/ascii-char117133.9 (lambda () 25390))
    (let ((ascii-char0.6 (call L.fun/ascii-char117128.7))
          (fixnum1.5
           (call
            L.+.11
            (call
             L.*.12
             (call L.*.12 (call L.+.11 176 552) (call L.*.12 1824 144))
             (call L.-.13 (call L.+.11 984 1264) (call L.*.12 32 1280)))
            (call
             L.+.11
             (call L.+.11 (call L.-.13 1536 1416) (call L.*.12 1072 616))
             (call L.+.11 (call L.+.11 384 1976) (call L.+.11 400 1288)))))
          (ascii-char2.4 (call L.fun/ascii-char117130.6))
          (fixnum3.3
           (call
            L.*.12
            (call
             L.+.11
             (call L.+.11 (call L.-.13 576 1344) (call L.+.11 528 1816))
             (call L.-.13 (call L.-.13 1160 864) (call L.+.11 1360 96)))
            (call
             L.-.13
             (call L.*.12 (call L.+.11 240 344) (call L.*.12 1928 1080))
             (call L.*.12 (call L.+.11 808 448) (call L.+.11 1296 2000)))))
          (ascii-char4.2 (call L.fun/ascii-char117132.4))
          (fixnum5.1
           (call
            L.+.11
            (call
             L.+.11
             (call L.-.13 (call L.*.12 1672 1456) (call L.+.11 1696 480))
             (call L.*.12 (call L.-.13 320 616) (call L.*.12 1016 1056)))
            (call
             L.-.13
             (call L.-.13 (call L.*.12 832 1176) (call L.-.13 248 328))
             (call L.-.13 (call L.+.11 920 1952) (call L.*.12 320 1000))))))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.empty?.17
      (lambda (tmp.45) (if (= (bitwise-and tmp.45 255) 22) 14 6)))
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
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.fun/void117486.4 (lambda () 30))
    (define L.fun/any117487.5 (lambda () 6))
    (define L.fun/void117490.6 (lambda () (call L.fun/void117491.11)))
    (define L.fun/error117483.7 (lambda () (call L.fun/error117484.12)))
    (define L.fun/empty117489.8 (lambda () 22))
    (define L.fun/void117485.9 (lambda () (call L.fun/void117486.4)))
    (define L.fun/empty117488.10 (lambda () (call L.fun/empty117489.8)))
    (define L.fun/void117491.11 (lambda () 30))
    (define L.fun/error117484.12 (lambda () 5182))
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.+.14
             (call L.+.14 (call L.+.14 984 1440) (call L.-.15 608 592))
             (call L.+.14 (call L.*.16 256 1672) (call L.*.16 1728 648)))
            (call
             L.-.15
             (call L.*.16 (call L.-.15 320 1552) (call L.*.16 1760 1760))
             (call L.*.16 (call L.-.15 1272 1384) (call L.-.15 1856 1192)))))
          (error1.5 (call L.fun/error117483.7))
          (void2.4 (call L.fun/void117485.9))
          (boolean3.3 (call L.empty?.17 (call L.fun/any117487.5)))
          (empty4.2 (call L.fun/empty117488.10))
          (void5.1 (call L.fun/void117490.6)))
      empty4.2)))
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
    (define L.fun/void118048.4 (lambda () (call L.fun/void118049.8)))
    (define L.fun/ascii-char118051.5 (lambda () 25390))
    (define L.fun/void118045.6 (lambda () 30))
    (define L.fun/error118053.7 (lambda () 47678))
    (define L.fun/void118049.8 (lambda () 30))
    (define L.fun/void118046.9 (lambda () (call L.fun/void118047.11)))
    (define L.fun/void118044.10 (lambda () (call L.fun/void118045.6)))
    (define L.fun/void118047.11 (lambda () 30))
    (define L.fun/error118052.12 (lambda () (call L.fun/error118053.7)))
    (define L.fun/ascii-char118050.13
      (lambda () (call L.fun/ascii-char118051.5)))
    (let ((void0.6 (call L.fun/void118044.10))
          (void1.5 (call L.fun/void118046.9))
          (void2.4 (call L.fun/void118048.4))
          (ascii-char3.3 (call L.fun/ascii-char118050.13))
          (error4.2 (call L.fun/error118052.12))
          (fixnum5.1
           (call
            L.*.16
            (call
             L.*.16
             (call L.*.16 (call L.+.15 528 1240) (call L.+.15 1216 1304))
             (call L.+.15 (call L.-.17 1552 936) (call L.+.15 1888 760)))
            (call
             L.*.16
             (call L.-.17 (call L.*.16 384 776) (call L.-.17 1824 800))
             (call L.+.15 (call L.+.15 976 1200) (call L.-.17 1504 1864))))))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.pair?.18
      (lambda (tmp.49) (if (= (bitwise-and tmp.49 7) 1) 14 6)))
    (define L.fun/void123827.4 (lambda () (call L.fun/void123828.8)))
    (define L.fun/empty123825.5 (lambda () (call L.fun/empty123826.10)))
    (define L.fun/empty123831.6 (lambda () (call L.fun/empty123832.14)))
    (define L.fun/error123823.7 (lambda () (call L.fun/error123824.15)))
    (define L.fun/void123828.8 (lambda () 30))
    (define L.fun/any123822.9 (lambda () 25390))
    (define L.fun/empty123826.10 (lambda () 22))
    (define L.fun/error123830.11 (lambda () 42814))
    (define L.fun/error123829.12 (lambda () (call L.fun/error123830.11)))
    (define L.fun/ascii-char123833.13
      (lambda () (call L.fun/ascii-char123834.16)))
    (define L.fun/empty123832.14 (lambda () 22))
    (define L.fun/error123824.15 (lambda () 32062))
    (define L.fun/ascii-char123834.16 (lambda () 25390))
    (let ((boolean0.6 (call L.pair?.18 (call L.fun/any123822.9)))
          (error1.5 (call L.fun/error123823.7))
          (empty2.4 (call L.fun/empty123825.5))
          (void3.3 (call L.fun/void123827.4))
          (error4.2 (call L.fun/error123829.12))
          (empty5.1 (call L.fun/empty123831.6)))
      (call L.fun/ascii-char123833.13))))
(check-by-interp
 '(module
    (define L.error?.15
      (lambda (tmp.48) (if (= (bitwise-and tmp.48 255) 62) 14 6)))
    (define L.boolean?.14
      (lambda (tmp.44) (if (= (bitwise-and tmp.44 247) 6) 14 6)))
    (define L.void?.13
      (lambda (tmp.46) (if (= (bitwise-and tmp.46 255) 30) 14 6)))
    (define L.*.12
      (lambda (tmp.20 tmp.21)
        (if (!= (if (= (bitwise-and tmp.21 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.20 7) 0) 14 6) 6)
            (* tmp.20 (arithmetic-shift-right tmp.21 3))
            318)
          318)))
    (define L.+.11
      (lambda (tmp.22 tmp.23)
        (if (!= (if (= (bitwise-and tmp.23 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.22 7) 0) 14 6) 6)
            (+ tmp.22 tmp.23)
            574)
          574)))
    (define L.-.10
      (lambda (tmp.24 tmp.25)
        (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
          (if (!= (if (= (bitwise-and tmp.24 7) 0) 14 6) 6)
            (- tmp.24 tmp.25)
            830)
          830)))
    (define L.fun/empty126710.4 (lambda () 22))
    (define L.fun/empty126709.5 (lambda () (call L.fun/empty126710.4)))
    (define L.fun/any126713.6 (lambda () 25390))
    (define L.fun/any126711.7 (lambda () 1184))
    (define L.fun/any126712.8 (lambda () 30))
    (let ((fixnum0.6
           (call
            L.-.10
            (call
             L.-.10
             (call L.+.11 (call L.-.10 464 1152) (call L.-.10 1752 56))
             (call L.*.12 (call L.-.10 992 904) (call L.+.11 128 488)))
            (call
             L.-.10
             (call L.*.12 (call L.*.12 1744 856) (call L.*.12 648 736))
             (call L.*.12 (call L.*.12 104 712) (call L.-.10 264 1896)))))
          (empty1.5 (call L.fun/empty126709.5))
          (boolean2.4 (call L.void?.13 (call L.fun/any126711.7)))
          (fixnum3.3
           (call
            L.*.12
            (call
             L.*.12
             (call L.-.10 (call L.+.11 72 904) (call L.-.10 816 448))
             (call L.+.11 (call L.-.10 136 848) (call L.*.12 1088 1872)))
            (call
             L.+.11
             (call L.+.11 (call L.-.10 376 976) (call L.*.12 1784 304))
             (call L.-.10 (call L.*.12 1416 368) (call L.+.11 1784 1720)))))
          (boolean4.2 (call L.boolean?.14 (call L.fun/any126712.8)))
          (boolean5.1 (call L.error?.15 (call L.fun/any126713.6))))
      (call
       L.-.10
       fixnum3.3
       (call L.+.11 (call L.*.12 fixnum0.6 fixnum3.3) fixnum0.6)))))
(check-by-interp
 '(module
    (define L.vector?.18
      (lambda (tmp.50) (if (= (bitwise-and tmp.50 7) 3) 14 6)))
    (define L.fun/error129841.4 (lambda () (call L.fun/error129842.9)))
    (define L.fun/ascii-char129834.5 (lambda () 25390))
    (define L.fun/ascii-char129832.6 (lambda () 25390))
    (define L.fun/empty129840.7 (lambda () 22))
    (define L.fun/empty129836.8 (lambda () 22))
    (define L.fun/error129842.9 (lambda () 41278))
    (define L.fun/ascii-char129831.10
      (lambda () (call L.fun/ascii-char129832.6)))
    (define L.fun/empty129835.11 (lambda () (call L.fun/empty129836.8)))
    (define L.fun/any129830.12 (lambda () 30))
    (define L.fun/ascii-char129833.13
      (lambda () (call L.fun/ascii-char129834.5)))
    (define L.fun/empty129837.14 (lambda () (call L.fun/empty129838.15)))
    (define L.fun/empty129838.15 (lambda () 22))
    (define L.fun/empty129839.16 (lambda () (call L.fun/empty129840.7)))
    (let ((boolean0.6 (call L.vector?.18 (call L.fun/any129830.12)))
          (ascii-char1.5 (call L.fun/ascii-char129831.10))
          (ascii-char2.4 (call L.fun/ascii-char129833.13))
          (empty3.3 (call L.fun/empty129835.11))
          (empty4.2 (call L.fun/empty129837.14))
          (empty5.1 (call L.fun/empty129839.16)))
      (call L.fun/error129841.4))))
