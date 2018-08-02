select fact.*, map.*
  from fact
  join dim_1
    on dim_1.id = fact.dim_1_id
  join dim_n
    on dim_1.dim_n_id = dim_n.id
  left join map
    on case when decode(map.rowid, map.rowid, fact.type) in ('A', 'B', 'C') then 1 end = 1
   and decode(map.category, 'FACT VALUE', fact.value, 'DETAILED VALUE', dim_n.value) = map.value;