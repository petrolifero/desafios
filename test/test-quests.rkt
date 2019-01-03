#lang racket

(require "../quests.rkt")
(require rackunit)
(check-equal?
	(quest (idt "ls") (list (idt "tutorial")) (echo-struct "ola"))
	(parser-quest "quest ls
			echo ola;
			tseuq")
	"Sem prerequisitos, um único comando")
(check-equal?
	(parser-quest "quest ls < tutorial echo ola; tseuq")
	(quest
		(idt "ls")
		(list (idt "tutorial"))
		(echo-struct "ola"))
	"Com prerequisitos, apenas tutorial, um único comando")
(check-equal?
	(parser-quest "quest ls < a,b,c,d echo ola; exec ls -l; tseuq")
	(quest
		(idt "ls")
		(list (idt "a") (idt "b") (idt "c") (idt "d")) 
		(seq (echo-struct "ola") (exec (ls-struct "-l" (list)))))
	"Com prerequisitos, varios prerequisitos, multiplos comandos")
