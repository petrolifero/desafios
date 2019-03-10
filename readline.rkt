#lang racket

(require readline/pread)
(require readline/readline)

(provide my-readline)
;limpar historico
(for ((i (in-range 0 (history-length))))
	(history-delete 0))

(define (my-readline prompt)
	(readline prompt))

