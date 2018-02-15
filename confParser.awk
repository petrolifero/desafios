#!/usr/bin/awk


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
}


$0 ~ /^include=.*/{
	split($0,b,"include=");
	
}



END{
	aux=""
	for(q in quest){
		aux=aux ":" q;
	}
	print substr(aux,2);
}
