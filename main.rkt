#lang racket

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

(current-directory home)

(system-message "you are in the tutorial, inside your personal directory. Start by pressing ls with enter to view the contents of your home folder\n")
(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (equal? x "ls")
		(begin
		  	(command-message (red (map path->string (directory-list (current-directory)))))
			(system-message (format "Look at the contents of your directory. Did you notice the text before you type ls? It shows that you are calling ~a and it is currently inside the directory (a pompous folder name) ~a \n" user (current-directory))))
		(begin
			(system-message (format "No. You typed ~a, it was to have typed ls. Please try again. \n" x))
			(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
			(loop (read-line)))))

(system-message "Now let's create a directory for you. You can choose the name. If you want to create challenges, type \"mkdir challenges\"\n")

(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (string-prefix? x "mkdir")
		(begin
		  	(make-directory* (car (string-split x "mkdir ")))
			(system-message (format "Look, your directory was created\n")))
		(begin
		  	(system-message (format "No. You typed ~a, it was to have typed some mkdir. Please try again.\n" x))
			(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
			(loop (read-line)))))
(system-message "You have created the directory that you specified ... Will it really ??\n")
(system-message "Do not trust me. Give \"ls name-of-directory\" to verify\n")

(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (string-prefix? x "ls")
		(begin
		  	(command-message (red (map path->string (directory-list (car (string-split x "ls "))))))
			(system-message (format "Look at the contents of your new directory ... Wow, nothing? Relax, it's just empty. You now have your new folder.\nIf it did not exist, an error message would appear.\n")))
		(begin
		  	(system-message (format "No. You typed ~a, it was to have typed ls. Please try again.\n" x))
			(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
			(loop (read-line)))))
(system-message "Now let's go into that directory and do the quests there. To travel through the directories we use the cd command. Type \"cd your-directory-name \" to enter this folder.\n")

(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (string-prefix? x "cd")
		(begin
		  	(current-directory (car (string-split x "cd "))))
		(begin
		  	(system-message (format "No. You typed ~a, it was to have typed cd with your directory. Please try again.\n" x))
			(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
			(loop (read-line)))))


(system-message "Look what you've done: Note the change\n")
(system-message "when you notice, type next and you officially left the tutorial. From now on, you will not have as many system messages, so red to guide you, you will be more free. Do not be frightened, the first quest of the new life will be about the manual to ask for help :)\n")

(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
	(if (equal? x "next")
	    (void)
	    (begin
	      (system-message "No, type next\n")
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

(system-message "Welcome to level 1.\n")
(system-message "")
(display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
(let loop ((x (read-line)))
  (if (equal? x "exit") (exit 0) (void))
  (display x)
  (newline)
  (display (format "~a@desafios:~a " (getenv "USER") (current-directory)))
  (loop (read-line)))











