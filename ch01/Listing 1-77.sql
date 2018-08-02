select --+ qb_name(q) 
 * 
   from t1 
   join t2 
     on t1.id = t2.id; 

select --+ qb_name(q) 
 * 
   from t1, t2 
 where t1.id = t2.id;