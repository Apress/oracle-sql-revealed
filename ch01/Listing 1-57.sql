select "FACT"."VALUE"    "VALUE",
       "FACT"."DIM_1_ID" "DIM_1_ID",
       "FACT"."DIM_2_ID" "DIM_2_ID",
       "FACT"."TYPE"     "TYPE",
       "MAP"."VALUE"     "VALUE",
       "MAP"."CATEGORY"  "CATEGORY"
  from "FACT" "FACT", "DIM_1" "DIM_1", "DIM_N" "DIM_N", "MAP" "MAP"
 where case when decode("MAP".ROWID(+), "MAP".ROWID(+), "FACT"."TYPE") in ('A', 'B', 'C') then 1 end = 1
   and "MAP"."VALUE"(+) = decode("MAP"."CATEGORY"(+), 'FACT VALUE', "FACT"."VALUE", 'DETAILED VALUE', "DIM_N"."VALUE")
   and "DIM_1"."DIM_N_ID" = "DIM_N"."ID"
   and "DIM_1"."ID" = "FACT"."DIM_1_ID";