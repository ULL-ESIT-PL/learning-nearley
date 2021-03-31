@{%

const nm = require('nearley-moo')
const tokens = require('./tokens.js')
 
nm(tokens)

%}

main ->  e    {% function(d) { return d[0] ; } %}

e -> e %minus e  {% function(d) { return d[0]-d[2]; } %}
   | e %div e    {% function(d) { return d[0]/d[2]; } %}
   | %number     {% id %}

