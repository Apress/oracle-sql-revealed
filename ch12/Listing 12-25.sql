set lines 150 pages 100

column str format a65
column priority_level heading PL
column priority_level format 99
column rn format 99

with t0 as
(select t.*, row_number() over (order by basket_id, priority_level) rn
   from t),
rec (basket_id, item_id, basket_amount, item_amount, priority_level,
     rn, total, is_used, str) as
(select t.basket_id, t.item_id, t.basket_amount,
        t.item_amount, t.priority_level, t.rn,
        case when t.item_amount <= t.basket_amount
             then t.item_amount else 0 end,
        case when t.item_amount <= t.basket_amount then 1 end,
        cast(case when t.item_amount <= t.basket_amount
                  then ',' || t.item_id end as varchar2(4000))
 from t0 t where rn = 1
 union all
 select t.basket_id, t.item_id, t.basket_amount,
        t.item_amount, t.priority_level, t.rn,
        case when decode(t.basket_id, r.basket_id, r.total, 0)
                  + t.item_amount <= t.basket_amount
              and instr(r.str, t.item_id) = 0
             then decode(t.basket_id, r.basket_id, r.total, 0)
                  + t.item_amount
             else decode(t.basket_id, r.basket_id, r.total, 0)
        end,
        case when decode(t.basket_id, r.basket_id, r.total, 0)
                  + t.item_amount <= t.basket_amount
              and instr(r.str, t.item_id) = 0
             then 1
        end,
        case when decode(t.basket_id, r.basket_id, r.total, 0)
                  + t.item_amount <= t.basket_amount
              and instr(r.str, t.item_id) = 0
             then r.str || ',' || t.item_id
             else r.str
        end
 from t0 t
 join rec r on t.rn = r.rn + 1)
select * from rec;