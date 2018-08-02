with t(id, value, dt, part) as 
( 
select 1, 10, date '2015-07-01', 1 from dual 
union all select 2, 3, date '2015-08-01', 1 from dual 
union all select 3, 2, date '2015-09-01', 1 from dual 
union all select 4, 0, date '2016-11-01', 1 from dual 
union all select 5, 5, date '2016-11-01', 1 from dual 
union all select 6, 9, date '2017-01-01', 1 from dual 
union all select 7, 4, date '2017-01-01', 1 from dual 
) 
select t.*,
       max(value) over(partition by part) m1,
       max(value) keep(dense_rank last order by dt) over(partition by part) m2,
       last_value(value) over(partition by part order by dt, value rows between unbounded preceding and unbounded following) m3,
       max(value) over(partition by part order by dt, value rows between unbounded preceding and unbounded following) m4
  from t
 order by id;