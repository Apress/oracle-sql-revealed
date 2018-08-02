create table phone_code as 
with tbl as
 (select regexp_substr(httpuritype('http://www.area-codes.org.uk/full-uk-area-code-list.php').getclob(),
                       '<table class="info">.*?</table>',
                       1,
                       1,
                       'n') c
    from dual)
select *
  from xmltable('/table/tr' passing xmltype((select c from tbl))
                columns
                  code varchar2(6) path '/tr/td[1]',
                  area varchar2(50) path '/tr/td[2]')
 order by 1;
 
exec dbms_stats.gather_table_stats(user, 'phone_call');