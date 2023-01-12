%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include "analsin.tab.h"



%}

Lint [0-9]+
Lfloat [0-9]*\.[0-9]+ 
Ids [a-zA-Z_][a-zA-Z0-9_]*
Comentarios [/][/](.)*|("/*"[^*/]*[\n]*[\n]*"*/")

/*Regras de Traducao*/
/* { Regra } { Salva os dados; Anda as colunas}*/
%%

{Lint} {yylval = atoi(yytext); return L_INT; } 
{Lfloat} {yylval = atoi(yytext); return L_FLOAT;} 

 /* { Regra } { Salva os dados; Anda as colunas}*/
 "if"       { return IF; }
 "else"     { return ELSE; }
 "while"    { return WHILE; }
 "var"      { return VAR; }
 "return"   { return RETURN; }
 "fn"       { return FN; }
 "bool"     { return BOOL; }
 "int"      { return INT; }
 "float"    { return FLOAT; }
 "true"     { return TRUE; }
 "false"    { return FALSE; }
 "="        { return EQ; }
 "("        { return ABPARANT; }
 ")"        { return FCPARANT; }
 "{"        { return ABCOLCH; }
 "}"        { return FCCOLCH; }
 ","        { return VIRG; }
 ":"        { return DSPTS; }

{Ids} {yylval = atoi(yytext); return IDS; } 

 /* Operadores */

"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV;}
"=="        { return EQEQ;}
"!="        { return DIFF; }

 /*Simbolo terminal */

";"         { return TERMINAL; }
\n          { return EOL; }
{Comentarios}    { return COMMT; }


<<EOF>>         { return EOF; }
%%
