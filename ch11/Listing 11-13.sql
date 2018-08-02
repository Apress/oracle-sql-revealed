create or replace function f_str return strings 
   pipelined is 
   l_min t_str.str%type; 
begin 
   select min(str) into l_min from t_str; 
   pipe row(l_min); 
   while true loop 
     select min(str) into l_min from t_str where str > l_min; 
     if l_min is not null then 
        pipe row(l_min); 
     else 
        return; 
     end if; 
   end loop; 
end f_str; 
/

-- directory UDUMP pointed to udump must exist
-- profilter tables must be created in current schema using dbmshptab.sql
exec dbms_hprof.start_profiling('UDUMP', '1.trc');
select column_value str from table(f_str);
exec dbms_hprof.stop_profiling;
select dbms_hprof.analyze('UDUMP', '1.trc') runid from dual;