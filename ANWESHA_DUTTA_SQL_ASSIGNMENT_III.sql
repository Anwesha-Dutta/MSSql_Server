
--Name:-Anwesha Dutta--
--LAB EXAM --
--SQL ASSIGNMENT III
--=============================================================================================

--1. What will be the output of the below query, given an Employee table having 10 records?        2
            --BEGIN TRAN
            --    TRUNCATE TABLE Employees
            --    ROLLBACK
            --END TRAN
            --    SELECT * FROM Employees

---------------------------------------------------------------------------------------------

-- Create the Employee table
CREATE DATABASE [Assignment]
CREATE SCHEMA [HR]

USE [Assignment]

CREATE TABLE [HR].[Employee] (
    [Emp_id] INT PRIMARY KEY,
    [Emp_name] VARCHAR(100)
);

-- Insert 10 rows into the Employee table
INSERT INTO [HR].[Employee] ([Emp_id], [Emp_name]) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Michael Johnson'),
(4, 'Emily Brown'),
(5, 'Daniel Lee'),
(6, 'Sarah Wang'),
(7, 'David Martinez'),
(8, 'Jennifer Taylor'),
(9, 'Christopher Anderson'),
(10, 'Jessica Garcia');

SELECT * FROM [HR].[Employee]

          BEGIN TRAN
                TRUNCATE TABLE [HR].[Employee]
                ROLLBACK 
      

  SELECT * FROM [HR].[Employee]
------------------------------------------------------------------------

---2. Write an SQL query to display the text CAPONE as following:                                                           2
                    --C
                    --A
                    --P
                    --O
                    --N
  --========================================================================               


DECLARE @string VARCHAR(100)='CAPONE'
DECLARE @String_lenth INT=LEN(@string)
DECLARE @i INT=1
WHILE @i<=@String_lenth
	BEGIN
		PRINT SUBSTRING(@string,@i,1)
		SET @i=@i+1
	END
--Or In Another Method
----------------------------------------
SELECT SUBSTRING('CAPONE', 1, 1) AS Letter
  UNION ALL
SELECT SUBSTRING('CAPONE', 2, 1)
  UNION ALL
SELECT SUBSTRING('CAPONE', 3, 1)
  UNION ALL
SELECT SUBSTRING('CAPONE', 4, 1)
  UNION ALL
SELECT SUBSTRING('CAPONE', 5, 1)
  UNION ALL
SELECT SUBSTRING('CAPONE', 6, 1);

--3.Explain the difference between ROW_NUMBER (), RANK () & DENSE_RANK () by giving an example----------------------------------------------------------------------------------------------------Use [BikeStores]--ROW_NUMBER()--SELECT first_name, last_name, city,
ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name ) row_num
FROM sales.customers
ORDER BY city

 --DENSE_RANK() FUNCTION
 -----------------------------------
 SELECT * FROM (
SELECT product_id,product_name,brand_id,list_price, DENSE_RANK () OVER (
PARTITION BY brand_id
ORDER BY list_price DESC
) price_rank
FROM production.products
) t
WHERE price_rank <= 3;--RANK() FUNCTION------------------------------USE Assignment-- Create the Students table
CREATE TABLE [HR].[Another_Students] (
    [Student_id] INT PRIMARY KEY,
    [Student_name] VARCHAR(100),
    [Score] INT
);

-- Insert some values into the Students table
INSERT INTO [HR].[Another_Students] ([Student_id], [Student_name], [Score]) VALUES
(1, 'Bhaskar', 92),
(2, 'Annapurna', 92),
(3, 'Dilip', 85),
(4, 'Shyamal', 85),
(5, 'Krishana', 85),
(6, 'Anwesha', 78);

SELECT * FROM [HR].[Another_Students]

SELECT Student_id,Student_name, Score, 
RANK() OVER (ORDER BY Score DESC) AS Rank
FROM [HR].[Another_Students];

--RANK()
----------------------------------------------------------------------
--It assigns a unique rank to each  row value within the partition
--If there are some rows with the same value, it assigns the same rank to those rows, and then skips the next rank. In other words, it leaves gaps in the rank sequence.
--Example: If two rows tie for the first position, the next rank will be 3 not 2.


--DENSE_RANK()
----------------------------------------------------------------------------
--It will assigns a unique rank to each  row value within the partition.
--If there are rows with the same value, it assigns the same rank to those rows, but it does not leave gaps in the rank sequence. 
--or it does not skip like RANK() In SQL ,It continues with consecutive ranks.
--Example: If two rows tie for the first position, the next rank will be 2 not 3.


--ROW_NUMBER()
-----------------------------------------------------------------------------------------
--Assigns a unique sequential integer to each row within the partition, starting from 1.
--It does not handle ties. Each row gets a unique rank, and there are no gaps in the sequence.
--Example: If two rows tie for the first position, both will receive a rank of 1, and the next rank will be 2.
---------------------------------------------------------------------------------------

