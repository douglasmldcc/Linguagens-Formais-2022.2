Pessoal. Alguns tinham pedido. Aqui vai um exemplo bem simples de arquivo bison (e o flex e o makefile).
 
É uma calculadora simples, exemplo do livro de flex e bison. 

* calc.l é o arquivo de entrada do flex

* calc.y é o arquivo para o bison

* o makefile contém os comandos com a ordem de dependência. Observem que o bison precisa ser executado primeiro, pois a declaração dos tipos de tokens é gerada pelo bison e importada pelo flex.

A execução do arquivo calcula aceita expressões como 2+3*5 e imprime o resultado da conta: = 17

Bom estudo,
Anamaria