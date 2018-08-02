create table h as
with t(id, parent_id, description, amount) as
(
  select 1 id, null, 'top', 10  from dual
  union all select 2, 1, 'top-one', 100 from dual
  union all select 3, 2, 'one-one', 2000 from dual
  union all select 4, 2, 'one-two', 3000 from dual
  union all select 5, 1, 'top-two', 1000 from dual
  union all select 6, 2, 'one-three', 300 from dual
  union all select 7, 6, 'three-one', 1 from dual
)
  select id, parent_id, description, amount, level l, rownum rn
    from t
   start with id = 1
 connect by parent_id = prior id;

select h.*,
       (select min(rn)
          from h h0
         where h0.rn > h.rn
           and h0.l <= h.l) next_branch
  from h;

select *
from h
model
dimension by (l, rn)
measures (id, parent_id, rn xrn, 0 next_branch)
rules
(
  next_branch[any, any] order by rn, l =
    min(xrn)[l <= cv(l), rn > cv(rn)]
);

select *
  from h
model
dimension by (rn)
measures (id, parent_id, l, 0 l_cur, rn xrn, 0 next_branch)
rules iterate (1e6) until l[iteration_number+2] is null
(
  l_cur[rn > iteration_number + 1] = l[iteration_number + 1],
  next_branch[iteration_number + 1] =
    min(case when l <= l_cur then xrn end)[rn > cv(rn)]
)
order by rn;