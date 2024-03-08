@{% 
/* 
s -> "a":? 

npx nearleyc null.ne  -o null.js
npx nearley-test -i "a"  null.js  # [ [ [ 'a' ] ] ]
npx nearley-test -i ''  null.js   # [ [ null ] ]
node use-null.js
*/
let count = 0; 
%}
s -> ("a" {% d => (console.log(`${count++}: ${JSON.stringify(d)}`), d) %}):? 
     {% d => (console.log(d), d) %}
    