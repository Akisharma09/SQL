with temp as (
select seat_id, name , row_number() over(order by seat_id asc) as rn
from seat_swap
), even as (
select t1.seat_id, t2.name from seat_swap t1
left join seat_swap t2
on (t1.seat_id = t2.seat_id+1)
where mod(t1.seat_id,2) = 0
), odd as (
select t1.seat_id, coalesce(t2.name, t1.name) from seat_swap t1
left join seat_swap t2
on (t1.seat_id = t2.seat_id-1)
where mod(t1.seat_id,2) <> 0
)
select * from even
union all
select * from odd
order by 1
;