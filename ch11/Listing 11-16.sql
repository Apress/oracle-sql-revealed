set lines 110 pages 100

alter session set statistics_level = all;

with
t1 as
 (select power(2, rownum-1) row_mask, num from t_num),
t2 as
 (select rownum as total_mask
    from (select count(*) as cnt from t1)
  connect by rownum < power(2, cnt)
  -- or the same: from t1 connect by num > prior num
 )
select count(*) cnt, sum(num) sum_num
  from (select total_mask as id, sum(num) as num
          from t2, t1
         where bitand(row_mask, total_mask) <> 0
         group by total_mask
        having count(*) > 1);

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));