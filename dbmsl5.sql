 CREATE DATABASE CollegeJoinDB; 
USE CollegeJoinDB; 
CREATE TABLE Departments (DeptID INT PRIMARY KEY,
DeptName VARCHAR(50),
Location VARCHAR(50)
);
create table Employees  (
EmpName int primary key,
DeptID Int,
Salary Decimal (10.2),
City varchar(50));
create table SalaryGrades (
Grade char(2) primary key,
MinSalary decimal(10,2),
ManSalary decimal(10,2));
 INSERT INTO Departments VALUES 
 (10,'Computer Science','Block A'), 
 (20,'Pharmacy','Block B'), 
 (30,'Management','Block C'), 
 (40,'Civil Engineering','Block D'); 
  alter table Employees
  add column EmpID int first;
  drop table Employees;
  create table Employees  (
  EmpID int primary key,
EmpName varchar(50),
DeptID Int,
Salary Decimal (10.2),
City varchar(50));
insert into Employees values
 (101,'Aarav',10,65000,'Delhi'),
 (102,'Priya',20,72000,'Mumbai'),
 (103,'Rahul',10,48000,'Delhi'), 
 (104,'Sneha',30,91000,'Pune'), 
 (105,'Vikram',20,55000,'Jaipur'), 
 (106,'Neha',50,80000,'Bengaluru'),
 (107,'Kabir',30,43000,'Pune'); 
  INSERT INTO SalaryGrades VALUES
  ('G1',0,49999),
  ('G2',50000,69999),
  ('G3',70000,89999), 
  ('G4',90000,120000); 
  SELECT E.EmpName, D.DeptName, D.Location
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID;
SELECT E.EmpID, E.EmpName, E.DeptID, D.DeptName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID;
SELECT E.EmpName, D.DeptName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptName = 'Pharmacy';
SELECT E.EmpName, D.DeptName, E.Salary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
WHERE E.Salary > 60000;
SELECT *
FROM Employees E, Departments D
WHERE E.DeptID = D.DeptID;
SELECT E.EmpName,
       E.City,
       D.DeptName,
       D.Location
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID;
SELECT E.EmpName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptName = 'Computer Science';
SELECT E.EmpName, E.Salary, S.Grade
FROM Employees E
JOIN SalaryGrades S
ON E.Salary > S.MinSalary;
SELECT E.EmpName,
       E.Salary,
       S.Grade
FROM Employees E
JOIN SalaryGrades S
ON E.Salary >= S.MinSalary
AND E.Salary <= S.MaxSalary;
SELECT E.EmpName, S.Grade
FROM Employees E
JOIN SalaryGrades S
ON E.Salary < S.MaxSalary;
SELECT E.EmpName,
       E.Salary,
       S.Grade
FROM Employees E
JOIN SalaryGrades S
ON E.Salary >= S.MinSalary;
SELECT EmpName, DeptID, DeptName
FROM Employees
NATURAL JOIN Departments;
SELECT EmpName, DeptName
FROM Employees
NATURAL JOIN Departments
WHERE Location = 'Block B';
SELECT EmpName,
       DeptName,
       Salary
FROM Employees
NATURAL JOIN Departments
WHERE Salary >= 70000;
SELECT E.EmpName,
       D.DeptName,
       E.Salary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
ORDER BY E.Salary DESC;
SELECT DISTINCT D.DeptName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID;
SELECT D.DeptName,
       COUNT(*) AS Employee_Count
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
GROUP BY D.DeptName;
SELECT D.DeptName,
       AVG(E.Salary) AS AvgSalary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
GROUP BY D.DeptName;
SELECT D.DeptName,
       AVG(E.Salary) AS AvgSalary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
GROUP BY D.DeptName
HAVING AVG(E.Salary) > 60000;
SELECT E.EmpName,
       D.DeptName
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
WHERE D.DeptName IN ('Computer Science','Pharmacy');
SELECT E.EmpName,
       D.DeptName,
       E.City,
       E.Salary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
WHERE (E.City = 'Delhi'
       OR E.City = 'Pune')
AND E.Salary >= 50000;
SELECT *
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID;
SELECT DeptName,
       COUNT(*) AS Employee_Count
FROM Employees
NATURAL JOIN Departments
GROUP BY DeptName;
SELECT D.DeptName,
       SUM(E.Salary) AS TotalSalary
FROM Employees E
INNER JOIN Departments D
ON E.DeptID = D.DeptID
GROUP BY D.DeptName
HAVING SUM(E.Salary) > 100000;


