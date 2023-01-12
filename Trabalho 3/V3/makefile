analise: lex.yy.o
	cc -g -o analise analsin.tab.c lex.yy.o

lex.yy.o: lex.yy.c analsin.tab.h
	cc -g -c lex.yy.c

lex.yy.c: analex.l analsin.tab.h
	flex analex.l

analsin.tab.h analsin.tab.c: analsin.y
	bison -d analsin.y

