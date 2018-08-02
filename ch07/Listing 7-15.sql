with points as
 (select rownum id, rownum * rownum x, mod(rownum, 3) y
    from dual
  connect by rownum <= 6)
select *
from points
model
dimension by (id)
measures (id i, x, y, 0 x_cur, 0 y_cur, 0 dist2)
rules iterate (1e6) until i[iteration_number+2] is null
(
  x_cur[any] = x[iteration_number + 1],
  y_cur[any] = y[iteration_number + 1],
  dist2[iteration_number + 1] =
  round(sum(sqrt((x - x_cur) * (x - x_cur) +
                 (y - y_cur) * (y - y_cur)))[id <= cv(id)], 2)
)
order by id;