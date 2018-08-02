create table fact_ as (select 1 value, 1 dim_1_id, 2 dim_2_id from dual); 
create table dim_ as (select rownum id, 'name'||rownum name from dual connect by rownum <= 2);