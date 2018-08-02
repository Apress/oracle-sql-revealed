set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

select *
  from (select * from transaction order by id desc)
 where rownum <= 10;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST')); 