#!/bin/sh

	for u in `cut -d: -f1 /etc/passwd`; do \
		mkdir /home/$(u)/.desafios -p ;\
		>/home/$(u)/.desafios/questsAccepted ;\
	done

	for u in `cut -d: -f1 /etc/passwd`; do \
		>/home/$(u)/.desafios/questsDone;\
	done
	
