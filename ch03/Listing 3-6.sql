set lines 100

with points as
 (select rownum id, rownum * rownum x, mod(rownum, 3) y
    from dual
  connect by rownum <= 6),
t as
 (select p.*,
         -- the number of points within the distance of 5 by x coordinate
         -- cannot be solved with analytic functions for more than one coordinate
         count(*) over(order by x range between 5 preceding and 5 following) cnt,
         -- sum of the distances to the point (3, 3) for all rows 
         -- between unbounded preceding and current row ordered by id 
         -- cannot be solved using analytic functions if required to calculate
         -- distance between other rows and current row rather than a constant point
         round(sum(sqrt((x - 3) * (x - 3) + (y - 3) * (y - 3)))
               over(order by id),
               2) dist
    from points p)
select t.*,
       (select count(*) from t t0 where t0.x between t.x - 5 and t.x + 5) cnt1,
       (select count(*)
          from t t0
         where t0.x between t.x - 5 and t.x + 5
           and t0.y between t.y - 1 and t.y + 1) cnt2,
       (select round(sum(sqrt((x - 3) * (x - 3) + (y - 3) * (y - 3))), 2)
          from t t0
         where t0.id <= t.id) dist1,
       (select round(sum(sqrt((x - t.x) * (x - t.x) + (y - t.y) * (y - t.y))),
                     2)
          from t t0
         where t0.id <= t.id) dist2
  from t
 order by id;