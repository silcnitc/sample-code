%{
	/* Calculator (using expression syntax tree) by Nachi */

/*Node type constants*/
#define EXPR 11
#define PLUS 22
#define MINUS 33
#define MUL 44
#define DIV 55
#define REM 66
#define NEG 77
#define POW 88
#define NUM 99

/*Header files*/
#include<stdio.h>
#include<stdlib.h>

/*Data structure of a binary tree (which will be used to implement the expression syntax tree)*/
struct node
{
	int type;
	int num;
	struct node *left;
	struct node *right;
};

/*Function declarations : */

/*To report an error */
void yyerror(char *);

/*To calculate power*/
double power(int a, int b);

/*To make a leaf in the tree*/
struct node* makeLeaf(int type,int num);

/*To make a node in the tree*/
struct node* makenode(int type,struct node *left, struct node*right);

/*To recursively descend the tree and calculate the value of the expression*/
int calculate(struct node *t);

%}


%union 
{
	struct node *ptr;
	int val;
	
};

%token <val> NUMBER
%token END

%left '+' '-'
%left '*' '/'
%left '%'
%nonassoc '^' 
%nonassoc UMINUS

%type <ptr> expr 
%start program

%%

program : expr END				{					
							int ans = calculate($1);
							printf("\nResult : %d\n",ans);
							exit(1);
						}
	;

expr :   expr '+' expr				{$$=makenode(PLUS,$1,$3);	}				
	| expr '-' expr				{$$=makenode(MINUS,$1,$3);	}
	| expr '*' expr				{$$=makenode(MUL,$1,$3);	}
	| expr '/' expr				{$$=makenode(DIV,$1,$3);	}
	| expr '%' expr				{$$=makenode(REM,$1,$3);	}
	| '(' expr ')'				{$$=$2;				}
	| '-' expr %prec UMINUS			{$$=makenode(NEG,$2,NULL);	}
	| expr '^' expr 			{$$=makenode(POW,$1,$3);	}		
	| NUMBER				{$$=makeLeaf(NUM,$1);		}

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

struct node* makeLeaf(int type,int num)
{
	struct node *ptr=malloc(sizeof(struct node));
	
	ptr->type=type;
	ptr->num=num;
	ptr->left=NULL;
	ptr->right=NULL;

	return ptr;
}

struct node *makenode(int type,struct node *left, struct node*right)
{
	struct node *ptr=malloc(sizeof(struct node));

	ptr->type=type;
	ptr->left=left;
	ptr->right=right;

	return ptr;
}

int calculate(struct node *t)
{

	if(t!=NULL)
	{
		int ret;
		if(t->type==PLUS)
		{	
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = a+b;
		}
		else if(t->type==NEG)
		{
			int temp = calculate(t->left);
			temp = temp * -1;
			ret = temp;
		}
		
		else if(t->type==MINUS)
		{
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = a-b;
		}
		else if(t->type==MUL)
		{
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = a*b;
		}
		else if(t->type==DIV)
		{
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = a/b;
		}
		else if(t->type==REM)
		{
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = a%b;
		}
		else if(t->type==POW)
		{
			int a = calculate(t->left);
			int b = calculate(t->right);
			ret = (int)power(a,b);
		}
		else if(t->type==EXPR)
		{
			int a=calculate(t->left);
			ret = a;
		}
		else if(t->type==NUM)
		{
			ret = t->num;
			
		}
		return ret;
	}
	
	else
		return 0;
}
		


void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}
int yywrap(void)
{
	return 1;	
}
	
int main()
{
	yyparse();
	return 0;
}

