create or replace type to_fact_a as object
(
  dt            date,
  dim_1_id      number,
  dim_2_id      number,
  value         number,
  dim1_sum      number,
  dim2_sum      number,
  dim1_dim2_sum number
)
/
create or replace type tt_fact_a as table of to_fact_a
/
create or replace function f_fact_a return tt_fact_a
  pipelined is
  type tt1 is table of number index by pls_integer;
  type tt2 is table of tt1 index by pls_integer;
  l_dim1  tt1;
  l_dim2  tt1;
  l_dim12 tt2;
begin
  for r in (select /*+ lvl 0 */
             dt, dim_1_id, dim_2_id, value
              from fact_a
             order by dt) loop
     -- NoFormat Start
     l_dim1(r.dim_1_id) := case
                             when l_dim1.exists(r.dim_1_id)
                             then l_dim1(r.dim_1_id)
                             else 0
                           end + r.value;
     l_dim2(r.dim_2_id) := case
                             when l_dim2.exists(r.dim_2_id)
                             then l_dim2(r.dim_2_id)
                             else 0
                           end + r.value;
    l_dim12(r.dim_1_id)(r.dim_2_id) :=
     case
       when l_dim12.exists(r.dim_1_id)
        and l_dim12(r.dim_1_id).exists(r.dim_2_id)
       then l_dim12(r.dim_1_id)(r.dim_2_id)
       else 0
     end + r.value;
     -- NoFormat End
    pipe row(to_fact_a(r.dt,
                       r.dim_1_id,
                       r.dim_2_id,
                       r.value,
                       l_dim1(r.dim_1_id),
                       l_dim2(r.dim_2_id),
                       l_dim12(r.dim_1_id) (r.dim_2_id)));
  end loop;
end;
/

alter session set plsql_optimize_level = 0;
alter function f_fact_a compile;

set timing on

select to_char(sum(dim1_sum), lpad('9', 20, '9')) d1,
       to_char(sum(dim2_sum), lpad('9', 20, '9')) d2,
       to_char(sum(dim1_dim2_sum), lpad('9', 20, '9')) d12
  from table(f_fact_a)
 order by dt;
 
create or replace function f_fact_a return tt_fact_a
  pipelined is
  type tt1 is table of number index by pls_integer;
  type tt2 is table of tt1 index by pls_integer;
  l_dim1  tt1;
  l_dim2  tt1;
  l_dim12 tt2;
begin
  for r in (select /*+ lvl 2 */
             dt, dim_1_id, dim_2_id, value
              from fact_a
             order by dt) loop
     -- NoFormat Start
     l_dim1(r.dim_1_id) := case
                             when l_dim1.exists(r.dim_1_id)
                             then l_dim1(r.dim_1_id)
                             else 0
                           end + r.value;
     l_dim2(r.dim_2_id) := case
                             when l_dim2.exists(r.dim_2_id)
                             then l_dim2(r.dim_2_id)
                             else 0
                           end + r.value;
    l_dim12(r.dim_1_id)(r.dim_2_id) :=
     case
       when l_dim12.exists(r.dim_1_id)
        and l_dim12(r.dim_1_id).exists(r.dim_2_id)
       then l_dim12(r.dim_1_id)(r.dim_2_id)
       else 0
     end + r.value;
     -- NoFormat End
    pipe row(to_fact_a(r.dt,
                       r.dim_1_id,
                       r.dim_2_id,
                       r.value,
                       l_dim1(r.dim_1_id),
                       l_dim2(r.dim_2_id),
                       l_dim12(r.dim_1_id) (r.dim_2_id)));
  end loop;
end;
/

alter session set plsql_optimize_level = 2;
alter function f_fact_a compile;

select to_char(sum(dim1_sum), lpad('9', 20, '9')) d1,
       to_char(sum(dim2_sum), lpad('9', 20, '9')) d2,
       to_char(sum(dim1_dim2_sum), lpad('9', 20, '9')) d12
  from table(f_fact_a)
 order by dt;

set timing off 
column hint format a15

select regexp_substr(sql_text, '/.*/') hint,
       executions,
       fetches,
       rows_processed
  from v$sql s
 where sql_text like '%FROM FACT_A%'
   and sql_text not like '%v$sql%';