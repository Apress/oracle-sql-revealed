cl col
set pages 100

create table orders(order_id, client_id, product_id, quantity) as 
( 
select 1, 1, 1, 1 from dual 
union all select 1, 1, 2, 2 from dual 
union all select 1, 1, 3, 1 from dual 
union all select 2, 2, 1, 1 from dual 
union all select 2, 2, 5, 1 from dual 
union all select 3, 1, 1, 1 from dual 
union all select 3, 1, 4, 1 from dual 
union all select 3, 1, 4, 1 from dual 
union all select 4, 2, 4, 1 from dual 
union all select 4, 2, 5, 1 from dual 
);

select client_id, product_id, sum(quantity) cnt
  from orders
 group by rollup(client_id, product_id)
 order by client_id, product_id;

select client_id, product_id, sum(quantity) cnt
  from orders
 group by cube(client_id, product_id)
 order by client_id, product_id;

column client_id format a15
column product_id format a15
column slice format a15
 
select decode(grouping(client_id), 1, 'all clients', client_id) as client_id,
       decode(grouping(product_id), 1, 'all products', product_id) as product_id,
       sum(quantity) cnt,
       decode(grouping_id(client_id, product_id),
              bitand(grouping_id(client_id, product_id), bin_to_num(0, 0)),
              'client, product',
              bitand(grouping_id(client_id, product_id), bin_to_num(0, 1)),
              'client',
              bitand(grouping_id(client_id, product_id), bin_to_num(1, 1)),
              'grand total') slice
  from orders
 group by rollup(client_id, product_id)
 order by client_id, product_id;

select decode(grouping(client_id), 1, 'all clients', client_id) as client_id,
       decode(grouping(product_id), 1, 'all products', product_id) as product_id,
       sum(quantity) cnt,
       group_id() group_id
  from orders
 group by grouping sets(client_id, product_id,(),())
 order by client_id, product_id;
 
select client_id, product_id, sum(quantity) cnt, slice
  from (select decode(instr(slice, 'client'), 0, 'all clients', client_id) as client_id,
               decode(instr(slice, 'product'), 0, 'all products', product_id) as product_id,
               quantity,
               slice
          from orders,
               (select 'client, product' slice from dual
                union all select 'client' from dual
                union all select 'grand total' from dual))
 group by client_id, product_id, slice
 order by client_id, product_id;