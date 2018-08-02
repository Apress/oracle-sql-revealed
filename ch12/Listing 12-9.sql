create table flow(ord, value) as
select 1, 10 from dual
union all select 2, 333 from dual
union all select 3, 100 from dual
union all select 4, 55 from dual
union all select 5, 1000 from dual;

select t1.*, percentile_cont(0.3) within group(order by t2.value) pct
  from flow t1
  join flow t2
    on t2.ord between t1.ord and t1.ord + 4
 group by t1.ord, t1.value;
