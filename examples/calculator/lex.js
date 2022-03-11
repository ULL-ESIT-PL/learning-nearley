const { makeLexer, moo } = require("moo-ignore");

const Tokens = {
  space: { match: /\s+/, lineBreaks: true },
  number: { match: /\d+(?:.\d+)?\b/, value: (x) => Number(x) },
  "+": "+",
  "-": "-",
  "*": "*",
  "/": "/",
  "^": "^",
  "(": "(",
  ")": ")",
  id: {
    match: /[a-z_][a-z_0-9]*/,
    type: moo.keywords({
      sin: "sin",
      cos: "cos",
      tan: "tan",
      asin: "asin",
      acos: "acos",
      atan: "atan",
      pi: "pi",
      e: "e",
      sqrty: "sqrt",
      ln: "ln"
    }),
  },
};

let lexer = makeLexer(Tokens, ["space"]);

module.exports = lexer;
