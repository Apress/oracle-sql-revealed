with t as (select 0 id from dual) 
select * 
from t 
model 
dimension by (id) 
measures ((1+2)/2 x, 1 x0, 2 x1) 
rules iterate (1e2) until abs(x[0]-previous(x[0])) < 1e-2 
  ( 
    x[iteration_number+1] = x[0], 
    x0[iteration_number+1] = case when sign(y(x[0])) = 
                                             sign(y(x0[iteration_number])) 
                                             then x[0] 
                                             else x0[iteration_number] 
                                        end, 
    x1[iteration_number+1] = case when sign(y(x[0])) = 
                                             sign(y(x1[iteration_number])) 
                                             then x[0] 
                                             else x1[iteration_number] 
                                        end, 
    x[0] = (x0[iteration_number+1] + x1[iteration_number+1])/2 
) 
order by id;