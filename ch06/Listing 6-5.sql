create or replace function y(x in number) return number as
begin return x*x - 2; end;
/

with t(id, x, x0, x1) as
 (select 0, 0, 1, 2
    from dual
  union all
  select t.id + 1,
         (t.x0 + t.x1) / 2,
         case
           when sign(y(x0)) = sign(y((t.x0 + t.x1) / 2)) then
            (t.x0 + t.x1) / 2
           else
            x0
         end,
         case
           when sign(y(x1)) = sign(y((t.x0 + t.x1) / 2)) then
            (t.x0 + t.x1) / 2
           else
            x1
         end
    from t
   where abs((t.x0 + t.x1) / 2 - t.x) > 1e-2)
select t.*, (x0 + x1) / 2 result from t;