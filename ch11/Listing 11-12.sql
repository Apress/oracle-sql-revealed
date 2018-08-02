create table t_str(str varchar2(30) not null, padding varchar2(240));

insert --+ append
into t_str
select 'AAA', lpad('x', 240, 'x') from dual
union all
select 'BBB', lpad('x', 240, 'x') from dual
union all
select lpad('C', 30, 'C'), lpad('x', 240, 'x') from dual
connect by rownum <= 3e6
union all
select 'DDD', lpad('x', 240, 'x') from dual;

create index t_str_idx on t_str(str);

exec dbms_stats.gather_table_stats(user,'t_str');

---

set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

select distinct str from t_str;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));
  
with rec(lvl, str) as
(
  select 1, min(str) from t_str
  union all
  select lvl + 1, (select min(str) from t_str where str > rec.str)
    from rec
   where str is not null
)
select * from rec where str is not null;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));