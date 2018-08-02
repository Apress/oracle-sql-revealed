create table entity(id, name) as 
(select 1, 'E1' from dual 
union all select 2, 'E2' from dual 
union all select 3, 'E3' from dual);

create table property(id, entity_id, name, value) as 
(select 1, 1, 'P1', 1 from dual 
union all select 2, 1, 'P2', 10 from dual 
union all select 3, 1, 'P3', 20 from dual 
union all select 4, 1, 'P4', 50 from dual 
union all select 5, 2, 'P1', 1 from dual 
union all select 6, 2, 'P3', 100 from dual 
union all select 7, 2, 'P4', 50 from dual 
union all select 8, 3, 'P1', 1 from dual 
union all select 19, 3, 'P2', 10 from dual 
union all select 10, 3, 'P3', 100 from dual);

select e.name 
   from entity e 
   join property p1 on p1.entity_id = e.id and p1.name = 'P1' 
   join property p2 on p2.entity_id = e.id and p2.name = 'P2' 
   join property p3 on p3.entity_id = e.id and p3.name = 'P3' 
 where p1.value = 1 and p2.value = 10 and p3.value = 100;