select * from fact_ f where dim_1_id not in (select id from dim_); 
select * from fact_ f where dim_2_id not in (select id from dim_);