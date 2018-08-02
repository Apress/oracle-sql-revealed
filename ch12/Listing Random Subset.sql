create table t_id_value as
select rownum id, 'name' || rownum value
  from dual
connect by rownum <= 2e6;

alter table t_id_value add constraint pk_t_id_value primary key (id);

select *
  from (select * from t_id_value order by dbms_random.value)
 where rownum <= 10;
 
select *
  from t_id_value
 where rowid in
       (select *
          from (select rowid from t_id_value order by dbms_random.value)
         where rownum <= 10);
         
select *
  from t_id_value
 where id in (select trunc(dbms_random.value(1, (select max(id) from t_id_value) + 1))
                from dual
              connect by level <= 10);
              
exec dbms_random.seed(48673);

select *
  from t_id_value
 where id in (select trunc(dbms_random.value(1, (select max(id) from t_id_value) + 1))
                from dual
              connect by level <= 10);
              
select *
  from t_id_value
 where id in
 (
  select distinct x
    from dual
  model -- return updated rows
  dimension by (0 id)
  measures (0 i, 0 x, (select max(id) from t_id_value) max_id)
  rules
  iterate (1e9) until i[0] = 10
  (
    x[iteration_number] = trunc(dbms_random.value(1,  max_id[0] + 1)),
    i[0] = case when iteration_number < 10 - 1
                then 0 else count(distinct x)[any]
           end
  )
 );
 
with rec(lvl, batch) as
 (select 1, numbers(trunc(dbms_random.value(1, 2e6 + 1)))
    from dual
  union all
  select lvl + 1,
         batch multiset union all numbers(trunc(dbms_random.value(1, 2e6 + 1)))
    from rec
   where case
           when lvl < 10 then
            0
         -- cardinality(set())
         -- does not work in recursive member
           else
            (select count(*) from table(set(rec.batch)))
         end < 10)
select *
  from t_id_value
 where id in (select column_value
                from (select *
                        from (select * from rec t order by lvl desc)
                       where rownum = 1),
                     table(batch));

set serveroutput on
declare
  type tp_arr is table of binary_integer index by binary_integer;
  arr tp_arr;
  i   int := 0;
begin
  while true loop
    arr(trunc(dbms_random.value(1, 2e6 + 1))) := null;
    i := i + 1;
    if i >= 10 and arr.count = 10 then
      exit;
    end if;
  end loop;
  i := arr.first;
  while (i is not null) loop
    dbms_output.put_line(i);
    i := arr.next(i);
  end loop;
end;
/
set serveroutput off