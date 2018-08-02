select * from t1 join t2 on t1.id = t2.id(+);

select "T1"."ID"        "ID", 
         "T1"."NAME" "NAME", 
         "T2"."ID"      "ID", 
         "T2"."NAME" "NAME" 
   from "T1" "T1", "T2" "T2" 
 where "T1"."ID" = "T2"."ID"(+);