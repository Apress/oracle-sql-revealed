column name1 format a10
column value1 format a10
column name2 format a10
column value2 format a10
column name3 format a10
column value3 format a10

select name, x.*
  from (select *
          from (select e.name name, p.name p_name, value
                  from entity e
                  join property p
                    on p.entity_id = e.id)
        pivot xml(max(value) value for p_name in(any))),
       xmltable('/PivotSet' passing p_name_xml
                columns
                  name1 varchar2(30) path '/PivotSet/item[1]/column[@name="P_NAME"]/text()',
                  value1 varchar2(30) path '/PivotSet/item[1]/column[@name="VALUE"]/text()',
                  name2 varchar2(30) path '/PivotSet/item[2]/column[@name="P_NAME"]/text()',
                  value2 varchar2(30) path '/PivotSet/item[2]/column[@name="VALUE"]/text()',
                  name3 varchar2(30) path '/PivotSet/item[3]/column[@name="P_NAME"]/text()',
                  value3 varchar2(30) path '/PivotSet/item[3]/column[@name="VALUE"]/text()') x;