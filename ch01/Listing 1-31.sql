select * 
   from t1, t2 
 where t1.id = t2.id(+) and t1.id = 1; 

select * 
   from t1, t2 
 where t1.id = t2.id(+) and t1.id = nvl2(t2.id(+), 1, 1); 

select * 
   from t1, t2 
 where case when t1.id = t2.id(+) and t1.id = 1 then 1 end = 1;