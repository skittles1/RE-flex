/* Parser to convert "C" assignments to lisp. */
/* Compile: bison -d -y flexexample3.y */

%{
#include <stdio.h>
extern int yylex(void);
extern char *yytext;
extern int yyleng;
extern int yylineno;
void yyerror(const char*);
%}

%union {
    int num;
    char* str;
}

%token <str> STRING
%token <num> NUMBER

%%

assignments : assignment
            | assignment assignments
            ;
assignment  : STRING '=' NUMBER ';' { printf("(setf %s %d)\n", $1, $3); }
            ;

%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(const char *msg)
{
  fprintf(stderr, "%s at line %d\n", msg, yylineno);
}
