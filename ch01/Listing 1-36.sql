select * 
   from t3 
   left join t1 
      on t1.id = t3.id 
    and t1.id = (select count(*) from dual) 
 order by t3.id; 

select * 
   from t3, t1 
 where t1.id(+) = t3.id 
    and t1.id(+) = (select count(*) from dual) 
 order by t3.id;