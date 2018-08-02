select tc.id, x.column_value 
from tc, table(tc.nums) x -- 1 
--from tc, lateral(select * from table(tc.nums)) x -- 2 
--from tc cross apply (select * from table(tc.nums)) x -- 3 
--from tc cross join table(tc.nums) x -- 4 
;