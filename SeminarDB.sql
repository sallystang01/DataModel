 USE MASTER
if (select count(*) 
    from sys.databases where name = 'Seminar') > 0
BEGIN
		DROP DATABASE Seminar;
END

CREATE DATABASE Seminar;
GO
USE Seminar;

exec sp_changedbowner 'sa'

CREATE TABLE Renewal
(
RenewalID int not null IDENTITY(1, 1),
RenewalType varchar(15) not null,
RenewalPrice smallmoney not null
PRIMARY KEY (RenewalID)
)


CREATE TABLE Members
(
MemberID int not null IDENTITY(1, 1),
RenewalID int not null,
MemberNumber varchar(10) not null,
FirstName varchar(50) not null,
MiddleName varchar(50),
LastName varchar(50) not null,
Email varchar(30) not null,
Phone varchar(15) not null,
Gender varchar(10) not null,
StarDate date not null,
CurrentFlag bit not null,
BirthDate date not null,
PRIMARY KEY (MemberID),
CONSTRAINT FK_RenewalNotSupplied FOREIGN KEY (RenewalID)
REFERENCES Renewal(RenewalID)
)

CREATE TABLE MemberInterest
(
MemberID int not null,
Interest1 varchar(20) not null,
Interest2 varchar(20),
Interest3 varchar(20),
PRIMARY KEY (MemberID)
)

CREATE TABLE MemberAddress
(
AddressID int not null IDENTITY(1, 1),
MemberID int not null,
AddressType int not null,
AddressLine1 varchar(50) not null,
AddressLine2 varchar(50),
City varchar(35) not null,
StateProvince varchar(25) not null,
PostalCode varchar(15) not null,
PRIMARY KEY (AddressID),
CONSTRAINT FK_MemberIDnotSupplied FOREIGN KEY (MemberID)
REFERENCES Members(MemberID)
)

CREATE TABLE PaymentCard
(
CardID int not null IDENTITY(1, 1),
MemberID int not null,
CardType varchar(45) not null,
CardNumber varchar(20) not null,
CardExpiration date not null,
PRIMARY KEY (CardID),
CONSTRAINT FK_MemberIDmissing FOREIGN KEY (MemberID)
REFERENCES Members(MemberID)
)

CREATE TABLE Transactions
(
TransactionID int not null IDENTITY(001, 1),
CardID int not null,
TransactionDate date not null,
Charge smallmoney not null,
Result varchar(10) not null,
PRIMARY KEY (TransactionID),
CONSTRAINT FK_CardIDnotSupplied FOREIGN KEY (CardID)
REFERENCES PaymentCard(CardID)
)

CREATE TABLE Host
(
HostID int not null IDENTITY(1, 1),
FirstName varchar(50) not null,
MiddleName varchar(50),
LastName varchar(50) not null,
Email varchar(30) not null,
Phone varchar(15) not null,
Gender varchar(10) not null,
StartDate date not null,
CurrentFlag bit not null,
BirthDate date not null,
PRIMARY KEY (HostID)
)

CREATE TABLE HostAddress
(

)