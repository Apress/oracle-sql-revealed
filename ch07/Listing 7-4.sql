with t as 
(select rownum id from dual connect by level <= 3) 
select * 
from t 
model 
dimension by (id)
measures (id result) 
rules 
( 
   result[any] /*order by id*/ = sum(result)[any] 
);