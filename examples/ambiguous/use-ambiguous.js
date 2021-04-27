#!/usr/bin/env node

const moo = require('moo');
const nearley = require("nearley");
const grammar = require("./ambiguous.js");

// Create a Parser object from our grammar.

const tokens = require('./tokens.js');
const lexer = moo.compile(tokens);
const nearleyMoo = require('nearley-moo');

// Parse something!
const tests = (process.argv.length > 2)? process.argv.slice(2): [
        "3\n - /* comment */ 2\n-\n1" ,
        "2-2/2"
    ];

const nm = nearleyMoo.parser(nearley, grammar);
try {
    for (let expression of tests) {      
        const parser = nm(lexer); // need to reset the parser from input to input
        parser.ignore(['ws', 'comment']); // Despite the name, the instantiation of Parser is intended to be cheap; you shouldn't worry about creating a fresh one each time. In particular, initialising the first column of the table is something that needs to be done afresh for each parse*.
                                          // See https://github.com/kach/nearley/issues/129
        parser.feed(expression);
        
        console.log(parser.results); // parser.results is an array of possible parsings
    }   
} catch(e) {
    console.error("Found an error: "+e.message);
}


