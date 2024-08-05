CREATE DATABASE IF NOT EXISTS an2dgq_Netflix;
USE an2dgq_Netflix;
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Devices;
DROP TABLE IF EXISTS Logging;
DROP TABLE IF EXISTS CustomerInfo;
DROP TABLE IF EXISTS Profiles;
DROP TABLE IF EXISTS Content;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS ContentOwner;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Employee;
SET foreign_key_checks = 1;


CREATE TABLE CustomerInfo (
  CustomerID INT not null,
  Name VARCHAR(20),
  Country VARCHAR(20),
  SubscriptionType VARCHAR(20),
  CostPerMonth SMALLINT,
  CONSTRAINT pk_CustomerInfo_CustomerID PRIMARY KEY (CustomerID));

INSERT INTO CustomerInfo VALUES
 (200001, 'Elijah Rhodes', 'USA', 'Basic', 9.99),
 (200002, 'Susan Figueroa', 'Spain', 'Standard', 15.49),
 (200003, 'Adrian Gregory', 'United Kingdom', 'Premium', 19.99),
 (200004, 'Spencer Soto', 'Dominican Republic', 'Standard', 15.49),
 (200005, 'Mei Maeda', 'Japan', 'Premium', 19.99);

CREATE TABLE Devices (
  DeviceID INT not null,
  DeviceType VARCHAR(20),
  IPAddress VARCHAR(20),
  CustomerID INT,
  Country VARCHAR(20), 
  CONSTRAINT pk_Devices_DeviceID PRIMARY KEY (DeviceID),
  CONSTRAINT fk_Devices_CustomerID FOREIGN KEY (CustomerID) REFERENCES   
  CustomerInfo(CustomerID) ON DELETE CASCADE ON UPDATE NO ACTION);

INSERT INTO Devices VALUES
 (110101, 'iPhone 13', '92.205.200.224', 200001, 'USA'),
(101010, 'iPad Air', '110.190.21.169', 200001, 'Germany'),
(111111, 'Samsung Galaxy', '86.154.30.182', 200002, 'Spain'), 
(100000, 'Roku', '11.224.220.131', 200002, 'Spain'), 
(111011, 'Playstation 4', '54.1.158.70', 200003, 'Vietnam'),
(100100, 'Playstation 5', '28.222.248.70', 200003, 'United Kingdom'), 
(111110, 'iPad Pro', '29.227.258.60', 200003, 'Spain'), 
(110001, 'XBox 360', '168.197.77.142', 200004, 'Dominican Republic'), 
(101110, 'XBox 1', '89.140.102.75', 200004, 'Dominican Republic'), 
(110111, 'iPhone XS', '246.154.106.102', 200005, 'Japan'),
(101000, 'iPhone 10', '247.117.123.6', 200005, 'Japan');

CREATE TABLE Profiles (
  ProfileID INT not null,
  CustomerID INT not null,
  Name VARCHAR(20),
  Age SMALLINT,
  CONSTRAINT pk_Profiles_ProfileID_CustomerID PRIMARY KEY (ProfileID, CustomerID),
  CONSTRAINT fk_Profiles_CustomerID FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID) ON DELETE CASCADE ON UPDATE NO ACTION);

INSERT INTO Profiles VALUES
 (91234, 200001, 'Mike', 18),
 (91235, 200001, 'Stacy', 25),
 (91236, 200001, 'Bill', 33),
 (93454, 200002, 'Adi', 20),
 (93455, 200002, 'Andrew', 20),
 (93456, 200002, 'Anvitha', 20),
 (93457, 200002, 'Casey', 20),
 (93458, 200002, 'Gabrielle', 20),
 (97111, 200003, 'Will', 13),
 (97112, 200003, 'Nate', 44),
 (97113, 200004, 'Paul', 60),
 (97640, 200005, 'Connor', 23),
 (97641, 200005, 'Lilly', 14),
 (97642, 200005, 'Hannah', 31), 
 (97643, 200005, 'Jasper', 52);
 
 CREATE TABLE Genres (
  GenreID INT not null,
  GenreName VARCHAR(20),
  CONSTRAINT pk_Genres_GenreID PRIMARY KEY (GenreID));
  
