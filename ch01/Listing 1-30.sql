select * 
   from t1 
   left join t2 
     on t1.id = t2.id 
     or t1.id = 1;

select * from t1, t2 where t1.id = t2.id(+) or t1.id = 1;