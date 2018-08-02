select *
  from (select fact.*, dim_n.value as value_1
          from fact, dim_1, dim_n
         where dim_1.id = fact.dim_1_id
           and dim_1.dim_n_id = dim_n.id) sub,
       map
 where case when decode(map.rowid(+), map.rowid(+), sub.type) in ('A', 'B', 'C') then 1 end = 1
   and decode(map.category(+), 'FACT VALUE', sub.value, 'DETAILED VALUE', sub.value_1) = map.value(+);