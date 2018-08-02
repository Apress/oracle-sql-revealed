select connect_by_root id_parent root,
       level lvl,
       rpad(' ', (level - 1) * 3, ' ') || t.id as id,
       prior id_parent grand_parent,
       sys_connect_by_path(id, '->') path,
       connect_by_isleaf is_leaf
  from tree t
 start with t.id_parent in (1, 10)
connect by prior t.id = t.id_parent
 order siblings by t.id desc;

/*

      ROOT        LVL ID              GRAND_PARENT PATH               IS_LEAF
---------- ---------- --------------- ------------ --------------- ----------
        10          1 11                           ->11                     0
        10          2    13                     10 ->11->13                 1
        10          2    12                     10 ->11->12                 1
         1          1 3                            ->3                      0
         1          2    4                       1 ->3->4                   0
         1          3       5                    3 ->3->4->5                1
         1          1 2                            ->2                      1

7 rows selected.

*/