#lang racket

(provide (rename-out [runs-within-time? testable?]))

(define (runs-within-time? p interpretor [timeout 3])
  (define ch (make-channel))

  (define thr
    (thread (lambda ()
              (channel-put ch
                           (with-handlers ([exn:fail? (lambda (e) 'error)])
                             (interpretor p))))))

  (define result (sync/timeout timeout ch))

  (cond
    [(not result) ; timeout
     (kill-thread thr)
     #f]
    [(eq? result 'error) #f]
    [else #t]))
