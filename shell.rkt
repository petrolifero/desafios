#lang peg

(struct or-struct (a b) #:transparent);
(struct and-struct (a b) #:transparent);

(define (red v l)
  (if (null? l) v
      (red ((car l) v (cadr l)) (cddr l))));


_ < [ \t\n]* ;
shell <- _ logic _;
logic <- v1:redirect _ v2:((logicOperator _ redirect _)*) -> (if (null? v2) v1 (red v1 v2));
logicOperator <- v:('&&' / '||' ) -> (if (equal? v "&&") and-struct or-struct);
redirect <- pipeline;
pipeline <- simpleCommand;
simpleCommand <- ls / cd / aaaa;
