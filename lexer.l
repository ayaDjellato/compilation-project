%{
	#include "parser.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	
	void yyerror();
%}

letters [a-zA-Z]
digit [0-9]
oprel <=|>=|>|<|==
print [-~]

id {letters}({letters}|{digit})
Iconst "0"|[0-9]{digit}*
Fconst "0"|{digit}*"."{digit}
esp [ \t]+
str    \"{print}*\"

%%
{esp}
"int" {return INT;}
"double" {return DOUBLE;}
"return" {return RETURN;}
"if" {return IF;}
"while" {return WHI;}
"else" {return ELSE;}

"+" {return PLUS;}
"-" {return MOIN;}
"*" {return MUL;}

"(" {return OB;} /*open bracket*/
")" {return CB;} /*closing brackets*/
"}" {return CBC;}
"{" {return OBC;}
"," {return COMMA;}
";" {return SEMI;}
"=" {return AFF;}


{oprel} {return ROP;}

{Iconst} {yylval.int_val=atoi(yytext); return(NB);}
{Fconst} {yylval.d_val=atof(yytext); return(FB);}
{id}	 {yylval.chain=strdup(yytext);return(ID);}
{str}    { yylval.chain = malloc(yyleng * sizeof(char));
              strcpy(yylval.chain, yytext);  return STRING; }

. {yyerror("unrecognized character");}

%%
