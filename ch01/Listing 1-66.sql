select * 
from fact_ f 
join dim_ d1 on f.dim_1_id = d1.id 
join dim_ d2 on f.dim_2_id = d2.id;