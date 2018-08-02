set pages 100

select t.*, sum(agg) over(order by value) agg_an
  from (select value, count(*) agg, count(*) over() an
          from tt
         group by value) t;
         
select * from table(dbms_xplan.display_cursor(format => 'basic'));
         
/*
select "T"."VALUE" "VALUE",
       "T"."AGG" "AGG",
       "T"."AN" "AN",
       sum("T"."AGG") over(order by "T"."VALUE" range between unbounded preceding and current row) "AGG_AN"
  from (select "TT"."VALUE" "VALUE", count(*) "AGG", count(*) over() "AN"
          from "TT" "TT"
         group by "TT"."VALUE") "T";
*/         

select t.*, sum(agg) over(order by value) agg_an
  from (select value, count(*) agg from tt group by value) t;

select * from table(dbms_xplan.display_cursor(format => 'basic'));

/*
select "TT"."VALUE" "VALUE",
       count(*) "AGG",
       sum(count(*)) over(order by "TT"."VALUE" range between unbounded preceding and current row) "AGG_AN"
  from "TT" "TT"
 group by "TT"."VALUE";
*/