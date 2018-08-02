with rec as 
( 
anchor_query_text - anchor member 
union all
recursive_query_text – recursive member referencing rec 
) 
select * 
from rec