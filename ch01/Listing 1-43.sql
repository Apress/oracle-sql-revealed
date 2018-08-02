create or replace type numbers as table of number 
/ 
create table tc (id int, nums numbers) nested table nums store as nums_t 
/

insert into tc 
select -1 id, numbers(null) nums from dual 
union all select 0 id, numbers() nums from dual 
union all select 1 id, numbers(1) nums from dual 
union all select 2 id, numbers(1,2) nums from dual; 