# This is a nice little grammar to familiarize yourself
# with the nearley syntax.

# It parses valid calculator input, obeying OOO and stuff.
#   ln (3 + 2*(8/e - sin(pi/5)))
# is valid input.

# This is (hopefully) pretty self-evident.

# `main` is the nonterminal that nearley tries to parse, so
# we define it first.
# The _'s are defined as whitespace below. This is a mini-
# -idiom.

main => _ AS _ {% function(d) {return d[1]; } %}

# PEMDAS!
# We define each level of precedence as a nonterminal.

# Addition and subtraction
AS -> AS _ "+" _ MD {% function(d) {return d[0]+d[4]; } %}
    | AS _ "-" _ MD {% function(d) {return d[0]-d[4]; } %}
    | MD            {% id %}

# Multiplication and division
MD -> MD _ "*" _ E  {% function(d) {return d[0]*d[4]; } %}
    | MD _ "/" _ E  {% function(d) {return d[0]/d[4]; } %}
    | E             {% id %}

# Exponents
E -> F _ "^" _ E    {% function(d) {return Math.pow(d[0], d[4]); } %}
    | F             {% id %}

# Factorial 
F ->  P "!"          {% function(d) {
                          const fac = n => (n===0)?1:n*fac(n-1);
                          return fac(d[0]); 
                        } 
                     %}
    | P              {% id %} 


# Parentheses
P -> Q
    | _ float _       {% d => d[1] %}
    | _ "sin" _ Q     {% function(d) {return Math.sin(d.pop()); } %}
    | _ "cos" _ Q     {% function(d) {return Math.cos(d.pop()); } %}
    | _ "tan" _ Q     {% function(d) {return Math.tan(d.pop()); } %}
    
    | _ "asin" _ Q    {% function(d) {return Math.asin(d.pop()); } %}
    | _ "acos" _ Q    {% function(d) {return Math.acos(d.pop()); } %}
    | _ "atan" _ Q    {% function(d) {return Math.atan(d.pop()); } %}

    | _ "pi" _           {% function(d) {return Math.PI; } %}
    | _ "e"  _          {% function(d) {return Math.E; } %}
    | _ "sqrt" _ Q    {% function(d) {return Math.sqrt(d.pop()); } %}
    | _ "ln" _ Q      {% function(d) {return Math.log(d.pop()); }  %}

Q -> _ "(" _ AS _ ")" _ {% function(d) {return d[3]; } %}

# I use `float` to basically mean a number with a decimal point in it
float ->
      int "." int   {% function(d) {return parseFloat(d[0] + d[1] + d[2])} %}
	| int           {% function(d) {return parseInt(d[0])} %}

int -> [0-9]:+        {% function(d) {return d[0].join(""); } %}

# Whitespace. The important thing here is that the postprocessor
# is a null-returning function. This is a memory efficiency trick.
_ -> [\s]:*     {% function(d) {return null; } %}
