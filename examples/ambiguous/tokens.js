const ws = /\s+/; /* whitespace */
const comment = /\/\*.*?\*\//;
const number = /\d+/;
const minus = "-";
const div = "/";

const tokens = {
  ws: {match: ws, lineBreaks: true },
  comment,
  number: {match: number, value: s => parseInt(s)},
  minus,
  div
};

module.exports = tokens;