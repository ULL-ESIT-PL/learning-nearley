@{% let count = 0; %}
s -> ("a" {% d => (console.log(`${count++}: ${JSON.stringify(d)}`), d) %}
     ):? 
     {% d => (console.log(d), d) %}
    