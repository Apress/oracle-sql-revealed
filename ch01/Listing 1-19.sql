create table t3 as select rownum - 1 id, mod(rownum, 2) sign from dual connect by level <= 3; 

select *
  from t3
  left join t1
    on t1.id = t3.id
 order by t3.id;

select *
  from t3
  left join t1
    on t1.id = t3.id
   and t1.id = 1
 order by t3.id;

select *
  from t3
  left join t1
    on t1.id = t3.id
 where t1.id = 1
 order by t3.id;

select *
  from t3, t1
 where t1.id(+) = t3.id
   and t1.id(+) = 1
 order by t3.id;

select *
  from t3, t1
 where t1.id(+) = t3.id
   and t1.id = 1
 order by t3.id;
