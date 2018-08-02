select * 
   from t1, t2 
 where t1.id = t2.id(+) 
     or t1.id = nvl2(t2.id(+), 1, 1);