--4.What are Scope_identity () and @@rowcount, explain with Example
--=====================================================================================

--SCOPE_IDENTITY() --It will retrieve the last inserted value of the last table
-----------------------------
USE [Assignment]


CREATE TABLE [HR].[Test] (
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [Name] VARCHAR(50)
);


INSERT INTO [HR].[Test] ([Name]) 
VALUES ('Anwesha'),
        ('Shyamal'),
		('Krishna');

SELECT * FROM [HR].[Test]

--It will retrieve the last insert number or last identity number of last table 
SELECT SCOPE_IDENTITY() AS LastIdentity;


--@@ROWCOUNT()-- returns the number of rows updated, inserted or deleted by the preceding statement.
--------------------------
UPDATE [HR].[Test] SET [Name] = 'Annapurna' WHERE ID = 1;

-- It will Retrieve the number of rows affected
SELECT @@ROWCOUNT AS RowsAffected;
SELECT * FROM [HR].[Test]

--------------------------------------------------------------------------------------------------------

--5. Let us have a table with the following data:                                                                                             2

--CourseID    Course Name
--1                 .Net
--2                 SQL Server
--3                 SSRS
--4                 SharePoint
--5                 WCF
--We need to concatenate the Course Name column like the following:
--.Net, SQL Server, SSRS, SharePoint, WCF
-----------------------------------------------------------------------------------

USE [Assignment]

CREATE TABLE [HR].[Courses] (
    [CourseID] INT PRIMARY KEY,
    [Course Name] VARCHAR(100)
);

INSERT INTO  [HR].[Courses] ([CourseID], [Course Name]) 
VALUES
(1, '.Net'),
(2, 'SQL Server'),
(3, 'SSRS'),
(4, 'SharePoint'),
(5, 'WCF');

SELECT * FROM [HR].[Courses]

SELECT STRING_AGG([Course Name], ', ') AS Concatenated_Courses
FROM [HR].[Courses];
-----------------------------------------------------------------------------------------------

--6. Create a stored procedure to print total number of patients and their average age to a specific doctor.
--The procedure should return total number of patients and their average age.      
--==============================================================================================================
USE [Assignment]


CREATE TABLE [HR].[Doctors] (
    [DoctorID] INT PRIMARY KEY,
    [DoctorName] VARCHAR(100) NOT NULL,
    [Specialization] VARCHAR(100),
    [PhoneNumber] VARCHAR(20)
);


INSERT INTO [HR].[Doctors] ([DoctorID], [DoctorName], [Specialization], [PhoneNumber]) 
VALUES 
(1, 'Dr.Anwesha', 'Cardiology', '123-456-7890'),
(2, 'Dr.Shyamal', 'Pediatrics', '456-789-0123'),
(3, 'Dr.Krishna', 'Orthopedics', '789-012-3456');

SELECT * FROM [HR].[Doctors]


