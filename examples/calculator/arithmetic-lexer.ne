# How to Implement Lexical Analysis in Tools Whithout a separated Lexer
# To use it run: 
# nearleyc arithmetic-parenthesis.ne -o grammar.js && export NODE_PATH=$NODE_PATH:`npm root -g` && node calculator.js
# This is a nice little grammar to familiarize yourself with the nearley syntax.

# It parses valid calculator input
#   ln (3 + 2*(8/e - sin(pi/5)))
# is valid input.

@{%

const lexer = require('./lex.js');

const bin = (([x, op, y]) => op(x,y));
const Null = (d => null);
const fac = n => (n===0)?1:n*fac(n-1);
const unaryPost = (([p, op]) => op(p));
const funApply = ([fun, arg]) => fun(arg);
%}

@lexer lexer

/*
main => null {% d => "" %} # Allow for empty lines
    | AS {% function(d) {return d[0]; } %}

# PEMDAS!
# We define each level of precedence as a nonterminal.

# Addition and subtraction
AS -> AS PLUS MD  {% bin %}  # Prefer this syntax
    | AS MINUS MD {% bin %}
    | MD          {% id %}

# Multiplication and division
MD -> MD MULT E  {% bin %}
    | MD DIV E   {% bin %}
    | E          {% id %}

# Exponents
E -> F EXP E    {% bin %}
    | F         {% id %}

# Factorial 
F ->  P FACTORIAL    {% unaryPost %}
    | P              {% id %} 

# Fixed "bug" sinpi

P -> Q
    | FLOAT     {% id %}
    | SIN  Q    {% funApply %}
    | COS Q     {% funApply %}
    | TAN Q     {% funApply %}
    | ASIN Q    {% funApply %}
    | ACOS Q    {% funApply %}
    | ATAN Q    {% funApply %}
    | PI        {% id %}
    | EULER     {% id %}
    | SQRT Q    {% funApply %}
    | LN Q      {% funApply %}

# Parentheses
Q ->  LP AS RP  {% ([lp, as, rp]) => as %}

*/

##### LEXICAL ANALYSIS #################################################

FLOAT -> %number   {% id %} 

PLUS -> "+"      {% function(d) {return ((a,b) => a+b); } %}
MINUS -> "-"     {% function(d) {return ((a,b) => a-b); } %}
MULT -> "*"      {% function(d) {return ((a,b) => a*b); } %}
DIV -> "/"       {% function(d) {return ((a,b) => a/b); } %}
EXP -> "^"       {% function(d) {return ((a,b) => Math.pow(a,b)); } %}
FACTORIAL -> "!"   {% d => fac %}
LP -> "("         {% Null %}
RP -> ")"         {% Null %}
SIN -> "sin"i      {% d => Math.sin %}
COS -> "cos"i      {% d => Math.cos %}
TAN -> "tan"i      {% d => Math.tan %}
ASIN -> "asin"i    {% d => Math.asin %}
ACOS -> "acos"i    {% d => Math.acos %}
ATAN -> "atan"i    {% d => Math.atan %}
PI -> "pi"i        {% d => Math.PI %}
EULER -> "e"i      {% d => Math.E  %}
SQRT -> "sqrt"i    {% d => Math.sqrt %}
LN -> "ln"i        {% d => Math.log %}
