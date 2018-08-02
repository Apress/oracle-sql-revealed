cl col
column name format a10

-- drop table tree; 
-- drop table nodes;

create table tree(id, id_parent) as 
select rownum, rownum - 1 from dual connect by level <= 4;
create table nodes(id, name, sign) as 
select rownum, 'name' || rownum, decode(rownum, 3, 0, 1)
  from dual
connect by rownum <= 4;

select t.*, n.name
  from tree t, nodes n
 where t.id = n.id
   and n.sign = 1
 start with t.id_parent = 0
connect by prior t.id = t.id_parent;

select *
  from (select t.*, n.name
          from tree t, nodes n
         where t.id = n.id
           and n.sign = 1) t
 start with t.id_parent = 0
connect by prior t.id = t.id_parent;

select t.*, n.name
  from tree t
  join nodes n
    on t.id = n.id
   and n.sign = 1
 start with t.id_parent = 0
connect by prior t.id = t.id_parent;
