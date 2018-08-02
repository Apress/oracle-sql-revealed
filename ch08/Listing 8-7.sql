with t as (select rownum id from dual connect by rownum <= 10) 
select * from t 
match_recognize 
( order by id 
   measures 
     match_number() match, 
     classifier() cls 
   all rows per match with unmatched rows 
   pattern (x y{2, 3} z) 
   define 
     z as x.id + z.id <= 15 
) mr;