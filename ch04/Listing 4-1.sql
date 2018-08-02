column details format a40

select p.name,
       count(*) cnt_all,
       count(distinct p.day) cnt_day,
       listagg(p.day || ' ' || p.time || ':00', '; ') within group(order by w.id) details
  from presentation p, week w
 where p.day = w.day
 group by p.name;