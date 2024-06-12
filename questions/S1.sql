with temp as (
select *, count(1) over(partition by site_id  order by reading_datetime asc rows between 2 preceding and 2 following) day_before_after_flag
, round(((sum(temperature) over (partition by site_id order by reading_datetime asc rows between 2 preceding and current row) + sum(temperature) over (partition by site_id order by reading_datetime asc rows between current row and 2 following )
) - (2*temperature) )/4, 4) avg_4_day_temp
from readings
), temp2 as (select site_id, reading_datetime, temperature, avg_4_day_temp, round(((temperature-avg_4_day_temp)/avg_4_day_temp)*100,4) percentage_increase
from temp
where day_before_after_flag = 5
-- order by 1
)
select  site_id, reading_datetime, temperature, avg_4_day_temp, percentage_increase
from temp2 where percentage_increase>= 10
order by site_id, reading_datetime
;