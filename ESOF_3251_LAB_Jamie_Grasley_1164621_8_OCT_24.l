%{
  char str[100];
  int yyerror(char *errormsg);
  int yyparse();
%}
  
%%

("+")"\n"                {printf("operator: + \n");}
("-")"\n"                {{printf("operator: - \n");}}
("*")"\n"                {printf("operator: * \n");}
("/")"\n"                {printf("operator: / \n");}
("=")"\n"                {printf("operator: = \n");}
("<")"\n"                {printf("operator: < \n");}
(">")"\n"                {printf("operator: > \n");}
("<=")"\n"               {printf("operator: <= \n");}
(">=")"\n"               {printf("operator: >= \n");}
("==")"\n"               {printf("operator: == \n");}
("!=")"\n"               {printf("opßerator: != \n");}
("(")"\n"                {printf("parenthesis: ( \n");}
(")")"\n"                {printf("parenthesis: ) \n");}
(";")"\n"                {printf("semicolon: ; \n");}
("if")"\n"               {printf("keyword: if \n");}
("then")"\n"             {printf("keyword: then \n");}
("print")"\n"            {printf("keyword: print \n");}
("newline")"\n"          {printf("keyword: newline \n");}
 \/\/[^"\n"]*            {printf("\n");}
[0-9]+                   {printf("integer: %s\n",yytext);}
[a-zA-Z][a-zA-Z0-9]*     {printf("id: %s\n",yytext);}

\"[^\"]*\" {
strncpy(str, &(yytext[1]), strlen(yytext)-2);
str[strlen(yytext)-2] = (char) 0; {printf("quoted string: %s\n",str);}
}


.                     { yyerror("Unknow char");  }

%%

int main(void)
{
     yyparse();
     return 0;
}

int yywrap(void)
{
     return 0;
}

int yyerror(char *errormsg)
{
      fprintf(stderr, "%s\n", errormsg);
      exit(1);
}