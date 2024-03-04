
--NAME:Anwesha Dutta

--1.Write a query using Inline View. 
-----------------------------------------------------------------------------

  USE BikeStores


CREATE TABLE [HR].[University] (
    [id] INT PRIMARY KEY,
    [name] VARCHAR(40) NOT NULL,
    [country] VARCHAR(20) NOT NULL,
    [rating] FLOAT
);


INSERT INTO [HR].[University] ([id],[name], [country], [rating]) VALUES
    (1,'Harvard University', 'USA', 4.8),
    (2,'University of Oxford', 'UK', 4.7),
    (3,'ETH Zurich', 'Switzerland', 4.5),
    (4,'National University of Singapore', 'Singapore', 4.6),
    (5,'Tokyo University', 'Japan', 4.4),
    (6,'MIT', 'USA', 4.9),
    (7,'Imperial College London', 'UK', 4.6),
    (8,'EPFL', 'Switzerland', 4.4),
    (9,'Nanyang Technological University', 'Singapore', 4.5),
    (10,'University of Tokyo', 'Japan', 4.3);

	SELECT * FROM [HR].[university]


	SELECT name FROM  
	(SELECT *  FROM [HR].[University] WHERE country = 'UK') AS University_Name


--2.Print the following pattern in SQL Server                                                                                       2
--*
--**
--***
--****
--*****
----------------------------------------------------------------------------

DECLARE @i INT =1WHILE @i<6BEGINPRINT REPLICATE('*',@i)SET @i =@i+1END
 

--3.Write a SQL Query to find the first Week Day of the month?   
--------------------------------------------------------------------------

SELECT DATENAME(weekday, getdate() ) AS DATE
SELECT DATENAME(weekday, '2024-02-05') AS DATE


--	4.How to find the 6th highest salary from the Employee table?  
------------------------------------------------------------------------------

USE BikeStores


CREATE TABLE [HR].[EmployeeDetails] (
    [emp_id] INT PRIMARY KEY,
    [emp_name] VARCHAR(30),
    [city] VARCHAR(40),
    [salary] DECIMAL(10, 2)
);

INSERT INTO [HR].[EmployeeDetails] ([emp_id], [emp_name], [city], [salary])
VALUES
    (1, 'John Doe', 'New York', 60000.00),
    (2, 'Jane Smith', 'Los Angeles', 70000.50),
    (3, 'Bob Johnson', 'Chicago', 55000.75),
    (4, 'Alice Williams', 'San Francisco', 80000.25),
    (5, 'Eva Martinez', 'Miami', 65000.00),
    (6, 'Michael Brown', 'Houston', 72000.75),
    (7, 'Sophia Garcia', 'Dallas', 58000.50),
    (8, 'William Davis', 'Atlanta', 67000.25),
    (9, 'Olivia Wilson', 'Seattle', 75000.00),
    (10, 'James Rodriguez', 'Denver', 68000.75),
    (11, 'Emily Thomas', 'Phoenix', 63000.50),
    (12, 'Daniel Lee', 'Boston', 71000.25);

	SELECT * FROM  [HR].[EmployeeDetails]

	WITH RankedSalaries AS (
    SELECT 
        emp_id, 
        emp_name, 
        city, 
        salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS SalaryRank
    FROM [HR].[EmployeeDetails]
)
SELECT 
    emp_id, 
    emp_name, 
    city, 
    salary

FROM RankedSalaries
WHERE SalaryRank = 6;


--5.Write a query by using ANY & ALL operator?  
------------------------------------------------------------------------

USE BikeStores

--USING ANY OPERATOR--
  SELECT product_name,list_price
  FROM [production].[products]
  WHERE list_price >= ANY(SELECT MAX(list_price) FROM production.products GROUP BY brand_id)
  ORDER BY list_price

 --USING ALL OPERATOR
 SELECT product_name,list_price
 FROM [production].[products]
 WHERE list_price >= ALL(SELECT AVG(list_price) FROM production.products GROUP BY brand_id)
 ORDER BY list_price


 --6.Assign a rank to each movie based on the ordering of their release dates. 
 -----------------------------------------------------------------------------------------
 USE BikeStores

 CREATE TABLE [HR].[ReleasedMovie] (
    [Movie_id] INT PRIMARY KEY,
    [Movie_Name] VARCHAR(50),
    [Released_Date] DATE
);

