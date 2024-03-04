

--------------------------------------NAME:ANWESHA DUTTA---------------------------------------------
---------------------------------SQL ASSIGNMENT IV(19/02/2024)---------------------------------------


--1.	How to display the students from a student table having same name and father's name from below table:                                                          2
								--Student Name	Father’s Name
								--Rajiv Kumar	Arvind Kumar
								--Asish Roy	    Ashim Roy
								--Bipin Gupta	Rajiv Gupta
								--Rajiv Kumar	Arvind Kumar
								--Sourav Patra	Asish Patra
								--Asish Roy  	Ashim Roy
--=====================================================================================================================

CREATE DATABASE Assignment_IV_DB
USE  [Assignment_IV_DB]

CREATE TABLE [student]
(
	[id] INT PRIMARY KEY,
	[stu_name] VARCHAR(50),
	[father_name] VARCHAR(50)
)


  INSERT INTO [student]([id],[stu_name],[father_name])
     VALUES(1,'Rajiv Kumar','Arvind Kumar'),
            (2,'Asish Roy',	'Ashim Roy'),
            (3,'Bipin Gupta','Rajiv Gupta'),
            (4,'Rajiv Kumar','Arvind Kumar'),
            (5,'Sourav Patra','Asish Patra'),
            (6,'Asish Roy','Ashim Roy')

	   SELECT * FROM [student]

	   SELECT stu_name, father_name
       FROM student
       GROUP BY stu_name, father_name
       HAVING  COUNT(*) > 1



--2.How to display current date time in below format :Oct 23 2022 21:38 PM  
--=========================================================================
SELECT FORMAT(GETDATE(), 'MMM dd yyyy hh:mm tt') AS formatted_date_time;

--3.Write a query to finding all possible paths between two nodes in a graph using recursive CTE.   
--==================================================================================================
  USE[Assignment_IV_DB]

CREATE TABLE [Node] (
    [Node_id] INT PRIMARY KEY,
    [Node_Name] VARCHAR(100)
);

INSERT INTO [Node] ([Node_id], [Node_Name])
VALUES
    (1, 'Node A'),
    (2, 'Node B'),
    (3, 'Node C'),
    (4, 'Node D');

CREATE TABLE [Graph] (
    [Start_Node] INT,
    [End_Node] INT,
    PRIMARY KEY (Start_Node, End_Node),
    FOREIGN KEY (Start_Node) REFERENCES Node(Node_id),
    FOREIGN KEY (End_Node) REFERENCES Node(Node_id)
);

INSERT INTO [Graph] ([Start_Node], [End_Node]) VALUES
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 4);

SELECT * FROM [Node]
SELECT * FROM [Graph]

WITH RecursivePaths AS (
    SELECT  Start_Node, End_Node, CAST(Node_Name AS VARCHAR(MAX)) AS Path
    FROM  [Graph]
    INNER JOIN  [Node] 
	ON [Graph].Start_Node = [Node].Node_id
    
    UNION ALL

    SELECT g.Start_Node,  g.End_Node, rp.Path + ' -> ' + n.Node_Name
    FROM RecursivePaths  AS rp
    JOIN Graph AS g 
	ON rp.End_Node = g.Start_Node
    JOIN [Node] AS n 
	ON g.End_Node = n.Node_id
)
SELECT  Start_Node, End_Node,  Path
FROM  RecursivePaths;


--===========================================================
--4.Write a query to generate a Bill of Materials for mobile.   
--===========================================================
CREATE TABLE [Product] (
    [Product_Id] INT PRIMARY KEY,
    [Product_Name] VARCHAR(100)
);

INSERT INTO [Product] ([Product_Id], [Product_Name]) VALUES
(1, 'Mobile'),
(2, 'Screen'),
(3, 'Battery'),
(4, 'Processor'),
(5, 'Camera'),
(6, 'Memory'),
(7, 'Motherboard');

SELECT * FROM [Product]


CREATE TABLE [Component_Product] (
    Component_Product_id INT,
    Product_id INT,
    Quantity INT,
	Cost INT
    PRIMARY KEY (Component_Product_id, Product_id),
    FOREIGN KEY (Component_Product_id) REFERENCES Product(Product_Id),
    FOREIGN KEY (Product_id) REFERENCES Product(Product_Id)
);


INSERT INTO Component_Product (Component_Product_id, Product_id, Quantity, Cost)
VALUES
    (2, 1, 1, 100),  
    (3, 1, 1, 200),  
    (4, 1, 1, 300),  
    (5, 1, 2, 400),  
    (6, 1, 1, 500),  
    (7, 1, 1, 600); 


SELECT * FROM [Product]
SELECT * FROM [Component_Product]

