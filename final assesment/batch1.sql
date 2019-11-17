create database test25;
use test25;
create table hotel 
(
hotelno varchar(225) primary key ,
name varchar (225) ,
city varchar(225) 
);

create table room
(
roomno int ,
hotelno varchar(225) ,
type varchar(225) ,
price float
);

create table booking
(
hotelno varchar(225)  ,
guestno int ,
datefrom date ,
dateto date ,
roomno int 
);

create table guest
(
guestno int primary key ,
guestname varchar(225) ,
guestaddress varchar(225)
);

insert into hotel values('fb01', 'Grosvenor', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('cc01', 'Latham', 'Berlin');
select * from hotel;


insert into room values (501, 'fb01', 'single', 19);
insert into room values (601, 'fb01', 'double', 29);
insert into room values (701, 'fb01', 'family', 39);
insert into room values (1001, 'fb02', 'single', 58);
insert into room values (1101, 'fb02', 'double', 86);
insert into room values (1001, 'ch01', 'single', 29.99);
insert into room values (1101, 'ch01', 'family', 59.99);
insert into room values (701, 'ch02', 'single', 10);
insert into room values (801, 'ch02', 'double', 15);
insert into room values (901, 'dc01', 'single', 18);
insert into room values (1001, 'dc01', 'double', 30);
insert into room values (1101, 'dc01', 'family', 35);
select * from room ;


insert into guest values(10001, 'John Kay', '56 High St, London');
insert into guest values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values(10004,'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values(10005,'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');
select * from guest ;


insert into booking values('fb01', 10001, '2004-04-01', '2004-04-08', 501);
insert into booking values('fb01', 10004, '2004-04-15', '2004-05-15', 601);
insert into booking values('fb01', 10005, '2004-05-02', '2004-05-07', 501);
insert into booking values('fb01', 10002, '2016-05-04', '2004-05-29', 601);
insert into booking values('fb01', 10001, '2004-05-01', null, 701);
insert into booking values('fb02', 10005, '2004-05-12', '2030-05-04', 1101);
insert into booking values('ch01', 10006, '2004-04-21', null, 1101);
insert into booking values('ch02', 10002, '2004-04-25', '2004-05-06', 801);
insert into booking values('dc01', 10007, '2004-05-13', '2004-05-15', 1001);
insert into booking values('dc01', 10003, '2004-05-20', null, 1001);
select * from booking ;

--2.
update room set price = (price*105)/100;

--3.
select guestname , guestaddress from guest where guestno in
(select distinct guestno from booking where hotelno in
(
    select hotelno from hotel where city = 'london'
)) order by guestname asc ;

--4.
select * from booking where dateto is NULL ;

--5.
delimiter $$
create function noofhotel()
returns int
deterministic
begin
declare total int ;
select count(*) into total from hotel ;
return total;
end ; $$
delimiter ;
select noofhotel();

--6.
create procedure totalrevenue() 
select sum(price) from room where type = 'double';
call totalrevenue();

--7.
select type , price from room where hotelno = 'fb01';

--8.
create view guestbooking as
select e1.roomno as roomno , e1.hotelno as hotelno, e1.guestno as guestno , e2.guestname
from booking as e1
inner join guest as e2
on e1.guestno = e2.guestno
where e1.hotelno = 'fb01' ;

select e2.hotelno ,e2.roomno ,  e1.type , e1.price , e2.guestno ,e2.guestname from room as e1
inner join guestbooking as e2
on e1.roomno = e2.roomno ;

--9.
select * from room where roomno in (
    select roomno from booking where dateto < CURRENT_DATE() or datefrom > CURRENT_DATE() and hotelno='fb01'
) and hotelno = 'fb01';

--10.
select count(*) as totalhotel , hotelno from room group by hotelno ;

--11.
--!Didn't able to solve..

--12.
create table newbooking
(
hotelno varchar(225)  ,
guestno int ,
datefrom date ,
dateto date ,
roomno int 
);

insert into newbooking select * from newbooking where dateto is NULL or dateto > '2007-12-31';

--13.
create table ath
(
name varchar(225) ,
rollno int 
);

create table opr 
(
curr_date date ,
operation varchar(225)
);

delimiter $$
create trigger aht
before insert 
on ath
for each row
begin
insert into opr values(CURRENT_DATE(), 'insertion') ;
end $$

create trigger aht1
after delete 
on ath
for each row
begin
insert into opr values(CURRENT_DATE(), 'deletion') ;
end $$

create trigger aht2
after update
on ath
for each row
begin
insert into opr values(CURRENT_DATE(), 'updation') ;
end $$

delimiter ;

