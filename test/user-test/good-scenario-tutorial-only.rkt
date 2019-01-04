#lang racket

(require rackunit)
(require "../../main.rkt")




(check-equal?
	(with-output-to-string (lambda ()
					(with-input-from-string
								"exit"
								(lambda () (main)))))
	""
	"Consigo sair antes de comecar o tutorial")

