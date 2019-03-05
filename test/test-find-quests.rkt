#lang racket

(require "../main.rkt")
(require rackunit)

(check-equal?
	(find-quests "tutorial")
	(quest
		(idt "tutorial")
		'()
		(seq
			(echo-struct (list "você esta no tutorial, dentro do seu diretorio pessoal. Comece apertando ls com enter depois para ver o conteudo da sua pasta pessoal"))
		(seq
			(exec (ls-struct '() '()))
			(seq
				(echo-struct (list "Olha só o conteudo do seu diretorio. Reparou no textinho antes de você digitar ls? Ele mostra que você se chama " (env-variable "USER") " e esta atualmente dentro do diretorio(um nome pomposo para pasta) " (env-variable "PWD")))
				(seq
					(echo-struct (list "Agora vamos criar um diretorio para você. Ele se chamará desafios. Digite \"mkdir desafios\""))
					(exec (mkdir-struct (shell-identifier "desafios")))))))))
(check-equal?
	(find-quests "xargs")
	#f)
