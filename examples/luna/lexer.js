const moo = require("moo");
const tokens = require("./tokens");
const util = require('util');
const ins = obj => console.log(util.inspect(obj, { depth: null }));


// Static Method
function makeLexer(tokens) {
  let lexer; // = moo.compile(tokens);

// Wrap the lexer!!
//const mylexer = Object.create(lexer);
  let oldnext; // = lexer.next;

  lexer = moo.compile(tokens);
  oldnext = lexer.next;


  lexer.ignore = function(...types) {
    this.ignore = new Set(types);
  }
  
  lexer.next = function () {
      try {
          let token = oldnext.call(this);
          if (token && this.ignore.has(token.type)) {
              token = oldnext.call(this);
          }
          return token;
      } catch (e) {
          console.error("Eh!\n" + e)
      }
  
  };
  return lexer;
}

/*
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
*/

module.exports = {makeLexer, ins};
