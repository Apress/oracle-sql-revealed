create table t_resemblance(id, value) as
(select 1, 1 from dual
union all select 2, 2 from dual
union all select 3, 2.5 from dual
union all select 4, 3.4 from dual
union all select 5, 0.4 from dual
union all select 6, 5 from dual
union all select 7, -0.5 from dual
union all select 8, -2 from dual
union all select 9, -1 from dual
union all select 10, 3 from dual
union all select 11, 4 from dual
union all select 12, 5 from dual);

select *
from t_resemblance
model
ignore nav
dimension by (row_number() over (order by id) id)
measures(value, 0 mi, 0 ma, 0 flag)
rules iterate (1e9) until value[iteration_number + 2] = 0
(
  flag[iteration_number + 1] =
  case when value[iteration_number + 1] between
            mi[iteration_number] - 1 and ma[iteration_number] + 1
            or iteration_number = 0
       then 1 end,
  mi[iteration_number + 1] =
    decode(flag[iteration_number + 1], 1, least(mi[iteration_number],
           value[iteration_number + 1]), mi[iteration_number]),
  ma[iteration_number + 1] =
    decode(flag[iteration_number + 1], 1, greatest(ma[iteration_number],
           value[iteration_number + 1]), ma[iteration_number])
);

select *
  from (select t.*, lag(value, 1, value) over(order by id) vv
          from (select id, value
                  from t_resemblance t
                union all select null, null from dual) t)
match_recognize
(
  order by id
  measures
    match_number() match,
    classifier() cls,
    min(x.value) mi,
    max(x.value) ma
  all rows per match
  pattern((x|dummy)+)
  define
      x as (next(x.vv) >= min(x.vv) - 1 and next(x.vv) <= max(x.vv) + 1)
    -- x as (next(x.vv) between min(x.vv) - 1 and max(x.vv) + 1)
) mr
where id is not null;