create table t(basket_id, item_id, basket_amount, item_amount, priority_level) as
with
  baskets(basket_id, basket_amount) as
  ( select 100, 500000 from dual union all
    select 200, 400000 from dual union all
    select 300, 1000000 from dual
  ),
  inventory(item_id, item_amount) as
  ( select 1000001, 50000 from dual union all
    select 1000002, 15000 from dual union all
    select 1000003, 250000 from dual union all
    select 1000004, 350000 from dual union all
    select 1000005, 45000 from dual union all
    select 1000006, 100500 from dual union all
    select 1000007, 200500 from dual union all
    select 1000008, 30050 from dual union all
    select 1000009, 400500 from dual union all
    select 1000010, 750000 from dual
  ),
  eligibility(basket_id, item_id, priority_level) as
  ( select 100, 1000003, 1 from dual union all
    select 100, 1000004, 2 from dual union all
    select 100, 1000002, 3 from dual union all
    select 100, 1000005, 4 from dual union all
    select 200, 1000004, 1 from dual union all
    select 200, 1000003, 2 from dual union all
    select 200, 1000001, 3 from dual union all
    select 200, 1000005, 4 from dual union all
    select 200, 1000007, 5 from dual union all
    select 200, 1000006, 6 from dual union all
    select 300, 1000002, 1 from dual union all
    select 300, 1000009, 2 from dual union all
    select 300, 1000010, 3 from dual union all
    select 300, 1000006, 4 from dual union all
    select 300, 1000008, 5 from dual
  )
 select e.basket_id,
        e.item_id,
        b.basket_amount,
        i.item_amount,
        e.priority_level
   from eligibility e
   join baskets b
     on b.basket_id = e.basket_id
   join inventory i
     on i.item_id = e.item_id
  order by basket_id, priority_level;

select *
from t
model
dimension by (basket_id, priority_level, item_id)
measures (basket_amount, item_amount, 0 result)
rules
(
  result[any, any, any] order by basket_id, priority_level, item_id =
  case when max(result)[any, any, cv(item_id)] = 0 and
            nvl(max(result)[cv(basket_id),priority_level < cv(priority_level),any],0) + 
            item_amount[cv(basket_id),cv(priority_level),cv(item_id)]
            <= max(basket_amount)[cv(basket_id),cv(priority_level),any]
       then nvl(max(result)[cv(basket_id),priority_level < cv(priority_level),any],0) + 
            item_amount[cv(basket_id),cv(priority_level),cv(item_id)]
       else 0
  end       
)
order by 1, 2;