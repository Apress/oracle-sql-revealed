set lines 100

column path_id format a15
column path_id_parent format a15

with t(id, id_parent, path_id, path_id_parent, cnt1, cnt2) as
 (select g.*,
         cast('->' || g.id as varchar2(4000)),
         cast('->' || g.id_parent as varchar2(4000)),
         0,
         0
    from graph g
   where id = 3
  union all
  select g.id,
         g.id_parent,
         t.path_id || '->' || g.id,
         t.path_id_parent || '->' || g.id_parent,
         regexp_count(t.path_id || '->', '->' || g.id || '->'),
         regexp_count(t.path_id_parent || '->', '->' || g.id || '->')
    from t
    join graph g
      on t.id = g.id_parent
  -- and t.cnt1 = 0 
  -- and t.cnt2 = 0 
  )
search depth first by id set ord
cycle id set cycle to 1 default 0
select * from t;