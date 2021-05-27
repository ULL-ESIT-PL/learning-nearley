#!/usr/bin/env node

const nearley = require("nearley");
const grammar = require("./ambiguous.js");

const tests = (process.argv.length > 2)? process.argv.slice(2): [
        "3\n - /* comment */ 2\n-\n1" ,
        "2-2/2"
    ];

try {
    for (let expression of tests) { 
        const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
        parser.feed(expression);
        
        console.log(parser.results); // parser.results is an array of possible parsings
    }   
} catch(e) {
    console.error("Found an error: "+e.message);
}


