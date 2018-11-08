#lang peg

(struct or-struct (a b) #:transparent);
(struct and-struct (a b) #:transparent);
(struct pipe-struct (a b) #:transparent);
(struct cd-struct (directory) #:transparent);

(define (red v l)
  (if (null? l) v
      (red ((car l) v (cadr l)) (cddr l))));


_ < [ \t\n]* ;
shell <- _ logic _;
logic <- v1:redirect _ v2:((logicOperator _ redirect _)*) -> (red v1 v2);
logicOperator <- v:('&&' / '||' ) -> (if (equal? v "&&") and-struct or-struct);

//na versão atual, não há redirecionamento
redirect <- pipeline;
pipeline <- v1:simpleCommand _ v2:((pipe _ simpleCommand _ )*) -> (red v1 v2);
pipe <- '|' -> pipe-struct;
simpleCommand <- ls / cd / mkdir / cat / less / more / find / man / l;

ls <- 'ls' [a-zA-Z _\-]*;

cd <- 'cd' _ v:directory-name -> (cd-struct v);
directory-name <- [a-zA-Z]+;
