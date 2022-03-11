const lex = require('./lex.js');

lex.reset(process.argv[2] || ' 2 + pi * e -sin(pi/4)');

let lookahead;
while (lookahead = lex.next()) {
  console.log(lookahead.type);
}
