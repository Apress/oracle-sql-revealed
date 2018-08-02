set serveroutput on

declare
  s varchar2(4000) := 'abcd c*de 01';
  n number := length(s);
  j number := 1;
  k number := 1;
  x number := 1;
  i number := 1;
  c number := 0;
begin
  while x > 0 loop
    i := i + 1;
    c := case when substr(s, j + 1, 1) < substr(s, j, 1)
              then 1
              else case when j = 1 then 0 else c end
         end;
    s := case when substr(s, j + 1, 1) < substr(s, j, 1)
              then substr(s, 1, j - 1) || substr(s, j + 1, 1) ||
                   substr(s, j, 1) || substr(s, j + 2)
              else s
         end;
    x := case when j = n - k and c = 0 then 0 else 1 end;
    k := case when j = n - k then k + 1 else k end;
    j := case when j - 1 = n - k then 1 else j + 1 end;
  end loop;
  dbms_output.put_line(i || s);
end;
/