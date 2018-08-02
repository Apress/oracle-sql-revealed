with t as 
  (select -100 + level - 1 result from dual connect by level <= 201) 
select level - 1 as id, result, connect_by_iscycle cycle
  from t
 start with result = 1
connect by nocycle round(100 * sin(prior result + level - 2)) = result
       and prior sys_guid() is not null
       and level <= 21;