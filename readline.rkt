#lang racket

(require readline/pread)
(require readline/readline)

(provide (all-defined-out))

(define aux #f)

(define (exit-complete str)
	(if (string-prefix? "exit" str)
		'("exit") '()))

(define (ls-complete str)
	(if (string-prefix? "ls" str)
		'("ls") '()))

(define (echo-complete str)
	(if (string-prefix? "echo" str)
		'("echo") '()))

(define commands-complete `(,echo-complete ,ls-complete ,exit-complete))

(define (complete partial-command)
	(flatten (map (lambda (x) (x partial-command)) commands-complete)))


(define (my-readline prompt)
	(set-completion-function! complete)
	(readline prompt))

