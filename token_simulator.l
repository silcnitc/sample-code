%{
/* Token simulator program
Scan and return a token for identifiers of the format : (string)(number)
Note : strings are not case sensitive
examples : a0 , A1 , ab2 , AB4 , aBc5
*/

#include<stdio.h>

#define ID 1	//Identifier token
#define ER 2	//Error token

%}

low_case [a-z]
upp_case [A-Z]
number	 [0-9]

%option noyywrap

%%

({low_case}|{upp_case})({low_case}|{upp_case})*({number})	return ID;
(.)*								return ER;

%%
int main()
{
	int token = yylex();
	if(token==ID)
		printf("Acceptable\n");
	else if(token==ER)
		printf("Unacceptable\n");
	return 1;
}
