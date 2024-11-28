create database project1

use project1

CREATE TABLE course(
course_id INT AUTO_INCREMENT PRIMARY KEY,
course_name VARCHAR(30) NOT NULL);

desc course; 

INSERT INTO course
VALUES(1, "Java"),
(2, "SQL"),
(3, "Python"),
(4, "HTML"),
(5, "C"),
(6, "Data Structures");

select * from course; 

CREATE TABLE student1(
student_id INT AUTO_INCREMENT PRIMARY KEY,
student_name VARCHAR(40),
dob DATE NOT NULL,
street VARCHAR(30) DEFAULT NULL,
city VARCHAR(30) NOT NULL,
state VARCHAR(25) NOT NULL,
pin VARCHAR(12) DEFAULT NULL,
course_id INT NOT NULL,
FOREIGN KEY (course_id) REFERENCES course (course_id)
);

desc student1;

INSERT INTO student1
VALUES(100, 'Vinay' , '2001-09-30' , 'Kalbadevi' , 'Mumbai' , 'Maharasthra' , '400002' , 1),
(101 , 'Manasa' , '2002-01-17' , 'Arumbakkam' , 'Chennai' , 'Tamil Nadu' , '600106' , 4),
(102 , 'Akshata' , '2002-11-10' , 'Chembur' , 'Mumbai' , 'Maharasthra' , '40074' , 1),
(103, 'Jackson', '2002-05-22', 'Malleshwaram', 'Bangalore', 'Karnataka', '560003', 5),
(104, 'Shreyas', '2002-07-12', 'Balanagar', 'Hyderabad', 'Telangana', '560037', 6),
(105, 'Peter', '2001-03-20', 'Afzalgunj', 'Hyderabad', 'Telangana', '560012',2),
(106, 'Sneha', '2001-12-30', 'Greater Kailash', 'Delhi', 'Delhi', '110048', 3),
(107, 'Ankita', '2000-08-20', 'Fatorda', 'Margao', 'Goa', '403601', '2'),
(108, 'Shreya', '2001-06-28', 'Pathnoolpet', 'Bangalore', 'Karnataka', '560002', 6),
(109, 'Aishwarya', '2002-04-19', 'Jodhpur park', 'Kolkata', 'West Bengal', '700019', 3),
(110, 'Neha', '2001-01-05', 'Ashram Road', 'Ahmedabad', 'Gujarat', '380009', 6),
(111, 'Harshitha', '2000-11-23', 'Ashram Jalandhar by pass', 'Ludhiana', 'Punjab', '141001', 1);

select * from student1;

CREATE TABLE student_hobby(
student_id INT NOT NULL,
hobby VARCHAR(30) DEFAULT NULL,
FOREIGN KEY (student_id) REFERENCES student (student_id)
);

desc student_hobby;

INSERT INTO student_hobby
VALUES(109, 'Cooking'),
(101, 'Art'),
(100, 'Swimming'),
(105, 'Dance'),
(107, 'Singing'),
(103, 'Sleeping'),
(111, 'Travelling');

select * from student_hobby;

CREATE TABLE lecturer(
lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
lecturer_name VARCHAR(30) NOT NULL,
course_id INT NOT NULL,
FOREIGN KEY (course_id) REFERENCES course(course_id)
);

desc lecturer;

INSERT INTO lecturer
VALUES(200, 'Prisha' , 4),
(201, 'Aadhya' , 2),
(202, 'Isha' , 1),
(203, 'Siya' , 5),
(204, 'Anjali' , 3),
(205, 'Kamala' , 6);

select * from lecturer;

CREATE TABLE subject(
subject_id INT AUTO_INCREMENT PRIMARY KEY,
subject_name VARCHAR(25) DEFAULT NULL,
lecturer_id INT NOT NULL,
FOREIGN KEY(lecturer_id) REFERENCES lecturer(lecturer_id)
);

desc subject;

INSERT INTO subject
VALUES(15, 'OOP' , 204),
(16, 'Variable' , 203),
(17, 'Constraints' , 205),
(18, 'Loops' , 200),
(19, 'Numpy' , 202),
(20, 'Matplotlib' , 202),
(21, 'Panda' , 204),
(22, 'Stats' , 205),
(23, 'Joins' , 205);

select * from subject;

/*Retrieve only student_name and student_id column from student table*/
select student_name , student_id 
from student;

/*Retrieve student_id and student_name whose name starts with N*/
select student_id , student_name 
from student 
where student_name like 'N%%';

/*Retrieve student_name with alias*/
select student_name as new_one
from student 

/*Retrieve top 5 lecturer_id*/
select lecturer_id
from lecturer limit 5;

/*Retrieve in descending order of student_id in student_hobby*/
select student_id
from student_hobby 
order by student_id desc 

/*Left join lecturer_id from lecturer and subject and select columns lecturer_id, lecturer_name and subject_name*/
select lecturer.lecturer_id , lecturer_name , sub_name
from subject 
left join lecturer
on lecturer.lecturer_id = subject.lecturer_id

/*Full outer join student and course*/
select * from student left join course on student.course_id = course.course_id
UNION
select * from student right join course on student.course_id = course.course_id

/*Retrieve students who are born after 2002-06-20*/
select * from student
where dob  > '2002-06-20';

/*Find the lecturer who teaches specific subject*/
select lecturer_name
from lecturer 
join subject
on lecturer.lecturer_id = subject.lecturer_id
where subject.subject_id = 19;

/*Find the number of students in each course*/
select course_name , count(student_id)
from course
left join student
on course.course_id = student.course_id
group by course.course_name

/*Inner join lecturer, course, subject and retrieve lecturer_id's 201, 202, 203*/
select course.course_id , lecturer.lecturer_id , lecturer.lecturer_name , sub_name
from lecturer 
inner join course  
on lecturer.course_id = course.course_id
inner join subject
on lecturer.lecturer_id = subject.lecturer_id
where lecturer.lecturer_id in (201,202,203);

/*How to change the column name?*/
ALTER TABLE subject
RENAME COLUMN subject_name to sub_name;
select * from subject;


/*Find the lecturers who are not currently assigned to teach any subjects*/
select lecturer_name
from lecturer
left join subject
on lecturer.lecturer_id = subject.lecturer_id
where subject.lecturer_id is null;

/* Retrieve top 3 most popular hobbies among students*/
select student_hobby.hobby , count(student.student_id) as num_students
from student_hobby
join student
on student_hobby.student_id = student.student_id 
group by hobby
order by num_students desc
limit 3;

/*Retrieve the lecturer teaching maximum number of subjects*/
select lecturer.lecturer_name , count(subject_id) as num_subjects_taught
from lecturer
join subject
on lecturer.lecturer_id = subject.lecturer_id
group by lecturer_name 
order by num_subjects_taught desc
limit 1;

/*Find the students who are enrolled in multiple courses*/
select student_name , count(distinct student.course_id) as num_courses
from student
group by student.student_name
having num_courses >1;

