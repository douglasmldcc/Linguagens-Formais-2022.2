calcula: lex.yy.o
	cc -g -o analise anals.tab.c lex.yy.o

lex.yy.o: lex.yy.c calc.tab.h
	cc -g -c lex.yy.c

lex.yy.c: calc.l calc.tab.h
	flex analex.l

calc.tab.h calc.tab.c: calc.y
	bison -d analsin.y

