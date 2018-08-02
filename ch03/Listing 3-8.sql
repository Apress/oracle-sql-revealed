set lines 120

create table stream as 
select batch_id, value
  from (select rownum value from dual connect by rownum <= 10000) x1,
       (select rownum batch_id from dual connect by level <= 1000)
 order by 1, 2;

create index stream_batch_id_idx on stream(batch_id); 

exec dbms_stats.gather_table_stats(user, 'stream'); 
alter session set statistics_level = all; 

select sum(s.value)
  from stream s
 where batch_id = (select max(s0.batch_id) from stream s0);
select * from table(dbms_xplan.display_cursor(null, null, 'IOSTATS LAST'));

select sum(value)
  from (select s.*, dense_rank() over(order by batch_id) drnk from stream s)
 where drnk = 1;
select * from table(dbms_xplan.display_cursor(null, null, 'IOSTATS LAST'));