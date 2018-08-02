select * 
   from t1, t2 
 where t1.id = t2.id(+) 
    and t2.id(+) in (1, 2, 3); 

select * 
   from t1, t2 
 where t1.id = t2.id(+) 
    and case when t2.id(+) in (1, 2, 3) then 1 end = 1;