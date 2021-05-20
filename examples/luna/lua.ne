@{%
const lexer = require("./lexer");
const util = require('util');
const ins = obj => console.error(util.inspect(obj, {depth: null}));

function makeWord(token) {
  const { text, line, offset, col } = token;
  return {type: 'word', name: text, line: line, col: col, offset: offset};
}

function makeApply(operator, args, comment) { 
	let node = { 
		comment: comment? comment: '',
		type: "apply", 
		operator: makeWord(operator), 
		args: args,
		line: operator.line,
		col: operator.col,
	};
	return node;
}
%}

@lexer lexer

S -> Function  {% id %}
Function -> FUN  LP NameList  RP StList END  
             {% 
			    ([fun, lp, namelist, rp, stlist]) => {
				   let doToken = { type:  "do", text: "do", line: fun.line, offset: fun.offset, col: fun.col};
				   return makeApply(fun, 
				                    namelist.concat([makeApply(doToken, stlist, "the body of the function")]),
									"the function")
				  } 
			 %}

NameList -> name  {% d => [makeWord(d[0])] %}
	| NameList COMMA  name 
	   {% 
	      ([list, _, name ]) => { 
			 list.push(makeWord(name)); 
			 return list
		   } 
	   %}

StList -> Statement                 {% ([st]) => st? [ st ] : [] %}
	| StList SEMICOLON Statement    {% ([list, _, st ]) => { if (st) list.push(st); return list } %}
 
Statement -> null     {% d => null %}
     | DO StList  END {%  ([dolua, stlist]) => makeApply(makeWord(dolua), stlist, "Lua 'do' to Egg 'do'") %}

# Lexical part

name  ->      %identifier {% id %}
COMMA ->       ","        {% id %}
LP    ->       "("        {% id %}
RP    ->       ")"        {% id %}
END   ->      %end        {% id %}
DO    ->      %dolua      {% id %}
FUN   ->      %fun        {% id %}
SEMICOLON ->  ";"         {% id %}
