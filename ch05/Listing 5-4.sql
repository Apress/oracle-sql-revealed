select level id from dual connect by level <= 10; 
select rownum id from dual connect by rownum <= 10; 
select rownum id from (select * from dual connect by 1 = 1) 
 where rownum <= 10; 