column id format a10
column path format a10

with rec(lvl, id, path) as
 (select 1 lvl, id, cast('->' || id as varchar2(4000))
    from tree
   where id_parent in (1, 10)
  union all
  select r.lvl + 1, t.id, r.path || '->' || t.id
    from tree t
    join rec r
      on t.id_parent = r.id)
select lvl, rpad(' ', (lvl - 1) * 3, ' ') || id as id, path
  from rec;