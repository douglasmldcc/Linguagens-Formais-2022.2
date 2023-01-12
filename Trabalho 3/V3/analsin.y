/*Nome dos alunos: Gabriel Menezes San Segundo Rebello; */
/*DREs: 120018731; */

%{
#include <stdio.h>
%}

 /*Leitores e identificadores */

%token IDS L_INT L_FLOAT

 /* Palavras Reservadas */
 
%token IF ELSE WHILE VAR RETURN FN  
%token BOOL INT FLOAT TRUE FALSE
%token EQ ABPARANT FCPARANT ABCOLCH FCCOLCH VIRG DSPTS
%token TERMINAL COMMT

 /* Operadores */
%token ADD SUB MUL DIV EQEQ DIFF

%token EOL


%%

program:   {printf("Cabo\n");}
 | program decl_var EOL {printf("program decl_var--> program\n");}
 | program decl_fun EOL {printf("program decl_fun--> program\n");}
 | program EOL 
 | COMMT EOL            {printf("Comentario\n");}
 ;

decl_var: VAR IDS DSPTS tipo TERMINAL {printf("VAR IDS DSPTS tipo TERMINAL--> decl_var\n");}
 | VAR IDS DSPTS tipo EQ exp TERMINAL {printf("VAR IDS DSPTS tipo EQ exp TERMINAL--> decl_var\n");}
 ;

tipo: INT {printf("INT--> tipo\n");}
 | FLOAT {printf("FLOAT--> tipo\n");} 
 | BOOL {printf("BOOL--> tipo\n");} 
 ;

exp: factor {printf("factor --> exp\n");}
 | exp ADD factor {printf("exp ADD factor --> exp\n");}
 | exp SUB factor {printf("exp SUB factor --> exp\n");}
 ;

factor: term {printf("term --> factor\n");}
 | factor MUL term {printf("factor MUL term --> factor\n");}
 | factor DIV term {printf("factor DIV term --> factor\n");}
 ;

term: value {printf("value --> term\n");}
 | term EQEQ value {printf("term EQEQ value --> term\n");}
 | term DIFF value {printf("term DIFF value --> term\n");}
 ;

value: L_FLOAT {printf("L_FLOAT --> value\n");}
 | L_INT {printf("L_INT --> value\n");}
 | TRUE {printf("TRUE --> value\n");}
 | FALSE {printf("FALSE --> value\n");}
 ;

decl_fun: FN IDS ABPARANT Lista FCPARANT DSPTS tipo ABCOLCH def FCCOLCH TERMINAL {printf("FN IDS (Lista) : tipo  {def} TERMINAL --> decl_fun\n");}

Lista: {printf("vazio--> Lista\n");}
 | IDS tipo {printf("IDS tipo--> Lista\n");}
 | IDS tipo VIRG Lista {printf("IDS tipo , Lista--> Lista\n");} /* Isso permitiria (IDS tipo,) dá para garantir que isso não possa ocorrer mas ia ser bem mas complicado então não botei no rascunho */
 ;

def:
 | decl_var def {printf("decl_var def--> def\n");}
 | cmd cmd_2 {printf("cmd cmd_2--> def\n");}
 ;

cmd_2:/* epsilon */  {printf("vazio --> cmd_2\n");}
 | cmd cmd_2 {printf("cmd cmd_2--> cmd_2\n");}
 ;

cmd: IDS EQ exp TERMINAL {printf("IDS = exp TERMINAL --> cmd\n");}/* eu não tenho certeza se identificador seria o correto aqui, mas acho que é isso mesmo e o analizador semântico que é responsável por conectar o id cmd os dados da variável*/
 | IF ABPARANT cond FCPARANT ABCOLCH def FCCOLCH TERMINAL  {printf("IF (cond) {cmd cmd_2} TERMINAL--> cmd\n");}
 | IF ABPARANT cond FCPARANT ABCOLCH def FCCOLCH ELSE ABCOLCH def FCCOLCH TERMINAL  {printf("IF (cond) {cmd cmd_2} ELSE {cmd cmd_2} TERMINAL--> cmd\n");}
 | WHILE ABPARANT cond FCPARANT ABCOLCH def FCCOLCH TERMINAL {printf("WHILE (cond) {cmd cmd_2} TERMINAL--> cmd\n");}
 | RETURN exp TERMINAL {printf("RETURN exp TERMINAL--> cmd\n");}
 ;

cond: TRUE {printf("TRUE--> cond\n");}
 | FALSE {printf("FALSE--> cond\n");}
 | exp {printf("exp --> cond\n");}
 ;

%%

main(int argc, char **argv)
{
  yyparse();
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}