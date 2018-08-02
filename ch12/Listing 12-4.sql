create table edge(x1, x2) as
select 10,20 from dual
union all select 50,40 from dual
union all select 20,30 from dual
union all select 20,40 from dual
union all select 60,70 from dual
union all select 80,60 from dual
union all select 20,90 from dual;

select x, dense_rank() over(order by min(root)) grp
  from (select connect_by_root x1 root, x1, x2
          from edge
        connect by nocycle prior x1 in (x1, x2)
                or prior x2 in (x1, x2))
 unpivot(x for x12 in(x1, x2))
 group by x
 order by 1, 2;
