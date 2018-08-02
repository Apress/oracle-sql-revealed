select "from$_subquery$_003"."NAME_0" "NAME",
       "from$_subquery$_003"."QCSJ_C000000000300000_2" "DAY",
       count("from$_subquery$_003"."TIME_4") "CNT"
  from (select "P"."NAME" "NAME_0",
               "W"."ID"   "ID_1",
               "W"."DAY"  "QCSJ_C000000000300000_2",
               "P"."DAY"  "QCSJ_C000000000300001",
               "P"."TIME" "TIME_4"
          from "PRESENTATION" "P" partition by("P"."NAME")
         right outer join "WEEK" "W"
            on "W"."DAY" = "P"."DAY") "from$_subquery$_003"
 group by "from$_subquery$_003"."NAME_0",
          "from$_subquery$_003"."QCSJ_C000000000300000_2",
          "from$_subquery$_003"."ID_1"
 order by "from$_subquery$_003"."NAME_0", "from$_subquery$_003"."ID_1";