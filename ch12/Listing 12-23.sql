set timing on

select path
  from (select t1.*,
               min(nvl2(p2, 1, 0)) over(partition by p1) m2,
               min(nvl2(p3, 1, 0)) over(partition by p1, p2) m3,
               min(nvl2(p4, 1, 0)) over(partition by p1, p2, p3) m4,
               min(nvl2(p5, 1, 0)) over(partition by p1, p2, p3, p4) m5
          from (select path,
                       substr(path, i1, i2 - i1) p1,
                       substr(path, i2, i3 - i2) p2,
                       substr(path, i3, i4 - i3) p3,
                       substr(path, i4, i5 - i4) p4,
                       substr(path, i5, i6 - i5) p5
                  from (select path,
                               instr(path, '/', 1, 1) i1,
                               instr(path, '/', 1, 2) i2,
                               instr(path, '/', 1, 3) i3,
                               instr(path, '/', 1, 4) i4,
                               instr(path, '/', 1, 5) i5,
                               instr(path, '/', 1, 6) i6
                          from t_path) t0) t1)
 where not (m2 = 0 and p2 is not null or m3 = 0 and p3 is not null or
        m4 = 0 and p4 is not null or m5 = 0 and p5 is not null);

set timing off