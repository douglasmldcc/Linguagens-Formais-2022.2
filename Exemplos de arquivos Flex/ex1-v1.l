%{
#include <stdio.h>
#include <stdlib.h>

/* aqui estamos definindo um tipo enumerado que traduz o retorno do analisador em palavras (valido e invalido) */
typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

%%

<<EOF>>         { return eof; }
[abc]+c         { return valido; }
  /* a unica ER que estamos tentando reconhecer - uma sequencia de caracteres a, b e c, com pelo menos 2 caracteres, terminada em um c */
  /* IMPORTANTE - aqui na secao das regras, os comentarios nao podem comecar na primeira coluna da linha */

%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

/* na ultima secao, definimos codigo a ser copiado no arquivo gerado pelo flex */
/* no caso, estamos definindo uma funcao main que chama o analisador (yylex)
e analisa o resuldado, mostrando para o usuario se a string foi reconhecida ou nao pelo analisador. */
/* IMPORTANTE - toda comunicacao com o usuario (p.ex., os prints) deve acontecer aqui e nao no codigo
associado a cada regra - posteriormente, quem vai fazer o papel de programa principal que vai chamar o
lexico eh o analisador sintatico. */

int main() {

    if ( (TOKEN) yylex() == valido ) {
        printf("\n valido\n");
    } else {
        printf("\n invalido\n");
    }
    return 0;
}
