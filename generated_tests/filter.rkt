; temporary script file to patch out bad tests

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

(define (peek x)
  ; (pretty-display x)
  x)

; step1: replace dummy-interp with the right interpretor
(define (check-by-interp-v6 p)
    (when (runs-within-time? p dummy-interp)
       (displayln (string-append "(check-by-interp-v6 " (pretty-format p) ")"))))

; step1: replace dummy-interp with the right interpretor
(define (check-by-interp p )
    (when (runs-within-time? p dummy-interp)
        (displayln (string-append "(check-by-interp " (pretty-format p) ")"))))

; step2: add test cases here and run