# Match a loud moo
cow -> "MO" "O":+ 
  {% (d, loc) => {
        console.log(loc); 
        return d;
        } 
   %}