CREATE TABLE [HR].[Patients] (
    [PatientID] INT PRIMARY KEY,
    [PatientName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [DoctorID] INT, -- Foreign Key referencing Doctors table
    CONSTRAINT FK_Doctor FOREIGN KEY (DoctorID) REFERENCES [HR].[Doctors](DoctorID)
);

INSERT INTO [HR].[Patients] ([PatientID], [PatientName], [Age], [Gender], [DoctorID]) 
VALUES 
(1, 'Susmita', 30, 'Female', 1), 
(2, 'Subrata', 40, 'Male', 2),      
(3, 'Sudip', 20, 'Male', 3),  
(4, 'Anirban', 30, 'Male', 1),    
(5, 'Pushpa', 60, 'Female', 2);  

SELECT * FROM [HR].[Doctors]
SELECT * FROM [HR].[Patients]


CREATE PROCEDURE usp_getPatientDetails 
(
    @DoctorID INT,
	@message VARCHAR(100) OUT
)
AS 
BEGIN
  SELECT DoctorName, COUNT(PatientID) AS 'Total_number_of_Patient' ,AVG(Age) AS 'Avg_age'
  FROM [HR].[Doctors] AS d
  JOIN [HR].[Patients] AS p
  ON d.DoctorID = p.DoctorID
  WHERE d.DoctorID =@DoctorID
  GROUP BY DoctorName

   IF(@@ROWCOUNT<1)
   BEGIN
    SET @message = 'No details available'
   END
END;

DECLARE @message VARCHAR(100) 
EXEC usp_getPatientDetails 1,@message OUT
PRINT @message

--------------------------------------------------------------------------------------------------------------
--7. Create a stored procedure with input student ID, course ID and enrolment date 
--to enrol a student in multiple courses simultaneously while ensuring that
--all enrollments are successful or rolled back in case of any failure.
--=====================================================================================================

Use [Assignment]

--DROP TABLE [HR].[New_Courses]
CREATE TABLE [HR].[New_Courses] (
    [CourseID] INT PRIMARY KEY,
    [Course Name] VARCHAR(100)
);

INSERT INTO  [HR].[New_Courses] ([CourseID], [Course Name]) 
VALUES
(1, 'C'),
(2, 'Java'),
(3, 'HTML');

SELECT * FROM [HR].[New_Courses]
--DROP TABLE [HR].[New_Students]

CREATE TABLE [HR].[New_Students] (
    [StudentID] INT PRIMARY KEY,
    [Student_name] VARCHAR(100),
    [Score] INT
);

-- Insert some values into the Students table
----------------------------------------------------------------------------
INSERT INTO [HR].[New_Students] ([StudentID], [Student_name], [Score]) VALUES
(1, 'Anwesha', 92),
(2, 'Shyamal', 92),
(3, 'Krishna', 85);

SELECT * FROM [HR].[New_Courses]
SELECT * FROM [HR].[New_Students]

--DROP TABLE [HR].[Enrollments]
CREATE TABLE [HR].[Enrollments] (
    [EnrollmentID] INT PRIMARY KEY IDENTITY(1,1),
    [StudentID] INT,
    [CourseID] INT,
    [EnrollmentDate] DATE,
    CONSTRAINT FK_Student FOREIGN KEY (StudentID) REFERENCES [HR].[Students](Student_id),
    CONSTRAINT FK_Course FOREIGN KEY (CourseID) REFERENCES [HR].[Courses](CourseID)
);

INSERT INTO [HR].[Enrollments] ([StudentID], [CourseID], [EnrollmentDate]) 
VALUES 
(1, 1, '2024-02-12'),  
(2, 2, '2024-02-12'),  
(3, 3, '2024-02-12'); 

SELECT * FROM [HR].[Enrollments]

 
ALTER PROCEDURE usp_EnrollStudentInCourses 
    (
	@StudentID INT,
    @CourseID VARCHAR(MAX),
    @EnrollmentDate DATE,
	@message VARCHAR(100) OUT
	)
AS
BEGIN
SET NOCOUNT ON;
    
      BEGIN TRANSACTION 

		IF EXISTS(SELECT * FROM [HR].[Enrollments] WHERE StudentID = @StudentID AND CourseID =@CourseID)
		BEGIN
		    IF(@@ROWCOUNT<1)
		      SET @message = 'Already Inserted'
		      ROLLBACK
        END
        ELSE
	         BEGIN
			   INSERT INTO [HR].[Enrollments] ([StudentID],[CourseID],[EnrollmentDate])
			   VALUES(@StudentID,@CourseId, @EnrollmentDate)
      BEGIN
	       IF(@@ROWCOUNT>=1)
		       SET @message = 'Sucessfully Inserted'
			   COMMIT
	         END
		END

	END;

DECLARE @message VARCHAR(100) 
EXEC usp_EnrollStudentInCourses 2,1,'2024-02-12',@message OUT
 --EXEC usp_EnrollStudentInCourses 1,3,'2024-02-12',@message OUT
 --EXEC usp_EnrollStudentInCourses 1,1,'2024-02-12',@message OUT
-- EXEC usp_EnrollStudentInCourses 2,3,'2024-02-12',@message OUT
PRINT @message

 
--====================================================================================================

--8.Create stored procedure to place an order and corresponding entry 
--should be done in all tables like order, order_items,stock.        
---------------------------------------------------------------------------------------------
USE [Assignment]


CREATE TABLE [HR].[Orders] (
    [OrderID] INT PRIMARY KEY IDENTITY(1,1),
    [CustomerID] INT,
    [OrderDate] DATE
);

INSERT INTO  [HR].[Orders]([CustomerID], [OrderDate]) VALUES
(1, '2024-02-12'),
(2, '2024-02-13'),
(3, '2024-02-14');

--DROP TABLE [HR].[Stock]
CREATE TABLE [HR].[Stock] (
    [ProductID] INT PRIMARY KEY,
    [Quantity] INT,
	[OrderID] INT FOREIGN KEY 
	REFERENCES [HR].[Orders]([OrderID])
);

INSERT INTO [HR].[Stock] ([ProductID], [Quantity], [OrderID]) VALUES
(1, 10, 1),  
(2, 15, 2),  
(3, 20, 3);  


SELECT * FROM [HR].[Orders]
SELECT * FROM [HR].[Stock]


CREATE PROCEDURE usp_PlaceOrder 
    (
	@ProductID INT,
    @Quantity INT,
    @CustomerID INT,
    @OrderDate DATE
	)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert order record
        INSERT INTO [HR].[Orders] ([CustomerID], [OrderDate])
        VALUES (@CustomerID, @OrderDate);
        DECLARE @OrderID INT = SCOPE_IDENTITY();

        -- Update stock quantity
        UPDATE [HR].[Stock]
        SET Quantity = Quantity - @Quantity
        WHERE ProductID = @ProductID;

       COMMIT TRANSACTION;
   END TRY

    BEGIN CATCH
        -- Rollback transaction in case of error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
    END CATCH;
END;

EXEC usp_PlaceOrder 3,10,1,'2024-02-12'

SELECT * FROM [HR].[Orders]
SELECT * FROM [HR].[Stock]

--================================================================================================

--9.Create stored procedure to  take input parameter passenger id
--to retrieve booking details for a specific passenger and returns output parameters 
--to provide information about the number of bookings and the total amount spent by the passenger.
--==================================================================================================
 Use [Assignment]


 CREATE TABLE [HR].[Passengers] (
    [PassengerID] INT PRIMARY KEY,
    [PassengerName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [Email] VARCHAR(100),
	[Amount] DECIMAL(10,2)
);

 
INSERT INTO [HR].[Passengers] ([PassengerID], [PassengerName], [Age], [Gender], [Email], [Amount])
VALUES 
    (1, 'Anwesha Dutta', 24, 'Male', 'anweshadutta891@gmail.com',51000.00),
    (2, 'Susmita Hazra', 25, 'Female', 'susmita.hazra@example.com', 1500.00),
    (3, 'Subrata Pal', 40, 'Male', 'subrata.pal@example.com', 2000.00),
    (4, 'Anjali Singh', 28, 'Female', 'anjali.singh@example.com', 2500.00),
    (5, 'Pushpak Mondal', 35, 'Male', 'pushpak.mandal@example.com', 3000.00);

	SELECT * FROM [HR].[Passengers]
	
CREATE TABLE [HR].[New_Booking] (
    [booking_id] INT PRIMARY KEY,
    [booking_date] DATE,
    [PassengerID] INT,
    FOREIGN KEY (PassengerID) REFERENCES [HR].[Passengers]([PassengerID])
);


INSERT INTO [HR].[New_booking] ([booking_id], [booking_date], [PassengerID])
VALUES 
    (1, '2024-02-12', 1),
    (2, '2024-02-11', 2),
    (3, '2024-02-10', 3),
    (4, '2024-02-09', 2),
    (5, '2024-02-08', 3);

	SELECT * FROM  [HR].[New_booking] 

CREATE PROCEDURE usp_passengerinfo(@PassengerID INT)
AS
BEGIN
    SELECT p.PassengerID,p.PassengerName, COUNT(p.PassengerID) AS total_booking,SUM(Amount) AS total_amount
	FROM  [HR].[Passengers]  AS p
	INNER JOIN [HR].[New_Booking] AS  b
	ON p.PassengerID = b.PassengerID
	WHERE p.PassengerID=@PassengerID
	GROUP BY p.PassengerID,p.PassengerName
	
END

EXEC usp_passengerinfo 1

--==================================================================================================
--10. Suppose there is table named sales that stores information 
--about sales transactions, including the sales ID, sales date,
--customer ID, product ID, and the total amount.
--Create indexes on the columns frequently used 
--in the WHERE clause or JOIN conditions like sales date, customer id, product id
--using covering index.  
--=========================================================================================

CREATE TABLE [HR].[Sales] (
    [SalesID] INT PRIMARY KEY IDENTITY(1,1),
    [SalesDate] DATE,
    [CustomerID] INT,
    [ProductID] INT,
    [TotalAmount] INT,
	
);

DECLARE @Counter INT = 1;
DECLARE @SalesDate DATE = '2024-01-01';

WHILE @Counter <= 60000
BEGIN
    INSERT INTO [HR].[Sales] ([SalesDate], [CustomerID], [ProductID], [TotalAmount]) 
    VALUES (@SalesDate, @Counter % 100 + 1, @Counter % 50 + 1, @Counter % 1000 + 100);

    SET @Counter = @Counter + 1;
    SET @SalesDate = DATEADD(DAY, 1, @SalesDate); 
END;

SELECT * FROM [HR].[Sales]
 

	CREATE NONCLUSTERED INDEX IX_tbl_Sales ON [HR].[Sales](CustomerId,ProductID ASC)
	INCLUDE([SalesDate],[TotalAmount])

	SELECT * FROM [HR].[Sales] WHERE CustomerId = 1 and ProductID = 1
	SELECT * FROM [HR].[Sales] WHERE SalesDate='2024-04-9' AND TotalAmount=200
	SELECT * FROM [HR].[Sales] WHERE CustomerId = 1 and TotalAmount = 400

	--===============================================================================
