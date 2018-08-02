select level lvl, graph.*, connect_by_iscycle cycle
  from graph
 start with id_parent = 1
connect by nocycle prior id = id_parent
       and prior id_parent is not null;