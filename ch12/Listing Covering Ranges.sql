create table t_range(a, b) as
(select 1, 15 from dual
union all select 3, 17 from dual
union all select 6, 19 from dual
union all select 10, 21 from dual
union all select 17, 26 from dual
union all select 18, 29 from dual
union all select 20, 32 from dual
union all select 24, 35 from dual
union all select 28, 45 from dual
union all select 30, 49 from dual);

select a, b
  from (select a,
               b,
               min(a) over(order by a range between b - a following and unbounded following) as next_a,
               min(a) over() start_a
          from t_range)
 start with a = start_a
connect by prior next_a = a;

select a, b
  from (select a, b, lag(a) over(order by a) as lag_a from t_range)
 start with lag_a is null
connect by a >= prior b
       and lag_a < prior b;

select *
 from t_range
match_recognize
(
  order by a
  all rows per match
  pattern((x|{-dummy-})+)
  define
    x as nvl(last(x.b, 1), 0) <= x.a
) mr;