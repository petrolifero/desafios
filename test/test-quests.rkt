#lang racket

(require "../quests.rkt")
(require rackunit)
(check-equal?
	(parser-quest "quest ls
			echo ola;
			tseuq")
	(quest (idt "ls") (list) (echo-struct '("ola")))
	"Sem prerequisitos, um único comando")
(check-equal?
	(parser-quest "quest ls < tutorial echo ola; tseuq")
	(quest
		(idt "ls")
		(list (idt "tutorial"))
		(echo-struct '("ola")))
	"Com prerequisitos, apenas tutorial, um único comando")
(check-equal?
	(parser-quest "quest ls < a,b,c,d echo ola; exec ls -l; tseuq")
	(quest
		(idt "ls")
		(list (idt "a") (idt "b") (idt "c") (idt "d")) 
		(seq (echo-struct '("ola")) (exec (ls-struct "-l" (list)))))
	"Com prerequisitos, varios prerequisitos, multiplos comandos")

(check-equal?
	(parser-quest "quest tutorial
				echo você esta no tutorial, dentro do seu diretorio pessoal. Comece apertando ls com enter depois para ver o conteudo da sua pasta pessoal;
				exec ls;
				tseuq")
	(quest
		(idt "tutorial")
		(list)
		(seq (echo-struct '("você esta no tutorial, dentro do seu diretorio pessoal. Comece apertando ls com enter depois para ver o conteudo da sua pasta pessoal")) (exec (ls-struct (list) (list)))))
		"inicio do tutorial")
