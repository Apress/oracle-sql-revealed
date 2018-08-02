set pages 100

exec dbms_random.seed(11); 

create table atm as 
select trunc(sysdate) + (2 * rownum - 1) / (24 * 60) ts,
       trunc(dbms_random.value(1, 20 + 1)) * 5 amount
  from dual
connect by level <= 15;

select to_char(ts, 'mi') minute,
       amount,
       count(nullif(sign(amount - 50), -1)) over(order by ts rows 5 preceding) cnt1,
       count(nullif(sign(amount - 50), -1)) over(order by ts range interval '5' minute preceding) cnt2
  from atm;