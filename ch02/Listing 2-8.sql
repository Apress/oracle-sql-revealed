set pages 100

explain plan for
select /*+ rule */ * from tr where id = any (:bind1, :bind2); 

select * from table(dbms_xplan.display(format => 'basic predicate'));
