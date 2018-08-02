exec dbms_random.seed(99); 

create table ta as 
select rownum id,
       trunc(dbms_random.value(1, 5 + 1)) x1,
       trunc(dbms_random.value(1, 5 + 1)) x2,
       trunc(dbms_random.value(1, 5 + 1)) x3
  from dual
connect by level <= 10;

select (select sum(x3) from ta t0 where t0.x2 = ta.x1) s,
       case
         when x1 > x2 then
          sum(x3) over(order by x2 range between greatest(x1 - x2, 0)
                       following and greatest(x1 - x2, 0) following)
         else
          sum(x3) over(order by x2 range between greatest(x2 - x1, 0)
                       preceding and greatest(x2 - x1, 0) preceding)
       end sa,
       ta.*
  from ta
 order by id;