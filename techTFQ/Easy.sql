create database techTFQEasy ; 

use techtfqeasy ;

/*
1. How to remove Duplicate Data in SQL | SQL Query to remove duplicates
   Scenario 1 - Data duplicated based on SOME of the columns
   Requirement: Delete duplicate data from cars table. Duplicate record is identified based on the model and brand name.
*/

create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);

insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);
insert into cars values (7, 'Model S', 'Tesla', 'White', 2017);

select * from cars
order by model, brand;

-- 1. Delete using unique identifier but this doesn't work in mysql as del table shouhld not be same as select table
-- will not work on multiple dup records say dup rec > 2
select * -- delete
	from 
cars where id in (
select 
    max(id)
from cars
group by model,brand
having count(*) > 1 ) ;


-- 2. Using self join but this doesn't work in mysql as del table shouhld not be same as select table
-- works on multiple dup records
-- delete from cars where id in (
select c2.id 
-- c1.*, 
-- c2.* 
from cars c1 join cars c2
on c1.model = c2.model and c1.brand = c2.brand 
where c1.id < c2.id ;
-- ) ;


-- 3. Using window function but this doesn't work in mysql as del table shouhld not be same as select table
-- works on multiple dup records
delete from cars where id in (
select id from
(
select
	*,
    row_number() over (partition by model, brand) rn
from cars ) tmp
where tmp.rn > 1 ) ;



-- 4. Get the original record first using min function and keep these del rest but this doesn't work in mysql as del table shouhld not be same as select table
-- will delete multiple records 
delete from cars where id not in (
select 
	min(id)
from cars
group by model,brand ) ;


-- 5. By creating a backup table
-- Scenario 2 - Data duplicated based on ALL of the columns
-- Requirement: Requirement: Delete duplicate entry for a car in the CARS table.

create table cars_bkp 
as
select * from cars where 1=2;

insert into cars_bkp
select * from cars where id in (
select 
	min(id)
from cars
group by model,brand
);
drop table cars_bkp ;
-- below not recommended in prod as cars table might be used by other apps
-- once insert stmt is success 
-- drop table cars
-- alter table cars_bkp rename to cars



-- 6. Using backup table without dropping the original table
create table cars_bkp 
as
select * from cars where 1=2;

insert into cars_bkp
select * from cars where id in (
select 
	min(id)
from cars
group by model,brand
);

-- truncate table cars ;

insert into cars 
select * from cars_bkp ;

-- drop table cars_bkp ;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

/*
-->> Problem Statement:
Suppose you have a car travelling certain distance and the data is presented as follows -
row1 : Day 1 - 50 km
row2 : Day 2 - 100 km
row3 : Day 3 - 200 km

Now the distance is a cumulative sum as in
    row2 = (kms travelled on that day + row1 kms).

How should I get the table in the form of kms travelled by the car on a given day and not the sum of the total distance?
*/

drop table car_travels;
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);
insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels;

select 
	*,
    cumulative_distance - lag(cumulative_distance,1,0) over (partition by cars order by days) as true_distance
from car_travels ;
