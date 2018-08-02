with points as 
  (select rownum id, rownum * rownum x, mod(rownum, 3) y 
     from dual 
   connect by rownum <= 6) 
, t as 
(select p.*, 
         -- the number of points within the distance of 5 by x coordinate 
         -- cannot be solved with analytic functions for more than one coordinate 
         count(*) over(order by x range between 5 preceding and 5 following) cnt, 
         -- sum of the distances to the point (3, 3) for all rows 
         -- between unbounded preceding and current row ordered by id 
         -- cannot be solved using analytic function if required to calculate 
         -- distance between other rows and current row rather than a constant point 
         round(sum(sqrt((x - 3) * (x - 3) + (y - 3) * (y - 3))) 
               over(order by id), 2) dist 
   from points p) 
select * 
from t 
model 
dimension by (x, y) 
measures (id, cnt, dist, 0 cnt2) 
rules 
( 
   cnt2[any, any] = count(*)[x between cv(x) - 5 and cv(x) + 5, 
                             y between cv(y) - 1 and cv(y) + 1] 
) 
order by id;