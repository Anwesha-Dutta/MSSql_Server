
--HANDS-ON ON 22/02/2024
--BASED ON STUDENT_MANAGEMENT_STYSTEM
--CREATE 6 TABLE
--STUDENT TABLE, COURSE, ENROLLMENT, INSTRUCTOR(TEACHER), GRADE , DEPARTMENT
--====================================================================================-
CREATE DATABASE SQL_PRACICE_DB
use  SQL_PRACICE_DB


CREATE TABLE [Teacher] (
    Teacher_id INT PRIMARY KEY,
    Teacher_name VARCHAR(100),
	Course_id INT 
);

INSERT INTO Teacher (Teacher_id, Teacher_name,Course_id) VALUES
(1, 'Annapurna Dutta',1),
(2, 'Shyamal Dutta',2),
(3, 'Krishna Dutta',3),
(4,'Dayamay Rana',4),
(5, 'Hossein Midya',5),
(6, 'Angsuman Mandal',6);

SELECT * FROM [Teacher]

CREATE TABLE [Course] (
    [Course_id] INT CONSTRAINT[Course_pk] PRIMARY KEY,
    Course_name VARCHAR(100)
);

INSERT INTO [Course] ([Course_id], [Course_name]) VALUES
(1, 'Mathematics'),
(2, 'Physics '),
(3, 'Chemistry'),
(4, 'Geography'),
(5,'History'),
(6, 'Political Science');

SELECT *FROM [Course]


CREATE TABLE [Grade] (
    [grade_id] INT PRIMARY KEY,
    [grade_name] VARCHAR(50)
);


INSERT INTO Grade ([grade_id], [grade_name]) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'F');

SELECT * FROM [Grade]


CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    Department_name VARCHAR(50)
);

INSERT INTO Department (Department_id, Department_name) VALUES
(1, 'Science'),
(2, 'Arts');

SELECT * FROM Department


CREATE TABLE [Student] (
    [Student_id] INT PRIMARY KEY,
    [Student_name] VARCHAR(100),
    [Department_id] INT FOREIGN KEY
	REFERENCES [Department]([Department_id])
);

INSERT INTO Student (Student_id, Student_name,Department_id) VALUES
(1, 'Anwesha',1),
(2, 'Sudipto',2),
(3, 'Minakshi',1),
(4, 'Chayanika',2);

SELECT * FROM [Student]


CREATE TABLE Enrollment (
    Student_id INT,
    Course_id INT,
    department_id INT,
    Teacher_id INT,
    PRIMARY KEY (Student_id, Course_id),
    FOREIGN KEY (Student_id) REFERENCES Student(Student_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Teacher_id) REFERENCES Teacher(Teacher_id)
);

INSERT INTO Enrollment (Student_id, Course_id, department_id, Teacher_id) VALUES
(1, 1, 1, 1), 
(1, 2, 1, 2),  
(1, 3, 1, 3),  
(2, 1, 1, 1),  
(2, 3, 1, 3),
(3, 4, 2, 4),
(3, 5, 2, 5),
(4, 5, 2, 5),
(5, 6, 2, 6);

SELECT * FROM [Enrollment]


SELECT s.Student_id, Student_name,Department_name, c.Course_name ,Teacher_name
FROM [Student] AS s
 JOIN [Enrollment] AS e
 ON e.student_id = e.student_id 
 JOIN [Course] as c
  ON c.Course_id = e.Course_id
  JOIN [Department] as d
  ON d.department_id = e.department_id
  JOIN [Teacher] AS t
  ON t.teacher_id =e.teacher_id


--==========================================================================================================
--MERGE TABLE STATEMENT WHERE ALL INSERT ,UPDATE, DELETE WILL BE PERFORMED
----===============================================================================

CREATE TABLE Source (
    target_id INT PRIMARY KEY,
    target_name VARCHAR(100)
);

INSERT INTO Source (target_id, target_name) VALUES
(1, 'Internet'),
(2, 'Library'),
(3, 'Class Notes'),
(4, 'Online Databases'),
(5, 'Research Papers');

