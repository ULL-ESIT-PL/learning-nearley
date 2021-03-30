# Match a loud moo
cow -> _ "M" oos _
  {% (d, loc) => {
        console.log(`inside cow ${loc}`); 
        return d;
        } 
   %}

oos -> _ [oO]:+ 
  {%
    (d, loc) => {
        console.log(`inside oos ${loc}`);
        return d;
    }
  %}

_ -> [\s]:*
  {% 
    (d) => {
        return null;
    }
  %}