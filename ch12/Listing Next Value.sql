exec dbms_random.seed(1);

create table t_value as
select trunc(dbms_random.value(1, 10000 + 1)) value
  from dual
connect by level <= 1e6;

set timing on

select sum(nvl(next_value, 0) - value) s
  from (select value, max(next_value) over(partition by value) next_value
          from (select value,
                       decode(lead(value, 1) over(order by value),
                              value,
                              to_number(null),
                              lead(value, 1) over(order by value)) next_value
                  from t_value));
                  
select sum(nvl(next_value, 0) - value) s
  from (select value,
               min(value) over(order by value range between 1 following and 1 following) next_value
          from t_value);

select sum(nvl(next_value, 0) - value) s
from
(
  select value, next_value
  from t_value
  model
  dimension by (row_number () over (order by value desc) rn)
  measures(value, cast(null as number) next_value)
  rules
  (
    next_value[rn > 1] order by rn = decode(value[cv()], value[cv()-1], next_value[cv()-1], value[cv()-1])
  )
);

select sum(nvl(next_value, 0) - value) s
from (select * from t_value union all select null from dual)
match_recognize
(
  order by value nulls last
  measures
    final first (next_val.value) as next_value
  all rows per match
  after match skip to next_val
  pattern (val+ {-next_val-})
  define
    val as val.value = first(val.value)
) mr;

set timing off