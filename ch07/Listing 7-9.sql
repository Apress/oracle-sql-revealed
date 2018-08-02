with sales(year, currency, value) as 
(select '2015', 'GBP', 100 from dual 
union all select '2015', 'USD', 200 from dual 
union all select '2015', 'EUR', 300 from dual 
union all select '2016', 'GBP', 400 from dual 
union all select '2016', 'EUR', 500 from dual) 
, usd_rates(currency, rate) as 
(select 'GBP', 1.45 from dual 
union all select 'USD', 1 from dual 
union all select 'EUR', 1.12 from dual) 
select * 
from sales 
model 
   reference usd_rates_model on (select * from usd_rates) 
   dimension by (currency) 
   measures (rate)
main sales_model 
dimension by (year, currency) 
measures (value, 0 usd_value) 
( 
   usd_value[any, any] order by year, currency = 
     value[cv(year), cv(currency)] * usd_rates_model. 
     rate[cv(currency)] 
) 
order by 1, 2;