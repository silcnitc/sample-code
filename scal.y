%{
/* Yacc program for a simple calculator */

/*Header files*/
#include<stdio.h>
#include<stdlib.h>

/*Function to calculate power*/
double power(int a, int b);

%}

/*Union for YYSTYPE*/
%union 
{
	int val;
	
};

/*Tokens*/
%token <val> NUMBER
%token END

/*Associativity*/
%left '+' '-'
%left '*' '/'
%left '%'
%nonassoc '^' 
%nonassoc UMINUS

/*Type of non-terminal*/
%type <val> expr
 
/*Start variable*/
%start program

%%

program : expr END				{					
							int ans = $1;
							printf("\nResult : %d\n",ans);
							exit(1);
						}
	;

expr :   expr '+' expr				{$$=$1+$3;		}					
	| expr '-' expr				{$$=$1-$3;		}
	| expr '*' expr				{$$=$1*$3;		}
	| expr '/' expr				{$$=$1/$3;		}
	| expr '%' expr				{$$=$1%$3;		}
	| '(' expr ')'				{$$=$2;			}
	| '-' expr %prec UMINUS			{$$=-1*$2;		}
	| expr '^' expr 			{$$=(int)power($1,$3);	}									
	| NUMBER				{$$=$1;			}
	;


%%

#include "lex.yy.c"

double power(int a,int b)
{
	int i;
	double c=1;	
	for(i=0;i<b;i++)
		c=c*a;
	return c;
}

int yyerror(char *s)
{
	fprintf(stderr, "%s in line no : %d\n", s, yylineno);
	return 1;
}

int yywrap(void)
{
	return 1;	
}
	
int main()
{
	yyparse();
	return 1;
}

