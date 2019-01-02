#lang peg

(require "shell.rkt");

(struct idt (a) #:transparent);
(struct seq (a b) #:transparent);
(struct exec (a) #:transparent);


//(string (listOf Idt) Command . -> . Quest)
(struct quest (name pre c) #:transparent);



(define (parser-quest str)
  (peg top-quest str));

(module+ test
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
		"Com prerequisitos, varios prerequisitos, multiplos comandos"));
_ < [ \t\n]* ;
sep < [ \t]* ;
EOI < ! . ;

top-quest <- _ v:quest _ EOI -> v;
quest <- quest-with-prerequisites / quest-without-prerequisites ;
quest-with-prerequisites <- _ 'quest' _ v1:identifier _ v2:preRequisites _ v3:comand _ 'tseuq' _ -> (quest v1 v2 v3);
quest-without-prerequisites <- _ 'quest' _ v1:identifier _ v2:comand _ 'tseuq' _ -> (quest v1 (list (idt "tutorial")) v2);

identifier <- v:[a-zA-Zé]+ -> (idt v);
preRequisites <- '<' _ v:(identifier _ (~',' _ identifier _)*) -> v;
comand <- v:(comandUnit (_ comandUnit)*) -> (foldl (lambda (x y) (seq y x)) (car v) (cdr v)) ;
comandUnit <- v:(exec / echo-quest / file) ';' -> v;
exec <- 'exec' sep v:shell -> (exec v);
echo-quest <- echo ;
file <- 'file' sep identifier sep assertionOnFile ;
assertionOnFile <- 'exists' / 'is directory' ;



//quest ls > cd,mkdir

//exec ls

//echo "muito bem, você mostrou o diretorio"

//file ola exists

//exec cd p

//tseuq





