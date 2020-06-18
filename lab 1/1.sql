create database lab11 ;
use lab11 ;
create table if not exists employee
(
    empid int NOT NULL PRIMARY KEY ,
    empname varchar(50) not null ,
    empaddress varchar(500) ,
    doj date ,
    salary bigint
);

create table if not exists project
(
    projectno int primary key ,
    duration int ,
    projectname varchar(500) 
);

create table if not exists workson
(
    empid int ,
    projno int ,
    foreign key (empid) references employee(empid) ,
    foreign key (projno) references project(projectno)
);

insert into employee (empid,empname ,empaddress,doj,salary)
values(1,'ashutosh','ahirouli','2015-4-23',1000000);
insert into employee values(2,'ajay','mohammadabad','2014-3-1',10000000);
insert into employee values(3,'anand','ghazipur','2013-3-1',10000000000);
insert into employee values(4,'balram','trichy','2016-3-9',1);
insert into employee values(5,'raj','varansi','2011-4-12',20000);

insert into project(projectno , duration , projectname)
values(100,100,'kuch bhi');
insert into project values(101,100,'kuch nahi');
insert into project values(104,70,'khali');
insert into project values(105,32,'machine learning');
insert into project values(110,32,'deep learning');
insert into project values(103,104,'dbms');

insert into workson (empid,projno)
values(1,100);
insert into workson values(1,110);
insert into workson values(2,104);
insert into workson values(2,105);
insert into workson values(2,100);
insert into workson values(4,105);
insert into workson values(5,101);
insert into workson values(5,104);
insert into workson values(5,103);

select * from employee
order by empname desc ;

select * from project where projectno = 100 ;
select * from project where projectno in (100,101,110) ;

select * from employee where empname like 'b%';

select empid from workson where projno = 100 ;
select empid from workson where projno = 111 ;
select empid from workson where projno in (111,100,110,105);

drop database lab11 ;
show databases ;



