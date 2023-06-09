CREATE DATABASE db_MiniProject


--CREATE TABLE STARTS

CREATE TABLE tbl_Customer(
	CustomerID int IDENTITY(100,1) PRIMARY KEY,
    FirstName varchar(15) NOT NULL,
	LastName varchar(15) NOT NULL,
	Address varchar(50) NOT NULL,
	City varchar(25) NOT NULL,
	State varchar(30) NOT NULL,
	ZipCode INT NOT NULL,
	ContactNumber BIGINT NOT NULL UNIQUE 
	CONSTRAINT tbl_Customer_ContactNumber CHECK (len(ContactNumber)=10) 
	)


CREATE TABLE tbl_Login (
    UserName VARCHAR(15) PRIMARY KEY,
    CustomerId INT REFERENCES tbl_Customer(CustomerId),
    Password VARCHAR(14) ,
    Email VARCHAR(20) NOT NULL,
    CONSTRAINT tbl_Login_Email CHECK (Email LIKE '%@%.%')
);

BEGIN TRAN

ALTER TABLE tbl_Login
ADD Password VARBINARY(40);

UPDATE tbl_Login
SET Password = HASHBYTES('MD2', Password);

SELECT  * FROM tbl_Login


CREATE TABLE tbl_Chef 
( Chef_Id INT PRIMARY KEY, 
FirstName VARCHAR(10), 
LastName VARCHAR(10),
Experience INT, 
Speciality VARCHAR(30) 
)


CREATE TABLE tbl_Restaurant
(
 RestaurantId  INT IDENTITY(200,1) PRIMARY KEY,
 RestaurantName VARCHAR(30) NOT NULL,
 RestaurantAddress VARCHAR(50) NOT NULL,
 City VARCHAR(15) NOT NULL,
 State VARCHAR(10) NOT NULL,
 Zipcode	INT NOT NULL,
 OperatingHrs VARCHAR(12) NOT NULL,
 OperatingDays VARCHAR(10) NOT NULL,
 Chef_id INT REFERENCES tbl_Chef(Chef_Id)
)


CREATE TABLE tbl_FoodItems
(
FoodItemId INT IDENTITY(300,1) PRIMARY KEY,
FoodName VARCHAR(40) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Category VARCHAR(10) NOT NULL,
RestaurantId  INT REFERENCES Tbl_Restaurant(RestaurantId),
FoodDescription VARCHAR(45) NOT NULL
)

CREATE TABLE tbl_Card (
  CardId INT IDENTITY(400,1) PRIMARY KEY,
  CustomerId INT REFERENCES tbl_Customer(CustomerId),
  CardNumber BIGINT NOT NULL,
  CONSTRAINT tbl_Card_CardNumber CHECK (LEN(CONVERT(VARCHAR, CardNumber)) = 16),
  CardHolderName VARCHAR(15) NOT NULL,
  ExpiryDate DATE NOT NULL,
  CardType VARCHAR(15) NOT NULL,
  CVV INT NOT NULL,
  CONSTRAINT tbl_Card_CVV CHECK (LEN(CONVERT(VARCHAR, CVV)) = 3 OR LEN(CONVERT(VARCHAR, CVV)) = 4)
);


ALTER TABLE tbl_Card
ALTER COLUMN ExpiryDate CHAR(7)

ALTER TABLE tbl_Card
ADD CONSTRAINT tbl_Card_ExpiryDate CHECK (ExpiryDate LIKE '[0-1][0-9]/[1-2][0-9][0-9][0-9]' )


CREATE TABLE tbl_Promocode
(
Promocode VARCHAR(40) PRIMARY KEY,
StartDate DATE,
EndDate DATE,
Discount DECIMAL(10,2)
)

ALTER TABLE tbl_Promocode
ADD CONSTRAINT tbl_Promocode_EndDate CHECK (EndDate > StartDate);

CREATE TABLE tbl_DeliveryStaff(
DeliveryStaffId INT IDENTITY(500,1) PRIMARY KEY,
FirstName VARCHAR(15),
LastName VARCHAR(15),
ContactNumber BIGINT
CONSTRAINT tbl_DeliveryStaff_ContactNumber CHECK (len(ContactNumber)=10)
)

CREATE TABLE Tbl_Delivery
(
DeliverId INT IDENTITY(600,1) PRIMARY KEY,
DeliveryStatus VARCHAR(20),
DeliveryStaffId INT REFERENCES Tbl_DeliveryStaFf(DeliveryStaffId),
DeliveryAddress VARCHAR(50) NOT NULL,
EstimatedTimeOfDelivery VARCHAR(15) NOT NULL,
DeliveryInstruction VARCHAR(45)
)

CREATE TABLE tbl_Order(
OrderID INT IDENTITY(700,1) PRIMARY KEY,
CustomerId INT REFERENCES tbl_Customer(CustomerId),
RestaurantId  INT REFERENCES tbl_Restaurant(RestaurantId),
FoodItemId INT REFERENCES Tbl_FoodItems(FoodItemId),
Quantity INT NOT NULL,
FoodItemAmount DECIMAL(10,2) NOT NULL,
OrderInstruction VARCHAR(45),
OrderStatus VARCHAR(15),
OrderDate DATE,
DeliverId INT REFERENCES Tbl_Delivery(DeliverId)
)


CREATE TABLE tbl_Bill
(
BillId INT IDENTITY(800,1) PRIMARY KEY,
OrderID INT REFERENCES tbl_Order(OrderId),
TaxAmount DECIMAL(10,2) DEFAULT 10,
TipAmount DECIMAL(10,2) DEFAULT 0,
DeliveryCharges DECIMAL(10,2) DEFAULT 0,
PROMOCODE DECIMAL(10,2) DEFAULT 0,
Discounted DECIMAL(10,2) DEFAULT 0,
TotalAmount DECIMAL(10,2) NOT NULL,
)

CREATE TABLE tbl_Payment 
(PaymentID INT IDENTITY(900,1) PRIMARY KEY,
CardId INT REFERENCES Tbl_Card(CARDID),
BillId INT REFERENCES Tbl_bill(BillId),
CustomerId INT REFERENCES tbl_Customer(CustomerId),
PaymentStatus VARCHAR(20),
PaymentType VARCHAR(15),
PaymentDate DATE
)

CREATE TABLE tbl_Review
(
FeedbackId INT PRIMARY KEY,
Reviews VARCHAR(90),
Ratings INT CHECK (Ratings>=0 and Ratings<=5),
ReviewDate DATE,
CustomerId INT REFERENCES tbl_Customer(CustomerId),
RestaurantId  INT REFERENCES tbl_Restaurant(RestaurantId),
FoodItemId INT REFERENCES tbl_FoodItems(FoodItemId)
)


