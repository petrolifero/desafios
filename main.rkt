#lang racket



#|
As quests devem estar em um grafo anotado. Cada vertice contem o nome
da quest, quantas são suas dependencias e o estado atual da quest(como
uma quest é dada por um programa com seq e tals, a cada execução algo
cai)

|#

(provide (all-defined-out))


(require "readline.rkt")
(require "quests.rkt")

(provide (all-from-out "quests.rkt"))

(define (less str)
	(command-message str))

(define (man str)
	(less (cadr (assoc str `(
			("man" ,(file->string "/home/petrolifero/desafios/desafios/man/man"))
			("desafios" ,(file->string "/home/petrolifero/desafios/desafios/man/desafios"))
		    )))))


(define (system-message str)
  (let ([s (string-append "\x1B[31m" str "\x1B[0m")])
    (display s)))

(define (command-message str)
  (let ([s (string-append "\x1B[35m" str "\x1B[0m")])
    (display s)))

(define (red l)
  (if (null? l)
      ""
      (if (null? (cdr l))
	  (car l)
	  (red (cons (string-append (car l) "\n" (cadr l) "\n") (cddr l))))))

;env variable
(define user (getenv "USER"))
(define home (getenv "HOME"))
(define last-exit-code 0)

;list of lists
; ( (name-of-quest rest-of-quest))
;nodes are "name number-of-dependents quest-struct list-of-dependents
(define graph-of-quests `(
				("tutorial"
					0
					,(parser-quest "quest tutorial
							echo você esta no tutorial, dentro do seu diretorio pessoal. Comece apertando ls com enter depois para ver o conteudo da sua pasta pessoal\n;
							exec ls;
							echo Olha só o conteudo do seu diretorio. Reparou no textinho antes de você digitar ls? Ele mostra que você se chama $USER e esta atualmente dentro do diretorio(um nome pomposo para pasta) $PWD\n;
							echo Agora vamos criar um diretorio para você. Ele se chamará desafios. Digite \"mkdir desafios\"\n;
							exec mkdir desafios;
							echo Olha só, seu diretorio foi criado\n;
							echo Você criou o diretorio que especificou... Será mesmo??\n;
							echo Não confie em mim. Dê um \"ls desafios\" para verificar\n;
							exec ls desafios;
							echo Olha só o conteudo do seu diretorio novo... Ué, sem nada? Relaxa, ela só esta vazia. Agora tem sua nova pasta.\n;
							echo Se ela não existisse, ia aparecer uma mensagem de erro.\n;
							echo Agora vamos entrar nesse diretorio e fazer as quests ali. Para viajar pelos diretorios usamos o comando cd. digite \"cd desafios\" para entrar nessa pasta.\n;
							exec cd desafios;
							echo Olhe só o que você fez : Note a mudança\n;
							echo quando notar, digite next e você oficialmente saiu do tutorial.A partir de agora, não terão mais tantas mensagens do sistema, vermelhas assim para te guiar, você estará mais livre. Não se amedronte, a primeira quest da nova vida será sobre o manual para pedir ajuda :)\n;
							exec next;
							tseuq")
					("ls"))
				("ls"
					1
					,(parser-quest "quest ls < tutorial
								echo ola;
								tseuq")
					("cd"))))
;se não tiver no grafo, retorna 
(define (find-quests name)
	(for/first
		([quest graph-of-quests]
		#:when (equal? (car quest) name))
		(caddr quest)))
		
	
(define list-of-actual-quests (list
					(find-quests "tutorial")))
;
(define next-string "")
(define next-command "")
(define my-prompt (string-append (getenv "USER") "@desafios:" (path->string (current-directory))))

(define (emit c)
	(define (advance-quest q)
		(match q
			[(quest name pre (seq (exec (? (lambda (x) (equal? x c)) a)) b)) (list (quest name pre b))]
			[a (list a)]))
	(define (advance-quests q)
		(flatten (map advance-quest q)))
	(set! list-of-actual-quests (advance-quests list-of-actual-quests)))

(define (execute c [emit? #t] [show command-message])
	(when emit? (emit c))
	(match c
		[(exit-struct a) a]
		[(echo-struct l) (let loop ((v l))
					(if (null? v)
						(show "")
						(begin
							(if (string? (car v))
								(show (car v))
								(show (or
										(getenv (env-variable-a (car v)))
										"")))
							(loop (cdr v)))))
				(newline)
				#f]
		[(man-struct n) (man n) #f]
		[(ls-struct '() (shell-identifier directory)) 
			(if (absolute-path? directory)
				(command-message (red (map path->string (directory-list (string->path directory)))))
				(command-message (red (map path->string (directory-list (build-path (current-directory) directory))))))
			#f]
		[(command-not-exist v) (command-message (format "comando ~a inexiste" v)) #f]))
(define (graph-next-quests name)
	(for/list ([quest graph-of-quests]
			#:when (member name (quest-pre (caddr quest))))
			(caddr quest)))
		

(define (update-actual-quests)

	;quest -> (quest)
	;return () if the last comand was echo
	;return (q) if the quest was partly consumed by echos
	;return l if the quest was total consumed but exist (length l) dependencies

	(define (advance-quest q)
		(match q
			[(quest name pre (seq (echo-struct l) r))
			(begin
				(execute (echo-struct l) #f system-message)
				(advance-quest (quest name pre r)))]
			[(quest name pre (seq a b)) (list q) ]
			[(quest name pre (echo-struct l))
			(begin
				(execute (echo-struct l) #f system-message)
				(graph-next-quests name))]))
	(define (advance-quests q)
		(flatten (map advance-quest q)))
			
	(set! list-of-actual-quests (advance-quests list-of-actual-quests)))
	


(define (refine-main)
	(update-actual-quests)
	(display next-string) ;;feito
	(set! next-command (parser-shell (my-readline my-prompt))) 
	(if (execute next-command) (void) (refine-main)))


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


(system-message "Muito bem, completou sua primeira quest. Agora pode usar o comando desafios.\n")
(system-message "Pode usar \"man desafios\" para ver suas opcoes. Leia atentamente.\n")
(system-message "Pois la tera como acessar suas proximas quests")


(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
  (if (equal? x "exit") (exit 0) (void))
  (display x)
  (newline)
  (display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
  (loop (read-line))))


