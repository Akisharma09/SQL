with temp as (
select user_id
, event_datetime
, event_type
, row_number() over(partition by user_id order by event_datetime asc) as rn
from events
), lf as (
select user_id
, event_datetime
, row_number() over(partition by user_id order by event_datetime asc) rn_lf
from events
where event_type = 'login failed'
), temp2 as (
select temp.user_id, temp.rn, lf.rn_lf, temp.rn - lf.rn_lf grp_id
from temp inner join lf on (temp.user_id = lf.user_id and temp.event_datetime = lf.event_datetime)
), sol as (
select user_id, grp_id, count(1) cnt from temp2
group by user_id, grp_id
)
select user_id, max(cnt) from sol
where cnt>=5
group by user_id
;