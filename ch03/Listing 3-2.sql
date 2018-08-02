with t as
 (select rownum id, trunc(rownum / 4) part from dual connect by rownum <= 6)
select t.*,
       (select sum(id)
          from t t0
         where t0.part = t.part
           and t0.id <= t.id) sum1,
       (select sum(id) from t t0 where t0.part = t.part) sum2
  from t
 order by id;