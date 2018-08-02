create or replace type strings as table of varchar2(4000) 
/

create or replace function collagg(p in strings) return varchar is
  result varchar2(4000);
begin
  for i in 1 .. p.count loop
    result := result || ', ' || p(i);
  end loop;
  return(substr(result, 3));
end collagg;
/