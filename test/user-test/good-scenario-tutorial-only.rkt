#lang racket

(require rackunit)
(require "../../main.rkt")




(check-equal?
		(execute (exit-struct 0))
		0)

(check-equal?
		(execute (echo-struct (list "ola")))
		#f)

