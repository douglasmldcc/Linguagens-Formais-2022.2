%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

/* podemos dar nomes para a linguagem correspondente a uma ER */
VALIDO      [abc]+c
INVALIDO    (.)*

/* observe que aqui colocamos so o ponto - sem o \n - isso muda o que vai ser reconhecido em relacao
ao exemplo anterior, que capturava tambem o \n */

%%

<<EOF>>          { return eof; }
{VALIDO}         { return valido; }
{INVALIDO}       { return invalido; }


%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

int main() {

    if ( (TOKEN) yylex() == valido ) {
        printf("\n valido\n");
        printf("A palavra %s pertence a linguagem.\n", yytext);
    } else {
        printf("\n invalido\n");
        printf("A string %s nao pertence linguagem.\n", yytext);
    }
    return 0;
}
