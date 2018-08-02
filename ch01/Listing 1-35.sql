select * 
   from t1, t2 
 where case when t1.id = 1 or t1.id = t2.id(+) then 1 end = 1;