const nearley = require("nearley");
const grammar = require("./grammar.js");

let s = process.argv[2] || ` 4 * pi / e`;

try {
  const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
  parser.feed(s);
  console.log(parser.results[0]) 
} catch (e) {
    console.log(e);
}