CREATE TABLE Audit
(id int identity , AuditInformation VARCHAR(max))



SELECT NAME FROM SYS.TABLES

SELECT * FROM dbo.tbl_Customer;
SELECT * FROM dbo.tbl_Login;
SELECT * FROM dbo.tbl_Restaurant;
SELECT * FROM dbo.tbl_Chef;
SELECT * FROM dbo.tbl_FoodItems;
select * from dbo.tbl_Order
SELECT * FROM dbo.tbl_Card;
SELECT * FROM dbo.tbl_Promocode;
SELECT * FROM dbo.tbl_DeliveryStaff;
SELECT * FROM dbo.tbl_Delivery;
SELECT * FROM dbo.tbl_Bill;
SELECT * FROM dbo.tbl_Payment;
SELECT * FROM dbo.tbl_Review;
SELECT * FROM dbo.Audit;




--CREATE TABLE ENDS

--INSERTING VALUES START

INSERT INTO dbo.tbl_Customer VALUES
								('Vineet','K','7 West Ave #1','Columbia','SC',29201,'9066625436'),
								('Sailee','A','669 Packerland Dr #1438','Denver','CO',80212,'9220123123'),
								('Charu','B','759 Eldora St','New Haven','CT',6515,'9123123123'),
								('MIHIR','C','5 S Colorado Blvd #449','Bothell','WA',98021,'9876543211'),
								('ARYA','D','944 Gaither Dr','Strongsville','OH',44136,'9321654432'),
								('DIVYA','E','66552 Malone Rd','Plaistow','NH',3865,'9876123456'),
								('ANKUR','F','77 Massillon Rd #822','Satellite Beach','FL',32937,'9762785423'),
								('SACHIN','B','25346 New Rd','New York','NY',10016,'9872223456'),
								('Shwetha','W','60 Fillmore Ave','Huntington Beach','CA',92647,'9876127776'),
								('Priya','T','42744 Hamann Industrial Pky #82','Miami','FL',33155,'9387655556')

SELECT * FROM tbl_Customer

INSERT INTO dbo.tbl_Customer VALUES
								('MAMATA','A','42744 H1 amann Industrial Pky #82','Miami','FL',33155,'93876555561')


INSERT INTO dbo.tbl_Login VALUES
							('Vineet123',100, 'Vinnet123$','vineet123@gmail.com'),
							('Sailee123',101, 'Sailee123$','sailee123@gmail.com'),
							('Charu123',102, 'Charu123$','charu123@gmail.com'),
							('Mihir123',103, 'Mihir123$','mihir123@gmail.com'),
							('Arya123',104, 'Arya123$','arya123@gmail.com'),
							('Divya123',105, 'Divya123$','divya123@gmail.com'),
							('Ankur123',106, 'Ankur123$','ankur123@gmail.com'),
							('Sachin123',107, 'Sachin123$','sachin123@gmail.com'),
							('Shwetha123',108, 'Shwetha123$','shwetha123@gmail.com'),
							('Priya123',109, 'Priya123$','priya123@gmail.com');		

SELECT * FROM tbl_login

INSERT INTO dbo.tbl_Login VALUES
							('Vineet1234',100, 'Vinnet123$','vineet123gmail.com')


INSERT INTO dbo.tbl_Restaurant VALUES	
									('Chat House'				,'148 Ave NE'			,'Bellevue'	,'Washington',98007,'9AM-9PM'  ,'Mon-Fri',1),
									('Cactus'					,'350 Terry Ave NE'		,'Seattle'	,'Washington',98105,'9AM-11PM' ,'Mon-Sun',2),
									('Serious Pie and Biscuits'	,'401 Westlake Ave N'	,'Seattle'	,'Washington',98109,'9AM-11PM' ,'Mon-Sun',3),
									('The pink door'			,'1919 Post Alley'		,'Seattle'	,'Washington',98109,'11AM-12AM','Mon-Sun',4),
									('Mediterranean Kitchen'	,'103 Bellevue way'		,'Bellevue'	,'Washington',98007,'9AM-12AM' ,'Mon-Sun',5),
									('Taste Of India'			,'121 University Way'	,'Seattle'	,'Washington',98005,'9AM-11PM' ,'Mon-Sun',6),
									('Din Tai Fung'				,'700 Bellevue way'		,'Bellevue'	,'Washington',98007,'9AM-11PM' ,'Mon-Sun',7),
									('Zig Zag Cafe'				,'1501 Western Ave'		,'Bellevue'	,'Washington',98007 ,'9AM-9PM'  ,'Mon-Sun',8),
									('Lola'						,'2000 4th Ave Belltown','Seattle'	,'Washington',98102,'9AM-9PM'  ,'Mon-Sun',9),
									('New'						,'1519 Capital Hill'	,'Seattle'	,'Washington',98109,'9AM-9PM'  ,'Mon-Sun',10),
									('Art Of the Table'			,'3801 Stone Way'		,'Seattle'	,'Washington',98109,'9AM-9PM'  ,'Mon-Sun',11);


SELECT * FROM dbo.tbl_Restaurant


SELECT * FROM dbo.tbl_Chef

INSERT into dbo.tbl_FoodItems VALUES
								  ( 'BRUSCHETTA CON CAPONATA'			, 100,'Dinner',  200 , 'eggplant, tomatoes, celery'),
								  (  'GRILLED OCTOPUS'					, 5000,'Dinner'	,201, 'capers, frisee & olives'),
								  (  'PIZZA BIANCA'					    , 300,'Lunch'	,202 , 'individual sized pizza'),
								  (  'GRILLED ITALIAN SAUSAGE'			,200, 'Dinner',  203 , 'w/fried peppers and onions'),
								  (  'BUTTERSCOTCH BUDINO'				, 100,'Dessert'	,204 , 'tuile cookie'),
								  (  'PUMPKIN TART'					    ,150, 'Dessert'	,205  , 'toasted meringue'),
								  (  'The LUXE Burger'					,250, 'Burgers'	,206 , 'grilled burger,white truffle cheese'),
								  (  'Lucky Star Burger'				,500, 'Burgers'	,207, 'grilled burger,smoked gouda cheese'),
								  (  'Pumpkin Spice Cake'				,1000, 'Dessert',208, 'All time favourite cake'),
								  (  'Chocolate Chip Cookie'			,300, 'Dessert'	,209 , 'cane juice, dark chocolate chips'),
								  (  'Butter Masala Dosa'				,100, 'Breakfast',210 , 'Rice pancake with potato filling'),
								  (  'Potato Parantha'					,160, 'Breakfast',200  , 'whole wheat stuffed bread'),
								  (  'Paneer Tikka Masala'				,200, 'Lunch'	 ,201, 'Indian cheese in creamy tomato sauce'),
								  (  'Kadhai Chicken'					,500, 'Dinner'	 ,202, 'chicken, peppers with spicy sauce'),
								  ( 'Gulab Jamun'						,70, 'Dessert'	 ,203 , 'Spongy milky balls with rose scented syrup'),  
								  (  'Falafel Sandwich'				    ,100, 'Lunch'	 ,204, 'Falafel, hummus, romaine, tomatoes, parsley'),
								  (  'Chicken Kebab Plate'				,400, 'Lunch'	 ,205, 'Sliced rotisserie chicken, grilled and hummus'),
								  (  'Gralic Fries'					    ,100, 'Sides'	 ,206, 'Seasoned fries, cheese and oregano'),
								  (  'Beef and Lamb Shawarma Sandwich'	,300, 'Lunch'	 ,207, 'Sliced lamb mix and tahini'),
								  (  'Baklawa'							,100, 'Dessert'	 ,208, 'Layered buttered  pistachio');


