select t3.id, v.column_value idx 
   from t3, 
         table(cast(multiset (select rownum 
                           from dual 
                          where rownum <= t3.id 
                         connect by rownum <= t3.id) as sys. 
                         odcinumberlist))(+) v; 

select t3.id, v.column_value idx 
   from t3, 
         table (select cast(collect(rownum) as sys. 
         odcinumberlist) 
                     from dual 
                   where rownum <= t3.id 
                  connect by rownum <= t3.id)(+) v;