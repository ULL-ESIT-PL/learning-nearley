const moo = require("moo");
const util = require('util');
const ins = obj => console.log(util.inspect(obj, { depth: null }));

const lexer = moo.compile({
    ws: { match: /\s+|#[^\n]*/, lineBreaks: true },
    lte: "<=",
    lt: "<",
    gte: ">=",
    gt: ">",
    eq: "==",
    lparan: "(",
    rparan: ")",
    comma: ",",
    lbracket: "[",
    rbracket: "]",
    lbrace: "{",
    rbrace: "}",
    assignment: "=",
    plus: "+",
    minus: "-",
    multiply: "*",
    divide: "/",
    modulo: "%",
    colon: ":",
    semicolon: ";",
    string_literal: {
        match: /"(?:[^\n\\"]|\\["\\ntbfr])*"/,
        value: s => JSON.parse(s)
    },
    number_literal: {
        match: /[0-9]+(?:\.[0-9]+)?/,
        value: s => Number(s)
    },
    identifier: {
        match: /[a-z_][a-z_0-9]*/,
        type: moo.keywords({
            fun: "fun",
            proc: "proc",
            while: "while",
            for: "for",
            else: "else",
            in: "in",
            if: "if",
            return: "return",
            and: "and",
            or: "or",
            true: "true",
            false: "false",
            end: "end",
            dolua: "do"
        })
    }
});

// Wrap the lexer!!
const mylexer = Object.create(lexer);
const oldnext = lexer.next;

mylexer.next = function () {
    try {
        let token = oldnext.call(this);
        if (token && (token.type === 'ws')) {
            token = oldnext.call(this);
        }
        return token;
    } catch (e) {
        console.error("Eh!\n" + e)
    }

}

module.exports = mylexer;