SELECT * FROM dbo.tbl_FoodItems

INSERT INTO dbo.tbl_Card VALUES 
						      (100,2468124682246812,'VineetBagga','2019-01-01','Credit',123),
							  (101,3691112223333444,'Sailee Walke','2019-05-01','Credit',456),
							  (102,4321567823456789,'Charu Desh','2020-07-01','Credit',789),
							  (103,1276127132458765,'Mihir Salunke','2019-11-01','Credit',234),
							  (104,4964237165438312,'Arya Soman','2021-11-01','Credit',345),
							  (105,7666627132458765,'Divya Sharma','2020-11-01','Credit',466),
							  (106,2333337165438312,'Ankur Gupta','2019-12-01','Credit',223),
							  (107,7767676468224681,'Sachin S','2022-11-01','Credit',443),
							  (108,4563535132458765,'Shwetha K','2021-09-01','Credit',112),
							  (109,4127637165438312,'Priya Gupta','2020-08-01','Credit',778);

SELECT * FROM dbo.tbl_Card




INSERT INTO dbo.tbl_Card VALUES 
							(115,4127637165438312,'Priya Gupta','2020-08-01','Credit',72278)

INSERT INTO dbo.tbl_Promocode VALUES	
							('THANKS15', '2018-06-11 09:00:00', '2018-06-15 12:00:00', 15.00),
							('WELCOME5', '2018-06-11 09:00:00', '2018-06-12 11:00:00', 5.00),
							('HOLIDAY20', '2018-12-20 09:00:00', '2018-12-30 00:00:00', 20.00),
							('EXTRA5', '2018-08-30 09:00:00', '2018-09-30 11:00:00', 5.00),
							('HAPPY10', '2018-05-11 09:00:00', '2018-06-11 11:00:00', 10.00),
							('NEWYEAR25', '2018-12-25 09:00:00', '2019-01-05 11:00:00', 25.00),
							('FUN20', '2018-07-11 09:00:00', '2018-07-12 11:00:00', 20.00),
							('MOTHER20', '2018-05-01 09:00:00', '2018-05-10 11:00:00', 20.00),
							('FRIDAY15', '2018-04-06 09:00:00', '2018-04-13 11:00:00', 15.00),
							('EXTRA10', '2018-09-11 09:00:00', '2018-09-12 11:00:00', 10.00);

SELECT * FROM dbo.tbl_Promocode

INSERT INTO dbo.tbl_Promocode
VALUES
		('FUNFRIDAY55', '2018-09-11 09:00:00', '2015-09-12 11:00:00', 10.00);

INSERT into dbo.tbl_DeliveryStaff VALUES	
									('John'	  ,'Doe'	,2067463524),
									('Lee'	  ,'Willams',3129876543),
									('David'  ,'Taylor'	,2069874331),
									('Salim'  ,'Khan'	,2063284597),
									('Shawn'  ,'Parker'	,3129876543),
									('Sam'	  ,'Kate'	,2069432543),
									('Zen'	  ,'Green'	,3129464343),
									('Daneil' ,'Brayon'	,3129464343),
									('Sandeep','Mishra'	,3129464343),
									('Ting'	  ,'Tong'	,3129464343);

SELECT * FROM tbl_DeliveryStaff

INSERT into dbo.tbl_Delivery VALUES
								('Delivered' 		, 500, '567 John Street,Seattle'		   , '02:00:00','Please give a call on arrival' ),
								( 'Delivered',501,'534 Elliot Ave,Seattle'				, '10:00:00','Please do not knock on arrival'	 ),
								('Delivered',502, '567 John Street,Seattle'			 , '08:00:00','Please give a call on arrival' ),
							    ('Delivery Fail',503, '83rd NE Elliot Ave,Seattle'			, '09:00:00',NULL),
								('Delivered', 504,'567 John Street,Bellevue'				 , '10:00:00',NULL),
							    ('Delivered',505, '112 Fairview Ave, Apt 605,Seattle' 	   , '05:00:00', NULL),
							    ( 'Delivered',506,'1106 11th Ave NE, Apt 402,Seattle'	, '10:00:00','Please give a call on arrival' ),
							    ( 'Delivered',507,'431 Desxter Street, Apt 301,Seattle' , '10:00:00',NULL),
						   	    ( 'Delivery fail',508,'2122 Howe Street,Apt 701,Seattle'		  ,  '10:00:00','Leave Parcel at reception'),
								( 'Delivered',509,'892 Nelson Street,Bellevue'		, '10:00:00', 'Call on arrival');

SELECT * FROM dbo.tbl_Delivery


INSERT INTO dbo.tbl_Order VALUES	



							(100,203,303,4,(SELECT FI.PRICE*4 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=303),'MAKEITSPICY','SUCCESS','2018-05-22',603),
							(101,200,300,10,(SELECT FI.PRICE*10 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=300),'MAKE IT SWEET','Success','2018-06-16 ',600),
							(102,201,301,3,(SELECT FI.PRICE*3 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=301),NULL,'Success','2018-07-21',601),
							(103,202,302,4,(SELECT FI.PRICE*4 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=302),null,'success','2018-07-21',602),
							(104,203,303,4,(SELECT FI.PRICE*4 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=303),'MAKEITSPICY','SUCCESS','2018-05-12',603),
							(105,204,304,4,(SELECT FI.PRICE*4 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=304),NULL,'Success','2018-06-16 ',604),
							(106,204,315,3,(SELECT FI.PRICE*3 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=315),NULL,'Success','2018-06-16 ',602),
							(107,204,315,5,(SELECT FI.PRICE*5 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=315),NULL,'Success','2018-06-16 ',602),	
							(108,200,311,10,(SELECT FI.PRICE*10 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=311),'MAKE IT SPICY','Success','2018-8-16 ',600),
							(109,201,312,3,(SELECT FI.PRICE*3 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=312),NULL,'Success','2018-07-21',601),
							(110,200,311,5,(SELECT FI.PRICE*5 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=311),null,'Success','2019-07-22',600),
							(102,201,301,3,(SELECT FI.PRICE*3 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=301),NULL,'Success','2023-05-28',601),
							(103,202,302,4,(SELECT FI.PRICE*4 FROM Tbl_FoodItems FI WHERE FI.FoodItemId=302),null,'success','2023-05-21',602)

