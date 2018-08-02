column cls format a5

with t(s, e) as ( 
select 1, 4 from dual 
union all select 7, 8 from dual 
union all select 9, 10 from dual 
union all select 11, 14 from dual 
union all select 20, 25 from dual 
union all select 30, 40 from dual)
select mr.* 
from (select * from t union all select 1e10, 1e10 from dual) 
match_recognize 
( order by s 
  measures 
    classifier() cls, 
    decode(classifier(), 'Y', last(cont.e) + 1, s) strt, 
    decode(classifier(), 'Y', s - 1, e) end 
  all rows per match with unmatched rows 
  after match skip to last y 
  pattern (strt x* y) 
  subset cont = (strt, x) 
  define x as x.s = prev(x.e) + 1 
) mr 
where s <> 1e10 
order by strt, end;