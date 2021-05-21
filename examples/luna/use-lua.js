const nearley = require("nearley");
const grammar = require("./lua.js");
const { lexer, ins } = require('./lexer.js');

let s = `
fun (id, idtwo, idthree)  
  do  
    do end;
    do end
  end 
end`;
let ans;
try {
    const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
   // Parse something!
    parser.feed(s);
    ins(parser.results);
} catch (e) {
    console.log(e);
}

