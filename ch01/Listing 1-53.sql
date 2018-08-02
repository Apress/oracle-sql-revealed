create table fact as (select 1 value, 1 dim_1_id, 1 dim_2_id, 'A' type from dual); 
create table dim_1 as (select 1 id, 1 dim_n_id from dual); 
create table dim_n as (select 1 id, 1 value from dual); 
create table map as (select 1 value, 'DETAILED VALUE' category from dual); 

select fact.*, map.* 
   from fact 
   join dim_1 
     on dim_1.id = fact.dim_1_id 
   join dim_n 
     on dim_1.dim_n_id = dim_n.id 
   left join map 
     on fact.type in ('A', 'B', 'C') 
    and ((map.category = 'FACT VALUE' and map.value = fact.value) or 
         (map.category = 'DETAILED VALUE' and map.value = dim_n.value));