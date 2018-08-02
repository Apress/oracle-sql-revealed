select t3.id, 
         (select count(t2.rowid) + count(t1.rowid) 
             from t2 
             join t1 
               on t2.id = t1.id 
           where t2.id = t3.id) x 
   from t3 
 order by t3.id;