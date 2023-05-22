const nearley = require("nearley");
const grammar = require("./null.js");

// Create a Parser object from our grammar.
const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));

// Parse something!
parser.feed(process.argv[2] || "");

// parser.results is an array of possible parsings.
//console.log(JSON.stringify(parser.results));