exec dbms_random.seed(3);

create table t_num as
select id, num
  from dual
model
dimension by (1 id)
measures (1 num)
(
  num[for id from 2 to 19 increment 1] order by id =
  sum(num)[any] + trunc(dbms_random.value(1, 11))
);