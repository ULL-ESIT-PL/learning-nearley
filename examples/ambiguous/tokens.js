const ws = /\s+/; /* whitespace */
const comment = /\/\*.*?\*\//;
const number = /\d+/;
const minus = "-";
const plus = "+";
const mul = "*";
const div = "/";

const tokens = {
  ws: {match: ws, lineBreaks: true },
  comment,
  number: {match: number, value: s => parseInt(s)},
  minus,
  plus,
  mul,
  div
};

module.exports = tokens;