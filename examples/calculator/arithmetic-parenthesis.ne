# Adive. How to Implement Lexical Analysis in Tools Whithout a separated Lexer

# This is a nice little grammar to familiarize yourself
# with the nearley syntax.

# It parses valid calculator input, obeying OOO and stuff.
#   ln (3 + 2*(8/e - sin(pi/5)))
# is valid input.

@{%
const bin = (([x, op, y]) => op(x,y));
%}

main => null {% d => "" %} # Allow for empty lines
    | AS {% function(d) {return d[0]; } %}

# PEMDAS!
# We define each level of precedence as a nonterminal.

# Addition and subtraction
AS -> AS PLUS MD  {% bin %}  # Prefer this syntax
    | AS MINUS MD {% function([as, _, md]) {return as-md; } %}
    | MD          {% id %}

# Multiplication and division
MD -> MD MULT E  {% function(d) {return d[0]*d[2]; } %}
    | MD DIV E   {% function(d) {return d[0]/d[2]; } %}
    | E          {% id %}

# Exponents
E -> F EXP E    {% function(d) {return Math.pow(d[0], d[2]); } %}
    | F             {% id %}

# Factorial 
F ->  P "!"          {% function(d) {
                          const fac = n => (n===0)?1:n*fac(n-1);
                          return fac(d[0]); 
                        } 
                     %}
    | P              {% id %} 

# Fixed "bug" sinpi

P -> Q
    | FLOAT     {% d => d[0] %}
    | SIN  Q    {% function(d) {return Math.sin(d.pop()); } %}
    | COS Q     {% function(d) {return Math.cos(d.pop()); } %}
    | TAN Q     {% function(d) {return Math.tan(d.pop()); } %}
    
    | ASIN Q    {% function(d) {return Math.asin(d.pop()); } %}
    | ACOS Q    {% function(d) {return Math.acos(d.pop()); } %}
    | ATAN Q    {% function(d) {return Math.atan(d.pop()); } %}
    | PI        {% function(d) {return Math.PI; } %}
    | EULER     {% function(d) {return Math.E; } %}
    | SQRT Q    {% function(d) {return Math.sqrt(d.pop()); } %}
    | LN Q      {% function(d) {return Math.log(d.pop()); }  %}

# Parentheses
Q ->  LP AS RP  {% function(d) {return d[1]; } %}

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
MULT -> _ "*" _    {% function(d) {return null; } %}
DIV -> _ "/" _     {% function(d) {return null; } %}
EXP -> _ "^" _     {% function(d) {return null; } %}
LP -> _ "(" _      {% function(d) {return null; } %}
RP -> _ ")" _      {% function(d) {return null; } %}
SIN -> _ "sin" _   {% function(d) {return null; } %}
COS -> _ "cos" _   {% function(d) {return null; } %}
TAN -> _ "tan" _   {% function(d) {return null; } %}
ASIN -> _ "asin" _ {% function(d) {return null; } %}
ACOS -> _ "acos" _ {% function(d) {return null; } %}
ATAN -> _ "atan" _ {% function(d) {return null; } %}
PI -> _ "pi" _     {% function(d) {return null; } %}
EULER -> _ "e"  _  {% function(d) {return null; } %}
SQRT -> _ "sqrt" _ {% function(d) {return null; } %}
LN -> _ "ln" _     {% function(d) {return null; } %}
