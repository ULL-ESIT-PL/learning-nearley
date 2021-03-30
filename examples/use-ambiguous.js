const nearley = require("nearley");
const grammar = require("./compiled-grammars/ambiguous.js");
const expression = (process.argv.length > 2)? process.argv[2] : "3-2-1";
// Create a Parser object from our grammar.
const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));

// Parse something!
parser.feed(expression);

// parser.results is an array of possible parsings.
console.log(parser.results); 