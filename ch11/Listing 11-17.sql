create or replace function f_calc(p_str in varchar2) return number is
  pragma udf;
  result number := 0;
  i      int := 0;
  n      varchar2(30);
begin
  while true loop
    i := i + 1;
    n := substr(p_str,
                instr(p_str, '+', 1, i) + 1,
                instr(p_str, '+', 1, i + 1) - instr(p_str, '+', 1, i) - 1);
    if n is not null then
      result := result + n;
    else
      exit;
    end if;
  end loop;
  return result;
end f_calc;
/

set timing on

select count(*) cnt, sum(f_calc(path)) sum_num
  from (select sys_connect_by_path(num, '+') || '+' as path
          from t_num
         where level > 1
        connect by num > prior num);

set timing off

create global temporary table tmp(lvl int, x int, num number);

begin
  insert into tmp(lvl, x, num)
    select 1, rownum, num from (select num from t_num order by num);
  for c in (select rownum x, num from (select num from t_num order by num)) loop
    insert into tmp(lvl, x, num)
      select c.x, 0, tmp.num + c.num from tmp where tmp.x < c.x;
  end loop;
end;
/

set timing on

select count(*) cnt, sum(num) sum_num from tmp where lvl > 1;

set timing off