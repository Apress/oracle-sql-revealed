with n_fib as
 (select num, value, lvl
    from n
    join fib
      on fib.value <= n.num)
, m as
(select *
   from n_fib
  model
 ignore nav
 partition by (num part)
 dimension by (lvl)
 measures (num, value, 0 x)
 rules
 (
   x[any] order by lvl desc =
   case when x[cv(lvl)+1] + value[cv(lvl)] <= num[cv(lvl)]
        then x[cv(lvl)+1] + value[cv(lvl)]
        else x[cv(lvl)+1]
   end
 ))
select num, listagg(f, '+') within group(order by f desc) path
  from (select num, max(value) f from m group by num, x)
 group by num
 order by num;