SELECT * FROM dbo.tbl_Order
		
		

INSERT INTO dbo.tbl_Bill values 
							(711,100,100,10,0,0,8000),
							(722,1500,20,0,10,10,16510),
							(723,120,50,10,0,0,1380),
							(724,80,10,10,50,50,850),
							(725,100,10,20,0,0,100),
							(726,100,10,50,50,50,100),
							(727,10,10,0,0,0,100),
							(728,80,10,10,50,50,850),
							(729,100,10,20,0,0,100),
							(730,100,10,50,50,50,100),
							(732,10,10,0,0,0,100),
							(734,80,10,10,50,50,850)


SELECT * FROM dbo.tbl_Bill
			

INSERT INTO  dbo.tbl_Payment VALUES
								(400,804,100,'SUCCESS','CARD','2018-07-21'),
								(401,805,101,'SUCCESS','CARD','2018-08-22'),
								(402,806,102,'SUCCESS','CARD','2018-07-20')
								(404,808,103,'Success','CARD','2018-07-21'),
								(405,809,104,'Success','CARD','2018-05-12'),
								(405,810,105,'Success','CARD','2018-06-16'),
								(406,811,106,'Success','CARD','2018-06-16'),
								(407,812,107,'Success','CARD','2018-06-16'),
								(408,813,108,'Success','CARD','2018-06-16')
SELECT * FROM dbo.tbl_Payment	

INSERT INTO dbo.tbl_Review values
					  (1,'Amazing',5,'2018-06-18',100,200,300),
					  (2,'Wonderful',4,'2018-07-21',101,201,301),
					  (3,'Not so good',2,'2018-05-01',102,202,302),
					  (4,'Fantastic',5,'2018-02-02',103,202,302),
					  (5,'Average',3,'2018-11-25',104,203,303),
					  (6,'Must Try',4,'2018-12-20',105,204,304),
					  (7,'Amazing',5,'2018-06-18',106,204,315),
					  (8,'Wonderful',4,'2018-07-21',107,204,315),
					  (9,'Not so good',2,'2018-05-01',108,200,311),
					  (10,'Fantastic',5,'2018-02-02',109,201,312)
		

INSERT INTO dbo.tbl_Review values
						(11,'Average',8,'2018-11-25',110,204,304)


SELECT * FROM tbl_Review
	
--INSERT VALUES ENDS


--TRIGGERS START

--DDL TRIGGERS STARTS 

-- 1)SHOWING A MESSAGE IF WE CREATE OR UPDATE OR ALTER A TABLE

CREATE TRIGGER tr_MessageDB
ON DATABASE 
FOR ALTER_TABLE,DROP_TABLE,CREATE_TABLE
AS 
BEGIN
PRINT 'YOU HAVE CREATED OR ALTERED OR DROPED THE TABLE SUCCESSFULLY'
END

CREATE TABLE MYTable(ID int, Name Varchar(45))




DROP TABLE MYTable

--2)GETTING THE SQLCommands Inforamtion into AuditTable

CREATE TRIGGER tr_AuditTableChanges
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
SELECT EVENTDATA();
END 


CREATE TABLE AuditTableChanges(
DatabaseName VARCHAR(20),
TableName VARCHAR(20),
EventType VARCHAR(20),
LoginName VARCHAR(20),
SQLCommand VARCHAR(1000),
AuditDateTime DATETIME
)


ALTER TRIGGER  tr_AuditTableChanges
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN

DECLARE @EventData XML
SELECT @EventData = EVENTDATA();

INSERT INTO db_MiniProject.dbo.AuditTableChanges VALUES
(
@EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]','VARCHAR(20)'),
@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','VARCHAR(20)'),
@EventData.value('(/EVENT_INSTANCE/EventType)[1]','VARCHAR(20)'),
@EventData.value('(/EVENT_INSTANCE/LoginName)[1]','VARCHAR(20)'),
@EventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','VARCHAR(1000)'),
GETDATE()
)
END

SELECT * FROM AuditTableChanges

ALTER TABLE MyTable ALTER COLUMN Name VARCHAR(30);




--DDL TRIGGERS ENDS


--DML TRIGGER START

--3)Updating Inforamtion Regarding INSERTION OF CUSTOMER INFORMATION

CREATE TRIGGER tr_tbl_Customer_ForInsert
ON tbl_customer
FOR INSERT
AS
BEGIN
DECLARE @new VARCHAR(100)
SELECT @new=FirstName+LastName FROM Inserted
INSERT INTO Audit
VALUES('NEW PERSON NAMED ' +@new+  ' registered on '+ CAST(GETDATE() AS VARCHAR) )
END

INSERT INTO tbl_Customer VALUES
('Amrut1','D','Hubli','KARNATAKA','IND',580013,9036625136)


SELECT * FROM Audit

SELECT * FROM tbl_Customer

--4)Updating Inforamtion Regarding DELETION OF CUSTOMER INFORMATION

CREATE TRIGGER tr_tbl_Customer_ForDelete
ON Tbl_Customer
FOR DELETE
AS
BEGIN
DECLARE @id int
SELECT @id=CustomerId FROM Deleted
INSERT INTO Audit 
VALUES ('PERSON WITH CUSTOMER ID ' + cast(@id as varchar) + ' Got deleted ')
END


DELETE FROM tbl_Customer
WHERE CustomerID = 125

SELECT * FROM tbl_Customer

SELECT * FROM dbo.Audit



--5)UPDATION REGAERDING REVIEW TABLE 

SELECT * FROM dbo.tbl_Review

CREATE TRIGGER tr_tbl_Review_ForUpdate
on tbl_Review
for update
as
begin
DECLARE @FeedbackId int
DECLARE @oldreview varchar(45), @newreview varchar(45)
DECLARE @oldratings int,@newratings int
DECLARE @oldrdate date,@newrdate date
DECLARE @oldcustomerid int,@newcustomerid int
DECLARE @oldrestid int ,@newrestid int
DECLARE @oldfooditemid int,@newfooditemid int

