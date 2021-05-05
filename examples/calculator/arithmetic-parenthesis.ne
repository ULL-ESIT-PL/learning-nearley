# How to Implement Lexical Analysis in Tools Whithout a separated Lexer

# This is a nice little grammar to familiarize yourself
# with the nearley syntax.

# It parses valid calculator input, obeying OOO and stuff.
#   ln (3 + 2*(8/e - sin(pi/5)))
# is valid input.

@{%
const bin = (([x, op, y]) => op(x,y));
const Null = (d => null);
const fac = n => (n===0)?1:n*fac(n-1);
const unaryPost = (([p, op]) => op(p));
const funApply = ([fun, arg]) => fun(arg);
%}

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
    | COS Q     {% (d) => {return Math.cos(d.pop()); } %}
    | TAN Q     {% (d) => {return Math.tan(d.pop()); } %}
    | ASIN Q    {% (d) => {return Math.asin(d.pop()); } %}
    | ACOS Q    {% (d) => {return Math.acos(d.pop()); } %}
    | ATAN Q    {% (d) => {return Math.atan(d.pop()); } %}
    | PI        {% (d) => {return Math.PI; } %}
    | EULER     {% (d) => {return Math.E; } %}
    | SQRT Q    {% (d) => {return Math.sqrt(d.pop()); } %}
    | LN Q      {% (d) => {return Math.log(d.pop()); }  %}

# Parentheses
Q ->  LP AS RP  {% ([lp, as, rp]) => as %}

##### LEXICAL ANALYSIS #################################################

# I use `float` to basically mean a number with a decimal point in it
FLOAT -> _ float _  {% d => d[1] %} 
float ->
      int "." int   {% function(d) {return parseFloat(d[0] + d[1] + d[2])} %}
	| int           {% function(d) {return parseInt(d[0])} %}

int -> [0-9]:+     {% function(d) {return d[0].join(""); } %}

# Whitespace. The important thing here is that the postprocessor
# is a null-returning function. This is a memory efficiency trick.
_ -> [\s]:*        {% function(d) {return null; } %}

PLUS -> _ "+" _    {% function(d) {return ((a,b) => a+b); } %}
MINUS -> _ "-" _   {% function(d) {return ((a,b) => a-b); } %}
MULT -> _ "*" _    {% function(d) {return ((a,b) => a*b); } %}
DIV -> _ "/" _     {% function(d) {return ((a,b) => a/b); } %}
EXP -> _ "^" _     {% function(d) {return ((a,b) => Math.pow(a,b)); } %}
FACTORIAL -> "!"   {% d => fac %}
LP -> _ "(" _       {% Null %}
RP -> _ ")" _       {% Null %}
SIN -> _ "sin"i _   {% d => Math.sin %}
COS -> _ "cos"i _   {% Null %}
TAN -> _ "tan"i _   {% Null %}
ASIN -> _ "asin"i _ {% Null %}
ACOS -> _ "acos"i _ {% Null %}
ATAN -> _ "atan"i _ {% Null %}
PI -> _ "pi"i _     {% Null %}
EULER -> _ "e"i  _  {% Null %}
SQRT -> _ "sqrt"i _ {% Null %}
LN -> _ "ln"i _     {% Null %}
