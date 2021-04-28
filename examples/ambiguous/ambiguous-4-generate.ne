
main ->  e    {% function(d) { return d[0] ; } %}

e -> e minus e  {% ([f,_,s]) => { return f-s; } %}
   | e div e    {% ([f,_,s]) => { return f/s; } %}
   | number     {% id %}

minus -> "-"
div -> "/"
number -> [0-9]:+