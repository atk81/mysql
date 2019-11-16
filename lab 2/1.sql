create database lab2;
use lab2;

CREATE TABLE dep
(
	Dno INT NOT NULL PRIMARY KEY,
	Dname VARCHAR(255),
	Managername VARCHAR(255)
);

CREATE TABLE emp
(
	Empno INT NOT NULL PRIMARY KEY,
	Ename VARCHAR(255),
	Address VARCHAR(255),
	Sex VARCHAR(255),
	DOB Date,
	Dateofjoining Date,
	Deptno INT,
	Division VARCHAR(255),
	Desig VARCHAR(255),
	Salary INT,
	FOREIGN KEY (Deptno) REFERENCES dep(Dno)
);


INSERT INTO dep VALUES ( 1, "ADMIN" , "RAJESH");
INSERT INTO dep VALUES ( 2, "FINANCE" , "MAHESH");
INSERT INTO dep VALUES ( 3, "SALES" , "JAMES BOND");
INSERT INTO dep VALUES (4 , "MARKETING" , "IRON MAN");
INSERT INTO dep VALUES ( 5 , "WARS" , "CAPTAIN MARVEL");

INSERT INTO emp VALUES ( 1 , 'RAJESH' , 'PQRST' , 'MALE' , "1992-04-23", "2013-06-15" , 1 , "NE" , "DES1" , 1000);
INSERT INTO emp VALUES ( 2 , 'EFGH' , 'MNOPQ' , 'FEMALE' , "1992-04-23", "2013-06-15" , 1 , "SE" , "DES2" , 10000);
INSERT INTO emp VALUES ( 3 , 'IJKL' , 'RSTUV' , 'MALE' , "1991-04-22", "2013-06-15" , 1 , "RO" , "DES3" , 3500);

INSERT INTO emp VALUES ( 4 , 'MAHESH' , 'PQRSTRV' , 'MALE' , "1980-11-23", "2018-06-15" , 2 , "NE" , "DES11" , 10000);
INSERT INTO emp VALUES ( 5 , 'EFGHIJKL' , 'MNOPQVS' , 'FEMALE' , "1982-04-23", "2018-06-15" , 2 , "SE" , "DES21" , 10000);
INSERT INTO emp VALUES ( 6 , 'IJKLMNOP' , 'RSTUVST' , 'FEMALE' , "1980-11-23", "2018-06-15" , 2 , "RO" , "DES31" , 3500);

INSERT INTO emp VALUES ( 7 , 'JAMES BOND' , 'PQRSTSDF' , 'MALE' , "1991-04-23", "2003-06-15" , 3 , "NE" , "DES12" , 1000);
INSERT INTO emp VALUES ( 8 , 'EFGHPRST' , 'MNOPQSD' , 'FEMALE' , "1983-04-24", "2003-06-15" , 3 , "SE" , "DES22" , 100000);
INSERT INTO emp VALUES ( 9 , 'IJKLASLS' , 'RSTUVASDF' , 'MALE' , "1979-04-22", "2013-06-15" , 3 , "RO" , "DES32" , 3500);

INSERT INTO emp VALUES ( 10 , 'IRON MAN' , 'PQRSTSDFSDF' , 'FEMALE' , "1991-04-23", "2000-06-15" , 4 , "NE" , "DES13" , 1000);
INSERT INTO emp VALUES ( 11 , 'EFGHPRSTSDF' , 'MNOPQSDST' , 'FEMALE' , "1983-04-24", "2000-06-15" , 4 , "SE" , "DES24" , 10000);
INSERT INTO emp VALUES ( 12 , 'IJKLASLSSDF' , 'RSTUVASDDFGF' , 'FEMALE' , "1979-04-22", "2003-06-15" , 4 , "RO" , "DES35" , 3500);

select * from dep ;
select * from emp ;

/*names of employees with their division whose salary is not in the range
3000 and 5000*/
select Ename from emp where Salary between 3000 and 5000 ;

/*list the names of employee and their salary whose department name  may be in the
group of admin, finance and sales*/
select Ename , Salary from emp 
where Deptno in 
(select Dno from dep where Dname in ('admin','finance','sales'));

