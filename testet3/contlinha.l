/*Declaracoes*/
%{
#include<stdio.h>
#include <stdlib.h>

// Variaveis contadoras para linha e coluna 
int ln=1, col=1; 
%}

Lint [0-9]+
Lfloat [0-9]*\.[0-9]+ 
PReservadas "if"|"else"|"while"|"var"|"return"|"fn"|"bool"|"int"|"float"|"true"|"false"|"="|"("|")"|"{"|"}"|","|":"
Ids "_"*[a-zA-Z]*"_"*[a-zA-Z]*

comentarioSL "//"(.)*
comentarioML ([/][/][^\n]*[\n])|([/][*][^*/]*[*][/])

/*Regras de Traducao*/
/* { Regra } { Salva os dados; Anda as colunas}*/
%%

{Lint} {fprintf(yyout,"Inteiro '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);} 
{Lfloat} {fprintf(yyout,"Float '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);} 
{PReservadas} {fprintf( yyout,"Palavra Reservada '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);} 
{Ids} {fprintf(yyout,"Identificadores '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);} 

 /* Operadores */
"+"    { fprintf(yyout,"ADD '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }
"-"    { fprintf(yyout,"SUB '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }
"*"    { fprintf(yyout,"MUL '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }
"/"    { fprintf(yyout,"DIV '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);}
"|"    { fprintf(yyout,"ABS '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }
"=="    { fprintf(yyout,"EQEQ '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext);}
"!="    { fprintf(yyout,"DIFF '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }

 /*Simbolo terminal */
";"    { fprintf(yyout,"TERMINAL '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }

\n {ln++;col=1;} //Contando linhas e resetando o valor das colunas
([ ])+ col++; //Conta os espacos e adicional o contador de colunas
. col++;     //Conta os outros caracteres

{comentarioSL} { fprintf(yyout,"Comentario de linha unica '%s' ln %d col %d \n",yytext,ln,col); col+=strlen(yytext); }
{comentarioML} { fprintf(yyout,"Comentario multi linha  ln %d col %d \n",ln,col); col+=strlen(yytext); } 
%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

/*Codigo Auxiliar*/ 
int main(){
    //Abre arquivo de leitura c em lex
    yyin = fopen("Entrada.txt", "r");
    //Abre arquivo de escrita c em lex
    yyout = fopen("Resultado.txt", "w");
    yylex();
    return 0;
}