create or replace function f_10base(p_x        in varchar,
                                    p_alphabet in varchar default '0123456789ABCDEF')
  return number is
  result number := 0;
  l_base int := length(p_alphabet);
begin
  for i in 1 .. length(p_x) loop
    result := result + power(l_base, i - 1) *
              (instr(p_alphabet, substr(p_x, -i, 1)) - 1);
  end loop;
  return result;
end f_10base;
/

set timing on

select sum(f_10base('ABC' || rownum)) f from dual connect by level <= 1e6;

select sum(num) f
  from (select (select sum(power(base, level - 1) *
                           (instr(:alphabet, substr(x, -level, 1)) - 1)) num
                  from (select length(:alphabet) base from dual)
                connect by level <= length(x)) num
          from (select 'ABC' || rownum x from dual connect by level <= 1e6));

select sum(to_number('ABC' || rownum, lpad('X', 10, 'X'))) f
  from dual
connect by level <= 1e6;

set timing off