/*list the names of employee with dept. names in dept. sales and marketing using
union operator.*/
select e1.Ename as emplyoeeName
from emp as e1
where e1.Deptno = e2.Dno
union
select e2.Dname as DeptName
from dep as e2 
where e2.Dname in ('Sales','Marketing');

--alternate method
select e1.Ename as emplyoeeName , e2.Dname as DeptName
from emp as e1 , dep as e2
where e1.Deptno = e2.Dno and e2.Dno in
(select Dno from dep where Dname in ('sales','marketing') );

/*list the names of employee common to division ‘ne’ or ‘se’*/
select Ename from emp where Division in ('ne','se');

/*list the name of the employee who is drawing the highest salary.*/
select Ename from emp where
Salary = (Select max(Salary) from emp);

/*list the jobs with average salary.*/
select e1.Dname as DeptName , avg(e2.Salary)
from dep as e1 , emp as e2
where e1.Dno = e2.Deptno
group by e1.Dname;

/*list the names of employee who earn 
lowest salary in each department.*/
-- create view minSalary as
-- select e2.Dname  as DeptName , min(e1.Salary) as minmumSalary ,e1.Deptno as Deptno 
-- from emp as e1 , dep as e2
-- where e1.Deptno = e2.Dno
-- group by e1.Deptno ;



-- complete it




/*list the employee details who earn salary greater than the average salary for their
department*/
--complete it 
 create view avgSalary  as select avg(Salary) as Salary , Deptno from emp group by Deptno;
 select e1.Ename as name , e2.Deptno as Deptno , e1.Salary from emp as e1 , avgSalary as e2 where e1.Deptno = e2.Deptno and e1.Sal
ary > e2.Salary ;



/*list the employee details who do not manage any one.*/
select * from emp where 


select * from emp where Salary > (select min(Salary) from emp where Ename in (select Managername from dep)) ;

select * from dep where Dno not in (select Deptno from emp) ;

select * from emp where Salary > (select max(Salary) from emp where Ename in (select Managername from dep)) ;


select year(date(now())) - year(DOB) from emp ;

create view experience1 as select year(date(now()))-year(Dateofjoining) as exp , Empno , Ename from emp ;

select * from experience1 where exp > 10 ;




/*
SELECT Ename,Salary FROM emp
WHERE Salary IN
(SELECT max(Salary) FROM emp);

SELECT * FROM emp as e1
WHERE Salary >(SELECT avg(Salary) FROM emp as e2);

SELECT * FROM emp as e1
WHERE Salary =(SELECT min(Salary) FROM emp as e2 WHERE e1.Deptno=e2.Deptno group by(Deptno));

SELECT * FROM emp as e1
WHERE Salary >(SELECT avg(Salary) FROM emp as e2 WHERE e1.Deptno=e2.Deptno group by(Deptno));

SELECT * FROM emp as e1
WHERE Salary >(SELECT avg(Salary) FROM emp as e2 WHERE e1.Deptno=e2.Deptno group by(Deptno));

SELECT * FROM emp
WHERE Ename NOT IN
(SELECT Managername FROM dep);

CREATE VIEW managersalaries AS (SELECT Salary FROM emp WHERE Ename IN (SELECT Managername FROM dep));
SELECT * FROM emp WHERE Salary > (SELECT MIN(Salary) FROM managersalaries);
SELECT * FROM emp WHERE Salary > (SELECT MAX(Salary) FROM managersalaries);

SELECT Dname FROM dep
WHERE Dno NOT IN
(SELECT Deptno FROM emp);


CREATE VIEW ages AS (SELECT Ename, (DATEDIFF(CURDATE(), DOB)/365.25) AS age FROM emp);
SELECT * FROM ages;
CREATE VIEW experiences AS (SELECT Ename, (DATEDIFF(CURDATE(), Dateofjoining)/365.25)AS experience FROM emp);
SELECT Ename FROM experiences
WHERE experience > 10;

CREATE VIEW sampleview AS (SELECT Ename, Sex, DOB, Dateofjoining, Desig, Salary FROM emp);
CREATE VIEW nestedview AS (SELECT Ename, (DATEDIFF(CURDATE(), Dateofjoining)/365) AS experience FROM sampleview);

*/