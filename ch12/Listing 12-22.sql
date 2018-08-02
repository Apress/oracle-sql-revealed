set timing on

with t0 as
 (select path,
         length(path) - length(replace(path, '/')) - 1 depth,
         substr(path, 1, instr(path, '/', 1, l.id + 1)) token
    from t_path,
         lateral (select rownum id
                    from dual
                  connect by level < length(path) - length(replace(path, '/'))) l),
t1 as
 (select t0.*, min(depth) over(partition by token) m from t0)
select path
  from t1
 group by path, depth
having depth = min (m)
 order by path;

set timing off