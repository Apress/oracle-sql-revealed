select t1.*, t2.*, t3.* 
   from t1 
   full join (t2 join t3 on t2.id = t3.id) on t1.id = t2.id 
 order by t1.id;