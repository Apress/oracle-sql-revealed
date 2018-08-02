create table t (part int, id int, value int);

begin 
   for i in 1 .. 80 loop 
     dbms_random.seed(i); 
     insert into t 
        select i, rownum id, trunc(dbms_random.value(1, 1000 + 1)) 
        value 
          from dual 
        connect by rownum <= 1e5; 
   end loop; 
   commit; 
end; 
/

select count(distinct sid) c, sum(x*part) s 
  from
(
    select --+ parallel(2)
    * 
    from t 
    model 
    partition by (part) 
    dimension by (id) 
    measures (value, 0 x, 0 sid) 
    rules 
    ( 
       x[any] order by id = case when cv(id)=1 then value[cv(id)] 
                                 when x[cv(id)-1] > 3e3 then value[cv(id)] 
                                 else x[cv(id)-1] + value[cv(id)] 
                            end, 
       sid[any] order by id = userenv('sid') 
    )
);