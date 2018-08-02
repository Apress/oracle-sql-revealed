create or replace type to_node as object (name varchar2(30), lvl  number)
/
create or replace type tt_node as table of to_node
/

create or replace function f_traverse return tt_node is
  result  tt_node;
  current tt_node;
  tmp     tt_node;
  lvl     int := 1;
begin
  select to_node(referenced_name, lvl)
    bulk collect
    into current
    from (select distinct referenced_name
            from d
           where not exists
           (select null from d d_in where d_in.name = d.referenced_name));
  result := current;
  while true loop
    lvl := lvl + 1;
    select to_node(name, lvl)
      bulk collect
      into tmp
      from (select distinct d1.name
              from d d1
              join table(current) cur
                on d1.referenced_name = cur.name
            -- add only nodes without unvisited children
             where not exists (select null
                      from d d2
                      left join table(result) r
                        on d2.referenced_name = r.name
                     where d1.name = d2.name
                       and r.name is null));
    if tmp.count = 0 then
      return result;
    else
      result  := result multiset union all tmp;
      current := tmp;
    end if;
  end loop;
end f_traverse;
/

select * from table(f_traverse) order by 2, 1;

drop table d;

create table d as
select decode(type, 'to', 'x' || to_char(x + 1), 'n' || x || y) name,
       decode(type, 'to', 'n' || x || y, 'x' || x) referenced_name
  from (select to_char(trunc((rownum - 1) / 7) + 1) x,
               to_char(mod(rownum, 7) + 1) y
          from dual
        connect by level <= 8 * 7) n,
       (select 'from' type from dual union all select 'to' from dual);

select * from table(f_traverse) order by 2, 1;