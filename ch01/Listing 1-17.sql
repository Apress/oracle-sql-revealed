select * 
   from t1, t2 
 where t1.id = t2.id(+) 
union all 
select * 
   from t1, t2 
 where t1.id(+) = t2.id 
    and t1.id is null;