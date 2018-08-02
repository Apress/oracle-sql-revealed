select name
  from (select e.name,
               max(decode(p.name, 'P1', value)) p1_value,
               max(decode(p.name, 'P2', value)) p2_value,
               max(decode(p.name, 'P3', value)) p3_value
          from entity e
          join property p
            on p.entity_id = e.id
         group by e.name)
 where (p1_value, p2_value, p3_value) in ((1, 10, 100));

select e.name
  from property p
  join entity e on p.entity_id = e.id
 where (p.name, p.value) in (('P1', 1), ('P2', 10), ('P3', 100))
 group by e.name
having count(*) = 3;