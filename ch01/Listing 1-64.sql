set pages 0
explain plan for
select /*+ rule */ t1.* from t1 where t1.id in (select id from t0);
select * from table(dbms_xplan.display(format => 'basic predicate'));

/*
------------------------------------------
| Id  | Operation             | Name     |
------------------------------------------
|   0 | SELECT STATEMENT      |          |
|   1 |  MERGE JOIN           |          |
|   2 |   SORT JOIN           |          |
|   3 |    TABLE ACCESS FULL  | T1       |
|*  4 |   SORT JOIN           |          |
|   5 |    VIEW               | VW_NSO_1 |
|   6 |     SORT UNIQUE       |          |
|   7 |      TABLE ACCESS FULL| T0       |
------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."ID"="ID")
       filter("T1"."ID"="ID")
*/

set pages 14