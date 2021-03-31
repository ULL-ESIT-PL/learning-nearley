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
        parser.ignore(['ws', 'comment']);

        parser.feed(expression);
        
        console.log(parser.results); // parser.results is an array of possible parsings
    }   
} catch(e) {
    console.error(e.message);
}


