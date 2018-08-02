with t(dim1, dim2, value) as 
( 
select 0, 0, 1 from dual 
union all select 0, 1, 2 from dual 
union all select 1, 0, 3 from dual 
) 
select * from t 
model 
dimension by (dim1, dim2)
measures (value, cast(null as number) result)
rules upsert all
(
  result[0, 0] = -1,
  result[dim1=1, dim2=0] = -3,
  result[-1, for dim2 in (select count(*) from dual)] = -4,
  result[-2, dim2=1] = -10,
  result[-3, dim2=-1] = -100,
  result[-4, -1] = -1000
)
order by dim1, dim2;