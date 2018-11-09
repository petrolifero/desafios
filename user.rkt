#lang racket

(require "shell.rkt")

(provide (all-defined-out))

(define (command-message str)
  (let ([s (string-append "\x1B[35m" str "\x1B[0m")])
    (display (string-length s))
    (newline)
    (display s)))


(struct user (name level) #:transparent)

(define (create-user name)
  (let* ([home (format "/home/~a" name)]
         [config-file (format "~a/.desafios.user" home)]
         [level (call-with-input-file config-file (lambda (in) (port->string in)))])
         (user name level)))

(define (can-execute? user command)
  (and
    (quest-allow? (quests user) command)
    (level-allow? (user-level user) command)))
    
(define (quests user)
  (let* ([home (format "/home/~a" (user-name user))]
         [config-file (format "~a/.desafios.quests" home)]
         [quests (call-with-input-file config-file (lambda (in) (string-split (port->string in) "\n")))])
         quests))

(define (quest-allow? l c)
  #t)
  
(define (level-allow? l c)
  #t)





#|
(define (execute-shell line user)
  (let ([command-str (destroy line)])
    (
    
    
|#
