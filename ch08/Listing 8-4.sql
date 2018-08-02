exec dbms_random.seed(1);
create table digit as
select rownum id, trunc(dbms_random.value(0, 9 + 1)) value
  from dual
connect by rownum <= 2e6;

select decode(v_id, v1_id, 1, v2_id, 2, v3_id, 3) v1,
       decode(v_id + 1, v1_id, 1, v2_id, 2, v3_id, 3) v2,
       decode(v_id + 2, v1_id, 1, v2_id, 2, v3_id, 3) v3,
       count(*) cnt
  from digit
match_recognize
( order by id
  measures
    least(v1.id, v2.id, v3.id) v_id,
    (v1.id) v1_id,
    (v2.id) v2_id,
    (v3.id) v3_id
  one row per match
  after match skip to next row
  pattern (permute (v1, v2, v3)) 
  define 
    v1 as v1.value = 1, 
    v2 as v2.value = 2, 
    v3 as v3.value = 3) 
 group by decode(v_id, v1_id, 1, v2_id, 2, v3_id, 3), 
          decode(v_id + 1, v1_id, 1, v2_id, 2, v3_id, 3), 
          decode(v_id + 2, v1_id, 1, v2_id, 2, v3_id, 3) 
 order by 1, 2, 3;