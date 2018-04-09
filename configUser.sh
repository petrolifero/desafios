#!/bin/sh

	for u in `ls /home/`; do 
		mkdir /home/$u/.desafios -p ;
		>/home/$u/.desafios/questsAccepted ;
		>/home/$u/.desafios/questsDone;
	done
	
