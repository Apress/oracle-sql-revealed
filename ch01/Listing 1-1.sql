create table t1(id, name) as 
select 1, 'A' from dual union all select 0, 'X' from dual; 

create table t2(id, name) as 
select 2, 'B' from dual union all select 0, 'X' from dual;