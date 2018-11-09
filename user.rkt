#lang racket

(provide (all-defined-out))

(struct user (name level) #:transparent)

(define (can-execute? user command)
  (and
    (quest-allow? (quests user) command)
    (level-allow? (user-level user) command)))
    
(define (quests user)
  (let ([str ()])
    (string-strip str " ")))
