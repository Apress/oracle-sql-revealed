with t(id) as 
(select cast('base' as varchar2(10)) from dual) 
select * 
from t 
model 
ignore nav 
dimension by (id) 
measures (cast(null as varchar2(10)) msr_base, 
          cast(null as varchar2(10)) msr_calc, 
          to_number(null) num) 
( 
   msr_base['calc'] = '1', 
   msr_base['presentv'] = presentv(msr_base['base'], '+', '-'), 
   msr_base['presentnnv'] = presentnnv(msr_base['base'], '+', '-'), 
   msr_base['nvl2'] = nvl2(msr_base['base'], '+', '-'), 
   msr_calc['presentv'] = presentv(msr_base['calc'], '+', '-'), 
   msr_calc['presentnnv'] = presentnnv(msr_base['calc'], '+', '-'), 
   msr_calc['nvl2'] = nvl2(msr_base['calc'], '+', '-'), 
   num[any] = num[-1] 
) 
order by id;