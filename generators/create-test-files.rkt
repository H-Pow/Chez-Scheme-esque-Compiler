#lang racket

(require "generate-exprs-lang-v8.rkt"
         "get-passes-content.rkt"
         "testable.rkt"
         cpsc411/langs/v8)

(define current-milestone 8)
(define interpretor interp-exprs-lang-v8)
(define out-folder (~a "m" current-milestone "-generated-tests" ))
(when (not (directory-exists? out-folder)) (make-directory out-folder))

(define (open-test-file pass-name #:override? [override? #f])
  (define filename (~a pass-name ".rkt"))
  (define filepath (build-path out-folder filename))
  (if (or override? (not (file-exists? filepath)))
      (let* ([file (open-output-file filepath #:mode 'text #:exists 'replace)]
             [passidx (index-of allowed-passes pass-name)]
             [src-interp/sym (list-ref interpretors/sym passidx)]
             [trg-interp/sym (list-ref interpretors/sym (+ passidx 1))]
             [trg-lang (list-ref langs (+ passidx 1))]
             [trg-lang?/sym (if trg-lang
                                (string->symbol (~a trg-lang '?))
                                #t)])
        (displayln "#lang racket" file)
        (pretty-write `(require rackunit
                                cpsc411/compiler-lib
                                cpsc411/ptr-run-time
                                ,(string->symbol (~a "cpsc411/langs/v" current-milestone))
                                ,(~a "../" pass-name ".rkt")) file)
        (pretty-write `(define (fail-if-invalid p)
                         (when (not (,trg-lang?/sym p))
                           (error (~a (pretty-format p)
                                      "\n is not a semantically valid " ,(~a trg-lang) " program")))
                         p) file)
        (pretty-write `(define-syntax-rule (check-by-interp p)
                         (check-equal? (,src-interp/sym p)
                                       (,trg-interp/sym (fail-if-invalid (,pass-name p))))) file)
        (displayln "" file)
        file)
      (open-output-file filepath #:mode 'text #:exists 'append)))

(define (generate/file max-recur max-iter [override? #f])
  (define prog (generate/p max-recur max-iter))
  (if (not (testable? prog interpretor))
      (generate/file max-recur max-iter)
      (let ([passes (get-passes-content current-milestone prog allowed-passes)])
        (for ([entry passes])
          (define file (open-test-file (car entry) #:override? override?))
          (pretty-write `(check-by-interp ,(cdr entry)) file)
          (close-output-port file)
          ))))

(for [(complexity (range 5 7))]
  (for [(ntests (range (arithmetic-shift 2 complexity)))]
    (displayln (format "generating test #~a for complexity ~a..." (add1 ntests) complexity))
    (generate/file complexity complexity)
    )

  )