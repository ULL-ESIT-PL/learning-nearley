#!/usr/bin/env node
const nearley = require("nearley");
const grammar = require("./catching-errors.js");

const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));

try {
    parser.feed("Cow goes% moo.");
} catch (parseError) {
    console.log("Error at character " + parseError.offset); // "Error at character 9"
}