WITH RecursiveMobileComponents AS (
  SELECT cp.Component_Product_id,  cp.Product_id,  cp.Quantity, p.Product_Name,  cp.Cost
  FROM  [Component_Product] AS cp
  JOIN [Product] p 
  ON cp.Component_Product_id = p.Product_Id
  WHERE cp.Product_id = 1

  UNION ALL

  SELECT cp.Component_Product_id, cp.Product_id, mc.Quantity * cp.Quantity AS Quantity,p.Product_Name, cp.Cost
  FROM  RecursiveMobileComponents AS mc
  JOIN  [Component_Product] AS cp 
  ON mc.Component_Product_id = cp.Product_id
  JOIN [Product] p
  ON cp.Component_Product_id = p.Product_Id
)

SELECT 
  Product_Name AS Component_Name,
  Quantity AS Quantity_Required,
  Cost AS Cost_Per_Unit,
  Quantity * Cost AS Total_Cost

FROM RecursiveMobileComponents;

--=================================================================================================================
 --5.Write a trigger to ensure that any modifications to the 
 --Employees table are recorded in the AuditLog table 
 --providing an audit trail for tracking changes over time. 
 --================================================================================================================
CREATE TABLE [Employee] (
    [Emp_id] INT PRIMARY KEY,
    [Emp_name] VARCHAR(100),
    [Salary] INT
);

INSERT INTO [Employee] ([Emp_id], [Emp_name], [Salary]) VALUES
(1, 'Anwesha Dutta', 50000),
(2, 'Shyamal Dutta', 60000),
(3, 'Krishna Dutta', 70000),
(4, 'Annapurna Dutta', 60000),
(5, 'Bhaskar Dutta', 62000),
(6, 'Dilip Dutta', 54000),
(7, 'Manisha Malhotra', 57000),
(8, 'Ananya Sen', 80000),
(9, 'Laboni Sen', 64000),
(10, 'Suravi Sen', 58000);

SELECT * FROM [Employee]


 CREATE TABLE EmployeeAudit
  (
	  [ID] INT PRIMARY KEY IDENTITY,
	  [AuditData] VARCHAR(100),
	  [AuditDate] DATE
  )

  CREATE TRIGGER tr_Audit_trigger ON Employee
  FOR INSERT,DELETE,UPDATE
  AS
  BEGIN
     DECLARE @ID INT 
	 DECLARE @Name VARCHAR(50)
	 DECLARE @AuditData VARCHAR(100)
	 
	 IF EXISTS(SELECT * FROM INSERTED)
	    BEGIN
			 SELECT @ID = Emp_id ,@Name = Emp_Name
			 FROM INSERTED
			 SET @AuditData = 'New Employee Added with Id: '+ ' ' + CAST(@ID AS VARCHAR(50)) +'Name'+' '+@Name
			 INSERT INTO EmployeeAudit(AuditData,AuditDate) VALUES (@AuditData, Getdate())
	   END

	   IF EXISTS(SELECT * FROM DELETED)
	   BEGIN
	 		SELECT @ID =Emp_id ,@Name =Emp_name
			FROM DELETED
			SET @AuditData = 'OLd Employee Deleted With: '+ ' '+ CAST(@ID AS VARCHAR(50))+' '  +'Name' +' '+@Name
			INSERT INTO EmployeeAudit(AuditData, AuditDate) VALUES(@AuditData,GETDATE())
	   END

	   IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
	      BEGIN
		       SET @Name ='UPDATE'
			   SELECT @ID = Emp_id , @Name = Emp_Name 
			   FROM INSERTED
			   SET @AuditData = 'An Employee is Updated With ID : ' +' '+ CAST(@ID AS VARCHAR(50))+' ' +'Name'+' '+@Name
			   INSERT INTO EmployeeAudit(AuditData, AuditDate) VALUES(@AuditData,GETDATE())
		  END
  END

INSERT INTO Employee VALUES (11, 'Monalisa Dey' ,32000)
--DELETE FROM Employee WHERE Emp_id = 7
--UPDATE Employee SET Salary = 78000 WHERE Emp_id =4 
--UPDATE Employee SET Salary = 85000 WHERE Emp_id =2
SELECT * FROM [Employee]
SELECT * FROM [EmployeeAudit]

--=====================================================================================================================

--6.Create a stored procedure that uses a cursor to iterate over the transactions table
--(transaction id,product id,transaction type,quantity,transaction date)and
--update the stock quantity in the products table (product id,product name,stock quantity) 
--====================================================================================================================


CREATE TABLE [Products] (
    [product_id] INT PRIMARY KEY,
    [product_name] VARCHAR(100),
    [stock_quantity] INT
);

