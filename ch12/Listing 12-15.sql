column path format a30

create table n(num) as select 222 from dual union all select 3690 from dual;

create table fib as
with t(lvl, result, tmp) as
 (select 1, 0, 1
    from dual
  union all
  select lvl + 1, tmp, tmp + result
    from t
   where lvl <= 21)
select lvl - 2 lvl, result value from t where lvl > 2;

with n_fib as
 (select num, value, lvl, max(lvl) over(partition by num) max_lvl
    from n
    join fib
      on fib.value <= n.num),
permutation as
 (select num, sys_connect_by_path(value, '+') path, level p_lvl
    from n_fib
   start with lvl = max_lvl
  connect by prior num = num
         and prior value > value
         and sys_guid() is not null)
select num, max(substr(path, 2)) keep(dense_rank first order by p_lvl) path
  from (select num, path, p_lvl
          from permutation p
          join fib
            on instr(p.path || '+', '+' || fib.value || '+') > 0
         group by num, path, p_lvl
        having sum(value) = num)
 group by num
 order by num;