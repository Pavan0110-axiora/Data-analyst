CREATE DATABASE College;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    city VARCHAR(100)
);
 drop table Students;
 CREATE TABLE Students (
    Id INT,
    Name VARCHAR(100)
);

INSERT INTO Students (Id, Name) VALUES
(1, 'Pavan'),
(2, 'Sai'),
(3, 'Ravi');

select*from Students;

drop table students;
CREATE TABLE Students (
    id INT PRIMARY KEY,                     -- PRIMARY KEY
    name VARCHAR(100) NOT NULL,             -- NOT NULL
    city VARCHAR(100) DEFAULT 'Hyderabad',  -- DEFAULT
    email VARCHAR(150) UNIQUE,              -- UNIQUE
    age INT CHECK (age >= 18)               -- CHECK
);

INSERT INTO Students (id, name, city, email, age) VALUES
(1, 'Pavan', 'Bangalore', 'pavan@gmail.com', 22),
(2, 'Sai', 'Chennai', 'sai@gmail.com', 21),
(3, 'Ravi', NULL, 'ravi@gmail.com', 25);

select*from Students;

ALTER TABLE Students
ADD CONSTRAINT chk_age CHECK (age >= 18);

insert into students values(4,'mani','khammam','mani@gmail.com',17);


CREATE DATABASE college;
USE college;

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(60),
    marks INT NOT NULL,
    grad VARCHAR(1),
    city VARCHAR(50)
);

INSERT INTO student (roll_no, name, marks, grad, city) VALUES
(1001, 'arjun', 71, 'C', 'Vijayawada'),
(1002, 'raju', 92, 'A', 'Hyderabad'),
(1003, 'seetha', 82, 'B', 'Hyderabad'),
(1004, 'raghu', 95, 'A', 'Vizag'),
(1005, 'ramesh', 11, 'F', 'Vizag'),
(1006, 'geetha', 80, 'B', 'Vizag');

select*from student;
INSERT INTO student VALUES(1007,'kiran',92,'A','vizag'),(1008,'suresh',82,'B','Hyderabad'),(1009,'madhu',95,'A','vizag');

select roll_no,name,marks,grad,
ROW_NUMBER() over(order by marks desc) as row_num,
rank() over (order by marks desc) as rank_num,
DENSE_RANK() over (order by marks desc) as dens_rank,
NTILE(3) over(order by marks desc) as groups,
LAG(marks) over (order by marks desc) as prev_marks,
LEAD(marks) over (order by marks desc) as next_marks,
FIRST_VALUE(marks) over (order by marks desc) as first_value,
last_value(marks) over (order by marks desc rows between unbounded preceding and unbounded following ) as last_value

from student;


