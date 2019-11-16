create table students(rollno varchar(100) , lastname varchar(100), firstname varchar(100), email varchar(100), classyear int, major varchar(100),phoneno varchar(100), primary key(rollno));

create table studentlog(time date, rollno varchar(100), action varchar(100));

insert into students values('106117005', 'kumar', 'aditya','kumaraditya@gmail.com',2015,'cse','7769004585');
insert into students values('106115007', 'lastname', 'aditya2','kumaradya2@gmail.com',2016,'cse','7869004586');
insert into students values('106115008', 'lastname2', 'aditya3','kumaradya4@gmail.com',2014,'cse','7839004586');

1.Create a trigger which will calculate the number of rows we have inserted till now. 

delimiter //
create trigger no_of_rows 
after insert on students
for each row
begin
	set @rc = (select count(*) from students);
end //
delimiter ;


select @rc;

+------+
| @rc  |
+------+
|    2 |
+------+


2. Create a trigger that displays a message prior to an insert operation on the students table 

delimiter //

create trigger disp_message
before insert on students
for each row
begin
	set @message = 'inserting data into dbms';
end //
delimiter ;

select @message;
+--------------------------+
| @message                 |
+--------------------------+
| inserting data into dbms |
+--------------------------+


3.Create a Trigger that adds “+91” to all Phone numbers in the students table. Test and see if the Trigger works properly by inserting and updating some data in the table.


delimiter //

create trigger update_phone_no
before insert on students
for each row
begin
	set new.phoneno = concat('+91',new.phoneno);
end //
delimiter ;


select * from students;
+-----------+-----------+-----------+------------------------+-----------+-------+---------------+
| rollno    | lastname  | firstname | email                  | classyear | major | phoneno       |
+-----------+-----------+-----------+------------------------+-----------+-------+---------------+
| 106117006 | kumar2    | aditya2   | kumaraditya2@gmail.com |      2016 | cse   | 7769004586    |
| 106117005 | kumar     | aditya    | kumaraditya@gmail.com  |      2015 | cse   | 7769004585    |
| 106115008 | lastname2 | aditya3   | kumaradya4@gmail.com   |      2014 | cse   | +917839004586 |
+-----------+-----------+-----------+------------------------+-----------+-------+---------------+


4.Modify the structure/create new by splitting the column name to ( First name and Last name) and copy the values appropriately into it.

5.Create  a  trigger  that  whenever  an  insert,  update,  or  delete  operation occurs  on  the students table, a row is added to the studentlog table recording the date, user, and action.

delimiter //

CREATE TRIGGER before_students_insert
	BEFORE INSERT ON students
FOR EACH ROW
BEGIN
	INSERT INTO studentlog VALUES (NOW(), CURRENT_USER(), 'INSERT');
END//

CREATE TRIGGER before_students_update
	BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
	INSERT INTO studentlog VALUES (NOW(), CURRENT_USER(), 'UPDATE');
END//

CREATE TRIGGER before_students_delete
	BEFORE DELETE ON students
FOR EACH ROW
BEGIN
	INSERT INTO studentlog VALUES (NOW(), CURRENT_USER(), 'DELETE');
END//

delimiter ;

mysql> select * from studentlog;
+------------+----------------+--------+
| dt         | usr            | action |
+------------+----------------+--------+
| 2019-09-19 | root@localhost | UPDATE |
| 2019-09-19 | root@localhost | DELETE |
+------------+----------------+--------+


6.Create a trigger to insert student details into student table only if classyear 2015

delimiter //

create trigger trg_trigger_test_ins before insert on students
for each row
begin
    declare msg varchar(128);
    if new.classyear > 2015 then
        UPDATE `Error: clasyear > 2015` SET x=1;
    end if;
end
// 

delimiter ;
	


7.Create a trigger to prevent any student named John to be inserted into the table.

delimiter //

create trigger no_john before insert on students
for each row
begin
    declare msg varchar(128);
    if new.firstname in ('John') then
        UPDATE `Error: cannot insert John` SET x=1;
    end if;
end
// 
delimiter ;


8.Create a trigger to raise an exception if the rollno is changed.

delimiter //

create trigger no_roll before update on students
for each row
begin
    declare msg varchar(128);
    if new.rollno != old.rollno then
        UPDATE `Error: cant change roll number` SET x=1;
    end if;
end
//

delimiter ;


9. Create a trigger when someone tried to insert a value into a students table values are inserted into views

delimiter //

CREATE TRIGGER view_insert
after INSERT
ON students
for each row
begin
    insert into students_view values(new.rollno, new.lastname, new.firstname,new.email, new.classyear, new.major, new.phoneno);
end //

delimiter ;
    

