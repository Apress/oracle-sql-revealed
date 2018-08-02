select t3.id,
       (select count(t2.rowid) + decode(sign(t3.id), 1, count(t1.rowid), 0)
          from t2
          left join t1
            on t2.id = t1.id
         where t2.id = t3.id) x
  from t3
 order by t3.id;