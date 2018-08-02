create table entity_flattened as 
select *
  from (select e.name name, p.name p_name, value
          from entity e
          join property p
            on p.entity_id = e.id)
pivot(max(value) for p_name in('P1' p1_value, 'P2' p2_value, 'P3' p3_value));