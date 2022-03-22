--#Create table

CREATE TABLE EmployeeDemographics
 (EmployeeID int,
 Firstname varchar(50),
 LastName varchar(50),
 Age int,
 Gender varchar(50)
 )

CREATE TABLE EmployeeSalary
 (EmployeeID int,
 JobTitle varchar(50),
 Salary int)

CREATE TABLE WareHouseEmployeeDemograhics
  (EmployeeID int,
 Firstname varchar(50),
 LastName varchar(50),
 Age int,
 Gender varchar(50)
 )

--Insert into

INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasly', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman',63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

INSERT INTO WareHouseEmployeeDemograhics VALUES
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')


--Select Statement
--Top, Distinct, Count, As, Max, Min, Avg

Select *
From EmployeeDemographics

Select Top 5 *
From EmployeeDemographics

Select Distinct(EmployeeID)
From EmployeeDemographics

Select Count(Lastname) As LastnameCount
From EmployeeDemographics

Select Max(Salary) As MaxSalary
From EmployeeSalary

Select Min(Salary) As MinSalary
From EmployeeSalary

Select Avg(Salary) As AvgSalary
From EmployeeSalary


--Where Statement
-- =, <>, <, >, AND, OR, LIKE, NULL, NOT NULL, IN

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim' -- =, <>, <, >

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim' AND Gender = 'Male' ---AND, OR

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%' --S%, %S%, S%o%

SELECT *
FROM EmployeeDemographics
WHERE FirstName IS NULL -- IS NULL, IS NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'MICHAEL')


-- GROUP BY, ORDER BY

SELECT Gender, Count(Gender) CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC


-- INNER JOINS, FULL/LEFT/RIGHT/OUTER JOINS


SELECT *
FROM EmployeeDemographics
INNER JOIN EmployeeSalary  -- INNER/FULL,LEFT,RIGHT,OUTER
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE Firstname <> 'Michaael'
ORDER BY Salary DESC

-- UNION/ UNION ALL

SELECT *
FROM EmployeeDemographics
UNION  -- UNION/ UNION ALL
SELECT *
FROM WareHouseEmployeeDemograhics
ORDER BY EmployeeID

-- CASE STATEMENT

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .01)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- HAVING CLAUSE

SELECT JobTitle, AVG(Salary) AverageSalary
 FROM EmployeeDemographics
 JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

-- UPDATING/ DELETING DATA


UPDATE WareHouseEmployeeDemograhics
SET Age = 30
WHERE EmployeeID = 1013

DELETE FROM WareHouseEmployeeDemograhics
WHERE EmployeeID = 1051

-- ALIASING

SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

-- PARTITION BY

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID


-- CTEs

WITH CTE_Employee AS	
 (SELECT FirstName, LastName, Gender, Salary,
  COUNT(gender) OVER (PARTITION BY Gender) as TotalGender,
  AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
 FROM EmployeeDemographics emp
 JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
 WHERE Salary > '45000'
 )
 SELECT FirstName, AvgSalary
 FROM CTE_Employee


-- TEMP TABLES

CREATE TABLE #Temp_Employee (
EmplpoyeeID int,
JobTitle varchar(100),
Salary int
)
SELECT *
FROM #Temp_Employee

INSERT INTO #Temp_Employee VALUES (
'1001', 'HR', '45000'
)

INSERT INTO #Temp_Employee
SELECT *
FROM EmployeeSalary

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO	#Temp_Employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics emp	
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2


 --String Functions = TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

 CREATE TABLE  EmployeeErrors (
 EmployeeID varchar(50),
 FirstName varchar(50),
 LastName varchar(50)
 )

 INSERT INTO EmployeeErrors VALUES
 ('1001  ', 'Jimbo', 'Halbert'),
 ('  1002', 'Pamela', 'Beasly'),
 ('1005', 'TOby', 'Flenderson - Fired')


 SELECT *
 FROM EmployeeErrors


--USING TRIM, LTRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

--USING REPLACE

SELECT LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
FROM EmployeeErrors

--USING SUBSTRING

SELECT SUBSTRING(err.FirstName, 1, 3),	SUBSTRING(dem.FirstName, 1, 3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3)

-- USING UPPER AND LOWER

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

-- STORED PROCEDURES

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST