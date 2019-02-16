#lang racket

(require rackunit)
(require "../../main.rkt")




(check-equal?
	(with-output-to-string (lambda ()
					(with-input-from-string
								"exit 0"
								(lambda () (refine-main)))))
	""
	"Consigo sair antes de comecar o tutorial")

