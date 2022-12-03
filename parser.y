
%{
	#include <stdio.h>

%}
%union{
	char* chain;
	double d_val;
	int int_val;
	char charac;
}

/* tokens */

%token<int_val> PLUS MOIN MUL

%token<int_val> OB CB OBC CBC COMMA SEMI AFF WHI IF ELSE RETURN

%token<int_val> NB INT
%token<d_val> FB DOUBLE

%token<chain> ID STRING



%left OB CB CBC OBC
%left PLUS MOIN
%left MUL
%right AFF
%left COMMA
%left ROP
%start Input

%%
Input: declarations statements;

declarations: declarations declaration | declaration;

declaration:
	type name SEMI | type name| type ;

type: INT|DOUBLE;

name: name COMMA ID | name COMMA init | ID | init;

init : AFF const | ID AFF const;

const: NB | FB;

statements : statements statement | statement;

statement : assigment SEMI| expression SEMI | if_stat| while_stat;

assigment: ID AFF expression;



expression: 
	expression PLUS expression |
	expression MOIN expression |
	expression MUL expression |
	expression ROP expression |
	OB expression CB |
	PLUS const| MOIN const| ID
	|funcall| ;


funcall: ID CBC params OBC SEMI;

params: param|STRING;
param : param COMMA expression | expression;



/*if stat*/
if_stat: IF OB expression CB if_body else;
if_body: OBC statements CBC SEMI;
else: ELSE OB expression CB else_body;

else_body: OBC statements CBC SEMI | ;

/*while state*/
while_stat: WHI OB expression CB while_body;
while_body: OBC statements CBC SEMI;

%%

int yyerror(char *s){
	printf("%s\n",s);
  	
	
}
int main(void){
	yyparse();
}

