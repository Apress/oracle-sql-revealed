with t as (select 'abcd c*de 01' s from dual)
select i, s
from t
model
dimension by (0 rn)
measures (length(s) n, 1 j, 1 k, 1 x, 1 i, 0 c, s)
rules iterate(1e9) until x[0]=0
(
  i[0] = i[0] + 1,
  c[0] = case when substr(s[0], j[0] + 1, 1) < substr(s[0], j[0], 1)
              then 1
              else case when j[0] = 1 then 0 else c[0] end
         end,
  s[0] = case when substr(s[0], j[0] + 1, 1) < substr(s[0], j[0], 1)
              then substr(s[0], 1, j[0] - 1) || substr(s[0], j[0] + 1, 1) ||
                   substr(s[0], j[0], 1) || substr(s[0], j[0] + 2)
              else s[0]
         end,
  x[0] = case when j[0] = n[0] - k[0] and c[0] = 0 then 0 else 1 end,
  k[0] = case when j[0] = n[0] - k[0] then k[0] + 1 else k[0] end,
  j[0] = case when j[0] - 1 = n[0] - k[0] then 1 else j[0] + 1 end
);