DECLARE @AUDIT VARCHAR(1000)

SELECT * INTO #TEMPTABLE FROM INSERTED

WHILE(EXISTS(SELECT feedbackId from #TEMPTABLE))
begin
SET @AUDIT =''


SELECT TOP 1 @FeedbackId=feedbackId,
@newreview=REVIEWS,@newratings=ratings,@newrdate=ReviewDate,@newcustomerid=customerid
,@newrestid=restaurantid,@newfooditemid=FoodItemId
from #TEMPTABLE


SELECT TOP 1 @FeedbackId=feedbackId,
@oldreview=REVIEWS,@oldratings=ratings,@newrdate=ReviewDate,@oldcustomerid=customerid
,@oldrestid=restaurantid,@oldfooditemid=FoodItemId
from deleted where FeedbackId=@feedbackid


SET @AUDIT = 'REVIEW WITH ID '+ CAST (@FeedbackId as varcHAR) +' changed '

if(@oldreview<>@newreview)
SET @AUDIT = @AUDIT + ' REVIEW CHANGED FROM '+ @oldreview +' TO '+@newreview

if(@oldratings<>@newratings)
SET @AUDIT = @AUDIT + ' RATINGS CHANGED FROM '+ CAST(@oldratings AS VARCHAR) +' TO '+CAST(@newratings AS VARCHAR)

if(@oldrdate<>@newRDATE)
SET @AUDIT = @AUDIT + ' DATE CHANGED FROM '+ CAST(@oldrdate AS VARCHAR) +' TO '+ CAST(@newrdate AS VARCHAR)

INSERT INTO Audit VALUES(@AUDIT)

DELETE FROM #TEMPTABLE WHERE FeedbackId=@FeedbackId
END
END

SELECT * FROM dbo.tbl_Review


UPDATE dbo.tbl_Review
SET RATINGS=4
WHERE FeedbackId=4


select * from Audit

--DML TRIGGER ENDS


--6)AFTER TRIGGER FOR TAX
CREATE TRIGGER tr_tbl_Bill_TaxAmount
ON tbl_Bill
AFTER INSERT
AS
BEGIN
    UPDATE tbl_Bill
    SET TaxAmount = 0.10*od.FoodItemAmount
    FROM tbl_Bill bl 
    JOIN inserted ON bl.BillId = inserted.BillId
	JOIN tbl_Order od ON od.OrderID=bl.OrderID
END

SELECT * FROM Tbl_FoodItems
SELECT * FROM tbl_Order
SELECT * FROM tbl_Bill


INSERT INTO tbl_Bill VALUES (735,100,20,10,10,10,10)

--7)AFTER TRIGGER FOR FOODITEMPRICE 

CREATE TRIGGER trg_CalculateTotalAmount
ON tbl_Bill
AFTER INSERT
AS
BEGIN
    UPDATE tbl_Bill
    SET TotalAmount = bl.TaxAmount + bl.TipAmount + bl.DeliveryCharges - bl.Discounted + od.FoodItemAmount
    FROM tbl_Bill bl 
    JOIN inserted ON bl.BillId = inserted.BillId
	JOIN tbl_Order od ON od.OrderID=bl.OrderID
END



--TRIGGERS ENDS

--STORED PROCEDURES START

--1)To count the cust numbers

CREATE PROCEDURE usp_TotalCountofCustomer
AS BEGIN
select COUNT(*) from tbl_Customer
END

EXEC dbo.usp_TotalCountofCustomer


SELECT * FROM tbl_Customer

--2)UPDATE NAME OF CUSTOMER

CREATE PROCEDURE usp_updateNameByCustomerID
@CustomerName VARCHAR(15),
@CustomerID INT
AS
BEGIN
UPDATE dbo.tbl_Customer
SET FirstName=@CustomerName
WHERE CustomerID=@CustomerID
END

SELECT * FROM dbo.tbl_Customer

EXEC dbo.usp_updateNameByCustomerID 'AMRUT',100

--3)GETTING THE COUNT OF ORDERS FROM RESTURANT


CREATE PROCEDURE usp_GetOrderCountByRestaurantID
@count INT OUTPUT,
@rest INT
AS
BEGIN
SELECT @count=COUNT(*)  FROM dbo.TBL_ORDER
where RestaurantId=@REST 
END


SELECT * FROM tbl_Order

DECLARE @out int
EXEC dbo.usp_GetOrderCountByRestaurantID @out OUTPUT,200
select @out


--4)RESTAURANT TOTAL PRICE BY DATES

CREATE PROCEDURE usp_TotalAmountOfRestaurantByDate
@StartDate DATE,
@EndDate DATE,
@RestaurantId INT
AS
BEGIN
SELECT SUM(TotalAmount) FROM dbo.tbl_Bill bl JOIN dbo.tbl_Order od on bl.OrderId=od.OrderID
WHERE RestaurantId=@RestaurantId AND od.OrderDate BETWEEN @StartDate AND @EndDate
END

EXEC dbo.usp_TotalAmountOfRestaurantByDate '2018-06-15','2020-06-20',200

SELECT * FROM dbo.tbl_Order
SELECT * FROM dbo.tbl_Bill

--5)GETTING THE ORDER QUANTITY AND FOODNAME FROM RESTURANT ID


CREATE PROCEDURE usp_GetOrderDetailsByRestaurant
@RestaurantId INT
AS
BEGIN
SELECT od.Quantity,fi.FoodName FROM dbo.tbl_Order od JOIN dbo.tbl_FoodItems fi ON fi.FoodItemId=od.FoodItemId
WHERE od.RestaurantId=@RestaurantId
END

EXEC dbo.usp_GetOrderDetailsByRestaurant 201

SELECT * FROM dbo.tbl_Order
SELECT * FROM dbo.Tbl_FoodItems



--6)CHECKING PROMOCODE

CREATE PROCEDURE usp_toCheckPromoCode
@promocode VARCHAR(45),
@out VARCHAR(45) OUTPUT
AS
BEGIN
SELECT  @OUT=(CASE
WHEN Promocode=@promocode THEN 'VALID PROMOCODE'
ELSE 'INVALID PROMOCODE'
END
)
FROM dbo.tbl_Promocode
WHERE Promocode=@promocode
END

DECLARE @out varchar(25)
EXEC dbo.usp_toCheckPromoCode'EXTRA10',@out OUTPUT
IF(@out is null)
print('INVALID PROMOCODE')
else
print('VALID PROMOCODE')

