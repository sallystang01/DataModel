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
StartDate date not null,
CurrentFlag bit not null,
BirthDate date not null,
PRIMARY KEY (MemberID),
CONSTRAINT FK_RenewalNotSupplied FOREIGN KEY (RenewalID)
REFERENCES Renewal(RenewalID)
)

CREATE TABLE MemberInterest
(
InterestID int not null IDENTITY(1, 1),
MemberID int not null,
Interest varchar(20) not null,
PRIMARY KEY (InterestID),
CONSTRAINT FK_MemberNotSelected FOREIGN KEY (MemberID)
REFERENCES Members(MemberID)
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
CardID int not null IDENTITY(101, 1),
MemberID int not null,
CardType varchar(75) not null,
CardNumber varchar(30) not null,
CardExpiration date not null,
PRIMARY KEY (CardID),
CONSTRAINT FK_MemberIDmissing FOREIGN KEY (MemberID)
REFERENCES Members(MemberID)
)

CREATE TABLE Transactions
(
TransactionID int not null IDENTITY(1001, 1),
CardID int not null,
TransactionDate date not null,
Charge smallmoney not null,
Result varchar(15) not null,
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
AddressID int not null IDENTITY(1, 1),
HostID int not null,
AddressLine1 varchar(50) not null,
AddressLIne2 varchar(50),
City varchar(35) not null,
StateProvince varchar(25) not null,
PostalCode varchar(15) not null,
PRIMARY KEY (AddressID),
CONSTRAINT FK_HostNotSupplied FOREIGN KEY (HostID)
REFERENCES Host(HostID)
)

CREATE TABLE [Events]
(
EventID int not null IDENTITY(1, 1),
HostID int not null,
EventName varchar(100) not null,
EventDate date not null,
StartTime time(1) not null,
EndTime time(1) not null,
EDescription varchar(1000) not null,
Comments varchar(1000),
PRIMARY KEY (EventID),
CONSTRAINT FK_MissingHost FOREIGN KEY (HostID)
REFERENCES Host(HostID)
)

CREATE TABLE EventAttendance
(
AttendanceID int not null IDENTITY(1, 1),
EventID int not null,
MemberID int not null,
PresentStatus bit not null,
PRIMARY KEY (AttendanceID),
CONSTRAINT FK_MissingEvent FOREIGN KEY (EventID)
REFERENCES [Events](EventID),
CONSTRAINT FK_MissingMember FOREIGN KEY (MemberID)
REFERENCES Members(MemberID)
)


--==============================================INSERTS========================================================--

INSERT INTO Renewal (RenewalType, RenewalPrice)
VALUES ('2 Year Plan', 189.00),
		('1 Year Plan', 99.00),
		('Quarterly', 27.00),
		('Monthly', 9.99)



INSERT INTO Members (RenewalID, MemberNumber, FirstName, MiddleName, LastName, Email, Phone, Gender, StartDate, CurrentFlag, BirthDate)
	VALUES ('4',	'M0001',	'Otis',	'Brooke',	'Fallon',	'bfallon0@artisteer.com',	'818-873-3863',	'Male',	'2017-04-07',	'1',	'1971-06-29'),
