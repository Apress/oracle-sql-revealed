with r0(x, num) as
 (select rownum, num from (select num from t_num order by num)),
rec(iter, lvl, x, num) as
 (select 1, 1, rownum, num
    from r0
  union all
  select rec.iter + 1,
         decode(z.id, 1, rec.lvl, rec.lvl + 1),
         decode(z.id, 1, rec.x, 0),
         decode(z.id, 1, rec.num, rec.num + r0.num)
    from rec
    join r0
      on rec.iter + 1 = r0.x
    join (select 1 id from dual union all select 2 id from dual) z
      on (z.id = 1 or rec.x < r0.x))
select count(*) cnt, sum(num) sum_num
  from rec
 where iter = (select count(*) from t_num)
   and lvl > 1;