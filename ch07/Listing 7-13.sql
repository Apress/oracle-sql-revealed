cl col

select * 
from (select rownum id from dual connect by rownum <= 3) t 
model 
dimension by (id) 
measures (id value, 0 r1, 0 r2) 
( 
   -- 1) 
   -- ORA-30483: window  functions are not allowed here 
   -- r1[any] order by id = sum(id) over (order by id desc) 
   -- 2) 
   r1[any] /*order by id*/ = sum(id) over (order by id desc), 
   -- 3) ORA-00904: : invalid identifier 
   -- r2[any] order by id desc = sum(id)[id >= cv(id)] 
   -- 4) 
   r2[any] = sum(value)[id >= cv(id)] 
);