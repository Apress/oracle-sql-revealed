with t as (select rownum id from dual connect by rownum <= 55) 
select * from t 
match_recognize 
( order by id 
  all rows per match 
  pattern ((fib|{-dummy-})+) 
  define fib as (id = 1 or id = 2 or id = last(fib.id, 1) + last(fib.id, 2))
);