create table graph (id, id_parent) as 
(select 2, 1 from dual 
union all select 3, 1 from dual 
union all select 4, 3 from dual 
union all select 5, 4 from dual 
union all select 3, 5 from dual);