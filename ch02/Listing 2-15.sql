explain plan for 
select *
  from (select * from fact_ f where dim_1_id not in (select id from dim_))
 where dim_2_id not in (select id from dim_);

select * from table(dbms_xplan.display(format => 'basic predicate')); 