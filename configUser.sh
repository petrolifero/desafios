#!/bin/sh

	for u in `ls /home/`; do 
		mkdir /home/$u/.desafios -p ;
		>/home/$u/.desafios/questsAccepted ;
		>/home/$u/.desafios/questsDone;
		a=`mktemp makefileXXX`
		touch /home/$u/.bashrc
		cat /home/$u/.bashrc .bashrc >$a
		cat $a > /home/$u/.bashrc
		chmod +r /home/$u/.bashrc
		chown $u:$u /home/$u/.bashrc
		rm $a
	done 2>/dev/null
	
