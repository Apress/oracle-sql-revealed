select t3.id,
       (select count(t2.rowid) + count(t1.rowid)
          from t2, t1
         where t2.id = t3.id
           and t2.id = t1.id(+)
           and decode(sign(t3.id), 1, 0) = nvl2(t1.id(+), 0, 0)) x
  from t3
 order by t3.id;