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
%token ADD SUB MUL DIV ABS EQEQ DIFF

%token EOL


%%

program:
 | program decl_var EOL {printf("program decl_var--> program\n");}
 | program decl_fun EOL {printf("program decl_fun--> program\n");}
 | EOL 
 | COMMT EOL            {printf("Comentario de linha unica\n");}
 ;

decl_var: VAR IDS DSPTS tipo TERMINAL {printf("VAR IDS DSPTS tipo TERMINAL--> decl_var\n");}
 | VAR IDS DSPTS tipo EQ exp TERMINAL {printf("VAR IDS DSPTS tipo EQ exp TERMINAL--> decl_var\n");}
 ;

tipo: INT {printf("INT--> tipo\n");}
 | FLOAT {printf("FLOAT--> tipo\n");} 
 | BOOL {printf("BOOL--> tipo\n");} 
 ;

exp: L_FLOAT {printf("L_FLOAT --> exp\n");}/* só botei o básico podemos botar suporte para operações depois*/
 | L_INT {printf("L_INT --> exp\n");}/* nós precisamos fazer que o analizador léxico saiba que se for int tem que ser L_INT ou isso é só trabalho para o analizador semântico? Eu acho que lembro dela falando que isso é só o semântico que detecta mas posso estar lembrando errado*/
 | TRUE {printf("TRUE --> exp\n");}
 | FALSE {printf("FALSE --> exp\n");}
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
 | IF ABPARANT COND FCPARANT ABCOLCH cmd cmd_2 FCCOLCH TERMINAL  {printf("IF (COND) {cmd cmd_2} TERMINAL--> cmd\n");}
 | IF ABPARANT COND FCPARANT ABCOLCH cmd cmd_2 FCCOLCH ELSE ABCOLCH cmd cmd_2 FCCOLCH TERMINAL  {printf("IF (COND) {cmd cmd_2} ELSE {cmd cmd_2} TERMINAL--> cmd\n");}
 | WHILE ABPARANT COND FCPARANT ABCOLCH cmd cmd_2 FCCOLCH TERMINAL {printf("WHILE (COND) {cmd cmd_2} TERMINAL--> cmd\n");}
 | RETURN exp TERMINAL {printf("RETURN exp TERMINAL--> cmd\n");}
 ;

COND: TRUE {printf("TRUE--> COND\n");}
 | FALSE {printf("FALSE--> COND\n");}
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