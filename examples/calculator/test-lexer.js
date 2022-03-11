const lex = require('./lex.js');

lex.reset(process.argv[2] || ' 2 + pi * e -sin(pi/4)');

/*
console.log(lex.has('number'));
console.log(lex.has('chuchu'));
console.log(lex.has('?'));

console.log(lex.save());
console.log(lex.formatError(lex.next()));
*/

let lookahead;
while (lookahead = lex.next()) {
  console.log(lookahead);
}
