create or replace function f_transaction(p_limit in number)
  return tt_id_value
  pipelined is
  l_limit number := 0;
begin
  for i in (select --+ index_desc(transaction idx_tran_id) zzz
             *
              from transaction
             order by id desc) loop
    l_limit := l_limit + i.value;
    if l_limit <= 5000 then
      pipe row(to_id_value(i.id, i.value));
    else
      exit;
    end if;
  end loop;
end f_transaction;
/

alter session set plsql_optimize_level = 0;
alter function f_transaction compile;

select * from table(f_transaction(p_limit => 5000));

column sql_text format a50
select executions, rows_processed, sql_text
  from v$sql v
 where sql_text like '%index_desc(transaction idx_tran_id) zzz%'
   and sql_text not like '%v$sql%';