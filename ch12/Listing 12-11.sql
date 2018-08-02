set lines 120

select ttt.*,
       decode(frn, crn, frn_value, (crn - rn) * frn_value + (rn - frn) * crn_value) percentile
  from (select tt.*,
               nth_value(value, ord + frn - 1) over(order by ord range between unbounded preceding and unbounded following) frn_v,
               nth_value(value, ord + crn - 1) over(order by ord range between unbounded preceding and unbounded following) crn_v,
               last_value(value) over(order by ord range between frn - 1 following and frn - 1 following) frn_value,
               last_value(value) over(order by ord range between crn - 1 following and crn - 1 following) crn_value
          from (select t.*, floor(rn) frn, ceil(rn) crn
                  from (select t0.*,
                               1 + 0.3 * (count(*) over(order by ord range between current row and 4 following) - 1) rn
                          from flow t0) t) tt) ttt;