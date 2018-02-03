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

select * from MemberInterest