select id,
       greatest((select min(id) mid from t3 where t3.id > t.id), 1) m1,
       (select max(mid)
          from (select min(id) mid
                  from t3
                 where t3.id > t.id
                union
                select 1
                  from dual) z) m2,
       (select max(value(v))
          from table(cast(multiset (select min(id) mid
                             from t3
                            where t3.id > t.id
                           union
                           select 1
                             from dual) as sys. odcinumberlist)) v) m3,
       (select max(value(v))
          from table (select cast(collect(mid) as sys. odcinumberlist) col
                        from (select min(id) mid
                                from t3
                               where t3.id > t.id
                              union
                              select 1
                                from dual) z) v) m4,
       (select value(v)
          from table(cast(multiset (select max(mid)
                             from (select min(id) mid
                                     from t3
                                    where t3.id > t.id
                                   union
                                   select 1
                                     from dual) z) as sys.odcinumberlist)) v) m5
  from t3 t
 where t.id = 1;