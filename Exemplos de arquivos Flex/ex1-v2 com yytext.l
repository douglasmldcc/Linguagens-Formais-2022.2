%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

%%

<<EOF>>         { return eof; }
[abc]+c         { return valido; }

%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

/* agora estamos usando a variavel yytext, exportada pelo analisador lexico,
para ver a sequencia de caracteres que foi reconhecida (o lexema) */

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
