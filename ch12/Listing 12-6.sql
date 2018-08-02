create table d(name, referenced_name) as
(select null, 'o' from dual
union all select 'o', 'a' from dual
union all select 'o', 'd' from dual
union all select 'a', 'b' from dual
union all select 'd', 'b' from dual
union all select 'b', 'e' from dual
union all select 'b', 'c' from dual
union all select 'e', 'c' from dual
union all select 'c', 'x' from dual
union all select 'c', 'y' from dual
union all select 'c', 'z' from dual
);