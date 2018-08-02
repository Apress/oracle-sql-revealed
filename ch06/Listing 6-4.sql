cl col
set pages 100

with t(id, result) as
 (select 0 id, 1 result
    from dual
  union all
  select t.id + 1, round(100 * sin(t.result + t.id))
    from t
   where t.id < 20)
select * from t;

with t(lvl, result, tmp) as
 (select 1, 0, 1
    from dual
  union all
  select lvl + 1, tmp, tmp + result
    from t
   where lvl < 15)
select lvl, result from t;