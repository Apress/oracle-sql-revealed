select * from t1 left join t2 on t1.id = t2.id where t1.name = t2.name; 

select * from t1, t2 where t1.id = t2.id(+) and t1.name = t2.name;