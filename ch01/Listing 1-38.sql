select * 
   from t1, t2, t t3 
 where t1.id = t2.id 
    and t1.id = t3.id(+) 
    and t2.name = t3.name(+);