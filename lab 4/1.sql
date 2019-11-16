create database lab4;
use  lab4;
/* Employee (EmpNo, EmpName, Sex, Salary, Address, DeptNo)*/
create table employee
(
empno int primary key ,
empname varchar (500) ,
sex varchar (500) ,
salary int ,
address varchar(500),
deptno int
);


insert into employee values(1,'abhishek','male',1000,'patna',1);
insert into employee values(2,'aditya','male',100,'pune',1);
insert into employee values(3,'adwait','male',900,'goa',1);
insert into employee values(4,'anoop','male',3000,'chennai',2);
insert into employee values(5,'ashutosh','male',1000,'varansi',2);
insert into employee values(6,'atif','male',10000,'dubai',2);
insert into employee values(7,'devansi','female',323232,'madurai',3);
insert into employee values(8,'gulab','male',32,'chennai',3);
insert into employee values(9,'hema','female',2309,'jaipur',4);
insert into employee values(10,'mohan','male',2,'chennai',4);
insert into employee values(11,'sita','female',2345,'mumbai',5);

select * from employee ;


/*Department (DeptNo, DeptName, Location)*/
create table department 
(
deptno int primary key ,
deptname varchar (500) ,
location varchar ( 500) 
);

insert into department values(1,'cse','chennai');
insert into department values(2,'ece','trichy');
insert into department values(3,'eee','hydrabad');
insert into department values(4,'mech','mumbai');
insert into department values(5,'ice','pune');

select * from department;

/*1.Create a procedure to display the details of an employee record from employee table for a given employee number*/
delimiter $$
create procedure emp_detail(in userid int)
begin
select * from employee where empno = userid ;
end $$
delimiter ;
call emp_detail(2);

/*2. Create a procedure to add details of a new employee into employee table*/
delimiter $$
create procedure insert_employee (in emp_id int, in Empname varchar(225) , in gender varchar(225) ,in salary bigint ,in address varchar(225) , in deptno int)
begin
insert into employee values (emp_id,Empname , gender ,salary , address , deptno);
end $$
delimiter ;
call insert_employee(13 , 'Dhruv' , 'male' , 1002, 'Kanpur' , 5) ;

/*3. Write a procedure raise_sal which increases the salary of an employee. It accepts an
employee number and salary increase amount. It uses the employee number to find the
current salary from the EMPLOYEE table and update the salary.*/
delimiter $$
create procedure increase_salary1(in empn int, in increase int)
begin
update employee set salary = salary + increase where empno = empn ;
end $$
delimiter ;
call increase_salary1(1,100) ;

select * from employee ;

/*4. Create a procedure to delete a record form employee table for a given employee name.*/
delimiter $$ 
create procedure delete_employee (in employee_name varchar(225))
begin
delete from employee where empname = employee_name ;
end $$
delimiter ;
call delete_employee ('dhruv') ;
select * from employee ;

/*5. Write a function to display maximum salary of employees from the employee table.*/

delimiter $$
create function max_salary ()
returns int
begin
declare max_sal  int ;
select max(salary) into max_sal from employee ;
return max_sal ;
end $$
delimiter ;
select max_salary() ;

/*6. Write a function to display the number of employees working in the Organization.*/
delimiter $$
create function total_employee ()
returns int 
begin
declare total int ;
select count(*) into total from employee ;
return total ;
end $$
delimiter ;
select total_employee () ;

/*7. Write a function to display salary of an employee with the given employee number.*/
delimiter $$
create function show_salary(emp_number int)
returns int
begin 
declare sal int ;
select salary into sal from employee where empno = emp_number ;
return sal ;
end $$
delimiter ;
select show_salary(2) ;

/*8. Write a function average which takes DeptNo as input argument and returns the average
salary received by the employee in the given department. */
delimiter $$
create function avg_sal (dep int)
returns int
begin
declare avg_salary int ;
select avg(salary) into avg_salary from employee where deptno = dep ;
return avg_salary ;
end $$
delimiter ;
select avg_sal(1) ;
select avg_sal(2) ;

/*9. Write a procedure which takes the DeptNo as input parameter and lists the names of all
employees belonging to that department. */
create procedure emp_Name (in deptNumber int)
select empname from employee where deptno = deptNumber ;
call emp_Name(1) ;

/*10. Write procedure that lists the highest salary drawn by an employee in each of the
departments. It should make use of a named procedure dept_highest which finds the
highest salary drawn by an employee for the given department.*/
delimiter $$
create function dept_highest(deptNumber int )
returns int
begin
declare maximumuSalary int ;
select max(salary) into maximumuSalary from employee where deptno = deptNumber ;
return maximumuSalary ;
end $$
delimiter ;

delimiter $$
create procedure all_dept_highest()
begin
select dept_highest(deptno) from department ;
end $$
delimiter ;
call all_dept_highest() ;

/*11. Write a function that will display the number of employees with salary more than 50k.*/
delimiter $$
create function total_employee_greater_1000 ()
returns int
begin
declare total int ;
select count(*) into total from employee where salary > 1000 ;
return total ;
end $$
delimiter ;
select total_employee_greater_1000() ;

/*12. Write a function that will display the count of the number of employees working in Chennai.*/


delimiter $$
create function working_in_chennai()
returns int
begin
declare total int ;
select count(*) into total 
from employee as t1
inner join department as t2 
on t1.deptno = t2.deptno 
where t2.location = 'chennai';
return total ;
end $$
delimiter ;

select working_in_chennai() ;





