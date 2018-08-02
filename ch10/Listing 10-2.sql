set pages 100
column str format a40

with t0 as
 (select '000000000010000000000000010000' str from dual),
t1 as
 (select 1 part, rownum rn, substr(str, rownum, 1) x
    from t0
  connect by substr(str, rownum, 1) is not null),
t2(part, rn, x) as
 (select part, rn, cast(x as char(1))
    from t1
  union all
  select part + 1,
         rn,
         case nvl(lag(x) over(order by rn),
              last_value(x) over(order by rn rows between current row and unbounded following))
              || x ||
              nvl(lead(x) over(order by rn),
              first_value(x) over(order by rn rows between unbounded preceding and current row))
           when '111' then '0'
           when '110' then '1'
           when '101' then '1'
           when '100' then '0'
           when '011' then '1'
           when '010' then '1'
           when '001' then '1'
           else '0'
         end
    from t2
   where part < 20)
select part, listagg(x) within group(order by rn) str
  from t2
 group by part
 order by 1;