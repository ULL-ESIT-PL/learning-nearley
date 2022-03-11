@{%
const lexer = require('./lex.js');
%}

@lexer lexer

expression -> 
       %STRING {% d => d[0] %}
    |  %NUMBER {% d => d[0] %}
    |  %WORD apply

apply ->   null       {% d => null %}
        |  parenExp   {% d => d[0] %}

parenExp -> "("  commaExp ")" {% d => d[1] %}

commaExp -> null       {% d => null %}
        | expression ("," expression {% d => d[1] %}):* {% d => [d[0]].concat(d[1]) %}