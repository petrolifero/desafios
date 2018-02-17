#!/usr/bin/awk


#receive a config file and print all the quest's Path


#input : a.config

#output : /var/games/desafios:/home/stallman/.desafios/quests




BEGIN{
	quest=""
}



#if is a comment, ignore

$0 ~ /^#.*/{
	next;
}



#if is a quest path definition, add to a array

$0 ~ /^quest=.*/{
	split($0,a,"quest=");
	quest[a[2]]=a[2];
	del a[1];
	del a[2];
}


$0 ~ /^include=.*/{
	split($0,b,"include=");
	"awk -f ./confParser.awk " b[2] | getline c;
	split(c,aux,":");
	for(q in aux)
	{
		quest[aux[q]]=aux[q];
		del aux[q];
	}
}



END{
	aux=""
	for(q in quest){
		aux=aux ":" q;
	}
	print substr(aux,2);
}
