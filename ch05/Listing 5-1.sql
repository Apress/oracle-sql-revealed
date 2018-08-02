column id format a15
column path format a15

create table tree as 
select 2 id, 1 id_parent from dual 
union all select 3 id, 1 id_parent from dual 
union all select 4 id, 3 id_parent from dual 
union all select 5 id, 4 id_parent from dual 
union all select 11 id, 10 id_parent from dual 
union all select 12 id, 11 id_parent from dual 
union all select 13 id, 11 id_parent from dual;

select connect_by_root id_parent root,
       level lvl,
       rpad(' ', (level - 1) * 3, ' ') || t.id as id,
       prior id_parent grand_parent,
       sys_connect_by_path(id, '->') path,
       connect_by_isleaf is_leaf
  from tree t
 start with t.id_parent in (1, 10)
connect by prior t.id = t.id_parent;