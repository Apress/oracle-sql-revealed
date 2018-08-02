alter session set statistics_level = all;
set lines 120 pages 100

select v1, v2, v3, count(*) cnt
  from (select row_number() over(order by id) rn,
               value v3,
               lag(value, 1) over(order by id) v2,
               lag(value, 2) over(order by id) v1
          from digit)
 where rn > 2
   and v1 in (1, 2, 3)
   and v2 in (1, 2, 3)
   and v3 in (1, 2, 3)
   and v1 <> v2
   and v1 <> v3
   and v2 <> v3
 group by v1, v2, v3
 order by 1, 2, 3;
select * from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST')); 

select v1, v2, v3, count(*) cnt
  from digit
match_recognize
( order by id
  measures
    v1.value as v1,
    v2.value as v2,
    v3.value as v3        
  one row per match
  after match skip to next row
  pattern (v1 v2 v3)
  define
    v1 as v1.value = any (1, 2, 3),
    v2 as v2.value = any (1, 2, 3)
          and v2.value <> v1.value,
    v3 as v3.value = any (1, 2, 3)
          and v3.value <> v2.value
          and v3.value <> v1.value)
 group by v1, v2, v3         
 order by 1, 2, 3;
select * from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST')); 