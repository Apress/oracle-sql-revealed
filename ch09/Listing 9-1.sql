select count(*) over() cnt1 
  from (select column_value id from table(numbers(1, 1)));

select count(*) over() cnt1, count(*) cnt2 
  from (select column_value id from table(numbers(1, 1)));