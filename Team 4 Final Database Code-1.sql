-- Team 4 Final Database Code
-- Michael Zhao, Janette Chow, Ray Zhang, Jeeyoung Kim

-- Database Creation Code

CREATE DATABASE INFO330_Team4
GO
USE INFO330_Team4
GO

CREATE TABLE [dbo].[tblCUSTOMER](
	[CustomerID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CustomerFname] [varchar](30) NOT NULL,
	[CustomerLname] [varchar](30) NOT NULL,
	[CustomerDOB] [date] NULL
)

CREATE TABLE [dbo].[tblLOCATION](
	[LocationID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[LocationName] [varchar](50) NOT NULL,
	[LocationDescr] [varchar](75) NULL
)

CREATE TABLE [dbo].[tblORDER_TYPE](
	[OrderTypeID] [int] IDENTITY(1,1)  PRIMARY KEY NOT NULL,
	[OrderTypeName] [varchar](30) NOT NULL,
	[OrderTypeDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblORDER](
	[OrderID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CustomerID] [int] FOREIGN KEY REFERENCES tblCUSTOMER (CustomerID) NOT NULL,
	[OrderTypeID] [int] FOREIGN KEY REFERENCES tblORDER_TYPE (OrderTypeID) NOT NULL,
	[LocationID] [int] FOREIGN KEY REFERENCES tblLOCATION (LocationID) NOT NULL,
	[OrderTotal] [Numeric](10, 2) NOT NULL,
	[OrderDate] [date] NOT NULL
)

CREATE TABLE [dbo].[tblPOSITION](
	[PositionID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[PositionName] [varchar](30) NOT NULL,
	[PositionDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblSTAFF](
	[StaffID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[StaffFname] [varchar](30) NOT NULL,
	[StaffLname] [varchar](30) NOT NULL,
	[StaffDOB] [date] NULL
)

CREATE TABLE [dbo].[tblAPPLIANCE_TYPE](
	[ApplianceTypeID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplianceTypeName] [varchar](30) NOT NULL,
	[AppliancerTypeDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblAPPLIANCE](
	[ApplianceID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplianceTypeID] [int] FOREIGN KEY REFERENCES tblAPPLIANCE_TYPE (ApplianceTypeID) NOT NULL,
	[ApplianceName] [varchar](30) NOT NULL,
	[ApplianceDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblTASK_APPLIANCE](
	[TaskAppID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ApplianceID] [int] FOREIGN KEY REFERENCES tblAPPLIANCE (ApplianceID) NOT NULL,
	[TaskID] [int] FOREIGN KEY REFERENCES tblTASK (TaskID) NOT NULL,
	[TaskAppName] [varchar](30) NOT NULL,
	[TaskAppDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblSTAFF_POSITION](
	[StaffPosID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[StaffID] [int] FOREIGN KEY REFERENCES tblSTAFF (StaffID) NOT NULL,
	[PositionID] [int] FOREIGN KEY REFERENCES tblPOSITION (PositionID) NOT NULL,
	[Salary] [Numeric](15, 2) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NULL
)

CREATE TABLE [dbo].[tblSHIFT](
	[ShiftID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ShiftName] [varchar](30) NOT NULL,
	[ShiftDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblSTAFF_POS_SHIFT](
	[StaffPosShiftID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[StaffPosID] [int] FOREIGN KEY REFERENCES tblSTAFF_POSITION (StaffPosID) NOT NULL,
	[ShiftID] [int] FOREIGN KEY REFERENCES tblSHIFT (ShiftID) NOT NULL,
	[StaffPosShiftDate] [date] NOT NULL,
)

CREATE TABLE [dbo].[tblTASK](
	[TaskID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[StaffPosShiftID] [int] FOREIGN KEY REFERENCES tblSTAFF_POS_SHIFT (StaffPosShiftID) NOT NULL,
	[TaskName] [varchar](50) NOT NULL,
	[StartTime] [date] NOT NULL,
	[EndTime] [date] NOT NULL,
)

CREATE TABLE [dbo].[tblITEM_TYPE](
	[ItemTypeID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ItemTypeName] [varchar](30) NOT NULL,
	[ItemTypeDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblITEM](
	[ItemID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ItemTypeID] [int] FOREIGN KEY REFERENCES tblITEM_TYPE (ItemTypeID) NOT NULL,
	[Price] [Numeric] (8, 2) NOT NULL,
	[ItemName] [varchar](30) NOT NULL,
	[ItemDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblINGREDIENT](
	[IngredientID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Cost] [Numeric] (8, 2) NOT NULL,
	[IngredientName] [varchar](30) NOT NULL,
	[IngredientDescr] [varchar](70) NULL
)

CREATE TABLE [dbo].[tblSUPPLIER](
	[SupplierID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[SupplierName] [varchar](30) NOT NULL,
	[SupplierAddress] [varchar](120) NULL
)

CREATE TABLE [dbo].[tblITEM_INGREDIENT](
	[ItemIngredientID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ItemID] [int] FOREIGN KEY REFERENCES tblITEM (ItemID) NOT NULL,
	[IngredientID] [int] FOREIGN KEY REFERENCES tblINGREDIENT (IngredientID) NOT NULL,
	[Quantity] [int] NOT NULL,
)

CREATE TABLE [dbo].[tblINGREDIENT_SUPPLIER](
	[IngSupID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[SupplierID] [int] FOREIGN KEY REFERENCES tblSUPPLIER (SupplierID) NOT NULL,
	[IngredientID] [int] FOREIGN KEY REFERENCES tblINGREDIENT (IngredientID) NOT NULL,
	[Price] [Numeric] (8, 2) NOT NULL,
)

CREATE TABLE [dbo].[tblLINE_ITEM](
	[LineItemID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ItemID] [int] FOREIGN KEY REFERENCES tblITEM (ItemID) NOT NULL,
	[OrderID] [int] FOREIGN KEY REFERENCES tblORDER (OrderID) NOT NULL,
	[StaffPosShiftID] [int] FOREIGN KEY REFERENCES tblSTAFF_POS_SHIFT (StaffPosShiftID) NOT NULL,
	[Quantity] [int] NOT NULL
)

-- Database Population Code

USE INFO330_Team4

--tblCUSTOMER
INSERT INTO tblCUSTOMER (CustomerFname, CustomerLname, CustomerDOB)
VALUES ('Abby', 'Smith', 'March 3, 1987'), ('Johnson', 'Brown', 'May 6, 1976'), ('Jessie', 'Jone', 'March 21, 1983'), ('Wilson', 'Miller', 'September 30, 1989'), ('Bonnie', 'Cooper', 'November 5, 1991')
GO

--tblOrder
INSERT INTO tblORDER(CustomerID, OrderTypeID, LocationID, OrderDate, OrderTotal)
VALUES ((SELECT CustomerID from tblCUSTOMER WHERE CustomerFname = 'Jessie' AND CustomerLname = 'Jone'), (SELECT OrderTypeID from tblORDER_TYPE WHERE OrderTypeName = 'Dine In'), (SELECT LocationID from tblLOCATION WHERE LocationName = 'Lynnwood'), 'April 17, 2019', 52.26), 
((SELECT CustomerID from tblCUSTOMER WHERE CustomerFname = 'Bonnie' AND CustomerLname = 'Cooper'), (SELECT OrderTypeID from tblORDER_TYPE WHERE OrderTypeName = 'Online Order'), (SELECT LocationID from tblLOCATION WHERE LocationName = 'Bellevue'), 'June 2, 2019', 25.87), 
((SELECT CustomerID from tblCUSTOMER WHERE CustomerFname = 'Abby' AND CustomerLname = 'Smith'), (SELECT OrderTypeID from tblORDER_TYPE WHERE OrderTypeName = 'Dine In'), (SELECT LocationID from tblLOCATION WHERE LocationName = 'Northgate'), 'December 19, 2018', 38.49), 
((SELECT CustomerID from tblCUSTOMER WHERE CustomerFname = 'Wilson' AND CustomerLname = 'Miller'), (SELECT OrderTypeID from tblORDER_TYPE WHERE OrderTypeName = 'Pickup'), (SELECT LocationID from tblLOCATION WHERE LocationName = 'Bellevue'), 'December 5, 2018', 73.65), 
((SELECT CustomerID from tblCUSTOMER WHERE CustomerFname = 'Johnson' AND CustomerLname = 'Brown'), (SELECT OrderTypeID from tblORDER_TYPE WHERE OrderTypeName = 'Dine In'), (SELECT LocationID from tblLOCATION WHERE LocationName = 'Seattle'), 'December 29, 2018', 27.38)
GO

--tblLine_ITEM
INSERT INTO tblLINE_ITEM(OrderID, ItemID, StaffPosShiftID, Quantity)
VALUES ((SELECT OrderID from tblORDER WHERE CustomerID = 1), (SELECT ItemID from tblITEM WHERE ItemName = 'New York Steak'), (SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2019-04-17'), 1), 
((SELECT OrderID from tblORDER WHERE CustomerID = 3), (SELECT ItemID from tblITEM WHERE ItemName = 'Chicken Wings'), (SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2019-06-02'), 2), 
((SELECT OrderID from tblORDER WHERE CustomerID = 5), (SELECT ItemID from tblITEM WHERE ItemName = 'Classic Caesar'), (SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2018-12-19'), 2), 
((SELECT OrderID from tblORDER WHERE CustomerID = 2), (SELECT ItemID from tblITEM WHERE ItemName = 'New York Steak'), (SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2018-12-29'), 1), 
((SELECT OrderID from tblORDER WHERE CustomerID = 4), (SELECT ItemID from tblITEM WHERE ItemName = 'Coke'), (SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2018-12-05'), 3)
GO

--tblLOCATION
INSERT INTO tblLOCATION (LocationName, LocationDescr)
VALUES ('Lynnwood', 'Alderwood mall'), ('Northgate', 'Northgate mall'), ('Seattle', 'Westlake mall'), ('Bellevue', 'Bellevue Square'), ('Everett', 'Everett Mall')
GO

-- tblPOSITION
INSERT INTO tblPOSITION (PositionName, PositionDescr)
VALUES ('Server', 'Front-of-the-House'), ('Bartender', 'Front-of-the-House'), ('Host', 'Front-of-the-House'), ('Chef', 'Back-of-the-House'), ('Restaurant Manager', 'Restaurant Management')
GO

-- tblStaff_Pos_Shift
INSERT INTO tblSTAFF_POS_SHIFT(StaffPosID, ShiftID, StaffPosShiftDate)
VALUES ((SELECT StaffPosID from tblSTAFF_POSITION WHERE StaffID = 3), (SELECT ShiftID from tblSHIFT WHERE ShiftName = 'Morning Shift'), 'April 17, 2019'), 
((SELECT StaffPosID from tblSTAFF_POSITION WHERE StaffID = 2), (SELECT ShiftID from tblSHIFT WHERE ShiftName = 'Day Shift'), 'June 2, 2019'), 
((SELECT StaffPosID from tblSTAFF_POSITION WHERE StaffID = 5), (SELECT ShiftID from tblSHIFT WHERE ShiftName = 'Night Shift'), 'December 19, 2018'), 
((SELECT StaffPosID from tblSTAFF_POSITION WHERE StaffID = 4), (SELECT ShiftID from tblSHIFT WHERE ShiftName = 'Morning Shift'), 'December 29, 2018'), 
((SELECT StaffPosID from tblSTAFF_POSITION WHERE StaffID = 6), (SELECT ShiftID from tblSHIFT WHERE ShiftName = 'Day Shift'), 'December 5, 2018')
GO

-- tblORDERTYPE
INSERT INTO tblORDER_TYPE(OrderTypeName, OrderTypeDescr)
VALUES ('Dine In', NULL), ('Carry Out', NULL), ('Delivery', NULL), ('Pickup', NULL), ('Online Order', NULL)
GO

--tblSTAFF
INSERT INTO tblSTAFF (StaffFname, StaffLname, StaffDOB)
VALUES ('Lisa', 'Mitchell', 'February 26, 1986'), ('Jessica', 'Perry', 'December 11, 1990'), ('Ben', 'Coleman', 'September 21, 1989'), ('Martin', 'Wood', 'July 7, 1994'), ('Ron', 'Bennett', 'June 13, 1995')
GO

--tblStaff_position
INSERT INTO tblSTAFF_POSITION(StaffID, PositionID, Salary, BeginDate, EndDate)
VALUES ((SELECT StaffID from tblSTAFF WHERE StaffFname = 'Lisa' AND StaffLname = 'Mitchell'), (SELECT PositionID from tblPOSITION WHERE PositionName = 'Host'), 14.00, 'January 17, 2016', NULL), 
((SELECT StaffID from tblSTAFF WHERE StaffFname = 'Jessica' AND StaffLname = 'Perry'), (SELECT PositionID from tblPOSITION WHERE PositionName = 'Server'), 13.00, 'March 1, 2018', NULL), 
((SELECT StaffID from tblSTAFF WHERE StaffFname = 'Ben' AND StaffLname = 'Coleman'), (SELECT PositionID from tblPOSITION WHERE PositionName = 'Restaurant Manager'), 47368.00, 'December 12, 2018', NULL), 
((SELECT StaffID from tblSTAFF WHERE StaffFname = 'Martin' AND StaffLname = 'Wood'), (SELECT PositionID from tblPOSITION WHERE PositionName = 'Bartender'), 10.74, 'March 28, 2015', NULL), 
((SELECT StaffID from tblSTAFF WHERE StaffFname = 'Ron' AND StaffLname = 'Bennett'), (SELECT PositionID from tblPOSITION WHERE PositionName = 'Chef'), 46899.00, 'May 9, 2012', NULL)
GO

--tblSUPPLIER
INSERT INTO tblSUPPLIER(SupplierName, SupplierAddress)
VALUES ('Acumera', '3307 Northland Dr. Suite 170 Austin, Texas 78731'), ('Jolt', '2901 Ashton Blvd. #300 Lehi, UT 84043'), ('The Howard Company', '1375 N Barker Road Brookfield, WI 53045'), ('Toast Inc.', '401 Park Drive Suite 801 Boston, MA'), ('EZ-Chow', '2303 Hurstbourne Village Drive Suite 1200 Louisville, Ky 40299')
GO

-- tblApplianceType
INSERT INTO tblAPPLIANCE_TYPE(ApplianceTypeName, AppliancerTypeDescr)
VALUES ('Storage', NULL), ('Refrigeration', NULL), ('Prep Surfaces and Equipment', 'Appliance for food prep'), ('Cooking Surfaces and Equipment', 'Appliance for cooking'), ('Table Settings', 'Include everything guests will use')
GO
INSERT INTO tblAPPLIANCE_TYPE(ApplianceTypeName, AppliancerTypeDescr)
VALUES ('Cleaning', NULL)

-- tblShift
INSERT INTO tblSHIFT(ShiftName, ShiftDescr)
VALUES ('Day Shift', '10am-5pm'), ('Afternoon Shift', '5pm-12am'), ('Midnight Shift', '12am-5am'), ('Night Shift', '7pm-11pm'), ('Morning Shift', '5am-10am')
GO

-- tblitem_type
INSERT INTO tblITEM_TYPE(ItemTypeName, ItemTypeDescr)
VALUES ('Appetizer', NULL), ('Soup & Salad', NULL), ('Entrees', NULL), ('Sides', NULL), ('Beverage', NULL), ('Alcohol beverage', NULL)
GO

--tblitem
INSERT INTO tblITEM(ItemName, ItemTypeID, Price, ItemDescr)
VALUES ('Classic Caesar', (SELECT ItemTypeID from tblITEM_TYPE WHERE ItemTypeName = 'Soup & Salad'), 9, 'Fresh lettuce, parmesan and dressing'), 
('Chicken Wings', (SELECT ItemTypeID from tblITEM_TYPE WHERE ItemTypeName = 'Appetizer'), 7.99, 'BBQ flavor'), 
('Cheese Bread', (SELECT ItemTypeID from tblITEM_TYPE WHERE ItemTypeName = 'Sides'), 6.79, NULL), 
('New York Steak', (SELECT ItemTypeID from tblITEM_TYPE WHERE ItemTypeName = 'Entrees'), 22.95, '12oz'), 
('Coke', (SELECT ItemTypeID from tblITEM_TYPE WHERE ItemTypeName = 'Beverage'), 2.50, NULL)
GO

--tblingredient
INSERT INTO tblINGREDIENT(IngredientName, IngredientDescr, Cost)
VALUES ('Chicken', 'per pound', 2.75), ('Steak', 'per pound', 10), ('Egg', '180pc', 15), ('Lettuce', '1pc', 0.5), ('Pork', 'per pound', 3), ('Bread', 'per pound', 0.75), ('Soda', '1 can', 0.25)
GO

--tblitem_ingredient
INSERT INTO tblITEM_INGREDIENT(ItemID, IngredientID, Quantity)
VALUES ((SELECT ItemID from tblITEM WHERE ItemName = 'Classic Caesar'), (SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Lettuce'), 0.5), 
((SELECT ItemID from tblITEM WHERE ItemName = 'Chicken Wings'), (SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Chicken'), 1), 
((SELECT ItemID from tblITEM WHERE ItemName = 'Cheese Bread'), (SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Bread'), 0.5), 
((SELECT ItemID from tblITEM WHERE ItemName = 'New York Steak'), (SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Steak'), 0.75), 
((SELECT ItemID from tblITEM WHERE ItemName = 'Coke'), (SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Soda'), 1)
GO

--tblIngredient_supplier
INSERT INTO tblINGREDIENT_SUPPLIER(IngredientID, SupplierID, Price)
VALUES ((SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Chicken'), (SELECT SupplierID from tblSUPPLIER WHERE SupplierName = 'Acumera'), 2.75), 
((SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Steak'), (SELECT SupplierID from tblSUPPLIER WHERE SupplierName = 'Acumera'), 10.00), 
((SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Lettuce'), (SELECT SupplierID from tblSUPPLIER WHERE SupplierName = 'Jolt'), 0.5), 
((SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Soda'), (SELECT SupplierID from tblSUPPLIER WHERE SupplierName = 'EZ-Chow'), 0.25), 
((SELECT IngredientID from tblINGREDIENT WHERE IngredientName = 'Pork'), (SELECT SupplierID from tblSUPPLIER WHERE SupplierName = 'The Howard Company'), 3.00)
GO

--tblAppliance
INSERT INTO tblAPPLIANCE(ApplianceName, ApplianceTypeID, ApplianceDescr)
VALUES ('Refrigerator', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Refrigeration'), NULL), 
('Freezer', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Refrigeration'), NULL), 
('Blender', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Prep Surfaces and Equipment'),NULL), 
('Cook Top', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Cooking Surfaces and Equipment'), NULL), 
('Utensils', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Table Settings'), NULL)
GO
INSERT INTO tblAPPLIANCE(ApplianceName, ApplianceTypeID, ApplianceDescr)
VALUES ('Knife', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Prep Surfaces and Equipment'), NULL), 
('Vacuum', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Cleaning'), NULL), 
('Pan', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Cooking Surfaces and Equipment'),NULL), 
('Food processor', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Prep Surfaces and Equipment'), NULL), 
('Dish washing machine', (SELECT ApplianceTypeID from tblAPPLIANCE_TYPE WHERE ApplianceTypeName = 'Cleaning'), NULL)
GO

--tblTaskAppliance (applianceid, taskID, TaskAppName, TaskAppDescr)
INSERT INTO tblTASK_APPLIANCE(TaskAppName, ApplianceID, TaskAppDescr, TaskID)
VALUES ('Cutting knife', (SELECT ApplianceID from tblAPPLIANCE WHERE ApplianceName = 'Knife'), NULL, (SELECT TaskID from tblTASK WHERE TaskName = 'Preparing Food')), 
('Cleaning vacuum', (SELECT ApplianceID from tblAPPLIANCE WHERE ApplianceName = 'Vacuum'), NULL, (SELECT TaskID from tblTASK WHERE TaskName = 'Cleaning Front house')), 
('Cooking pan', (SELECT ApplianceID from tblAPPLIANCE WHERE ApplianceName = 'Pan'),NULL, (SELECT TaskID from tblTASK WHERE TaskName = 'Cooking')), 
('Utensils', (SELECT ApplianceID from tblAPPLIANCE WHERE ApplianceName = 'Utensils'), NULL, (SELECT TaskID from tblTASK WHERE TaskName = 'Setting tables')), 
('Dish washing machine', (SELECT ApplianceID from tblAPPLIANCE WHERE ApplianceName = 'Dish washing machine'), NULL, (SELECT TaskID from tblTASK WHERE TaskName = 'Washing Dishes'))
GO

--tblTASK (StaffPosShiftID, StartTime, EndTime, TaskName)
INSERT INTO tblTASK(StaffPosShiftID, StartTime, EndTime, TaskName)
VALUES ((SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2019-04-17'), '05:01:00', '05:28:00', 'Cleaning Front house'), 
((SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2019-06-02'), '10:03:00', '11:58:00', 'Cooking'), 
((SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2018-12-19'), '19:13:00', '22:00:00', 'Washing Dishes'), 
((SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2018-12-29'), '06:24:00', '08:36:00', 'Preparing Food'), 
((SELECT StaffPosShiftID from tblSTAFF_POS_SHIFT WHERE StaffPosShiftDate = '2019-06-03'), '12:23:00', '14:48:00', 'Setting tables')
GO 

/* 
Indiviual coding section:
1. Two Stored Procedures: 
	Michael: addStaffToPosition, makeNewOrder
	Ray: addStaffToShift, addNewIngredientSupplier
	Jeeyoung: addNewItem, insert a new row into tblTASK_APPLICANCE
	Janette: addNewAppliance, addNewTask

2. Business rule: 
3. One user-defined function to enforce the business rule defined above:
	Michael: someone who is 12 years or younger cannot place a online order in any restaurant
	Ray: Employees must be at least age 18 to work
	Jeeyoung: Position name 'bartender' is not allowed for employees who are younger than 21
	Janette: Customers that are younger than 21 cannot order alcohol beverage
	
4. Computed column: 
	Michael: Total revenue generated by orders for a given restaurant location in the last 100 days
	Ray: Total dollars spent by each customer over the last 90 days
	Jeeyoung: Total money made by order that were placed in the last 90 days on items that include Steak or Chicken as ingredients
	Janette: Total money made from "Delivery" order in the last 30 days for each location

5. Complex query: 
	Michael:  List the Staff members (in a server position) who made more than $20 from selling items containing steak in the past year.
	Ray: 3 products that sold the most quntity by "delivery" in the past 90 days
	Jeeyoung: List of 10 oldest staffs who make more than 35000 as a bartender who have made and sold more than 100 Moscow mule or Crown and coke at any location
	Janette: Top 1 location that sell most item_type "Soup & Salad" in the past 30 days
*/

-- Michael Zhao Individual Database Coding Section

USE INFO330_Team4
GO

-- MZ Stored Procedure: Add an existing staff member to an existing staff position 
CREATE PROCEDURE addStaffToPositionMZ
@Fname varchar(30),
@Lname varchar(30),
@Birth Date,
@Salary Numeric(15, 2),
@BeginDate Date,
@EndDate Date = NULL,
@PosName varchar(30)

AS

DECLARE @StaffID INT
DECLARE @PositionID INT

SET @StaffID = (SELECT StaffID 
				FROM tblSTAFF 
				WHERE StaffFName = @Fname
				AND StaffLName = @Lname
				AND StaffDOB = @Birth)

SET @PosName = (SELECT PositionName
				FROM tblPOSITION
				WHERE PositionName = @PosName
				)
BEGIN TRAN MZ1
	INSERT INTO tblSTAFF_POSITION (StaffID, PositionID, Salary, BeginDate)
	VALUES (@StaffID, @PositionID, @Salary, @BeginDate)
COMMIT TRAN MZ1
GO

SELECT * FROM tblINGREDIENT

-- MZ Stored Procedure: Create a new order given location and customer
CREATE PROCEDURE makeNewOrderMZ
@Fname varchar(30),
@Lname varchar(30),
@Birth Date,
@LocationName varchar(50),
@OrderTypeName varchar(30),
@OrderDate date,
@OrderTotal INT

AS 

DECLARE @CustID INT
DECLARE @OrderTypeID INT
DECLARE @LocationID INT

SET @CustID = (SELECT CustomerID 
				FROM tblCUSTOMER
				WHERE CustomerFname = @Fname
				AND CustomerLname = @Lname
				AND CustomerDOB = @Birth
				)

SET @OrderTypeID = (SELECT OrderTypeID
				FROM tblORDER_TYPE
				WHERE OrderTypeName = @OrderTypeName
				)

SET @LocationID = (SELECT LocationID
				FROM tblLOCATION
				WHERE LocationName = @LocationName
				)
BEGIN TRAN MZ2
	INSERT INTO tblORDER (CustomerID, OrderDate, OrderTypeID, LocationID, OrderTotal)
	VALUES (@CustID, @OrderDate, @OrderTypeID, @LocationID, @OrderTotal)
COMMIT TRAN MZ2
GO


-- MZ Business Rule: Someone who is 12 years or younger cannot place a online order in any restarant location.
CREATE FUNCTION fn_mustBeOver12YearsOldToOrderOnlineMZ()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS (SELECT *
FROM  tblCUSTOMER C
JOIN tblORDER O ON C.CustomerID = O.CustomerID
JOIN tblORDER_TYPE OT ON O.OrderTypeID = OT.OrderTypeID
WHERE OT.OrderTypeName = 'Online Order'
AND C.CustomerDOB > (SELECT GETDATE() - (365.25 * 12))
)
BEGIN
SET @Ret = 1
END
RETURN @Ret
END
GO

ALTER TABLE tblORDER
ADD CONSTRAINT CK_NoYoungOnlineOrdersMZ
CHECK (dbo.fn_mustBeOver12YearsOldToOrderOnlineMZ() = 0)
GO



-- MZ Computed Column: What is the total revenue generated by orders for a given restaurant location in the last 100 days?
CREATE FUNCTION fn_TotalRevenuePerLocationMZ (@PK INT)
RETURNS Numeric(10,2)
AS
BEGIN
	DECLARE @Ret Numeric(8,2) =
		(SELECT SUM(O.OrderTotal)
		FROM tblLOCATION L
			JOIN tblORDER O ON O.LocationID = L.LocationID
		WHERE L.LocationID = @PK
		AND O.OrderDate > (SELECT GETDATE() - 100))
RETURN @Ret
END

ALTER TABLE tblLOCATION ADD TotalRevenue AS (dbo.fn_TotalRevenuePerLocationMZ (LocationID))


-- MZ Complex Query: List the Staff members (in a server position) who made more than $20 from selling items containing steak in the past year.
SELECT S.StaffID, S.StaffFname, S.StaffLname, SUM(I.Price * LI.Quantity) AS PorkMoney
FROM tblSTAFF S
	JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
	JOIN tblPOSITION P ON P.PositionID = SP.PositionID
	JOIN tblSTAFF_POS_SHIFT SPS ON SP.StaffPosID = SPS.StaffPosID
	JOIN tblLINE_ITEM LI ON LI.StaffPosShiftID = SPS.StaffPosShiftID
	JOIN tblITEM I ON I.ItemID = LI.ItemID
	JOIN tblITEM_INGREDIENT II ON II.ItemID = I.ItemID
	JOIN tblINGREDIENT ING ON ING.IngredientID = II.IngredientID
	JOIN tblORDER O ON O.OrderID = LI.OrderID
WHERE P.PositionName = 'Server'
AND O.OrderDate > (SELECT GETDATE() - 365.25)
AND ING.IngredientName = 'Steak'
GROUP BY S.StaffID, S.StaffFname, S.StaffLname
HAVING SUM(I.Price * LI.Quantity) > 20

SELECT I.ItemName
FROM tblITEM I
JOIN tblITEM_INGREDIENT II ON I.ItemID = II.ItemIngredientID
JOIN tblINGREDIENT ING ON ING.IngredientID = II.IngredientID
WHERE ING.IngredientName = 'Steak'


-- Janette Chow Individual Database Coding Section

-- JC Stored Procedure: addNewAppliance
CREATE PROCEDURE uspAddNewAppliance --need ApplianceTypeID
@ApplianceTypeName  varchar(30), --to find ApplianceTypeID
@ApplianceName varchar(30),
@ApplianceDescr varchar(70)
AS
DECLARE @A_ID INT
SET @A_ID = (SELECT ApplianceTypeID
			FROM tblAPPLIANCE_TYPE
			WHERE ApplianceTypeName = @ApplianceName)	
BEGIN TRAN G1
INSERT INTO tblAPPLIANCE(ApplianceTypeID, ApplianceName, ApplianceDescr)
VALUES (@A_ID, @ApplianceName, @ApplianceDescr)
COMMIT TRAN G1

-- JC Stored Procedure: AddNewTask
CREATE PROCEDURE uspAddNewTask --StaffPosShiftID, StartTime, EndTime, TaskName, TaskAppID
@TaskAppName varchar(30), --to find TaskAppID
@StaffPosShiftDate date, --to find StaffPosShiftID
@Start date,
@End date,
@TaskName varchar(70)

AS
DECLARE @TA_ID INT
DECLARE @SPS_ID INT
SET @TA_ID = (SELECT TaskAppID
			FROM tblTASK_APPLIANCE
			WHERE TaskAppName = @TaskAppName)	
SET @SPS_ID = (SELECT StaffPosShiftID	
			FROM tblSTAFF_POS_SHIFT
			WHERE StaffPosShiftDate = @StaffPosShiftDate)
BEGIN TRAN G1
INSERT INTO tblTASK(StaffPosShiftID, StartTime, EndTime, TaskName, TaskAppID)
VALUES (@SPS_ID, @Start, @End, @TaskName, @TA_ID)
COMMIT TRAN G1

--JC Business Rule: Customers that are younger than 21 cannot order alcohol beverage
CREATE FUNCTION FN_NoYoungerThan21OrderAlcohol()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0
IF EXISTS (SELECT *
	FROM tblCUSTOMER C
		JOIN tblORDER O ON C.CustomerID = O.CustomerID
		JOIN tblLINE_ITEM LI ON O.OrderID = LI.OrderID
		JOIN tblITEM I ON LI.ItemID = I.ItemID
		JOIN tblITEM_TYPE IT ON I.ItemTypeID = IT.ItemTypeID
	WHERE DATEADD(YEAR, 21, C.CustomerDOB) > getdate() --Add 21 to DOB and check if it is in the past
	AND IT.ItemTypeName = 'Alcohol beverage')
BEGIN
SET @Ret = 1
END

RETURN @Ret
END 
GO
ALTER TABLE tblORDER
ADD CONSTRAINT CK_YoungerThan21OrderAlcohol
CHECK (dbo.FN_NoYoungerThan21OrderAlcohol() = 0)
GO

-- JC Computed Column: Total money made from "Delivery" order in the last 30 days for each location
CREATE FUNCTION fn_TotalAmountOfNorthgateDeliveryLast30Days(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = (
SELECT SUM(O.OrderTotal)
FROM tblORDER O
	JOIN tblORDER_TYPE OT ON O.OrderTypeID = OT.OrderTypeID
	JOIN tblLOCATION L ON L.LocationID = O.LocationID
WHERE L.LocationName = 'Northgate'
AND OT.OrderTypeName = 'Delivery'
AND O.OrderDate >= DATEADD(month,-1,GETDATE()) 
AND O.LOCATIONID = @PK)

RETURN @Ret
END
GO
ALTER TABLE tblLocation
Add DeliverOrderRevenueLast30Days AS (dbo.fn_TotalAmountOfNorthgateDeliveryLast30Days(LocationID))

-- JC Complex query: Top 1 location that sell most item_type "Salad & Soup" in the past 30 days
SELECT TOP 1 L.LocationName, COUNT(IT.ItemTypeName) * LI.Quantity AS TotalAmountOfSaladSoup
FROM tblLOCATION L
	JOIN tblORDER O ON L.LocationID = O.LocationID
	JOIN tblLINE_ITEM LI ON O.OrderID = LI.OrderID
	JOIN tblITEM I ON LI.ItemID = I.ItemID
	JOIN tblITEM_TYPE IT ON I.ItemTypeID = IT.ItemTypeID
WHERE IT.ItemTypeName = 'Soup & Salad'
AND O.OrderDate >= DATEADD(month,-1,GETDATE()) 
GROUP BY L.LocationName, O.OrderDate, LI.Quantity
ORDER BY TotalAmountOfSaladSoup DESC

-- Ray Zhang Individual Database Coding Section

-- RZ Stored Procedure: Add staff member to shift
CREATE PROCEDURE rz_addStaffToShift
@FName varchar(30),
@LName varchar(30),
@Birth Date,
@ShiftName varchar(30),
@PosName varchar(30),
@ShiftDate Date

AS 

DECLARE @ST_ID INT
DECLARE @P_ID INT
DECLARE @STP_ID INT
DECLARE @SHIFTID INT

SET @ST_ID = (SELECT S.staffid
			from tblSTAFF S
			WHERE S.StaffFname = @FName
			AND S.StaffLname = @LName
			AND S.StaffDOB = @Birth)

SET @P_ID = (SELECT P.PositionID
			FROM tblPOSITION P
			WHERE P.PositionName = @PosName
			)

SET @STP_ID = (SELECT S.StaffPosID
				FROM tblSTAFF_POSITION S
				WHERE s.StaffID = @ST_ID
				AND S.PositionID = @P_ID)

SET @SHIFTID = (SELECT S.shiftid
				FROM tblSHIFT S
				WHERE s.ShiftName = @ShiftName)

INSERT INTO tblSTAFF_POS_SHIFT(StaffPosShiftDate, StaffPosID, ShiftID)
VALUES(@ShiftDate, @STP_ID, @SHIFTID)


-- RZ Stored Procedure: Add a new Ingredient Supplier
CREATE PROCEDURE rz_addNewIngredientSupplier
@SupplName varchar(30),
@IngName varchar(30),
@Price Numeric(8,2)
AS

DECLARE @INGID INT
DECLARE @SUPID INT

SET @INGID = (SELECT I.IngredientID
			FROM tblINGREDIENT I
			WHERE I.IngredientName = @IngName
			)

SET @SUPID = (SELECT S.SupplierID
				FROM tblSUPPLIER S
				WHERE S.SupplierName = @SupplName)

INSERT INTO tblINGREDIENT_SUPPLIER(SupplierID, IngredientID, Price)
VALUES(@SUPID, @INGID, @Price)


-- RZ Business Rule
CREATE FUNCTION fn_NoYoungHires()
RETURNS INT
AS 
BEGIN
	DECLARE @RET INT = 0
	IF Exists(

	SELECT * FROM tblSTAFF S
	WHERE S.StaffDOB > (SELECT GETDATE() - (365 * 18))
	)
	BEGIN
		SET @RET = 1
	END
RETURN @RET
END

GO 
ALTER TABLE tblStaff
ADD CONSTRAINT CK_NO_UNDER_18_HIRE
CHECK (dbo.fn_NoYoungHires() = 0)


-- RZ Computed Column
CREATE FUNCTION fn_CalcTotalSpent(@PK INT)
RETURNS Numeric(8,2)
AS
BEGIN
DECLARE @RET Numeric(8,2) = 
	(SELECT SUM(li.quantity * P.price) 
	FROM tblORDER O
	JOIn tblLINE_ITEM li on li.OrderID = o.OrderID
	JOIn tblITEM P on p.ItemID = li.ItemID
	JOIn tblCUSTOMER C on c.CustomerID = o.CustomerID
	WHERE C.CustomerID = @PK AND O.OrderDate > (SELECT GETDATE() - 90)
	)
RETURN @RET
END

GO
ALter Table tblCustomer
Add SpendTotal as(dbo.fn_CalcTotalSpent(CustomerId))


-- RZ Computed Query 
SELECT TOP 3 I.ItemName, SUM(li.Quantity) as AmountSold
FROM tblITEM I 
JOIN tblLINE_ITEM li on li.ItemID = I.ItemID
JOIn tblORDER o on o.OrderID = li.OrderID
JOIN tblORDER_TYPE ot on ot.OrderTypeID = o.OrderTypeID
WHERE ot.OrderTypeName = 'Delivery'
AND O.OrderDate > (SELECT GETDATE() - 900)
GROUP BY I.ItemName
ORDER BY SUM(li.Quantity) DESC

SELECT * FROM tblCUSTOMER

-- Jeeyoung Kim Individual Database Coding Section

-- JK Stored Procedure: insert new Item
CREATE PROCEDURE uspaddNewItem
@I_Name varchar (50),
@Price numeric (5,2),
@ItemDescr varchar (50),
@ItemTypeName varchar (50),
@ItemTypeDescr varchar (50)
AS 

DECLARE @IT_ID INT

SET @IT_ID = (SELECT ItemTypeID
    FROM tblITEM_TYPE
    WHERE ItemTypeName = @ItemTypeName
    AND ItemTypeDescr = @ItemTypeDescr)

BEGIN TRAN T1
INSERT INTO tblITEM(ItemName, ItemTypeID, Price, ItemDescr)
VALUES(@I_Name, @IT_ID, @Price, @ItemDescr)
COMMIT TRAN T1
GO

-- JK Stored Procedure: insert a new row into tblTASK_APPLIANCE 
CREATE PROCEDURE uspnewInsertTask_Appliance 
@TaskAppName varchar (50),
@TaskAppDescr varchar (50),
@ApplianceName varchar (50),
@ApplianceDescr varchar (50)
AS

DECLARE @A_ID INT

SET @A_ID = (SELECT ApplianceID 
    FROM tblAPPLIANCE 
    WHERE @ApplianceName = @ApplianceName
    AND @ApplianceDescr = @ApplianceDescr)

BEGIN TRAN T2
INSERT INTO tblTASK_APPLIANCE(ApplianceID, TaskAppName, TaskAppDescr)
VALUES (@A_ID, @TaskAppName, @TaskAppName, @TaskAppDescr)
COMMIT TRAN T2
GO

-- JK Business Rule: Position name 'bartender' is not allowed for employees who are younger than 21 
-- One (1) user-defined function to enforce the business rule defined above 
CREATE FUNCTION fn_too_young_for_drinks() 
RETURNS INT 
AS 
BEGIN DECLARE @Ret INT = 0
      IF EXISTS (SELECT* 
                FROM tblSTAFF S  
                    JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
                    JOIN tblPOSITION P ON P.PositionID = SP.PositionID
                WHERE  S.StaffDOB> (SELECT GETDATE() - (365.25 * 21))
                AND P.PositionName = 'Bartender'
                )
        BEGIN 
        SET @Ret = 1 
        END 
RETURN @Ret 
END 
GO 

ALTER TABLE tblEMPLOYEE 
ADD CONSTRAINT CK_no_making_drinks_for_minors
CHECK (dbo.fn_too_young_for_drinks() = 0)
GO

-- JK Computed Column: total money made by orders that were placed in the last 90 days on items
-- that include Steak or Chicken as ingredients 
CREATE FUNCTION fn_total_dollars_chicken_steaks(@PK INT)
RETURNS INT 
AS
BEGIN
DECLARE @Ret INT =
    (SELECT SUM(Price * LI.Quantity)
    FROM tblITEM IT
        JOIN tblITEM_INGREDIENT ITG ON IT.ItemID = ITG.ItemID
        JOIN tblINGREDIENT IG ON ITG.IngredientID = IG.IngredientID
        JOIN tblLINE_ITEM LI ON IT.ItemID = LI.ItemID
        JOIN tblORDER O ON O.OrderID = LI.OrderID
    WHERE IG.IngredientName IN ('Chicken', 'Steak')
    AND O.OrderDate >= (SELECT GETDATE() - 90)
    AND IT.ItemID = @PK)
RETURN @Ret
END
GO

ALTER TABLE tblITEM
ADD TotalChickenOrSteakMoney AS (dbo.fn_total_dollars_chicken_steaks(ItemID))


-- JK Complex Query: Oldest staff who made more than $20 as a bartender who have 
-- made and sold more than 5 Moscow mule or Crown and coke at any locations 
SELECT TOP 10 S.StaffID, S.StaffFname, S.StaffLname
FROM tblSTAFF S 
    JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
    JOIN tblPOSITION P ON SP.PositionID = P.PositionID
    JOIN tblSTAFF_POS_SHIFT SPS ON SP.StaffPosID = SPS.StaffPosID
    JOIN tblLINE_ITEM LI ON SPS.StaffPosShiftID = LI.StaffPosShiftID
    JOIN tblITEM I ON I.ItemID = LI.ItemID
    JOIN 
        (SELECT S.StaffID, StaffFname, StaffLname, SUM(LI.Quantity) AS numOfDrinks
        FROM tblSTAFF S 
            JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
            JOIN tblPOSITION P ON SP.PositionID = P.PositionID
            JOIN tblSTAFF_POS_SHIFT SPS ON SP.StaffPosID = SPS.StaffPosID
            JOIN tblLINE_ITEM LI ON SPS.StaffPosShiftID = LI.StaffPosShiftID
            JOIN tblITEM I ON I.ItemID = LI.ItemID
        WHERE I.ItemName IN ('Moscow Mule', 'Crown and Coke')
        GROUP BY S.StaffID, StaffFname, StaffLname
        HAVING SUM(LI.Quantity) >= 5) AS subquery ON S.StaffID = subquery.StaffID
    WHERE SP.Salary >= 20 
    AND P.PositionName = 'Bartender'
    ORDER BY S.StaffDOB 




