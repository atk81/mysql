create database ashu;
use ashu ;
create table if not exits employee(
    empid int primary key not null,
    empname varchar(50) ,
    address varchar(50) ,
    doj date ,
    salary int 
);

insert into employee (empid,empname, address , doj ,salary) values();