set pages 0

explain plan for
select --+ qb_name(q) 
 * 
   from t1 
   join t2 
     on t1.id = t2.id; 
select * from table(dbms_xplan.display(format => 'basic alias'));

explain plan for
select --+ qb_name(q) 
 * 
   from t1, t2 
 where t1.id = t2.id;
select * from table(dbms_xplan.display(format => 'basic alias'));

/*
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------

   1 - SEL$695B99D2
   2 - SEL$695B99D2 / T1@SEL$1
   3 - SEL$695B99D2 / T2@SEL$1

Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------

   1 - Q
   2 - Q / T1@Q
   3 - Q / T2@Q
*/

set pages 14