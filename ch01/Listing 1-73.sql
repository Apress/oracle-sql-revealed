select "T1"."ID"        "ID", 
         "T1"."NAME" "NAME", 
         "T2"."ID"      "ID", 
         "T2"."NAME" "NAME", 
         "T3"."ID"      "ID" 
   from "T1" "T1", "T2" "T2", "T3" "T3" 
 where "T3"."ID"(+) = "T2"."ID" + 1;