column list format a20

select listagg(id, ',') within group(order by id) list
  from (select column_value id, rownum rn from table(numbers(1, 2, 3, 5, 2)));

select listagg(max(id), ',') within group(order by max(id)) list
  from (select column_value id, rownum rn from table(numbers(1, 2, 3, 5, 2)))
 group by id;

---

select listagg(id, ',') within group(order by max(id)) list
  from (select column_value id, rownum rn from table(numbers(1, 2, 3, 5, 2)))
 group by id;

select listagg(max(id), ',') within group(order by id) list
  from (select column_value id, rownum rn from table(numbers(1, 2, 3, 5, 2)))
 group by id;