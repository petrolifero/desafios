#lang peg

(struct or-struct (a b) #:transparent);
(struct and-struct (a b) #:transparent);
(struct pipe-struct (a b) #:transparent);
(struct out-redirect (cmd file) #:transparent);
(struct in-redirect (cmd file) #:transparent);


(struct ls-struct (options directory) #:transparent);
(struct cd-struct (directory) #:transparent);
(struct mkdir-struct (directory) #:transparent);

(define (parser str)
  (peg shell str))

(define (red v l)
  (if (null? l) v
      (red ((car l) v (cadr l)) (cddr l))));


_ < [ \t\n]* ;
shell <- _ logic _;
logic <- v1:redirect _ v2:((logicOperator _ redirect _)*) -> (red v1 v2);
logicOperator <- v:('&&' / '||' ) -> (if (equal? v "&&") and-struct or-struct);

redirect <- v1:(pipeline) _ v2:(input-redirect?) _ v3:(output-redirect?) -> (if v3
                                                                           (out-redirect (if v2 (in-redirect v1 v2) v1) v3)
                                                                           (if v2 (in-redirect v1 v2) v1));
input-redirect <- '<' _ v:name _ -> v;
output-redirect <- '>' _ v:name _ -> v;
pipeline <- v1:simpleCommand _ v2:((pipe _ simpleCommand _ )*) -> (red v1 v2);
pipe <- '|' -> pipe-struct;
simpleCommand <- ls / cd / mkdir / cat / less / more / find / man / l;

ls <- 'ls' _ v1:options-ls _ v2:name -> (ls-struct v1 v2);
options-ls <- '-l'?;


cd <- 'cd' _ v:name -> (cd-struct v);
name <- [a-zA-Z]+;

mkdir <- 'mkdir' _ v:name -> (mkdir-struct v);

cat <- 'cat' _ 