('4',	'M0002',	'Katee',	'Virgie',	'Gepp',	'vgepp1@nih.gov',	'503-689-8066',	'Female',	'2017-11-29',	'1',	'1972-04-03'),
('3',	'M0003',	'Lilla',	'Charmion',	'Eatttok',	'ceatttok2@google.com.br',	'210-426-7426',	'Female',	'2017-02-26',	'1',	'1975-12-13'),
('3',	'M0004',	'Ddene',	'Shelba',	'Clapperton',	'sclapperton3@mapquest.com',	'716-674-1640',	'Female',	'2017-11-05',	'1',	'1997-02-19'),
('4',	'M0005',	'Audrye',	'Agathe',	'Dawks',	'adawks4@mlb.com',	'305-415-9419',	'Female',	'2016-01-15',	'1',	'1989-02-07'),
('2',	'M0006',	'Fredi',	'Melisandra',	'Burgyn',	'mburgyn5@cbslocal.com',	'214-650-9837',	'Female',	'2017-03-13',	'1',	'1956-05-31'),
('4',	'M0007',	'Dimitri',	'Francisco',	'Bellino',	'fbellino6@devhub.com',	'937-971-1026',	'Male',	'2017-08-09',	'1',	'1976-10-12'),
('2',	'M0008',	'Enrico',	'Cleve',	'Seeney',	'cseeney7@macromedia.com',	'407-445-6895',	'Male',	'2016-09-09',	'1',	'1988-02-29'),
('2',	'M0009',	'Marylinda',	'Jenine',	'OSiaghail',	'josiaghail8@tuttocitta.it',	'206-484-6850',	'Female',	'2016-11-21',	'0',	'1965-02-06'),
('4',	'M0010',	'Luce',	'Codi',	'Kovalski',	'ckovalski9@facebook.com',	'253-159-6773',	'Male',	'2017-12-22',	'1',	'1978-03-31'),
('4',	'M0011',	'Claiborn',	'Shadow',	'Baldinotti',	'sbaldinottia@discuz.net',	'253-141-4314',	'Male',	'2017-03-19',	'1',	'1991-12-26'),
('3',	'M0012',	'Isabelle',	'Betty',	'Glossop',	'bglossopb@msu.edu',	'412-646-5145',	'Female',	'2016-04-25',	'1',	'1965-02-17'),
('2',	'M0013',	'Davina',	'Lira',	'Wither',	'lwitherc@smugmug.com',	'404-495-3676',	'Female',	'2016-03-21',	'1',	'1957-12-16'),
('4',	'M0014',	'Panchito',	'Hashim',	'De Gregorio',	'hdegregoriod@a8.net',	'484-717-6750',	'Male',	'2017-01-27',	'1',	'1964-10-14'),
('4',	'M0015',	'Rowen',	'Arvin',	'Birdfield',	'abirdfielde@over-blog.com',	'915-299-3451',	'Male',	'2017-10-06',	'0',	'1983-01-09')

INSERT INTO MemberAddress (MemberID,AddressType, AddressLine1, AddressLine2, City, StateProvince, PostalCode)
	VALUES ('1',	'3',	'020 New Castle Way',	null,	'Port Washington',	'New York',	'11054'),
('2',	'3',	'8 Corry Parkway',	null,	'Newton',	'Massachusetts',	'2458'),
('3',	'3',	'39426 Stone Corner Drive',	null,	'Peoria',	'Illinois',	'61605'),
('4',	'3',	'921 Granby Junction',	null,	'Oklahoma City',	'Oklahoma',	'73173'),
('5',	'3',	'77 Butternut Parkway',	null,	'Saint Paul',	'Minnesota',	'55146'),
('6',	'3',	'821 Ilene Drive',	null,	'Odessa',	'Texas',	'79764'),
('7',	'3',	'1110 Johnson Court',	null,	'Rochester',	'New York',	'14624'),
('8',	'3',	'6 Canary Hill',	null,	'Tallahassee',	'Florida',	'32309'),
('9',	'3',	'9 Buhler Lane',	null,	'Bismarck',	'North Dakota',	'58505'),
('10',	'3',	'99 Northwestern Pass',	null,	'Midland',	'Texas',	'79710'),
('11',	'3',	'69 Spenser Hill',	null,	'Provo',	'Utah',	'84605'),
('12',	'3',	'3234 Kings Court',	null,	'Tacoma',	'Washington',	'98424'),
('13',	'3',	'3 Lakewood Gardens Circle',	null,	'Columbia',	'South Carolina',	'29225'),
('14',	'3',	'198 Muir Parkway',	null,	'Fairfax',	'Virginia',	'22036'),
('15',	'3',	'258 Jenna Drive',	null,	'Pensacola',	'Florida',	'32520')

INSERT INTO PaymentCard (MemberID, CardType, CardNumber, CardExpiration)
	VALUES ('1',	'AmericanExpress',	'337941553240515',	'2019-09-01'),
('2',	'Visa',	'4041372553875903',	'2020-01-01'),
('3',	'Visa',	'4041593962566',	'2019-03-01'),
('4',	'JCB',	'3559478087149594',	'2019-04-01'),
('5',	'JCB',	'3571066026049076',	'2018-07-01'),
('6',	'Diners-Club-Carte-Blanche',	'30423652701879',	'2018-05-01'),
('7',	'JCB',	'3532950215393858',	'2019-02-01'),
('8',	'JCB',	'3569709859937370',	'2019-03-01'),
('9',	'JCB',	'3529188090740670',	'2019-05-01'),
('10',	'JCB',	'3530142576111598',	'2019-11-01'),
('11',	'MasterCard',	'5108756299877313',	'2018-07-01'),
('12',	'JCB',	'3543168150106220',	'2018-06-01'),
('13',	'JCB',	'3559166521684728',	'2019-10-01'),
('14',	'Diners-Club-Carte-Blanche',	'30414677064054',	'2018-06-01'),
('15',	'JCB',	'3542828093985763',	'2020-03-01')

