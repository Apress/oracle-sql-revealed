create table tt as 
select rownum id, mod(rownum, 2) value from dual connect by level <= 3;

select value,
       count(*) agg,
       count(*) over() an,
       sum(count(*)) over(order by value) agg_an
  from tt
 group by value;