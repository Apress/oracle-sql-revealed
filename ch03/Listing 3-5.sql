with t as
 (select rownum id, column_value value
    from table(numbers(1, 2, 3, 4.5, 4.6, 7, 10)))
select t.*,
       last_value(value) over(order by value range between unbounded preceding and 1 preceding) l1,
       last_value(value) over(order by value rows between unbounded preceding and 1 preceding) l2
  from t;