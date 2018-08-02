select * 
   from t3, t1 
 where case when t3.sign = 1 then t3.id end = t1.id(+) 
 order by 1;

select * 
   from t3, t1 
 where decode(t3.sign, 1, t3.id) = t1.id(+) 
 order by 1;