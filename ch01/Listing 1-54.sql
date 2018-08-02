select "FACT"."VALUE"               "VALUE",
       "FACT"."DIM_1_ID"            "DIM_1_ID",
       "FACT"."DIM_2_ID"            "DIM_2_ID",
       "FACT"."TYPE"                "TYPE",
       "VW_LAT_3C55142F"."ITEM_1_0" "VALUE",
       "VW_LAT_3C55142F"."ITEM_2_1" "CATEGORY"
  from "FACT" "FACT",
       "DIM_1" "DIM_1",
       "DIM_N" "DIM_N",
       lateral((select "MAP"."VALUE" "ITEM_1_0", "MAP"."CATEGORY" "ITEM_2_1"
                 from "MAP" "MAP"
                where ("FACT"."TYPE" = 'A' or "FACT"."TYPE" = 'B' or
                      "FACT"."TYPE" = 'C')
                  and ("MAP"."CATEGORY" = 'FACT VALUE' and
                      "MAP"."VALUE" = "FACT"."VALUE" or
                      "MAP"."CATEGORY" = 'DETAILED VALUE' and
                      "MAP"."VALUE" = "DIM_N"."VALUE")))(+) "VW_LAT_3C55142F"
 where "DIM_1"."DIM_N_ID" = "DIM_N"."ID"
   and "DIM_1"."ID" = "FACT"."DIM_1_ID";