%{
	#include "parser.tab.h"
	#include <stdio.h>


%}

letters [a-zA-Z]
digit [0-9]
oprel <=|>=|>|<|==

id {letters}({letters}|{digit})
Iconst "0"|[0-9]{digit}*
Fconst "0"|{digit}*"."{digit}
esp [ ]
str    \"{print}*\"

%%

"int" {return INT;}
"double" {return DOUBLE;}
"\n" {return FIN;}
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

{Iconst} {yyval.integer=atoi(yytext); return(NB);}
{Fconst} {yyval.val_float=atof(yytext); return(FB);}
{id}	 {yylval.val_char=strdup(yytext);return(ID);}
{str}    { yylval.str_val = malloc(yyleng * sizeof(char));
              strcpy(yylval.str_val, yytext);  return STRING; }

. {yyerror("unrecognized character");}

%%