CREATE TABLE Target (
    Target_id INT PRIMARY KEY,
    Target_name VARCHAR(100)
);

INSERT INTO Target (Target_id, Target_name) VALUES
(1, 'Increase sales by 10% in Q1'),
(2, 'Launch new product line by end of the year'),
(3, 'Expand market presence to new regions'),
(6, 'Improve customer satisfaction ratings'),
(7, 'Reduce operational costs by optimizing processes');

SELECT * FROM [Source] 
select * from [Target]

MERGE INTO [Target] AS t
USING [Source] AS st
ON t.Target_id = st.Target_id
WHEN MATCHED THEN
    UPDATE SET t.Target_name = st.Target_name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (Target_id, Target_name)
    VALUES (st.Target_id, st.Target_name)
WHEN NOT MATCHED BY Source THEN
DELETE;

---========================================================================================================
---MERGE STATEMENT--
--=========================================================================================================
	CREATE TABLE Employees (
		EmployeeID INT PRIMARY KEY,
		firstname VARCHAR(50),
		lastname VARCHAR(50),
		Email VARCHAR(100),
		DepartmentId INT,
    )


INSERT INTO Employees (EmployeeID, firstname, lastname, Email, DepartmentId) VALUES
(1, 'Anwesha', 'Dutta', 'anweshadutta891@example.com', 1),
(2, 'Shyamal', 'Dutta', 'shyamaldutta@example.com', 2),
(3, 'Krishna', 'Dutta', 'duttakrishna@example.com', 1),
(4, 'Emily', 'Williams', 'emily.williams@example.com', 2),
(5, 'Riya', 'Mandi', 'mandiriya@example.com', 2);


CREATE TABLE New_Employee (
		EmployeeID INT PRIMARY KEY,
		firstname VARCHAR(50),
		lastname VARCHAR(50),
		Email VARCHAR(100),
		DepartmentId INT,
    )

INSERT INTO New_Employee (EmployeeID, firstname, lastname, Email, DepartmentId) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 2),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 1),
(6, 'Subhajit', 'Rana', 'ranasubhajit@example.com', 2),
(7,'Kalyan','Jana', 'janakalyan@gmail.com',3);

Merge into New_Employee as t
 using Employees as s
 on t.EmployeeId = s.EmployeeId
 WHEN MATCHED THEN
 UPDATE SET t.firstname = s.firstname,
            t.lastname = s.lastname,
			t.email = s.email,
			t.DepartmentId = s.DepartmentId
WHEN NOT MATCHED BY TARGET THEN
INSERT(EmployeeID,firstname, lastname, email, DepartmentId ) 
VALUES(s.EmployeeID, s.firstname, s.lastname, s.email, s.DepartmentId) 
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
          

select * from Employees 
select * from New_Employee

--========================================================================================================

--BULK INSERT--
--=======================================================================================================
		  create table [Students] 
		  ( 
		    [id] int primary key,
			[name] varchar(70),
			[marks] int 
		  )

		  bulk insert [Students] 
		  from 'D:\Anwesha Dutta\practicebulk_Insert.csv'
		  with 
		  (
		    FieldTerminator =',',
			RowTerminator ='\n',
			firstrow = 2
			)

			SELECT * FROM  [Students] 


--- FOR IDENTITY COLUMN--

create table [Student_Identity] 
   (
    [Id]  int constraint[Student_pk] primary key identity(1,1),
	[name] varchar(80)
	);

	set identity_insert [Student_Identity] on
	insert into [Student_Identity]([Id],[name]) VALUES (1, 'Anwesha'),(2,'Shyamal'),(3,'Krishna');

	select * from [Student_Identity]

	--WE CAN DO BULK INSERT USING IDENTITY COLUMN BY USING OPTION SET IDENTITY_INSERT ON


	--QUESTIONS USING CTE--
	--===================================
	--ASSIGN THE ROLL NUMBER TO EACH SALES ORDER BASED ON  ORDER_DATE AND CUSTOMER_ID USING CTE AND ROWNUMBER
