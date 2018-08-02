select *
  from tr
 where id is not null
   and :p is null
union all
select *
  from tr
 where id = :p
   and :p is not null;