/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IF = 258,
     THEN = 259,
     ELSE = 260,
     ENDIF = 261,
     PRINT = 262,
     NEWLINE = 263,
     SEMICOLON = 264,
     STOP = 265,
     ADD = 266,
     SUB = 267,
     MULT = 268,
     DIV = 269,
     LES = 270,
     GRE = 271,
     LEQ = 272,
     GEQ = 273,
     COMP = 274,
     NEQ = 275,
     LBR = 276,
     RBR = 277,
     STR = 278,
     INT = 279
   };
#endif
/* Tokens.  */
#define IF 258
#define THEN 259
#define ELSE 260
#define ENDIF 261
#define PRINT 262
#define NEWLINE 263
#define SEMICOLON 264
#define STOP 265
#define ADD 266
#define SUB 267
#define MULT 268
#define DIV 269
#define LES 270
#define GRE 271
#define LEQ 272
#define GEQ 273
#define COMP 274
#define NEQ 275
#define LBR 276
#define RBR 277
#define STR 278
#define INT 279




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 51 "ESOF_3251_LAB_Jamie_Grasley_1164621_8_OCT_24.y"
{
    int intval; //Store int values
    char* strval; //Store string values
}
/* Line 1529 of yacc.c.  */
#line 102 "ESOF_3251_LAB_Jamie_Grasley_1164621_8_OCT_24.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

