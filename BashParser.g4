parser grammar BashParser;

options {tokenVocab=BashLexer;}

pipeline : pipeline PIPE cmd
| cmd;

cmd : (assign_list RLS_BLANK)? exec | assign_list RLS_BLANK?;

assign_list : assign_list RLS_BLANK assign
| assign;

assign: NAME EQ assign_rls;

assign_rls : (LITERAL | SQUOTE_STR | VAR | dquote_str | subst)*;

exec: prog arg_list? ARGS_BLANK?;

prog : (NAME | VAR | SQUOTE_STR | dquote_str | subst)+;

arg_list : arg_list ARGS_BLANK arg
| arg
;

arg: (NAME | SQUOTE_STR | VAR | dquote_str | subst)+;

dquote_str : DQUOTE (DQUOTE_CONTENT | VAR | subst)* DQUOTE;

subst : cst | lpst | rpst;

cst : DOLLAR_LPAREN pipeline? RPAREN
| BACKTICK pipeline? BACKTICK
;

lpst : LT_LPAREN pipeline? RPAREN;

rpst : GT_LPAREN pipeline? RPAREN;
