set pages 100

select * 
from dual 
model 
dimension by (0 id) 
measures (1 result) 
rules 
( 
   result[for id from 1 to 20 increment 1] = 
   round(100 * sin(result[cv(id)-1] + cv(id) - 1)) 
); 

select *
  from (select rownum lvl, rownum - 1 result
          from dual connect by level <= 2)
model 
ignore nav 
dimension by (lvl) 
measures (result) 
rules 
( 
   result[for lvl from 3 to 15 increment 1] = 
   result[cv(lvl)-1] + result[cv(lvl)-2] 
);