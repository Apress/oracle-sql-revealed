set lines 110
column name format a30

select pci.runid,
       level depth,
       rpad(' ', (level - 1) * 3, ' ') || fi.function as name,
       fi.subtree_elapsed_time,
       fi.function_elapsed_time,
       fi.calls
  from (select runid, parentsymid, childsymid
          from dbmshp_parent_child_info
        union all
        select runid, null, 2
          from dbmshp_runs) pci
  join dbmshp_function_info fi
    on pci.runid = fi.runid
   and pci.childsymid = fi.symbolid
   and fi.function <> 'STOP_PROFILING'
connect by prior childsymid = parentsymid
       and prior pci.runid = pci.runid
 start with pci.parentsymid is null
        and pci.runid in (1);