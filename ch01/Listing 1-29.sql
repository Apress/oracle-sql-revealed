select * 
   from t1 
 outer apply (select * 
                    from t2 
                   where t2.id = t1.id - 1 
                       or t2.id = t1.id + 1) v;