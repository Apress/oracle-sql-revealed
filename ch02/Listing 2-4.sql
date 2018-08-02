set lines 120
column feature format a20
column feature_path format a34
column description format a15

with sql_feature as
 (select lpad(' ', (level - 1) * 2) || replace(f.sql_feature, 'QKSFM_', '') feature,
         sys_connect_by_path(replace(f.sql_feature, 'QKSFM_', ''), '->') feature_path,
         f.description
    from v$sql_feature f, v$sql_feature_hierarchy fh
   where f.sql_feature = fh.sql_feature
  connect by fh.parent_id = prior f.sql_feature
   start with fh.sql_feature = 'QKSFM_ALL')
select *
  from sql_feature
 where lower(replace(description, '-', ' ')) like 'or %';