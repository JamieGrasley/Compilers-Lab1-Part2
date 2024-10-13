%{

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

extern int yylex();  
extern int yyparse(); 
extern void yyerror(const char *s);
#define SIZE 5
int count = 0;
int stack[SIZE]={1};


void push(int value){
if(count<SIZE){
        count++;
        stack[count]=value;
        
}
else{
        printf("Stack full");
}
}
int pop(){
if(count>=0){

        return stack[count--];
}
else{
        printf("Stack empty");
        return -1;
}
}
int top(){
if(count>=0){
        return stack[count];
}
else{
        printf("Stack empty");
        return -1;
}   
}

%}

%union {
    int intval;
    char* strval;
}

%token IF THEN ELSE ENDIF PRINT NEWLINE SEMICOLON STOP
%token ADD SUB MULT DIV LES GRE LEQ GEQ COMP NEQ LBR RBR
%token <strval> STR
%type <intval> expr
%token <intval> INT




%left ADD SUB   // Define operator precedence
%left MULT DIV
%nonassoc LES GRE LEQ GEQ COMP NEQ 


%%

program:
        stmt_list
        ;

stmt_list:
        stmt stmt_list
        |
        ;
stmt:
        if_stmt
        |print_stmt
        |newline
        |end_stmt
        |expr
        ;
if_stmt:
    IF expr THEN {top()==1 ? push($2!=0) : push(0);} stmt_list {pop();}  
    ELSE {top()==1 ? push($2==0) : push(0);} stmt_list {pop();} ENDIF  
    ;



print_stmt:
        PRINT STR SEMICOLON {if (top() == 1){printf("%s\n", $2);}}
        |PRINT expr SEMICOLON {if (top() == 1){printf("%d\n", $2);}}
;
newline:
        PRINT NEWLINE SEMICOLON {if (top() == 1){printf("\n");}}
        ;
expr:
        expr ADD expr           {$$ = $1 + $3;}
        |expr SUB expr          {$$ = $1 - $3;}
        |expr MULT expr         {$$ = $1 * $3;}
        |expr DIV expr          {$$ = $1 / $3;}
        |expr LES expr          {$$ = ($1 < $3) ? 1 : 0;}
        |expr GRE expr          {$$ = ($1 > $3) ? 1 : 0;}
        |expr LEQ expr          {$$ = ($1 <= $3) ? 1 : 0;}
        |expr GEQ expr          {$$ = ($1 >= $3) ? 1 : 0;}
        |expr COMP expr         {$$ = ($1 == $3) ? 1 : 0;}
        |expr NEQ expr          {$$ = ($1 != $3) ? 1 : 0;}
        |LBR expr RBR           {$$ = $2;}
        |INT                    {$$=$1;}
        ;


end_stmt:    
        STOP SEMICOLON { printf("Ending process\n"); exit(0); }
         ;

%%

 void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}