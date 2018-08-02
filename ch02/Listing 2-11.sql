select --+ no_query_transformation 
 name, cnt
  from t3
  join (select id, max(name) name, count(*) cnt from tr group by id) sub
    on sub.id = t3.id;

select "from$_subquery$_004"."NAME_0" "NAME",
       "from$_subquery$_004"."CNT_1"  "CNT"
  from (select "SUB"."NAME" "NAME_0", "SUB"."CNT" "CNT_1"
          from "T3",
               (select "TR"."ID" "ID",
                       max("TR"."NAME") "NAME",
                       count(*) "CNT"
                  from "TR"
                 group by "TR"."ID") "SUB"
         where "SUB"."ID" = "T3"."ID") "from$_subquery$_004";