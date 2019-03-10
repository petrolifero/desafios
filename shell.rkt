#lang peg

(struct exit-ausente () #:transparent);
(struct exit-struct (a) #:transparent);
(struct or-struct (a b) #:transparent);
(struct and-struct (a b) #:transparent);
(struct pipe-struct (a b) #:transparent);
(struct out-redirect (cmd file) #:transparent);
(struct in-redirect (cmd file) #:transparent);
(struct shell-identifier (name) #:transparent);

(struct command-not-exist (command) #:transparent);

(struct ls-struct (options directory) #:transparent);
(struct cd-struct (directory) #:transparent);
(struct mkdir-struct (directory) #:transparent);
(struct cat-struct (l) #:transparent);
(struct man-struct (name) #:transparent);
(struct less-struct (name) #:transparent);
(struct more-struct (name) #:transparent);
(struct echo-struct (a) #:transparent);
(struct next-struct () #:transparent);

(struct env-variable (a) #:transparent);

(define (parser-shell str)
  (peg top-shell str));

(define (red v l)
  (if (null? l) v
      (red ((car l) v (cadr l)) (cddr l))));

(define (flat l)
  (match l
    [(list (list a ...)) (flat a)]
    [a a]));


EOI < ! . ;
_ < [ \t]* ;
top-shell <- shell-exist / shell-inexist  ;
shell-inexist <- v:(.*) -> (command-not-exist v);
shell-exist <- _ v:shell _ EOI -> v;
shell <- _ v:logic _ -> v;
logic <- v1:redirect _ v2:((logicOperator _ redirect _)*) -> (red v1 v2);
logicOperator <- v:('&&' / '||' ) -> (if (equal? v "&&") and-struct or-struct);

redirect <- v1:(pipeline?) _ v2:(input-redirect?) _ v3:(output-redirect?) -> (if (not (null? v3))
                                                                           (out-redirect (if (not (null? v2)) (in-redirect v1 v2) v1) v3)
                                                                           (if (not (null? v2)) (in-redirect v1 v2) v1));
input-redirect <- '<' _ v:name _ -> v;
output-redirect <- '>' _ v:name _ -> v;
pipeline <- v1:simpleCommand _ v2:((pipe _ simpleCommand _ )*) -> (red v1 v2);
pipe <- '|' -> pipe-struct;
simpleCommand <- ls / cd / mkdir / cat / less / more / man / l / echo / exit / next;

next <- 'next' -> (next-struct);
ls <- 'ls' _ v1:options-ls _ v2:name? -> (ls-struct v1 v2);
options-ls <- ('-l' / '-la' / '-a')?;


cd <- 'cd' _ v:name -> (cd-struct v);
name <- v:([a-zA-Z.]+) -> (shell-identifier v);

mkdir <- 'mkdir' _ v:name -> (mkdir-struct v);

cat <- 'cat' _ v1:name? v2:((_ name)*) -> (cat-struct (flat (cons v1 v2)));

less <- 'less' _ v1:name? -> (less-struct v1);

more <- 'more' _ v1:name? -> (more-struct v1);

man <- 'man' _ v1:name -> (man-struct v1);

l <- 'l' _ v1:name? -> (ls-struct "-l" v1);

echo <- 'echo' _ v:((string / env-variable)*) -> (echo-struct (if (list? v) v (list v)));
string <- [^$;]+;
env-variable <- '$' name:([a-zA-Z]+) -> (env-variable name);

exit <- 'exit' _ v:exit-code -> (exit-struct v);
exit-code <- number;
number <- v:([0-9]+) -> (string->number v);

