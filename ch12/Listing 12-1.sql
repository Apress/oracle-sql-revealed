var x varchar2(30) 
var alphabet varchar2(30) 
exec :alphabet := '0123456789ABCDEF'; 

exec :x := '1A0A'; 

select to_number(:x, 'XXXX') num from dual;