CREATE DATABASE PRSproto

USE PRSproto

CREATE TABLE [User]
(
ID			INT PRIMARY KEY IDENTITY(1,1),
Username	varchar(20) NOT NULL UNIQUE,
Password	varchar(10) NOT NULL,
FirstName	varchar(20) NOT NULL,
LastName	varchar(20) NOT NULL,
PhoneNumber varchar(12) NOT NULL, --check (phonenumber IS NULL OR LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
Email		varchar(75) NOT NULL, --check (email LIKE '%@%.%'),
Reviewer	BIT,
Admin		BIT
)

CREATE TABLE Vendor
(
ID INT PRIMARY KEY IDENTITY(1,1),
Code varchar(10) NOT NULL,
Name varchar(255) NOT NULL,
Address varchar(255) NOT NULL,
City varchar(255) NOT NULL,
State varchar(2) NOT NULL,
Zip varchar(5) NOT NULL,
PhoneNumber varchar(12) NOT NULL,
Email varchar(100) NOT NULL
)

CREATE TABLE Product
(
ID INT PRIMARY KEY IDENTITY(1,1),
VendorID INT NOT NULL,
PartNumber varchar(50) NOT NULL,
Name varchar(150) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Unit varchar(255) NULL,
PhotoPath varchar(255) NULL
)

CREATE TABLE Request
(
ID INT PRIMARY KEY IDENTITY(1,1),
UserID INT NOT NULL,
RequestNumber varchar(20) NOT NULL,
Description varchar(100) NOT NULL,
Justification varchar(255) NOT NULL,
DateNeeded DATE NOT NULL,
DeliveryMode varchar(25) NOT NULL,
Status varchar(20) default'New' NOT NULL,
Total DECIMAL(10,2) default 0.0 NOT NULL,
SubmittedDate DATETIME,
ReasonForRejection varchar(100) NULL
)

CREATE TABLE LineItem
(
ID INT PRIMARY KEY IDENTITY(1,1),
RequestID INT,
ProductID INT,
Quantity INT
)

SELECT *
FROM [User]

SELECT *
FROM Vendor

SELECT *
FROM Product
SELECT *
FROM Request
SELECT *
FROM LineItem

INSERT INTO [User] (Username, Password, FirstName, LastName, PhoneNumber, Email, Reviewer, Admin)
VALUES ('jimbob24', 'jimbobpass', 'Jim', 'Bob', '5138887621', 'jim.bob@gmail.com', 0, 0);

INSERT INTO [User] (Username, Password, FirstName, LastName, PhoneNumber, Email, Reviewer, Admin)
VALUES ('wrigleygumbiggestfan', '2849', 'Samantha', 'Gummy', '5139342151', 'wrigleygumbiggestfan@yahoo.com', 1, 0);

INSERT INTO [User] (Username, Password, FirstName, LastName, PhoneNumber, Email, Reviewer, Admin)
VALUES ('beesarecool', 'ilovebees', 'Bill', 'Hive', '8102568422', 'coolbees@hotmail.com', 0, 1);

INSERT INTO Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
VALUES (1, 'Beehive Business', '4860 Honey Way', 'New Orleans', 'LA', 70001, 225789456, 'beehive@gmail.com');

INSERT INTO Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
VALUES (2, 'Wrigley Gum Company', '322 Chewing Drive', 'Louisville', 'KY', 40000, 270123456, 'wrigleygumorders@hotmail.com');

INSERT INTO Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
VALUES (3, 'Northwest Airlines', '1 Airplane Road', 'Seattle', 'WA', 98001, 2066451321, 'northwestairlines@gmail.com');

INSERT INTO Product(VendorID, PartNumber, Name, Price, Unit)
VALUES (3, 81354589554445, 'Beehive Starter Kit', 52.50, 'Standard Unit');

INSERT INTO Product(VendorID, PartNumber, Name, Price)
VALUES (2, 5, 'Lifetime Supply of Mint Chewing Gum', 9999999.99);

INSERT INTO Product(VendorID, PartNumber, Name, Price)
VALUES (1, 5487984515888888654, 'Private Plane Access', 100000.00);

INSERT INTO Request(UserID, RequestNumber, Description, Justification, DateNeeded, DeliveryMode, Total, SubmittedDate)
VALUES (4, 5654277889, 'A Standard Beehive Construction Kit', 'Need more space for more bees', '2025-03-05', 'FedEx', 52.50, '2025-02-27');

INSERT INTO Request(UserID, RequestNumber, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate, ReasonForRejection)
VALUES (3, 1, 'Lifetime Supply of Mint Chewing Gum. Reward for being the 1,000,000th customer.', 'Due to shipping error I need to make this order from the website. At least that is what I was told over the phone.', '2025-01-27', 'Monthly Arrival', 'Pending', 9999999.99, '2010-01-27', 'This user may have hacked to website to try and get unlimited gum. Denied.');

INSERT INTO Request(UserID, RequestNumber, Description, Justification, DateNeeded, DeliveryMode, Status, Total, SubmittedDate)
VALUES (2, 686, 'VIP Membership allowing for a Northwest Airlines Private Jet to be taken worldwide', 'Worldwide Concert Tour. Need to be there ASAP', '2025-04-11', 'Premium 1-day Arrival', 'Arrived', 100000.00, '2025-04-10');

INSERT INTO LineItem(RequestID, ProductID, Quantity)
VALUES (1, 1, 1);

INSERT INTO LineItem(RequestID, ProductID, Quantity)
VALUES (2, 2, 1);

INSERT INTO LineItem(RequestID, ProductID, Quantity)
VALUES (4, 3, 1);

ALTER TABLE Request
ADD CONSTRAINT FK_UserID2UserID
FOREIGN KEY (UserID) REFERENCES [User](ID);

--COMPLETED TODO: Fixed Product Foreign Key. Had to match up VendorID data to Product data.
------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE Product
ADD CONSTRAINT FK_VendorID2VendorID
FOREIGN KEY (VendorID) REFERENCES Vendor(ID);

--(Alternative Product Foreign Key using Vendor as the base Table, does not fix issue)
--ALTER TABLE Vendor
--ADD CONSTRAINT FK_ID2VendorIDProduct
--FOREIGN KEY (ID) REFERENCES Product(VendorID)

--SELECT DISTINCT VendorID 
--FROM Product;


--SELECT DISTINCT ID 
--FROM Vendor;

--UPDATE Product
--SET VendorID = 3
--WHERE VendorID = 123;

--UPDATE Product
--SET VendorID = 2
--WHERE VendorID = 154;

--UPDATE Product
--SET VendorID = 1
--WHERE VendorID = 299;

--Msg 547, Level 16, State 0, Line 129
--The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK_VendorID2VendorID". The conflict occurred in database "PRSproto", table "dbo.Vendor", column 'ID'.

------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE LineItem
ADD CONSTRAINT FK_ProductID2ProductID
FOREIGN KEY (ProductID) REFERENCES Product(ID);

ALTER TABLE LineItem
ADD CONSTRAINT FK_RequestID2RequestID
FOREIGN KEY (RequestID) REFERENCES Request(ID);

SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = '<Product>';

ALTER TABLE [User]
ADD CONSTRAINT uname
UNIQUE (Username);

ALTER TABLE LineItem
ADD CONSTRAINT req_pdt
UNIQUE (RequestID, ProductID);

ALTER TABLE Product
ADD CONSTRAINT vendor_part
UNIQUE (VendorID, PartNumber);

ALTER TABLE Vendor
ADD CONSTRAINT vcode
UNIQUE (Code);


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Add a user

-- This should succeed
INSERT INTO [User] (Username, Password, FirstName, LastName)
VALUES ('msmith', 'topsecret', 'Mike', 'Smith');

-- This should fail
INSERT INTO [User] (Username, Password, FirstName)
VALUES ('msmith', 'topsecret', 'Mike');

-- This should succeed
INSERT INTO [User] 
VALUES ('fjones', 'topsecret', 'Fred', 'Jones', '123-123-1234',
        'mike@maxtrain.com', 0, 1);


-- Vendors

-- This should succeed
INSERT INTO Vendor (Code, Name)
VALUES ('V100', 'Mike''s Toys')

-- This should fail (duplicate Code)
INSERT INTO Vendor (Code, Name)
VALUES ('V100', 'Hobbies by Susan')

-- This should succeed
INSERT INTO Vendor (Code, Name, Address, City, State, Zip)
VALUES ('V101', 'Hobbies by Susan','123 Main St.', 'Cedarville','OH', '45236')

-- This should succeed
INSERT INTO Vendor (Code, Name, Address, City, State, Zip, 
                    PhoneNumber, Email)
VALUES ('V102', 'Boats Are Us','123 Main St.', 
        'Cedarville','OH', '45236', '111-111-1111','sales@boatrus.net')


-- Product

-- This should succeed
SELECT ID AS VendorID FROM Vendor WHERE Code = 'V100';
-- use the VendorID from above in the line below...
INSERT INTO Product (VendorID, PartNumber, Name, Price)
             VALUES (1,        'PN001', 'Helicopter', 100.00)

-- This should fail (duplicate VendorID+PartNumber)
-- use the VendorID from above in the line below...
INSERT INTO Product (VendorID, PartNumber, Name, Price)
             VALUES (1,        'PN001', 'Boat', 79.00)

-- This should succeed
-- use the VendorID from above in the line below...
INSERT INTO Product (VendorID, PartNumber, Name, Price)
             VALUES (1,        'PN002', 'Boat', 79.00)

-- This should fail (missing price)
-- use the VendorID from above in the line below...
INSERT INTO Product (VendorID, PartNumber, Name)
             VALUES (1,        'PN003', 'Car')


-- Request

-- This should succeed
SELECT ID as UserID FROM [User] WHERE UserName = 'msmith'
-- use the UserID from above in the line below...
INSERT INTO Request (UserID, Description, Justification, DateNeeded)
VALUES (1, 'New Desk', 'Boss says I need it','2025-05-01')

-- This should fail (bad date)
-- use the UserID from above in the line below...
INSERT INTO Request (UserID, Description, Justification, DateNeeded)
VALUES (1, 'New Computer', 'Boss says I need it','2025-02-31')

-- This should fail (missing required column)
-- use the UserID from above in the line below...
INSERT INTO Request (UserID, Description, DateNeeded)
VALUES (1, 'New Computer', '2025-05-31')

-- This should succeed
-- use the UserID from above in the line below...
INSERT INTO Request (UserID, Description, Justification, DateNeeded, SubmittedDate)
VALUES (1, 'New Computer', 'Boss says I need it','2025-05-31', GETDATE())


-- LinesItems

-- This should succeed
SELECT ID as RequestID FROM Request WHERE Description = 'New Desk'
SELECT ID as ProductID FROM Product WHERE PartNumber = 'PN001'
-- use the RequestID and ProductID from above in the line below...
INSERT INTO LineItem (RequestID, ProductID, Quantity)
VALUES (5, 1, 30)

-- This should succeed
SELECT ID as RequestID FROM Request WHERE Description = 'New Desk'
SELECT ID as ProductID FROM Product WHERE PartNumber = 'PN002'
-- use the RequestID and ProductID from above in the line below...
INSERT INTO LineItem
VALUES (5, 3, 10)  -- RequestID, ProductID, qty


-- Return data from all tables:

SELECT username, r.Description, Quantity, 
       p.Name as Product, v.Name AS Vendor
FROM [User]     AS u
  JOIN Request  AS r  on u.id = r.UserID
  JOIN LineItem AS li on r.ID = li.RequestID
  JOIN Product  AS p  on p.id = li.ProductID
  JOIN Vendor   AS v  on v.id = p.VendorID


-- Do we have anyone who did not make any requests?
-- Do we have any incomplete requests?
SELECT username, r.Description AS ReqiestDescription, 
       Quantity, p.Name as Product, v.Name AS Vendor
FROM [User]     AS u
  LEFT JOIN Request  AS r  on u.id = r.UserID
  LEFT JOIN LineItem AS li on r.ID = li.RequestID
  LEFT JOIN Product  AS p  on p.id = li.ProductID
  LEFT JOIN Vendor   AS v  on v.id = p.VendorID