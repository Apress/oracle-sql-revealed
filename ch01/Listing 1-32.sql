select * 
   from t1 
   left join t2 
     on t1.id = t2.id 
     or t1.id = 1;