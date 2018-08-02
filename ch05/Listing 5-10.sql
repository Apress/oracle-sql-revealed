select rownum rn,
       level lvl,
       replace(sys_connect_by_path(rownum, '~'), '~') as path_rn,
       replace(sys_connect_by_path(level, '~'), '~') as path_lvl,
       sys_connect_by_path(id, '~') path_id
  from t_two_branches
 start with id_parent is null
connect by prior id = id_parent
       and rownum <= 2;

select rownum rn,
       level lvl,
       replace(sys_connect_by_path(rownum, '~'), '~') as path_rn,
       replace(sys_connect_by_path(level, '~'), '~') as path_lvl,
       sys_connect_by_path(id, '~') path_id
  from t_two_branches
 start with id_parent is null
connect by prior id = id_parent
       and level <= 2;