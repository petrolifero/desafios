#lang racket

(require "user.rkt")
(require "shell.rkt")

(define (system-message str)
  (let ([s (string-append "\x1B[31m" str "\x1B[0m")])
    (display (string-length s))
    (newline)
    (display s)))


(define (loop user)
  (let ([line (parser (read-line))])
    (if (can-execute? user line)
        (execute-shell line user)
        (system-message "Voce nao pode executar esse comando ainda.")))
     (loop user))


(let ([user (create-user (getenv "USER"))])
  (loop user))
