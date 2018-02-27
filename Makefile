


install :
	cp -r etc/* /etc/;
	cp -r usr/* /usr/;
	cp -r var/* /var/;
	mkdir /etc/skeleton/.desafios
	>/etc/skeleton/.desafios/questsAccepted
	for user in `cut -d: -f1 /etc/passwd`
	do
		mkdir /home/$user/.desafios
		>/home/$user/.desafios/questsAccepted
	done
	>/etc/skeleton/.desafios/questsDone
	for user in `cut -d: -f1 /etc/passwd`
	do
		>/home/$user/.desafios/questsDone
	done
	echo 'instalado'


remove :
	rm /etc/desafios.conf
	rm /usr/games/desafios
	rm /usr/games/
	rm -rf /var/games/desafios
