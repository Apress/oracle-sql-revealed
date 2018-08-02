select t1.*, t2.*, t3.* 
   from t1 
   full join t2 
     on t1.id = t2.id 
   join t3 
     on t2.id = t3.id 
 order by t1.id; 

select t1.*, t2.*, t3.* 
   from t2 
   join t3 
     on t2.id = t3.id 
   full join t1 
     on t1.id = t2.id 
 order by t1.id;