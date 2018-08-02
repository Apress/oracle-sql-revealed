with t(id, value) as 
(select rownum, rownum from dual connect by level <= 3) 
select * 
from t 
model 
dimension by (id) 
measures (value, 100 r1, 100 r2) 
( 
   r1[any] order by id asc  = nvl(r1[cv(id)-1], 0) + value[cv(id)], 
   r2[id is any] order by id desc = nvl(r2[cv(id)-1], 0) + 
   value[cv(id)] 
)
order by id;