select p.name, w.day, count(p.time) cnt 
   from week w 
   left join presentation p partition by (p.name) 
       on w.day = p.day 
  group by p.name, w.day, w.id 
  order by p.name, w.id;