INSERT INTO  [HR].[ReleasedMovie] ([Movie_id], [Movie_Name], [Released_Date])
VALUES
    (1, 'The Great Adventure', '2023-01-15'),
    (2, 'Mystic Dreams', '2023-02-28'),
    (3, 'Eternal Sunshine', '2023-03-10'),
    (4, 'Midnight Serenade', '2023-04-05'),
    (5, 'Whispers in the Wind', '2023-05-20'),
    (6, 'Enchanted Forest', '2023-06-08'),
    (7, 'Lost Horizon', '2023-07-15'),
    (8, 'Sunset Serenade', '2023-08-02'),
    (9, 'Echoes of Eternity', '2023-09-18'),
    (10, 'Dreams Unfold', '2023-10-12');

	SELECT * FROM [HR].[ReleasedMovie] 

--With ROW_NUMBER()
	SELECT 
	Movie_Name,
	Released_Date,
	ROW_NUMBER() OVER (ORDER BY Released_Date ASC) AS Ranking
	FROM [HR].[ReleasedMovie] 
	
--With DENSE_RANK()
	SELECT 
	Movie_Name,
	Released_Date,
	DENSE_RANK() OVER (ORDER BY Released_Date ASC) AS Ranking
	FROM [HR].[ReleasedMovie] 


--7.Display the count of movies for each genre in a pivoted format. 
------------------------------------------------------------------------------------------
 USE BikeStores
	
	CREATE TABLE [HR].[MovieGenre](
		[Movie_id] INT PRIMARY KEY,
		[Movie_Name] VARCHAR(50),
		[Genre] VARCHAR(50)
    );

	INSERT INTO [HR].[MovieGenre] ([Movie_id], [Movie_Name], [Genre])
   VALUES
    (1, 'Action Movie 1', 'Action'),
    (2, 'Drama Movie 1', 'Drama'),
    (3, 'Action Movie 2', 'Action'),
    (4, 'Comedy Movie 1', 'Comedy'),
    (5, 'Drama Movie 2', 'Drama'),
    (6, 'Comedy Movie 2', 'Comedy'),
    (7, 'Action Movie 3', 'Action'),
    (8, 'Comedy Movie 3', 'Comedy'),
    (9, 'Drama Movie 3', 'Drama'),
    (10, 'Action Movie 4', 'Action');

	SELECT * FROM [HR].[MovieGenre]

	SELECT 
   [Action], [Drama], [Comedy]
	FROM 
	(
	SELECT 
	--Movie_name, 
	[Genre]
	FROM [HR].[MovieGenre]
	) AS PivotData

	Pivot
	(
	COUNT(Genre) FOR Genre
	IN([Action],[Drama],[Comedy])
	) AS PivotTable


	
--8.Display students who have enrolled in more than one course
------------------------------------------------------------------------------

	USE BikeStores


  CREATE TABLE [HR].[Students_Details] (
    [student_id] INT PRIMARY KEY,
    [student_name] VARCHAR(255)
);



INSERT INTO [HR].[Students_Details] ([student_id], [student_name])
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Bob Johnson'),
    (4, 'Alice Williams'),
    (5, 'Eva Martinez'),
    (6, 'Michael Brown');

	SELECT * FROM [HR].[Students_Details]
	


	CREATE TABLE [HR].[Course_Details] (
		[course_id] INT PRIMARY KEY,
		[course_name] VARCHAR(40),

);

INSERT INTO [HR].[Course_Details] ([course_id], [course_name])
VALUES
    (1, 'Mathematics 101'),
    (2, 'History 101'),
    (3, 'Science 101'),
    (4, 'English 101'),
    (5, 'Programming Basics'),
    (6, 'Art Appreciation'),
    (7, 'Physics Fundamentals'),
    (8, 'Literature Exploration'),
    (9, 'Database Design'),
    (10, 'Mathematics 102');

	SELECT * FROM [HR].[Course_Details]



