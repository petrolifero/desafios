#lang racket


(provide (all-defined-out))

(require "shell.rkt")

(module+ test
	(require rackunit)
	(display (man "man")))


(define (man str)
	(assoc str `(
			("man" ,(file->string "/home/joao/desafios/desafios/temp"))
		    )))


(define (system-message str)
  (let ([s (string-append "\x1B[31m" str "\x1B[0m")])
    (display s)
    (newline)))

(define (command-message str)
  (let ([s (string-append "\x1B[35m" str "\x1B[0m")])
    (display s)
    (newline)))

(define (red l)
  (if (null? l)
      ""
      (if (null? (cdr l))
	  (car l)
	  (red (cons (string-append (car l) "\n" (cadr l) "\n") (cddr l))))))

(define user (getenv "USER"))
(define home (getenv "HOME"))
(define (main)
	(current-directory home)

	(system-message "você esta no tutorial, dentro do seu diretorio pessoal. Comece apertando ls com enter depois para ver o conteudo da sua pasta pessoal\n")
	(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
	(let loop ((x (read-line)))
		(if (equal? x "ls")
			(begin
			  	(command-message (red (map path->string (directory-list (current-directory)))))
				(system-message (format "Olha só o conteudo do seu diretorio. Reparou no textinho antes de você digitar ls? Ele mostra que você se chama ~a e esta atualmente dentro do diretorio(um nome pomposo para pasta) ~a\n" user (current-directory))))
			(begin
			  	(system-message (format "Não não. Você digitou ~a, era para ter digitado ls. Por favor, tente de novo.\n" x))
				(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
				(loop (read-line)))))
	
	
	(system-message "Agora vamos criar um diretorio para você. Pode escolher o nome. Se quiser criar desafios, digite \"mkdir desafios\"\n")
	
	(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
	(let loop ((x (read-line)))
		(if (string-prefix? x "mkdir")
			(begin
			  	(make-directory* (car (string-split x "mkdir ")))
				(system-message (format "Olha só, seu diretorio foi criado\n")))
			(begin
			  	(system-message (format "Não não. Você digitou ~a, era para ter digitado algum mkdir. Por favor, tente de novo.\n" x))
				(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
				(loop (read-line)))))
	
	(system-message "Você criou o diretorio que especificou... Será mesmo??\n")
	(system-message "Não confie em mim. Dê um \"ls nome do diretorio\" para verificar\n")
	
	(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
	(let loop ((x (read-line)))
		(if (string-prefix? x "ls")
			(begin
			  	(command-message (red (map path->string (directory-list (car (string-split x "ls "))))))
				(system-message (format "Olha só o conteudo do seu diretorio novo... Ué, sem nada? Relaxa, ela só esta vazia. Agora tem sua nova pasta.\nSe ela não existisse, ia aparecer uma mensagem de erro. \n")))
			(begin
			  	(system-message (format "Não não. Você digitou ~a, era para ter digitado ls. Por favor, tente de novo.\n" x))
				(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
				(loop (read-line)))))
	
	(system-message "Agora vamos entrar nesse diretorio e fazer as quests ali. Para viajar pelos diretorios usamos o comando cd. digite \"cd nome-do-seu-diretorio\" para entrar nessa pasta.")
	
	(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
	(let loop ((x (read-line)))
		(if (string-prefix? x "cd")
		(begin
		  	(current-directory (car (string-split x "cd "))))
		(begin
		  	(system-message (format "Não não. Você digitou ~a, era para ter digitado cd com algum diretorio. Por favor, tente de novo.\n" x))
			(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
			(loop (read-line)))))


(system-message "Olhe só o que você fez : Note a mudança\n")
(system-message "quando notar, digite next e você oficialmente saiu do tutorial.A partir de agora, não terão mais tantas mensagens do sistema, vermelhas assim para te guiar, você estará mais livre. Não se amedronte, a primeira quest da nova vida será sobre o manual para pedir ajuda :)\n")

(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (equal? x "next")
	    (void)
	    (begin
	      (system-message "Não não, digite next \n")
	      (display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
	      (loop (read-line)))))

;;; Fim do tutorial
;;; Como mostro as quests disponiveis? Antes havia uma linha reta de quests, depois havia o comando desafios
;;; Agora, que esse comando foi descartado por ser complexo para o usuario, como seria a melhor forma de apresentar os caminhos???


;;;             --------------------------
;;;             |                        |
;;; level 1 -> man     -> ls -la         |
;;;         -> ls -l   /                 |
;;;         -> cd ..   -------------------> cd .

;;; como mostrar as quests disponiveis??


(system-message "Bem-vindo ao level 1.\n")
(system-message "Sua primeira missão é aprender a usar o manual do sistema\n")
(system-message "Como dito anteriormente, a partir de agora você estará andando mais solto\n")
(system-message "digite \"man man\" para abrir a pagina do manual sobre o proprio manual")


(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
  (if (equal? x "man man")
	(man "man")
	(if (equal? x "exit")
		(exit 0)
		(begin
		  (display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
		  (loop (read-line))))))



(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
  (if (equal? x "exit") (exit 0) (void))
  (display x)
  (newline)
  (display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
  (loop (read-line))))



(module+ test
	(require rackunit))


(main)




