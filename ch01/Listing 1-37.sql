select t3.id, v.id, v.name 
   from t3, 
         (select id, name from t1 where t1.id = (select count(*) 
         from dual)) v 
 where t3.id = v.id(+) 
 order by t3.id;
 
select t3.id, t1.id, t1.name 
  from (select t3.*, (select count(*) from dual) cnt from t3) t3, t1 
 where t3.id = t1.id(+) 
    and t3.cnt = t1.id(+) 
 order by t3.id; 

select t3.id, t1.id, t1.name 
   from t3, t1, (select count(*) cnt from dual) v 
 where t3.id = t1.id(+) 
    and v.cnt = t1.id(+) 
 order by t3.id; 