CREATE TABLE sales_data (
    id INT,
    category VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO sales_data VALUES
(1, 'Electronics', 500, '2024-01-01'),
(2, 'Electronics', 700, '2024-01-05'),
(3, 'Electronics', 300, '2024-01-10'),
(4, 'Clothing', 200, '2024-01-02'),
(5, 'Clothing', 400, '2024-01-06'),
(6, 'Clothing', 100, '2024-01-12');

SELECT id,category,amount,sale_date,

MIN(amount) OVER (PARTITION BY category ORDER BY sale_date) as min_amount,
MAX(amount) OVER (PARTITION BY category ORDER BY sale_date) as max_amount,
MIN(amount) OVER (PARTITION BY category) as min,
MAX(amount) OVER (PARTITION BY category)as max,

FIRST_VALUE(amount) OVER (PARTITION BY category ORDER BY sale_date) AS first_value,
LAST_VALUE(amount) OVER (PARTITION BY category ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS last_value
FROM sales_data;

SELECT * FROM student WHERE marks > 80;
SELECT * FROM student WHERE city = 'Vizag';
SELECT * FROM student WHERE grad = 'A';
SELECT * FROM student WHERE marks > 80 AND city = 'Hyderabad';
SELECT * FROM student WHERE marks > 80 OR city = 'Vizag';
SELECT * FROM student WHERE NOT grad = 'F';
SELECT * FROM student WHERE marks BETWEEN 70 AND 90;
SELECT * FROM student WHERE city IN ('Vizag', 'Hyderabad');
SELECT * FROM student WHERE name LIKE 'r%';   -- starts with r
SELECT * FROM student WHERE name LIKE '%a';   -- ends with a
SELECT * FROM student WHERE name LIKE '%e%';  -- contains e
SELECT * FROM student WHERE city IS NULL;
SELECT * FROM student WHERE city IS NOT NULL;

--- Comparison Operators
SELECT * FROM student WHERE marks = 80;
SELECT * FROM student WHERE marks != 80;
SELECT * FROM student WHERE marks > 80;
SELECT * FROM student WHERE marks < 80;
SELECT * FROM student WHERE marks >= 80;
SELECT * FROM student WHERE marks <= 80;

--- Logical Operators
SELECT * FROM student WHERE marks > 80 AND city = 'Vizag';
SELECT * FROM student WHERE marks > 90 OR grad = 'B';
SELECT * FROM student WHERE NOT city = 'Hyderabad';

--- Arithmetic Operators
SELECT name, marks, marks + 5 AS bonus_marks FROM student;
SELECT name, marks, marks * 2 AS double_marks FROM student;
SELECT name, marks, marks - 10 AS reduced_marks FROM student;
SELECT name, marks, marks / 2 AS half_marks FROM student;

-- aggreate fn 
SELECT COUNT(*) FROM student;
SELECT SUM(marks) FROM student;
SELECT AVG(marks) FROM student;
SELECT MAX(marks) FROM student;
SELECT MIN(marks) FROM student;

--- order by fn 
SELECT * FROM student ORDER BY marks DESC;
SELECT * FROM student ORDER BY name ASC;
--- group by fn 
SELECT city, COUNT(*) AS total_students
FROM student
GROUP BY city;
--- having  by fn 
SELECT city, AVG(marks) AS avg_marks
FROM student
GROUP BY city
HAVING AVG(marks) > 70;

--- Topper Student
SELECT * FROM student
WHERE marks = (SELECT MAX(marks) FROM student);

--- failed student
SELECT * FROM student WHERE grad = 'F';

--- students above avg 
SELECT * FROM student
WHERE marks > (SELECT AVG(marks) FROM student);

SELECT TOP 3 *
FROM student
ORDER BY marks DESC;

SELECT COUNT(*) AS total_students
FROM student;

SELECT TOP 3 roll_no, name, marks
FROM student
ORDER BY marks DESC;

SELECT city, AVG(marks) AS avg_marks
FROM student
GROUP BY city
ORDER BY avg_marks ASC;

CREATE TABLE student_2 (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO student_2 VALUES
(1001, 'ramu'),
(1002, 'syam'),
(1003, 'gopi');

select*from student_2;

CREATE TABLE course_2 (
    student_id INT,
    course VARCHAR(100)
);
INSERT INTO course_2 VALUES
(1002, 'english'),
(1005, 'math'),
(1003, 'science'),
(1007, 'computer science');
select*from student_2;
select*from course_2;
--- joins 
-- inner join 
SELECT 
    s.student_id,
    s.name,
    c.course
FROM student_2 s
INNER JOIN course_2 c
ON s.student_id = c.student_id;

--- left join 
SELECT 
    s.student_id,
    s.name,
    c.course
FROM student_2 s
LEFT JOIN course_2 c
ON s.student_id = c.student_id;

--- right join 
SELECT 
    s.student_id,
    s.name,
    c.course
FROM student_2 s
RIGHT JOIN course_2 c
ON s.student_id = c.student_id; 

--- full outer 
SELECT 
    s.student_id,
    s.name,
    c.course
FROM student_2 s
FULL OUTER JOIN course_2 c
ON s.student_id = c.student_id;

--- cross join 
SELECT*FROM student_2 s
CROSS JOIN course_2 c;

---self join 
SELECT 
    s1.name AS student1,
    s2.name AS student2
FROM student_2 s1
JOIN student_2 s2
ON s1.student_id <> s2.student_id;

--- time inteligence fn 
SELECT GETDATE() AS current_datetime;
SELECT CURRENT_TIMESTAMP AS current_datetime;
SELECT SYSDATETIME() AS high_precision_time;
SELECT 
    YEAR(GETDATE()) AS year,
    MONTH(GETDATE()) AS month,
    DAY(GETDATE()) AS day;

SELECT 
    DATEPART(YEAR, GETDATE()) AS year,
    DATEPART(MONTH, GETDATE()) AS month,
    DATEPART(DAY, GETDATE()) AS day;

SELECT FORMAT(GETDATE(), 'dd-MM-yyyy') AS formatted_date;
SELECT FORMAT(GETDATE(), 'MMMM') AS month_name;
SELECT FORMAT(GETDATE(), 'dddd') AS day_name;
SELECT FORMAT(GETDATE(), 'yyyy') AS year_name;

SELECT DATEADD(DAY, 5, GETDATE()) AS add_days;
SELECT DATEADD(MONTH, -2, GETDATE()) AS subtract_months;
SELECT DATEADD(YEAR, 1, GETDATE()) AS next_year;

SELECT DATEDIFF(DAY, '2024-01-01', GETDATE()) AS days_diff;
SELECT DATEDIFF(MONTH, '2024-01-01', GETDATE()) AS months_diff;
SELECT DATEDIFF(YEAR, '2020-01-01', GETDATE()) AS years_diff;

SELECT EOMONTH(GETDATE()) AS end_of_month;

---- views 
select*from Sales.SalesOrderHeader
select*from Sales.SalesOrderDetail
select*from Production.Product
select*from Production.ProductSubcategory
select*from Production.ProductCategory
select*from Sales.Customer
select*from Person.Person                    
select*from Sales.SalesPerson
select*from HumanResources.Employee
select*from Person.Address
select*from Person.StateProvince
select*from Person.CountryRegion


CREATE VIEW vw_Salesdashboard
AS

SELECT
    soh.SalesOrderID,
    soh.OrderDate,
    soh.DueDate,
    c.CustomerID,
    pp.FirstName + ' ' + pp.LastName AS CustomerName,
    p.ProductID,
    p.Name AS ProductName,
    pc.Name AS ProductCategory,
    a.City,
    spv.Name AS StateProvince,
    cr.Name AS CountryRegion,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal,
    sp.BusinessEntityID AS SalesPersonID,
    empPerson.FirstName + ' ' + empPerson.LastName AS SalesPersonName,
    YEAR(soh.OrderDate) AS [Year],
    DATENAME(MONTH, soh.OrderDate) AS MonthName,
    DATEPART(QUARTER, soh.OrderDate) AS Quarter

FROM Sales.SalesOrderHeader soh

INNER JOIN Sales.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID

INNER JOIN Production.Product p
    ON sod.ProductID = p.ProductID

LEFT JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID

LEFT JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID

LEFT JOIN Sales.Customer c
    ON soh.CustomerID = c.CustomerID

LEFT JOIN Person.Person pp
    ON c.PersonID = pp.BusinessEntityID

LEFT JOIN Person.Address a
    ON soh.BillToAddressID = a.AddressID

LEFT JOIN Person.StateProvince spv
    ON a.StateProvinceID = spv.StateProvinceID

LEFT JOIN Person.CountryRegion cr
    ON spv.CountryRegionCode = cr.CountryRegionCode

LEFT JOIN Sales.SalesPerson sp
    ON soh.SalesPersonID = sp.BusinessEntityID

LEFT JOIN HumanResources.Employee e
    ON sp.BusinessEntityID = e.BusinessEntityID

LEFT JOIN Person.Person empPerson
    ON e.BusinessEntityID = empPerson.BusinessEntityID;
GO
select*from vw_Salesdashboard;
select sum(linetotal) as total_sales from vw_Salesdashboard;
select sum(UnitPrice) as total_unitprice from vw_Salesdashboard;
select 
sum(linetotal) as total_sales,
sum(UnitPrice) as total_unitprice,
sum(orderqty) as total_units_sold,
count(distinct SalesOrderId) as total_orders,
count(distinct(CustomerID)) as count_of_customers,
Round(sum(linetotal)/count(distinct SalesOrderID),2) AS average_order_value from vw_Salesdashboard

where   Quarter = '2'
and ProductCategory = 'Clothing'
and CountryRegion = 'Canada'
and SalesPersonName ='Jae pak';

--- triggers

CREATE TABLE Emp(
    emp_id INT,
    emp_name VARCHAR(20)
);

CREATE TABLE Emp_Audit (
    emp_id INT,
    action_type VARCHAR(20),
    action_date DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_emp_insert
ON Emp
AFTER INSERT
AS
BEGIN
    INSERT INTO Emp_Audit (emp_id, action_type, action_date)
    SELECT emp_id, 'INSERT', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER trg_emp_update
ON Emp
AFTER UPDATE
AS
BEGIN
    INSERT INTO Emp_Audit (emp_id, action_type, action_date)
    SELECT emp_id, 'UPDATE', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER trg_emp_delete
ON Emp
AFTER DELETE
AS
BEGIN
    INSERT INTO Emp_Audit (emp_id, action_type, action_date)
    SELECT emp_id, 'DELETE', GETDATE()
    FROM deleted;
END;

select*from emp;
INSERT INTO Emp VALUES (1, 'Ravi');

UPDATE Emp
SET emp_name = 'Kiran'
WHERE emp_id = 1;

DELETE FROM Emp
WHERE emp_id = 1;

SELECT * FROM Emp_Audit;

-- strored procedure

CREATE PROCEDURE sp_SalesSummary
    @Quarter INT,
    @Country VARCHAR(50)
AS
BEGIN

    SELECT
        SUM(LineTotal) AS total_sales,
        SUM(OrderQty) AS total_quantity,
        COUNT(DISTINCT SalesOrderID) AS total_orders,
        COUNT(DISTINCT CustomerID) AS total_customers,
        ROUND(
            SUM(LineTotal) /
            COUNT(DISTINCT SalesOrderID),
        2) AS avg_order_value

    FROM vw_Salesdashboard

    WHERE Quarter = @Quarter
    AND CountryRegion = @Country;

END;

EXEC sp_SalesSummary 2, 'Canada';

---- Stored Procedures
--- Simple Stored Procedure
CREATE PROCEDURE sp_GetStudents
AS
BEGIN
    SELECT * FROM student;
END;

EXEC sp_GetStudents;

---- Stored Procedure with Parameter
CREATE PROCEDURE sp_GetStudentByCity
    @city VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM student
    WHERE city = @city;
END;

EXEC sp_GetStudentByCity 'Vizag';

--- Stored Procedure for Top Students
CREATE PROCEDURE sp_TopStudents
    @top_count INT
AS
BEGIN
    SELECT TOP (@top_count)
        roll_no,
        name,
        marks
    FROM student
    ORDER BY marks DESC;
END;

EXEC sp_TopStudents 3;

--- Stored Procedure with Aggregate Functions
CREATE PROCEDURE sp_StudentSummary
AS
BEGIN
    SELECT
        COUNT(*) AS total_students,
        AVG(marks) AS average_marks,
        MAX(marks) AS highest_marks,
        MIN(marks) AS lowest_marks
    FROM student;
END;

EXEC sp_StudentSummary;

--- Stored Procedure with INSERT
CREATE PROCEDURE sp_InsertStudent
    @roll_no INT,
    @name VARCHAR(60),
    @marks INT,
    @grad VARCHAR(1),
    @city VARCHAR(50)
AS
BEGIN
    INSERT INTO student
    VALUES(@roll_no, @name, @marks, @grad, @city);
END;

EXEC sp_InsertStudent 1010, 'Rahul', 88, 'A', 'Hyderabad';

--- Stored Procedure with UPDATE
CREATE PROCEDURE sp_UpdateMarks
    @roll_no INT,
    @marks INT
AS
BEGIN
    UPDATE student
    SET marks = @marks
    WHERE roll_no = @roll_no;
END;

EXEC sp_UpdateMarks 1001, 90;