--============================================================================================================
--order_id, item_id, quantity,order_date(select list column)
--============================================================================================================

Use [BikeStores]
select * from sales.orders
select * from sales.order_items 

WITH sales_details_cte AS 
(
   select  customer_id, o.order_id, item_id, quantity, order_date,
   ROW_NUMBER() OVER (PARTITION BY  customer_id  ORDER BY order_date)  'row_Num'
   from [sales].[orders] AS o
   join [sales].[order_items] AS i
   on o.order_id = i.order_id
)

SELECT * FROM sales_details_cte
WHERE row_Num > 10

--=============================================================================================================
--Write a query using Apply operator using Cross Apply and Outer Apply 
--=============================================================================================================

Create Table [HR].[New_Department]
(
[Id] int primary key,
[DName] varchar(50)
)


Insert into [HR].[New_Department] values (1, 'IT')
Insert into [HR].[New_Department] values (2, 'HR')
Insert into [HR].[New_Department] values (3, 'Payroll')
Insert into [HR].[New_Department] values (4, 'Exam')
Insert into [HR].[New_Department] values (5, 'Paint')

SELECT * FROM [HR].[New_Department]

CREATE TABLE [HR].[New_Employees_details]
(
	[Id] int primary key,
	[Name] nvarchar(50),
	[Gender] nvarchar(10),
	[Salary] int,
	[dept_Id] int foreign key references [HR]. [New_Department](Id)
)

Insert into [HR].[New_Employees_details] values (1, 'Manish', 'Male', 50000, 1)
Insert into [HR].[New_Employees_details] values (2, 'Mandira', 'Female', 60000, 3)
Insert into [HR].[New_Employees_details] values (3, 'Sudipto', 'Male', 45000, 2)
Insert into [HR].[New_Employees_details] values (4, 'John', 'Male', 56000, 1)
Insert into [HR].[New_Employees_details] values (5, 'Sara', 'Female', 39000, 2)

SELECT * FROM [HR].[New_Employees_details]

CREATE FUNCTION fn_GetEmployeeDetailsByDepartmentId(@dept_Id int)
Returns Table 
as 
Return 
(
	Select Id, Name, Gender, Salary ,dept_Id
	FROM [HR].[Employee]
	WHERE dept_Id = @dept_Id
)

SELECT * FROM fn_GetEmployeeDetailsByDepartmentId(1)

--Outer Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
outer apply fn_GetEmployeesByDepartmentId(D.Id) AS E

--cross Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
cross apply fn_GetEmployeesByDepartmentId(D.Id) AS E

--INNER JOIN 
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
inner join fn_GetEmployeesByDepartmentId(1) AS E
ON D.Id = E.dept_id


--LEFT OUTER JOIN 
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
left join fn_GetEmployeesByDepartmentId(1) AS E
ON D.Id = E.dept_id

--Find 6 th highest salary from a table--
--=========================================
USE HRDB
SELECT * FROM dbo.employees


SELECT Salary
FROM (
    SELECT  Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS salary_rank
    FROM dbo.employees
) AS ranked_salaries
WHERE salary_rank = 6

-- Same query using WITH CTE--
--===============================================================================

with find_6th_highest_salary_cte
as 
( 
  select salary , dense_rank() over( order by salary desc) as salary_rank
  from dbo.employees
 )
 select salary from find_6th_highest_salary_cte 
 where salary_rank =6


 ---Write a query using subquery enrolled students who have enrolled in more than one courses
 ---==========================================================================================

 CREATE TABLE [Students] (
    [student_id] INT PRIMARY KEY,
    [student_name] VARCHAR(100)
);

INSERT INTO [Students] ([student_id], [student_name]) VALUES
(1, 'Anwesha'),
(2, 'Monalisa'),
(3, 'Arnab'),
(4, 'Dhruv'),
(5, 'Sibasish');

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

INSERT INTO Course (course_id, course_name) VALUES
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Chemistry'),
(4, 'Biology'),
(5, 'English');


