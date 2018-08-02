select referenced_name, max(level) ord, count(*) cnt
  from d
 start with not exists
 (select 1 from d d_in where d_in.name = d.referenced_name)
connect by prior name = referenced_name
 group by referenced_name
 order by 2, 1;