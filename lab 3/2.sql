CREATE DATABASE lab31;
use lab31;

CREATE TABLE Department1
(
	deptid INT NOT NULL PRIMARY KEY,
	deptname VARCHAR(255)
);

CREATE TABLE Student1
(
	rollno INT NOT NULL PRIMARY KEY,
	name VARCHAR(255),
	gender VARCHAR(255),
	m1 INT,
	m2 INT,
	m3 INT,
	total NUMERIC,
	avg NUMERIC,
	depid INT,
	FOREIGN KEY (depid) REFERENCES Department1(deptid)
);

CREATE TABLE Staff
(
	staffid INT NOT NULL PRIMARY KEY,
	name VARCHAR(255),
	designation VARCHAR(255),
	qualification VARCHAR(255),
	depid INT,
	FOREIGN KEY (depid) REFERENCES Department1(deptid)
);

CREATE TABLE Tutor
(
	rollno INT,
	staffid INT,
	FOREIGN KEY (rollno) REFERENCES Student1(rollno),
	FOREIGN KEY (staffid) REFERENCES Staff(staffid)
);

INSERT INTO Department1(deptid, deptname)
VALUES(1, "CSE");

INSERT INTO Department1(deptid, deptname)
VALUES(2, "ECE");

INSERT INTO Department1(deptid, deptname)
VALUES(3, "ICE");

INSERT INTO Department1(deptid, deptname)
VALUES(4, "EEE");

INSERT INTO Department1(deptid, deptname)
VALUES(5, "MECH");

select * from Department1 ;

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117001, "M", "Anthony", 80, 85, 90, 1);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117002, "F", "Anita", 60, 75, 100, 2);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117003, "M", "Aditya", 90, 87, 100, 3);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117004, "M", "Akbar", 45, 32, 41, 4);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117005, "F", "Rekha", 90, 72, 67, 5);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117006, "F", "Dipika", 60, 65, 55, 2);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117007, "F", "Rita", 21, 71, 69, 3);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117008, "F", "Sita", 56, 78, 82, 4);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117009, "M", "Avi", 100, 100, 100, 1);

INSERT INTO Student1(rollno, gender, name, m1, m2, m3, depid)
VALUES(106117010, "M", "Ram", 69, 62, 75, 5);

select * from Student1 ;

INSERT INTO Staff(staffid, name, designation, qualification, depid)
VALUES(123, "Ron", "HOD", "PHD", 1);

INSERT INTO Staff(staffid, name, designation, qualification, depid)
VALUES(222, "Harry", "Professor", "M.Ed", 2);

INSERT INTO Staff(staffid, name, designation, qualification, depid)
VALUES(314, "Ginny", "Professor", "M.Ed", 3);

INSERT INTO Staff(staffid, name, designation, qualification, depid)
VALUES(400, "Percy", "Asst. HOD", "PHD", 4);

INSERT INTO Staff(staffid, name, designation, qualification, depid)
VALUES(420, "Anabeth", "Temporary Professor", "B.Ed", 5);

select * from Staff ;

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117001, 420);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117002, 314);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117003, 222);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117004, 314);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117005, 400);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117006, 420);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117007, 400);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117008, 222);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117009, 123);

INSERT INTO Tutor(rollno ,staffid)
VALUES(106117010, 123);

select * from Tutor ;

UPDATE Student1 SET total = (m1 + m2 + m3);

UPDATE Student1 SET avg = total / 3 ;

select * from Student1 ;

/* 1.Display the student details who got average >85. */
select * From Student1 where avg > 85 ;

/*2.Display the number of student under the department ‘cse’. */
select count(depid) as totalstudentfromcse from Student1 where depid in 
(select deptid from Department1 where deptname = 'cse');

/* 3.How many students are under the tutor ‘x’ */
select count(*) as totalstudentundertutor from Tutor where staffid = 420 ;

/*4.Display the staff details who work in CSE department.*/
create view department_staff as
select dep.deptid as deptid , dep.deptname as deptname , s.staffid as staffid , s.name as staffname ,
s.designation as designation , s.qualification as qualification 
from Department1 as dep
inner join Staff as s 
on dep.deptid = s.depid ;
select * from department_staff ;
select count(*) as totalstaffundercse from department_staff where deptname = 'CSE' ;

/*5. How many designations and departments are there?*/
select count(distinct(designation)),count(distinct(depid)) from Staff;

/*6. Display the student details whose name start with ‘R’.*/
select * from Student1 where name like 'R%';

/*7. Display the name of the department, tutor details for the particular student.*/
create view dep_staff_tutor as
select t.rollno as rollno , 
ds.deptid as deptid , ds.deptname as deptname  , ds.staffid as staffid , ds.staffname as staffname ,
 ds.designation as designation , ds.qualification as qualification 
from Tutor as t
inner join department_staff as ds 
on ds.staffid = t.staffid ;
select * from dep_staff_tutor ;

select * from dep_staff_tutor where rollno = 106117003 ;

/*8. Display the total number of male and female students in department wise.*/
select  gender ,count(*) , depid from Student1 group by gender , depid ;

/*9. Display the student name in department wise who got first mark.*/
create view topper as
select name , total  , depid , rollno from Student1 where total in
(select max(total) from Student1 group by depid);

select name from topper ;

/*10. Display tutor details for toppers in department wise.*/
select * from dep_staff_tutor where rollno in
(select rollno from topper);

/*11. Display the staff details who is the tutor for female students.*/
select * from Staff where staffid in
(
    select distinct staffid from Tutor where rollno in
    (
        select rollno from Student1 where gender = 'f'
    )
);

/*12. Create a view to staff details and their department name whose designation is professor.*/
select * from dep_staff_tutor where designation = 'professor';


