


install :
	cp -r etc/* /etc;
	cp -r usr/* /usr;
	cp -r var/* /var;
	echo 'instalado'


remove :
	rm /etc/desafios.conf
	rm /usr/games/desafios
	rm /usr/games/
	rm -rf /var/games/desafios
