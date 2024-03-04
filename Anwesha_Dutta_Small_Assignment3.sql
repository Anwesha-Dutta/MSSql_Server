
--NAME:ANWESHA DUTTA--

 --Q1: Write a to display organization hierarchy
  USE BikeStores
	CREATE TABLE [HR].[emp]
	(
		[emp_id] INT CONSTRAINT [empnew_pk] PRIMARY KEY IDENTITY(1,1),
		[emp_name] VARCHAR(20) NOT NULL,
		[manager_id] INT NOT NULL,
	);

	INSERT INTO [HR].[emp] ([emp_name],[manager_id])
	VALUES('Anwesha',2),
	     ('Susmita',3),
		  ('Bandita',1),
		  ('Sujata',2),
		  ('Manisha',4);

	SELECT * FROM [HR].[emp]

	--Showing the manager's name of each employees--

	SELECT t1.[emp_name]  AS 'Employee_Name',t2.[emp_name] AS 'Manager_Name'
	FROM [HR].[emp] AS t1
	JOIN [HR].[emp] AS t2
	ON t2.[emp_id] = t1.[manager_id] 


--Q2: Write a query to display count of orders placed by each customer.

USE BikeStores
 CREATE TABLE [HR].[customer]
 (
 [cust_id] INT PRIMARY KEY,
 [cust_name] VARCHAR(20),
 [city] VARCHAR(20)
 );

 INSERT INTO [HR].[customer]([cust_id],[cust_name],[city])
 VALUES(1,'Anwesha','Bankura'),
       (2,'Sudipto','Durgapur'),
       (3,'Lalit','Bishnupur'),
       (4,'Chadni','Kolkata'),
       (5,'Bandita','Bankura');

	  SELECT * FROM [HR].[customer]

CREATE TABLE [HR].[order]
 (
 [order_id] INT PRIMARY KEY,
 [order_name] VARCHAR(20),
 [cust_id] INT FOREIGN KEY 
 REFERENCES [HR].[customer]([cust_id])
 );
 
 INSERT INTO [HR].[order] ([order_id],[order_name],[cust_id])
 VALUES(1,'Shampoo',2),
        (2,'Dress',3),
		(3,'FaceWash',5),
		(4,'Food',1),
		(5,'Hairoil',4);


		SELECT  cust_name, order_name,COUNT(order_id) AS Total_Order_Number
		FROM [HR].[customer] as c
		JOIN [HR].[order] as o
		ON c.cust_id = o.cust_id
		GROUP BY cust_name, order_name
		

--Q3: Write a query to apply union, union all, intersect and except operator.

 USE BikeStores
CREATE TABLE [HR].[NewStudentone]
(
 [Student_id] INT ,
 [Student_name] VARCHAR(30),
 [Age] INT
 );
 
 INSERT INTO [HR].[NewStudentone]([Student_id],[Student_name],[Age])
 VALUES(1,'Anwesha',24),
       (2,'Pushpa',24),
	   (3,'Anindita',24),
	   (4,'Chandana',25),
	   (5,'Lalita',26);

CREATE TABLE [HR].[NewStudenttwo]
(
 [Student_id] INT ,
 [Student_name] VARCHAR(30),
 [Age] INT
 );
 
 INSERT INTO [HR].[NewStudenttwo]([Student_id],[Student_name],[Age])
 VALUES(1,'Anwesha',24),
       (2,'Durgadas',62),
	   (3,'Biswajit',62);
	 
	 --UNION--
	 SELECT * FROM [HR].[NewStudentone]
	 UNION
	 SELECT * FROM [HR].[NewStudenttwo]

	 --UNION ALL--

	 SELECT * FROM [HR].[NewStudentone]
	 UNION ALL
	 SELECT * FROM [HR].[NewStudenttwo]

	 --INTERSECT--

	 SELECT * FROM [HR].[NewStudentone]
	 INTERSECT
	 SELECT * FROM [HR].[NewStudenttwo]

	 --EXCEPT OPERATOR--
	 SELECT * FROM [HR].[NewStudentone]
	   EXCEPT
	 SELECT * FROM [HR].[NewStudenttwo]




 --Q4: Write a query using cross & outer apply operator.
 USE BikeStores	
Create Table [HR].[Department]
(
[Id] int primary key,
[DName] varchar(50)
)Insert into [HR].[Department] values (1, 'IT')
Insert into [HR].[Department] values (2, 'HR')
Insert into [HR].[Department] values (3, 'Payroll')
Insert into [HR].[Department] values (4, 'Exam')
Insert into [HR].[Department] values (5, 'Paint')SELECT * FROM [HR].[Department]CREATE TABLE [HR].[Employee]([Id] int primary key,
[Name] nvarchar(50),
[Gender] nvarchar(10),
[Salary] int,
[dept_Id] int foreign key references [HR]. [Department](Id)
)

Insert into [HR].[Employee] values (1, 'Manish', 'Male', 50000, 1)
Insert into [HR].[Employee] values (2, 'Mandira', 'Female', 60000, 3)
Insert into [HR].[Employee] values (3, 'Sudipto', 'Male', 45000, 2)
Insert into [HR].[Employee] values (4, 'John', 'Male', 56000, 1)
Insert into [HR].[Employee] values (5, 'Sara', 'Female', 39000, 2)

SELECT * FROM [HR].[Employee]

CREATE FUNCTION fn_GetEmployeeByDepartmentId(@dept_Id int)
Returns Table 
as 
Return 
(
Select Id, Name, Gender, Salary ,dept_Id
FROM [HR].[Employee] WHERE dept_Id = @dept_Id
)

SELECT * FROM fn_GetEmployeesByDepartmentId(1)


--Cross Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
cross apply fn_GetEmployeesByDepartmentId(D.Id) AS E

--Outer Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
outer apply fn_GetEmployeesByDepartmentId(D.Id) AS E






	