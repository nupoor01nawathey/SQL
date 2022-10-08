use techtfqmedium;

-- Query 1 Write a SQL query to fetch all the duplicate records from a table.
drop table users;
create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

select * from users;

with cte as
( select
	*,
    row_number() over (partition by user_name) as rn
from users ) 
select * from cte where rn > 1;

select *
from (
	select 
		*,
		row_number() over (partition by user_name order by user_id) as rn
	from users u
	order by user_id) x
where x.rn > 1;



-- 2. Write a SQL query to fetch the second last record from employee table

drop table employee;
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values
(101, 'Mohan', 'Admin', 4000),(102, 'Rajkumar', 'HR', 3000),(103, 'Akbar', 'IT', 4000),(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),(106, 'Rajesh',  'Finance', 5000),(107, 'Preet', 'HR', 7000),(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),(110, 'Vasudha', 'IT', 7000),(111, 'Melinda', 'IT', 8000),(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),(114, 'Manisha', 'HR', 3000),(115, 'Chandni', 'IT', 4500),(116, 'Satya', 'Finance', 6500),
(117, 'Adarsh', 'HR', 3500),(118, 'Tejaswi', 'Finance', 5500),(119, 'Cory', 'HR', 8000),(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),(122, 'Ibrahim', 'IT', 8000),(123, 'Vikram', 'IT', 8000),(124, 'Dheeraj', 'IT', 11000);

select * from employee;

select * from 
(select
	*,
    row_number() over (order by emp_id desc) rn
from employee ) x
where x.rn = 2 ;

select 
	*
from employee 
order by emp_id desc
limit 1,1;



-- 3. Write a SQL query to display only the details of employees who either earn the highest salary
-- or the lowest salary in each department from the employee table.

drop table employee;
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000),(102, 'Rajkumar', 'HR', 3000),(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),(105, 'Rohit', 'HR', 3000),(106, 'Rajesh',  'Finance', 5000),(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000),(109, 'Sanjay', 'IT', 6500),(110, 'Vasudha', 'IT', 7000),(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),(113, 'Gautham', 'Admin', 2000),(114, 'Manisha', 'HR', 3000),(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),(117, 'Adarsh', 'HR', 3500),(118, 'Tejaswi', 'Finance', 5500),(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),(121, 'Rosalin', 'IT', 6000),(122, 'Ibrahim', 'IT', 8000),(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);

select * from employee;

-- salary to be compared with min(salary) or max(salary)
select e2.* from employee e1
inner join (
select
	*,
    min(salary) over (partition by dept_name order by salary) min_salary,
    max(salary) over (partition by dept_name order by salary) max_salary
from employee ) e2
on e1.emp_id = e2.emp_id 
and (e1.salary = e2.min_salary or e1.salary = e2.max_salary) 
order by dept_name;




-- 4. From the doctors table, fetch the details of doctors who work in the same hospital but in different speciality.

drop table doctors;
create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors;

select d1.* from doctors d1 
inner join doctors d2 
on d1.id <> d2.id -- match one rec with rest of the rec
and d1.hospital = d2.hospital
and d1.speciality <> d2.speciality ; 


-- Additional Query: Write SQL query to fetch the doctors who work in same hospital irrespective of their specialty.
select d1.* from doctors d1
inner join doctors d2
on d1.id <> d2.id
and d1.hospital = d2.hospital ;


-- 5. From the login_details table, fetch the users who logged in consecutively 3 or more times.
drop table login_details;
create table login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

delete from login_details;
insert into login_details values
(101, 'Michael', current_date),
(102, 'James', current_date),
(103, 'Stewart', current_date+1),
(104, 'Stewart', current_date+1),
(105, 'Stewart', current_date+1),
(106, 'Michael', current_date+2),
(107, 'Michael', current_date+2),
(108, 'Stewart', current_date+3),
(109, 'Stewart', current_date+3),
(110, 'James', current_date+4),
(111, 'James', current_date+4),
(112, 'James', current_date+5),
(113, 'James', current_date+6);

select * from login_details;

select distinct consecutive_users from (
select 
	*,
    case 
		when user_name = lead(user_name) over()  and
        user_name = lead(user_name, 2) over()
	then user_name
    else null 
    end as consecutive_users
 from login_details ) tmp
 where tmp.consecutive_users is not null ;
 
 
 
 -- 6. From the students table, write a SQL query to interchange the adjacent student names.
-- Note: If there are no adjacent student then the student name should stay the same.
drop table students;
create table students
(
id int primary key,
student_name varchar(50) not null
);
insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

select * from students;

select
	*,
    case 
		when id%2 = 0 then lag(student_name) over () 
		when id%2 <> 0 then lead(student_name,1,student_name) over () -- to keep last student as is if swap not found ude default st_name
	end as swapped_students
from students;



-- 7. From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.
-- Note: Weather is considered to be extremely cold when its temperature is less than zero.

drop table weather;
create table weather
(
id int,
city varchar(50),
temperature int,
day date
);
delete from weather;
insert into weather values
(1, 'London', -1, '2021-01-01'),
(2, 'London', -2, '2021-01-02'),
(3, 'London', 4, '2021-01-03'),
(4, 'London', 1, '2021-01-04'),
(5, 'London', -2, '2021-01-05'),
(6, 'London', -5, '2021-01-06'),
(7, 'London', -7, '2021-01-07'),
(8, 'London', 5, '2021-01-08');

select * from (
	select 
		*, 
		case 
			when
				temperature < 0
				and lag(temperature) over(order by day) < 0
				and lead(temperature) over(order by day) < 0
			then 'Y'
			when 
				temperature < 0
				and lag(temperature) over() < 0
				and lag(temperature, 2) over() < 0
			then 'Y'
			when 
				temperature < 0
				and lead(temperature) over() < 0
				and lead(temperature, 2) over() < 0
			then 'Y'
			end as cold
		from weather ) tmp
where tmp.cold is not null;


-- 9. Find the top 2 accounts with the maximum number of unique patients on a monthly basis.
-- Note: Prefer the account if with the least value in case of same number of unique patients
drop table patient_logs;
create table patient_logs
(
  account_id int,
  date1 date,
  patient_id int
);

insert into patient_logs values (1, '2020-01-02', 100),(1, '2020-01-27', 200), (2, '2020-01-01', 300), (2, '2020-01-21', 400), 
(2, '2020-01-21', 300), (2, '2020-01-01', 500), (3, '2020-01-20', 400), (1, '2020-03-04', 500), (3, '2020-01-20', 450);

select * from patient_logs;


select 
	*
from (
	select 
		*,
		rank() over (partition by month order by no_of_uniq_patients desc, account_id asc) rk -- select top 2 and if same same number of unique patients then the account if with the least value
		from (
			select account_id, month, count(1) as no_of_uniq_patients from ( -- aggr count
				select 
					distinct account_id, patient_id, month(date1) as month -- get uniq patients
				from patient_logs ) patient_l
			group by account_id, month ) x  -- need count on the basis of acc and month
	) t
where t.rk in (1,2) ;
