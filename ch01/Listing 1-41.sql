create table tt1 as select 'name' || rownum name from dual connect by level <= 3; 
create table tt2 as select 'x_name' || rownum name from dual connect by level <= 2; 
create table tt3 as select 'y_x_name' || rownum name from dual; 

select tt1.name, tt2.name, tt3.name 
   from tt1 
   left join tt2 
     on tt2.name like '%' || tt1.name || '%' 
   left join tt3 
     on tt3.name like '%' || tt2.name || '%' 
    and tt2.name is not null; 