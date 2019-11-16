create database lab12 ;
use lab12 ;

create table if not exists stud
(
    rollno bigint primary key ,
    nameof varchar(100) ,
    sub1 int ,
    sub2 int,
    sub3 int ,
    sub4 int ,
    sub5 int ,
    sub6 int ,
    total int 
);

create table if not exists dep
(
    depid int primary key ,
    depname varchar(40) ,
    hodname varchar(50)
);

create table if not exists studdep
(
    rollno bigint ,
    depid int ,
    foreign key (rollno) references stud(rollno) ,
    foreign key (depid) references dep(depid)
);

insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117001,'abhishek',12,12,14,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117003,'abhishek kumar',12,12,34,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117005,'aditya',43,12,14,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117007,'adwait',12,12,83,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117011,'anoop',12,32,14,48,32,48);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(106117013,'ashutosh',32,3,4,48,32,91);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(107117001,'avi',12,12,14,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(107117003,'charn',12,12,14,48,31,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(108117002,'daniel',12,12,88,48,32,24);
insert into stud(rollno, nameof, sub1,sub2,sub3,sub4,sub5,sub6) 
values(108117003,'abhishek',12,12,14,48,32,24);
update stud 
set total = (sub1 + sub2 + sub3 + sub4 + sub5 + sub6) ;
select * from stud ;

insert into dep values(106,'cse','rajeshwari');
insert into dep values(107,'ece','mohan');
insert into dep values(108,'eee','lela');
select * from dep ;

insert into studdep values(106117001,106);
insert into studdep values(106117003,106);
insert into studdep values(106117005,106);
insert into studdep values(106117007,106);
insert into studdep values(106117011,106);
insert into studdep values(106117013,106);
insert into studdep values(107117001,107);
insert into studdep values(107117003,107);
insert into studdep values(108117002,108);
insert into studdep values(108117003,108);
select * from studdep ;

-- display the student details if depid is given
select * from stud where rollno in 
(select rollno from studdep where depid = 106 );
--display the department details if rollno is given 
select * from dep where depid in
(select depid from studdep where rollno = 107117001);
--display the student names who got total greater than 200
select nameof from stud where total > 200 ;
--display the hod name of the cse department 
select hodname from dep where depname like 'cse' ;
--display the student rollno of the cse department
select rollno from studdep where depid in
(select depid from dep where depname like 'cse');

delimiter $$
create function max_batao(no1 int, no2 int)
returns int
DETERMINISTIC
begin
declare le_max int;
if no1 > no2 then set le_max = no1 ;
else set le_max = no2 ;
end if ;
return le_max ;
end $$
delimiter ;
select max_batao(sub1 , max_batao(sub2,sub3)) from stud where nameof ='abhishek' ;

