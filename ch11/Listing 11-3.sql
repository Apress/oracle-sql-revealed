set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

select t1.id, t1.value
  from (select row_number() over(order by id desc) rn, t0.*
          from transaction t0) t1
 where rn <= 10;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));