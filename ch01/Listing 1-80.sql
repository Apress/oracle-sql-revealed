select t3.id, count(t2.rowid) + count(t1.rowid) x 
   from t3 
   left join(t2 join t1 on t2.id = t1.id) on t3.id = t2.id 
 group by t3.rowid, t3.id 
 order by t3.id; 