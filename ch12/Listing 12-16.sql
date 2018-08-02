with n_fib as
 (select num, value, lvl, max(lvl) over(partition by num) max_lvl
    from n
    join fib
      on fib.value <= n.num),
rec(lvl, num, f, s) as
 (select 1, n_fib.num, n_fib.value, 0
    from n_fib
   where n_fib.lvl = n_fib.max_lvl
  union all
  select rec.lvl + 1, l.num, l.value, rec.f + rec.s
    from rec
   cross apply (select *
                 from (select *
                         from n_fib
                        where n_fib.num = rec.num
                          and n_fib.value + rec.s + rec.f <= rec.num
                        order by lvl desc)
                where rownum = 1) l)
cycle lvl set c to 1 default 0
select num, listagg(f, '+') within group(order by f desc) path
  from rec
 group by num
 order by num;