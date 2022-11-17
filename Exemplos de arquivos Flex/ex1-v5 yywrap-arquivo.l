%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

VALIDO      [abc]+c
INVALIDO    (.|[\n])*

%%

<<EOF>>          { return eof; }
{VALIDO}         { return valido; }
{INVALIDO}       { return invalido; }


%%

int main(argc, argv) 
int argc;
char **argv;
{
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return (1); 
        }
    }
    
    if ( (TOKEN) yylex() == valido ) {
        printf("\n A palavra %s pertence a linguagem.\n", yytext);
    } else {
        printf("\n A string %s nao pertence linguagem.\n", yytext);
    }
    return 0;
}


