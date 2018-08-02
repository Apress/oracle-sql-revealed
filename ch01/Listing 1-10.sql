create table t(id, name, dummy) as select 1, 'A', 'dummy' from dual; 

select * from t1 natural left join t;