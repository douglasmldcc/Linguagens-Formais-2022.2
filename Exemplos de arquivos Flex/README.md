ATENÇÃO - adiei a data de entrega em 1 semana - pq eu peguei COVID e não poderei estar presencialmente na UFRJ para atendimento e dúvidas antes do prazo original de entrega. Agendei o Lab1 no dia 17/11 às 15h, depois da aula regular do Prof. Mitre, para dar uma olhada no andamento dos trabalhos e tirar dúvidas. Importante - esse atendimento é para ajustes finais do trabalho - não dá para chegar no dia 17 zerado!. 


Análise léxica e sintática de uma linguagem de programação usando Flex e Bison

Objetivo:
Desenvolver um analisador sintático para a linguagem LF e uma aplicação simples de análise de arquivos que contenham texto (programas) escritos em LF.
Contexto:
O primeiro trabalho teve como objetivo mostrar como usar autômatos finitos, de uma maneira bem simples, para implementar o reconhecimento de sentenças de uma linguagem regular.  A técnica usada serve para desenvolver analisadores léxicos simples e variações dessa técnica são usadas em quase qualquer analisador léxico existente por aí.

Agora vamos ver como usar ferramentas livres, gratuitas e poderosas para desenvolver um analisador léxico e, posteriormente, para desenvolver um analisador sintático para uma linguagem de programação inventada (com menos recursos do que uma linguagem real).

A primeira parte do projeto é um analisador léxico para a linguagem, desenvolvido com o uso do gerador de analisadores léxicos flex.
O analisador deve receber um arquivo e devolver a sequência de tokens identificada, também em um arquivo. Cada token é uma tupla contendo o tipo de token, o lexema e a linha e a coluna inicial do lexema. Em caso de erro, devolver a sequência até o ponto de erro e a informação de que houve um erro léxico.
Em anexo, as regras léxicas da linguagem LF.
