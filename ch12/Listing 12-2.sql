select sum(power(base, level - 1) *
           (instr(:alphabet, substr(:x, -level, 1)) - 1)) num
  from (select length(:alphabet) base from dual)
connect by level <= length(:x);