INSERT INTO [Products] ([product_id], [product_name], [stock_quantity])
VALUES
    (1, 'Laptop', 180),
    (2, 'Smartphone', 100),
    (3, 'Tablet', 200),
    (4, 'Headphones', 400),
    (5, 'Smartwatch', 150),
    (6, 'Desktop', 180);


CREATE TABLE [Transactions]
(
	 [transaction_id] INT PRIMARY KEY,
	 [transaction_type] VARCHAR(50),
	 [quantity] INT,
	 [transaction_date] DATE ,
	 [product_id] INT,
	 FOREIGN KEY(product_id) REFERENCES product(product_id)
 )

 INSERT INTO [Transactions] ([transaction_id], [transaction_type], [quantity], [transaction_date], [product_id])
  VALUES
    (1, 'Sale', 10, '2024-02-20', 1),
    (2, 'Purchase', 20, '2024-02-21', 2),
    (3, 'Sale', 15, '2024-02-22', 3),
    (4, 'Purchase', 30, '2024-02-23', 4),
    (5, 'Sale', 25, '2024-02-24', 1),
    (6, 'Purchase', 35, '2024-02-25', 2);

	SELECT * FROM [Products]
	SELECT * FROM [Transactions]


	CREATE PROCEDURE UpdateProductStock 
	AS 
	BEGIN
		DECLARE @transaction_id INT, @product_id INT, @transaction_type VARCHAR(80), @quantity INT ,@stock_quantity INT
		DECLARE My_Cursor CURSOR FOR
	    SELECT  t.transaction_id ,t.product_id ,t.transaction_type ,t.quantity,p.stock_quantity 
		FROM [Transactions] AS t
		JOIN [Products] AS p
		ON t.product_id = p.product_id

	    OPEN My_Cursor
	    FETCH NEXT FROM My_Cursor INTO @transaction_id, @product_id, @transaction_type, @quantity ,@stock_quantity
	    WHILE @@FETCH_STATUS =0
		BEGIN
		 BEGIN TRANSACTION
	          IF @transaction_type ='Sale' AND @stock_quantity>@quantity
		          BEGIN
						 UPDATE [Products]
						 SET stock_quantity = stock_quantity - @quantity
						 WHERE product_id = @product_id;
						 COMMIT TRAN
                  END

				  ELSE IF @transaction_type ='Sale' AND @stock_quantity<@quantity
		          BEGIN
						 PRINT 'Stock Not Available'
						 ROLLBACK TRAN
                  END

			ELSE IF @transaction_type = 'Purchase'
                BEGIN
					UPDATE [Products]
					SET stock_quantity = stock_quantity + @quantity
					WHERE product_id = @product_id
					COMMIT TRAN
                END
			FETCH NEXT FROM My_Cursor INTO @transaction_id, @product_id,  @transaction_type,@quantity ,@stock_quantity;
	 END

	  CLOSE My_Cursor
	  DEALLOCATE My_Cursor

 END;

 EXEC UpdateProductStock 
 select * from [products]

--=======================================================================================
--7.Create stored procedure that accept table variable as parameter using the BusBooking.  
--=======================================================================================

CREATE TABLE [BusBooking] (
    [BookingId] INT PRIMARY KEY,
    [BusId] INT,
   [PassengerName] VARCHAR(100),
    [BookingDate] DATE
);

INSERT INTO [BusBooking] ([BookingId], [BusId], [PassengerName], [BookingDate])
VALUES
    (1, 1, 'Anwesha Dutta', '2024-02-20'),
    (2, 2, 'Sujata Patra', '2024-02-21'),
    (3, 3, 'Suravi Sen', '2024-02-22'),
    (4, 4, 'Pushpashree Mondal', '2024-02-23');


SELECT * FROM [BusBooking];


CREATE TYPE [BusBookingType] AS TABLE (
    [BookingId] INT,
    [BusId] INT,
    [CustomerName] VARCHAR(100),
    [BookingDate] DATE
);


CREATE PROCEDURE InsertBusBookings (@BusBookings BusBookingType READONLY) 
AS
BEGIN
    INSERT INTO BusBooking (BookingId, BusId, PassengerName, BookingDate)
    SELECT BookingId, BusId, CustomerName, BookingDate
    FROM @BusBookings;
END;

--
DECLARE @BookingData BusBookingType;
INSERT INTO @BookingData ([BookingId], [BusId], [CustomerName], [BookingDate])
VALUES
    (5, 5, 'Debdutta Roy', '2024-02-24'),
    (6, 6, 'Manija Khatun', '2024-02-25');

EXEC InsertBusBookings @BusBookings = @BookingData;

SELECT * FROM [BusBooking]

