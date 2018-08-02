set lines 100

select tt.*,
       decode(frn, crn, frn_value, (crn - rn) * frn_value + (rn - frn) * crn_value) percentile
  from (select t.ord,
               t.value,
               t.rn,
               t.frn,
               t.crn,
               max(decode(rnum, frn, v)) frn_value,
               max(decode(rnum, crn, v)) crn_value
          from (select t1.*,
                       t2.value v,
                       row_number() over(partition by t1.ord order by t2.value) rnum,
                       1 + 0.3 * (count(*) over(partition by t1.ord) - 1) rn,
                       floor(1 + 0.3 * (count(*) over(partition by t1.ord) - 1)) frn,
                       ceil(1 + 0.3 * (count(*) over(partition by t1.ord) - 1)) crn
                  from flow t1
                  join flow t2
                    on t2.ord between t1.ord and t1.ord + 4) t
         group by t.ord, t.value, t.rn, t.frn, t.crn) tt
 order by tt.ord;