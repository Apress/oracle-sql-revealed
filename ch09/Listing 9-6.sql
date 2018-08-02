create or replace function f return number is
begin
  dbms_lock.sleep(1);
  return 1;
end f;
/

set timing on

select id, value, f + 1 f1, f - 1 f2 from tt t; 

select id, value, (select f from dual) + 1 f1, (select f from dual) - 1 f2
  from tt t;

select id, value, ff + 1 f1, ff - 1 f2
  from (select tt.*, (select f from dual) ff from tt) t;
  
set timing off