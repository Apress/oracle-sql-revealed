alter session set events 'trace[rdbms.SQL_Optimizer.*]'; 
alter session set events '10053 trace name context forever, level 1';