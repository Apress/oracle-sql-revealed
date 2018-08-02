-- to be executed in Impala
select * from t1 left anti join t2 on t1.id = t2.id; 

select * from t1 right anti join t2 on t1.id = t2.id;