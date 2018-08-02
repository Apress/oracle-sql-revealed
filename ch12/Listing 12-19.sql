select num,
       (select listagg(value, '+')
               within group(order by value desc) path
          from (select n.num, fib.value from fib) y
        match_recognize
        (
          order by value desc
          all rows per match
          pattern((x|{-dummy-})+)
          define
            x as sum(x.value) <= num
        ) mr
       ) path
  from n;
  
select t.*,
       (with rec(lvl) as (select /*t.id*/
                           5 lvl
                            from dual
                          union all
                          select rec.lvl + 1
                            from rec
                           where lvl < 10)
         select listagg(lvl, ', ') within group(order by lvl)
           from rec) str
           from (select 5 id from dual) t;