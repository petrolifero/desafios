#lang peg

(define (parser-quest port)
  (peg quest (port->string port)));


_ < [ \t\n]* ;
EOI < ! . ;

quest <- _ 'quest' _ identifier _ preRequisites? _ comand _ 'tseuq' _ EOI ;
identifier <- [a-zA-Z]+ ;
preRequisites <- identifier _ (',' _ identifier _)*;
comand <- comandUnit (_ comandUnit)* ;
comandUnit <- exec / echo-quest / file ;
exec <- 'exec' _ shell ;
echo-quest <- echo ;
file <- 'file' _ identifier _ assertionOnFile ;
assertionOnFile <- 'exists' / 'is directory' ;















quest ls > cd,mkdir

exec ls

echo "muito bem, você mostrou o diretorio"

file ola exists

exec cd p

tseuq





