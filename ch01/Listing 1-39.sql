select * 
   from t1 
   join t2 
     on t1.id = t2.id 
   left join t t3 
     on t1.id = t3.id 
    and t2.name = t3.name;