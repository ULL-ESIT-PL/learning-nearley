@{%

const nm = require('nearley-moo')
const tokens = require('./tokens.js')
 
nm(tokens)

%}

main ->  e    {% function(d) { return d[0] ; } %}

e -> e %minus e  {% ([f,_,s]) => { return f-s; } %}
   | e %div e    {% ([f,_,s]) => { return f/s; } %}
   | %number     {% id %}

