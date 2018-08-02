select * 
   from t3 
   left join t1 
     on t3.id = t1.id 
    and t3.sign = 1 
 order by 1;