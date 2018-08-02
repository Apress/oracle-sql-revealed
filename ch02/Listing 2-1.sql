select t1.* from t1 left join t2 on t1.id = t2.id where t2.id is null; 

select t1.* from t1 where not exists (select t2.id from t2 where t1.id = t2.id); 

select t1.* from t1, t2 where t1.id = t2.id(+) and t2.id is null; 

select t1.* from t1 where t1.id not in (select t2.id from t2);