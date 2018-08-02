set pages 100 lines 100

create table tr(id primary key, name) as 
select rownum, lpad('#',rownum,'#') from dual connect by level <= 1e5; 

explain plan for select * from tr where id = nvl(:p, id); 

select * from table(dbms_xplan.display(format => 'basic predicate'));