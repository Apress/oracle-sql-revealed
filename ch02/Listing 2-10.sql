column name format a5

SELECT MAX("TR"."NAME") "NAME", COUNT(*) "CNT"
  FROM "T3", "TR"
 WHERE "TR"."ID" = "T3"."ID"
 GROUP BY "TR"."ID", "T3".ROWID;