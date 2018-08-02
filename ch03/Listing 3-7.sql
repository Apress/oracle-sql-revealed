column list_ord format a10
column dist_ord format a10
column cumul format a10
column dist format a10
column cumul_dist format a10
column cumul_ord format a10

with t as
 (select rownum id, column_value value
    from table(sys.odcinumberlist(2, 1, 1, 3, 1))),
t0 as
 (select t.*, row_number() over(partition by value order by id) rn from t)
select t1.*,
       (select listagg(value, ',') within group(order by value)
          from t t_in
         where t_in.id <= t1.id) cumul_ord
  from (select t0.*,
               listagg(value, ',') within group(order by value) over() list_ord,
               listagg(decode(rn, 1, value), ',') within group(order by value) over() dist_ord,
               stragg(value) over(order by id) cumul,
               stragg(distinct value) over() dist,
               stragg(decode(rn, 1, value)) over(order by id) cumul_dist
          from t0) t1
 order by id;