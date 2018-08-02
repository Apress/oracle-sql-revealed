select t3.id, v.idx 
   from t3, 
         lateral (select rownum idx 
                       from dual 
                      where rownum <= t3.id 
                     connect by rownum <= t3.id)(+) v; 

select t3.id, v.idx 
   from t3 
 outer apply (select rownum idx 
                     from dual 
                   where rownum <= t3.id 
                  connect by rownum <= t3.id) v;