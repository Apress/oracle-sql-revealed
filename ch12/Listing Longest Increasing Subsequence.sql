declare
  t numbers := numbers(14, 15, 9, 11, 16, 12, 13);
begin
  delete from tmp;
  for i in 1 .. t.count loop
    insert into tmp
      (lvl, x, num)
    values
      ((select nvl(max(lvl), 0) + 1 from tmp where num < t(i)), i, t(i));
  end loop;
end;
/

select * from tmp;

set serveroutput on

declare
  x    numbers := numbers(14, 15, 9, 11, 16, 12, 13);
  m    numbers := numbers();
  l    int;
  newl int;
  v    varchar2(4000);
  -- index of the greatest element lower than p in array M
  function f(p in number) return int as
    lo  int;
    hi  int;
    mid int;
  begin
    lo := 1;
    hi := l;
    while lo <= hi loop
      mid := ceil((lo + hi) / 2);
      if x(m(mid)) < p then
        lo := mid + 1;
      else
        hi := mid - 1;
      end if;
    end loop;
    return lo;
  end;
begin
  m.extend(x.count);
  l := 0;
  for i in 1 .. x.count loop
    newl := f(x(i));
    m(newl) := i;
    if newl > l then
      l := newl;
    end if;
    v := '';
    for j in 1 .. l loop
      v := v || ' ' || x(m(j));
    end loop;
    dbms_output.put_line(i || ' ' || v);
  end loop;
end;
/

set serveroutput off

with t(id, value) as
(select rownum, column_value from table(numbers(14, 15, 9, 11, 16, 12, 13)))
select *
  from t
model
dimension by (id, value)
measures (0 l)
(l[any, any] order by id = nvl(max(l)[id < cv(id), value < cv(value)],0) + 1)
order by 1;