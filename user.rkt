#lang racket

(provide (all-defined-out))

(struct user (name level) #:transparent)

(define (can-execute? user command)
  (
