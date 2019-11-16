import mysql.connector

#connector initializer
mydb = mysql.connector.connect(
    host = 'localhost',
    user = 'ashu' ,
    passwd = 'ashu'
)

#database creation
x = input("What is your database name :")
cursor = mydb.cursor()
sql = """create database %s """% x
cursor.execute(sql)
mydb.commit()

#using database
cursor = mydb.cursor()
cursor.execute("use %s"%x)
mydb.commit()
#checking database exit
cursor.execute("show databases")
for y in cursor:
    print(y)

#creating a table rrs
cursor.execute("create table rrs(seatno int primary key auto_increment , name varchar(225) , source varchar(225) , destination varchar(225))")
mydb.commit()

# #printing the table information 
cursor.execute("desc rrs")
for y in cursor:
    print(y)

def bookticket():
    x = input("Enter your name : ")
    y = input("Enter your source station :")
    z = input("Enter your destination station :")
    cursor = mydb.cursor()
    sql = "insert into rrs (name , source , destination) values (%s , %s , %s)"
    record_tuple = (x , y , z)
    cursor.execute(sql, record_tuple)
    print("Successfully ticket booked")
    mydb.commit()

def showdetails():
    x = input("Enter your name :")
    print("Showing your details.......")
    print("Seat no \t name of passanger \t source station \t destination station")
    cursor = mydb.cursor()
    record_tuple = (x,) 
    sql = "select * from rrs where name = %s" 
    cursor.execute(sql,record_tuple)
    myresult =  cursor.fetchall()
    for z in myresult:
        print(z)
    mydb.commit()

def updatedetails():
    x = int(input("Enter your seat no :"))
    y = input("Enter your new destination station :")
    cursor = mydb.cursor()
    record_tuple = (y , x)
    sql = "update rrs set destination = %s where seatno = %s"
    cursor.execute(sql,record_tuple)
    mydb.commit()
    print("Successfully destination updated")

def cancelticket():
    x = int(input("Enter seatno :"))
    cursor = mydb.cursor()
    record_tuple = (x,) 
    sql = "delete from rrs where seatno = %s"
    cursor.execute(sql,record_tuple)
    mydb.commit()
    print("Successfully ticket cancel")




while 1:
    print()
    print("press 1 to book ticket")
    print("press 2 to show details of passanger")
    print("press 3 to update destination of passanger")
    print("press 4 to cancel the ticket")
    print("press any integer to logout")
    x = int(input())
    if x == 1:
        bookticket()
    
    elif x == 2:
        showdetails()
    
    elif x == 3:
        updatedetails()

    elif x == 4:
        cancelticket()
    
    else :
        break
