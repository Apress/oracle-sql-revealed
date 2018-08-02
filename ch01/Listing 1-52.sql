select t1.*, 
         l.* 
   from t1, 
         table(cast(multiset (select id 
                          from t3 
                         start with t3.id = t1.id 
                       connect by prior t3.id + 1 = t3.id) as 
                       numbers)) l; 

select t1.*, l.* 
   from t1, 
         table (select cast(collect(id) as numbers) 
                    from t3 
                   start with t3.id = t1.id 
                 connect by prior t3.id + 1 = t3.id) l; 

select t1.*, l.* 
   from t1, 
         lateral (select id 
                      from t3 
                     start with t3.id = 0 -- t1.id 
                    connect by prior t3.id + 1 = t3.id) l;