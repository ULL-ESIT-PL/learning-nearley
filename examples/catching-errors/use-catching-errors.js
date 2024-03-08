#!/usr/bin/env node
const nearley = require("nearley");
const grammar = require("./catching-errors.js");

const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));

try {
    parser.feed(process.argv[2] || "Cow goes% moo.");
} catch (parseError) {
    console.log("Error at character '" +parseError.token.value+"' at offset "+ parseError.offset); // "Error at character '%' at offset 8"
}