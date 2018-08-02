select tc.id, x.column_value 
from tc, table(tc.nums)(+) x -- 1 
--from tc, lateral(select * from table(tc.nums))(+) x -- 2 
--from tc cross apply (select * from table(tc.nums))(+) x -- 3 
--from tc outer apply (select * from table(tc.nums)) x -- 4 
--from tc, table(tc.nums) x where nvl2(x.column_value(+), 0, 0) = nvl2(tc.id, 0, 0) -- 5 
--from tc left join table(tc.nums) x on nvl2(x.column_value, 0, 0) = nvl2(tc.id, 0, 0) -- 6 
;