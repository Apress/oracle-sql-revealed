with rec(root, lvl, id, id_parent, grand_parent) as
 (select id_parent, 1 lvl, id, id_parent, cast(null as number)
    from tree
   where id_parent in (1, 10)
  union all
  select r.root, r.lvl + 1, t.id, t.id_parent, r.id_parent
    from tree t
    join rec r
      on t.id_parent = r.id) search depth first by id set ord
select root,
       lvl,
       rpad(' ', (lvl - 1) * 3, ' ') || id as id,
       id_parent,
       grand_parent,
       ord,
       decode(lvl + 1, lead(lvl) over(partition by root order by ord), 0, 1) is_leaf
  from rec;