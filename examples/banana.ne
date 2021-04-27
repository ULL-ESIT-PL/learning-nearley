banana -> "ba" 
         ("na" {% (d)=> { console.log("expected na: ",d); return 1; } %} 
          | 
          "NA" {% (d)=> { console.log("Expected NA: ",d); return 2; } %}
          ):+ 
          {% (d) => { console.log(d); return 3; } %}