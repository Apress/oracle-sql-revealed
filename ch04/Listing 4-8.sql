select *
  from entity_flattened unpivot(value for p_name in(p1_value as 'P1',
                                                    p2_value as 'P2',
                                                    p3_value as 'P3'));

select name,
       p_name,
       decode(p_name, 'P1', p1_value, 'P2', p2_value, 'P3', p3_value) value
  from entity_flattened,
       (select 'P1' p_name from dual
        union all select 'P2' from dual
        union all select 'P3' from dual)
 where decode(p_name, 'P1', p1_value, 'P2', p2_value, 'P3', p3_value) is not null
 order by 1, 2;