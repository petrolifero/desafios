#lang racket

(require "shell.rkt")

(provide (all-defined-out))

(define (system-message str)
  (let ([s (string-append "\x1B[31m" str "\x1B[0m")])
    (display (string-length s))
    (newline)
    (display s)
    (newline)))

(define (command-message str)
  (let ([s (string-append "\x1B[35m" str "\x1B[0m")])
    (display (string-length s))
    (newline)
    (display s)
    (newline)))


(struct quest (name prepare prerequisites text verify) #:transparent)
(struct user (name level) #:transparent)

(define (create-user name)
  (let* ([home (format "/home/~a" name)]
         [config-file (format "~a/.desafios.user" home)]
         [lines (call-with-input-file config-file (lambda (in) (port->lines in)))])
	(user name (car lines))))

(define (can-execute? user command)
    (level-allow? (user-level user) command))

(define (level-quest l)
  (match l
	 ["tutorial-0" (lambda (c) (ls-struct? c))]
	 ["tutorial-1" (lambda (c) (cd-struct? c))]))

(define (level-allow? l c)
  (if (equal? c #f)
    #f
    #t))


(define (destroy line)
  (match line
    [#f (format "printf ~a" (system-message "Este não é um comando valido\n"))]
    [(list) "printf \"\n\""]
    [(pipeline-struct c1 c2) (string-append (destroy c1) " | " (destroy c2))]))


;https://docs.racket-lang.org/reference/subprocess.html
(define (execute-shell line user)
  (let ([command-str (destroy line)])
    (with-output-to-string (lambda () (system command-str)))))
    
    

