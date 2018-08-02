exec dbms_random.seed(1);

create table fact_a as
select date '2010-01-01' + level / (60 * 24) dt,
       trunc(3 * dbms_random.value()) dim_1_id,
       trunc(3 * dbms_random.value()) dim_2_id,
       trunc(1000 * dbms_random.value()) value
  from dual
connect by level <= 3e6;

exec dbms_stats.gather_table_stats(user, 'fact_a');

---

set lines 120 pages 100

alter session set statistics_level = all;
-- for 12.1
-- alter session set "_optimizer_adaptive_plans" = false;
alter session set optimizer_adaptive_plans = false;

alter session set workarea_size_policy = manual;
alter session set sort_area_size = 2147483647;

select to_char(sum(dim1_sum), lpad('9', 20, '9')) d1,
       to_char(sum(dim2_sum), lpad('9', 20, '9')) d2,
       to_char(sum(dim1_dim2_sum), lpad('9', 20, '9')) d12
  from (select dt,
               dim_1_id,
               dim_2_id,
               value,
               sum(value) over(partition by dim_1_id order by dt) dim1_sum,
               sum(value) over(partition by dim_2_id order by dt) dim2_sum,
               sum(value) over(partition by dim_1_id, dim_2_id order by dt) dim1_dim2_sum
          from fact_a
         order by dt);

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));