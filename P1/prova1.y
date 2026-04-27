%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *msg);

%}

%token ERROR
%token IDENT NUM STRING
%token PRINT CONCAT LENGTH
%token EQUAL OPEN CLOSE COMMA

%left '+' '-'
%left '*' '/'

%start program

%%

/* programa */
program
: stmt_list 
;

stmt_list
: stmt
| stmt_list stmt
;

stmt
: IDENT EQUAL expr
| PRINT OPEN exprlist CLOSE
| expr
;

exprlist
: expr
| exprlist COMMA expr
;

expr
: expr '+' expr
| expr '-' expr
| expr '*' expr
| expr '/' expr
| OPEN expr CLOSE
| NUM
| STRING
| IDENT
| CONCAT OPEN exprlist CLOSE
| LENGTH OPEN expr CLOSE
;

%%