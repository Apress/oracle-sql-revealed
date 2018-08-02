with t(id, value) as 
( 
select 1, 3 from dual 
union all select 2, 9 from dual 
union all select 3, 8 from dual 
union all select 5, 5 from dual 
union all select 10, 4 from dual 
) 
select * from t 
model 
-- return updated rows 
dimension by (id) 
measures (value, 0 result) 
-- rules 
( 
   result[id >= 5] = sum(value)[id <= cv(id)], 
   result[0] = value[10] + value[value[1]] 
);