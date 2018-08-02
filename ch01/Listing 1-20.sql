select * 
   from t3, t1 
 where 0 = 0 
    and t1.id(+) > 1
 order by t3.id; 

select * 
   from t3, t1 
 where nvl2(t3.id, 0, 0) = nvl2(t1.id(+), 0, 0) 
    and t1.id(+) > 1 
 order by t3.id;