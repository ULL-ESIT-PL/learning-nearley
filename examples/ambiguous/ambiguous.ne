@{%
const { makeLexer } = require("moo-ignore");
const tokens = require('./tokens.js')
 
let lexer = makeLexer(tokens);
lexer.ignore("ws", "comment");
%}

@lexer lexer

main ->  e       {% id %}

e -> e %plus e   {% ([f,_,s]) => { return f+s; } %}
   | e %minus e  {% ([f,_,s]) => { return f-s; } %}
   | e %mul e    {% ([f,_,s]) => { return f*s; } %}
   | e %div e    {% ([f,_,s]) => { return f/s; } %}
   | %number     {% id %}

