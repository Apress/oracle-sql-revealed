set pagesize 0 linesize 90
set echo on

select sql_text||';'from v$sqlarea join v$session using(sql_id) where sid=userenv('sid');

select substr(rpad(1,125,'||chr(39)),26)from
dual;select substr(rpad(1,125,'||chr(39)),26)from
dual;

select
replace('@''[@'||chr(93)||''')from dual;','@',q'[select
replace('@''[@'||chr(93)||''')from dual;','@',q]')from dual;

set echo off