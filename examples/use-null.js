/* 
s -> "a":? 

npx nearleyc null.ne  -o null.js
npx nearley-test -i "a"  null.js  # [ [ [ 'a' ] ] ]
npx nearley-test -i ''  null.js   # [ [ null ] ]
node use-null.js
*/
const nearley = require("nearley");
const grammar = require("./null.js");

const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));

parser.feed(process.argv[2] || "");

//console.log(JSON.stringify(parser.results));