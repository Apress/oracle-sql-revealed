column x1 format a10
column x2 format a10

select t1.*,
       (select listagg(max(t2.name), ', ') within group(order by t2.name)
          from t2
         where t1.id = t2.id
         group by t2.name) x1,
       (select listagg(t2.name, ', ') within group(order by t2.name)
          from (select distinct name from t2 where t1.id = t2.id) t2) x2
  from t1;