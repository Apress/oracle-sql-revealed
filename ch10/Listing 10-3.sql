set serveroutput on

declare
  s varchar2(4000) := 'abcd c*de 01';
  n number := length(s);
  j number := 1;
  k number := 1;
  x number := 1;
  i number := 1;
begin
  while x > 0 loop
    x := 0;
    for j in 1 .. n - k loop
      i := i + 1;
      if substr(s, j + 1, 1) < substr(s, j, 1) then
        s := substr(s, 1, j - 1) || substr(s, j + 1, 1) ||
             substr(s, j, 1) || substr(s, j + 2);
        x := 1;
      end if;
    end loop;
    k := k + 1;
  end loop;
  dbms_output.put_line(i || s);
end;
/