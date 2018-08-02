column days format a30
column days_unique format a30

select name,
       collagg(cast(collect(p.day order by w.id desc) as strings)) days,
       collagg(set(cast(collect(p.day order by w.id desc) as strings))) days_unique
  from presentation p, week w
 where p.day = w.day
 group by p.name;