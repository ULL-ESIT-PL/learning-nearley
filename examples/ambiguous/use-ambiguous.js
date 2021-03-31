const moo = require('moo');
const nearley = require("nearley");
const grammar = require("./ambiguous.js");

// Create a Parser object from our grammar.

const tokens = require('./tokens.js');
const lexer = moo.compile(tokens);
const nearleyMoo = require('nearley-moo');

// Parse something!
const user = (process.argv.length > 2)? process.argv[2]: null;
const tests =  [
    "3\n - 2\n-\n1" ,
    "2-2"
];
if (user) tests.unshift(user);

const nm = nearleyMoo.parser(nearley, grammar);
try {
    for (let expression of tests) {      
        const parser = nm(lexer); // need to reset the parser form input to input
        parser.ignore(['ws', 'comment']);

        parser.feed(expression);
        // parser.results is an array of possible parsings.
        console.log(parser.results); 
    }   
} catch(e) {
    console.error(e.message);
}


