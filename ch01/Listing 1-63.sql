set pages 0
explain plan for
select /*+ no_query_transformation */ t1.* from t1 where t1.id in (select id from t0); 
select * from table(dbms_xplan.display(format => 'basic predicate'));

/*
-----------------------------------
| Id  | Operation          | Name |
-----------------------------------
|   0 | SELECT STATEMENT   |      |
|*  1 |  FILTER            |      |
|   2 |   TABLE ACCESS FULL| T1   |
|*  3 |   TABLE ACCESS FULL| T0   |
-----------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter( EXISTS (SELECT 0 FROM "T0" "T0" WHERE "ID"=:B1))
   3 - filter("ID"=:B1)
*/

set pages 14