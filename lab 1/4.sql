create database lab14 ;
use lab14 ;
CREATE TABLE Car
(
	Serial_no INT NOT NULL PRIMARY KEY,
	Model VARCHAR(255),
	Manufacturer VARCHAR(255),
	Price INT
);

CREATE TABLE Options
(
	Serial_no INT,
	Option_name VARCHAR(255),
	Price INT,
	FOREIGN KEY (Serial_no) REFERENCES Car(Serial_no)
);

CREATE TABLE Salesperson
(
	Salesperson_id INT NOT NULL PRIMARY KEY,
	Name VARCHAR(255),
	Phone bigint
);

CREATE TABLE Sales
(
	Salesperson_id INT,
	Serial_no INT,	
	Date Date,
	Sale_price INT,
	FOREIGN KEY (Serial_no) REFERENCES Car(Serial_no),
	FOREIGN KEY (Salesperson_id) REFERENCES Salesperson(Salesperson_id)
);

INSERT INTO Car VALUES(1, "mer81", "Mercedes",50000);
INSERT INTO Car VALUES(2, "adllsd", "Mercedes",1000000);
INSERT INTO Car VALUES(3, "asdl", "Mercedes",750000);
INSERT INTO Car VALUES(4, "Pqasdfr", "Bugatti",2000000);
INSERT INTO Car VALUES(5, "Lmasfdn", "Bugatti",5000000);
INSERT INTO Car VALUES(6, "Rfsdst", "Bugatti",2500000);

INSERT INTO Options VALUES(1, "Airbag", 10000);
INSERT INTO Options VALUES(1, "Button_Key", 5000);
INSERT INTO Options VALUES(2, "Airbag", 10000);
INSERT INTO Options VALUES(2, "Button_Key", 5000);
INSERT INTO Options VALUES(3, "Airbag", 10000);
INSERT INTO Options VALUES(3, "Button_Key", 5000);
INSERT INTO Options VALUES(4, "Airbag", 10000);
INSERT INTO Options VALUES(4, "Button_Key", 5000);
INSERT INTO Options VALUES(5, "Airbag", 10000);
insert into Options (Serial_no , price)
values(6,100000);
INSERT INTO Options
VALUES(5, "Button_Key", 5000);

INSERT INTO Salesperson
VALUES(1, "John", 1234567890);
INSERT INTO Salesperson
VALUES(2, "Osaasdfdj", 987653210);
INSERT INTO Salesperson
VALUES(3, "Kfjfsadsd", 543210876);
INSERT INTO Salesperson
VALUES(4, " Rshydgfs", 987602345);
INSERT INTO Salesperson
VALUES(5, "Psjaafds", 123509876);

INSERT INTO Sales
VALUES(1, 5, "2019-02-01",5015000);
INSERT INTO Sales
VALUES(2, 2, "2019-03-05",1010000);
INSERT INTO Sales
VALUES(3, 1, "2019-01-07",505000);
INSERT INTO Sales
VALUES(4, 3, "2019-12-09",2000000);
INSERT INTO Sales
VALUES(5, 4, "2019-11-10",751500);
insert into Sales
values(1,6,'2019-1-1',34233223);

SELECT * FROM Car;
SELECT * FROM Options;
SELECT * FROM Salesperson;
SELECT * FROM Sales;

--for the sales person named 'John' list the information for all
--the cars sold : serial no, manufacturer , sale price 
select e2.Serial_no as serial_no , e2.Manufacturer as Manufacturer , e1.Sale_price as Sale_price
from Sales as e1 , Car as e2  where e1.Serial_no = e2.Serial_no and e1.Serial_no in 
(Select Serial_no from Sales where Salesperson_id in
(
    Select Salesperson_id from Salesperson where name like 'John'
));

--list the Serial_no and Model of cars that have no options
select Serial_no , Model
from Car 
where Serial_no in
(select Serial_no from Options where Option_name is NULL);

--list the serial_no , model, sale_price for the cars that have optional parts.
Select e1.Serial_no as serial_no , e1.Model as model , e2.Sale_price
from Car as e1 , Sales as e2 where e1.Serial_no = e2.Serial_no and e1.Serial_no in
(Select Serial_no from Options where Option_name is not NULL)
order by e1.Serial_no ;

--modify the phone no of a particular sales person
update Salesperson 
set Phone = 783223
where Salesperson_id = 1 ;
select Phone from Salesperson where Salesperson_id in (1,2 ,3,4) ;