INSERT INTO Genres VALUES
 (1, 'Reality'),
 (2, 'Thriller'),
 (3, 'Action'),
 (4, 'Comedy'),
 (5, 'Adventure'),
 (6, 'Horror'),
 (7, 'Romance'),
 (8, 'Western'); 
 
CREATE TABLE Content (
  ContentID INT not null,
  Title VARCHAR(30),
  Director VARCHAR(50),
  Cast VARCHAR(50),
  Year SMALLINT,
  GenreID INT,
  TypeOfContent VARCHAR(30),
  CONSTRAINT pk_Content_ContentID PRIMARY KEY (ContentID),
  CONSTRAINT fk_Content_GenreID FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE ON UPDATE NO ACTION);
  
  INSERT INTO Content VALUES
 (61234, 'Bridgerton', 'Chris Van Dusen', 'Adjoa Andoh, Julie Andrews, Lorraine Ashbourne', 2022, 7, 'show'), 
 (61235, 'Titanic', 'James Cameron', 'Kate Winslet, Leonardo Dicaprio, Billy Zane', 1997, 7, 'movie'),
 (61236, 'Django Unchained', 'Quentin Tarantino', 'Leonardo Dicaprio, Jamie Foxx, Samuel L. Jackson', 2012, 8, 'movie'),
 (61237, 'Love Is Blind', 'Matt Thomas', 'Nick Lachey, Vanessa Lachey', 2022, 7, 'show'),
 (61238, 'Parasite', 'Bong Joon-Ho', 'Song Kang-Ho, Lee Sun-Kyun, Cho Yeo-Jeong', 2019, 2, 'movie'),
 (61239, 'Scream', 'Wes Craven', 'David Arquette, Neve Campbell, Courtney Cox', 1996, 6, 'movie'),
 (81234, 'A Nightmare on Elm Street', 'Wes Craven', 'Robert Englund, Johnny Depp, Heather Langenkamp', 1984, 6, 'movie'),
(81235, 'Queer Eye', 'David Collins', 'Bobby Berk, Karamo Brown, Tan France', 2021, 1, 'show'),
(81236, 'Demon Slayer', 'Haruo Sotozaki', 'Natsuki Hanae, Akari Kito, Hiro Shimono', 2019, 5, 'show'),
(81237, 'Hercules', 'Ron Clements, John Musker', 'Tate Donovan, Danny DeVito, James Woods', 1997, 5, 'movie');
 
