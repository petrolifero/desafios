#lang racket

(require "user.rkt")
(require "shell.rkt")




(define (loop user)
  (let ([prompt (format "~a@desafios:~a " (name user) (current-directory user))])
	  (display (string-length prompt))
	  (newline)
	  (display prompt))
  (let ([line (call-with-exception-handler (lambda (e) #f) (lambda () (parser (read-line))))])
    (if (can-execute? user line)
        (execute-shell line user)
        (system-message "Voce nao pode executar esse comando ainda.")))
     (loop user))


(let ([user (create-user (getenv "USER"))])
  (with-output-to-file (string-append (getenv "HOME") "/.desafios/inC")
	(lambda ()
	  (with-input-from-file (string-append (getenv "HOME") "/.desafios/outC")
		(lambda ()  (loop user))))))
