set pages 100

explain plan for 
select name, cnt
  from t3
  join (select id, max(name) name, count(*) cnt from tr group by id) sub
    on sub.id = t3.id;

select * from table(dbms_xplan.display(format => 'basic predicate'));