 /*Nome dos alunos / DRE:  Douglas de Morais                     117227656
                          Gabriel Menezes San Segundo Rebello;  120018731
                          
                          */

%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern FILE *yyin;
extern FILE *yyout;

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
 | program decl_var EOL {printf("program decl_var--> program\n\n"); fprintf(yyout,"program decl_var--> program\n\n");}
 | program decl_fun EOL {printf("program decl_fun--> program\n\n"); fprintf(yyout,"program decl_fun--> program\n\n");}
 | program COMMT EOL            {printf("Comentario\n\n"); fprintf(yyout,"Comentario\n\n");}
 | program EOL 
 ;

decl_var: VAR IDS DSPTS tipo TERMINAL {printf("VAR IDS DSPTS tipo TERMINAL--> decl_var\n"); fprintf(yyout,"VAR IDS DSPTS tipo TERMINAL--> decl_var\n");}
 | VAR IDS DSPTS tipo EQ exp TERMINAL {printf("VAR IDS DSPTS tipo EQ exp TERMINAL--> decl_var\n"); fprintf(yyout,"VAR IDS DSPTS tipo EQ exp TERMINAL--> decl_var\n");}
 ;

tipo: INT {printf("INT--> tipo\n"); fprintf(yyout,"INT--> tipo\n");}
 | FLOAT {printf("FLOAT--> tipo\n"); fprintf(yyout,"FLOAT--> tipo\n");} 
 | BOOL {printf("BOOL--> tipo\n"); fprintf(yyout,"BOOL--> tipo\n");} 
 ;

exp: factor {printf("factor --> exp\n"); fprintf(yyout,"factor --> exp\n");}
 | exp ADD factor {printf("exp ADD factor --> exp\n"); fprintf(yyout,"exp ADD factor --> exp\n");}
 | exp SUB factor {printf("exp SUB factor --> exp\n"); fprintf(yyout,"exp SUB factor --> exp\n");}
 ;

factor: term {printf("term --> factor\n"); fprintf(yyout,"term --> factor\n");}
 | factor MUL term {printf("factor MUL term --> factor\n"); fprintf(yyout,"factor MUL term --> factor\n");}
 | factor DIV term {printf("factor DIV term --> factor\n"); fprintf(yyout,"factor DIV term --> factor\n");}
 ;

term: value {printf("value --> term\n"); fprintf(yyout,"value --> term\n");}
 | term EQEQ value {printf("term EQEQ value --> term\n"); fprintf(yyout,"term EQEQ value --> term\n");}
 | term DIFF value {printf("term DIFF value --> term\n"); fprintf(yyout,"term DIFF value --> term\n");}
 ;

value: L_FLOAT {printf("L_FLOAT --> value\n"); fprintf(yyout,"L_FLOAT --> value\n"); }
 | L_INT {printf("L_INT --> value\n"); fprintf(yyout,"L_INT --> value\n");}
 | TRUE {printf("TRUE --> value\n"); fprintf(yyout,"TRUE --> value\n");}
 | FALSE {printf("FALSE --> value\n"); fprintf(yyout,"FALSE --> value\n");}
 ;

decl_fun: FN IDS ABPARANT lista FCPARANT DSPTS tipo ABCOLCH def FCCOLCH TERMINAL
 {printf("FN IDS (lista) : tipo  {def} TERMINAL --> decl_fun\n");
 fprintf(yyout,"FN IDS (lista) : tipo  {def} TERMINAL --> decl_fun\n");  }

lista: {printf("vazio--> lista\n"); fprintf(yyout,"vazio--> lista\n");}
 | IDS tipo {printf("IDS tipo--> lista\n"); fprintf(yyout,"IDS tipo--> lista\n");}
 | IDS tipo VIRG lista {printf("IDS tipo , lista--> lista\n"); fprintf(yyout,"IDS tipo , lista--> lista\n");} /* Isso permitiria (IDS tipo,) dá para garantir que isso não possa ocorrer mas ia ser bem mas complicado então não botei no rascunho */
 ;

def:
 | decl_var def {printf("decl_var def--> def\n"); fprintf(yyout,"decl_var def--> def\n");}
 | cmd cmd_2 {printf("cmd cmd_2--> def\n"); fprintf(yyout,"cmd cmd_2--> def\n");}
 ;

cmd_2:/* epsilon */  {printf("vazio --> cmd_2\n"); fprintf(yyout,"vazio --> cmd_2\n");}
 | cmd cmd_2 {printf("cmd cmd_2--> cmd_2\n"); fprintf(yyout,"cmd cmd_2--> cmd_2\n");}
 ;

cmd: IDS EQ exp TERMINAL {printf("IDS = exp TERMINAL --> cmd\n"); fprintf(yyout,"IDS = exp TERMINAL --> cmd\n");}/* eu não tenho certeza se identificador seria o correto aqui, mas acho que é isso mesmo e o analizador semântico que é responsável por conectar o id cmd os dados da variável*/
 | IF ABPARANT cond FCPARANT ABCOLCH cmd cmd_2 FCCOLCH TERMINAL  {printf("IF (cond) {cmd cmd_2} TERMINAL--> cmd\n"); fprintf(yyout,"IF (cond) {cmd cmd_2} TERMINAL--> cmd\n");}
 | IF ABPARANT cond FCPARANT ABCOLCH cmd cmd_2 FCCOLCH ELSE ABCOLCH cmd cmd_2 FCCOLCH TERMINAL  {printf("IF (cond) {cmd cmd_2} ELSE {cmd cmd_2} TERMINAL--> cmd\n"); fprintf(yyout,"IF (cond) {cmd cmd_2} ELSE {cmd cmd_2} TERMINAL--> cmd\n");}
 | WHILE ABPARANT cond FCPARANT ABCOLCH cmd cmd_2 FCCOLCH TERMINAL {printf("WHILE (cond) {cmd cmd_2} TERMINAL--> cmd\n"); fprintf(yyout,"WHILE (cond) {cmd cmd_2} TERMINAL--> cmd\n");}
 | RETURN exp TERMINAL {printf("RETURN exp TERMINAL--> cmd\n"); fprintf(yyout,"RETURN exp TERMINAL--> cmd\n");}
 ;

cond: TRUE {printf("TRUE--> cond\n"); fprintf(yyout,"TRUE--> cond\n");}
 | FALSE {printf("FALSE--> cond\n"); fprintf(yyout,"FALSE--> cond\n");}
 | exp {printf("exp --> cond\n"); fprintf(yyout,"exp --> cond\n");}
 ;

%%

int main(int argc, char **argv) {
    FILE *file;
    FILE *file2;

    if (argc == 3) {
        file = fopen(argv[1], "r");
        file2 = fopen(argv[2], "w");
        if (!file) {
            fprintf(stderr, "Could not open file %s\n", argv[1]);
            return 1;
        }
        if (!file2) {
            fprintf(stderr, "Could not open file 2 %s\n", argv[1]);
            return 1;
        }
        yyin = file;
        yyout = file2;
    } else if (argc == 2){
        fprintf(stderr, "Usage: %s output_file\n", argv[0]);
        return 1;
    } else {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }
    yyparse();

    if (file) {
        fclose(file);
    }

    return 0;
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}