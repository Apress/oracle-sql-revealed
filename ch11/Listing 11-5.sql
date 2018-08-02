set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

select t1.id, t1.value
  from (select sum(value) over(order by id desc) s, t0.* from transaction t0) t1
 where s <= 5000;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));

alter session set workarea_size_policy = manual;
alter session set sort_area_size = 2147483647;

select t1.id, t1.value
  from (select sum(value) over(order by id desc) s, t0.* from transaction t0) t1
 where s <= 5000;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));