CREATE TABLE Enrollment (
    Enrollment_id INT PRIMARY KEY,
    Student_id INT,
    Course_id INT,
    FOREIGN KEY (Student_id) REFERENCES Students(Student_id),
    FOREIGN KEY (Course_id) REFERENCES Course(course_id)
);

INSERT INTO Enrollment (Enrollment_id, Student_id, Course_id) VALUES
(1, 1, 1),  -- Student 1 enrolled in Mathematics
(2, 1, 3),  -- Student 1 enrolled in Chemistry
(3, 2, 2),  -- Student 2 enrolled in Physics
(4, 3, 5),  -- Student 3 enrolled in English
(5, 1, 2);  -- Student 1 enrolled in Physics as well

Select Student_id, Count(Course_id) AS number_of_course
FROM Enrollment  
GROUP BY Student_id
HAVING Count(*) >1

--================================================================
--Using Inline View
----------------------------------------------------------------
SELECT Student_id
FROM (
    SELECT Student_id, COUNT(Course_id) AS num_courses
    FROM Enrollment
    GROUP BY Student_id
) AS enrolled_courses
WHERE num_courses > 1;
--====================================================================
SELECT Student_id ,Student_name
FROM ( 
     select s.student_id, s.student_name, Count(c.course_id) as num_courses
	 from [Enrollment] as e
	 JOIN  [Students] as s
	 on e.student_id = s.student_id
	 JOIN [Course] as c
	 on e.course_id = c.course_id
	 Group by s.student_id,s.student_name
	 ) as enrolled_courses
	 where num_courses>1
--======================================================================
--------------------------------------------------------------------
--Using Inline Subquery--
---====================================================================
USE HRDB

select s.student_id,student_name
from students as s
join enrollment as e
on s.student_id=e.student_id
join course as c
on c.course_id=e.course_id
where s.student_id in
(select s.student_id
from students as s
join enrollment as e
on s.student_id=e.student_id
join course as c
on c.course_id=e.course_id
group by s.student_id,s.student_name
having count(*)>1)

--============================================================================================================
USE [HRDB]
--same subquery but also find the number_of_course
--===================================================
select s.student_id,student_name,count(*) from Students as s
join Enrollment as e
on s.student_id=e.student_id
join course as c 
on c.course_id=e.course_id
group by s.student_id,student_name
having s.student_id in (select s.student_id from Students as s
join Enrollment as e on s.student_id=e.student_id
join Course as c on c.course_id=e.course_id
group by s.student_id,student_name
having count(*)>=1)

--==============================================================================================================
---Write a subquery to  display booking_id, booking_date,flight_number, departure airport, destination_airport,
--passenger_name and passenger_age 
--table using booking, flight and passenger using subquery

use [SQL_PRACICE_DB]

CREATE TABLE Airports (
						AirportCode VARCHAR(3) PRIMARY KEY,
						AirportName VARCHAR(100) NOT NULL,
						City VARCHAR(100) NOT NULL,
						Country VARCHAR(100) NOT NULL
						);
