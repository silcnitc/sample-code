%{
/*LEXER FOR SIL BY NACHIAPPAN.V */	

	#include "y.tab.h"
	#include<stdlib.h>
	#include<stdio.h>
	
	int yylineno;
		
%}


number  [0-9]+
op 	[-|+|*|/]	

%%

" "  		;
[\n]		return END;
{op}		return *yytext;
\%		return *yytext;
\^		return *yytext;
{number}	{
			yylval.val=atoi(yytext);
			return NUMBER;
		}
[\(\)] 	return *yytext;
.	yyerror("ERROR");
%%
