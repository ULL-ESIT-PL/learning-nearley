e -> number "-" e    {% ([f, _, s]) => { return f-s } %}
   | number          {% id %}

number -> [0-9]:+ {% d => Number(d.join("")) %}

