create database techTFQMedium;

use techTFQMedium;

/* 1. Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

create table if not exists comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');

select 
	*,
    case when translation is null then comment 
		 else translation 
	end as meaningful_msg 
from  comments_and_translations ;   
    
select *, coalesce(comment, translation) as meaningufl_msg from comments_and_translations ;


/*
	Two tables source and target
    If same id found in both with same name - don't output
    If id found in source but not in target - output new in source
    If id found in both but different name - mismatch
    If id only found in output but not in source - new in target
*/

CREATE TABLE if not exists source
    (
        id      int,
        name    varchar(1)
    );

CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');


select * from source ;
select * from target ;

-- there's no full outer join in mysql
-- workaround: left and right join with union combined in cte and case when stmts
select s.id, 'Mismatched' as comment
from source s
join target t 
on t.id = s.id and s.name <> t.name
union all
select s.id, 'New in Source' as Comment from source s
left join target t
on s.id = t.id 
where t.id is null 
union all
select t.id, 'New in Target' as Comment from source s
right join target t
on s.id = t.id 
where s.id is null ;



/*
There are 10 IPL team. 
	1. Write an sql query such that each team play with every other team just once.
	2. Write an sql query such that each team play with every other team Twice.
*/

drop table teams;
create table teams (
        team_code       varchar(10),
        team_name       varchar(40)
);

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

-- 1. skip prev matches by creating an id 
with matches as (
select 
	row_number() over (order by team_name) as id,
    team_code,
    team_name
from teams )
select 
	team.team_name as team,
    opponent.team_name as opponent
from matches team inner join matches opponent
on team.id < opponent.id;


-- 2. 
with matches as (
select 
	row_number() over (order by team_name) as id,
    team_code,
    team_name
from teams )
select 
	team.team_name as team,
    opponent.team_name as opponent
from matches team inner join matches opponent
on team.id <> opponent.id;
