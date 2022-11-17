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
(.|[\n])*       { return invalido; }

  /* a difereca eh que agora temos uma ER que casa com qq string de entrada - entao, se houver uma sobra
apos o reconhecimento de uma cadeia valida pela regra [abc]+c, pela regra da prioridade para o maior lexema
possivel, o analisador vai aplicar essa ultima regra, retornando invalido */

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
