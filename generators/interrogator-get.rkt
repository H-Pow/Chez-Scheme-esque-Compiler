#lang racket
(require net/http-client
         net/uri-codec
         xml)

(provide interrogator-get interrogator-post)

(define CALL-POINT "/interrogator/standalone.rkt")
(define (peek x)
  (pretty-display x)
  x)
(define (interrogator-get milestone-num [sexpr '()] [trace? #f])
  (define data (filter identity (list (cons 'an (~a "a" milestone-num #:separator ""))
                                      (if (empty? sexpr)
                                          #f
                                          (cons 'test (~v sexpr)))
                                      (cons 'traced? (~a trace?)))))
  (define con (http-conn))
  (http-conn-open! con "williamjbowman.com"
                   #:ssl? #t
                   #:port 8083
                   #:auto-reconnect? #f)
  (define-values (status header port)
    (http-conn-sendrecv! con (~a CALL-POINT (alist->form-urlencoded data)
                                 #:separator "?")))
  ;   (define (read-all port [str ""])
  ;     (let [(str+ (read-string 1024 port))]
  ;       (if (eof-object? str+)
  ;           str
  ;           (read-all port (string-append str str+)))))
  (if (string-contains? (bytes->string/utf-8 status) "200")
      (parameterize [(permissive-xexprs #t)] (xml->xexpr (document-element (read-xml port))))
      (error status))
  )

(define (interrogator-post milestone-num [sexpr '()] [trace? #f])
  (define data (filter identity (list (cons 'an (~a "a" milestone-num #:separator ""))
                                      (if (empty? sexpr)
                                          #f
                                          (cons 'test (~v sexpr)))
                                      (cons 'traced? (~a trace?)))))
  (define con (http-conn))
  (http-conn-open! con "williamjbowman.com"
                   #:ssl? #t
                   #:port 8083
                   #:auto-reconnect? #f)
  (define-values (status header port)
    (http-conn-sendrecv! con CALL-POINT
                         #:method "POST"
                         #:data
                         (alist->form-urlencoded data)
                         #:headers (list "Content-Type: application/x-www-form-urlencoded")))

  ;   (define (read-all port [str ""])
  ;     (let [(str+ (read-string 1024 port))]
  ;       (if (eof-object? str+)
  ;           str
  ;           (read-all port (string-append str str+)))))
  (if (string-contains? (bytes->string/utf-8 status) "200")
      (parameterize [(permissive-xexprs #t)] (xml->xexpr (document-element (read-xml port))))
      (error status))
  )

