select w.name, w.day, count(p.time) cnt
  from (select p0.name, w0.*
          from (select distinct name from presentation) p0, week w0) w,
       presentation p
 where w.day = p.day(+)
   and w.name = p.name(+)
 group by w.name, w.day, w.id
 order by w.name, w.id;