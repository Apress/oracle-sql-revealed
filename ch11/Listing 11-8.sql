create or replace type to_id_value as object(id int, value number)
/
create or replace type tt_id_value as table of to_id_value
/
create or replace function f_transaction(p_limit in number)
  return tt_id_value
  pipelined is
  l_limit number := 0;
begin
  for i in (select --+ index_desc(transaction idx_tran_id)
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