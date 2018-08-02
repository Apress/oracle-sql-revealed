with t as
 (select rownum id, trunc(rownum / 4) part from dual connect by rownum <= 6)
select t.*,
       sum(id) over(partition by part order by id) sum1,
       sum(id) over(partition by part) sum2
  from t
 order by id;