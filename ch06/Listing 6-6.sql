create or replace function stop_at(p_id in number, p_stop in number)
  return number is
begin
  if p_id = p_stop then
    dbms_application_info.set_client_info('1');
    return 1;
  end if;
  for i in (select client_info from v$session where sid = userenv('sid')) loop
    return i.client_info;
  end loop;
end;
/

exec dbms_application_info.set_client_info(''); 

with rec(lvl, id) as
 (select 1, id
    from t_two_branches
   where id_parent is null
  union all
  select r.lvl + 1, t.id
    from t_two_branches t
    join rec r
      on t.id_parent = r.id
   where stop_at(t.id, 101) is null)
search breadth first by id set ord
--search depth first by id set ord 
select * from rec;

exec dbms_application_info.set_client_info(''); 

with rec(lvl, id) as
 (select 1, id
    from t_two_branches
   where id_parent is null
  union all
  select r.lvl + 1, t.id
    from t_two_branches t
    join rec r
      on t.id_parent = r.id
   where stop_at(t.id, 101) is null)
--search breadth first by id set ord 
search depth first by id set ord
select * from rec;

select rownum rn, level lvl, id, id_parent
  from t_two_branches
 start with id_parent is null
connect by prior id = id_parent
       and stop_at(id, 101) is null;