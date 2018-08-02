select * 
   from t3, t1 
 where t3.id = t1.id(+) 
    and nvl2(t1.rowid(+), t3.sign, null) = 1 
 order by 1;