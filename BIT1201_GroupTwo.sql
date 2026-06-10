-- SQL script for Market Stall Allocation System Database
-- This script creates the database 
CREATE DATABASE Market_Stall_Allocation_System_DB;

-- SQL Code for Database Table Creation
CREATE TABLE Trader (
    TraderID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    contactNumber VARCHAR(20),
    address VARCHAR(150),
    TypeOfGoods VARCHAR(50),
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Market (
    MarketID INT AUTO_INCREMENT PRIMARY KEY,
    MarketName VARCHAR(100) NOT NULL,
    Location VARCHAR(150) NOT NULL,
    CouncilOfficer VARCHAR(100)
);

CREATE TABLE MarketStall (
    StallID INT AUTO_INCREMENT PRIMARY KEY,
    MarketID INT NOT NULL,
    LocationDescription VARCHAR(100),
    Size VARCHAR(50),
    StallType VARCHAR(50),
    AvailabilityStatus VARCHAR(20) NOT NULL,
    FORRIGN KEY (MarketID) REFERENCES Market(MarketID)
);

CREATE TABLE Allocation (
    AllocationID INT AUTO_INCREMENT PRIMARY KEY,
    TraderID INT NOT NULL,
    StallID INT NOT NULL,
    AllocationDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (TraderID) REFERENCES Trader(TraderID),
    FOREIGN KEY (StallID) REFERENCES MarketStall(StallID)
);

CREATE TABLE UsageRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    AllocationID INT NOT NULL,
    DateOfUse DATE NOT NULL,
    FeesPaid DECIMAL(10,2) NOT NULL,
    Remarks VARCHAR(200),
    FOREIGN KEY (AllocationID) REFERENCES Allocation(AllocationID)
);

-- Insert meaningful sample data into all tables to demonstrate the functionality of the system.

INSERT INTO Traders (FullName, ContactNumber, Address, TypeOfGoods, RegistrationDate) 
VALUES ('Abdul Kamara', '076111111', 'Freetown', 'Vegetables', '2026-01-10'),
('Mariama Conteh', '078222222', 'BO', 'Clothing', '2026-01-15'),
('Ibrahim Sesay','073333333', 'Kenema', 'Electronics', '2026-01-20');

INSERT INTO Market (MarketName, Location, CouncilOfficer)
VALUES ('Big Market', 'Freetown','Mr. Bangura'), ('Bo Central Market','Bo','Mrs. Kallon');

INSERT INTO MarketStall (MarketID, LocationDescription, Size, StallType, AvailabilityStatus)
VALUES (1,'Block A - stall 1', 'Small', 'Vegetable', 'Occupied'),(1,'Block B - Stall 5', 'Medium','Clothing', 'Occupied'),
(2,'Section C -Stall 3', 'Large', 'Large','Electronics', 'Available');

INSERT INTO Allocation (TraderID, StallID, AllocationDate, ExpiryDate, Status)
VALUES (1, 1, '2026-02-01', '2026-12-31','Active') , (2,2, '2026-02-05', '2026-12-31','Active');

INSERT INTO UsageRecord (AllocationID, DateOfUse, FeesPaid, Remarks)
VALUES (1, '2026-03-01', 150.00, 'Monthly fee'), (1, '2026-04-01', 100.00, 'Monthly fee'), (2, '2026-03-01', 150.00, 'Monthly fee');

-- Demonstration of UPDATE and DELETE statements
UPDATE Trader set FullName = 'Clifford .J. Jones' where TraderID =1;

DELETE FROM UsageRecord where RecordID = 3;

-- SELECT QUERIES

SELECT * FROM Trader;

-- FILTERING USING WHERE
Select * From Trader where TypeOfGoods = 'Vegetables';

--SORTING USING ORDER BY
SELECT * FROM Trader ORDER BY FullName ASC;

-- AGGREGATE FUNCTIONS
SELECT  COUNT (*) AS TotalTraders FROM Trader;

SELECT  SUM(FeesPaid) AS TotalFees FROM UsageRecord;

SELECT AVG(FeesPaid) AS AverageFees FROM UsageRecord;

SELECT * FROM Trader LIMIT 2;

-- REAL-LIFE SCENARIO QUERIE
SELECT SUM(FeesPaid) AS TotalFeesCollected FROM UsageRecord;

-- Creation of users and granting privileges
CREATE USER 'clifford'@'localhost' IDENTIFIED BY 'JONES';
CREATE USER 'JANE'@'localhost' IDENTIFIED BY 'BANGURA';
CREATE USER 'ISMATU'@'localhost' IDENTIFIED BY 'KAMARA';

-- Grant privileges
GRANT ALL PRIVILEGES ON Market_Stall_Allocation_System_DB.* TO 'clifford'@'localhost';
GRANT ALL PRIVILEGES ON Market_Stall_Allocation_System_DB.* TO 'JANE'@'localhost';
GRANT ALL PRIVILEGES ON Market_Stall_Allocation_System_DB.* TO 'ISMATU'@'localhost';

-- Changing passwords
ALTER USER 'clifford'@'localhost' IDENTIFIED BY 'JONES2873';

