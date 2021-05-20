@{%

const nm = require('nearley-moo')
const tokens = require('./tokens.js')
 
nm(tokens)

%}

main ->  e       {% id %}

e -> e %minus t  {% ([f,_,s]) => { return f-s; } %}
   | t           {% id %}
   | e %div e    {% ([f,_,s]) => { return f/s; } %}
   | %number     {% id %}

# (2 - 3) - 4
#    e
#  e     -      e
# e - e         4
# 2   3

# 8/3
