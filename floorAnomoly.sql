/*START Table structure and values */

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('A','Bangalore','A@gmail.com',1,'CPU');
Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('A','Bangalore','A1@gmail.com',1,'CPU');
Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('A','Bangalore','A2@gmail.com',2,'DESKTOP');
Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('B','Bangalore','B@gmail.com',2,'DESKTOP');
Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('B','Bangalore','B1@gmail.com',2,'DESKTOP');
Insert into ENTRIES (NAME,ADDRESS,EMAIL,FLOOR,RESOURCES) values ('B','Bangalore','B2@gmail.com',1,'MONITOR');

/*END Table structure and values */

--SOLUTION

with distinct_res as (
select distinct name , RESOURCES from entries
),
res_agg as (
select name, listagg(RESOURCES, ', ') within group(order by RESOURCES) as resource_list from distinct_res
group by name
),
floor as (
SELECT NAME, FLOOR, rank() over (partition by name order by count(1) desc ) as rn 
FROM entries
GROUP BY NAME, floor
)
, MAX_FLOOR AS ( 
select NAME,FLOOR AS MAX_FLOOR from floor
where rn = 1
)
, TOTAL_VISIT AS 
(SELECT NAME, COUNT(1) AS TOTAL_VISITS FROM entries GROUP BY NAME)
select TV.NAME, TV.TOTAL_VISITS, MF.MAX_FLOOR, RA.resource_list 
FROM TOTAL_VISIT TV
INNER JOIN MAX_FLOOR MF
ON (TV.NAME = MF.NAME)
INNER JOIN res_agg RA
ON (RA.NAME = TV.NAME)
;
