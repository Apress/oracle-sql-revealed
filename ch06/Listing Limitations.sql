with t0(id, id_parent, letter) as
(select 1, 0, 'B' from dual 
union all select 2, 1, 'D' from dual 
union all select 3, 1, 'A' from dual 
union all select 10, 5, 'C' from dual 
union all select 66, 6, 'X' from dual), 
t(id, id_parent, sum_id, lvl, str, rn) as
 (select id, id_parent, id, 1, letter, 1
    from t0
   where id_parent = 0
  union all
  select t0.id,
         t0.id_parent,
         sum(t0.id) over(),
         t.lvl + 1,
         listagg(letter, ', ') within group(order by letter) over(),
         rownum
    from t
    join t0
      on t.sum_id = t0.id_parent
     and t.rn = 1)
select * from t;