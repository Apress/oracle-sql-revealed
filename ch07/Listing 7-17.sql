column result format 999999999999

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