CREATE TABLE Logging(
  ProfileID INT not null,
  CustomerID INT not null,
  TimeDate VARCHAR(20) not null,
  StreamingContentID INT not null,
  StreamingDuration SMALLINT not null,
  DeviceID INT, 
  CONSTRAINT pk_Profile_ID_CustomerID_TimeDate_DeviceID PRIMARY KEY (ProfileID,   
  CustomerID, TimeDate, DeviceID),   
  CONSTRAINT fk_Profile_ID_CustomerID FOREIGN KEY (ProfileID, CustomerID)  
  REFERENCES Profiles(ProfileID, CustomerID) ON DELETE CASCADE ON UPDATE NO   
  ACTION,   
  CONSTRAINT fk_StreamingContent_ID FOREIGN KEY (StreamingContentID) REFERENCES   
  Content(ContentID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT fk_Device_ID FOREIGN KEY (DeviceID)  REFERENCES Devices(DeviceID) 
  ON DELETE CASCADE ON UPDATE NO ACTION);

INSERT INTO Logging VALUES
 
(91234, 200001, '05.22-03.25.2021', 81237 , 13, 110111), 
(91235, 200001, '21.59-04.09.2021', 61234 , 102, 101000), 
(91236, 200001, '17.31-04.11.2021', 61237 , 59, 100000),
(93454, 200002, '20.01-02.21.2021', 81235 , 61, 101010),
(93455, 200002, '17.12-02.25.2021', 61238 , 243, 110101),
(93456, 200002, '08.37-03.01.2021', 81237 , 37, 111111),
(93457, 200002, '22.18-03.18.2021', 81236 , 79, 100100),
(93458, 200002, '06.51-03.27.2021', 61235 , 8, 111011),
(97111, 200003, '09.32-04.11.2021', 61236 , 21, 110111),
(97112, 200003, '18.12-04.12.2021', 81234 , 119, 110101),
(97113, 200004, '21.18-03.06.2021', 61239 , 216, 101110),
(97640, 200005, '13.40-03.13.2021', 61239 , 123, 110001),
(97113, 200004, '15.18-03.09.2021', 61236 , 216, 101110),
(93454, 200002, '05.01-02.24.2021', 61237 , 61, 101010),
(93455, 200002, '19.12-07.25.2021', 61234 , 243, 110101),
(91236, 200001, '22.13-08.11.2021', 81234 , 59, 100000);

CREATE TABLE ContentOwner (
  FilmStudio VARCHAR(40) not null,
  ContentID INT not null,
  CONSTRAINT pk_ContentOwner_FilmStudio_ContentID PRIMARY KEY (FilmStudio,   
  ContentID),
  CONSTRAINT fk_ContentOwner_ContentID FOREIGN KEY (ContentID) REFERENCES    
  Content(ContentID) ON DELETE CASCADE ON UPDATE NO ACTION);

INSERT INTO ContentOwner VALUES
 ('Shondaland', 61234),
 ('Lightstorm Entertainment', 61235),
 ('Paramount Pictures Studios', 61235),
 ('20th Century Studios', 61235),
 ('The Weinstein Company', 61236),
 ('Columbia Pictures', 61236),
 ('A Band Apart', 61236),
 ('Netflix', 61237),
 ('CJ Entertainment', 61238),
 ('TMS Entertainment', 61238),
 ('Woods Entertainment', 61239),
 ('New Line Cinema', 81234),
 ('Media Home Entertainment', 81234),
 ('Scout Productions', 81235),
 ('ITV Studios', 81235),
 ('Ufotable Studio', 81236),
 ('Shueisha', 81236),
 ('Aniplex', 81236),
 ('Walt Disney Pictures', 81237),
 ('Walt Disney Animation Studios', 81237),
 ('The Walt Disney Company', 81237);
 
 CREATE TABLE Employee (
  EmployeeID INT not null,
  EmployeeName VARCHAR(20) not null,
  salary INT,
  CONSTRAINT pk_Employee_EmployeeID PRIMARY KEY (EmployeeID));

INSERT INTO Employee VALUES
 (10001, 'Martha Byrd', 60000),
 (10204,'Traci Goodwin', 88000),
 (20313, 'Anthony Thomas', 137000),
 (24230, 'Bruce Crawford', 181000),
 (50610,' Gerald Aguilar', 305000);


CREATE TABLE Contract (
  ContractID INT not null,
  ContentID INT not null,
  EmployeeID INT not null,
  StartDate DATE,
  EndDate DATE,
  contractAmount BIGINT not null,
  country VARCHAR(50),
  CONSTRAINT pk_Contract_contractID PRIMARY KEY (ContractID),
  CONSTRAINT fk_Contract_contentID FOREIGN KEY (ContentID) REFERENCES    
  Content(ContentID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT fk_Contract_employeeID FOREIGN KEY (EmployeeID) REFERENCES    
  Employee(EmployeeID) ON DELETE CASCADE ON UPDATE NO ACTION);

INSERT INTO Contract VALUES
 (70123, 61234, 50610, '2019-05-23', '2029-05-31', 100000000, 'United States'),
 (70124, 61235, 50610, '2008-03-14', '2028-03-31', 225000000, 'United States'),
 (71187, 61236, 10204, '2013-08-02', '2023-07-31', 150000000,  'Canada'),
 (71188, 61236, 10204, '2014-06-23', '2022-06-30', 100000000,  'Japan'),
 (71189, 61236, 10001, '2018-10-11', '2023-10-31', 50000000, 'India '),
 (72398, 61238, 50610, '2020-04-26', '2023-04-30', 350000000, 'United States'),
 (75691, 61239, 24230, '2020-04-26', '2026-12-31', 50000000,  'United States'),
 (78910, 61239, 24230, '2012-07-23', '2022-07-31', 20000000, 'Mexico'),
 (72399, 81237, 10204, '2014-01-07', '2024-01-31', 40000000,  'United Kingdom'),
 (78911, 81237, 10204, '2014-01-07', '2024-01-31', 40000000, 'France');
 
SELECT * FROM CustomerInfo;
SELECT * FROM Devices;
SELECT * FROM Logging;
SELECT * FROM Profiles;
SELECT * FROM Content;
SELECT * FROM Genres;
SELECT * FROM ContentOwner;
SELECT * FROM Contract;
SELECT * FROM Employee;

