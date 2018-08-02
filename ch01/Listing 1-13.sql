set pages 0
select t1.* from t1 where t1.id not in (select id from t0); 
select * from table(dbms_xplan.display_cursor(format => 'basic')); 
select t1.* from t1 where not exists (select id from t0 where t1.id = t0.id); 
select * from table(dbms_xplan.display_cursor(format => 'basic'));
set pages 14