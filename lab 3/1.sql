create database ashu1 ;
use ashu1 ;
create table hostel 
(
hno int primary key not null ,
hname varchar(50) ,
htype varchar(50) 
);

create table menu
(
hno int ,
day varchar(50),
breakfast varchar(50),
lunch varchar(50),
dinner varchar(50),
FOREIGN KEY (hno) REFERENCES hostel(hno)
);

create table warden
(
hno int ,
wname varchar(50) ,
qual varchar(50) ,
FOREIGN KEY (hno) REFERENCES hostel(hno)
);

create table student
(
sid int primary key not null,
sname varchar(50),
gender varchar(50),
year int ,
hno int ,
FOREIGN KEY (hno) REFERENCES hostel(hno)
);

insert into hostel values(1,'Amber','boy');
insert into hostel values(2,'Diamond','boy');
insert into hostel values(3,'Opal','girl');
select *from hostel ;

insert into warden values(1,'Mohan','B.sc');
insert into warden values(2,'Raj','B.Com');
insert into warden values(3,'Shridevi','B.com');
select *from warden ;

insert into menu values(1,'Mon','Alo parata','Chapati','Ghobi');
insert into menu values(1,'Tue','Alo parata','muli','Ghobi');
insert into menu values(1,'Wed','Chole bature','Chapati','Sabji');
insert into menu values(1,'Thu','Alo parata','Chapati','Ghobi');
insert into menu values(1,'Fri','Chole bature','Chapati','Ghobi');
insert into menu values(1,'Sut','Chole bature','Chapati','Sabji');
insert into menu values(1,'Sun','Alo parata','muli','Ghobi');

insert into menu values(2,'Mon','Alo parata','Chapati','Ghobi');
insert into menu values(2,'Tue','Alo parata','muli','Ghobi');
insert into menu values(2,'Wed','Chole bature','Chapati','Sabji');
insert into menu values(2,'Thu','Alo parata','Chapati','Ghobi');
insert into menu values(2,'Fri','Chole bature','Chapati','Ghobi');
insert into menu values(2,'Sut','Chole bature','Chapati','Sabji');
insert into menu values(2,'Sun','Alo parata','muli','Ghobi');

insert into menu values(3,'Mon','Alo parata','Chapati','Ghobi');
insert into menu values(3,'Tue','Alo parata','muli','Ghobi');
insert into menu values(3,'Wed','Chole bature','Chapati','Sabji');
insert into menu values(3,'Thu','Alo parata','Chapati','Ghobi');
insert into menu values(3,'Fri','Chole bature','Chapati','Ghobi');
insert into menu values(3,'Sut','Chole bature','Chapati','Sabji');
insert into menu values(3,'Sun','Alo parata','muli','Ghobi');
select *from menu ;

insert into student values(1,'Ashutosh','boy',2,1);
insert into student values(2,'Gulab','boy',2,1);
insert into student values(3,'Anoop','boy',2,1);
insert into student values(4,'Dhruv','boy',3,2);
insert into student values(5,'Manoj','boy',3,2);
insert into student values(6,'Ridhi','girl',2,3);
insert into student values(7,'Devansi','girl',2,3);
select *from student ;

select gender , count(gender) from student group by gender ;
select * from menu where day like 'Tue' and hno = 2;

select hno , count(hno) from warden group by hno ;

select hno , count(hno) from student group by hno ;

update menu set breakfast = 'noddles' where hno = 2 and day like 'Thu' ;
select * from menu ;

select wname from warden where qual like 'B.Com' ;

select count(hno) as totalcount from student where sname like 'A%' and hno = 2;

select count(year) as noofstudent , year from student group by year ;

select * from hostel where htype like 'girl' ;


create view newtable as
select e1.wname , e1.hno , e2.gender , e2.sname 
from warden as e1  , student as e2 
where e1.hno = e2.hno ;
select count(hno),hno , wname from newtable group by hno ;
select * from newtable ;




