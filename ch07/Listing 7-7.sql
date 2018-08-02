select * from (select 1 x from dual) 
model dimension by (x) measures (0 as result, 64 tmp) 
rules automatic order 
(result[1]=ceil(tmp[1]/4), tmp[1]=result[1]); 

select * from (select 1 x from dual) 
model dimension by (x) measures (0 as result, 65 tmp) 
rules automatic order 
(result[1]=ceil(tmp[1]/4), tmp[1]=result[1]);