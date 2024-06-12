--Q: Write a query to swap 1 with 2 , 3 with 4 and since we don't have 6 5 will remain as it is.
--input
--seat_id, name
--1, akshay
--2, dilawar
--3, chandana
--4, uddesh
--5, hassan
--
--output
--seat_id, name
--1, dilawar
--2, akshay
--3, uddesh
--4, chandana
--5, hassan

-- table script
create table seat_swap as
select 1 as seat_id, 'akshay' as name
union all
select 2 as seat_id, 'dilawar' as name
union all
select 3 as seat_id, 'chandana' as name
union all
select 4 as seat_id, 'uddesh' as name
union all
select 5 as seat_id, 'hassan' as name
;
