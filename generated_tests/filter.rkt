; temporary script file to filter out tests cases that never terminates

#lang racket

(require cpsc411/langs/v5
  cpsc411/langs/v6)

(define (runs-within-time? p interp-lang)
  (define ch (make-channel))

  (define thr
    (thread (lambda ()
              (channel-put ch
                           (with-handlers ([exn:fail? (lambda (e) 'error)])
                             (interp-lang p))))))

  (define result (sync/timeout 3 ch))
  (cond
    [(not result) ; timeout
     (kill-thread thr)
     #f]
    [(eq? result 'error) #f]
    [else #t]))

(define (dummy-interp p)
    (error "you forgot to set an actual interpretor!"))

(define (dummy-valid? p) 
  #t)

(define (peek x)
  ; (pretty-display x)
  x)

; step1: replace dummy-interp and dummy-valid? with the right interpretor and validator
(define (check-by-interp-v6 p)
    (when (and (nested-asm-lang-v6? p) (runs-within-time? p interp-nested-asm-lang-v6))
       (displayln (string-append "(check-by-interp " (pretty-format p) ")"))))

; step1: replace dummy-interp with the right interpretor
(define (check-by-interp p)
    (check-by-interp-v6 p))

; step2: add test cases here and run