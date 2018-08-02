set pages 100

create or replace function f(n in number) return numbers as 
   result numbers := numbers(); 
begin 
   result.extend(n + 1); 
   result(1) := 1; 
   for i in 2 .. n + 1 loop 
     result(i) := round(100 * sin(result(i - 1) + i - 2)); 
   end loop; 
   return result; 
end f; 
/

create or replace function f(n in number) return numbers as 
   result numbers; 
begin 
   if n = 0 then return numbers(1); 
   else 
     result := f(n - 1); 
     result.extend; 
     result(n + 1) := round(100 * sin(result(n) + n - 1)); 
     return result; 
   end if; 
end f; 
/

with t as 
  (select -100 + level - 1 result from dual connect by level <= 201) 
select level - 1 as id, result, connect_by_iscycle cycle
  from t
 start with result = 1
connect by nocycle round(100 * sin(prior result + level - 2)) = result
       and level <= 21;