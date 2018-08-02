create table week(id, day) as 
select rownum,
       to_char(trunc(sysdate, 'd') + level - 1,
               'fmday',
               'NLS_DATE_LANGUAGE = English')
  from dual
connect by rownum <= 7;

create table presentation(name, day, time) as 
select 'John', 'monday', '14' from dual 
union all 
select 'John', 'monday', '9' from dual 
union all 
select 'John', 'friday', '9' from dual 
union all 
select 'Rex', 'wednesday', '11' from dual 
union all 
select 'Rex', 'friday', '11' from dual;