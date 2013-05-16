%{
/*Executing comments using states*/
/*Rules without conditonal state specification will be executed in any state (this is correct) */
/*Simple scanner which scans for identifiers, constants and mathematical operators*/

#include<stdlib.h>
#include<stdio.h>

%}

number 	[0-9]+
id	[a-zA-Z][a-zA-Z0-9]*
op 	[-|+|*|/|^|=]


%option noyywrap

%s COMMENT
%s PROGRAM
%%

"/*"		{printf(" Comment initiated ");BEGIN COMMENT;}
<COMMENT>"*/"   {printf("Comment closed "); BEGIN PROGRAM;}
<COMMENT>(.)*   {printf("Inside comment");}
"BEGIN"		printf(" Section-begin ");
"END"		return 1;
{op}		printf(" Math-operator ");
{number}	printf(" Constant ");
{id}		printf(" Identifier ");


%%

int main()
{
	if(yylex()==1)
		printf("\nSection-end\n");
	return 0;
}
