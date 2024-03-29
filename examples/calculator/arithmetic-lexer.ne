# How to Implement Lexical Analysis in Tools with a separated Lexer
# To use it run: 
# nearleyc arithmetic-lexer.ne -o grammar.js  && node use-arithmetic.js 'ln (3 + 2*(8/e - sin(pi/5)))'
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

main => null {% d => "" %} # Allow for empty lines
    | AS {% function(d) {return d[0]; } %}


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


##### LEXICAL ANALYSIS #################################################

FLOAT -> %number  
PLUS -> "+"      {% function(d) {return ((a,b) => a+b); } %}
MINUS -> "-"     {% function(d) {return ((a,b) => a-b); } %}
MULT -> "*"      {% function(d) {return ((a,b) => a*b); } %}
DIV -> "/"       {% function(d) {return ((a,b) => a/b); } %}
EXP -> "^"       {% function(d) {return ((a,b) => Math.pow(a,b)); } %}
FACTORIAL -> "!"   {% d => fac %}
LP -> "("         {% Null %}
RP -> ")"         {% Null %}
SIN -> "sin"      {% d => Math.sin %}
COS -> "cos"      {% d => Math.cos %}
TAN -> "tan"      {% d => Math.tan %}
ASIN -> "asin"    {% d => Math.asin %}
ACOS -> "acos"    {% d => Math.acos %}
ATAN -> "atan"    {% d => Math.atan %}
PI -> %pi         {% d => Math.PI %}
EULER -> %e       {% d => Math.E  %}
SQRT -> %sqrt     {% d => Math.sqrt %}
LN -> %ln         {% d => Math.log %}
