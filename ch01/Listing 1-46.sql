with tc as 
(select -1 id, numbers(null) nums from dual 
union all select 0 id, numbers() nums from dual 
union all select 1 id, numbers(1) nums from dual 
union all select 2 id, numbers(1,2) nums from dual) 
select tc.id, x.column_value 
from tc left join table(tc.nums) x on nvl2(x.column_value, 0, 0) = nvl2(tc.id, 0, 0); 