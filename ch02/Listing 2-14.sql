set lines 100 pages 100

explain plan for 
select *
  from fact_ f
 where dim_1_id not in (select id from dim_)
    or dim_2_id not in (select id from dim_);

select * from table(dbms_xplan.display(format => 'basic predicate'));