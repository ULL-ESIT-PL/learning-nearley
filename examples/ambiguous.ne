@builtin "whitespace.ne"

main -> _ e _  {% function(d) {return d[1]; } %}

e -> e _ "-" _ e  {% function(d) {return d[0]-d[4]; } %}
   | e _ "/" _ e  {% function(d) {return d[0]/d[4]; } %}
   | int          {% function(d) {return parseInt(d[0]); } %}

int -> [0-9]:+    {% function(d) {return d[0].join(""); } %}