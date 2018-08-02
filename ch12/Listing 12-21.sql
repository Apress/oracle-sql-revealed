set timing on

select t_path.path
  from t_path
  left join t_path t_top
    on t_path.path like t_top.path || '%_/'
 where t_top.path is null;

select path
  from t_path
 where not exists (select null
          from t_path t_top
         where t_path.path like t_top.path || '%_/');

set timing off