INSERT INTO MemberInterest (MemberID, Interest)
	VALUES ('1',	'Acting'),
('1',	'Video Games'),
('1',	'Crossword Puzzles'),
('2',	'Calligraphy'),
('3',	'Movies'),
('3',	'Restaurants'),
('3',	'Woodworking'),
('4',	'Juggling'),
('4',	'Quilting'),
('5',	'Electronics'),
('6',	'Sewing'),
('6',	'Cooking'),
('6',	'Movies'),
('7',	'Botany'),
('7',	'Skating'),
('8',	'Dancing'),
('8',	'Coffee'),
('8',	'Foreign Languages'),
('9',	'Fashion'),
('10',	'Woodworking'),
('11',	'Homebrewing'),
('11',	'Geneology'),
('11',	'Movies'),
('11',	'Scrapbooking'),
('12',	'Surfing'),
('12',	'Amateur Radio'),
('13',	'Computers'),
('14',	'Writing'),
('14',	'Singing'),
('15',	'Reading'),
('15',	'Pottery')

INSERT INTO Host (FirstName, MiddleName, LastName, Email, Phone, Gender, StartDate, CurrentFlag, BirthDate)
	VALUES ('Tiffany',	'Watt',	'Smith',	'tiffanywatt2@gmail.com',	'352-123-4567',	'Female',	'2016-01-01',	'1',	'1974-04-13'),
('Simon',	null,	'Sinek',	'simon2@gmail.com',	'352-542-1234',	'Male',	'2016-01-01',	'1',	'1983-12-12'),
('Dan',	null,	'Pink',	'dan2@gmail.com',	'352-929-0101',	'Male',	'2016-01-01',	'1',	'1989-02-03'),
('Elizabeth',	null,	'Gilbert',	'elizabeth2@gmail.com',	'352-112-1212',	'Female',	'2016-01-01',	'1',	'1964-07-01'),
('Andrew',	null,	'Comeau',	'andrew2@gmail.com',	'352-313-3142',	'Male',	'2016-01-01',	'1',	'1991-09-12')

INSERT INTO HostAddress (HostID, AddressLine1, AddressLIne2, City, StateProvince, PostalCode)
	VALUES (1, '942 76th Street', null, 'Ocala', 'Florida', '34470'),
			(2, '832 Magnolia Avenue', null, 'Ocala', 'Florida', '34470'),
			(3, '11234 98th Circle', null, 'Ocala', 'Florida', '34470'),
			(4, '903 Highway 441', null, 'Ocala', 'Florida', '34470'),
			(5, '1337 Programming Street', null, 'Ocala', 'Florida', '34470')

INSERT INTO [Events] (HostID, EventName, EventDate, StartTime, EndTime, EDescription, Comments)
	VALUES ('1',	'The History of Human Emotions',	'2017-01-12',	'12:00',	'2:00',	'History of human emotions',	'This will be fun'),
('2',	'How Great Leaders Inspire Action',	'2017-02-22',	'12:00',	'1:00',	'How great leaders inspire action',	'Helpful class and inspiration'),
('3',	'The Puzzle of Motivation',	'2017-03-05',	'12:00',	'3:00',	'Motivational',	'Motivate people'),
('4',	'Your Elusive Creative Genius',	'2017-04-16',	'12:00',	'2:00',	'Learn to become a genius!',	'Thinking Skills'),
('5',	'Why are Programmers So Smart?',	'2017-05-01',	'12:00',	'2:30',	'Overview of how smart programmers are',	'Programmers are awesome')

