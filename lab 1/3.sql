create database lab13 ;
use lab13;
CREATE TABLE salesperson
(
    ssn INT NOT NULL PRIMARY KEY ,
    name VARCHAR(50),
    startyear VARCHAR(50) ,
    deptno VARCHAR(50)
);

CREATE TABLE trip
(
    ssn INT ,
    fromcity varchar(50),
    tocity varchar(50),
    depdate date,
    retdate date,
    tripid int PRIMARY KEY,
    FOREIGN KEY (ssn) REFERENCES salesperson(ssn)
);

CREATE TABLE salerepexpense
(
    tripid int ,
    travelexpense int,
    statexpense int,
    foodexpense int,
    amount NUMERIC,

    FOREIGN KEY (tripid) REFERENCES trip(tripid)
);

insert into salesperson
values(100, 'Ashutosh', 2015, 106);
insert into salesperson
values(200,'Gulab',2016,108);
insert into salesperson
values(300, 'Anoop', 2015, 107);
insert into salesperson
values(500, 'Mayank', 2016, 108);
insert into salesperson
values(700, 'Atif', 2016, 106);
insert into salesperson
values(800, 'Abhishek', 2017, 107);
insert into salesperson
values(900, 'Avi bomb', 2018, 108);
insert into salesperson
values(1000, 'Dhruv', 2018, 106);
insert into salesperson
values(1100, 'Raj', 2018, 108);

insert into trip
values(100, 'trichy', 'chennai', '2018-3-12' , '2018-11-14' , 1 );
insert into trip
values(100, 'trichy', 'chennai', '2018-12-1' , '2019-1-1' , 2 );
insert into trip
values(200, 'trichy', 'kanyakumari', '2018-3-12' , '2018-11-14', 3 );
insert into trip
values(300, 'trichy', 'varansi', '2018-3-12' , '2018-11-14' , 4 );
insert into trip
values(500, 'trichy', 'delhi', '2018-3-12' , '2018-11-14' , 5 );
insert into trip
values(700, 'trichy', 'chennai', '2018-3-12' , '2018-11-14' , 6 );
insert into trip
values(700, 'trichy', 'chennai', '2018-3-12' , '2018-11-14' , 7 );
insert into trip
values(800, 'trichy', 'chennai', '2018-3-12' , '2018-11-14' , 8 );
insert into trip
values(900, 'trichy', 'kolkata', '2018-3-12' , '2018-11-14' , 9 );
insert into trip
values(1000, 'trichy', 'varansi', '2018-3-12' , '2018-11-14' , 10 );
insert into trip
values(1100, 'trichy', 'chennai', '2018-3-12' , '2018-11-14' , 11 );

insert into salerepexpense
values(1, 100, 200, 1000, 0);
insert into salerepexpense
values(2, 100, 200, 100, 0);
insert into salerepexpense
values(3, 100, 200, 100, 0);
insert into salerepexpense
values(4, 100, 300, 1000, 0);
insert into salerepexpense
values(5, 100, 200, 100, 0);
insert into salerepexpense
values(6, 100, 2000, 100, 0);
insert into salerepexpense
values(7, 100, 200, 100, 0);
insert into salerepexpense
values(8, 100, 200, 100, 0);
insert into salerepexpense
values(9, 100, 200, 100, 0);
insert into salerepexpense
values(10, 100, 200, 100, 0);
insert into salerepexpense
values(11, 100, 700, 1000, 0);

select * from salesperson ;
select * from trip ;
update salerepexpense 
set amount = (travelexpense + statexpense + foodexpense) ;
select * from salerepexpense ;

--give the details for trips that exceed rs 1000.
select * from trip where tripid in 
(select tripid from salerepexpense where amount > 1000 ) ;

--print the ssn of salespreson who took trips to chennai more than once
create view chennaitrip as 
select ssn , count(tocity) as chennaicount from trip 
group by tocity 
having tocity like 'chennai' ;

select ssn from chennaitrip 
where chennaicount > 1 ;

--print the total expenses incurred by the salesperson with ssn = 1000
select amount from salerepexpense where tripid in
(select tripid from trip where ssn = 1000) ;

--display the salesperson details in the sortedd ordre by based on name
select * from salesperson 
order by name ;