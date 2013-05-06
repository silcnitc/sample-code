%{
/*Simple scanner which scans for strings (with case specification),numbers and special characters and prints the classification*/
#include<stdlib.h>
#include<stdio.h>
%}

number 		[0-9]+
lowletter	[a-z]
upletter	[A-Z]
mixletter	[a-zA-Z]

%%


{number}	printf("Number : %d\n",atoi(yytext));
{lowletter}+	printf("Lower case string : %s\n",yytext);
{upletter}+	printf("Upper case string : %s\n",yytext);
{mixletter}+	printf("Mixed case String : %s\n",yytext);
.		printf("Special character : %s\n",yytext);

%%
int yywrap()
{
	return 1;
}
int main()
{
	yylex();
	return 0;
}
