select * 
   from t1, t2 
   left join t3 
     on t3.id = t2.id + 1 
 where t3.id(+) = t1.id;