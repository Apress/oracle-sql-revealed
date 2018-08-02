select * from t1 left join t2 on t2.id in (t1.id - 1, t1.id + 1); 

select * from t1, t2 where t2.id(+) in (t1.id - 1, t1.id + 1); 

select * 
   from t1, t2 
 where case when t2.id(+) in (t1.id - 1, t1.id + 1) then 1 end = 1;