set lines 120 pages 100
alter session set statistics_level = all;

select count(*) cnt_all, count(distinct num) cnt_dist from phone_call;

column area format a35
select *
  from phone_code pc1
  join phone_code pc2
    on pc2.code like pc1.code || '%'
   and pc2.code <> pc1.code
 order by 1, 3;

select length(code) l, count(*) cnt
  from phone_code
 where code like '01%'
 group by length(code)
 order by 1;

select sum(code * sum(duration)) s, count(*) cnt
  from (select ca.rowid,
               num,
               duration,
               max(code) keep(dense_rank first order by length(code) desc) code
          from phone_call ca
          join phone_code co
            on ca.num like co.code || '%'
         group by ca.rowid, num, duration)
 group by code;
 
select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));

select sum(code * sum(duration)) s, count(*) cnt
  from (select ca.rowid,
               num,
               duration,
               max(code) keep(dense_rank first order by length(code) desc) code
          from phone_call ca
         cross join (select rownum + 3 idx from dual connect by rownum <= 3) x
          join phone_code co
            on substr(ca.num, 1, x.idx) = co.code
         group by ca.rowid, num, duration)
 group by code;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));
 
create or replace package phone_pkg is
  type tp_phone_code is table of int index by varchar2(6);
  g_phone_code tp_phone_code;
  function get_code(p_num in varchar2) return varchar2 deterministic;
end phone_pkg;
/
create or replace package body phone_pkg is
  function get_code(p_num in varchar2) return varchar2 deterministic is
    pragma udf;
    l_num varchar2(6);
  begin
    l_num := substr(p_num, 1, 6);
    while (l_num is not null) and (not g_phone_code.exists(l_num)) loop
      l_num := substr(l_num, 1, length(l_num) - 1);
    end loop;
    return l_num;
  end;
begin
  for cur in (select * from phone_code) loop
    g_phone_code(cur.code) := 1;
  end loop;
end phone_pkg;
/

select sum(code * sum(duration)) s, count(*) cnt
  from (select ca.rowid, num, duration, phone_pkg.get_code(num) code
          from phone_call ca
         group by ca.rowid, num, duration)
 group by code;

select *
  from table(dbms_xplan.display_cursor(format => 'IOSTATS LAST'));