--)Getting ResturantName by FoodName

CREATE PROCEDURE usp_RestaurantNameByfoodName
@FoodName VARCHAR(20),
@RestaurantName VARCHAR(25) OUTPUT
AS
BEGIN
SELECT @RestaurantName = rt.RestaurantName FROM dbo.tbl_Restaurant rt JOIN dbo.tbl_FoodItems fi
on rt.RestaurantId=fi.RestaurantId
WHERE FoodName = @FoodName
END

DECLARE @RestaurantName VARCHAR(25)
EXEC dbo.usp_RestaurantNameByfoodName 'GRILLED OCTOPUS',@RestaurantName OUTPUT
SELECT @RestaurantName as Restaurant_Name

SELECT * FROM dbo.tbl_Restaurant
SELECT * FROM dbo.tbl_FoodItems

--8)Find most valuable Customer with highest order Amount BY RESTAURANT ID

CREATE PROCEDURE usp_GetValuableCustomerByRestaurantId
@RestaurantId INT
AS
BEGIN
SELECT TOP 1 cr.FirstName,SUM(bl.TotalAmount) as TotalBill FROM tbl_Bill bl
JOIN  tbl_Order od ON bl.OrderID=od.OrderID
JOIN  tbl_Customer cr ON cr.CustomerID=od.CustomerId
WHERE od.RestaurantId= @RestaurantId
GROUP BY FirstName
ORDER BY SUM(bl.TotalAmount) DESC
END

EXEC usp_GetValuableCustomerByRestaurantId 201

SELECT cr.FirstName,SUM(bl.TotalAmount) FROM tbl_Bill bl
JOIN  tbl_Order od ON bl.OrderID=od.OrderID
JOIN  tbl_Customer cr ON cr.CustomerID=od.CustomerId
WHERE od.RestaurantId= 201
GROUP BY FirstName
ORDER BY SUM(bl.TotalAmount) 





--STRORED PROCEDURES ENDS

--VIEWS START

	
--Find most 5 valuable Customer with highest order Amount

Create View vw_TopCustomer
As
SELECT top 5 od.CustomerID,cr.FirstName,cr.LastName,SUM(od.FoodItemAmount) AS[Total Order Amount]
FROM	tbl_Order od
JOIN dbo.tbl_Customer cr
ON cr.CustomerID=od.CustomerID
GROUP BY od.CustomerID,cr.FirstName,cr.LastName
order by [Total Order Amount] DESC;

SELECT * FROM vw_TopCustomer

EXEC sp_helptext vw_TopCustomer


--Find most popular 5 restaurant having highest number of Orders

ALTER View vw_TopRestaurant
WITH ENCRYPTION
As
SELECT Top 5 rt.RestaurantName,COUNT(od.OrderID) AS[Total No of Orders]
FROM dbo.tbl_Order od
INNER JOIN dbo.tbl_Restaurant rt
ON od.RestaurantID=rt.RestaurantID
GROUP BY od.RestaurantID,rt.RestaurantName
order by [Total No of Orders] DESC;

SELECT * FROM vw_TopRestaurant


EXEC sp_helptext vw_TopRestaurant

--Find 5 most popular food item for each restaurant

Create View vw_PopularFoodItem
As
SELECT TOP 5 rt.RestaurantName AS [Restaurant Name], fi.FoodName , COUNT(od.FoodItemID) AS[No of times ordered]
FROM dbo.tbl_FoodItems fi
INNER JOIN dbo.tbl_Restaurant rt
ON fi.RestaurantID=rt.RestaurantID
INNER JOIN dbo.tbl_Order od
ON od.FoodItemID=fi.FoodItemID
GROUP BY fi.RestaurantID,rt.RestaurantName,fi.FoodName,fi.Category
Order by [No of times ordered] DESC;

SELECT * FROM vw_PopularFoodItem
--VIEWS END

--FUNCTIONS START

-- Function to GET LASTEST REVIEW
CREATE FUNCTION ufn_GetLatestReview (@restaurantId INT)
RETURNS TABLE
AS
RETURN (
    SELECT TOP 1 *
    FROM tbl_Review
    WHERE RestaurantId = @restaurantId
    ORDER BY ReviewDate DESC
);

SELECT * FROM ufn_GetLatestReview(200)


--Function to get Get Restaurants By City name
ALTER FUNCTION ufn_GetRestaurantByCity (@city VARCHAR(15))
RETURNS TABLE
AS
RETURN (
    SELECT RestaurantName,RestaurantAddress,City,State,Zipcode,OperatingDays,OperatingHrs
    FROM tbl_Restaurant
    WHERE City = @city
);

SELECT * FROM ufn_GetRestaurantByCity('Seattle')

SELECT * FROM tbl_Restaurant

--Function to Get Food Items By Category


CREATE FUNCTION ufn_GetFoodItemsByCategory (@category VARCHAR(10))
RETURNS TABLE
AS
RETURN (
    SELECT FoodName,Price,Category,FoodDescription
    FROM tbl_FoodItems
    WHERE Category = @category
);


SELECT * FROM ufn_GetFoodItemsByCategory('Dinner')

--Function to check if a customer has placed any orders in the last 30 days:

