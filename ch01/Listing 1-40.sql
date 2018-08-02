-- 11g 

select "from$_subquery$_003"."ID"   "ID",
       "from$_subquery$_003"."NAME" "NAME",
       "from$_subquery$_003"."ID"   "ID",
       "from$_subquery$_003"."NAME" "NAME",
       "T3"."ID"                    "ID",
       "T3"."NAME"                  "NAME",
       "T3"."DUMMY"                 "DUMMY"
  from (select "T1"."ID"   "ID",
               "T1"."NAME" "NAME",
               "T2"."ID"   "ID",
               "T2"."NAME" "NAME"
          from "T1" "T1", "T2" "T2"
         where "T1"."ID" = "T2"."ID") "from$_subquery$_003",
       "T" "T3"
 where "from$_subquery$_003"."NAME" = "T3"."NAME"(+)
   and "from$_subquery$_003"."ID" = "T3"."ID"(+);

-- 12c 

select "T1"."ID"    "ID",
       "T1"."NAME"  "NAME",
       "T2"."ID"    "ID",
       "T2"."NAME"  "NAME",
       "T3"."ID"    "ID",
       "T3"."NAME"  "NAME",
       "T3"."DUMMY" "DUMMY"
  from "T1" "T1", "T2" "T2", "T" "T3"
 where "T1"."ID" = "T3"."ID"(+)
   and "T2"."NAME" = "T3"."NAME"(+)
   and "T1"."ID" = "T2"."ID";