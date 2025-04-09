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
FROM [USER]

SELECT *
FROM [Vendor]

SELECT *
FROM Product
SELECT *
FROM Request
SELECT *
FROM LineItem