set pages 0

explain plan for
select * 
from 
(select * 
  from (select rownum id from dual connect by rownum <= 1e6) t 
model 
dimension by (id) 
measures (id value, 0 result) 
( 
   -- analytic version 
   result[any] = sum(value) over (order by id desc) 
   -- aggregate version 
   -- result[any] = sum(value)[id >= cv(id)] 
) 
order by id 
) 
where rownum <= 3;

select * from table(dbms_xplan.display(format => 'basic'));