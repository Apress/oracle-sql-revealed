set pages 100

select ts,
       amount,
       count(decode(cls, 'STRT', 1)) over(order by ts) match,
       cls
  from (select ts,
               amount,
               case
                 when lag(cls) over(order by ts) = 'UP' and cls <> 'UP' then
                  'STRT'
                 else
                  cls
               end cls
          from (select atm.*,
                       nvl(case
                             when amount < lag(amount) over(order by ts) then
                              'DOWN'
                             when amount > lag(amount) over(order by ts) then
                              'UP'
                           end,
                           'STRT') cls
                  from atm))
 order by ts;