INSERT INTO Airports (AirportCode, AirportName, City, Country)
VALUES 
    ('DEL', 'Indira Gandhi International Airport', 'New Delhi', 'India'),
    ('BOM', 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India'),
    ('MAA', 'Chennai International Airport', 'Chennai', 'India'),
    ('BLR', 'Kempegowda International Airport', 'Bengaluru', 'India'),
    ('HYD', 'Rajiv Gandhi International Airport', 'Hyderabad', 'India');

CREATE TABLE Airlines (
					AirlineID INT PRIMARY KEY,
					AirlineName VARCHAR(100) NOT NULL,
					IATA_Code VARCHAR(2) NOT NULL
					);

INSERT INTO Airlines (AirlineID, AirlineName, IATA_Code)
VALUES 
    (1, 'Air India', 'AI'),
    (2, 'IndiGo', '6E'),
    (3, 'SpiceJet', 'SG'),
    (4, 'GoAir', 'G8'),
    (5, 'Vistara', 'UK');


CREATE TABLE Flights (
					FlightID INT PRIMARY KEY,
					AirlineID INT,
					FlightNumber VARCHAR(10) NOT NULL,
					DepartureAirportCode VARCHAR(3),
					ArrivalAirportCode VARCHAR(3),
					DepartureTime DATETIME,
					ArrivalTime DATETIME,
					Amount dec(10,2),
					CONSTRAINT FK_Airline FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
					CONSTRAINT FK_DepartureAirport FOREIGN KEY (DepartureAirportCode) REFERENCES Airports(AirportCode),
					CONSTRAINT FK_ArrivalAirport FOREIGN KEY (ArrivalAirportCode) REFERENCES Airports(AirportCode)
				  );

INSERT INTO Flights (FlightID, AirlineID, FlightNumber, DepartureAirportCode, ArrivalAirportCode, DepartureTime, ArrivalTime, Amount)
VALUES 
    (1, 1, 'AI101', 'DEL', 'BOM', '2024-02-12 08:00:00', '2024-02-12 10:00:00', 200.00),
    (2, 2, '6E202', 'BOM', 'MAA', '2024-02-12 11:00:00', '2024-02-12 13:00:00', 150.00),
    (3, 3, 'SG303', 'MAA', 'BLR', '2024-02-12 14:00:00', '2024-02-12 15:00:00', 100.00),
    (4, 4, 'G845', 'BLR', 'HYD', '2024-02-12 16:00:00', '2024-02-12 17:00:00', 120.00),
    (5, 5, 'UK707', 'HYD', 'DEL', '2024-02-12 18:00:00', '2024-02-12 20:00:00', 180.00);


CREATE TABLE Passengers (
						PassengerID INT PRIMARY KEY,
						PassengerName VARCHAR(100) NOT NULL,
						Age INT,
						Gender VARCHAR(10),
						Email VARCHAR(100)
						);

INSERT INTO Passengers (PassengerID, PassengerName, Age, Gender, Email)
VALUES 
    (1, 'Amit Patel', 35, 'Male', 'amit@example.com'),
    (2, 'Priya Sharma', 28, 'Female', 'priya@example.com'),
    (3, 'Rahul Singh', 45, 'Male', 'rahul@example.com'),
    (4, 'Neha Gupta', 30, 'Female', 'neha@example.com'),
    (5, 'Sanjay Kumar', 40, 'Male', 'sanjay@example.com');

CREATE TABLE Reservations (
							ReservationID INT PRIMARY KEY,
							FlightID INT,
							PassengerID INT,
							ReservationDate DATE,
							SeatNumber VARCHAR(10),
							CONSTRAINT FK_Flight FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
							CONSTRAINT FK_Passenger FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
						);

INSERT INTO Reservations (ReservationID, FlightID, PassengerID, ReservationDate, SeatNumber)
VALUES 
    (1, 1, 1, '2024-02-12', 'A1'),
    (2, 2, 2, '2024-02-12', 'B3'),
    (3, 3, 3, '2024-02-12', 'C2'),
    (4, 4, 4, '2024-02-12', 'D4'),
    (5, 5, 5, '2024-02-12', 'E5'),
    (6, 1, 2, '2024-02-12', 'F6');

INSERT INTO Reservations (ReservationID, FlightID, PassengerID, ReservationDate, SeatNumber)
VALUES (7, 1, 1, '2024-02-12', 'F6');

Select ReservationID, ReservationDate, FlightNumber, a1.AirportName as DepartureAirport, a2.AirportName as ArrivalAirport,PassengerName,Age
FROM Passengers as p
JOIN  [Reservations] as r
ON p.PassengerID = r.PassengerID
JOIN [Flights] as f
on f.FlightID = r.FlightID
JOIN [Airports] as a1
on a1.AirportCode =f.DepartureAirportCode
JOIN  [Airports] as a2
on a2.AirportCode = f.ArrivalAirportCode
WHERE ReservationID in
(
select ReservationID from Passengers as p
join [Reservations] as r
on p.PassengerId = r.PassengerID
join [Flights] as f
on f.FlightId = r.FlightId
join [Airports] as a1
on a1.AirportCode =f.DepartureAirportCode
join  [Airports] as a2
on a2.AirportCode = f.ArrivalAirportCode
)

--PIVOT QUESTION---
---============================================================================================================
--PIVOT in SQL Server


CREATE TABLE Customers
(
	CustomerName VARCHAR(50),
	ProductName VARCHAR(50),
	Amount INT
)

INSERT INTO Customers VALUES('James', 'Laptop', 30000)
INSERT INTO Customers VALUES('James', 'Desktop', 25000)
INSERT INTO Customers VALUES('James', 'Mobile', 60000)
INSERT INTO Customers VALUES('David', 'Laptop', 25000)
INSERT INTO Customers VALUES('David', 'Mobile', 50000)
INSERT INTO Customers VALUES('Smith', 'Desktop', 30000)
INSERT INTO Customers VALUES('Pam', 'Laptop', 45000)
INSERT INTO Customers VALUES('Pam', 'Laptop', 30000)
INSERT INTO Customers VALUES('John', 'Desktop', 30000)
INSERT INTO Customers VALUES('John', 'Desktop', 30000)
INSERT INTO Customers VALUES('John', 'Laptop', 30000)

 
 SELECT * FROM Customers

 --SECTION-1--
SELECT
	CustomerName,
	Laptop,
	Desktop

--SECTION-2--
FROM
( 
 SELECT
	 CustomerName,
	 ProductName,
	 Amount
 FROM Customers
 )
 AS PivotData

--SECTION-3--
 PIVOT
 (
	 SUM(Amount) FOR ProductName 
	 IN(Laptop,Desktop)
 ) 
 AS PivotTable

 --Write a query to anlysis number of patients admitted to each ward for each gender --
 --patient table have (patient_id, patient_name,gender (pivot on gender), age, ward)

 CREATE TABLE [Patient] (
    [patient_id] INT PRIMARY KEY,
    [patient_name] VARCHAR(100),
    [gender] VARCHAR(10),
    [age] INT,
    [ward] VARCHAR(50)
);

INSERT INTO Patient (patient_id, patient_name, gender, age, ward) VALUES
(1, 'William Taylor', 'Male', 45, 'Ortho'),
(2, 'Olivia Wilson', 'Female', 30, 'Neurologists'),
(3, 'Ethan Thomas', 'Male', 55, 'Medicine'),
(4, 'Ava Brown', 'Female', 20, 'Psychology'),
(5, 'Liam Miller', 'Male', 35, 'Ortho'),
(6, 'Sophia Garcia', 'Female', 50, 'Neurologists'),
(7, 'James Rodriguez', 'Male', 40, 'Psychology'),
(8, 'Emma Martinez', 'Female', 25, 'Medicine'),
(9, 'Noah Hernandez', 'Male', 60, 'Ortho'),
(10, 'Isabella Gonzalez', 'Female', 28, 'Psychology');

SELECT * FROM [Patient]

 --SECTION-1--
SELECT * FROM
( 
 SELECT
	  [ward], [gender] ,count(gender) AS No_of_Patients
      from [Patient]
      group by [ward],[gender]
 )
  AS PivotData

--SECTION-3--
 PIVOT
 (
	Sum(No_of_Patients) for [gender]
	 IN(Male,Female)
 ) 
 AS PivotTable

 --HANDS_ON ON 23/02/2024--
 ---=======================================================================
 --CREATE A PROCEDURE BASED ON ACTION_TYPE (INSERT, SELECT, UPDATE, DELETE)
 --========================================================================

 Select * from [Employee]

alter procedure usp_basedonCrudOperation
(
	  @action_type VARCHAR(50) ,
	  @Id INT = Null,
	  @name varchar(50) = Null,
	  @marks INT =Null,
	  @message varchar(100) = null OUT 
)
 as
 begin
        if @action_type ='INSERT' 
		  begin
		       Insert into [Employee] ([Id],[name],[marks]) VALUES(@Id, @name, @marks)
		   end
	  
	   else if @action_type ='SELECT' 
	       begin
			     if (@Id is not null)
				    begin
			           select [Id],[name],[marks]  from [Employee] Where Id =@Id
				    end

			    else
				   begin 
				      select [Id],[name],[marks] from [Employee] 
				    end

			end

	   else if @action_type = 'UPDATE' 

	        begin 
			      if (@name is not null )
				    begin
			              update  [Employee] set  name =@name  where Id =@id
				    end
				 else if(@marks is not null)
				    begin 
				        update  [Employee] set marks =@marks  where Id =@id
				    end
				 else
				    begin
				        update  [Employee] set name  =@name ,marks =@marks  where Id =@id
				    end
			end

		else if @action_type = 'DELETE'
		     begin
			      delete from [Employee] where id=@id
			 end
		    
	     else
		    if(@@ROWCOUNT<1)
			  begin
			    set @message = 'Please select a valid action_type'
			  end
 end

 DECLARE @message varchar(100) 
 --EXEC usp_basedonCrudOperation 'INSERT', 4, 'Annapurna', 100 ,@message out
 --EXEC usp_basedonCrudOperation 'SELECT' 
 --EXEC usp_basedonCrudOperation 'SELECT',1
 --EXEC  usp_basedonCrudOperation 'UPDATE',1,'Munka'
 --EXEC  usp_basedonCrudOperation 'UPDATE',1,null, 90
 --EXEC  usp_basedonCrudOperation 'UPDATE',1,'Raji', 80
 --EXEC  usp_basedonCrudOperation 'DELETE',4
 PRINT @message
 
 SELECT * FROM Employee
 --==============================================================================================================

 --create a procedure that accepts one table variable as input parameter for orders
 --ORDER_INFORMARION :- order_id, product_id, customer_id, quantity 
-- with that procedure output parameters are total orders and total amounts
--==============================================================================================================
USE [BikeStores]
--======================================================================

create type ut_details as table
(
	order_id int,
    product_id int,
    customer_id int,
    quantity int
)

declare @details_tble ut_details
select * from @details_tble



alter procedure usp_order_Details(@details ut_details readonly)
as 
	begin
			select SUM(d.quantity*oi.list_price) as Total_Amount ,count( o.order_id) AS total_orders
			from sales.orders as o
			join sales.order_items as oi
			on o.order_id=oi.order_id
			join @details as d 
			on d.order_id=oi.order_id
			
	end


declare @details ut_details
insert into @details
select 2,20,1212,1

exec usp_order_Details @details
--===============================================================================================================
    select * from sales.orders
	

---CREATE A PROCEDURE TO RETRIEVE ORDERS FOR SPECIFIC CUSTOMER ALONG WITH DETAIL INFORMATION ABOUT THE PRODUCTS 
--IN THOSE ORDERS
--==============================================================================================================

select * from sales.orders
select * from  sales.order_items
select * from production.products
select * from sales.customers
--=====================================================================================================

create procedure usp_getorderdetailsbycustomerid(@customer_id INT)
as 
begin
	    select o.order_id, order_status, order_date,o.required_date, p.product_id, product_name, model_year 
		from sales.orders as o 
		join sales.order_items as i
		on o.order_id = i.order_id
		join production.products as p
		on p.product_id = i.product_id
		join sales.customers as c
		on c.customer_id = o.customer_id
		where c.customer_id = @customer_id
end

	exec usp_getorderdetailsbycustomerid 5
--=======================================================================================================
alter function getorderdetailsbycustomerid(@customer_id int)
returns table
as 
return 
    (
	   select o.order_id, order_status, order_date,o.required_date, p.product_id, product_name, model_year 
		from sales.orders as o 
		join sales.order_items as i
		on o.order_id = i.order_id
		join production.products as p
		on p.product_id = i.product_id
		join sales.customers as c
		on c.customer_id = o.customer_id
		where c.customer_id = @customer_id
		)

	select * from getorderdetailsbycustomerid(5)
--============================================================================================================