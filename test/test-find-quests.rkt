#lang racket

(require "../main.rkt")
(require rackunit)

(check-equal?
	(find-quests "tutorial")
	(quest
		(idt "tutorial")
		'()
		(seq
			(echo-struct '("sdasdsadsad"))
			(exec (idt "ls")))))
(find-quests "ls")

(check-equal?
	(find-quests "xargs")
	#f)
