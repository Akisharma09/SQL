with temp as (
select 1 as n, 1 as fn, 0 as fm
union all
select n+1 as n, fn+fm as fn, fn from temp
where n <= 10
)
select n, fn
from temp
;