CREATE TABLE [HR].[Enrollment] (
    [enrollment_id] INT PRIMARY KEY,
    [student_id] INT,
    [course_id] INT,
    FOREIGN KEY (student_id) REFERENCES [HR].[Students_Details]([student_id]),
    FOREIGN KEY (course_id) REFERENCES [HR].[Course_Details]([course_id])
);


INSERT INTO [HR].[Enrollment] ([enrollment_id], [student_id], [course_id])
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1),
    (4, 3, 3),
    (5, 3, 2),
    (6, 4, 1),
    (7, 4, 2),
    (8, 4, 3),
    (9, 5, 1),
    (10, 5, 3);

	SELECT * FROM [HR].[Enrollment] 

SELECT s.student_name, s.student_id, COUNT(DISTINCT c.course_id) as enrolled_courses
FROM [HR].[Course_Details]AS c
JOIN [HR].[Enrollment] AS e
ON e.course_id= c.course_id
JOIN  [HR].[Students_Details] AS s
ON e.student_id = s.student_id
GROUP BY s.student_id,s.student_name
HAVING COUNT(DISTINCT c.course_id) > 1;


--9.Retrieve information about each book along with its author, publisher, and genre details. 
--Using Apply Operator
------------------------------------------------------------------------------------------------------

	
	USE BikeStores


CREATE TABLE [HR].[Author] (
    [author_id] INT PRIMARY KEY,
    [author_name] VARCHAR(255)
);


INSERT INTO [HR].[Author] ([author_id], [author_name])
VALUES
    (1, 'Sharatchandra Chattopadhyay'),
    (2, 'Rabindranath Tagore'),
    (3, 'Bibhutibhushan Bandopadhyay'),
    (4, 'Kazi Nazrul Islam'),
    (5, 'Sukumar Ray'),
    (6, 'Manojder Adbhut Bari'),
    (7, 'Sharadindu Bandyopadhyay'),
    (8, 'Humayun Ahmed');

	
CREATE TABLE [HR].[Books] (
    [book_id] INT PRIMARY KEY,
    [book_name] VARCHAR(50),
    [genre] VARCHAR(50),
    [publisher] VARCHAR(30),
    [author_id] INT
    FOREIGN KEY (author_id) REFERENCES [HR].[Author]([author_id])
);


INSERT INTO [HR].[Books] ([book_id], [book_name], [genre], [publisher], [author_id])
VALUES
    (1, 'Mahabharat', 'Epic', 'Pustok Kuthir', 1),
    (2, 'Shesher Kobi', 'Poetry', 'Bosudeb Sahitya Kendra', 2),
    (3, 'Prachin Samskritir Itihas', 'History', 'Granthagar Prokash', 3),
    (4, 'Shokuntala', 'Drama', 'Anannya Prokashon', 4),
    (5, 'Megher Opare', 'Novel', 'Somoy Prokashon', 5),
    (6, 'Durgasangram', 'Poetry', 'Bishwoshahityo Kendro', 6),
    (7, 'Hunkar', 'Science Poetry', 'Upanibesh Prokashon', 5),
    (8, 'Sangsar Simante', 'Novel', 'Somoy Prokashon', 8);

	SELECT * FROM [HR].[Books]

ALTER FUNCTION fn_GetBooksByAuthorId(@author_id INT)
RETURNS TABLE
AS
RETURN
(
	SELECT[book_name],[genre],[publisher]
	FROM [HR].[Books]
	WHERE author_id = @author_id
)

SELECT book_name, author_name, publisher,genre
FROM [HR].[Author] AS a
CROSS APPLY  fn_GetBooksByAuthorId(a.author_id)
ORDER BY author_name


--10.Find employees whose salaries are higher than the average salary of employees
--in departments with at least 5 employees, with specific job titles.     
-------------------------------------------------------------------------------------------------

USE HRDB

SELECT * FROM [dbo].[employees]
SELECT * FROM [dbo].[jobs]

SELECT e.employee_id ,e.first_name, salary 
FROM [dbo].[employees] AS e
JOIN [dbo].[jobs] AS j
ON e.job_id = j.job_id
WHERE salary > 
(SELECT AVG(salary) FROM [dbo].[employees]
    WHERE job_id IN (SELECT job_id FROM [dbo].[employees] 
 GROUP BY job_id 
 HAVING COUNT(*)>=5
))
 AND job_title = 'Programmer'