INSERT INTO EventAttendance (EventID, MemberID, PresentStatus)
	VALUES (1, 1, 0),
			(2, 1, 0),
			(3, 1, 1),
			(4, 1, 1),
			(5, 1, 1),
			(1, 2, 1),
			(2, 2, 0),
			(3, 2, 1),
			(4, 2, 1),
			(5, 2, 0),
			(1, 3, 1),
			(2, 3, 1),
			(3, 3, 1),
			(4, 3, 0),
			(5, 3, 1),
			(1, 4, 1),
			(2, 4, 1),
			(3, 4, 1),
			(4, 4, 1),
			(5, 4, 1),
			(1, 5, 1),
			(2, 5, 1),
			(3, 5, 1),
			(4, 5, 1),
			(5, 5, 0),
			(1, 6, 1),
			(2, 6, 0),
			(3, 6, 1),
			(4, 6, 1),
			(5, 6, 0),
			(1, 7, 0),
			(2, 7, 1),
			(3, 7, 1),
			(4, 7, 1),
			(5, 7, 0),
			(1, 8, 1),
			(2, 8, 1),
			(3, 8, 1),
			(4, 8, 1),
			(5, 8, 0),
			(1, 9, 0),
			(2, 9, 1),
			(3, 9, 1),
			(4, 9, 1),
			(5, 9, 0),
			(1, 10, 1),
			(2, 10, 1),
			(3, 10, 0),
			(4, 10, 0),
			(5, 10, 0),
			(1, 11, 1),
			(2, 11, 1),
			(3, 11, 0),
			(4, 11, 0),
			(5, 11, 0),
			(1, 12, 1),
			(2, 12, 0),
			(3, 12, 1),
			(4, 12, 1),
			(5, 12, 1),
			(1, 13, 1),
			(2, 13, 1),
			(3, 13, 0),
			(4, 13, 0),
			(5, 13, 1),
			(1, 14, 0),
			(2, 14, 1),
			(3, 14, 1),
			(4, 14, 1),
			(5, 14, 0),
			(1, 15, 1),
			(2, 15, 1),
			(3, 15, 1),
			(4, 15, 1),
			(5, 15, 0)

INSERT INTO Transactions (CardID, TransactionDate, Charge, Result)
	VALUES ('105',	'2016-01-15',	'9.99',	'Approved'),
