create table phone_call (num varchar2(11), duration int);

exec dbms_random.seed(1);

insert --+ append
into phone_call
  select '01' || to_char(trunc(1e9 * dbms_random.value), 'fm099999999'),
         trunc(dbms_random.value(1, 5 + 1))
    from dual
  connect by level <= 1e6;
  
commit;

exec dbms_stats.gather_table_stats(user, 'phone_call');