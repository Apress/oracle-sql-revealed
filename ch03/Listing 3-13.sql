select min(value) keep(dense_rank last order by dt) over(partition by part) m2,
       last_value(value) over(partition by part order by dt, value desc rows between unbounded preceding and unbounded following) m3
  from t
 order by id;