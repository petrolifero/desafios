


install :
	cp -r etc/* /etc/;
	cp -r usr/* /usr/;
	cp -r var/* /var/;
	mkdir /etc/skel/.desafios -p
	>/etc/skel/.desafios/questsAccepted
	>/etc/skel/.desafios/questsDone
	./appendBashrc
	./configUser.sh
	echo 'instalado'


remove :
	rm /etc/desafios.conf
	rm -rfv /usr/games/desafios
	rm -rf /var/games/desafios
