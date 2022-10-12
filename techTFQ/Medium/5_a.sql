create database assignment_db;

use assignment_db;

DROP TABLE student_batch_maps;
DROP TABLE instructor_batch_maps;
DROP TABLE attendances;
DROP TABLE sessions;
DROP TABLE test_scores;
DROP TABLE tests;



-- 1.users table:  name(user name), active(boolean to check if user is active)
DROP TABLE users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into users values 
(1, 'Rohit', true, CURRENT_DATE-5, CURRENT_DATE-4), (2, 'James', true, CURRENT_DATE-5, CURRENT_DATE-4),
(3, 'David', true, CURRENT_DATE-5, CURRENT_DATE-4),(4, 'Steven', true, CURRENT_DATE-5, CURRENT_DATE-4),
(5, 'Ali', true, CURRENT_DATE-5, CURRENT_DATE-4),(6, 'Rahul', true, CURRENT_DATE-5, CURRENT_DATE-4),
(7, 'Jacob', true, CURRENT_DATE-5, CURRENT_DATE-4),(8, 'Maryam', true, CURRENT_DATE-5, CURRENT_DATE-4),
(9, 'Shwetha', false, CURRENT_DATE-5, CURRENT_DATE-4),(10, 'Sarah', true, CURRENT_DATE-5, CURRENT_DATE-4),
(11, 'Alex', true, CURRENT_DATE-5, CURRENT_DATE-4),(12, 'Charles', false, CURRENT_DATE-5, CURRENT_DATE-4),
(13, 'Perry', true, CURRENT_DATE-5, CURRENT_DATE-4),(14, 'Emma', true, CURRENT_DATE-5, CURRENT_DATE-4),
(15, 'Sophia', true, CURRENT_DATE-5, CURRENT_DATE-4),(16, 'Lucas', true, CURRENT_DATE-5, CURRENT_DATE-4),
(17, 'Benjamin', true, CURRENT_DATE-5, CURRENT_DATE-4),(18, 'Hazel', false, CURRENT_DATE-5, CURRENT_DATE-4);

select * from users; 

-- 2.batches  table:  name(batch name), active(boolean to check if batch is active)
DROP TABLE batches;
CREATE TABLE batches (
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) UNIQUE NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into batches values 
(1, 'Statistics', true, CURRENT_DATE-8, CURRENT_DATE-6), (2, 'Mathematics', true, CURRENT_DATE-8, CURRENT_DATE-6),
(3, 'Physics', false, CURRENT_DATE-8, CURRENT_DATE-6) ;

