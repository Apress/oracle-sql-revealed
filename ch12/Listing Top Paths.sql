set timing on

select *
from t_path
match_recognize
(
  order by path
  measures
    first(path) path
  one row per match
  pattern(x+)
  define
    x as path like first(path) || '%'
) mr;

set timing off