const moo = require('moo');
const nearley = require("nearley");
const grammar = require("./ambiguous.js");
const expression = (process.argv.length > 2)? process.argv[2] : "3 - 2 - /* a comment */ 1 ";
// Create a Parser object from our grammar.


const nm = require('nearley-moo').parser(nearley, grammar);


const tokens = require('./tokens.js');
const parser = nm(moo.compile(tokens)); //new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
parser.ignore(['ws', 'comment']);

// Parse something!
parser.feed(expression);

// parser.results is an array of possible parsings.
console.log(parser.results); 