-- 3.student_batch_maps  table: this table is a mapping of the student and his batch. deactivated_at is the time when a student is made inactive in a batch.
CREATE TABLE student_batch_maps (
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  active BOOLEAN NOT NULL DEFAULT true,
  deactivated_at TIMESTAMP NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into student_batch_maps values 
(1, 1, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4), (2, 2, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  
(3, 3, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (4, 4, 1, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  
(5, 5, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (6, 6, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  
(7, 7, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (8, 8, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  
(9, 9, 2, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (10, 10, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  
(11, 11, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (12, 12, 3, false, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4), 
(13, 13, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),  (14, 14, 3, true, CURRENT_TIMESTAMP, CURRENT_DATE-5, CURRENT_DATE-4),
(15, 4, 2, true, CURRENT_TIMESTAMP, CURRENT_DATE-4, CURRENT_DATE-3),  (16, 9, 3, false, CURRENT_TIMESTAMP, CURRENT_DATE-3, CURRENT_DATE-2),
(17, 9, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-2, CURRENT_DATE-1),  (18, 12, 1, true, CURRENT_TIMESTAMP, CURRENT_DATE-4, CURRENT_DATE-3);



-- 4.instructor_batch_maps  table: this table is a mapping of the instructor and the batch he has been assigned to take class/session.
CREATE TABLE instructor_batch_maps (
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INTEGER REFERENCES users(id),
  batch_id INTEGER REFERENCES batches(id),
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into instructor_batch_maps values (1, 15, 1, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (2, 16, 2, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (3, 17, 3, true, CURRENT_DATE-5, CURRENT_DATE-4);
insert into instructor_batch_maps values (4, 18, 2, true, CURRENT_DATE-5, CURRENT_DATE-4);




-- 5.sessions table: Every day session happens where the teacher takes a session or class of students.
CREATE TABLE sessions (
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  conducted_by INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into sessions values
(1, 15, 1, (CURRENT_TIMESTAMP - INTERVAL 240 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 180 MINUTE), CURRENT_DATE, CURRENT_DATE) , 
(2, 16, 2, (CURRENT_TIMESTAMP - INTERVAL 240 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 180 MINUTE), CURRENT_DATE, CURRENT_DATE), 
(3, 17, 3, (CURRENT_TIMESTAMP - INTERVAL 240 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 180 MINUTE), CURRENT_DATE, CURRENT_DATE), 
(4, 15, 1, (CURRENT_TIMESTAMP - INTERVAL 180 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 120 MINUTE), CURRENT_DATE, CURRENT_DATE), 
(5, 16, 2, (CURRENT_TIMESTAMP - INTERVAL 180 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 120 MINUTE), CURRENT_DATE, CURRENT_DATE), 
(6, 18, 2, (CURRENT_TIMESTAMP - INTERVAL 120 MINUTE), (CURRENT_TIMESTAMP - INTERVAL 60 MINUTE), CURRENT_DATE, CURRENT_DATE);



-- 6.attendances table: After session or class happens between teacher and student, attendance is given by student. students provide ratings to the teacher.
CREATE TABLE attendances (
  student_id INTEGER NOT NULL REFERENCES users(id),
  session_id INTEGER NOT NULL REFERENCES sessions(id),
  rating DOUBLE PRECISION NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, session_id)
);

insert into attendances values 
(1, 1, 8.5, CURRENT_DATE, CURRENT_DATE), (2, 1, 7.5, CURRENT_DATE, CURRENT_DATE), (3, 1, 6.0, CURRENT_DATE, CURRENT_DATE),  
(5, 2, 8.5, CURRENT_DATE, CURRENT_DATE),  (6, 2, 7.5, CURRENT_DATE, CURRENT_DATE),  (7, 2, 6.0, CURRENT_DATE, CURRENT_DATE),  
(8, 2, 6.0, CURRENT_DATE, CURRENT_DATE),  (10, 3, 9.5, CURRENT_DATE, CURRENT_DATE),  (11, 3, 7.0, CURRENT_DATE, CURRENT_DATE),  
(13, 3, 8.0, CURRENT_DATE, CURRENT_DATE),  (14, 3, 6.0, CURRENT_DATE, CURRENT_DATE),  (1, 4, 7.0, CURRENT_DATE, CURRENT_DATE),  
(2, 4, 5.5, CURRENT_DATE, CURRENT_DATE),  (5, 5, 5.0, CURRENT_DATE, CURRENT_DATE),  (5, 6, 6.0, CURRENT_DATE, CURRENT_DATE),  
(9, 2, 4.0, CURRENT_DATE, CURRENT_DATE),  (12, 3, 5.0, CURRENT_DATE, CURRENT_DATE);




-- 7.tests table: Test is created by instructor. total_mark is the maximum marks for the test.
CREATE TABLE tests (
   id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  batch_id INTEGER REFERENCES batches(id),
  created_by INTEGER REFERENCES users(id),
  total_mark INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

insert into tests values 
(1, 1, 15, 100, CURRENT_DATE, CURRENT_DATE), (2, 2, 16, 100, CURRENT_DATE, CURRENT_DATE), 
(3, 3, 17, 100, CURRENT_DATE, CURRENT_DATE),  (4, 2, 18, 100, CURRENT_DATE, CURRENT_DATE),  
(5, 1, 15, 50, CURRENT_DATE, CURRENT_DATE),  (6, 1, 15, 25, CURRENT_DATE, CURRENT_DATE), 
(7, 1, 15, 25, CURRENT_DATE, CURRENT_DATE),  (8, 2, 16, 50, CURRENT_DATE, CURRENT_DATE),  
(9, 3, 17, 50, CURRENT_DATE, CURRENT_DATE);



-- 8.test_scores table: Marks scored by students are added in the test_scores table.
CREATE TABLE test_scores (
  test_id INTEGER REFERENCES tests(id),
  user_id INTEGER REFERENCES users(id),
  score INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(test_id, user_id)
);

insert into test_scores values 
(1, 1, 80, CURRENT_DATE, CURRENT_DATE), (1, 2, 60, CURRENT_DATE, CURRENT_DATE), 
(1, 3, 30, CURRENT_DATE, CURRENT_DATE), (2, 5, 80, CURRENT_DATE, CURRENT_DATE), 
(2, 6, 35, CURRENT_DATE, CURRENT_DATE), (2, 7, 38, CURRENT_DATE, CURRENT_DATE), 
(2, 8, 90, CURRENT_DATE, CURRENT_DATE), (3, 10, 65, CURRENT_DATE, CURRENT_DATE), 
(3, 11, 85, CURRENT_DATE, CURRENT_DATE), (3, 13, 95, CURRENT_DATE, CURRENT_DATE), 
(3, 14, 100, CURRENT_DATE, CURRENT_DATE), (5, 1, 40, CURRENT_DATE, CURRENT_DATE), 
(5, 2, 35, CURRENT_DATE, CURRENT_DATE), (5, 3, 45, CURRENT_DATE, CURRENT_DATE), 
(6, 1, 22, CURRENT_DATE, CURRENT_DATE), (6, 2, 12, CURRENT_DATE, CURRENT_DATE), 
(7, 1, 16, CURRENT_DATE, CURRENT_DATE), (7, 3, 10, CURRENT_DATE, CURRENT_DATE), 
(8, 5, 15, CURRENT_DATE, CURRENT_DATE), (8, 6, 20, CURRENT_DATE, CURRENT_DATE), 
(9, 13, 25, CURRENT_DATE, CURRENT_DATE), (9, 14, 35, CURRENT_DATE, CURRENT_DATE);




-- Using the above table schema, please write the following queries. To test your queries, you can use some dummy data.

-- 1.Calculate the average rating given by students to each teacher for each session created. Also, provide the batch name for which session was conducted.

-- 2.Find the attendance percentage  for each session for each batch. Also mention the batch name and users name who has conduct that session

-- 3.What is the average marks scored by each student in all the tests the student had appeared?

-- 4.A student is passed when he scores 40 percent of total marks in a test. Find out how many students passed in each test. Also mention the batch name for that test.

-- 5.A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
--  At a time, one student can be active in one batch only. One Student can not be transferred more than four times. Calculate each students attendance percentage for all the sessions created for his past batch. Consider only those sessions for which he was active in that past batch.

-- Note - Data is not provided for these tables, you can insert some dummy data if required.

-- /* Additional Questions added by techTFQ */

-- 6. What is the average percentage of marks scored by each student in all the tests the student had appeared?

-- 7. A student is passed when he scores 40 percent of total marks in a test. Find out how many percentage of students have passed in each test. Also mention the batch name for that test.

-- 8. A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
--     At a time, one student can be active in one batch only. One Student can not be transferred more than four times.
--     Calculate each students attendance percentage for all the sessions.