('105',	'2016-02-15',	'9.99',	'Approved'),
('105',	'2016-03-15',	'9.99',	'Approved'),
('113',	'2016-03-21',	'99',	'Approved'),
('105',	'2016-04-15',	'9.99',	'Approved'),
('113',	'2016-04-21',	'99',	'Approved'),
('112',	'2016-04-25',	'27',	'Approved'),
('105',	'2016-05-15',	'9.99',	'Approved'),
('105',	'2016-06-15',	'9.99',	'Approved'),
('105',	'2016-07-15',	'9.99',	'Approved'),
('112',	'2016-07-25',	'27',	'Approved'),
('105',	'2016-08-15',	'9.99',	'Approved'),
('108',	'2016-09-09',	'99',	'Approved'),
('105',	'2016-09-15',	'9.99',	'Approved'),
('105',	'2016-10-15',	'9.99',	'Approved'),
('112',	'2016-10-25',	'27',	'Approved'),
('105',	'2016-11-15',	'9.99',	'Approved'),
('109',	'2016-11-21',	'99',	'Approved'),
('105',	'2016-12-15',	'9.99',	'Approved'),
('105',	'2017-01-15',	'9.99',	'Approved'),
('112',	'2017-01-25',	'27',	'Approved'),
('114',	'2017-01-27',	'9.99',	'Approved'),
('105',	'2017-02-15',	'9.99',	'Approved'),
('103',	'2017-02-26',	'27',	'Approved'),
('114',	'2017-02-27',	'9.99',	'Approved'),
('106',	'2017-03-13',	'99',	'Approved'),
('105',	'2017-03-15',	'9.99',	'Approved'),
('111',	'2017-03-19',	'9.99',	'Approved'),
('114',	'2017-03-27',	'9.99',	'Approved'),
('101',	'2017-04-07',	'9.99',	'Approved'),
('105',	'2017-04-15',	'9.99',	'Approved'),
('111',	'2017-04-19',	'9.99',	'Approved'),
('112',	'2017-04-25',	'27',	'Approved'),
('114',	'2017-04-27',	'9.99',	'Approved'),
('101',	'2017-05-07',	'9.99',	'Approved'),
('105',	'2017-05-15',	'9.99',	'Approved'),
('111',	'2017-05-19',	'9.99',	'Approved'),
('103',	'2017-05-26',	'27',	'Approved'),
('114',	'2017-05-27',	'9.99',	'Approved'),
('101',	'2017-06-07',	'9.99',	'Declined'),
('101',	'2017-06-08',	'9.99',	'Approved'),
('105',	'2017-06-15',	'9.99',	'Approved'),
('111',	'2017-06-19',	'9.99',	'Approved'),
('114',	'2017-06-27',	'9.99',	'Approved'),
('101',	'2017-07-07',	'9.99',	'Approved'),
('105',	'2017-07-15',	'9.99',	'Approved'),
('111',	'2017-07-19',	'9.99',	'Declined'),
('111',	'2017-07-20',	'9.99',	'Approved'),
('112',	'2017-07-25',	'27',	'Approved'),
('114',	'2017-07-27',	'9.99',	'Approved'),
('101',	'2017-08-07',	'9.99',	'Approved'),
('107',	'2017-08-09',	'9.99',	'Approved'),
('105',	'2017-08-15',	'9.99',	'Approved'),
('111',	'2017-08-19',	'9.99',	'Approved'),
('103',	'2017-08-26',	'27',	'Approved'),
('114',	'2017-08-27',	'9.99',	'Approved'),
('101',	'2017-09-07',	'9.99',	'Approved'),
('107',	'2017-09-09',	'9.99',	'Approved'),
('108',	'2017-09-09',	'99',	'Approved'),
('105',	'2017-09-15',	'9.99',	'Approved'),
('111',	'2017-09-19',	'9.99',	'Approved'),
('114',	'2017-09-27',	'9.99',	'Approved'),
('115',	'2017-10-06',	'9.99',	'Invalid Card'),
('101',	'2017-10-07',	'9.99',	'Approved'),
('107',	'2017-10-09',	'9.99',	'Approved'),
('105',	'2017-10-15',	'9.99',	'Approved'),
('111',	'2017-10-19',	'9.99',	'Approved'),
('112',	'2017-10-25',	'27',	'Approved'),
('114',	'2017-10-27',	'9.99',	'Approved'),
('104',	'2017-11-05',	'27',	'Approved'),
('101',	'2017-11-07',	'9.99',	'Approved'),
('107',	'2017-11-09',	'9.99',	'Approved'),
('105',	'2017-11-15',	'9.99',	'Approved'),
('111',	'2017-11-19',	'9.99',	'Approved'),
('103',	'2017-11-26',	'27',	'Declined'),
('103',	'2017-11-27',	'27',	'Approved'),
('114',	'2017-11-27',	'9.99',	'Approved'),
('102',	'2017-11-29',	'9.99',	'Approved'),
('101',	'2017-12-07',	'9.99',	'Approved'),
('107',	'2017-12-09',	'9.99',	'Approved'),
('105',	'2017-12-15',	'9.99',	'Approved'),
('111',	'2017-12-19',	'9.99',	'Approved'),
('110',	'2017-12-22',	'9.99',	'Approved'),
('114',	'2017-12-27',	'9.99',	'Approved'),
('102',	'2017-12-29',	'9.99',	'Approved'),
('101',	'2018-01-07',	'9.99',	'Approved'),
('107',	'2018-01-09',	'9.99',	'Approved'),
('105',	'2018-01-15',	'9.99',	'Approved'),
('111',	'2018-01-19',	'9.99',	'Approved'),
('110',	'2018-01-22',	'9.99',	'Approved'),
('112',	'2018-01-25',	'27',	'Approved'),
('114',	'2018-01-27',	'9.99',	'Approved')


--=============================================------------
GO
CREATE VIEW vwRenewal
AS
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 4
	AND DATEPART(day, startdate) = DATEPART(day, getdate())

	UNION ALL
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 3
	AND DATEPART(day, startdate) = DATEPART(day, getdate())
	AND DATEPART(month, GETDATE()) IN
		((select (datepart(month, m.startdate) + 3)),
		(select (datepart(month, m.startdate) + 6)),
		(select (datepart(month, m.startdate) + 9)))
UNION ALL

select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 2
	AND DATEPART(day, startdate) = DATEPART(day, getdate())
	AND DATEPART(month, startdate) = DATEPART(month, getdate())
UNION 
ALL
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 1
	AND GETDATE() IN
	((SELECT dateadd(month, 24, m.startdate)),
	(select dateadd(month, 48, m.startdate)),
	(select dateadd(month, 72, m.startdate)))
