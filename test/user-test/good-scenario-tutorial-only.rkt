#lang racket

(require rackunit)
(require "../../main.rkt")




(check-equal?
		(execute (exit-struct 0))
		0)

(check-equal?
		(execute (echo-struct (list "ola")))
		#f)

(check-equal?
		(execute (exit-struct 23))
		23)

