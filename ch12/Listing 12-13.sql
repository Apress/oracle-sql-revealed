select h0.*,
       nullif(max(rn) over(order by s range between current
                   row and x - 1e-38 following),
              count(*) over()) + 1 next_branch
  from (select h.*,
               power(2 * 10, 1 - l) x,
               sum(power(2 * 10, 1 - l)) over(order by rn) s
          from h) h0;