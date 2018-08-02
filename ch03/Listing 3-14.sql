with t(id, value, part) as 
( 
select 1, null, 1 from dual 
union all select 2, 'one', 1 from dual 
union all select 3, null, 1 from dual 
union all select 1, 'two', 2 from dual 
union all select 2, null, 2 from dual 
union all select 3, null, 2 from dual 
union all select 4, 'three', 2 from dual 
) 
select t.*, max(value) over(partition by part, cnt) lv0
  from (select t.*,
               last_value(value ignore nulls) over(partition by part order by id) lv,
               count(value) over(partition by part order by id) cnt
          from t
         order by part, id) t;