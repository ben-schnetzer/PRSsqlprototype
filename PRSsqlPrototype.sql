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
VALUES (299, 'Beehive Business', '4860 Honey Way', 'New Orleans', 'LA', 70001, 225789456, 'beehive@gmail.com');

INSERT INTO Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
VALUES (154, 'Wrigley Gum Company', '322 Chewing Drive', 'Louisville', 'KY', 40000, 270123456, 'wrigleygumorders@hotmail.com');

INSERT INTO Vendor (Code, Name, Address, City, State, Zip, PhoneNumber, Email)
VALUES (123, 'Northwest Airlines', '1 Airplane Road', 'Seattle', 'WA', 98001, 2066451321, 'northwestairlines@gmail.com');

INSERT INTO Product(VendorID, PartNumber, Name, Price, Unit)
VALUES (299, 81354589554445, 'Beehive Starter Kit', 52.50, 'Standard Unit');

INSERT INTO Product(VendorID, PartNumber, Name, Price)
VALUES (154, 5, 'Lifetime Supply of Mint Chewing Gum', 9999999.99);

INSERT INTO Product(VendorID, PartNumber, Name, Price)
VALUES (123, 5487984515888888654, 'Private Plane Access', 100000.00);

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