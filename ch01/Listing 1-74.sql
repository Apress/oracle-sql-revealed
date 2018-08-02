select * 
   from t1 
 cross join t2 
   left join t3 
     on t3.id = t2.id + 1 
    and t3.id = t1.id;