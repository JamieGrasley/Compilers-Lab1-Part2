%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

// Declare external functions and variables provided by lex
extern int yylex();  
extern int yyparse(); 
extern void yyerror(const char *s);  // Error handling function

#define StackSize 10  // Define the size of the stack

// Initialize the stack and a counter to track the top of the stack
int s[StackSize] = {1,0,0,0,0,0,0,0,0,0}; 
int counter = 0;

// Function to push a value onto the stack
void push(int value){
    if(counter < StackSize){  // Check if the stack is not full
        counter++;
        s[counter] = value;  // Store value at the new top of the stack
    } else {
        printf("Stack is full\n");  // Print error if the stack is full
    }
}

// Function to pop a value off the stack
int pop(){
    if(counter >=0){  // Check if there is a value to pop
        return s[counter--];  // Return top value and decrement counter
    } else {
        printf("Stack Empty\n");  // Print error if the stack is empty
        return -1;
    }
}

// Function to get the top value from the stack without popping it
int top(){
    if(counter >=0){  // Ensure the stack is not empty
        return s[counter];  // Return top value
    } else {
        printf("Stack Empty\n");  // Print error if the stack is empty
        return -1;
    }
}

// Prototype for a function to print strings
void print_string(const char* str);  
%}

// Define the types of data that can be used in the parser
%union {
    int int_val;   // To store integer values
    char* strval;  // To store string literals
}

// Token declarations for different symbols and keywords in the language
%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE  // Comparison operators
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> STRING_LITERAL  // String literals use the 'strval' union field
%type <int_val> expr  // Expressions return integer values
%token <int_val> INTEGER  // Integer tokens use the 'int_val' field

// Operator precedence and associativity
%left PLUS MINUS   // '+' and '-' have left-to-right associativity
%left MULT DIV     // '*' and '/' also have left-to-right associativity
%nonassoc LESSER GREATER LE GE EQU NE  // Comparison operators are non-associative

%%

// Grammar rules for the language start here
program:
    stmt_list  // A program is a list of statements
    ;

stmt_list :
    statement stmt_list  // A list of statements can be a statement followed by more
    | /* empty */  // Or it can be empty (epsilon production)
    ;

statement:
    if_stmt  // A statement can be an if-statement
    | print_statement  // Or a print statement
    | bye_statement  // Or a "bye" statement to exit the program
    | expr  // Or just an expression
    ;

// Grammar rule for print statements
print_statement:
    PRINT STRING_LITERAL SEMICOLON {if(top() == 1) {printf("%s",$2);} }  // Print a string
    | PRINT expr SEMICOLON {if(top() == 1) {printf("%d", $2);} }  // Print an expression result
    | PRINT NEWLINE SEMICOLON {if(top() == 1) {printf("\n");} }  // Print a newline
    ;

// Grammar rule for if-statements
if_stmt:  
    IF expr THEN {top()==1 ? push($2!=0) : push(0);} stmt_list {pop();}  // If true, execute block
    ELSE {top()==1 ? push($2==0) : push(0);} stmt_list {pop();} ENDIF  // Else, execute else-block
    ;

// Grammar rules for expressions, defining arithmetic and comparison operations
expr: 
    expr PLUS expr       { $$ = $1 + $3; }  // Addition
    | expr MINUS expr    { $$ = $1 - $3; }  // Subtraction
    | expr MULT expr     { $$ = $1 * $3; }  // Multiplication
    | expr DIV expr      { $$ = $1 / $3; }  // Division
    | expr LESSER expr   { $$ = ($1 < $3) ? 1 : 0; }  // Less-than comparison
    | expr GREATER expr  { $$ = ($1 > $3) ? 1 : 0; }  // Greater-than comparison
    | expr LE expr       { $$ = ($1 <= $3) ? 1 : 0; }  // Less-than-or-equal comparison
    | expr GE expr       { $$ = ($1 >= $3) ? 1 : 0; }  // Greater-than-or-equal comparison
    | expr EQU expr      { $$ = ($1 == $3) ? 1 : 0; }  // Equality comparison
    | expr NE expr       { $$ = ($1 != $3) ? 1 : 0; }  // Not-equal comparison
    | LPEREN expr RPEREN { $$ = $2; }   // Parentheses for grouping expressions
    | INTEGER            { $$ = $1; }   // Integer base case for expressions
    ;

// Grammar rule for exiting the program
bye_statement:
    BYE SEMICOLON { printf("Bye World\n"); exit(0); }  // Exit the program with a goodbye message
    ;

%%

// Error handling function
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}