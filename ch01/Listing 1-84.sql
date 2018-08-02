select t3.id,
       (select count(t2.rowid) + count(tt.column_value)
          from t2
          left join table(cast(multiset (select nvl2(t2.rowid, 1, null)
                                          from t1
                                         where t2.id = t1.id
                                           and t3.id > 0) as numbers)) tt
            on 1 = 1
         where t2.id = t3.id) x
  from t3
 order by t3.id;