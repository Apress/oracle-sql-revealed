create table t0(id, name) as select 0, 'X' from dual union all select 0, 'X' from dual; 

select t1.* from t1 where t1.id in (select id from t0); 

select t1.* from t1 where exists (select id from t0 where t1.id = t0.id);

select t1.* from t1 join t0 on t1.id = t0.id;