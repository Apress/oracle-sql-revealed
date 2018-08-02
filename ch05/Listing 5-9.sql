column path_rn format a10
column path_lvl format a10
column path_id format a25

create table t_two_branches(id, id_parent) as 
(select rownum, rownum - 1 from dual connect by level <= 10 
union all 
select 100 + rownum, 100 + rownum - 1 from dual connect by 
level <= 10 
union all 
select 0, null from dual 
union all 
select 100, null from dual);

select rownum rn,
       level lvl,
       replace(sys_connect_by_path(rownum, '~'), '~') as path_rn,
       replace(sys_connect_by_path(level, '~'), '~') as path_lvl,
       sys_connect_by_path(id, '~') path_id
  from t_two_branches
 where mod(level, 3) = 0
 start with id_parent is null
connect by prior id = id_parent;