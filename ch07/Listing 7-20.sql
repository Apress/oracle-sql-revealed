create or replace type to_3int as object (part int, x int, sid int) 
/ 
create or replace type tt_3int as table of to_3int 
/
create or replace package pkg as 
  type refcur_t is ref cursor return t%rowtype; 
end; 
/
create or replace function f_running(p in pkg.refcur_t) return tt_3int 
   pipelined 
   parallel_enable(partition p by hash(part)) order p by(part, id) is 
   rec  p%rowtype; 
   prev p%rowtype; 
  x      int := 0; 
begin 
   loop 
     fetch p 
       into rec; 
     exit when p%notfound; 
     if rec.id = 1 then 
       x := rec.value; 
     elsif x > 3e3 then 
       x := rec.value; 
     else 
       x := x + rec.value; 
     end if; 
     pipe row(to_3int(rec.part, x, userenv('sid'))); 
     prev := rec; 
   end loop; 
   return; 
end; 
/

select count(distinct sid) c, sum(x*part) s 
  from table(f_running(cursor(select /*+ parallel(2) */ * from t)));