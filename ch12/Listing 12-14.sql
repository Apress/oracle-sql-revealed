set lines 140

select h0.*,
       count(*) over(order by s range between 1e-38 following and x - 1e-38 following) cnt_children,
       sum(amount) over(order by s range between current row and x - 1e-38 following) h_sum
  from (select h.*,
               power(2 * 10, 1 - l) x,
               sum(power(2 * 10, 1 - l)) over(order by rn) s
          from h) h0;
          
select *
  from (select h.*, power(2 * 10, 1 - l) x from h)
match_recognize
(
  order by rn
  measures
    first (id) as id,
    first (parent_id) as parent_id,
    first (l) as l,
    first (rn) as rn,
    final count(*)-1 cnt_children,
    final sum(amount) h_sum
  one row per match
  after match skip to next row
  pattern (y+)
  define
    y as sum(x) < 2 * first(x)
) mr;

select *
  from (select h.*,
               power(2 * 10, 1 - l) x,
               sum(power(2 * 10, 1 - l)) over(order by rn) s
          from h) h0
match_recognize
(
  order by rn
  measures
    final count(*)-1 cnt_children,
    final sum(amount) h_sum,
    count(*) cnt
  all rows per match
  after match skip to next row
  pattern (y+)
  define
    y as max(s) - min(s) < first(x)
) mr
where cnt = 1;

column cls format a15

select *
  from h
match_recognize
(
  order by rn
  measures
    classifier() cls,
    first (id) as id,
    first (parent_id) as parent_id,
    first (l) as l,
    first (rn) as rn,
    first (amount) as amount,
    final count(child.*) cnt_children,
    final sum(amount) h_sum
  one row per match
  after match skip to next row
  pattern (strt child+|no_children)
  define
    child as child.l > strt.l
) mr;          