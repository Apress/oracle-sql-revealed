with t(id, id_parent) as
 (select *
    from graph
   where id_parent = 1
  union all
  select g.id, g.id_parent
    from t
    join graph g
      on t.id = g.id_parent)
search depth first by id set ord
cycle id_parent set cycle to 1 default 0
select * from t;