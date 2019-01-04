#lang racket

(require charterm)

(with-charterm
	(charterm-screen-size #:charterm (current-charterm)))
