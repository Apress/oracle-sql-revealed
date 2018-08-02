select tt1.name, tt2.name, tt3.name 
   from tt1, tt2, tt3 
 where tt2.name(+) like '%' || tt1.name || '%' 
    and tt3.name(+) like '%' || tt2.name || '%' 
    and tt2.name is not null;

select tt1.name, tt2.name, tt3.name 
   from tt1, tt2, tt3 
 where tt2.name(+) like '%' || tt1.name || '%' 
    and tt3.name(+) like '%' || tt2.name || '%' 
    and tt2.name(+) is not null;