GO	

		
--===========================CONTACT LIST===========================--
GO
CREATE VIEW vwMemberContactList
AS
select concat(LastName, ', ', FirstName) [Member Name], ma.AddressLine1, ma.AddressLine2,
			ma.City, ma.StateProvince, ma.PostalCode, m.Phone, m.Email
from Members m
inner join
MemberAddress ma
on m.MemberID = ma.MemberID
GO

--===========================Email List===========================--
CREATE VIEW vwMemberEmailList
AS
select concat(lastname, ', ', firstname) [Member Name], Email
from Members
GO

--===========================Member Birthdays===========================--

CREATE VIEW vwMemberMonthlyBirthdays
AS
select concat(lastname, ', ', firstname) [Member Name],  BirthDate
from Members
where DATENAME(month, birthdate) = DATENAME(month, getdate())
GO

--===========================Renewals===========================--
CREATE PROCEDURE sp_Renewal

	AS
	BEGIN

		IF EXISTS (select * from vwRenewal)
			BEGIN
				INSERT INTO Transactions (CardID, TransactionDate, Charge, Result)
					VALUES (		(select CardID
										from vwRenewal),
											getdate(),
												(select RenewalPrice
													from vwRenewal),
														'Pending')
				END
	SELECT * FROM Transactions WHERE Result = 'Pending'

	END

--===========================Expired Cards===========================--
GO
CREATE VIEW vwExpiredCards
AS
select *
from PaymentCard
where CardExpiration < GETDATE()
GO

--===========================Monthly Income===========================--
CREATE PROCEDURE sp_MonthlyIncome
	
	@StartDate date,
	@EndDate date
	AS
	BEGIN
select sum(t.charge) [Income]
from Transactions t
where t.TransactionDate between @StartDate and @EndDate

END 

GO
--===========================Member Sign Ups===========================--
CREATE PROCEDURE sp_MemberSignUps
	
	@StartDate date,
	@EndDate date
	AS
	BEGIN
select count(memberid) [Number of Sign Ups]
from Members
where StartDate between @StartDate and @EndDate

END 
GO

--exec sp_MemberSignUps '2016-01-01', '2016-01-31'

--===========================Attendance Per Event===========================--

CREATE PROCEDURE sp_AttendancePerEvent
	
	@StartDate date,
	@EndDate date
	AS
	BEGIN
select e.EventID, count(memberid) [Amount Attended], e.EventName, e.EventDate
from EventAttendance ea
inner join
[Events] e
on e.EventID = ea.EventID
where e.EventDate between @StartDate and @EndDate
group by e.EventID, e.EventName, e.EventDate

END 
GO

--Passwords table where passwords are stored

CREATE TABLE Passwords
(
    MemberID INT IDENTITY(1,1) NOT NULL,
    LoginName NVARCHAR(40) NOT NULL,
    PasswordHash BINARY(64) NOT NULL,
    FirstName NVARCHAR(40) NULL,
    LastName NVARCHAR(40) NULL,
    CONSTRAINT [PK_Member_MemberID] PRIMARY KEY CLUSTERED (MemberID ASC)
)
	
	GO
	--Password Procedure that inserts new password
CREATE PROCEDURE NewPassword
    @pLogin NVARCHAR(50), 
    @pPassword NVARCHAR(50), 
    @pFirstName NVARCHAR(40) = NULL, 
    @pLastName NVARCHAR(40) = NULL,
    @responseMessage NVARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    BEGIN 

        INSERT INTO Passwords(LoginName, PasswordHash, FirstName, LastName)
        VALUES(@pLogin, HASHBYTES('SHA2_256', @pPassword), @pFirstName, @pLastName)

        SET @responseMessage='Success'

    END
   

END
	
--TEST TO MAKE SURE PASSWORD PROCEDURE WORKS

--	DECLARE @responseMessage NVARCHAR(250)

--EXEC NewPassword
--          @pLogin = 'bfallon0@artisteer.com',
--          @pPassword = 'Cheese',
--          @pFirstName = 'Otis',
--          @pLastName = 'Fallon',
--          @responseMessage=@responseMessage OUTPUT

--SELECT *
--FROM Passwords


PRINT 'DATABASE LOADED SUCCESSFULLY'