#lang racket

(require rackunit)
(require "../shell.rkt")
(check-equal?
	(parser "echo ola")
	(echo-struct "ola")
	"string simples")
(check-equal?
	(parser "echo Seu nome é Joao")
	(echo-struct "Seu nome é Joao")
	"acento agudo")
(check-equal?
	(parser "echo Seu nome é João")
	(echo-struct "Seu nome é João")
	"Til")
(check-equal?
	(parser "echo Seu nome é $USER")
	(echo-struct (list "Seu nome é " (env-variable "USER")))
	"Variavel de ambiente")
(check-equal?
	(parser "echo Seu nome é $USER Silva")
	(echo-struct (list "Seu nome é " (env-variable "USER") " Silva"))
	"Variavel de ambiente no meio de strings")

