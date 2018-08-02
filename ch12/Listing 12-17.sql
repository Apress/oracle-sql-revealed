with rec(lvl, num, f, s) as
 (select 1,
         n.num,
         (select max(fib.value) from fib where fib.value <= n.num),
         0
    from n
  union all
  select lvl + 1,
         d.num,
         (select max(fib.value)
            from fib
           where fib.value <= d.num - (d.f + d.s)),
         d.f + d.s
    from rec d
   where d.s + d.f < d.num)
select num, listagg(f, '+') within group(order by f desc) path
  from rec
 group by num
 order by num;