with tc as 
(select -1 id, numbers(null) nums from dual 
union all select 0 id, numbers() nums from dual 
union all select 1 id, numbers(1) nums from dual 
union all select 2 id, numbers(1,2) nums from dual) 
select tc.id, x.column_value 
from tc cross join table(case when cardinality(tc.nums) = 0 then numbers(null) else tc.nums end) x;