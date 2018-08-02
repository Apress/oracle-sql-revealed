-- drop table fact_;
-- drop table dim_;

create table fact_ as 
select rownum value, rownum - 1 dim_1_id, rownum dim_2_id
  from dual
connect by rownum <= 1e6;

create table dim_ as 
select rownum id, 'name' || rownum name from dual connect by rownum <= 1e6;