CREATE FUNCTION dbo.HasPlacedOrdersInLast30Days(@CustomerId INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @HasPlacedOrders VARCHAR(3)

    SELECT @HasPlacedOrders = CASE
                                WHEN EXISTS (
                                    SELECT 1
                                    FROM tbl_Order
                                    WHERE CustomerId = @CustomerId
                                    AND OrderDate >= DATEADD(DAY, -30, GETDATE())
                                ) THEN 'Yes'
                                ELSE 'No'
                             END

    RETURN @HasPlacedOrders
END


SELECT * FROM tbl_Order


SELECT dbo.HasPlacedOrdersInLast30Days (100) as [Has PlacedOrders In Last 30 Days]

--Function to retrieve the average ratings for a given restaurant ID:

CREATE FUNCTION dbo.GetAverageRatingsForRestaurant(@RestaurantId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AverageRatings DECIMAL(10, 2)

    SELECT @AverageRatings = AVG(Ratings)
    FROM tbl_Review
    WHERE RestaurantId = @RestaurantId

    RETURN @AverageRatings
END



SELECT dbo.GetAverageRatingsForRestaurant(203)

--FUNCTIONS ENDS


--COMMON TABLE EXPRESSION STARTS


--To retrieve the CustomerId and OrderDate for all orders placed in the last 30 days. 
WITH CTE_CustomerOrders AS (
    SELECT CustomerId, OrderDate
    FROM tbl_Order
    WHERE OrderDate >= DATEADD(DAY, -30, GETDATE())
)
SELECT c.CustomerId, c.FirstName, c.LastName, o.OrderDate
FROM tbl_Customer c
JOIN CTE_CustomerOrders o ON c.CustomerId = o.CustomerId




--To GENERATE A BILL
WITH cte_OrderDetails AS (
    SELECT FI.FoodName,O.Quantity,O.FoodItemAmount,B.TotalAmount as [Total Bill]
FROM tbl_Order O JOIN tbl_FoodItems FI 
ON  O.FoodItemId=FI.FoodItemId
JOIN tbl_Bill B ON B.OrderID=O.OrderID
WHERE OrderStatus like 'Success')

SELECT *
FROM cte_OrderDetails

--To Update the ZipCode Of New york city
WITH cte_Customers AS (
    SELECT *
    FROM tbl_Customer
    WHERE City = 'New York'
)
UPDATE cte_Customers
SET ZipCode = 121212

SELECT * FROM tbl_Customer


--Error with Join table CTE

WITH cte_Updateable AS(
SELECT * FROM tbl_Customer cr JOIN tbl_Card cd
ON cr.CustomerID=cd.CustomerId
)
UPDATE cte_Updateable
SET LastName='Deshpande'
WHERE cr.CustomerId=100


--PROVIDING THE DETAILS OF THE USERS PRESENT IN THE APPLICATION

WITH cte_UnionData AS (
    SELECT FirstName, LastName, 'Customer' AS [USERTYPE]
    FROM tbl_Customer

    UNION ALL

    SELECT FirstName, LastName, 'Chef' AS [USERTYPE]
    FROM tbl_Chef
)
SELECT *
FROM cte_UnionData
ORDER BY USERTYPE


--RECURSIVE CTE TO FIND WHICH RESTAURANT HAS HOW MANY ORDERS

WITH OrderCTE AS (
    SELECT RestaurantId, OrderID, 1 AS OrderCount
    FROM tbl_Order
   
    UNION ALL
    SELECT o.RestaurantId, o.OrderID, oc.OrderCount + 1
    FROM tbl_Order o
     JOIN OrderCTE oc ON o.RestaurantId = oc.RestaurantId
        AND o.OrderID > oc.OrderID
)
SELECT o.RestaurantId,RestaurantName, COUNT (DISTINCT(o.OrderID)) AS TotalOrders
FROM tbl_Order o
JOIN (
    SELECT RestaurantId, MAX(OrderCount) AS MaxOrderCount
    FROM OrderCTE
    GROUP BY RestaurantId, OrderID
) oc ON o.RestaurantId = oc.RestaurantId
JOIN tbl_Restaurant rt ON rt.RestaurantId=o.RestaurantId
GROUP BY o.RestaurantId,rt.RestaurantName;


SELECT * FROM tbl_Order


--COMMON TABLE EXPRESSION ENDS




--TRIGGER USING TEMP TABLE TO RECORD THE NEW RESTAURANTS ADDED TO THE TABLE

CREATE TRIGGER tr_tbl_Restaurant_ForInsert
ON tbl_Restaurant
FOR INSERT
AS
BEGIN
    DECLARE @new VARCHAR(100)
    SELECT @new = RestaurantName FROM Inserted

    INSERT INTO #Audit
    VALUES('NEW Restaurant  ' + @new + ' registered on ' + CAST(GETDATE() AS VARCHAR))
END


CREATE TABLE #Audit (
	AuditId INT IDENTITY(1000,1),
    AuditMessage VARCHAR(500)
)

INSERT INTO tbl_Restaurant
VALUES ('SRIGANESH', 'DESAI CROSS', 'HUBLI', 'KARNATAKA',  580023,'9AM-10-PM','Mon-Fri', 6)

SELECT * FROM #Audit
SELECT * FROM tbl_Restaurant

--RECURSIVE CTE

--To provide level according to the the expierence of the chef


WITH CTE_ToProvideLevelByExpierence AS (
  SELECT     Chef_Id,     FirstName,    LastName,     Experience,   1 AS [Level]
  FROM     tbl_Chef
	WHERE Experience IN (SELECT MAX(Experience) FROM tbl_Chef)

  UNION ALL

  SELECT  c.Chef_Id,    c.FirstName,    c.LastName,    c.Experience,    cte.[Level] + 1
   FROM   tbl_Chef c
    JOIN CTE_ToProvideLevelByExpierence cte ON cte.Experience = c.Experience  + 1
)
SELECT   Chef_Id, FirstName, LastName, Experience, [level]
FROM CTE_ToProvideLevelByExpierence 

  SELECT * FROM tbl_Chef

  
  SELECT Chef_Id,FirstName,LastName,Experience,DENSE_RANK() OVER(ORDER BY Experience desc) AS [Level]
  FROM tbl_Chef

--CTE TO PROVIDE POSITION TO THE CHEF 


WITH CTE_ToProvidePositionByExperience AS (
  SELECT
    Chef_Id,FirstName,LastName,Experience,1 AS [Level],
    CASE
      WHEN Experience < 5 THEN 'Sub Junior'
      WHEN Experience >= 5 AND Experience < 10 THEN 'Junior'
      WHEN Experience >= 10 AND Experience <= 15 THEN 'Intermediate'
      WHEN Experience > 15 THEN 'Senior'
    END AS ExperienceCategory
  FROM tbl_Chef
  WHERE   Experience = (SELECT MAX(Experience) FROM tbl_Chef)

  UNION ALL

  SELECT
    c.Chef_Id,c.FirstName,c.LastName,c.Experience,cte.[Level] + 1,
    CASE
      WHEN c.Experience < 5 THEN 'Sub Junior'
      WHEN c.Experience >= 5 AND c.Experience < 10 THEN 'Junior'
      WHEN c.Experience >= 10 AND c.Experience <= 15 THEN 'Intermediate'
      WHEN c.Experience > 15 THEN 'Senior'
    END AS ExperienceCategory
  FROM tbl_Chef c
    JOIN CTE_ToProvidePositionByExperience cte ON c.Experience = cte.Experience - 1
)
SELECT
  Chef_Id, FirstName,LastName,Experience,[Level],ExperienceCategory
  FROM CTE_ToProvidePositionByExperience






-- STORED PROCEDURE FOR MENU RECOMMENDATION
ALTER PROCEDURE uspMenuRecommendation
 @customer_id INT
AS
BEGIN
SET NOCOUNT ON
  
    IF NOT EXISTS (
        SELECT TOP 1 FoodItemId
        FROM tbl_Order
        WHERE CustomerId = @customer_id
        GROUP BY FoodItemId
        ORDER BY COUNT(*) DESC
    )
    BEGIN

        SELECT 'No menu recommendations available.' AS Recommendation;
        RETURN;
    END

   
    DECLARE @most_ordered_food_item INT;
    SELECT TOP 1 @most_ordered_food_item = FoodItemId
    FROM tbl_Order
    WHERE CustomerId = @customer_id
    GROUP BY FoodItemId
    ORDER BY COUNT(*) DESC;

  
    DECLARE @recommendation VARCHAR(MAX);
    SELECT @recommendation = 'Recommended Food Item: ' + FoodName
    FROM Tbl_FoodItems
    WHERE FoodItemId = @most_ordered_food_item;


    SELECT @recommendation AS Recommendation;

END



EXEC uspMenuRecommendation @customer_id = 100;

--EXPLAINATION
SELECT  O.FoodItemId,f.FoodName
        FROM tbl_Order O JOIN tbl_FoodItems F ON F.FoodItemId = O.FoodItemId
        WHERE CustomerId = 100
       
--RECURSIVE STORED PROCEDURE


CREATE PROCEDURE usp_MultipleOrders
(
    @CustomerId INT,
    @RestaurantId INT,
    @FoodItemId INT,
    @Quantity INT,
    @FoodItemAmount DECIMAL(10,2),
    @OrderInstruction VARCHAR(45),
    @PaymentType VARCHAR(15),
    @PaymentDate DATE,
	@DeliverId INT
)
AS
BEGIN

    DECLARE @RemainingQuantity INT = @Quantity;
    DECLARE @OrderId INT;
    DECLARE @BillId INT;
    DECLARE @TotalAmount DECIMAL(10,2);
    DECLARE @RecursiveCounter INT = 1;
    
    WHILE @RemainingQuantity > 0
    BEGIN
        DECLARE @OrderQuantity INT;
        
        IF @RemainingQuantity > 5
            SET @OrderQuantity = 5;
        ELSE
            SET @OrderQuantity = @RemainingQuantity;
        
		 SET @FoodItemAmount = (SELECT @OrderQuantity*fi.Price
		 FROM tbl_FoodItems fi
		 WHERE fi.FoodItemId=@FoodItemId
		 )
	     
		 
		 
        INSERT INTO tbl_Order
        VALUES
        (
			
            @CustomerId,
            @RestaurantId,
            @FoodItemId,
            @OrderQuantity,
            @FoodItemAmount,
            @OrderInstruction,
            'Success', 
            GETDATE(), 
			@DeliverId
        );
        
        SET @TotalAmount = @FoodItemAmount * @OrderQuantity;
        
		DECLARE @MAXORDERID INT
		 SELECT @MAXORDERID = CASE WHEN 
		 MAX(ORDERID) IS NULL THEN 0 
		ELSE MAX(ORDERID) 
		END 
		 FROM tbl_Order
		
	
	

        INSERT INTO tbl_Bill
        VALUES
        (	
           @MAXORDERID,
		   0,
		   10,
		   10,
		   10,
		   0,
		   @TotalAmount
        );
        
	DECLARE @MAXBILLID INT
	SELECT @MAXBILLID = CASE WHEN 
		 MAX(BillId) IS NULL THEN 0 
		ELSE MAX(BillId) 
		END  FROM tbl_Bill
    
        INSERT INTO tbl_Payment  VALUES
        (
           
            (SELECT CardId FROM Tbl_Card WHERE CustomerId = @CustomerId),
            @MAXBILLID,
            @CustomerId,
            'Success', 
            @PaymentType,
            @PaymentDate
        );
        
        SET @RemainingQuantity = @RemainingQuantity - @OrderQuantity;
        
        SET @RecursiveCounter = @RecursiveCounter + 1;
    END;
    
    SELECT @RecursiveCounter - 1 AS 'TotalOrdersPlaced';
END;



EXEC RecursiveOrder 100,203,303,11,10,'MAKE IT SWEET','CARD' ,'2012-09-02',600

       
SELECT * FROM tbl_Order
SELECT * FROM tbl_bill
SELECT * FROM tbl_Payment




--TABLE TYPE

CREATE TYPE UT_CHEF AS TABLE  
(  
Chef_id int NOT NULL,  
FirstName varchar(MAX),
LastName varchar(MAX),
Experience int,
Speciality varchar(MAX)
)

SELECT * FROM tbl_Chef

CREATE PROCEDURE USP_Insert_Chef_Info(@Chef_Details [UT_chef]	READONLY )  
AS  
BEGIN  
  
INSERT INTO dbo.tbl_Chef  
(  
Chef_id ,  
FirstName ,
LastName ,
Experience ,
Speciality  
)  
SELECT * FROM @Chef_Details
END 

DECLARE @TAB AS [UT_chef];

INSERT INTO @TAB 
SELECT 18,'Amruta','Deshpande',18,'BRUNCH' UNION ALL
SELECT 19,'Aditi','Deshpande',19,'SNACKS' 

EXEC dbo.USP_Insert_Chef_Info @TAB


SELECT * FROM tbl_Chef



--FUNCTION TO CHECK PASSWORD

SELECT * FROM tbl_Login

CREATE FUNCTION fn_toLogin
(
@Username VARCHAR(30),
@Password VARCHAR(30)  
)
RETURNS VARCHAR(100)
AS
BEGIN

DECLARE @loginstatus VARCHAR(20)
SELECT @loginstatus = 
					(CASE WHEN PASSWORD = HASHBYTES('MD2',@Password)THEN 'CORRECT PASSWORD'
					ELSE 'WRONG PASSWORD'
					END)
	FROM tbl_Login
WHERE UserName = @Username 
	
	RETURN ISNULL(@loginstatus, 'USERNAME NOT FOUND');

END


SELECT dbo.fn_toLogin ('Ankur123', 'Ankur123$')

SELECT * FROM tbl_Login

--FUNCTION TO CHECK WHAT WOULD BE THE FINAL AMOUNT BY PROVIDE QUANTITY AND FOODNAME

ALTER FUNCTION dbo.GetFinalAmountByQuantityAndFoodName
(
    @Quantity INT,
    @FoodName VARCHAR(40)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        @FoodName AS FoodName,
        @Quantity AS Quantity,
        (Price * @Quantity) + ((Price * @Quantity) * 0.1) AS FinalAmount
    FROM tbl_FoodItems
    WHERE FoodName = @FoodName
);

SELECT * FROM tbl_Bill

SELECT FoodName, Quantity, FinalAmount FROM dbo.GetFinalAmountByQuantityAndFoodName (4,'BAKLAWA') 

SELECT * FROM tbl_FoodItems
WHERE FOODNAME='BAKLAWA'

