#lang racket

(require "generate-exprs-lang-v8.rkt"
         "get-passes-content.rkt"
         "testable.rkt"
         cpsc411/langs/v8)

(define current-milestone 8)
(define out-folder (~a "m" current-milestone "-generated-tests" ))
(when (not (directory-exists? out-folder)) (make-directory out-folder))

(define (open-test-file pass-name #:override? [override? #f])
  (define filename (~a pass-name ".rkt"))
  (define filepath (build-path out-folder filename))
  (if (or override? (not (file-exists? filepath)))
      (let ([file (open-output-file filepath #:mode 'text #:exists 'replace)]
            [src-interp/sym (list-ref interpretors/sym (index-of allowed-passes pass-name))]
            [dest-interp/sym (list-ref interpretors/sym (+ (index-of allowed-passes pass-name) 1))])
        (displayln "#lang racket" file)
        (pretty-write `(require ,(string->symbol (~a "cpsc411/langs/v" current-milestone))
                                (only-in ,(~a "../" pass-name ".rkt"))) file)
        (pretty-write `(define (check-by-interp p)
                         (,src-interp/sym p)
                         (,dest-interp/sym (,pass-name p))) file)
        (displayln "" file)
        file)
      (open-output-file filepath #:mode 'text #:exists 'append)))

(define (generate/file max-recur max-iter [override? #f])
  (define prog (generate/p max-recur max-iter))
  (if (not (testable? prog interp-exprs-lang-v8))
      (generate/file max-recur max-iter)
      (let ([passes (get-passes-content current-milestone prog allowed-passes)])
        (for ([entry passes])
          (define file (open-test-file (car entry) #:override? override?))
          (pretty-write `(check-by-interp ,(cdr entry)) file)
          (close-output-port file)
          ))))

(for [(complexity (range 8))]
  (for [(ntests (range (arithmetic-shift 2 complexity)))]
    (displayln (format "generating ~ath test for complexity ~a..." (add1 ntests) complexity))
    (generate/file complexity complexity)
    )

  )