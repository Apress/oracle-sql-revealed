exec dbms_random.seed(1);

create table transaction(id int not null, value number not null);

insert --+ append
into transaction
select rownum, trunc(1000 * dbms_random.value + 1) value
  from dual
connect by rownum <= 3e6;

create index idx_tran_id on transaction(id);

exec dbms_stats.gather_table_stats(user, 'transaction');