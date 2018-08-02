set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

with rec(id, value, s) as
(
  select id, value, value
    from transaction
   where id = (select max(id) from transaction)
  union all
  select t.id, t.value, rec.s + t.value
    from rec
    cross apply (select max(id) id from transaction where id < rec.id) t0
    join transaction t on t0.id = t.id
   where rec.s + t.value <= 5000
)
cycle id set c to 1 default 0
select * from rec;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));