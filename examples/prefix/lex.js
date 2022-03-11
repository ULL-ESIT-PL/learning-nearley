const { makeLexer, moo } = require("moo-ignore");

const Tokens = {
  WHITES: { match: /\s+/, lineBreaks: true },
  NUMBER: { match: /[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?/, value: x => Number(x) },
  STRING: /"(?:[^"\\]|\\.)*"/,
  WORD  : /[^\s(),"]+/,
  "(": "(",
  ")": ")",
  ",": ","
};

let lexer = makeLexer(Tokens, ["WHITES"]);

module.exports = lexer;
