# desafios

arquitetura
	shellinaboxd expõe "login" para os usuarios.
	o login sendo feito, o usuario será redirecionado para seu shell.
	Este shell, para os usuarios do jogo, será o binario produzido pelo
	entrance.c

	
	____________      __________
	|entrance.c|  --> |main.rkt|
	|__________|  <-- |________|


	main.rkt controlará a logica do jogo, se um usuario pode realizar
	um comando, se a execução de um comando avançará alguma quest, etc.

	entrance.c controlará a interface com o usuario : lerá a linha de
	comando com readline e comunicará ao main.rkt

	Para a comunicação dar certo, usarei um protocolo como o ftp :
	existirão 3 pipes nomeados, a saber a,b e c(nomes precisam melhorar)
	com aas seguintes funções :
         _
	|a|  :   entrance.c escreverá nele, para fins de controle. Entrance
	|_|      dirá para main.rkt se irá mandar um comando do usuario ou se
                 deseja verificar quais tab-complete ele deve oferecer.
         _
	|b|  :   entrance.c escreverá nele. Por aqui entrance mandará a linha
        |_|      lida do usuario para que main.rkt possa parsear e atualizar
                 seu estado OU os argumentos da função de auto-complete

	 _
        |c|  :   main.rkt escreverá nele. Por aqui main.rkt dará a resposta do
        |_|      sistema para o comando digitado ou a lista dos auto-completes
                 apropriados.
