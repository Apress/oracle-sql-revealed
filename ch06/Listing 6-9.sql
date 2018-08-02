select level lvl, graph.*, connect_by_iscycle cycle
  from graph
 start with id = 3
connect by nocycle prior id = id_parent;

select level lvl, graph.*, connect_by_iscycle cycle
  from graph
 start with id = 3
connect by nocycle prior id = id_parent
       and prior id_parent is not null;

with t(id, id_parent) as
 (select *
    from graph
   where id = 3
  union all
  select g.id, g.id_parent
    from t
    join graph g
      on t.id = g.id_parent) 
search depth first by id set ord
cycle id set cycle to 1 default 0
select * from t;