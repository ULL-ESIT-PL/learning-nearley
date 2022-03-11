const nearley = require("nearley");
const grammar = require("./grammar.js");

let s = process.argv[2] || ` 4 `;

try {
  const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
  parser.feed(s);
  let ast = parser.results[0];
  console.log(JSON.stringify(ast, null, 2));
} catch (e) {
    console.log(e);
}