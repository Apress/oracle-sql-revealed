set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

select t2.*
  from (select --+ cardinality(10) index_desc(t0 idx_tran_id) 
         row_number() over(order by id desc) rn, rowid row_id
          from transaction t0) t1
  join transaction t2
    on t1.row_id = t2.rowid
 where t1.rn <= 10;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));