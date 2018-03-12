


install :
	cp -r etc/* /etc/;
	cp -r usr/* /usr/;
	cp -r var/* /var/;
	mkdir /etc/skel/.desafios -p
	>/etc/skel/.desafios/questsAccepted
	for u in `cut -d: -f1 /etc/passwd`; do \
		mkdir /home/$u/.desafios -p ;\
		>/home/$u/.desafios/questsAccepted ;\
	done
	>/etc/skel/.desafios/questsDone
	for u in `cut -d: -f1 /etc/passwd`; do \
		>/home/$u/.desafios/questsDone;\
	done
	echo 'instalado'


remove :
	rm /etc/desafios.conf
	rm /usr/games/desafios
	rm /usr/games/
	rm -rf /var/games/desafios
