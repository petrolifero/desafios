#lang racket

(require "user.rkt")
(require "shell.rkt")

(define (system-message str)
  (string-append "" str ""))


(define (loop)
  (let ([line (parser (read-line))])
    (if (
