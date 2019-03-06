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
				(seq
					(exec (mkdir-struct (shell-identifier "desafios")))
				(seq
					(echo-struct (list "Olha só, seu diretorio foi criado"))
				(seq
					(echo-struct (list "Você criou o diretorio que especificou... Será mesmo??"))
				(seq
					(echo-struct (list "Não confie em mim. Dê um \"ls desafios\" para verificar"))
				(seq
					(exec (ls-struct '() (shell-identifier "desafios")))
				(seq
					(echo-struct (list "Olha só o conteudo do seu diretorio novo... Ué, sem nada? Relaxa, ela só esta vazia. Agora tem sua nova pasta."))
				(seq
					(echo-struct (list "Se ela não existisse, ia aparecer uma mensagem de erro."))
				(seq
					(echo-struct (list "Agora vamos entrar nesse diretorio e fazer as quests ali. Para viajar pelos diretorios usamos o comando cd. digite \"cd desafios\" para entrar nessa pasta."))
				(seq
					(exec (cd-struct (shell-identifier "desafios")))
				(seq
					(echo-struct (list "Olhe só o que você fez : Note a mudança"))
				(seq
					(echo-struct (list "quando notar, digite next e você oficialmente saiu do tutorial.A partir de agora, não terão mais tantas mensagens do sistema, vermelhas assim para te guiar, você estará mais livre. Não se amedronte, a primeira quest da nova vida será sobre o manual para pedir ajuda :)"))
					(exec (next-struct)))))))))))))))))))

(check-equal?
	(find-quests "xargs")
	#f)
