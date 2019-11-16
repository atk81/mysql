/*Student Schema
students(Rollno, Lastname, Firstname, Email, classyear, major, phoneno)*/
create database lab5 ;
use lab5 ;
create table students
(
    rollno int ,
    lastname varchar(225),
    firstname varchar(225),
    email varchar(225) ,
    classyear int ,
    major varchar(225) ,
    phoneno varchar(225)
);

/*1. Create a trigger which will calculate the number of rows we have inserted till now.*/
set @total = 0;
delimiter $$
create trigger no_of_student
after insert on students
for each row
begin
select count(*) into @total from students ;
end $$
delimiter ;

/*6. Create a trigger to insert student details into student table only if classyear<2015.*/
delimiter $$
create trigger classyear_restriction
before insert on students
for each row 
begin
if new.classyear>2014 then 
signal sqlstate '45000'
set message_text = 'Must be before 2015!';
end if ;
end $$
delimiter ;

/*7. Create a trigger to prevent any student named John to be inserted into the table.*/
delimiter $$
create trigger prevent_john
before insert on students
for each row
begin
if new.firstname = 'john' then
signal sqlstate '45000'
set message_text = 'John cannat be inserted!';
end if;
end $$
delimiter ;

/*8. Create a trigger to raise an exception if the rollno is changed.*/
delimiter $$
create trigger rollno_changed
after update on students
for each row
begin
if old.rollno <> new.rollno then 
signal sqlstate '45000'
set message_text = 'rollno of students cannot be changed!';
end if;
end $$
delimiter ;

/*5. Create a trigger that whenever an insert, update, or delete operation occurs on the students
table, a row is added to the studentlog table recording the date, user, and action.*/
create table studentlog
(
    cur_date date ,
    user varchar (225) ,
    action varchar (225) 
);

delimiter $$
create trigger studentlog_insert 
after insert on students
for each row
begin
insert into studentlog values(CURRENT_DATE(), new.firstname , 'insert operation');
end $$
delimiter ;

delimiter $$
create trigger studentlog_update
after update on students
for each row
begin
insert into studentlog values (CURRENT_DATE(), new.firstname , 'update operation');
end $$
delimiter ;

delimiter $$
create trigger studentlog_delete
after delete on students
for each row
begin
insert into studentlog values (CURRENT_DATE(), old.firstname , 'delete operation');
end $$
delimiter ;

/*3. Create a Trigger that adds “+91” to all Phone numbers in the students table.
Test and see if the Trigger works properly by inserting and updating some data in the table.*/
delimiter $$
create trigger add_country_code
before insert on students
for each row
begin
set new.phoneno = concat('+91',new.phoneno);
end $$
delimiter ;

/*2. Create a trigger that displays a message prior to an insert operation on the students table.*/
set @mess = '';
delimiter $$
create trigger display_message
before insert on students
for each row
begin
set @mess = 'Want to insert new coloumn';
end $$
delimiter ;

/*4. Modify the structure/create new by splitting the column name to ( First name and Last name)
and copy the values appropriately into it.*/
delimiter $$
create trigger split_details
before insert on students
for each row 
begin
if new.lastname = NULL then
set new.firstname = substring_index(new.firstname,' ',1);
set new.lastname = substring_index(new.firstname,' ',2);
elseif new.firstname = null then
set new.firstname = substring_index(new.lastname, ' ',1);
set new.lastname = substring_index(new.firstname,' ',2);
end if ;
end $$
delimiter ;

/*9. Create a trigger when someone tried to insert a value into a students table values are
inserted into views.*/
create table views
(
    name varchar(225)
);

delimiter $$
create trigger insert_into_views
before insert on students
for each row
begin
insert into views values(concat(new.firstname,' ',new.lastname));
end $$
delimiter ;







