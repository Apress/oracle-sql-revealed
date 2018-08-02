set pages 100

create or replace type to_2int as object (x int, grp int)
/
create or replace type tt_2int as table of to_2int
/
create or replace function f_connected_component return tt_2int
  pipelined is
  i_list number := 0;
  i      number;
  n      number;
  k      number;
  type tp1 is table of binary_integer index by binary_integer;
  type tp2 is table of tp1 index by binary_integer;
  t1 tp1;
  t2 tp2;
begin
  for c in (select x1, x2 from edge) loop
    if not t1.exists(c.x1) and not t1.exists(c.x2) then
      i_list := i_list + 1;
      t1(c.x1) := i_list;
      t1(c.x2) := i_list;
      t2(i_list)(c.x1) := null;
      t2(i_list)(c.x2) := null;
    elsif t1.exists(c.x1) and not t1.exists(c.x2) then
      t1(c.x2) := t1(c.x1);
      t2(t1(c.x1))(c.x2) := null;
    elsif t1.exists(c.x2) and not t1.exists(c.x1) then
      t1(c.x1) := t1(c.x2);
      t2(t1(c.x2))(c.x1) := null;
    elsif t1.exists(c.x1) and t1.exists(c.x2) and t1(c.x1) <> t1(c.x2) then
      n := greatest(t1(c.x1), t1(c.x2));
      k := least(t1(c.x1), t1(c.x2));
      i := t2(n).first;
      while (i is not null) loop
        t2(k)(i) := null;
        t1(i) := k;
        i := t2(n).next(i);
      end loop;
      t2.delete(n);
    end if;
  end loop;
  i := t1.first;
  for idx in 1 .. t1.count loop
    pipe row(to_2int(i, t1(i)));
    i := t1.next(i);
  end loop;
end;
/

select x, dense_rank() over(order by grp) grp
  from table(f_connected_component)
 order by x;

drop table edge;

exec dbms_random.seed(11);

create table edge as
select trunc(dbms_random.value(1, 100)) x1,
       trunc(dbms_random.value(1, 100)) x2
  from dual
connect by level <= 61;

-- to check that no duplicate edges have been generated
select count(distinct least(x1, x2) || ' ' || greatest(x1, x2)) dist_edge from edge;

select x, dense_rank() over(order by grp) grp
  from table(f_connected_component)
 order by x;