select * 
   from t1, t2 
 where t1.id = t2.id(+) 
    and t2.id(+) between 1 and 3;