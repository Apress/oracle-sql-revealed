exec dbms_random.seed(1);

create table t_sign as
select rownum id,
       case when trunc(dbms_random.value(1, 10 + 1)) > 3
            then 1
            else 0
       end sign
  from dual
connect by rownum <= 1e6;

alter session set workarea_size_policy = manual;
alter session set sort_area_size = 2147483647;

set timing on

select count(*) cnt
  from (select t.*, sum(sign) over(partition by g order by id) s
          from (select id, sign, sum(x) over(order by id) g
                  from (select t0.*,
                               decode(nvl(lag(sign) over(order by id), -1),
                                      sign,
                                      0,
                                      1) x
                          from t_sign t0)
                 where sign <> 0) t)
 where s >= 10;

select count(*)
  from (select id,
               sum(sign) over(order by id rows between 9 preceding and current row) s
          from t_sign)
 where s = 10;
 
select count(*) cnt from
(
  select *
  from t_sign
  model
  ignore nav
  dimension by (id)
  measures (sign, 0 s)
  rules
  (
     s[any] order by id = decode(sign[cv()], 0, 0, s[cv()-1] + sign[cv()])
  )
);

select count(*)
from t_sign
match_recognize
(
  order by id
  one row per match
  after match skip to first one
  pattern (strt one{9})
  define
     strt as strt.sign = 1,
     one as one.sign = 1
) mr;

set timing off