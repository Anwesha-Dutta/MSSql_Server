
--Hands-on on 17/01/2024

ALTER DATABASE Student_DB modify name = Students_DB;
--OR WE CAN ALSO RENAME IT IN ANOTHER WAY
EXEC sp_renamedb 'Student_DB' ,'Students_DB';
CREATE DATABASE [New_DB];
--DROP DATABASE New_DB ;
USE Students_DB;
CREATE SCHEMA HR;

CREATE TABLE [HR].[jobs]
(
job_id INT PRIMARY KEY IDENTITY,
customer_id INT NOT NULL,
description VARCHAR(200),
created_at DATETIME2 NOT NULL
);

--Hands-on on 18/01/2024

--Master Table 
 CREATE TABLE [HR].[department]
 (
	 [Dept_id] INT CONSTRAINT [Dept_pk] PRIMARY KEY IDENTITY(1,1),
	 [Dept_Name] VARCHAR(10)  NOT NULL,
	 [Location] VARCHAR(30)  NOT NULL,
	 [City] VARCHAR(10)  NOT NULL,
	 [PINCode] CHAR(7)  NOT NULL
 );

 -- Child Table 
  CREATE TABLE [HR].[Employee]
 (
	 [Emp_id] INT CONSTRAINT [Emp_pk] PRIMARY KEY IDENTITY(1,1),
	 [Emp_Name] VARCHAR(30)  NOT NULL,
	 [Gender] CHAR(1)  NOT NULL,
	 [Address] VARCHAR(30)  NOT NULL,
	 [Salary] INT  NOT NULL,
	 --[Dept_id] INT FOREIGN KEY
	 [Dept_id] INT,
	 [DOJ] DATETIME NOT NULL,
	 FOREIGN KEY ([Dept_id]) REFERENCES [HR].[department]([Dept_id])

	 --We can also write in this way 

	  --[Dept_id] INT FOREIGN KEY
	--  REFERENCES [HR].[department]([Dept_id])
 );

 --Insert the data in Department table







 INSERT INTO [HR].[department] ([Dept_Name],[Location],[City],[PINCode])
		 VALUES('IT','MCC','Kolkata','722674'),
		 ('BPO','MCC','Kolkata','722674'),
		 ('HR','MCC','Kolkata','722674'),
		  ('ACCOUNTENT','MCC','Kolkata','722674'),
		   ('EXAM','MCC','Kolkata','722674'),
			('PAINT','MCC','Kolkata','722674');


	SELECT * FROM [HR].[department];

	TRUNCATE TABLE [HR].[department]; --You have to delete foreign key first to truncate this table

	USE Students_DB;

	CREATE TABLE [HR].[Marks]
	(
		 [Student_id] INT CONSTRAINT [Student_pk]  PRIMARY KEY IDENTITY(1,1),
		 [Student_Name] VARCHAR(20) NOT NULL,
		 [Marks] INT NOT NULL
	 );

	 INSERT INTO [HR].[Marks] ([Student_Name],[Marks])
	 VALUES('Anwesha Dutta',80),
	       ('Susmita Hazra',80),
		   ('Mandira Roy',70),
		   ('Tuhina Mondal',67),
		   ('Chaina Roy',76),
		   ('Debarati China',65),
		   ('Pranjal Chatterjee',65),
		   ('Manisha Choudhury', 58),
		   ('Lisa Dey', 45),
		   ('Isha Kundu', 54);


		   SELECT * FROM [HR].[Marks];
		   
		   DELETE FROM [HR].[Marks] WHERE Student_id BETWEEN 6 AND 10;

		   SELECT * FROM [HR].[Marks];

		   DBCC CHECKIDENT ('[HR].[Marks]',Reseed,5);


		  -- DROP TABLE [HR].[Employee];

		  SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
		  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		  WHERE TABLE_NAME ='Employee';
		  
		  EXEC sp_rename  'HR.FK__Employee__Dept_i__49C3F6B7', 'HR.Employee_Dept_id_fk';

		 ALTER TABLE [HR].[Employee] DROP CONSTRAINT [HR.Employee_Dept_id_fk];

		 --Now you can delete the master table by deleting the constraint of child table
		 --that reffering the primary key of master table

		 DROP TABLE [HR].[department];
	


	CREATE TABLE [HR].[Record]
	(
		  [Worker_id] INT CONSTRAINT[Worker_pk]  PRIMARY KEY IDENTITY(1,1) ,
		  [Worker_Name] VARCHAR(20) NOT NULL,
		  [Address] VARCHAR(30) ,
		  [Marks] INT NOT NULL
		  );

		  SELECT * FROM [HR].[Record];

		  -- Change Datatype
		  ALTER TABLE [HR].[Record] 
		  ALTER COLUMN [Marks] decimal(3,2);

		  -- Drop Column
		  ALTER TABLE [HR].[Record] 
		  DROP COLUMN [Address];


		  --Add a  new Column
		   ALTER TABLE [HR].[Record] 
		   ADD  Age INT;
	 
	 --Add NOT NULL CONSTRAINT
	      ALTER TABLE [HR].[Record] 
	      ALTER COLUMN [Age] INT NOT NULL;

	  	 --Change the size of data
	     ALTER TABLE [HR].[Record] 
	     ALTER COLUMN [Address] VARCHAR(40);
		
		--Change data-type
		 ALTER TABLE [HR].[Record] 
		 ALTER COLUMN[Worker_Name] CHAR(20);

		 --Practice
		 CREATE TABLE [HR].[price_lists]
		 (
		 product_id INT,
		 valid_from DATE,
		 price DEC(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK(price>=0),
		 discount DEC(10,2) NOT NULL,
		 surcharge DEC(10,2) NOT NULL,
		 note VARCHAR(255),
		 PRIMARY KEY(product_id,valid_from)
		 );
		 ----

		 --Set defalut value 
		 ALTER TABLE [HR].[RECORD]
		 ADD City VARCHAR(20) CONSTRAINT[Worker_dc] DEFAULT 'NEW TOWN';

		 INSERT INTO [HR].[Record] ([Worker_Name],[Age],[Marks])
		 VALUES('Nayan',24,8.00),
		 ('Barun',24,8.00),
		 ('Chayan',24,8.00);

		 SELECT * FROM [HR].[Record];

		 DBCC CHECKIDENT('[HR].[Record]',Reseed,1);

		  --TEMPORARY TABLE(COPY)(# means temporary table)
		  SELECT [Worker_Name] ,[Age],[Marks]
		  INTO #Record_temp
		  FROM [HR].[Record];

		  -- Create Temporary Table

		  CREATE TABLE #Newtemp
		  (
		   [Singer_id] INT CONSTRAINT [Singere_pk]  PRIMARY KEY IDENTITY(1,1),
		   [Singer_Name] VARCHAR(20),
		   [Age] INT NOT NULL,
		   [Marks] INT NOT NULL
		   );

		   DROP TABLE #Newtemp;

		    CREATE TABLE #Newtemp
		  (
		   [Singer_Name] VARCHAR(20),
		   [Age] INT NOT NULL,
		   [Marks] DEC(3,2) NOT NULL
		   );

		   DROP TABLE #Newtemp

		   
		    CREATE TABLE #Newtemp
		  (
		   [Age] INT NOT NULL,
		   [Marks] DEC(3,2) NOT NULL
		   );

		   INSERT INTO #Newtemp
		   SELECT Age ,Marks 
		   FROM [HR].[Record]
		  WHERE Worker_id =3;


		     
	 --HANDS-ON 0N 19/01/2024      
	 
		CREATE TABLE [HR].[Parent]
		(

		 Parent_id INT  CONSTRAINT[Parent_pk]  PRIMARY KEY IDENTITY(1,1),
		 Parent_name VARCHAR(255) NOT NULL,
		 Parent_date DATE NOT NULL,
		 );

		 DROP TABLE [HR].[Parent];


		 CREATE TABLE [HR].[Parent]
		(

		 [Parent_id] INT  CONSTRAINT[Parent_pk]  PRIMARY KEY IDENTITY(1,1),
		 [Parent_name] VARCHAR(255) NOT NULL,
		 [Parent_date] DATE NOT NULL,
		 );

		 CREATE TABLE[HR].[Child]
		 (
		 Child_id INT, Parent_id INT,
		 PRIMARY KEY(Parent_id,Child_id)
		 );


		 --HOW TO CHECK YOUR DEFAULT CONSTRAINT NAME WHEN YOU DON'T DEFINE CONSTRAINT NAME

		  SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
		  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		  WHERE TABLE_NAME ='Child';
		   
		   -- RENAME YOUR DEFALUT CONSTRAINT NAME
		  EXEC sp_rename 'HR.PK__Child__57D76F590177112D' ,'child_pk';


		   CREATE TABLE [HR].[Events]
		   (
		   [event_id] INT NOT NULL,
		   [event_name] VARCHAR(255),
		   [start_date] DATE NOT NULL,
		   [duration] DEC(5,2)
		   );


		   DROP TABLE[HR].[Events]


		     CREATE TABLE [HR].[Events]
		   (
		   [event_id] INT NOT NULL,
		   [event_name] VARCHAR(255),
		   [start_date] DATE NOT NULL,
		   [duration] DEC(5,2)
		   );
		   

		  ALTER TABLE  [HR].[Events] ADD CONSTRAINT [event_pk] PRIMARY KEY(event_id);



		  CREATE TABLE [HR].[Vendor_group]
		  (
		  [group_id] INT CONSTRAINT[group_pk] PRIMARY KEY IDENTITY(1,1),
		  [group_name] VARCHAR(50) NOT NULL
		  );

		  INSERT INTO [HR].[Vendor_group] ([group_name])
		  VALUES('Skyblue'),
		       ('Challenger'),
			   ('Dreambig');

			   SELECT * FROM [HR].[Vendor_group];

		  CREATE TABLE[HR].[Vendor]
		  (
		  [vendor_id] INT CONSTRAINT[vendor_pk] PRIMARY KEY IDENTITY(1,1),
		  [vendor_name] VARCHAR(50) ,
		  [group_id] INT NOT NULL
		  CONSTRAINT [fk_group] FOREIGN KEY ([group_id]) REFERENCES [HR].[Vendor_group]([group_id])
		  ON DELETE CASCADE 
		  );
  
         INSERT INTO [HR].[Vendor] ([vendor_name],[group_id])
		  VALUES('MCC',2),
		       ('TCS',3),
			   ('CTS',4);

			  		
	SELECT * FROM [HR].[Vendor];
	SELECT * FROM [HR].[Vendor_group]
	DELETE  FROM [HR].[Vendor_group] WHERE  [group_id]= 2;


	DROP TABLE [HR].Vendor

	ALTER TABLE[HR].[Vendor_group] 
	ADD CONSTRAINT fk_constraint  FOREIGN KEY(group_id)
	REFERENCES [HR].[Vendor_group](group_id)
	ON UPDATE SET NULL

	ALTER TABLE [HR].[Vendor] DROP CONSTRAINT fk_group;

	  CREATE TABLE[HR].[Vendor]
		  (
		  [vendor_id] INT CONSTRAINT[vendor_pk] PRIMARY KEY IDENTITY(1,1),
		  [vendor_name] VARCHAR(50) ,
		  [group_id] INT NOT NULL
		  CONSTRAINT [fk_group] FOREIGN KEY ([group_id]) REFERENCES [HR].[Vendor_group]([group_id])
		  ON  UPDATE CASCADE ON DELETE CASCADE 
		  );
  
	UPDATE  [HR].[Vendor_group] SET group_name = 'Royal' WHERE group_id = 3;
	SELECT * FROM [HR].[Vendor];
	SELECT * FROM [HR].[Vendor_group];
	
	--If I already define Identity but Still I want to give it manually then we have to do this following--

Set IDENTITY_INSERT [HR].[Vendor] OFF



--If we want current date and time--
SELECT getdate()
SELECT FORMAT(getdate(),'dd/MM/yyyy')
SELECT ASCII('A')
SELECT ASCII('a')
SELECT ASCII('#')
SELECT ASCII(' ')

-- A temporary table--
		     CREATE TABLE [HR].[Product]
		   (
		   [product_id] INT NOT NULL,
		   [product_name] VARCHAR(255),
		   [start_date] DATE NOT NULL,
		   [duration] DEC(5,2),
		   [City] VARCHAR(20) NOT NULL,
		   [Marks] INT NOT NULL
		   );
		   


   CREATE TABLE [HR].[Project]
		   (
		   [project_id] INT NOT NULL,
		   [project_name] VARCHAR(255),
		   [City] VARCHAR(20) NOT NULL,
		   [Marks] INT NOT NULL
		   );

		   INSERT INTO  [HR].[Project]
		   SELECT [City],[Marks]
		   FROM [HR].[Product]
		   
		   
		   CREATE TABLE excel
		  (
		   [excel_id] INT CONSTRAINT [Singere_pk]  PRIMARY KEY,
		   [excel_Name] VARCHAR(20),
		   [Age] INT NOT NULL,
		   [Marks] INT NOT NULL
		   );

		   

		     CREATE TABLE [HR].[excel]
		  (
		   [excel_id] INT CONSTRAINT [excel_pk]  PRIMARY KEY,
		   [excel_Name] VARCHAR(20),
		   
		   );
		   DROP TABLE excel

		   BULK INSERT [HR].[excel]
		   FROM 'D:\Excel.csv' 
		   with (
		   FieldTerminator =',',
		   RowTerminator='\n',
		   FirstRow = 2
		   )
		 
		 SELECT * FROM [HR].[excel]


		 --HANDS-ON ON 22/01/2024

		 --Rename the table name
		 EXEC sp_rename '[HR].[Project]' , '[HR].[NewProject]'

		 
		 -- EXEC sp_rename  'HR.[[HR].[NewProject]]', '[Project]'

			--Rename Column Name
		EXEC sp_rename '[HR].[Events].[event_name]','e_name','COLUMN';


		--Group by and Order By
		USE [BikeStores]

		SELECT city, COUNT(*)
		FROM sales.customers 
		WHERE state = 'ca' collate sql_latin1_general_cp1_cs_as
		GROUP BY city
		ORDER BY city;


		--USING HAVAING CLAUSE
		SELECT city, COUNT(phone)
		FROM sales.customers 
		WHERE state = 'CA'
		GROUP BY city
		HAVING COUNT(*)>10
		ORDER BY city;

		--ORDER BY 
		SELECT city,first_name,last_name
		FROM sales.customers
		ORDER BY city,first_name;


		 --City DESC AND  with respect to City ,first_name ASC
	    SELECT city,first_name,last_name
		FROM sales.customers
		ORDER BY city DESC,first_name ASC;

		--Legth--
		SELECT city,first_name,last_name
		FROM sales.customers
		ORDER BY LEN(first_name) DESC;

 ---SUM() Aggregate function

 	  --  SELECT [first_name],[last_name] LEN([first_name)]
		--FROM sales.customers
		---ORDER BY LEN(first_name) DESC 


	
	-- TOTAL NAME WITH CONCAT
 	     SELECT [first_name],[last_name], LEN(CONCAT((first_name),(last_name)))
		FROM sales.customers
		ORDER BY LEN (CONCAT((first_name),(last_name))) DESC;


		--OFFSET AND FETCH 
		--OFFSET MEANS STARTING NUMBER AND FETCH MEANS LIMIT
		
		SELECT product_name ,list_price
		FROM production.products
		ORDER BY list_price, product_name
		OFFSET 20 ROWS
		FETCH NEXT 10 ROWS ONLY;


		--TOP 10 means 10 LIMIT AND THEN IT WILL SHOW list_price FROM HIGHER TO LOWER
		SELECT TOP 10 product_name, list_price
		FROM  production.products
		ORDER BY list_price DESC


		SELECT city
		FROM sales.customers
		ORDER BY city;


		--DISTINCT ONE COLUMN
		SELECT DISTINCT city 
		FROM sales.customers
		ORDER BY city;

		-- DISTINCT MULTIPLE COLUMNS--

		SELECT DISTINCT city,state 
		FROM sales.customers
		ORDER BY city;

		--WE CAN EITHER WRITE IT LIKE THIS
		SELECT city,state,zip_code
		FROM sales.customers
		GROUP BY city, state,zip_code
		ORDER BY city,state, zip_code

		--OR WE CAN WRITE IT LIKE THIS 
		--BOTH ARE SAME 
		--BUT DISTINCT IS FAST THAN GROUP BY ORDER BY BECAUSE GROUP BY ORDER BY IS DESIGNED FOR AGGREGATE FUNCTION
		SELECT DISTINCT city, state,zip_code 
		FROM sales.customers

		--IN--
		SELECT product_id, product_name, category_id, model_year, list_price
		FROM production.products
		WHERE product_name LIKE 'Cruiser' collate sql_latin1_general_cp1_cs_as
		ORDER BY list_price;

		SELECT * FROM [production].[products]


		SELECT product_name, brand_id,list_price
		FROM production.products
		WHERE brand_id = 1 
		OR brand_id= 2
		AND list_price>500
		ORDER BY brand_id DESC , list_price;



		--EITHER I CAN WRITE LIKE THIS
		SELECT store_id, product_id 
		FROM production.stocks
		WHERE store_id= 1 AND quantity >=30;

		--OR I CAN WRITE LIKE THIS
		--BOTH ARE SAME
		SELECT product_name, list_price 
		FROM production.products
		WHERE product_id IN (SELECT product_id FROM production.stocks WHERE store_id= 1 AND quantity >=30)
		ORDER BY product_name;


		-- COlumn Alias and Table Alias
		SELECT category_name'Product Category'
		FROM production.categories;

		 -- SET ALIAS NAME AND INNER JOIN
		SELECT C.customer_id , first_name, last_name, order_id
		FROM sales.customers AS C
		INNER JOIN sales.orders   AS O ON 
		O.customer_id = C.customer_id;


		--CASE EXPRESSION

		SELECT   SUM(CASE WHEN order_status =1 THEN 1 ELSE 0 END) AS 'Pending',
		         SUM(CASE WHEN order_status =2 THEN 1 ELSE 0 END) AS 'Processing',
		         SUM(CASE WHEN order_status =3 THEN 1 ELSE 0 END) AS 'Rejected',
				 SUM(CASE WHEN order_status =4 THEN 1 ELSE 0 END) AS 'Completed',

				 COUNT (*) AS Total
				 FROM sales.orders
				 WHERE YEAR(order_date) = 2018;

--The following statement uses the searched CASE expression sales order by order value:

SELECT O.order_Id, SUM(quantity*list_price) order_value,

CASE WHEN  SUM(quantity*list_price)<=500
     THEN 'Very Low'

     WHEN  SUM(quantity*list_price)>500 AND 
     SUM(quantity*list_price)<=1000
     THEN 'Low'

     WHEN  SUM(quantity*list_price)>1000 AND 
     SUM(quantity*list_price)<=5000
     THEN 'Medium'

     WHEN  SUM(quantity*list_price)>5000 AND 
     SUM(quantity*list_price)<=10000
     THEN 'High'

     WHEN  SUM(quantity*list_price)>10000
     THEN 'Very High'

   END order_priority
   FROM sales.orders O INNER JOIN sales.order_items I ON I.order_id = O.order_id
   WHERE YEAR(order_date) =2018
   GROUP BY O.order_id;


   -- MARGE STATEMENT--

   --TARGET TABLE
   CREATE TABLE  sales.category --Target Table
   (
   category_id INT PRIMARY KEY,
   category_name VARCHAR(255) NOT NULL,
   amount DECIMAL(10,2)
   );

    INSERT INTO sales.category([category_Id],[category_name],[amount])
   VALUES(1,'Children Bicycles', 15000),
   (3,'Cruisers Bicycles', 35000),
    (4,'Cyclocross Bicycles', 20000);
	
	-- SOURCE TABLE
   CREATE TABLE  sales.category_staging --Source Table
   (
   category_id INT PRIMARY KEY,
   category_name VARCHAR(255) NOT NULL,
   amount DECIMAL(10,2)
   );

   INSERT INTO sales.category_staging([category_Id],[category_name],[amount])
   VALUES(1,'Children Bycycles', 15000),
   (3,'Cruisers Bicycles', 35000),
    (4,'Cyclocross Bicycles', 20000),
	 (5,'Electric Bikes', 10000),
	  (6,'Mountain Bikes', 10000);


   MERGE sales.category t USING sales.category_staging s ON (s.category_id = t.category_id)

   WHEN MATCHED THEN 
     
	 UPDATE SET t.category_name = s.category_name,t.amount =s.amount
	 WHEN NOT MATCHED BY TARGET THEN
	 INSERT(category_id, category_name, amount) 
	 VALUES(s.category_id,s.category_name,s.amount)
	 WHEN NOT MATCHED BY SOURCE THEN
	 DELETE;


	 SELECT * FROM sales.category;
	 SELECT * FROM sales.category_staging



	 -- LEFT JOIN:Condition in ON vs WHERE clause

	 SELECT product_name, order_id
	 FROM production.products p LEFT JOIN sales.order_items o
	 ON o.product_id = p.product_id
	 WHERE order_id =100
	 ORDER BY order_id;
	 
	-- Let's move the condition order_id =100 to the ON Clause

	SELECT p.product_id,product_name,order_id
	FROM production.products p
	LEFT JOIN sales.order_items o ON o.product_id = p.product_id AND o.order_id =100
	ORDER BY order_id DESC;

	SELECT * FROM [sales].[order_items] WHERE order_id =100  --Right Table

	SELECT * FROM [production].[products] --Left Table


	-- LEFT JOIN --

		CREATE SCHEMA hr;
GO

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);



INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');


	SELECT * FROM [hr].[candidates]	
	SELECT * FROM [hr].[employees]	


	--INNER JOIN
	SELECT c.id, c.fullname,e.id,e.fullname
	FROM [hr].[candidates] c
	INNER JOIN hr.employees  e 
	ON c.id = e.id;

	--LEFT JOIN 
	SELECT c.id ,c.fullname,e.id ,e.fullname
	FROM [hr].[candidates] c 
	LEFT JOIN hr.employees e 
	ON c.id = e.id;

	--RIGHT JOIN
	SELECT c.id ,c.fullname,e.id ,e.fullname
	FROM [hr].[candidates] c 
	RIGHT JOIN hr.employees e 
	ON c.id = e.id;

	--FULL OUTER JOIN
	SELECT c.id ,c.fullname,e.id,e.fullname
	FROM [hr].[candidates] c 
	FULL OUTER JOIN hr.employees e 
	ON c.id = e.id;


	--PRACTICE --

	--GROUP BY--
   SELECT customer_id, YEAR (order_date) AS order_year
   FROM sales.orders
   WHERE customer_id IN (1, 2)
   ORDER BY customer_id;


   --EITHER THIS--
 SELECT customer_id, YEAR (order_date) AS order_year
FROM sales.orders
WHERE customer_id IN (1, 2)
GROUP BY customer_id, YEAR (order_date)
ORDER BY customer_id;


--USING DISTINCT KEYWORD--
--OR THIS
SELECT DISTINCT
    customer_id,YEAR (order_date) AS order_year
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id;

	--GROUP BY AND AGREGATE FUNCTION--

 SELECT customer_id, YEAR (order_date) AS order_year, COUNT (order_id) AS order_placed
FROM sales.orders
WHERE customer_id IN (1, 2)
GROUP BY customer_id,YEAR (order_date)
ORDER BY customer_id; 

--MARGE STATEMENT--

--MERGE target_table USING source_table
--ON merge_condition
--WHEN MATCHED
  --  THEN update_statement
--WHEN NOT MATCHED
   --THEN insert_statement
--WHEN NOT MATCHED BY SOURCE
    --THEN DELETE;


	CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);

INSERT INTO sales.category(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (2,'Comfort Bicycles',25000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',10000);


--CREATE TABLE sales.category_staging (
--    category_id INT PRIMARY KEY,
--    category_name VARCHAR(255) NOT NULL,
--    amount DECIMAL(10 , 2 )
--);


--CREATE TABLE sales.category (
--    category_id INT PRIMARY KEY,
--    category_name VARCHAR(255) NOT NULL,
--    amount DECIMAL(10 , 2 )
--);

--INSERT INTO sales.category(category_id, category_name, amount)
--VALUES(1,'Children Bicycles',15000),
--    (2,'Comfort Bicycles',25000),
--    (3,'Cruisers Bicycles',13000),
--    (4,'Cyclocross Bicycles',10000);


--CREATE TABLE sales.category_staging (
--    category_id INT PRIMARY KEY,
--    category_name VARCHAR(255) NOT NULL,
--    amount DECIMAL(10 , 2 )
--);


--INSERT INTO sales.category_staging(category_id, category_name, amount)
--VALUES(1,'Children Bicycles',15000),
--    (3,'Cruisers Bicycles',13000),
--    (4,'Cyclocross Bicycles',20000),
--    (5,'Electric Bikes',10000),
--    (6,'Mountain Bikes',10000);


-- HANDS ON 23/01/2024

--CROSS JOIN

SELECT s.store_id, p.product_id,
ISNULL(sales, 0) sales
FROM sales.stores s
CROSS JOIN production.products p

LEFT JOIN (
SELECT s.store_id, p.product_id, SUM (quantity * i.list_price) sales -- C TABLE
FROM sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id  -- C TABLE
INNER JOIN sales.stores s ON s.store_id = o.store_id -- C TABLE
INNER JOIN production.products p ON p.product_id = i.product_id -- C TABLE
GROUP BY s.store_id, p.product_id -- C TABLE
) c ON c.store_id = s.store_id AND c.product_id = p.product_id 
WHERE sales IS NULL
ORDER BY product_id, store_id;


--SELF JOIN--
CREATE TABLE [HR]. [Emp]
(
[Emp_id] INT CONSTRAINT[Emp_pk] PRIMARY KEY,
[Emp_Name] VARCHAR(30),
[Manager_id] INT FOREIGN KEY REFERENCES [HR].[Emp]([Emp_id])
);

INSERT INTO [HR].[Emp] ([Emp_id],[Emp_name],[Manager_id])
VALUES(1,'A',NULL),
       (2,'B',1),
	   (3,'C',1),
	   (4,'D',2),
	   (5,'E',3),
	   (6,'F',2),
	   (7,'G',3),
	   (8,'H',5);

	   SELECT  e.[Emp_Name] AS 'EMPLOYEE'  ,m.[Emp_name] AS 'MANAGER NAME'
	   FROM [HR].[Emp]  AS e  --Left Table
	   INNER JOIN [HR].[Emp]  AS m -- Right Table
	   ON e.[Manager_id] = m.[Emp_id];
	  

	  --IF I WANT TO KNOW WHICH EMPLOYEE'S MANAGER ID IS NULL -- we have to do left join
	  SELECT  e.[Emp_Name] AS 'EMPLOYEE'  ,m.[Emp_name] AS 'MANAGER NAME'
	   FROM [HR].[Emp]  AS e
	   LEFT JOIN [HR].[Emp]  AS m 
	   ON e.[Manager_id] = m.[Emp_id];
	  

	   SELECT * FROM [HR].[Emp];

	    --UPDATE JOIN--

		
		CREATE TABLE [sales].[target]
		(
		[target_id] INT PRIMARY KEY,
		[percentage] DECIMAL(4,2) NOT NULL DEFAULT 10,
		);

		INSERT INTO [sales].[target] ([target_id], [percentage])
		VALUES(1,0.2),(2,0.3),(3,0.5),(4,0.6),(5,0.8);

		SELECT * FROM [sales].[target]


CREATE TABLE sales.commissions (
staff_id INT PRIMARY KEY,
target_id INT,
base_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
commission DECIMAL(10, 2) NOT NULL DEFAULT 0,
  CONSTRAINT [target_fk] FOREIGN KEY(target_id) REFERENCES sales.target(target_id),
FOREIGN KEY(staff_id) REFERENCES sales.staffs(staff_id) 
);


		INSERT INTO [sales].[commissions] ([staff_id],[base_amount],[target_id])
		VALUES(1,100000,2),(2,120000,1),(3,80000,3),(4,900000,4);

		SELECT * FROM [sales].[commissions]

UPDATE sales.commissions
SET sales.commissions.commission = c.base_amount * t.percentage
FROM sales.commissions c INNER JOIN sales.target t
ON c.target_id = t.target_id;

SELECT * FROM [sales].[target]
SELECT * FROM [sales].[commissions]

--UPDATE LEFT JOIN--
	INSERT INTO [sales].[commissions] ([staff_id],[base_amount],[target_id])
		VALUES(6,100000,NULL),(7,120000,NULL);

UPDATE [sales].[commissions] SET [sales].[commissions].commission = c.[base_amount] * COALESCE(t.percentage,0.1)
FROM sales.commissions c LEFT JOIN sales.target t ON c.[target_id] = t.[target_id];

CREATE TABLE [HR].[Product]
(
[product_id] INT PRIMARY KEY,
[product_name] VARCHAR(30) NOT NULL 
);

INSERT INTO [HR].[Product] ([product_id],[product_name])
VALUES(1,'Shampoo'),
(2,'Soap'),
(3,'HairOil'),
(4,'BodyLotion');

SELECT * FROM [HR].[Product]

CREATE TABLE [HR].[OrderItem]
(
[order_id] INT PRIMARY KEY,
[order_date] DATE NOT NULL,
[product_id] INT FOREIGN KEY
REFERENCES [HR].[Product]([product_id])
);

DROP TABLE [HR].[OrderItem]

INSERT INTO [HR].[OrderItem] ([order_id],[order_date],[product_id])
VALUES(1,'2024-01-20',2),
(2,'2024-01-21',4),
(3,'2024-01-22',3),
(4,'2024-01-23',1);

SELECT * FROM [HR].[OrderItem];
SELECT * FROM [HR].[Product];

DELETE [HR].[OrderItem]
FROM [HR].[OrderItem] o
JOIN [HR].[Product] p
ON o.[product_id] = p.[product_id]
WHERE order_id = '2'


USE  [PracticeDB];

--1st Answer
SELECT [FirstName], [Phone] ,[OrderNumber],[TotalAmount]
FROM [dbo].[Customer]  AS c
JOIN [dbo].[Order] AS o
ON o.CustomerId = c.Id
WHERE [TotalAmount] >2000;

--2 nd Answer
SELECT [FirstName],[City],[Country]
FROM [dbo].[Customer] AS c 
WHERE [Country] =( SELECT [Country] FROM  [dbo].[Customer] WHERE [FirstName]= 'Rita'
collate sql_latin1_general_cp1_cs_as)


-- 3 rd Answer
SELECT [CompanyName],[City],[Country]
FROM [dbo].[Supplier] AS s
JOIN [dbo].[Product] AS p
ON s.Id = p.SupplierId
WHERE IsDiscontinued = 1


-- 4 th Answer
SELECT [OrderId],[OrderDate],[TotalAmount]
FROM [dbo].[Order] AS o
JOIN [dbo].[OrderItem] AS oi
ON  o.Id = oi.OrderId 
WHERE (oi.UnitPrice * oi.Quantity) = 0

-- 5 th Answer

SELECT [FirstName],[OrderNumber],[Quantity]
FROM [dbo].[Customer] AS c
JOIN [dbo].[Order] AS o 
ON c.id = o.CustomerId
JOIN [dbo].[OrderItem] AS oi 
ON oi.OrderId = o.Id

-- 6 th QUESTION

SELECT[OrderNumber],[FirstName], COUNT(*) AS 'TOTAL ORDERS'
FROM [dbo].[Customer] AS c
JOIN [dbo].[Order] AS o 
ON c.id = o.CustomerId
JOIN [dbo].[OrderItem] AS oi 
ON oi.OrderId = o.Id
GROUP BY [OrderNumber],[FirstName]
 

 --7 th Answer
SELECT [FirstName],[LastName],[City]
FROM [dbo].[Customer]
WHERE [FirstName] LIKE '%th';

-- 8 th Answer
USE [BikeStores]

SELECT [store_name],[city],[product_name] [quantity]
FROM [sales].[stores] AS s
JOIN [production].[stocks] AS ps
ON s.store_id = ps.store_id
JOIN[production].[products] AS pp
ON pp.product_id = ps.product_id

-- 9th Answer
 SELECT s.[First_Name] as Staff,m.[First_Name] as [ManagerName]
 FROM [sales].[staffs] AS s
 LEFT JOIN [sales].[staffs] as  m
 ON s.manager_id =m.staff_id

 --HANDS-ON ON 24/01/2024
 USE [BikeStores]

  SELECT category_name ,cast(round(avg(list_price),2)AS DEC(10,2))  AS 'average_list_price'
  FROM [production].[products] AS pp
  INNER JOIN [production].[categories] AS pc
  ON pp.[category_id] = pc.[category_id]
  GROUP BY [category_name]
  HAVING cast(round(avg(list_price),2)AS DEC(10,2)) >500 -- Either I can write like this
  ORDER BY [category_name]

   SELECT category_name ,cast(round(avg(list_price),2)AS DEC(10,2))  AS 'average_list_price'
  FROM [production].[products] AS pp
  INNER JOIN [production].[categories] AS pc
  ON pp.[category_id] = pc.[category_id]
  GROUP BY [category_name]
  HAVING AVG(list_price) >500 --Or simply write can this
  ORDER BY [category_name]

  SELECT COUNT(*) product_count 
  FROM [production].[products]
  WHERE list_price>500

  SELECT * INTO [HR].[Employee_tbl]
  FROM [HRDB].[dbo].[employees]

  SELECT * FROM [HR].[Employee_tbl]


  SELECT [department_id], SUM(Salary) AS TotalSalary,
  COUNT(*) AS TotalEmployee
  FROM [HR].[Employee_tbl]
  GROUP BY department_id


  --HOW MANY EMPLOYEES ARE WORKING UNDER EACH AND EVERY MANAGER
  
  SELECT [manager_id],
  COUNT(employee_id) AS TotalEmployee
  FROM [HR].[Employee_tbl]
  GROUP BY [manager_id]

SELECT * FROM [HR].[Employee_tbl]
  --SHOW MANAGER NAME
  SELECT m.first_name ,
  COUNT(e.employee_id) AS TotalEmployee
  FROM [HR].[Employee_tbl] AS e
  JOIN [HR].[Employee_tbl] AS m
  ON m.employee_id = e.manager_id
  GROUP BY m.first_name

  --DISPLAY THE CUSTOMER ID --
  SELECT customer_id , YEAR(order_date) order_year,
  COUNT(order_id)  AS order_placed
  FROM sales.orders
  WHERE customer_id IN(1,2)
  GROUP BY customer_id ,YEAR(order_date)
  ORDER BY customer_id;

  --DISPLAY THE CUSTOMER NAME INSTEAD OF CUSTOMER ID


  SELECT sc.first_name, YEAR(order_date) order_year,
  COUNT(order_id) AS order_placed 
  FROM sales.orders AS so 
  JOIN sales.customers AS sc
  ON sc.customer_id = so.customer_id
  WHERE sc.customer_id IN(1,2)
  GROUP BY sc.first_name ,YEAR(order_date)


 -- 1 ST--
 SELECT d.department_name 
 FROM [dbo].[departments]  AS d
 LEFT JOIN [dbo].[employees] as e
 ON e.department_id = d.department_id
 WHERE e.employee_id IS NULL
 


  --2 ND
 SELECT first_name, last_name, salary
 FROM [dbo].[employees]
 WHERE salary 
 <(SELECT salary FROM [dbo].[employees] WHERE employee_id = 192)

 --3RD 
 SELECT first_name,last_name
 FROM [dbo].[employees]
 WHERE department_id =
 (SELECT department_id  FROM [dbo].[employees] WHERE last_name ='Taylor')

 --4th
 SELECT employee_id ,first_name, last_name
 FROM [dbo].[employees]
 WHERE hire_date  BETWEEN '1993-1-1' AND '1997-8-31'

 --5th

  --SELECT department_name , AVG(salary), COUNT(employee_id) 
  --FROM [dbo].[employees]  AS  e
  --JOIN [dbo].[departments]  AS d
  --ON e.department_id = d.department_id
  --WHERE 

  --SELECT  DISTINCT department_name 
  --FROM [dbo].[departments] AS d
  --JOIN [dbo].[employees] AS e
  --ON d.department_id = e.department_id
  --JOIN [dbo].[locations] AS l
  --ON 
  --WHERE employee_id >=2

  --6TH--
  SELECT country_name,department_name,
  COUNT(e.employee_id) AS No_of_Employees
  FROM [dbo].[countries] AS c
  INNER JOIN [dbo].[locations] AS l
  ON c.country_id = l.country_id
  INNER JOIN [dbo].[departments] AS d
  ON d.location_id = l.location_id
  INNER JOIN [dbo].[employees] AS e
  ON d.department_id = e.department_id
  GROUP BY country_name, department_name
  HAVING COUNT(e.employee_id)>=2


   --7TH --How to get difference between two date

  
   SELECT datediff(dd,'2024-1-10',getdate())

   --8th--
   --Write a query to display the highest salary in each department
   SELECT department_name,  Max(salary) AS 'Highest_salary'
   FROM [dbo].[departments] AS d
   JOIN [dbo].[employees] AS e
   ON d.department_id = e.department_id
   GROUP BY department_name 

   --9 th--
   --Write a query to display employee name, department name,country name whose joining date is year 1997

   SELECT first_name,department_name,country_name
   FROM [dbo].[countries] AS c
   JOIN [dbo].[locations] AS l
   ON  l.country_id = c.country_id
   JOIN [dbo].[departments] AS d
   ON d.location_id = l.location_id
   JOIN [dbo].[employees] AS e
   ON e.department_id = d.department_id
   WHERE YEAR(hire_date) = '1997'
 
 --10TH--
 --Write a query to display region name ,job title,and number of employee against each region
 SELECT region_name, job_title ,COUNT(e.employee_id)
 FROM [dbo].[regions] AS r
 JOIN [dbo].[countries] AS c
 ON c.region_id = r.region_id
 JOIN [dbo].[locations] AS l
 ON l.country_id = c.country_id
 JOIN [dbo].[departments] AS d
  ON d.location_id = l.location_id
 JOIN [dbo].[employees] AS e
 ON e.department_id = d.department_id
 JOIN [dbo].[jobs] AS j
 On j.job_id = e.job_id
 GROUP BY region_name, job_title


 -- HANDS-ON ON 25/01/2024

 --NESTED SUBQUERY
 --Either we can write like this

 SELECT [order_id],[order_date],[sales].[orders].[customer_id ]
 FROM [sales].[orders]
 WHERE [customer_id] IN
 (SELECT [customer_id] FROM sales.customers WHERE city = 'New York')
 ORDER BY [order_date] DESC;

 --USING JOIN 
 --Or we can write like this
 SELECT order_id,order_date, o.customer_id
 FROM [sales].[orders] AS o
 FULL JOIN [sales].[customers] AS c
 ON o.customer_id = c.customer_id
WHERE city ='New York'
 ORDER BY [order_date] DESC;

 --DISPLAY THE PRODUCT NAME AND THOSE LIST PRICE WHOSE brand_name  = 'Strider' OR brand_name ='Trek'
 --AND LIST PRICE HAS TO BE MORE THAN OF AVERAGE list_price

 SELECT product_name,list_price FROM [production].[products] WHERE list_price>
 (SELECT AVG(list_price) FROM [production].[products] WHERE brand_id IN 
 (SELECT [brand_id] FROM [production].[brands] WHERE brand_name='Strider' OR brand_name ='Trek'))

 -- SAME USING JOIN
 SELECT product_name, list_price
 FROM [production].[products] AS pp
 JOIN [production].[brands] AS pb
 ON pp.brand_id = pb.brand_id 
 WHERE list_price>
 (select AVG(list_price) from production.products where brand_id in (SELECT [brand_id] FROM [production].[brands] 
 WHERE brand_name='Strider' OR brand_name ='Trek'))
 
 
 USE BikeStores

 -- WRITE A QUERY TO DISPLAY CUSTOMER NAME, EMAIL, CITY, WHERE CIYT = PORT WASHINGTON

(SELECT first_name,email,city
FROM [sales].[customers]  
WHERE city = 'PORT WASHINGTON')

--DISPLAY PRODUCT NAME WHERE CIYT = PORT WASHINGTON

SELECT product_name FROM [production].[products] 
WHERE product_id IN (SELECT product_id FROM [sales].[order_items]
WHERE order_id IN (SELECT order_id FROM [sales].[orders]
WHERE customer_id IN (SELECT customer_id FROM [sales].[customers] WHERE city ='Port Washington')))



 --Write a query to display customer name ,email,city,product_name Where city is belongs to  PORT Washington

 --USING JOIN 
 
 SELECT first_name,email,city,product_name
 FROM [sales].[customers] AS c
 JOIN [sales].[orders] AS o
 ON c.customer_id = o.customer_id
 JOIN [sales].[order_items] AS so
 ON so.order_id = o.order_id
 JOIN [production].[products] AS pp
 ON pp.product_id = so.product_id
 WHERE city = 'Port Washington'
 ORDER BY first_name DESC

 --Subquery Using ANY operator

 SELECT product_name,list_price
 FROM [production].[products]
 WHERE list_price >= ANY(SELECT AVG(list_price) FROM production.products GROUP BY brand_id)
 ORDER BY list_price

  SELECT list_price
  FROM [production].[products]
  WHERE list_price >= ANY(SELECT AVG(list_price) FROM production.products GROUP BY brand_id)
  ORDER BY list_price


   SELECT list_price,product_name
  FROM [production].[products]
  WHERE list_price >= ANY(SELECT MIN(list_price) FROM production.products GROUP BY brand_id)
  ORDER BY list_price

  
   SELECT list_price,product_name
  FROM [production].[products]
  WHERE list_price >= ANY(SELECT MAX(list_price) FROM production.products GROUP BY brand_id)
  ORDER BY list_price

   --Subquery Using ALL operator
 SELECT product_name,list_price
 FROM [production].[products]
 WHERE list_price >= ALL(SELECT AVG(list_price) FROM production.products GROUP BY brand_id)
 --ORDER BY list_price

 --Subquery with Exists or Not Exists  

 SELECT customer_id,first_name, last_name, city
 FROM [sales].[customers] AS c
 WHERE EXISTS 
 (SELECT customer_id FROM [sales].[orders] AS o 
 WHERE o.customer_id = c.customer_id AND YEAR(order_date)=2017)

 ORDER BY first_name, last_name

 --Correlated Subquery
 SELECT product_name,list_price ,category_id
 FROM [production].[products]  AS p1 
 WHERE list_price IN (SELECT MAX(p2.list_price)
 FROM [production].[products]  AS p2
 WHERE p2.category_id = p1.category_id
 GROUP BY category_id)
 ORDER BY category_id,product_name

 --PRACTICE QUESTIONS ON CORRELATED SUBQUERY--

 USE HRDB
 --Write a query to display Employee name, salary and hire date who have joined in same year

 SELECT first_name, salary ,YEAR(hire_date) AS hire_date
 FROM [dbo].[employees] AS e1
 WHERE YEAR(hire_date) IN(SELECT YEAR( e1.hire_date)
 FROM [dbo].[employees] AS e2
 WHERE YEAR(e1.hire_date)= YEAR(e2.hire_date)
 GROUP BY YEAR(e2.hire_date)
 HAVING COUNT(*)>=10)
 ORDER BY YEAR( hire_date)


 --Write a query to display ,Employee id ,Employee name,
 --salary whose salary is greater than
 --avg salary in their department

 SELECT employee_id, first_name, salary 
 FROM [dbo].[employees]  AS e1
 WHERE  Salary > (SELECT AVG(salary)
 FROM [dbo].[employees] AS  e2
 WHERE e1.department_id = e2.department_id)


 --PRACTICE--
 --MERGE STATEMENT--
 DROP TABLE [HR].[newsourceone]
 CREATE TABLE [HR].[newsourceone]
 (
 [id] INT CONSTRAINT[newsourceone_pk] PRIMARY KEY IDENTITY(1,1),
 [name] VARCHAR(20),
 [city] VARCHAR(30),
 );

 INSERT INTO [HR].[newsourceone]([name],[city])
 VALUES('Anwesha','Bankura'),
 ('Susmita','Digha'),
 ('Pushpa','Murshidabad'),
 ('Antara','Bishnupur');

 SELECT * FROM [HR].[newsourceone]

 DROP TABLE [HR].[newtargetone]

 CREATE TABLE [HR].[newtargetone]
 (
 [id] INT CONSTRAINT[newtargetone_pk] PRIMARY KEY IDENTITY(1,1),
 [name] VARCHAR(20),
 [city] VARCHAR(30),
 );

 INSERT INTO [HR].[newtargetone]([name],[city])
 VALUES('Manisha','NEW YORK'),
 ('Bandita','AUSTRALIA'),
 ('Chandana','UK'),
 ('Chanchal','USA');
 
  SELECT * FROM [HR].[newtargetone]

 MERGE INTO [HR].[newtargetone] AS t
 USING [HR].[newsourceone] AS s
 ON s.id = t.id
 WHEN MATCHED THEN
 UPDATE SET t.[name] = s.[name] , t.[city] =s.[city]
 WHEN NOT MATCHED BY TARGET THEN
 INSERT([name],[city])
 VALUES(s.[name],s.[city])
 WHEN NOT MATCHED BY SOURCE THEN
 DELETE;
 SELECT * FROM [HR].[newtargetone]

 --MERGE STATEMENT--
 DROP TABLE [HR].[nsource]
 CREATE TABLE [HR].[nsource]
 (
 [id] INT CONSTRAINT[nsource_pk] PRIMARY KEY ,
 [name] VARCHAR(30), 
 [location] VARCHAR(30)
 );

 INSERT INTO [HR].[nsource] ([id],[name],[location])
 VALUES (1,'Anwesha','Bankura'),
 (2,'Mandira','Bankura'),
 (3,'Aditi','Bankura'),
 (4,'Bandita','Bankura'),
 (5,'Shalini','Bankura');
 
 DROP TABLE [HR].[ntarget]
  CREATE TABLE [HR].[ntarget]
 (
 [id] INT CONSTRAINT[ntarget_pk] PRIMARY KEY ,
 [name] VARCHAR(30), 
 [location] VARCHAR(30)
 );

 INSERT INTO [HR].[ntarget] ([id],[name],[location])
 VALUES (1,'Shyamal','Bishnupur'),
 (2,'Krishna','Bishnupur'),
 (3,'Arjun','Bishnupur'),
 (6,'Subhadra','Bishnupur'),
 (7,'Kunti','Bishnupur');

 MERGE INTO [HR].[ntarget] as t
 USING [HR].[nsource] as s
 ON t.id = s.id
 WHEN MATCHED THEN 
 UPDATE SET t.[id] = s.[id] ,t.[name] = s.[name], t.[location] = s.[location] 
 WHEN NOT MATCHED BY TARGET THEN
 INSERT([id] ,[name],[location]) VALUES (s.[id],s.[name] ,s.[location]) 
 WHEN NOT MATCHED BY SOURCE THEN 
 DELETE;


 --UPDATE AND DELETE USING JOIN --

      DROP TABLE [HR].[Student]

	   CREATE TABLE [HR].[Student]
	   (
	   [id] INT CONSTRAINT[student_pk] PRIMARY KEY IDENTITY(1,1),
	   [name] VARCHAR(20),
	   [location] VARCHAR(30),
	   );

	   INSERT INTO[HR].[Student] ([name],[location])
	   VALUES('Anwesha','Bankura'),
	   ('Sudipto','Durgapur'),
	   ('Anindita','Burdwan'),
	   ('Nilanjana','Bankura'),
	   ('Sanjana','Bishnupur');

	  --UPDATE AND DELETE JOIN --
	 

	   DROP TABLE [HR].[Teacher]

	  CREATE TABLE [HR].[Teacher]
	  (
	  [id] INT CONSTRAINT[teachers_pk] PRIMARY KEY IDENTITY(1,1),
	  [name] VARCHAR(20),
	  [salary] VARCHAR(20),
	  [Age] INT NOT NULL,
	  [Gender] CHAR(1) ,
	  [location] VARCHAR(20)
	  );

	  INSERT INTO [HR].[Teacher]
	  ([name],[salary],[Age],[Gender],[location])

	  VALUES('Riju',20000, 20,'M','KOLKATA'),
	  ('Mohor',30000, 22,'M','Bishnupur'),
	  ('Krishna',40000,25,'F','Bankura'),
	  ('Babu',10000,26,'M' ,'Murshidabad'),
	  ('Shyamal', 80000,50,'M','Bankura');
	  
	  SELECT * FROM [HR].[Student]
	  SELECT * FROM [HR].[Teacher]

	  --UPDATE JOIN--
	  UPDATE [HR].[Teacher] 
	  SET age = age+10
	  FROM [HR].[Teacher] as t
	  JOIN [HR].[Student] as s
	  ON t.[location] = s.[location]
	  WHERE t.[location] = 'Bankura'

	  -- DELETE JOIN --
	  DELETE [HR].[Teacher]
	  FROM [HR].[Teacher] as t
	  JOIN [HR].[Student] AS s
	  ON s.[location] = t.[location]
	  WHERE t.[location] = 'Bankura'

	  


	 --PRACTICE--

SELECT order_id, order_date,
( SELECT MAX (list_price) FROM sales.order_items I WHERE i.order_id = o.order_id
) AS max_list_price
FROM sales.orders o
order by order_date desc;



--HANDS-ON ON 29/01/2024

--Show difference between two dates as DD: HH:MM format.  

SELECT datediff(MINUTE,'2024/01/20','2024/01/22')
SELECT datediff(DAY,'2024/01/20','2024/01/22')
SELECT datediff(HOUR,'2024/01/20','2024/01/22')

SELECT CONCAT (
CAST(DATEDIFF(DAY,'2024/01/20','2024/01/22') AS VARCHAR(10)),
':',
CAST(DATEDIFF(HOUR,'2024/01/20','2024/01/22') AS VARCHAR(10)),
':',
CAST(DATEDIFF(MINUTE,'2024/01/20','2024/01/22') AS VARCHAR(10))
)

--SUPPOSE THERE ARE TWO TABLES STUDENTS AND COURSES ,STUDENT TABLE HAVE STUDENT_ID, STUDENT_NAME
--SUBJECT 
--COURSE TALBE TABLE COURSE ID ,COURSE NAME, STUDENT_ID ,COURSE_GRADE 
--YOU NEED TO GENERATE THE REPORT ON ABOUT STUDENT WHO HAVE ENROLLED IN ANY COURSE OR NOT ENROLLED IN ANY COURSE

--Answer--

--CREATE TABLE [HR].[Students] 
--(
--[Student_id] INT  CONSTRAINT[students_pk] PRIMARY KEY,
--[Student_name] VARCHAR(20),
--[Subject] VARCHAR(30),
--);

--INSERT INTO [HR].[Students]([Student_id],[Student_name],[Subject])
--VALUES(1,'Anwesha' ,'C#'),
--      (2,'Sudip','HTML'),
--	  (3,'Anuradha','CSS');

--	  DROP TABLE [HR].[Course]
--CREATE TABLE [HR].[Course] 
--(
--[course_id] INT  CONSTRAINT[course_pk] PRIMARY KEY,
--[course_name] VARCHAR(20),
--[course_grade] CHAR(1),
--[Student_id] INT FOREIGN KEY([Student_id]) 
--REFERENCES [HR].[Students]([Student_id])
--);

--INSERT INTO [HR].[Course]([course_id],[course_name],[course_grade],[Student_id])
--VALUES(1,'c# Introduction','A',2),
--      (2,'Entity','B',3),
--	  (3,'ID AND CLASS','C',null);

--	  SELECT CONCAT('Enrolled' ,c.student_name)
--	  FROM [HR].[Students] as s
--	   JOIN [HR].[Course] as c
--	  ON c.student_id = s.student_id

--	  UNION

--	  SELECT CONCAT('Not Enrolled' ,c.student_name)
--	  FROM [HR].[Students] as s
--	   LEFT JOIN [HR].[Course] as c
--	  ON c.student_id = s.student_id
--	  WHERE c.student_id is null


--HANDS-ON ON 30/01/2024

--1.Query: Find students who have not enrolled in any courses using except set operator.

  CREATE TABLE [HR].[New_Students]
  (
  [Student_id] INT CONSTRAINT[New_Students_pk] PRIMARY KEY IDENTITY(1,1),
  [Student_name] VARCHAR(30) NOT NULL,
  );

  INSERT INTO [HR].[New_Students]([Student_name])
  VALUES('Anwesha'),
  ('Manisha'),
  ('Sujata'),
  ('Rupali'),
  ('Kuheli'),
  ('Mousumi');

  DROP TABLE [HR].[New_Course]
   CREATE TABLE [HR].[New_Course]
  (
  [Course_id] INT CONSTRAINT[New_Course_pk] PRIMARY KEY IDENTITY(1,1),
  [Course_name] VARCHAR(30) NOT NULL,
  [Course_grade] CHAR(1),
  [Student_id] INT FOREIGN KEY 
  REFERENCES [HR].[New_Students]([Student_id])
  );

  INSERT INTO [HR].[New_Course]([Course_name],[Course_grade],[Student_id])
  VALUES('HTML','B',5),('CSS','A',1),('JAVASCRIPT','A',2),('SQL','C',2),('AJAX','D',4);


  SELECT * FROM [HR].[New_Students]
  
  SELECT * FROM [HR].[New_Course]

  SELECT [Student_id] 
  FROM [HR].[New_Students] 

  EXCEPT

  SELECT [Student_id] 
  FROM [HR].[New_Course] 



  (SELECT [Student_name] FROM [HR].[New_Students] WHERE Student_id IN
  (SELECT [Student_id] 
  FROM [HR].[New_Students] 
  EXCEPT
  SELECT [Student_id] 
  FROM [HR].[New_Course])) 
 
  

--2.Query: Display employees who are both managers and have a salary greater than 45000 using intersect. 
--Employees table have employee_id,employee_name, job_title, salary columns.


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    job_title VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert sample data into employees table
INSERT INTO employees VALUES(106, 'Anwesha', 'Manager', 40000.00),
    (101, 'Alice Johnson', 'Manager', 70000.00),
    (102, 'Bob Smith', 'Developer', 60000.00),
    (103, 'Charlie Brown', 'Manager', 75000.00),
    (104, 'David Wilson', 'Developer', 65000.00),
    (105, 'Eva Martinez', 'Manager', 80000.00);

-- Find employees who are both managers and have a salary greater than 45,000
SELECT employee_id, employee_name, job_title, salary
FROM employees
WHERE job_title = 'Manager' AND salary > 45000.00

INTERSECT

SELECT employee_id, employee_name, job_title, salary
FROM employees
WHERE job_title = 'Manager';




--3.Query: Customers who have placed an order along with their order information and also those customers
--who have not placed any orders using union.

SELECT * FROM [sales].[customers]
SELECT * FROM [sales].[orders]

SELECT o.[order_id], o.[order_date], c.[customer_id] 
FROM [sales].[orders] AS o
JOIN [sales].[customers] AS c
ON c.customer_id = o.customer_id
UNION
SELECT o.[order_id], o.[order_date], c.[customer_id] 
FROM [sales].[orders] AS o
LEFT OUTER JOIN [sales].[customers] AS c
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL


INSERT INTO [sales].[orders] ([order_status],[order_date],[staff_id],[store_id],[required_date])
VALUES(3,'2024-01-20',8,2,'2024-01-22',)

--4.Query: Display employees with information about their projects
--and employees without any assigned projects using union.

--5.Query : Find customers who have placed orders with an amount
--greater than the average order amount using correlated subquery.

--6.Query: Display employees
--whose salary is greater than the average salary in their department using correlated subquery.

--7.Query : To retrieve Parent NodeID, Parent Value, ChildNode ID,Child Value 
--in BinaryTree table to show the parent-child relationships.

--8.Query : Displays the parent messages along with their corresponding replies the Message table
--have Message ID, Content, Reply To columns.



--APPLY OPERATOR--


--Create Table Department
--(
--[Id] int primary key,
--[DepartmentName] nvarchar(50)
--)

--Insert into Department values (1, 'IT')
--Insert into Department values (2, 'HR')
--Insert into Department values (3, 'Payroll')
--Insert into Department values (4, 'Administration')
--Insert into Department values (5, 'Sales')

--SELECT * FROM Department


--Create table Employee
--(
--[Id] int primary key,
--[Name] nvarchar(50),
--[Gender] nvarchar(10),
--[Salary] int,
--[DepartmentId] int foreign key references Department(Id)
--);

--Insert into Employee values (1, 'Mark', 'Male', 50000, 1)
--Insert into Employee values (2, 'Mary', 'Female', 60000, 3)
--Insert into Employee values (3, 'Steve', 'Male', 45000, 2)
--Insert into Employee values (4, 'John', 'Male', 56000, 1)
--Insert into Employee values (5, 'Sara', 'Female', 39000, 2)

--SELECT * FROM Employee

--Create function fn_GetEmployeesByDepartmentId(@DepartmentId int)
--Returns Table
--as
--Return
--(
--Select Id, Name, Gender, Salary, DepartmentId
--from Employee where DepartmentId = @DepartmentId
--);

--Select * from fn_GetEmployeesByDepartmentId(1)
--Select * from fn_GetEmployeesByDepartmentId(2)

--Select D.DepartmentName, E.Name, E.Gender, E.Salary
--from Department D
--Inner Join fn_GetEmployeesByDepartmentId(D.Id) E
--On D.Id = E.DepartmentId



--APPLY OPERATOR

USE [BikeStores]

DROP TABLE Department

Create Table [HR].[Department]
(
[Id] int primary key,
[DName] varchar(50)
)


Insert into [HR].[Department] values (1, 'IT')
Insert into [HR].[Department] values (2, 'HR')
Insert into [HR].[Department] values (3, 'Payroll')
Insert into [HR].[Department] values (4, 'Exam')
Insert into [HR].[Department] values (5, 'Paint')

SELECT * FROM [HR].[Department]

CREATE TABLE [HR].[Employee]
(
[Id] int primary key,
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

CREATE FUNCTION fn_GetEmployeesByDepartmentId(@dept_Id int)
Returns Table 
as 
Return 
(
Select Id, Name, Gender, Salary ,dept_Id
FROM [HR].[Employee] WHERE dept_Id = @dept_Id
)

SELECT * FROM fn_GetEmployeesByDepartmentId(1)

--Outer Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
outer apply fn_GetEmployeesByDepartmentId(D.Id) AS E

--Cross Apply
Select D.DName, E.Name, E.Gender, E.Salary
from [HR].[Department]  AS  D
cross apply fn_GetEmployeesByDepartmentId(D.Id) AS E

--With Condition
SELECT  D.DName, E.Name, E.Gender, E.Salary
FROM [HR].[Department] AS D
outer apply fn_GetEmployeesByDepartmentId(D.Id) AS E --OUTER APPLY IS SIMILAR TO INNER JOIN
WHERE Salary >50000

SELECT  D.DName, E.Name, E.Gender, E.Salary
FROM [HR].[Department] AS D
cross apply fn_GetEmployeesByDepartmentId(D.Id) AS E --CROSS APPLY IS SIMILAR TO LEFT OUTER JOIN
WHERE Salary >50000


--APPLY OPERATOR QUESTIONS--

--SUPPOSE THERE ARE TWO TABLES PROJECTS AND DEVELOPERS 
--WRITE A QUERY TO DISPLAY PROJECT DETAILS FOR EACH EMPLOYEE USING APPLY OPERATOR

DROP TABLE [HR].[Developers]
CREATE TABLE [HR].[Developers]
(
 [developer_id] INT CONSTRAINT[developers_pk] PRIMARY KEY,
 [developer_name] VARCHAR(30),
 [salary] INT NOT NULL,
 [city] VARCHAR(30),
 );

 INSERT INTO [HR].[Developers]([developer_id],[developer_name],[salary],[city])
 VALUES(1,'Anwesha',50000,'Bankura'),
 (2,'Pushpa',50000,'Murshidabad'),
 (3,'Piya',50000,'Onda'),
 (4,'Rohima',50000,'Bishnupur'),
 (5,'Chandana',50000,'Bankura');

 CREATE TABLE [HR].[Project]
(
 [Project_id] INT CONSTRAINT[project_pk] PRIMARY KEY,
 [Project_name] VARCHAR(30),
 [developer_id] INT FOREIGN KEY 
 REFERENCES [HR].[Developers]([developer_id])
 );
 
 INSERT INTO [HR].[Project]([Project_id],[Project_name],[developer_id])
 VALUES(1,'A',2),
 (2,'B',3),
 (3,'C',1),
 (4,'D',5),
 (5,'E',4);

 SELECT * FROM [HR].[Project]

 CREATE FUNCTION fn_GetProjectDetailByDeveloperID(@developer_id int)
Returns Table 
as 
Return 
(
Select [Project_id], [Project_name], [developer_id]
FROM [HR].[Project] WHERE developer_id = @developer_id
)

SELECT * FROM fn_GetProjectDetailByDeveloperId(1)


--OUTER APPLY
Select D.developer_id, D.developer_name, P.project_name, P.project_id
from [HR].[Developers]  AS  D
outer apply fn_GetProjectDetailByDeveloperId(D.developer_id) AS P

--CROSS APPLY
Select D.developer_id, D.developer_name, P.project_name, P.project_id
from [HR].[Developers]  AS  D
cross apply fn_GetProjectDetailByDeveloperId(D.developer_id) AS P

--QUERY PRACTICE ON APPLY OPERATOR

--DISPLAY ORDER DETAILS FOR EACH CUSTOMER USING APPLY OPERATOR

 CREATE FUNCTION fn_GetOrderDetailsByCustomerID(@customer_id int)
Returns Table 
as 
Return 
(
Select  [order_id], [order_date]
FROM [sales].[orders] WHERE customer_id= @customer_id
)

--SELECT * FROM fn_GetOrderDetailsByCustomerID(1)

Select o.customer_id, o.first_name
from [sales].[customers]  AS  o
outer apply fn_GetOrderDetailsByCustomerID(o.customer_id) AS c

--WRITE A QUERY TO RECENT BOOK(child) DETAILS FOR EACH AUTHORS--master 


DROP TABLE [Authors]

CREATE TABLE [HR].[Authors]
(
[author_id] INT CONSTRAINT[author_pk] PRIMARY KEY,
[author_name] VARCHAR(30) NOT NULL,
);

INSERT INTO [HR].[Authors] ([author_id],[author_name])
VALUES(1,'Anwesha'),
(2,'Manisha'),
(3,'Chandana'),
(4,'Manjuli'),
(5,'Rita');

SELECT * FROM [HR].[Authors]

CREATE TABLE [HR].[book] (
    [book_id] INT PRIMARY KEY,
   [book_name] VARCHAR(255) NOT NULL,
    [publish_date] DATE,
    [author_id] INT,
    FOREIGN KEY (author_id) REFERENCES [HR].[Authors](author_id)
);

INSERT INTO [HR].[book] (book_id, book_name, publish_date, author_id)
VALUES
(1, 'The Mystery of the Lost Key', '2024-01-25', 1),
(2, 'The Adventure in the Hidden Cave', '2024-01-26', 3),
(3, 'Coding for Beginners', '2024-01-27', 2),
(4, 'HTML Introduction', '2024-01-28', 5),
(5, 'CSS Introduction', '2024-01-27', 4);


ALTER FUNCTION fn_GetBooksDetailsByAuthorID(@author_id int)
Returns Table 
as 
Return 
(
Select TOP 1  [book_id], [book_name],[publish_date]
FROM [HR].[book] WHERE author_id= @author_id
order by publish_date DESC
)
 select * from fn_GetBooksDetailsByAuthorID(2)

 --OUTER APPLY
SELECT  A.author_id, A.author_name , B.book_id, B.book_name, B.publish_date
FROM [HR].[Authors] AS A
outer apply fn_GetBooksDetailsByAuthorID(A.author_id) AS B --OUTER APPLY IS SIMILAR TO INNER JOIN
order by B.publish_date desc
 

 --CROSS APPLY
SELECT  A.author_id, A.author_name , B.book_id, B.book_name, B.publish_date
FROM [HR].[Authors] AS A
outer apply fn_GetBooksDetailsByAuthorID(A.author_id) AS B --OUTER APPLY IS SIMILAR TO INNER JOIN
order by B.publish_date desc


-- WRITE A QUERY TO DISPLAY DETAILS OF ACCOUNTS--child table
--WITH HIGHEST BALANCE FOR EACH CUSTOMERS--master table

CREATE TABLE [HR].[Bank_customer]
(
[customer_id] INT CONSTRAINT[bank_customer_pk] PRIMARY KEY,
[customer_name] VARCHAR(30),
);

INSERT INTO [HR].[Bank_customer]([customer_id],[customer_name])
VALUES(1,'Anwesha'), 
      (2,'Priyanka'),
	  (3,'Anjali'),
	  (4,'Madhumita');


CREATE TABLE [HR].[bank] (
    bank_id INT PRIMARY KEY,
    bank_name VARCHAR(255) NOT NULL,
    account_number VARCHAR(20) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES [HR].[Bank_customer](customer_id)
);

INSERT INTO [HR].[bank](bank_id, bank_name, account_number, account_type, balance, customer_id) 
VALUES
(101, 'ABC Bank', '1234567890', 'Savings', 5000.00, 1),
(102, 'XYZ Bank', '9876543210', 'Checking', 10000.00, 3),
(103, 'PQR Bank', '5678901234', 'Savings', 7500.00, 4),
(104, 'LMN Bank', '3456789012', 'Checking', 12000.00,2 ),
(105, 'JKL Bank', '6789012345', 'Savings', 3000.00, 1);

SELECT * FROM [HR].[bank]

CREATE FUNCTION fn_GetAccountDetailsByCustomerId(@customer_id int)
Returns Table 
as 
Return 
(
Select TOP 1  [bank_id], [bank_name],[balance],[customer_id]
FROM [HR].[bank] WHERE customer_id= @customer_id
order by [balance] DESC
)

 select * from fn_GetAccountDetailsByCustomerId (2)

SELECT  C.customer_id, C.customer_name ,B.bank_id ,B.bank_name ,B.balance
FROM [HR].[Bank_customer] AS C --Master table
outer apply fn_GetAccountDetailsByCustomerId(C.customer_id) AS B--Child table
--OUTER APPLY IS SIMILAR TO INNER JOIN

--NULLIF--
 SELECT NULLIF('ABC','XYZ') --ABC

 SELECT NULLIF('XYZ','XYZ')--NULL

 SELECT NULLIF(10,10) --NULL

 SELECT NULLIF(10,11) --10

--VALUE IS SAME BUT DATATYPE IS DIFFERENT IN THIS CASE IT WILL RETURN NULL
 SELECT NULLIF('10',10) --NULL

 SELECT NULLIF('10',11) --10

  SELECT NULLIF('10',0)--10

 SELECT NULLIF(10,'SY') --This will show an error because here varchar sy will not convert into int


 SELECT * FROM [sales].[customers]
 WHERE NULLIF(phone,'') IS NULL

SELECT * FROM [sales].[customers]

--COALESCE WILL RETURN FIRST NOT NULL VALUE IN THE LIST

SELECT COALESCE(NULL, 'Hi', 'Hello', NULL) result; --SO HERE RESULT WILL BE Hi 
--because  Hi is first not null value in this list

SELECT @@IDENTITY
drop table [HR].[#Identity]

CREATE TABLE [HR].[Identity]
(
[Identity_id]  INT   CONSTRAINT[Identity_pk] PRIMARY KEY IDENTITY(1,1),
[Identity_name] VARCHAR(30),
);

INSERT INTO [HR].[Identity] ([Identity_name])
VALUES ('A'),
('B'),
('C');

SELECT * FROM [HR].[Identity]
SELECT SCOPE_IDENTITY(), @@IDENTITY
 

 --IFF FUNCTION--

SELECT
IIF(order_status = 1,'Pending',
IIF(order_status=2, 'Processing',
IIF(order_status=3, 'Rejected',
IIF(order_status=4,'Completed','N/A')
)
)
) order_status,
COUNT(order_id) order_count
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY order_status;

--SUBSTRING FUNCTION--

--IT WILL TAKE 3 ARGUMENT 1st one is Substring 2nd is start and 3rd is length)
SELECT SUBSTRING('Anwesha Dutta',5,3);

SELECT SUBSTRING('Anwesha Dutta',8,4);

SELECT SUBSTRING('Anwesha Dutta',-1,4)

--LEFT()
 SELECT LEFT('SQL Server', 3) 

 --RIGHT()
 SELECT RIGHT('SQL Server', 6) 

 

 --LTRIM()
 LTRIM(' SQL Server LTRIM Function') 

 --RTRIM()
 SELECT RTRIM('SQL Server RTRIM Function ')

 --REPLACE()
 SELECT REPLACE('It is a good tea at the famous tea store.', 'tea', 'coffee')

 --STUFF()
 SELECT STUFF('SQL Tutorial', 1 , 3, 'SQL Server')

 --HANDS-ON ON 31/01/2024

 --Nested Subquery

SELECT product_name, list_price

FROM production.products
WHERE list_price > ( SELECT AVG (list_price) FROM production.products
WHERE brand_id IN ( SELECT brand_id FROM production.brands
WHERE brand_name = 'Strider' OR brand_name = 'Trek' ) )
ORDER BY list_price;

SELECT STUFF ('Rahul',1,3,'Par')

--FORMAT() FUNCTION
DECLARE @d  DATE = GETDATE();

--SELECT FORMAT(@d,'dd/MM/yyyy','en-US') AS 'Date', FORMAT(123456789,'###-##-####') AS 'Custom Number';

DECLARE @d  DATETIME = GETDATE();
SELECT FORMAT(@d,'dd/MM/yyyy hh:mm:tt') AS 'Today'

DECLARE @d  TIME = GETDATE();
SELECT FORMAT(@d,'hh:mm:tt') AS 'Today'

--I WANT TO SHOW ONLY DATE
DECLARE @d  DATE = GETDATE();
SELECT FORMAT(@d,'dd/MM/yyyy') AS 'Today'

--DATEDIFF() FUNCTION
SELECT order_id, required_date, shipped_date,
CASE WHEN DATEDIFF(day,shipped_date,required_date) < 0
THEN 'Late' ELSE 'OnTime'
END shipment
FROM sales.orders
WHERE shipped_date IS NOT NULL
ORDER BY required_date;

--DATEPART() FUNCTION

SELECT DATEPART(YEAR,GETDATE()) AS 'YEAR' --It will return year

SELECT DATEPART(MM,GETDATE()) AS 'MONTH' -- It will return month

SELECT DATEPART(DD,GETDATE()) AS 'DAY' --It will return day

--Convert() Function

SELECT GETDATE()
SELECT CONVERT(DATE,GETDATE()) date --It will convert it in date format --time will be deleted



--It is similar to  conver() but the syntax is different
SELECT CAST(GETDATE() AS DATE) date;

--THESE TWO RETURNS SAME VALUE BUT THE SYNTAX IS DIFFERENT

SELECT CONVERT(DECIMAL(10,2),124) --CONVERT() FUNCTION

SELECT CAST(123 AS DECIMAL(10,2)) --CAST() FUNCTION

SELECT CONVERT(VARCHAR,GETDATE(),100) AS 'Pattern one'
SELECT CONVERT(VARCHAR,GETDATE(),105) AS 'Pattern two'
SELECT CONVERT(VARCHAR,GETDATE(),106) AS 'Pattern three'
SELECT CONVERT(VARCHAR,GETDATE(),107) AS 'Pattern four'

--TRY CAST() Function

SELECT TRY_CAST('Anwesha' AS int) --if we don't use try cast so it shows error 
--but as I use TRY_CAST so it handled the exception

--ROUND() FUNCTION

SELECT ROUND(235.415, 2) AS RoundValue --Round the number to 2 decimal places

--ABSOLUTE() FUNCTION

SELECT Abs(-243.5) AS AbsNum --Return the absolute value of a number.

--FLOOR() FUNCTION

--Return the largest integer value that is equal to or less than 25.75
SELECT FLOOR(25.75) AS FloorValue 

--CEILING() FUNCTION

--- Return the smallest integer value that is greater than or equal to a number
 SELECT CEILING(25.75) AS CeilValue

 --ISNUMERIC() FUNCTION
SELECT ISNUMERIC('Anwesha') --It will return 0
SELECT ISNUMERIC(5) --It will return 1

SELECT ISNUMERIC('phone FROM [sales].[customers]')  --It returns 0 because it's data type is varchar

--ISNUMERIC() FUNCTION
SELECT [store_id] FROM [sales].[orders] 
WHERE 1 = ISNUMERIC([store_id]) 


--STRING_SPLIT() FUNCTION
--1st--
SELECT value 
FROM
STRING_SPLIT('red,green,,,blue', ','); -- It return a single valued function

--2nd--
SELECT value 
FROM
STRING_SPLIT('Anwesha Dutta,green,,,blue', ',');

--NEWID () FUNCTION

DECLARE @id UNIQUEIDENTIFIER;
SET @id = NEWID();
SELECT @id AS GUID; Here is the output:
 GUID

 --DENSE_RANK() FUNCTION
 SELECT * FROM (
SELECT product_id,product_name,brand_id,list_price, DENSE_RANK () OVER (
PARTITION BY brand_id
ORDER BY list_price DESC
) price_rank
FROM production.products
) t
WHERE price_rank <= 3;

SELECT * FROM (
 SELECT order_id, product_id, list_price , DENSE_RANK() OVER(
PARTITION BY order_id
ORDER BY list_price DESC
) price_rank
FROM [sales].[order_items]
) as o




--ROW_NUMBER()--
SELECT first_name, last_name, city,
ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name ) row_num
FROM sales.customers
ORDER BY city

--DELETE DUPLICATE ROWS FROM BASED ON TITLE AND AUTHOR FROM BOOKS TABLE
-- books table have BOOK_ID, TITLE,AUTHOR,PUBLICATION YEAR USING ROW_NUMBER FUNCTION

SELECT * FROM [HR].[Authors]
SELECT * FROM [HR].[book]

INSERT INTO [HR].[book]([book_id],[book_name],[publish_date],[author_id])
VALUES(6,'JAVASCRIPT_Introduction', '2024-01-20',5)



delete from [HR].[book] where author_id = 4

INSERT INTO [HR].[book]([book_id],[book_name],[publish_date],[author_id])
VALUES(7,'HTML Introduction', '2024-01-21',5)

WITH CTE 
AS 
(   
	SELECT [book_id],[book_name],[author_id],[publish_date] as publication_year,
	ROW_NUMBER() OVER (PARTITION BY author_id,book_name ORDER BY publish_date) row_num
	FROM [HR].[book] 
)

DELETE FROM CTE WHERE row_num>1
select * from CTE

--Dense Rank : Assign a rank to sales representatives based on their total sales amount on table 
--having TransactionID,SalesRepID,TransactionDate,Amount columns.


 CREATE TABLE [HR].[sales] (
    transiton_id INT,
    sales_rp_id INT,
    transtion_date DATE,
    ammount DECIMAL(10, 2)
);

-- Insert 10 rows of data into the sales table
INSERT INTO [HR].[sales] (transiton_id, sales_rp_id, transtion_date, ammount)
VALUES
    (1, 101, '2024-01-01', 100.50),
    (2, 102, '2024-01-02', 150.75),
    (3, 103, '2024-01-03', 200.00),
    (4, 104, '2024-01-04', 120.25),
    (5, 105, '2024-01-05', 80.75),
    (6, 106, '2024-01-06', 150.00),
    (7, 107, '2024-01-07', 300.50),
    (8, 108, '2024-01-08', 60.25),
    (9, 109, '2024-01-09', 200.75),
    (10, 110, '2024-01-10', 90.00);

INSERT INTO [HR].[sales] (transiton_id, sales_rp_id, transtion_date, ammount)
VALUES (11, 102, '2024-01-01', 100.50),
       (12, 104, '2024-01-01', 100.50);

	SELECT * FROM [HR].[sales]


	SELECT * FROM 
	(
	SELECT transiton_id ,sales_rp_id,transtion_date,ammount ,DENSE_RANK () OVER (
	PARTITION BY sales_rp_id
	ORDER BY transtion_date DESC
	) sales_rank
	FROM [HR].[sales]
    ) s

	--HANDS-ON ON 01/02/2024

--CASE EXPRESSION--
SELECT order_status,
COUNT(order_id) AS order_count
FROM sales.orders
WHERE YEAR(order_date) = 2018
GROUP BY order_status

SELECT 
CASE order_status
WHEN 1 THEN 'Pending'
WHEN 2 THEN 'Processing'
WHEN 3 THEN 'Rejected'
WHEN 4 THEN 'Completed'
END AS order_status,
COUNT(order_id) AS order_count
FROM sales.orders 
WHERE YEAR(order_date) =2018
GROUP BY order_status;

--CASE EXPRESSION IN AGGREGATE FUNCTION

SELECT SUM(CASE WHEN order_status = 1 THEN 1 ELSE 0 END) AS 'Pending',
SUM(CASE WHEN order_status = 2 THEN 1 ELSE 0 END) AS 'Processing',
SUM(CASE WHEN order_status = 3 THEN 1 ELSE 0 END) AS 'Rejected',
SUM(CASE WHEN order_status = 4 THEN 1 ELSE 0 END) AS 'Completed',
COUNT(*) AS Total --Individual order_status count
FROM sales.orders
WHERE YEAR(order_date) = 2018;

--Searched CASE expression in the SELECT clause

SELECT o.order_id, SUM(quantity * list_price) order_value,
CASE
WHEN SUM(quantity * list_price) <= 500 THEN 'Very Low'
WHEN SUM(quantity * list_price) > 500 AND SUM(quantity * list_price) <= 1000 THEN 'Low'
WHEN SUM(quantity * list_price) > 1000 AND SUM(quantity * list_price) <= 5000 THEN 'Medium'
WHEN SUM(quantity * list_price) > 5000 AND SUM(quantity * list_price) <= 10000 THEN 'High'
WHEN SUM(quantity * list_price) > 10000 THEN 'Very High'
END order_priority
FROM sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE YEAR(order_date) = 2018
GROUP BY o.order_id;

--WHILE LOOOP--
--It will print number from 0 to 9

DECLARE @counter INT =0
WHILE @counter<10
BEGIN
PRINT @counter;
SET @counter = @counter+1;
END

--It will print number from 1 to 10

DECLARE @counter INT =0
WHILE @counter<10
BEGIN
SET @counter = @counter+1;
PRINT @counter;
END

--BREAK STATEMENT--
DECLARE @count  INT =0
WHILE @count<10

BEGIN
 SET @count = @count+1

IF @count=3
BEGIN
  BREAK;
END
END
PRINT('Hello Anwesha');

--CONTINUE STATEMENT--
DECLARE @count  INT =0
WHILE @count<10

BEGIN
 SET @count = @count+1

IF @count=3
BEGIN
  CONTINUE;
END
END
PRINT('Hello Anwesha');


DROP TABLE IF EXISTS SampleTable
CREATE TABLE SampleTable
(Id INT, CountryName NVARCHAR(100), ReadStatus TINYINT)
GO
INSERT INTO SampleTable ( Id, CountryName, ReadStatus)
Values (1, 'Germany', 0),
(2, 'France', 0),
(3, 'Italy', 0),
(4, 'Netherlands', 0) ,
(5, 'Poland', 0)
SELECT * FROM SampleTable

DECLARE @Counter INT , @MaxId INT,
@CountryName NVARCHAR(100)
SELECT @Counter = min(Id) , @MaxId = max(Id)
FROM SampleTable
WHILE(@Counter IS NOT NULL
AND @Counter <= @MaxId)
BEGIN
SELECT @CountryName = CountryName
FROM SampleTable WHERE Id = @Counter
PRINT CONVERT(VARCHAR,@Counter) + '. country name is ' + @CountryName
SET @Counter = @Counter + 1
END

--PATTERN PRINTING -1
DECLARE @i INT =1

WHILE @i<5

BEGIN

PRINT REPLICATE('*',@i)
SET @i =@i+1

END

--PATTERN PRINTING-2

DECLARE @i INT =1 
WHILE @i<5
BEGIN
PRINT REPLICATE(' ',5-@i)+REPLICATE('*',@i)
SET @i=@i+1
END


--PATTERN PRINTING-3

DECLARE @i INT = 1
WHILE @i<5
BEGIN
PRINT REPLICATE(' ',5-@i) + REPLICATE(1,@i)
SET @i = @i+1
END

--PATTERN PRINTINT -4
DECLARE @i INT = 1
WHILE @i<5
BEGIN
PRINT REPLICATE(1,@i) 
SET @i = @i+1
END

--PATTERN PRINTING-5
DECLARE @i INT = 0
WHILE @i<5
BEGIN
PRINT REPLICATE(0+@i,@i) 
SET @i = @i+1
END

--PATTERN PRINTING-6
DECLARE @i INT = 1
DECLARE @j INT = 1
WHILE @i<5
BEGIN
PRINT REPLICATE(@j,@i) 
SET @i = @i+1
END

--Inserting Records With WHILE Loop

DROP TABLE bikeshop
CREATE TABLE bikeshop (
Id INT PRIMARY KEY,
bike_name VARCHAR (50) NOT NULL,
price FLOAT
);

DECLARE @count INT 
SET @count = 1
WHILE @count<=10
BEGIN
 INSERT INTO bikeshop 
 VALUES(@count,'Bike-' + CAST(@count AS VARCHAR), @count*5000)
 SET @count = @count+1
END;

SELECT * FROM bikeshop

--SQL SERVER LOOPS AND DATES

--DATEADD() FUNCTION
 SELECT dateadd(day,1,'2024-02-01')
 SELECT dateadd(month,1,'2024-02-01')
 SELECT dateadd(YEAR,1,'2024-02-01')

  SELECT dateadd(YEAR,2,'2024-02-01')
  SELECT dateadd(MONTH,3,'2024-02-01')
  SELECT dateadd(DAY,4,'2024-02-01')

  --SQL SERVER LOOPS AND DATES

   DECLARE @start_date DATE
   DECLARE @end_date DATE
   DECLARE @loop_date DATE

   SET @start_date = '2024-02-01'
   SET @end_date = '2024-02-05'
   SET @loop_date = @start_date

   WHILE @loop_date<=@end_date
   BEGIN
   PRINT @loop_date
   SET @loop_date = DATEADD(day, 1,@loop_date)
   END

   --SQL SERVER LOOPS AND DATES --INSIDE TABLE
CREATE TABLE #dates 
( 
report_date DATE
);

DECLARE @date_start DATE;
DECLARE @date_end DATE;
DECLARE @loop_date DATE;

SET @date_start = '2024/02/01';
SET @date_end = '2024/02/05';
SET @loop_date = @date_start;

WHILE @loop_date <= @date_end
BEGIN

INSERT INTO #dates (report_date) 
VALUES (@loop_date);

SET @loop_date = DATEADD(DAY, 1, @loop_date);
END;

SELECT * FROM #dates;


--CONTINUE WITHIN WHILE--
DECLARE @counter INT = 0;
WHILE @counter < 10
BEGIN
	SET @counter = @counter + 1;

	IF @counter = 5
		CONTINUE;

    PRINT @counter;
END

--BREAK WITHIN WHILE--

DECLARE @counter INT = 0;
WHILE @counter < 10
BEGIN
	SET @counter = @counter + 1;

	IF @counter = 5
		BREAK;

    PRINT @counter;
END

--SCALAR FUNCTION--

USE HRDB

ALTER FUNCTION Age(@DOB Date)
RETURNS INT
AS
BEGIN
DECLARE @Age INT
SET @Age = DATEDIFF(YEAR,@DOB, GETDATE()) 
if(MONTH(@DOB) > 6) 
SET @Age = @Age+1
RETURN @Age
END

SELECT dbo.Age('1999/10/04') AS Age

--QUERY--
--TWO SCALAR FUNCTION--

--1.ONE SCALAR FUNCTION--

CREATE FUNCTION fn_calculate_areaofsqure(@a INT)
RETURNS INT AS 
BEGIN
RETURN @a*@a
END
 
 SELECT dbo.fn_calculate_areaofsqure(10)



 --1.ANOTHER SCALAR FUNCTION--

 CREATE FUNCTION user_defined_fn_calculatesum(@a INT ,@b INT)
 RETURNS INT AS
 BEGIN
 RETURN @a+@b
 END

 SELECT dbo.user_defined_fn_calculatesum(5,7)


 --2. INLINE TABLE FUNCTION--

 CREATE FUNCTION fn_inline()
 RETURNS TABLE
 AS 
 RETURN

 SELECT 
  book_id, book_name,publish_date 
  FROM [HR].[book]
  WHERE book_id =2

  SELECT * FROM fn_inline()


  --3.MULTI VALUED FUNCTION--
  CREATE TABLE [HR].[Newone]
  (
	  [Id] INT CONSTRAINT[newone_pk] PRIMARY KEY,
	  [Name] VARCHAR(20) ,
	  [Marks] INT
  );

  INSERT INTO [HR].[Newone]([Id],[Name],[Marks])
  VALUES(1,'Anwesha',90),
  (2,'Minakshi',80),
  (3,'Sanjana',70),
   (4,'Sudipta',60),
   (5,'Manjuli',50);

    CREATE TABLE [HR].[Newtwo]
  (
  [Id] INT CONSTRAINT[newtwo_pk] PRIMARY KEY,
  [Name] VARCHAR(20) ,
  [Marks] INT
  );

   INSERT INTO [HR].[Newtwo]([Id],[Name],[Marks])
  VALUES(1,'Shyamal',100),
  (2,'Karan',50),
  (3,'Uttam',60),
   (4,'Nilakshi',80),
   (5,'Mandira',70);


  CREATE FUNCTION user_defined_fn_details()
  RETURNS @Contacts TABLE
  (
  [Id] INT,
  [Name] VARCHAR(30) ,
  [Marks] INT,
  [Age] INT
  )
  AS
  BEGIN

  INSERT INTO  @Contacts
  SELECT [Id],[Name],[Marks],24
  FROM [HR].[Newone];

   INSERT INTO  @Contacts
  SELECT [Id],[Name],[Marks] ,26
  FROM [HR].[Newtwo];

  RETURN 
  END;
  
  SELECT * FROM user_defined_fn_details()


  --4.PATTERN PRINTING

  DECLARE @i INT=0,@j INT=65, @s VARCHAR(100)=''
  WHILE (@i<10)
  BEGIN
     WHILE(@j<=(65+@i))
     BEGIN
		SET @s+= char(@j)
		SET @j+=1
     END
	 PRINT(@s)
     SET @s =''
     SET @j =65
     SET @i+=1
  END

 
-- HANDS_ON ON 02/02/2024--

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


 --Practice of PIVOT in SQL Server

 SELECT CustomerName,
	Laptop,
	Desktop,
	Mobile
FROM
( 
 SELECT
	 CustomerName,
	 ProductName,
	 Amount
 FROM Customers
 )
 AS PivotData

 PIVOT
 (
	 SUM(Amount) FOR ProductName 
	 IN(Laptop,Desktop,Mobile)
 ) 
 AS PivotTable



 --CONVERT IN PIVOT--
 SELECT category_name,
 COUNT(product_id) product_count
 FROM [production].[products] AS p
 INNER JOIN [production].[categories] AS c
 ON p.category_id = c.category_id
 GROUP BY category_name

 --SECTION-1--

 SELECT *
 FROM
 (
 SELECT 
 category_name,
 product_id ,model_year

 --SECTION-2--
 FROM
 [production].[products] as p
 JOIN [production].[categories] as c
 ON p.category_id = c.category_id
 ) 
  AS PivotData

  --SECTION-3--
 PIVOT
 (
 COUNT(product_id) FOR category_name 
 IN (
      [Children Bicycles], [Comfort Bicycles], [Cruisers Bicycles], [Cyclocross Bicycles], [Electric Bikes], [Mountain Bikes], [Road Bikes]
   ))
AS pivot_table;


--PIVOT IN SQL SERVER--
--GENERIC COLUMN VALUES--

DECLARE @columns NVARCHAR(MAX) = '';
SELECT @columns += QUOTENAME(category_name) + ','
FROM production.categories
ORDER BY category_name;
SET @columns = LEFT(@columns, LEN(@columns) - 1);
PRINT @columns;

 
ALTER FUNCTION fn_pivotfunction(@category_name VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS 
BEGIN

DECLARE @columns NVARCHAR(MAX) = '';
SELECT @columns += QUOTENAME(category_name) + ',' 
FROM production.categories
--ORDER BY category_name;
SET @columns = LEFT(@columns, LEN(@columns) - 1);

RETURN @columns
END


SELECT dbo.fn_pivotfunction('Children Bicycles') 
[Children Bicycles],[Comfort Bicycles],[Cruisers Bicycles],[Cyclocross Bicycles],[Electric Bikes],[Mountain Bikes],[Road Bikes]


--UNPIVOT in SQL Server

Create Table ProductSales
(
AgentName VARCHAR(50),
India int,
US int,
UK int
)
INSERT INTO ProductSales VALUES ('Smith', 9160, 5220, 3360)
INSERT INTO ProductSales VALUES ('David', 9770, 5440, 8800)
INSERT INTO ProductSales VALUES ('James', 9870, 5480, 8900)


SELECT * FROM ProductSales

SELECT 
AgentName,
Country,
SalesAmount

FROM 
(
SELECT AgentName,India, US,UK
FROM ProductSales
)AS ActualData

UNPIVOT(
SalesAmount
FOR Country IN(India, US,UK)
) AS UnpivotData

--Write a query to display total sales amount for each employee in each product type for each month
--emp_id ,emp_name, product_type, amount,sales_date

DROP TABLE [HR].[AnotherEmployeetbl]

CREATE TABLE [HR].[AnotherEmployeetbl]
(
[Emp_id] INT ,
[Emp_name] VARCHAR(30),
[product_type] VARCHAR(30),
[sales_amount] INT,
[sales_date] DATE
);

INSERT INTO[HR].[AnotherEmployeetbl]([Emp_id],[Emp_name],[product_type],[sales_amount],[sales_date])
VALUES  (1,'Anwesha','Electronics', 20000,'2024-01-02'),
        (1,'Anwesha','Electronics',50000,'2024-01-01'),
        (1,'Anwesha','Ornaments',60000,'2024-01-26'),
		(1,'Anwesha','Ornaments',80000,'2024-01-27'),
	    (2,'Manisha','Food',40000,'2024-02-27'),
	    (2,'Manisha','clothing',50000,'2024-02-27'),
	    (2,'Manisha','clothing',60000,'2024-03-27');

	  SELECT * FROM [HR].[AnotherEmployeetbl]

	  
 SELECT Emp_name,product_type,January,February,March
 FROM
 (
 SELECT 
 [Emp_id],[Emp_name],[product_type],[sales_amount],format([sales_date],'MMMM') SalesMonth
 FROM [HR].[AnotherEmployeetbl]
 ) AS PivotData

 PIVOT
 (
 SUM(sales_amount) FOR SalesMonth
 IN(January,February,March)
) AS PivotTable


--How to extract month of any date

SELECT FORMAT(CAST('2024-01-20'AS DATE),'MMMM')

--display total quantity of products, ordered, for each product category over quater using pivot
--order_id , product_category, quantity, order_date,

CREATE TABLE [HR].[products]
(
[order_id] INT,
[product_category] VARCHAR(30),
[quantity] INT ,
[order_date] DATE
);

INSERT INTO [HR].[products] ([order_id],[product_category],[quantity],[order_date])
VALUES(1,'Electronics',6,'2024-12-25'),
      (2,'Electronics',4,'2024-02-25'),
	  (3,'Electronics',8,'2024-03-25'),
	  (4,'Electronics',7,'2024-04-25'),
	  (5,'Food',8,'2024-01-26'),
	  (6,'Food',6,'2024-02-26'),
	  (7,'Food',2,'2024-03-26'),
	  (8,'Food',4,'2024-04-26'),
	  (9,'Food',8,'2024-05-27'),
	  (10,'Food',4,'2024-06-27'),
	  (11,'Food',2,'2024-07-27'),
	  (12,'Food',4,'2024-08-27');

		SELECT * FROM [HR].[products]

SELECT * FROM
 (
	 SELECT 
	 [order_id],[product_category],[quantity],CONCAT('Q',DATEPART(QUARTER,order_date),' ',YEAR(order_date)) AS [QUARTER]
	 FROM [HR].[products]
 ) 
 AS PivotData
 PIVOT
 (
	SUM(quantity) FOR [QUARTER]
 IN([Q1 2024],[Q2 2024],[Q3 2024],[Q4 2024])
)
AS PivotTable

--LIKE OPERATOR--
SELECT first_name FROM [sales].[customers] WHERE first_name LIKE '___'

SELECT first_name FROM [sales].[customers] WHERE first_name LIKE '[J, H, K, U]%'

SELECT first_name FROM  [sales].[customers] WHERE first_name LIKE'[A-Z]%'

SELECT first_name FROM  [sales].[customers] WHERE first_name NOT LIKE'[A-Z]%'


--HANDS-ON ON 06/02/2024
-------------------------------------------------------------------------------------
--THE IFF STATEMENT--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

IF 20>10
BEGIN
  PRINT 'yes'
END
ELSE
BEGIN
   PRINT 'No'
END

-------------------------------------------------------------------
DECLARE @Age  INT = 18
IF @Age>=18
BEGIN 
  PRINT 'You are eligible for voting'
END
ELSE
BEGIN
  PRINT 'You are not eligible for voting'
END
----------------------------------------------------------------------
DECLARE @Marks INT = 100
IF @Marks >=50 AND @Marks<=60
BEGIN
  PRINT 'Too Low'
END
ELSE IF @Marks>60 AND @Marks<=70 
BEGIN
  PRINT 'Close But low'
END
ELSE IF @Marks>70 AND @Marks<80 
BEGIN
  PRINT 'Close but Still low'
END
ELSE IF @Marks=80
BEGIN
   PRINT 'Yes it is the number'
END

ELSE
BEGIN
   PRINT 'Invalid'
END
-----------------------------------------------------------------------------------------------------
--TRY CATCH--
---------------------------------------------------------------------------------------------
DECLARE @Age INT = 18
BEGIN TRY 
IF @Age>='A'
BEGIN 
  PRINT 'You are eligible for voting'
END

ELSE
BEGIN
  PRINT 'You are not eligible for voting'
END

END TRY

BEGIN CATCH
     PRINT 'Please Check Again'
END CATCH
-----------------------------------------------------------------------------
--TRY CATCH--
CREATE TABLE [sales].[persons] --Parent Table
(
[person_id] INT PRIMARY KEY IDENTITY, 
[first_name] NVARCHAR(100) NOT NULL, 
[last_name] NVARCHAR(100) NOT NULL
);
INSERT INTO [sales].[persons] ([first_name], [last_name])
VALUES ('John','Doe'),
       ('Jane','Doe');

INSERT INTO [sales].[persons] ([first_name], [last_name])
VALUES ('Anwesha', 'Dutta');
       
 CREATE TABLE [sales].[deals] --Child Table
 ([deal_id] INT PRIMARY KEY IDENTITY, 
 [person_id] INT NOT NULL, 
 [deal_note] NVARCHAR(100), 
 FOREIGN KEY(person_id) REFERENCES sales.persons( person_id)
 );

 INSERT INTO  [sales].[deals] ([person_id], [deal_note])
 VALUES (1,'Deal for John Doe');

 SELECT * FROM [sales].[deals]
 SELECT * FROM [sales].[persons]
`	

 CREATE PROC spreport_error
AS
SELECT
ERROR_NUMBER() AS ErrorNumber
,ERROR_SEVERITY() AS ErrorSeverity
,ERROR_STATE() AS ErrorState
,ERROR_LINE () AS ErrorLine8
,ERROR_PROCEDURE() AS ErrorProcedure
,ERROR_MESSAGE() AS ErrorMessage; 

ALTER PROC sp_delete_person( @person_id INT ,@message VARCHAR(100) out ) AS
BEGIN

BEGIN TRY
BEGIN TRANSACTION; -- delete the person
DELETE FROM sales.persons WHERE person_id = @person_id -- if DELETE succeeds, commit the transaction
IF(@@ROWCOUNT>0)
 SET @message = 'Transaction Successful'
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
EXEC spreport_error; -- report exception
IF (XACT_STATE()) = -1 -- Test if the transaction is uncommittable.
BEGIN
PRINT N'The transaction is in an uncommittable state.' + 'Rolling back transaction.'
ROLLBACK TRANSACTION; 
END;
END CATCH
END;

EXEC sp_delete_person 2

--print sp_delete_person
DECLARE @message VARCHAR(100)
EXEC sp_delete_person 5, @message out
print @message
 -----------------------------------------------------------------------
 CREATE PROC spdivide 
 (
  @a decimal,
  @b decimal,
  @c decimal output
  ) AS 
  BEGIN
  BEGIN TRY
    SET @c = @a/@b;
  END TRY

BEGIN CATCH

SELECT
ERROR_NUMBER() AS ErrorNumber
,ERROR_SEVERITY() AS ErrorSeverity
,ERROR_STATE() AS ErrorState
,ERROR_PROCEDURE() AS ErrorProcedure
,ERROR_LINE() AS ErrorLine
,ERROR_MESSAGE() AS ErrorMessage; 
END CATCH
END

DECLARE  @a decimal = 10,
         @b decimal = 5,
         @c decimal 

--Syntax for calling Store Procedure--
-----------------------------------------------------
EXEC spdivide @a, @b, @c out
PRINT CONCAT(@c,'Done')

PRINT @c+ CAST('Done' AS INT)

--RAISE ERROR IN TRY CATCH BLOCK--
-----------------------------------------------------------------------
--Mesage_Text
-----------------------------------------------------------------------
DECLARE 
@ErrorMessage NVARCHAR(4000),
@ErrorSeverity INT,
@ErrorState INT 
BEGIN TRY
RAISERROR('Error_occourred in the TRY block.',2,1)
END TRY
BEGIN CATCH
SELECT
@ErrorMessage = ERROR_MESSAGE(),
@ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
-- return the error inside the CATCH block
RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH

--------------------------------------------------------------

CREATE TABLE [HR].[BankAccounts](
    [AccountNumber] VARCHAR(10) PRIMARY KEY,
    [Balance] INT
);
INSERT INTO  [HR].[BankAccounts] ([AccountNumber], [Balance]) 
VALUES ('A', 500),
       ('B', 800);
                
SELECT* FROM [HR].[BankAccounts]

----Transaction T1: Fund Transfer from Account A to Account B
BEGIN TRANSACTION;

--Deduct $100 From Account A
UPDATE [HR].[BankAccounts] SET Balance = Balance -100
WHERE AccountNumber ='A';

---Simute a delay or some processing
WAITFOR DELAY '00:00:05'; -- Sumulating some processing time

---Transaction T2: Query balance of Account B with Read Uncommitted
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

---Read the balance of  Account B(may read uncommitted data) --Means Dirty Read
SELECT Balance
FROM [HR].[BankAccounts]
WHERE AccountNumber ='B';

---Commit or Rollback Transaction T1
--ROLLBACK;
COMMIT

SELECT * FROM [HR].[BankAccounts]

--Read Committed Data--
--Transaction T1: Fund transfer from Account A to Account B
BEGIN TRANSACTION;

--Add $100 from Account	A
UPDATE [HR].[BankAccounts]
SET Balance = Balance +100
WHERE AccountNumber ='A';

--Simulate a delay or some processing
WAITFOR DELAY '00:00:05'; --Simulating some processing time

--Commit Transaction T1
COMMIT;

--Transaction T2: Query balance of Account B with Read Committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

---Read the balance of  Account B(won't read uncommitted data) --Means Dirty Read
SELECT Balance
FROM [HR].[BankAccounts]
WHERE AccountNumber ='A';

SELECT * FROM [HR].[BankAccounts]

---HANDS-ON ON 07/02/2024

---COMMIT AND ROLLBACK IN TRANSACTION---

-- Create table
CREATE TABLE[HR].[employeestbl] (
    [employee_Id] INT,
    [employee_name] VARCHAR(50)
);

-- Insert sample values
INSERT INTO [HR].[employeestbl] (employee_Id, employee_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Michael Johnson');

SELECT * FROM [HR].[employeestbl]

--In case of Transaction whatever we upadated data will be not save after logout session data will
--lost , it will be return in its previous position if we don't we commit
--if we use commit then only we can able to see changes that we have made because now its permanently 
--save 

BEGIN TRANSACTION 
UPDATE [HR].[employeestbl] SET employee_name = 'Shyamal Dutta' WHERE employee_id =1
SAVE TRAN Point1
UPDATE [HR].[employeestbl] SET employee_name = 'Krishna Dutta' WHERE employee_id =2
SAVE TRAN Point2
DELETE FROM [HR].[employeestbl] WHERE employee_id = 3
ROLLBACK TRAN Point1
COMMIT

--IT will be save means it's auto commit
--It is auto commit

UPDATE [HR].[employeestbl] SET employee_name = 'Anwesha Dutta' WHERE employee_id =1


-- Create table

CREATE TABLE [HR].[Department_tbl] (
    [dept_id] INT PRIMARY KEY,
    [dept_name] VARCHAR(50)
);

-- Insert sample values
INSERT INTO  [HR].[Department_tbl]([dept_id], [dept_name]) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'Finance');

-- Create table

CREATE TABLE [HR].[Student_tbl] (
   [student_Id] INT PRIMARY KEY,
    [student_name] VARCHAR(50),
    [dept_id] INT CONSTRAINT[stu_fk] FOREIGN KEY(dept_id) 
	REFERENCES [HR].[Department_tbl] (dept_id)
);

-- Insert sample values
INSERT INTO  [HR].[Student_tbl] ([student_Id], [student_name], [dept_id]) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 1),
(4, 'David', 3),
(5, 'Emma', 1),
(6, 'Frank', 2),
(7, 'Grace', 3),
(8, 'Hannah', 1);


SELECT * FROM [HR].[Department_tbl]
SELECT * FROM [HR].[Student_tbl]

BEGIN TRANSACTION 
DELETE FROM [HR].[Department_tbl] WHERE dept_id = 2
SAVE TRAN Point1
UPDATE [HR].[Department_tbl] SET dept_name = 'IT' WHERE dept_id = 1
SAVE TRAN Point2
ROLLBACK TRAN Point1
--ROLLBACK
COMMIT

PRINT XACT_STATE()


--TRANSACTON MODES IN SQL SERVER
--------------------------------------------------------------------------------------

SET IMPLICIT_TRANSACTIONS ON
UPDATE [HR].[employeestbl] SET employee_name = 'Annapurna Dutta' WHERE employee_id =1
--ROLLBACK
COMMIT

SELECT * FROM [HR].[employeestbl]

----------------------------------------------------------------------------------------------------------------
--WHEN WE DEFINE PRIMARY KEY AND WE INSERT VALUE IN HAPHAZARDLY Like(20,10,30) It will give result as (10,20,30)
----------------------------------------------------------------------------------------------------------------
-- Create table
CREATE TABLE Employees (
    employee_Id INT PRIMARY KEY,
    employee_Name VARCHAR(50)
);

-- Insert sample values
INSERT INTO Employees (employee_Id, employee_Name) VALUES
(3, 'John Smith'),
(1, 'Jane Doe'),
(2, 'Michael Johnson');

SELECT * FROM Employees 

--CREATE A PROCEDURE, DEFIRNE ONE PARAMETER THAT WILL TAKE AN INPUT AS MODEL YEAR, SHOW THE DETAILS AND COUNT 
--THE NUMBER OF ORDERS
-------------------------------------------------------------------------------------------------------------

SELECT * FROM  production.products
--SELECT * FROM  sales.orders
SELECT * FROM  sales.order_items

ALTER PROCEDURE uspFindModelYear
(
@model_year  SMALLINT ,
@message VARCHAR(100) OUT
)
 AS 
 BEGIN 
 SELECT model_year,COUNT(i.order_id)
 FROM [production].[products] as p
 JOIN [sales].[order_items] as i
 ON p.product_id = i.product_id
 --JOIN [sales].[orders] as o
 --ON o.order_id = i.order_id
 WHERE model_year = @model_year
 GROUP BY model_year


 IF(@@RowCount<=0)
 BEGIN
   SET @message = 'No order'
 END

 END

 DECLARE @message VARCHAR(100)
 EXEC uspFindModelYear 2018 ,@message out
 PRINT @message
-- PRINT XACT_STATE()

----------------------------------------------------------------------------------------------------------------
--CREATE A PROCEDURE TO DISPLY EMPLOYEES FIRST NAME, HIRE DATE , JOB TITLE AND SALARY BETWEEN 8000 AND 20000
--INPUT WILL BE MIN SALARY AND MAX SALARY

USE HRDB

ALTER PROCEDURE uspFindDetails(@min_salary DECIMAL(8,2) ,@max_salary DECIMAL(8,2),@message VARCHAR(100) out)
AS 
BEGIN
SELECT first_name,hire_date,job_title,salary
FROM [dbo].[employees] AS e
JOIN [dbo].[jobs] AS j
ON e.job_id = j.job_id
WHERE salary BETWEEN @min_salary AND @max_salary 

IF(@@RowCount<=0)
 BEGIN
   SET @message = 'No Employees are there in this salary range'
 END

END

DECLARE @message VARCHAR(100)
EXEC uspFindDetails 8000,20000,@message out
 
SELECT * FROM [dbo].[employees]
SELECT * FROM [dbo].[jobs]


--------------------------------------------------------------------------------------------
--CREATE A PROCEDURE TO DISPLAY BRAND NAME, PRODUCT NAME, LIST PRICE BETWEEN TWO ORDER DATES 

USE BikeStores

ALTER PROCEDURE uspFindProductDetails
(@dateone DATE , @datetwo DATE, @product_name VARCHAR(100),@rowcount INT OUT,@message VARCHAR(100) OUT)
AS 
BEGIN

SET NOCOUNT ON;
SELECT brand_name, product_name, p.list_price ,order_date
FROM [production].[brands] AS b
JOIN [production].[products] AS p
ON b.brand_id = p.brand_id
JOIN [sales].[order_items] as i
ON i.product_id = p.product_id
JOIN [sales].[orders] AS o
ON o.order_id = i.order_id
AND product_name LIKE '%'+@product_name +'%'

WHERE o.order_date BETWEEN @dateone AND @datetwo

 SET @rowcount = @@ROWCOUNT
IF(@@RowCount<=0)
 BEGIN
   SET @message = 'No Employees are there in this date range'
 END


END

DECLARE @message VARCHAR(100),@rowcount INT 
EXEC uspFindProductDetails '2016-01-05','2016-01-20','electra', @message out,@rowcount  out
PRINT @message
PRINT @rowcount



SELECT * FROM [sales].[orders]

SELECT * FROM [production].[products]
----------------------------------------------------------------------------------------------------
PRINT 'Anwesha'
PRINT CHAR(10) --THIS WILL PRODUCE A ENTER BETWEEN THESE TWO NAMES
PRINT 'Shyamal'
----------------------------------------------------------------------------------------------------

--HANDS ON ON 08/02/2024
-----------------------------------------------------------------------------------------------------

--Stored Procedure : Create a stored procedure that retrieves information
--about bookings made for a specific train, 
--including details about the passengers who have booked tickets

CREATE TABLE [HR].[train](
    [train_id] INT PRIMARY KEY,
    [train_name] VARCHAR(255)
);

INSERT INTO  [HR].[train]([train_id], [train_name]) VALUES
(1, 'Express'),
(2, 'Thunderbolt'),
(3, 'Metro Liner'),
(4, 'Coast Starlight'),
(5, 'Bullet Train');



CREATE TABLE [HR].[passenger] (
    [passenger_id] INT PRIMARY KEY,
    [passenger_name] VARCHAR(255),
    [train_id] INT
    FOREIGN KEY  REFERENCES [HR].[train] ([train_id])
);

INSERT INTO  [HR].[passenger] ([passenger_id], [passenger_name], [train_id]) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 1),
(4, 'David', 3),
(5, 'Emma', 4);

SELECT * FROM [HR].[train]
SELECT * FROM [HR].[passenger]

ALTER PROCEDURE usp_bookingdetails( @train_id INT ,@rowcount INT OUT, @message VARCHAR(100) OUT)
AS 
BEGIN 

SELECT t.train_id, train_name, passenger_name
FROM [HR].[train] AS t
JOIN [HR].[passenger] AS p
ON t.train_id = p.train_id
WHERE t.train_id = @train_id
SET @rowcount = @@ROWCOUNT
IF(@rowcount<1)
BEGIN
 SET @message = 'No train Available'
END
END

DECLARE @message VARCHAR(100),@rowcount INT 
EXEC usp_bookingdetails 5,@rowcount  out,@message out
PRINT @message



-------------------------------------------------------------------------------------------


--Create stored procedure that retrieves information about orders for a specific customer,
--including the products ordered and their quantities.

USE BikeStores

ALTER PROCEDURE usp_orderinfo(@customer_id INT, @rowcount INT OUT, @message VARCHAR(100) OUT)
WITH ENCRYPTION
AS 
BEGIN
SELECT first_Name, city, o.order_id,product_name
FROM [sales].[customers] as c
 JOIN [sales].[orders] as o
 ON c.customer_id = o.customer_id
 JOIN [sales].[order_items] as i
 ON o.order_id = i.order_id
 JOIN [production].[products] as p
 ON p.product_id = i.product_id
 WHERE c.customer_id =@customer_id
 --SET @rowcount =@@rowcount

 IF (@@ROWCOUNT<1)
 BEGIN
 SET @message = 'No Order'
 END
 END

DECLARE @message VARCHAR(100), @rowcount INT 
EXEC usp_orderinfo 5000 ,@rowcount  out, @message out
PRINT @message
PRINT @rowcount

-----------------------------------------------------------------------------------------
--FOR SHOWING THE DETAILS OF TALBE 
--WE CAN HIDE THIS DETAILS BY USING WITH ENCRYPTION 

sp_helptext usp_orderinfo

--------------------------------------------------------------------------------

SELECT * FROM [HR].[Employee]
SELECT * FROM [HR].[Department]

ALTER PROCEDURE spGETotalCountEmployees
@TotalCount INT OUTPUT
AS 
BEGIN
  SELECT @TotalCount = COUNT(ID) FROM [HR].[Employee]
END

DECLARE @TotalEmployees INT 
EXECUTE spGETotalCountEmployees @TotalEmployees OUTPUT

SELECT @TotalEmployees

ALTER PROCEDURE spGETotalCountEmployees
AS
BEGIN 
RETURN (SELECT COUNT(ID) FROM [HR].[Employee])
END
--SELECT @TotalEmployees

-------------------------------------------------------------------------------------------

Declare @Name nvarchar(20)

Execute spGETotalCountEmployees 2, @Name out
PRINT 'Name of the Employee =' +@Name

CREATE PROCEDURE sp_GetNameBYId3
@Id INT
AS 
BEGIN 
RETURN (SELECT Name FROM [HR].[Employee] WHERE Id =@Id)
END

DECLARE @Name nvarchar(20)
EXECUTE @Name = sp_GetNameBYId3
PRINT @Name

----------------------------------------------------------------------------------------

DROP TABLE [HR].[user]
CREATE TABLE [HR].[user](
    [username] VARCHAR(50) PRIMARY KEY,
    [password] VARCHAR(50),
    [firstname] VARCHAR(50),
    [lastname] VARCHAR(50),
    [email] VARCHAR(100),
    [phone] VARCHAR(20),
    [location] VARCHAR(100),
    [createdby] VARCHAR(50),
    
);

INSERT INTO[HR].[user]([username], [password], [firstname], [lastname], [email], [phone], [location], [createdby]) VALUES
('user1', 'password1', 'John', 'Doe', 'john.doe@example.com', '1234567890', 'New York', 'admin'),
('user2', 'password2', 'Jane', 'Smith', 'jane.smith@example.com', '0987654321', 'Los Angeles', 'admin'),
('user3', 'password3', 'Alice', 'Johnson', 'alice.johnson@example.com', '5551234567', 'Chicago', 'admin'),
('user4', 'password4', 'Michael', 'Brown', 'michael.brown@example.com', '7778889999', 'Houston', 'admin'),
('user5', 'password5', 'Emily', 'Wilson', 'emily.wilson@example.com', '4445556666', 'Miami', 'admin');

SELECT * FROM [HR].[user]


ALTER PROCEDURE spuserRegistration

@username varchar(50),
@password varchar(50),
@firstname varchar(50),
@lastname varchar(50),
@email varchar(50),
@phone varchar(50),
@location varchar(50),
@createdby varchar(50),
@message varchar(100) out


AS 
BEGIN

SET NOCOUNT ON
IF NOT EXISTS(SELECT * FROM [HR].[user] WHERE username =@username)
Begin
	Insert into [HR].[user] ([username],[password], [firstname], [lastname], [email], [phone], [location], [createdby])
	values(@username,@password,@firstname,@lastname,@email,@phone,@location,@createdby)
	Set @message=@username+' registered successfully.'
End

Else
Begin


	UPDATE [HR].[user] SET firstname = @firstname WHERE username = @username
	Set @message=@username+' already exists.'
	IF(@@ROWCOUNT>0)
	BEGIN
	  SET @message ='Row updated sucessfully'
	END

end
END

DECLARE @message VARCHAR(100) 
EXEC spuserRegistration 'user1',NULL,'Anwesha',NULL,NULL,NULL,NULL,NULL,@message out
--EXEC spuserRegistration 'user1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@message out
PRINT @message
--------------------------------------------------------------------------------------------------------------

SELECT * FROM [sales].[persons]

INSERT INTO [sales].[persons] ([first_name], [last_name])
VALUES ('Anwesha', 'Dutta'),
        ('Shyamal','Dutta');



ALTER PROC usp_delete_person( @person_id INT ,@message VARCHAR(100) OUT) AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		-- delete the person
		DELETE FROM sales.persons
		WHERE person_id = @person_id;
		-- if DELETE succeeds, commit the transaction
		IF(@@ROWCOUNT=0)
		 SET @message = 'Not Exist'

		COMMIT TRANSACTION;
	END TRY
		BEGIN CATCH

		-- Test if the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
		PRINT N'The transaction is in an uncommittable state.' + 'Rolling back transaction.'
		ROLLBACK TRANSACTION;
		END;
		-- Test if the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
		PRINT N'The transaction is committable.' + 'Committing transaction.'
		COMMIT TRANSACTION;
		END;
		END CATCH
END;

DECLARE @message VARCHAR(100)
EXEC usp_delete_person 1003,@message out
PRINT @message
------------------------------------------------------------------------------------------------------------

CREATE TABLE [HR].[NewEmployees_tbl] (
    [emp_Id] INT PRIMARY KEY,
    [emp_name] VARCHAR(50),
    [age] INT,
    [salary] DECIMAL(10, 2),
    [dob] DATE,
    [designation] VARCHAR(50),
    --[Reqtype] VARCHAR(50)
);

INSERT INTO [HR].[NewEmployees_tbl]([emp_Id], [emp_name], [age], [salary], [dob], [designation]) VALUES
(1, 'John Smith', 30, 50000.00, '1994-05-15', 'Software Engineer'),
(2, 'Alice Johnson', 28, 55000.00, '1996-10-22', 'Data Analyst'),
(3, 'Michael Brown', 35, 60000.00, '1989-03-10', 'Project Manager'),
(4, 'Emily Wilson', 32, 52000.00, '1992-07-08', 'Marketing Specialist'),
(5, 'David Lee', 40, 70000.00, '1984-12-03', 'Senior Developer');

SELECT * FROM [HR].[NewEmployees_tbl]

ALTER PROCEDURE [spEmployee] (@emp_id  INT=0, @emp_name VARCHAR(50)=NULL, @age INT =0, @salary INT=0, @dob
VARCHAR(20)=NULL, @designation  VARCHAR(50)=NULL, @Reqtype  VARCHAR(10)=NULL )
 AS
 BEGIN
   IF @Reqtype='SELECT'
 BEGIN
	 SELECT emp_id, emp_name, age, salary, dob, designation
	 FROM [HR].[NewEmployees_tbl]
 END
   ELSE IF @Reqtype='INSERT'
 BEGIN
	 INSERT INTO  [HR].[NewEmployees_tbl] 
	 VALUES(@emp_id,@emp_name,@age,@salary,@dob,@designation)
 END

  ELSE IF @Reqtype='DELETE'
 BEGIN
   DELETE FROM  [HR].[NewEmployees_tbl]  WHERE emp_id=@emp_id
END
  ELSE IF @Reqtype='UPDATE'
 BEGIN
	 UPDATE [HR].[NewEmployees_tbl] 
	 SET emp_name=@emp_name, age=@age, salary=@salary, dob=@dob, designation=@designation
	 WHERE emp_id=@emp_id
 END
 END  

 EXEC [spEmployee] @emp_id = 4 , @Reqtype='DELETE'
 -------------------------------------------------------------------------------------------------------------
 --CREATE A STORE PROCEDURE TO RETRIVE CUSTOMER NAME, PRODUCT DETAILS  BY CUSTOMER ID AND PRODUCT ID


 create proc spcust(@customer_id int)
as 
begin
select first_name,last_name,phone,email,street,city,state,zip_code
from sales.customers
where customer_id= @customer_id
end

create proc sppro(@product_id int)
as 
begin
select product_name,model_year,list_price
from production.products
where product_id= @product_id
end

create proc spgetcustdetailsbyproduct(@customer_id int, @product_id int)
as
begin
exec spcust @customer_id
exec sppro @product_id
end
EXEC usp_getdetailsbycustomerId 3





  

--exec spgetcustdetailsbyproduct 1,2

----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
 
 CREATE PROCEDURE usp_getdetailsbycustomerId(@customer_id INT)
 AS 
 BEGIN
	 SELECT  p.product_id, product_name,c.customer_id,first_name, last_name
		FROM [sales].[customers] as c
		 JOIN [sales].[orders] as o
		 ON c.customer_id = o.customer_id
		 JOIN [sales].[order_items] as i
		 ON o.order_id = i.order_id
		 JOIN [production].[products] as p
		 ON p.product_id = i.product_id
		 WHERE c.customer_id =@customer_id
 END

 EXEC usp_getdetailsbycustomerId 3

 ALTER PROCEDURE spgetcustdetailsbyproduct(@customer_id INT)
 AS
 BEGIN
 EXEC usp_getdetailsbycustomerId @customer_id

 END

 ---------------------------------------------------------------------------------------------------------------
 --CREATE A STORE PROCEDURE TO DISPLAY EMPLOYEES AND DEPARTMENT INFORMATION BELONGS TO EUROP REGION NAME AND CITY
ALTER PROCEDURE usp_GetInformationByCountryID(@region_name VARCHAR(100), @city VARCHAR(100))
AS 
BEGIN
 
SELECT first_name, last_name, department_name,city FROM 
[dbo].[employees] AS e
JOIN [dbo].[departments] AS  d
ON e.department_id = d.department_id
JOIN [dbo].[locations] AS l
ON l.location_id = d.location_id
JOIN [dbo].[countries] AS c
ON c.country_id = l.country_id
JOIN [dbo].[regions] AS r
ON r.region_id = c.region_id
WHERE region_name =@region_name  AND city = @city

END

EXEC usp_GetInformationByCountryID 'Europe','London'
------------------------------------------------------------------------------------------------------------

--HANDS-ON ON 09/02/2024
-------------------------------------------------------------------------------------------------------
 ---Create a stored procedure to enroll a student into a course.
 --Before enroll you should check whether the same student enrolled in same course or not.

 -- Create the Course table
 CREATE SCHEMA [HR]
CREATE TABLE [HR].[Course](
    [course_id] INT PRIMARY KEY,
    [course_name] VARCHAR(100)
);
0
-- Insert sample values into the Course table
INSERT INTO [HR].[Course] ([course_id], [course_name]) VALUES
(1, 'Introduction to Programming'),
(2, 'Database Management'),
(3, 'Web Development'),
(4, 'Data Structures and Algorithms');

-- Create the Students table
CREATE TABLE [HR].[Students] (
    [student_id] INT PRIMARY KEY,
    [student_name] VARCHAR(100),
    [course_id] INT,
    FOREIGN KEY (course_id) REFERENCES [HR].[Course](course_id)
);

-- Insert sample values into the Students table
INSERT INTO [HR].[Students] ([student_id], [student_name], [course_id]) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Alice Johnson', 1),
(4, 'Bob Brown', 3);

SELECT * FROM [HR].[Course]
SELECT * FROM [HR].[Students]

CREATE PROCEDURE usp_enrollstudentbycourseId(@student_id INT, @course_id INT)
AS
BEGIN
--CHECK IF THE STUDENT IS ALREADY ENROLLED IN THE COURSE OR NOT

IF EXISTS( SELECT 1 FROM [HR].[Students] WHERE course_id = @course_id AND student_id =@student_id)
 BEGIN
    PRINT 'Student is already enrolled in this course'
 END
 ELSE
     BEGIN
	     INSERT INTO [HR].[Students]([student_id],[course_id])
		 VALUES(@student_id, @course_id)
		 PRINT 'Student Enrolled Sucessfully'
	 END

END;

EXEC  usp_enrollstudentbycourseId 1,1

-------------------------------------------------------------------------------------------------------------
 ---Create a procedure to display information of staffs who have not generated any sales across store

SELECT * FROM [sales].[stores]
SELECT * FROM [sales].[staffs]

ALTER PROCEDURE usp_info(@message VARCHAR(100) out)
AS
BEGIN
 SELECT  sta.first_name,sta.email, o.order_id ,store_name
 FROM [sales].[staffs] AS sta
 LEFT JOIN [sales].[stores] AS sto
 ON sto.store_id = sta.store_id
 LEFT JOIN [sales].[orders] AS o
 ON o.staff_id = sta.staff_id
 LEFT JOIN [sales].[order_items] AS i
 ON o.order_id = i.order_id
 WHERE o.order_id IS NULL
 
 if(@@ROWCOUNT=0)
 BEGIN
  PRINT 'There are no such employees who have not genereated any sales'
  END
END;

DECLARE @message VARCHAR(100)
EXEC  usp_info  @message out
-----------------------------------------------------------------------------------------------------------

--Create a procedure to display products which have not sold across in stores

-----------------------------------------------------------------------------------------------
--INSERT 100000 values

CREATE DATABASE IndexDB
use IndexDB

CREATE TABLE Employee (
[ID] INT,
[Name] VARCHAR(50),
[Salary] INT,
[Gender] VARCHAR(10),
[City] VARCHAR(50),
[Dept] VARCHAR(50)
)
INSERT INTO Employee VALUES (3,'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employee VALUES (1,'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employee VALUES (4,'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employee VALUES (5,'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employee VALUES (7,'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (6,'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employee VALUES (2,'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employee VALUES (8,'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (10,'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employee VALUES (9,'Sara', 500, 'Female', 'London', 'IT')

SELECT * FROM [Employee] WHERE id =3


-- Generate random employee data
WITH RandomData AS (
  SELECT 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
    CONCAT('Employee', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS Name,
    FLOOR(RAND() * 10000) AS Salary,
    CASE WHEN RAND() > 0.5 THEN 'Male' ELSE 'Female' END AS Gender,
    CASE 
      WHEN RAND() > 0.5 THEN 'City1'
      WHEN RAND() > 0.3 THEN 'City2'
      ELSE 'City3'
    END AS City,
    CASE 
      WHEN RAND() > 0.6 THEN 'Dept1'
      WHEN RAND() > 0.3 THEN 'Dept2'
      ELSE 'Dept3'
    END AS Dept
  FROM master..spt_values t1
  CROSS JOIN master..spt_values t2
)
-- Insert random data into the Employee table
INSERT INTO Employee ([ID], [Name], [Salary], [Gender], [City], [Dept])
SELECT 
  ID,
  Name,
  Salary,
  Gender,
  City,
  Dept
FROM RandomData
WHERE ID <= 100000;

SELECT * FROM [Employee]
----------------------------------------------------------------------------------------------------------
INSERT INTO Employee (ID, Name, Salary, Gender, City, Dept)
SELECT 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
    CONCAT('Employee', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS Name,
    CAST(RAND() * 100000 AS INT) AS Salary,
    CASE WHEN RAND() < 0.5 THEN 'Male' ELSE 'Female' END AS Gender,
    CASE WHEN RAND() < 0.3 THEN 'New York' 
         WHEN RAND() < 0.6 THEN 'Los Angeles'
         ELSE 'Chicago' END AS City,
    CASE WHEN RAND() < 0.2 THEN 'IT' 
         WHEN RAND() < 0.4 THEN 'HR'
         WHEN RAND() < 0.6 THEN 'Finance'
         ELSE 'Operations' END AS Dept
FROM 
    master..spt_values t1
CROSS JOIN 
    master..spt_values t2

	-----------------------------------------------------------
	--CREATING CLUSTERED INDEX--
	----------------------------------------------------------
	---1.WHEN YOU CREATED A TABLE WITHOUT INDEX THEN IT WILL CHECK BY TABLE SCAN 

	--2.WHEN YOU CREATED A TABLE WITH INDEX AND WHEN YOU SEARCH BY THAT COLUMN WHICH YOU CREATE AS INDEX THEN IT
	--WILL SEARCH BY INDEX SEEK

	--3.WHEN YOU CREATED A TABLE WITH INDEX AND WHEN YOU SEARCH BY THAT COLUMN WHICH YOU NOT CREATED AS INDEX THEN
	--SEARCH OPERATION WILL BE BY INDEX SCAN

	----4.WHEN WE GIVE (NOT IN) In NONCLUSTERED INDEX THEN IT WILL CHECK BY INDEX SCAN--

	---5.ONE TABLE CAN HAVE ONE CLUSTERED INDEX BUT WE CAN CREATE MULTIPLE NONCLUSTERED INDEX ---

	---6.WHEN WE CREATE A TABLE USING PRIMARY KEY THEN (CLUSTERED INDEX) WILL BE AUTOMATICALLY
	--CREATED BY SYSTEM

	--7.WHEN WE CREATE A TABLE USING UNIQUE KEY THEN (NONCLUSTERED INDEX) WILL BE AUTOMATICALLY
	--CREATED BY SYSTEM
--------------------------------------------------------------------------------
	--creating clustered index--
------------------------------------------------------------------------------

CREATE CLUSTERED INDEX IX_Employee_ID ON Employee(Id ASC);

	SELECT * FROM [Employee] WHERE Id = 8

	---INDEX SCAN--
    SELECT * FROM [Employee] WHERE gender = 'Male'



	----------------------------------------------------------
	--CREATING NONCLUSTERED INDEX--
	----------------------------------------------------------

	CREATE NONCLUSTERED INDEX IX_Employee_city ON Employee(city ASC);
		SELECT * FROM [Employee] WHERE city = 'London'

--------------------------------------------------------------------------------------------------------

--HOW TO DROP A INDEX--
---------------------------------------------------
--DROP INDEX Employee.IX_Employee_ID

------------------------------


CREATE TABLE [Student]
(
[id] INT UNIQUE ,
[Name] VARCHAR(30)
);


-------------------------------------------------------------------
USE IndexDB

CREATE TABLE tblOrder
(
[Id] INT,
[CustomerId] INT,
[ProductId] Varchar(100),
[ProductName] VARCHAR(50)
)

DECLARE @i int = 0
WHILE @i < 6000
BEGIN
SET @i = @i + 1
IF(@i < 1000)
Begin INSERT INTO tblOrder VALUES (@i, 1, 'Product - 10120', 'Laptop') End
ELSE IF(@i < 2000)
Begin INSERT INTO tblOrder VALUES (@i, 3, 'Product - 1020', 'Mobile') End
Else if(@i < 3000)
Begin INSERT INTO tblOrder VALUES (@i, 2, 'Product - 101', 'Desktop') End
Else if(@i < 4000)
Begin INSERT INTO tblOrder VALUES (@i, 3, 'Product - 707', 'Pendrive') End
Else if(@i < 5000)
Begin INSERT INTO tblOrder VALUES (@i, 2, 'Product - 999', 'HD') End
Else if(@i < 6000)
Begin INSERT INTO tblOrder VALUES (@i, 1, 'Product - 100', 'Tablet')
End
END

SELECT * FROM [tblOrder]

	CREATE NONCLUSTERED INDEX IX_tblOrder_ProductId ON dbo.tblOrder(ProductId ASC)
	INCLUDE([Id],[CustomerId],[ProductName])

	SELECT * FROM tblOrder WHERE ProductId = 'Product – 101'
	SELECT * FROM tblOrder WHERE Productname = 'laptop'

	SELECT * FROM tblOrder WHERE CustomerId = 3 and ProductName = 'Pendrive';

	DROP INDEX tblOrder.IX_tblOrder_ProductId 
    CREATE NONCLUSTERED INDEX IX_tblOrder_ProductId ON dbo.tblOrder(ProductId ASC)

--COMPOSITE NONCLUSTERED INDEX CREATEATION--
-- when we create composite nonclustered index then it will check with index seek

CREATE NONCLUSTERED INDEX IX_tblOrder_CustomerId_ProductId 
ON [tblOrder] ([CustomerId],[ProductName])
INCLUDE ([Id],[ProductId])

	SELECT * FROM tblOrder WHERE CustomerId = 3 and ProductName = 'Pendrive'
		SELECT * FROM tblOrder WHERE CustomerId = 1 and ProductId = 'Product - 10120'
-------------------------------------------------------------------------------------------

--CREATE A TABLE NAME CUSTOMER USING COLUMN CUSTOMER ID, CUSTOMER_NAME, ADDRESS , PHONE, EMAIL,CITY,STATE
--clustered index will be customer_id and unclustered  index  address, phone, email, state


CREATE TABLE CUSTOMER (
    [cust_id] INT,
    [cust_name] VARCHAR(100),
    [address] VARCHAR(255),
    [phone] VARCHAR(20),
    [email] VARCHAR(100),
    [city] VARCHAR(100),
    [state] VARCHAR(50)
);

-- Generate and insert 100000 records into the CUSTOMER table
DECLARE @counter INT = 1;

WHILE @counter <= 100000
BEGIN
    INSERT INTO CUSTOMER ([cust_id], [cust_name], [address], [phone], [email], [city], [state])
    VALUES (@counter, 'CustomerName' + CAST(@counter AS VARCHAR(10)), 'Address' + CAST(@counter AS VARCHAR(10)), 'PhoneNumber' + CAST(@counter AS VARCHAR(10)), 'email' + CAST(@counter AS VARCHAR(10)) + '@example.com', 'City' + CAST(@counter AS VARCHAR(10)), 'State' + CAST(@counter AS VARCHAR(10)));

    SET @counter = @counter + 1;
END
-----------------------------
SELECT * FROM CUSTOMER



CREATE NONCLUSTERED INDEX IX_CUSTOMER_ID ON CUSTOMER([phone],[email],[state],[address])
INCLUDE(cust_name,city)

DROP INDEX CUSTOMER.IX_CUSTOMER_ID


SELECT * FROM CUSTOMER WHERE email ='email1@example.com'--INDEX SEEK
SELECT * FROM CUSTOMER WHERE email ='email1@example.com'--INDEX SCAN

--FOR CHECKING INDEX--
EXEC sp_helpindex IX_CUSTOMER_ID
------------------------------------------------------------------------------------------------



--HANDS-ON ON 12/02/2024
------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
--1.Create a stored procedure to update quantity, list price of order in  order_items table.
------------------------------------------------------------------------------------------------------

--SELECT * FROM [sales].[order_items]

CREATE TABLE [HR].[order_items] (
    [order_id] INT,
    [order_name] VARCHAR(50),
    [quantity] INT,
    [list_price] INT
);

INSERT INTO [HR].[order_items] ([order_id], [order_name], [quantity], [list_price]) VALUES
(1, 'Product A', 3, 2599),
(2, 'Product B', 1, 4999),
(3, 'Product C', 2, 3999),
(4, 'Product D', 5, 1599),
(5, 'Product E', 1, 9999);

CREATE PROCEDURE usp_OrderDetails(@order_id INT ,@quantity INT , @list_price INT , @message VARCHAR(100) OUT)
AS 
BEGIN
    UPDATE [HR].[order_items] SET quantity =@quantity , list_price =@list_price WHERE order_id =@order_id
	

	IF(@@ROWCOUNT<1)
	BEGIN
	 SET @message= 'No Order details Available'
	END
END

SELECT * FROM [HR].[order_items]

DECLARE @message VARCHAR(100)
EXEC usp_OrderDetails 2, 5,5000,@message OUT
--EXEC usp_OrderDetails 8, 8,6000,@message OUT
PRINT @message

--------------------------------------------------------------------------
--create a stored procedure to calculates the total revenue generated for a specific route within a given date range.
-----------------------------------------------------------------------------------------------------------------------

--CREATE TABLE [HR].[CalculateRevenue] (
--    [booking_date] DATE,
--    [route_name] VARCHAR(100),
--    [Passenger_quantity] INT,
--    [Booking_price] INT 
--);

--INSERT INTO [HR].[CalculateRevenue] ([booking_date], [route_name], [Passenger_quantity], [Booking_price]) VALUES
--('2024-01-06', 'Route A', 3, 25),
--('2024-01-07', 'Route A', 1, 25),
--('2024-01-08', 'Route A', 2, 25),
--('2024-01-09', 'Route A', 5, 25),
--('2024-01-10', 'Route A', 1, 25),
--('2024-01-06', 'Route B', 3, 50),
--('2024-01-07', 'Route B', 1, 50),
--('2024-01-08', 'Route B', 2, 50),
--('2024-01-09', 'Route B', 5, 50),
--('2024-01-10', 'Route B', 1, 50),
--('2024-01-06', 'Route C', 3, 100),
--('2024-01-07', 'Route C', 1, 100),
--('2024-01-08', 'Route C', 2, 100),
--('2024-01-09', 'Route C', 5, 100),
--('2024-01-10', 'Route C', 1, 100);

--SELECT * FROM [HR].[CalculateRevenue]

--ALTER PROCEDURE usp_CalculateRevenue (@booking_date DATE, @route_name VARCHAR(100),@message VARCHAR(100) OUT)
--AS
--BEGIN
--   SELECT SUM(Passenger_quantity*Booking_price) AS Revenue
--   FROM [HR].[CalculateRevenue]
--   WHERE  booking_date =@booking_date AND route_name =@route_name


--   IF(@@ROWCOUNT<1)
--   BEGIN
--      SET @message = 'No passenger_available within this date range'
--   END

--END

--DECLARE  @message VARCHAR(100)
--EXEC usp_CalculateRevenue '2024-01-08' ,'Route A' , @message OUT
--PRINT @message
-------------------------------------------------------------------------------------------------

--2.create a stored procedure to calculates the total revenue generated for a specific route within a given date range.
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [HR].[Stations] (
    [StationID] INT PRIMARY KEY,
    [StationName] VARCHAR(100) NOT NULL
);

INSERT INTO [HR].[Stations] ([StationID], [StationName]) VALUES
(1, 'Station A'),
(2, 'Station B'),
(3, 'Station C');

CREATE TABLE [HR].[Trains] (
    [TrainID] INT PRIMARY KEY,
    [TrainName] VARCHAR(100) NOT NULL,
    [SourceStationID] INT,
    [DestinationStationID] INT,
    [DepartureTime] TIME,
    [ArrivalTime]TIME,
    CONSTRAINT FK_SourceStation FOREIGN KEY (SourceStationID) REFERENCES [HR].[Stations](StationID),
    CONSTRAINT FK_DestinationStation FOREIGN KEY (DestinationStationID) REFERENCES [HR].[Stations](StationID)
);

INSERT INTO [HR].[Trains] ([TrainID], [TrainName], [SourceStationID], [DestinationStationID], [DepartureTime], [ArrivalTime]) VALUES
(1, 'Express 1', 1, 3, '08:00:00', '12:00:00'),
(2, 'Local 1', 2, 3, '09:00:00', '11:00:00'),
(3, 'Express 2', 1, 2, '10:00:00', '14:00:00');

--SELECT * FROM [HR].[Trains]

CREATE TABLE [HR].[Passengers] (
    [PassengerID] INT PRIMARY KEY,
    [PassengerName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [Email] VARCHAR(100)
);

INSERT INTO [HR].[Passengers] ([PassengerID], [PassengerName], [Age], [Gender], [Email]) VALUES
(1, 'John Doe', 30, 'Male', 'john.doe@example.com'),
(2, 'Jane Smith', 25, 'Female', 'jane.smith@example.com'),
(3, 'Alice Johnson', 35, 'Female', 'alice.johnson@example.com');

SELECT * FROM [HR].[Passengers]

CREATE TABLE [HR].[Reservations] (
    [ReservationID] INT PRIMARY KEY,
    [TrainID] INT,
    [PassengerID] INT,
    [ReservationDate] DATE,
	[ReservationAmount] INT,
    [SeatNumber] VARCHAR(10),
    CONSTRAINT FK_Train FOREIGN KEY (TrainID) REFERENCES [HR].[Trains](TrainID),
    CONSTRAINT FK_Passenger FOREIGN KEY (PassengerID) REFERENCES [HR].[Passengers](PassengerID)
);


-- Create the table
--DROP TABLE [HR].[Reservations]
CREATE TABLE [HR].[Reservations] (
    [ReservationID] INT PRIMARY KEY,
    [TrainID] INT,
    [PassengerID] INT,
    [ReservationDate] DATE,
	[ReservationAmount] INT,
    [SeatNumber] VARCHAR(10),
    CONSTRAINT FK_Train FOREIGN KEY (TrainID) REFERENCES [HR].[Trains](TrainID),
    CONSTRAINT FK_Passenger FOREIGN KEY (PassengerID) REFERENCES [HR].[Passengers](PassengerID)
);

-- Insert sample data
INSERT INTO [HR].[Reservations] ([ReservationID], [TrainID], [PassengerID], [ReservationDate], [ReservationAmount], [SeatNumber])
VALUES
(1, 1, 1, '2024-02-11', 50, 'A1'),
(2, 2, 2, '2024-02-12', 60, 'B3'),
(3, 3, 3, '2024-02-13', 70, 'C5');

-- Confirm the data has been inserted
SELECT * FROM [HR].[Reservations];


CREATE PROCEDURE usp_calculateTotalRev(
							@source_id INT,
							@dest_id INT,
							@start_date DATE,
							@end_date DATE,
							@total_revenue DEC(10,2) OUT
						)
AS
BEGIN
		SELECT @total_revenue=SUM(r.ReservationAmount)
		FROM [HR].[Reservations] AS r
		JOIN [HR].[Trains] AS t 
		ON t.TrainID=r.TrainID
		WHERE t.SourceStationID=@source_id and t.DestinationStationID=@dest_id
		AND r.ReservationDate BETWEEN @start_date AND @end_date
END

SELECT * FROM [HR].[Reservations]
SELECT * FROM [HR].[Trains]

DECLARE @totalRevenue DECIMAL(10,2)
EXEC usp_calculateTotalRev 1, 3, '2024-02-11', '2024-02-13', @totalRevenue OUT;
SELECT @totalRevenue AS TotalRevenue;
--------------------------------------------------------------------------------------------------------

--3.Create a procedure to display patients information like patient id, name, hospital,
--doctors, prescription and duration.
--Display duration as "3 Days 8 Hours 30 Minutes"
------------------------------------------------------------------------------------------------------------

CREATE TABLE [HR].[Doctors] (
    [DoctorID] INT PRIMARY KEY,
    [DoctorName] VARCHAR(100) NOT NULL,
    [Specialization] VARCHAR(100),
    [PhoneNumber] VARCHAR(20)
);

INSERT INTO [HR].[Doctors] ([DoctorID], [DoctorName], [Specialization], [PhoneNumber]) VALUES
(1, 'Dr. John Smith', 'Cardiology', '123-456-7890'),
(2, 'Dr. Sarah Johnson', 'Orthopedics', '987-654-3210'),
(3, 'Dr. Emily Davis', 'Pediatrics', '456-789-0123');


CREATE TABLE [HR].[Patients] (
    [PatientID] INT PRIMARY KEY,
    [PatientName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [DoctorID] INT, -- Foreign Key referencing Doctors table
    CONSTRAINT FK_Doctor FOREIGN KEY (DoctorID) REFERENCES [HR].[Doctors](DoctorID)
);

INSERT INTO [HR].[Patients] ([PatientID], [PatientName], [Age], [Gender], [DoctorID]) VALUES
(1, 'Alice Johnson', 35, 'Female', 1),
(2, 'Bob Smith', 45, 'Male', 2),
(3, 'Emma Davis', 25, 'Female', 3);

CREATE TABLE [HR].[Medicines] (
    [MedicineID] INT PRIMARY KEY,
    [MedicineName] VARCHAR(100) NOT NULL,
    [Quantity] INT
);

INSERT INTO [HR].[Medicines] ([MedicineID], [MedicineName], [Quantity]) VALUES
(1, 'Paracetamol', 100),
(2, 'Ibuprofen', 150),
(3, 'Aspirin', 200);

CREATE TABLE [HR].[Prescriptions](
    [PrescriptionID] INT PRIMARY KEY,
    [PatientID] INT, -- Foreign Key referencing Patients table
    [MedicineID] INT, -- Foreign Key referencing Medicines table
    [PrescriptionDate] DATE,
    [Dosage] VARCHAR(50),
    CONSTRAINT FK_Patient FOREIGN KEY (PatientID) REFERENCES [HR].[Patients](PatientID),
    CONSTRAINT FK_Medicine FOREIGN KEY (MedicineID) REFERENCES [HR].[Medicines](MedicineID)
);

INSERT INTO [HR].[Prescriptions] ([PrescriptionID], [PatientID], [MedicineID], [PrescriptionDate], [Dosage]) VALUES
(1, 1, 1, '2024-02-10', '1 tablet per day'),
(2, 2, 2, '2024-02-11', '2 tablets every 6 hours'),
(3, 3, 3, '2024-02-12', '1 tablet every 8 hours');
--------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--4.Create a procedure to display available flights between two airports on a specific date.
------------------------------------------------------------------------------------------------------

CREATE TABLE [HR].[Airports] (
    [AirportCode] VARCHAR(3) PRIMARY KEY,
    [AirportName] VARCHAR(100) NOT NULL,
    [City] VARCHAR(100) NOT NULL,
    [Country] VARCHAR(100) NOT NULL
);

INSERT INTO [HR].[Airports] ([AirportCode], [AirportName], [City], [Country]) VALUES
('JFK', 'John F. Kennedy International Airport', 'New York', 'United States'),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'United States'),
('LHR', 'Heathrow Airport', 'London', 'United Kingdom');


 --DROP TABLE [HR].[Flights]
CREATE TABLE [HR].[Flights] (
    [FlightID] INT PRIMARY KEY,
    [FlightNumber] VARCHAR(10) NOT NULL,
    [DepartureAirportCode] VARCHAR(3),
    [ArrivalAirportCode] VARCHAR(3),
    [DepartureTime] DATE,
    [ArrivalTime] DATE,
 
    CONSTRAINT FK_DepartureAirport FOREIGN KEY (DepartureAirportCode) REFERENCES [HR].[Airports](AirportCode),
    CONSTRAINT FK_ArrivalAirport FOREIGN KEY (ArrivalAirportCode) REFERENCES [HR].[Airports](AirportCode)
);


INSERT INTO [HR].[Flights] ([FlightID], [FlightNumber], [DepartureAirportCode], [ArrivalAirportCode], [DepartureTime], [ArrivalTime]) VALUES
(1, 'AA123', 'JFK', 'LAX', '2024-02-10 08:00:00', '2024-02-10'),
(2, 'UA456', 'LAX', 'JFK', '2024-02-10 12:00:00', '2024-02-10'),
(3, 'BA789', 'LHR', 'JFK', '2024-02-10 09:00:00', '2024-02-10');

SELECT * FROM [HR].[Airports]
SELECT * FROM [HR].[Flights]

CREATE PROCEDURE usp_findavailableflights
(
@DepartureAirportCode VARCHAR(100),
@ArrivalAirportCode VARCHAR(100),
@ArrivalTime DATE,
@message VARCHAR(100) OUT
)
AS
BEGIN
     SELECT AirportCode, AirportName,f1.*
	 FROM [HR].[Flights] AS f1
	 JOIN [HR].[Airports] AS a
	 ON f1.DepartureAirportCode = a.AirportCode
	 JOIN [HR].[Flights] AS f2
	 ON f2.ArrivalAirportCode =a.AirportCode
	 WHERE f2.DepartureAirportCode =@DepartureAirportCode
	 AND  f2.ArrivalAirportCode =@ArrivalAirportCode
	 AND f2.ArrivalTime =@ArrivalTime 

	 IF(@@ROWCOUNT<1)
	 BEGIN
	   SET @message = 'No flight_Available'
	 END
END;

DECLARE @message VARCHAR(100)
EXEC usp_findavailableflights 'JFK','LAX' ,'2024-02-10',@message OUT

SELECT * FROM [HR].[Airports]
SELECT * FROM [HR].[Flights]

-----------------------------------------------------------------------------------------------------

--5.Create a procedure allows users to book a flight providing flight, passenger,
--seat and reservation date in passenger table.
---------------------------------------------------------------------------------------------------

SELECT * FROM [HR].[Airports]

CREATE TABLE [HR].[Airlines] (
    [AirlineID] INT PRIMARY KEY,
    [AirlineName] VARCHAR(100) NOT NULL,
    [IATA_Code] VARCHAR(2) NOT NULL
);

INSERT INTO [HR].[Airlines] ([AirlineID], [AirlineName], [IATA_Code]) VALUES
(1, 'American Airlines', 'AA'),
(2, 'United Airlines', 'UA'),
(3, 'British Airways', 'BA');



CREATE TABLE [HR].[Flight] (
    [FlightID] INT PRIMARY KEY,
    [AirlineID] INT,
    [FlightNumber] VARCHAR(10) NOT NULL,
    [DepartureAirportCode] VARCHAR(3),
    [ArrivalAirportCode] VARCHAR(3),
    [DepartureTime] DATETIME,
    [ArrivalTime] DATETIME,
    CONSTRAINT FK_Airline FOREIGN KEY (AirlineID) REFERENCES [HR].[Airlines](AirlineID),
    CONSTRAINT FK_DepartureAirports FOREIGN KEY (DepartureAirportCode) REFERENCES[HR].[Airports](AirportCode),
    CONSTRAINT FK_ArrivalAirports FOREIGN KEY (ArrivalAirportCode) REFERENCES [HR].[Airports](AirportCode)
);

INSERT INTO [HR].[Flight] ([FlightID], [AirlineID], [FlightNumber], [DepartureAirportCode], [ArrivalAirportCode], [DepartureTime], [ArrivalTime]) VALUES
(1, 1, 'AA123', 'JFK', 'LAX', '2024-02-10 08:00:00', '2024-02-10 11:00:00'),
(2, 2, 'UA456', 'LAX', 'JFK', '2024-02-10 12:00:00', '2024-02-10 15:00:00'),
(3, 3, 'BA789', 'LHR', 'JFK', '2024-02-10 09:00:00', '2024-02-10 14:00:00');

SELECT * FROM [HR].[Flight]

CREATE TABLE [HR].[Passenger_Details] (
    [PassengerID] INT PRIMARY KEY,
    [PassengerName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [Email] VARCHAR(100)
);

INSERT INTO [HR].[Passenger_Details] ([PassengerID], [PassengerName], [Age], [Gender], [Email]) VALUES
(1, 'John Doe', 30, 'Male', 'john.doe@example.com'),
(2, 'Jane Smith', 25, 'Female', 'jane.smith@example.com'),
(3, 'Alice Johnson', 35, 'Female', 'alice.johnson@example.com');


CREATE TABLE [HR].[Flight_Reservations] (
    [ReservationID] INT PRIMARY KEY,
    [FlightID] INT,
    [PassengerID] INT,
    [ReservationDate] DATE,
    [SeatNumber] VARCHAR(10),
    CONSTRAINT FK_Flight_new FOREIGN KEY (FlightID) REFERENCES [HR].[Flight](FlightID),
    CONSTRAINT FK_Passenger_new FOREIGN KEY (PassengerID) REFERENCES [HR].[Passengers](PassengerID)
);


-- Insert sample data
INSERT INTO [HR].[Flight_Reservations] ([ReservationID], [FlightID], [PassengerID], [ReservationDate], [SeatNumber])
VALUES
(1, 1, 3, '2024-02-11', 'A1'),
(2, 2, 2, '2024-02-12', 'B3'),
(3, 3, 1, '2024-02-13', 'C5');

-- Confirm the data has been inserted
SELECT * FROM [HR].[Flight_Reservations];
SELECT * FROM [HR].[Flight]
--SELECT * FROM[HR].[Passengers]
SELECT * FROM[HR].[Passenger_Details]

CREATE PROCEDURE usp_bookingFlight
(
	@ReservationID INT,
	@FlightID INT,
	@PassengerID INT,
	@SeatNumber VARCHAR(50),
	@ReservationDATE DATE
)
AS
BEGIN
SET NOCOUNT ON;

--check if the provided flight ID exists
IF NOT EXISTS (SELECT 1 FROM [HR].[Flight] WHERE [FlightID] = @FlightID)
    BEGIN
        RAISERROR ('Invalid FlightID. Please provide a valid FlightID.', 16, 1);
        RETURN;
    END;

-- Check if the provided passenger ID exists
    IF NOT EXISTS (SELECT 1 FROM [HR].[Passenger_Details] WHERE [PassengerID] = @PassengerID)
    BEGIN
        RAISERROR ('Invalid PassengerID. Please provide a valid PassengerID.', 16, 1);
        RETURN
    END;

	 -- Insert the reservation
	 
    INSERT INTO [HR].[Flight_Reservations] ([ReservationID],[FlightID], [PassengerID], [ReservationDate], [SeatNumber])
    VALUES (@ReservationID,@FlightID, @PassengerID, @ReservationDate, @SeatNumber);
    PRINT 'Flight booked successfully.';
	
END;

--EXEC usp_bookingFlight 4,1,1,'A1','2024-02-11'
EXEC usp_bookingFlight 1,1,3,'A1','2024-02-11'
EXEC usp_bookingFlight 5,2,3,'B3','2024-02-15'


---------------------------------------------------------------------------------------------------
--6.Create a procedure allow users to cancel a reservation based on the reservation ID.
-----------------------------------------------------------------------------------------------------
CREATE PROCEDURE usp_cancel_reservation(@ReservationID INT )
AS
BEGIN
   SET NOCOUNT ON  
     -- Check if the provided reservation ID exists
    IF NOT EXISTS (SELECT 1 FROM [HR].[Flight_Reservations] WHERE [ReservationID] = @ReservationID)
    BEGIN
        RAISERROR ('Invalid ReservationID. Please provide a valid ReservationID.', 16, 1);
        RETURN;
    END;
	--Cancel Reservation
   DELETE FROM [HR].[Flight_Reservations] WHERE ReservationID=@ReservationID 
   PRINT('Reservation Cancel Sucessfully')
END

SELECT * FROM [HR].[Flight_Reservations]

--EXEC usp_cancel_reservation 4
EXEC usp_cancel_reservation 5


--7.Create a procedure retrieves all reservations made by a specific passenger
-------------------------------------------------------------------------------------------
CREATE PROCEDURE usp_find_reservationdetails (@PassengerID INT,@message VARCHAR(100) OUT)
AS
BEGIN
  SELECT * FROM [HR].[Flight_Reservations] WHERE PassengerID =@PassengerID 

  IF(@@ROWCOUNT<1)
  BEGIN 
    SET @message = 'No details avilable'
  END
END

DECLARE @message VARCHAR(100) 
EXEC  usp_find_reservationdetails 1  ,@message  OUT
--EXEC  usp_find_reservationdetails 5  ,@message  OUT
PRINT @message


--8.Write a query to book a flight for a passenger with a 
--specified seat number within a transaction to ensure atomicity.

--9.write a query cancels a reservation for a specific passenger within a transaction to ensure consistency.

--10.write a query to transfer a reservation from one flight to another for a 
--specific passenger within a transaction to ensure integrity.

--11.Create a procedure to retrieve the no. of patients assigned to each doctor in a hospital. 
--No parameters to be defined to procedures.
-------------------------------------------------------------------------------------------------

CREATE TABLE [HR].[Doctor] (
    [DoctorID] INT PRIMARY KEY,
    [DoctorName] VARCHAR(100) NOT NULL,
    [Specialization] VARCHAR(100),
    [PhoneNumber] VARCHAR(20)
);

INSERT INTO [HR].[Doctor] ([DoctorID], [DoctorName], [Specialization], [PhoneNumber]) VALUES
(1, 'Dr. John Smith', 'Cardiology', '123-456-7890'),
(2, 'Dr. Sarah Johnson', 'Orthopedics', '987-654-3210'),
(3, 'Dr. Emily Davis', 'Pediatrics', '456-789-0123');


CREATE TABLE [HR].[Patient] (
    [PatientID] INT PRIMARY KEY,
    [PatientName] VARCHAR(100) NOT NULL,
    [Age] INT,
    [Gender] VARCHAR(10),
    [DoctorID] INT, -- Foreign Key referencing Doctors table
    CONSTRAINT FK_Doctors FOREIGN KEY (DoctorID) REFERENCES [HR].[Doctor](DoctorID)
);

INSERT INTO [HR].[Patient] ([PatientID], [PatientName], [Age], [Gender], [DoctorID]) VALUES
(1, 'John Doe', 30, 'Male', 1),
(2, 'Jane Smith', 25, 'Female', 1),
(3, 'Alice Johnson', 35, 'Female', 2),
(4, 'Anwesha Dutta', 24, 'Female', 3),
(5, 'Sujata Patra', 36, 'Female', 3);



SELECT * FROM [HR].[Doctor]
SELECT * FROM [HR].[Patient]

CREATE PROCEDURE usp_find_details
AS
BEGIN
    SELECT d.DoctorId, DoctorName ,COUNT(PatientID) AS 'No_of_Patients'
	FROM [HR].[Doctor] AS d
	JOIN [HR].[Patient] AS p
	ON d.DoctorID = p.DoctorID
	GROUP BY d.DoctorId, DoctorName

END

EXEC usp_find_details
--------------------------------------------------------------------------------------------------

--12.Create a procedure to retrieve details of prescriptions for a specific patient, 
--including medicine details defining one input parameter - @PatientID.
-----------------------------------------------------------------------------------
SELECT * FROM [HR].[Patient]

SELECT * FROM[HR].[Medicines]

SELECT * FROM [HR].[Prescriptions]

SELECT * FROM[HR].[Doctor]



CREATE PROCEDURE usp_details_of_prescriptions
(
	@PatientID INT,
	@message VARCHAR(100) OUT
)
AS 
BEGIN
  SELECT p.PatientID, PatientName, Age, Gender, m.MedicineID,MedicineName,PrescriptionID,PrescriptionDate,Dosage
  FROM [HR].[Patient] AS p
  JOIN [HR].[Prescriptions] AS pre
  ON p.PatientID = pre.PatientID
  JOIN [HR].[Medicines] AS m
  ON pre.MedicineID = m.MedicineID
  WHERE p.PatientID =@PatientID

  IF(@@ROWCOUNT<1)
  SET @message = 'No Details Available'

END;

DECLARE @message VARCHAR(100)
EXEC usp_details_of_prescriptions 2,@message OUT
PRINT @message
---------------------------------------------------------------------------------------------------------

--13.create a procedure with two input parameters - @MedicineID and @NewQuantity 
--to update the quantity of a specific medicine in the inventory.
-----------------------------------------------------------------------------------------

SELECT * FROM [HR].[Medicines]

CREATE PROCEDURE usp_update_quantity
(
@MedicineID INT ,
@NewQuantity INT,
@message VARCHAR(100) OUT
)
AS
BEGIN
   UPDATE [HR].[Medicines] SET Quantity =@NewQuantity WHERE MedicineID = @MedicineID
   IF(@@ROWCOUNT<1)
   BEGIN
    SET @message ='No Records Available'
   END
END;

DECLARE @message VARCHAR(100)
EXEC usp_update_quantity 1, 400,@message OUT
--EXEC usp_update_quantity 5, 200,@message OUT
PRINT @message

SELECT *FROM [HR].[Medicines]
-------------------------------------------------------------------------------------------------------------------

--14.create a procedure without any input parameter to retrieve patients who have overdue prescriptions.
--------------------------------------------------------------------------------------------------------

SELECT * FROM [HR].[Patients]

 --Create the new_patient_tbl table

SELECT * FROM [HR].[Prescriptions]
SELECT * FROM [HR].[Medicines]

--DROP TABLE [HR].[new_Prescriptions]
CREATE TABLE [HR].[new_Prescriptions] (
    [PrescriptionID] INT PRIMARY KEY,
    [PatientID] INT, -- Foreign Key referencing Patients table
    [MedicineID] INT, -- Foreign Key referencing Medicines table
    [PrescriptionDate] DATE,
    [DueDate] DATE, -- Comma was missing here
    [Dosage] VARCHAR(50), -- Space was missing here
    CONSTRAINT FK_Patients FOREIGN KEY (PatientID) REFERENCES [HR].[Patients](PatientID),
    CONSTRAINT FK_Medicines FOREIGN KEY (MedicineID) REFERENCES [HR].[Medicines](MedicineID)
);


INSERT INTO [HR].[new_Prescriptions] ([PrescriptionID], [PatientID], [MedicineID], [PrescriptionDate], [DueDate], [Dosage])
VALUES
(1, 1, 1, '2024-02-11', '2024-02-25', '1 pill daily'),
(2, 2, 2, '2024-02-10', '2024-02-20', '2 pills twice a day'),
(3, 3, 3, '2024-02-12', '2024-02-28', '1 teaspoon thrice a day'),
(4, 1, 2, '2024-02-05', '2024-02-10', '1 pill before bedtime'),
(5, 2, 3, '2024-02-15', '2024-02-25', '1 tablet with meals');

SELECT * FROM [HR].[new_Prescriptions]



CREATE PROCEDURE RetrieveOverduePatients (@message VARCHAR(100) OUT)
AS
BEGIN
    -- Declare variables
    DECLARE @Today DATE = GETDATE();

    -- Temporary table to store results
    CREATE TABLE #OverduePatients (
        [PatientID] INT,
        [PatientName] VARCHAR(100),
        [PrescriptionID] INT,
        [MedicineID] INT,
        [PrescriptionDate] DATE,
        [Dosage] VARCHAR(50),
        [DueDate] DATE
    );

    -- Insert overdue patients into the temporary table
	-----------------------------------------------------------------------------------------------
    INSERT INTO #OverduePatients ([PatientID], [PatientName], [PrescriptionID], [MedicineID], [PrescriptionDate], [Dosage], [DueDate])
    SELECT p.[PatientID], p.[PatientName], pr.[PrescriptionID], pr.[MedicineID], pr.[PrescriptionDate], pr.[Dosage], pr.[DueDate]
    FROM [HR].[Patients] AS p
    INNER JOIN [HR].[new_Prescriptions] AS pr
	ON p.[PatientID] = pr.[PatientID]
    INNER JOIN [HR].[Medicines] m 
	ON pr.[MedicineID] = m.[MedicineID]
    WHERE pr.[DueDate] < @Today;

    -- Select results from the temporary table
    SELECT [PatientID], [PatientName], [PrescriptionID], [MedicineID], [PrescriptionDate], [Dosage], [DueDate]
    FROM #OverduePatients;

    -- Drop the temporary table
    --DROP TABLE #OverduePatients;

	 IF(@@ROWCOUNT<1)
	 BEGIN
	   SET @message ='No such Patients available'
	 END
END;

DECLARE @message VARCHAR(100)
EXEC RetrieveOverduePatients @message OUT
PRINT @message

--------------------------------------------------------------------------------------------------------
---15.create a procedure with input parameters - PatientID, PatientName,  Age, Gender, DoctorID 
-- to add a new patient to the system .

SELECT * FROM [HR].[Doctor]
SELECT * FROM [HR].[Patient]

CREATE PROCEDURE usp_add_patient
(
	@PatientID INT,
	@PatientName VARCHAR(100) ,
	@Age INT,
	@Gender VARCHAR(50),
	@DoctorID INT
--@message VARCHAR(100) OUT
)
AS
BEGIN
   INSERT INTO [HR].[Patient]([PatientID],[PatientName],[Age],[Gender],[DoctorID])
   VALUES(@PatientID, @PatientName, @Age, @Gender, @DoctorID)

END;

EXEC usp_add_patient 6, 'Subrata Chattaraj',24,'Male', 1


---Write a query to book a flight for a passenger 
--with a specified seat number within a transaction to ensure atomicity.
--======================================================================================
SELECT * FROM [HR].[Flight]
SELECT * FROM [HR].[Passengers]
SELECT * FROM [HR].[Flight_Reservations]

alter PROCEDURE usp_booking_flight
(
  
  @ReservationID INT,
  @PassengerID INT,
  @PassengerName VARCHAR(100),
  @Age INT ,
  @Gender VARCHAR(10),
  @Email VARCHAR(100),
  @FlightID INT,
  @ReservationDate DATE,
  @SeatNumber VARCHAR(10)
 )
 AS
BEGIN
  BEGIN TRANSACTION 
      IF EXISTS(SELECT * FROM [HR].[Passengers] WHERE PassengerID = @PassengerID)
		BEGIN
		      IF EXISTS(SELECT FlightID FROM [HR].[Flights] WHERE FlightID=@FlightID)
				BEGIN
					IF NOT EXISTS(SELECT SeatNumber FROM [HR].[Flight_Reservations] WHERE FlightID=@FlightID AND SeatNumber=@SeatNumber)
						BEGIN
							INSERT INTO [HR].[Flight_Reservations]
							([ReservationID],[FlightID],[PassengerID],[ReservationDate],[SeatNumber])
							VALUES(@ReservationID,@FlightID,@PassengerID, @ReservationDate,@SeatNumber)
							PRINT 'Successfully booked the flight'
							COMMIT
						END
					ELSE 
						BEGIN
							ROLLBACK 
							PRINT 'Seat Number already booked'
						END
				END
				ELSE
					BEGIN
						ROLLBACK TRAN
						PRINT 'Flight does not exist in the flight table'
					END

			END
			ELSE
				BEGIN
					INSERT INTO [HR].[Passengers]([PassengerID],[PassengerName],[Age],[Gender],[Email])
					VALUES(@PassengerID,@PassengerName,@Age,@Gender,@Email)
					PRINT 'Sucessfully Inserted into the passenger table '

					IF EXISTS( SELECT FlighTID FROM [HR].[Flights] WHERE FlightID=@FlightID)
						BEGIN
							INSERT INTO [HR].[Flight_Reservations]([ReservationID],[FlightID],[PassengerID],[ReservationDate],[SeatNumber])
							VALUES(@ReservationID,@FlightID,@PassengerID,@ReservationDate,@SeatNumber)
							PRINT 'Successfully Booked'
						END
					ELSE
						BEGIN	
							ROLLBACK TRAN
							PRINT 'Flight id does not exist'
					 END
				END
 END


 EXEC usp_booking_flight 4,2, 'Anwesha Dutta', 24,'Female','anweshadutta891@gmail.com',4, '2024-02-15', 'A5'
 EXEC usp_booking_flight 4,2, 'Anwesha Dutta', 24,'Female','anweshadutta891@gmail.com',1, '2024-02-15', 'A5'
 EXEC usp_booking_flight 5,4, 'Subrata Pal', 25,'male','subratapal122@gmail.com',2, '2024-02-15', 'A5'
 EXEC usp_booking_flight 6,4, 'Subrata Pal', 25,'male','subratapal122@gmail.com',1, '2024-02-15', 'A5'

 exec usp

 --HANDS-ON ON 13/02/2024--
 -------------------------------------------------------------------------
 USE IndexDB
 CREATE SCHEMA [HR]
 --drop table [HR].[New_Employee]
 CREATE TABLE [HR].[New_Employee]
 (
 [id] INT UNIQUE,
 [Name] VARCHAR(100)
 )

 CREATE UNIQUE CLUSTERED INDEX IX_example_id ON [HR].[New_Employee](id ASC)
 DROP INDEX  [HR].[New_Employee].IX_example_id

-- SELECT 
--    i.name AS IndexName,
--    i.type_desc AS IndexType,
--    c.name AS ColumnName
--FROM 
--    sys.indexes AS i
--INNER JOIN 
--    sys.index_columns AS ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
--INNER JOIN 
--    sys.columns AS c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
--WHERE 
--    i.object_id = OBJECT_ID([HR].[New_Employee]);


CREATE DATABASE TriggerDB
USE TriggerDB

CREATE SCHEMA [HR]

--DROP TABLE [HR].[Employee]
CREATE TABLE [HR].[Employee]
(
	[Id] int Primary Key,
	[Name] nvarchar(30),
	[Salary] int,
	[Gender] nvarchar(10),
	[DepartmentId] int
)

INSERT INTO [HR].[Employee] VALUES (1,'Bhaskar', 5000, 'Male', 3)
INSERT INTO[HR].[Employee] VALUES (2,'Annapurna', 5400, 'Female', 2)
INSERT INTO [HR].[Employee] VALUES (3,'Dilip', 6500, 'male', 1)
INSERT INTO [HR].[Employee] VALUES (4,'Shyamal', 4700, 'Male', 2)
INSERT INTO [HR].[Employee] VALUES (5,'Krishna', 6600, 'Female', 3)

SELECT * FROM [HR].[Employee]


DROP TRIGGER [HR].[Employee]. trInsertEmployee

--INSERT--
-----------------------------------------------------------------
CREATE TRIGGER trInsertEmployee ON [HR].[Employee]
FOR INSERT
AS
BEGIN
PRINT 'YOU CANNOT PERFORM INSERT OPERATION'
ROLLBACK TRANSACTION
END

INSERT INTO [HR].[Employee] VALUES(6,'Anwesha', 7600,'Female',1)

--UPDATE--
---------------------------------------------------------------------------
CREATE TRIGGER trUpdateEmployee ON [HR].[Employee]
FOR UPDATE
AS
BEGIN
PRINT 'YOU CANNOT PERFORM UPDATE OPERATION'
ROLLBACK TRANSACTION
END

 UPDATE [HR].[Employee] SET Salary = 90000 WHERE Id = 1

 -----------------------------------------------------------------------------------

 --ransaction which will roll back the DELETE operation and print a message.

CREATE TRIGGER trDeleteEmployee ON [HR].[Employee]
FOR DELETE
AS
BEGIN
PRINT 'YOU CANNOT PERFORM DELETE OPERATION'
ROLLBACK TRANSACTION
END

DELETE FROM [HR].[Employee] WHERE Id = 1

drop trigger trDeleteEmployee
--ALL DML Operation--
----------------------------------------------------------------------
DROP TRIGGER hr.trAllDMLOperationsOnEmployee

CREATE TRIGGER trAllDMLOperationsOnEmployee ON [HR].[Employee]
FOR INSERT, UPDATE, DELETE
AS
BEGIN
PRINT 'YOU CANNOT PERFORM DML OPERATION'
ROLLBACK TRANSACTION
END


-- Create a Trigger that will restrict all the DML operations on the Employee table on MONDAY only.
ALTER TRIGGER [HR].trAllDMLOperationsOnEmployee ON [HR].[Employee]
FOR INSERT, UPDATE, DELETE
AS
BEGIN
IF DATEPART(DW,GETDATE())= 2
BEGIN
PRINT 'DML OPERATIONS ARE RESTRICTED ON MONDAY'
ROLLBACK TRANSACTION
END
END



ALTER TRIGGER [HR].trAllDMLOperationsOnEmployee ON [HR].[Employee]
FOR INSERT, UPDATE, DELETE
AS
BEGIN
IF DATEPART(HH,GETDATE()) < 13
BEGIN
PRINT 'INVALID TIME'
ROLLBACK TRANSACTION
END
END

--CREATE TRIGGER [HR].trAllDMLOperationsOnEmployee ON [HR].[Employee]
--FOR INSERT
--AS
--BEGIN
--FOR INSERT
--BEGIN
--PRINT 'YOU CANNOT PERFORM INSERT OPERATION'
--ROLLBACK TRANSACTION
--END


INSERT INTO [HR].[Employee] VALUES(6,'Anwesha', 7600,'Female',1)

SELECT * FROM [HR].[Employee]

--DISABLE TRIGGER trAllDMLOperationsOnEmployee o

--DROP TRIGGER hr.[trDeleteEmployee]


--HANDS-ON ON 14/02/2024--

use TriggerDB

--WITH ROLLBACK--
---------------------------------------------
ALTER TRIGGER [HR].trInsertEmployee ON [HR].[Employee]
FOR INSERT
AS
BEGIN
SELECT * FROM INSERTED
ROLLBACK
END


--INSERT INTO [HR].[Employee] 
--VALUES(8,'Anwesha', 7700,'Female',2)

--DELETE FROM [HR].[Employee] WHERE Id = 8

--INSERT INTO [HR].[Employee] 
--VALUES(7,'Pushpa', 8000,'Female',2)



INSERT INTO [HR].[Employee] 
VALUES(8,'Mandira', 5000,'Female',1)

SELECT * FROM [HR].[Employee]


--WITHOUT ROLLBACK--
--------------------------------------------------------------
ALTER TRIGGER [HR].trInsertEmployee ON [HR].[Employee]
FOR DELETE
AS
BEGIN
SELECT * FROM DELETED
--ROLLBACK
END

--DELETE FROM [HR].[Employee] WHERE Id = 7

--------------------------------------------------
--WITH ROLLBACK 
-------------------------------------------------
ALTER TRIGGER [HR].trInsertEmployee ON [HR].[Employee]
FOR DELETE
AS
BEGIN
SELECT * FROM DELETED
ROLLBACK
END

DELETE FROM [HR].[Employee] WHERE Id = 6

---------------------------------------------------------------------------

CREATE TRIGGER trUpdateEmployee ON [HR].[Employee]
FOR UPDATE
AS
BEGIN
SELECT * FROM DELETED
SELECT * FROM INSERTED
END


UPDATE [HR].[Employee] SET Name = 'Sharma', Salary = 8000 WHERE Id = 5



CREATE TRIGGER [HR].trInsertEmployees ON [HR].[Employee]
FOR INSERT
AS
BEGIN
SELECT * FROM INSERTED
--ROLLBACK
END

INSERT INTO [HR].[Employee] ([Id],[Name],[Salary] ,[Gender], [DepartmentId])
VALUES ( 10,'Chandana', 7000,'Female', 2)


--INSERT INTO [HR].[Employee] 
--VALUES(7,'Mandira', 5000,'Female',1)

--INSERT INTO [HR].[Employee] 
--VALUES(8,'Bandita', 7000,'Female',2)

--INSERT INTO [HR].[Employee] 
--VALUES(9,'Ankita', 6000,'Female',1)
 
      
--DROP TRIGGER [HR].tr_Employee_For_Insert


CREATE TABLE [AuditData]
( 
	[ID] INT PRIMARY KEY,
	[Name] VARCHAR(100),
	[AuditDate] DATETIME
)

create TRIGGER tr_Employee_For_Insert ON [HR].[Employee]
FOR INSERT
AS
BEGIN

	DECLARE @ID INT
	DECLARE @Name VARCHAR(100)
	DECLARE @AuditDate DATETIME

	SELECT @ID = ID, @Name = [Name] FROM INSERTED

	INSERT INTO [AuditData](ID, [Name], AuditDate) VALUES(@ID,@Name ,GETDATE())
END

INSERT INTO [HR].[Employee] VALUES (11, 'Saroj', 3300, 'Male', 2)

SELECT * FROM [HR].[Employee]

INSERT INTO [HR].[Employee] ([Id],[Name],[Salary] ,[Gender], [DepartmentId])
VALUES ( 10,'Chandana', 7000,'Female', 2)

select * from auditdata

--======================================================================================

-- Create EmployeeAudit Table
CREATE TABLE EmployeeAudit
(
ID INT IDENTITY(1,1) PRIMARY KEY,
AuditData VARCHAR(MAX),
AuditDate DATETIME
)
CREATE TRIGGER tr_Employee_For_Insert ON [HR].[Employee]
FOR INSERT
AS
BEGIN
-- Declare a variable to hold the ID Value
DECLARE @ID INT
-- Declare a variable to hold the Name value
DECLARE @Name VARCHAR(100)
-- Declare a variable to hold the Audit data
DECLARE @AuditData VARCHAR(100)
-- Get the ID and Name from the INSERTED Magic table
SELECT @ID = ID, @Name = Name FROM INSERTED
-- Set the AuditData to be stored in the EmployeeAudit table
SET @AuditData = 'New employee Added with ID = ' + Cast(@ID AS VARCHAR(10)) + ' and Name ' + @Name
-- Insert the data into the EmployeeAudit table
INSERT INTO EmployeeAudit (AuditData, AuditDate) VALUES(@AuditData, GETDATE())
END

SELECT * FROM [HR].[Employee]

INSERT INTO [HR].[Employee] VALUES (12, 'Kanishka', 8500, 'Male', 3)

SELECT * FROM [EmployeeAudit]
---------------------------------------------------------------------------------------

--PRACTICE ON TRIGGER
--===============================================================================
--AFTER TRIGGER FOR DELETE EVENT
---------------------------------------------------------------------------------
CREATE TRIGGER tr_Employee_For_Delete ON [HR].[Employee]
FOR DELETE
AS
BEGIN
-- Declare a variable to hold the ID Value
DECLARE @ID INT
DECLARE @Name VARCHAR(100)
DECLARE @AuditData VARCHAR(100)
SELECT @ID = ID, @Name = Name FROM DELETED
SET @AuditData = 'An employee is deleted with ID = ' + Cast(@ID AS VARCHAR(10)) + ' and Name = ' + @Name
INSERT INTO EmployeeAudit (AuditData, AuditDate)VALUES(@AuditData, GETDATE())
END


DELETE FROM [HR].[Employee] WHERE ID = 6DELETE FROM [HR].[Employee] WHERE ID = 11SELECT * FROM [HR].[Employee]SELECT * FROM [EmployeeAudit]--============================================================================== --================================================================================--INSTEAD OF TRIGGER IN SQL SERVER----------------------------------------CREATE TABLE Department
(
	[ID] INT PRIMARY KEY,
	[Name] VARCHAR(50)
)
-- Populate the Department Table with test data
INSERT INTO Department VALUES(1, 'IT')
INSERT INTO Department VALUES(2, 'HR')
INSERT INTO Department VALUES(3, 'Sales')CREATE TABLE Employee
(
	[ID] INT PRIMARY KEY,
	[Name] VARCHAR(50),
	[Gender] VARCHAR(50),
	[DOB] DATETIME,
	[Salary] DECIMAL(18,2),
	[DeptID] INT
)
-- Populate the Employee Table with test data
INSERT INTO Employee VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 25000, 1)
INSERT INTO Employee VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 30000, 2)
INSERT INTO Employee VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060',40000, 2)
INSERT INTO Employee VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 35000, 3)
INSERT INTO Employee VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 27000, 1)
INSERT INTO Employee VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 33000, 2)SELECT * FROM [Department]SELECT * FROM [Employee]--So, let’s create a view that will return the above results.
---------------------------------------------------------------
CREATE VIEW vwEmployeeDetails
AS
SELECT emp.ID, emp.Name, Gender, Salary, dept.Name AS Department
FROM Employee emp
INNER JOIN Department dept
ON emp.DeptID = dept.IDSELECT * FROM vwEmployeeDetails
INSERT INTO vwEmployeeDetails VALUES(7, 'Sujata', 'Female', 60000, 'IT')
--USING INSTEAD OF TO INSERT INTO VIEW TABLE--
---------------------------------------------------------------------

CREATE TRIGGER tr_vwEmployeeDetails_InsteadOfInsert ON vwEmployeeDetails
INSTEAD OF INSERT
AS 
BEGIN
DECLARE @DepartmenttId int
-- First Check if there is a valid DepartmentId in the Department Table
-- for the given Department Name
SELECT @DepartmenttId = dept.ID
FROM Department dept
INNER JOIN INSERTED inst
on inst.Department = dept.Name
--If the DepartmentId is null then throw an error
IF(@DepartmenttId is null)
BEGIN
RAISERROR('Invalid Department Name. Statement terminated', 16, 1)
RETURN
END
-- Finally insert the data into the Employee table
INSERT INTO Employee(ID, Name, Gender, Salary, DeptID)
SELECT ID, Name, Gender, Salary, @DepartmenttId
FROM INSERTED
End

INSERT INTO vwEmployeeDetails VALUES(7, 'Sujata', 'Female', 60000, 'IT')

SELECT * FROM vwEmployeeDetails


--FOR UPDATE--
--------------------------------

SELECT * FROM [HR].[Employee]

CREATE TRIGGER tr_Employee_For_Update ON [HR].[Employee]
FOR UPDATE
AS
  BEGIN
    DECLARE @ID INT 
	DECLARE @Old_Name VARCHAR(100) , @New_Name VARCHAR(100)
	DECLARE @Old_Gender VARCHAR(10) ,@Newd_Gender VARCHAR(10)
	DECLARE @Old_Salary INT, @New_Salary INT
	DECLARE @Old_DepertmentId INT,@New_DepertmentId INT

  END

  DECLARE AuditData VARCHAR(MAX)
  SELECT * INTO #UpdatedDataTempTable
  FROM INSERTED


--================================================================================

--HANDS-ON ON 15/02/2024
-------------------------------------------------------------------
-------------------------------------------------------------------
CREATE DATABASE CTE_DB
CREATE TABLE [Student] 
(
  [ID] INT PRIMARY KEY,
  [Name] VARCHAR(100),
  [City] VARCHAR(100)
  )

  INSERT INTO [Student]([ID],[Name],[City])
  VALUES(1,'Anwesha', 'Bankura'),
  (2,'Manisha', 'Bangalore'),
  (3,'Bandita', 'Bankura'),
  (4,'Chandrani', 'Bangalore')

  SELECT * FROM [Student]
--===============================================
    WITH CTE 
     AS
       (
         SELECT *  FROM [Student]
	      WHERE City ='Bankura'
       )

  SELECT * FROM CTE
  --===================================================

  WITH CTE 
   AS
    (
       SELECT *  FROM [Student]  
    )
  DELETE  FROM [Student] WHERE id = 3 

  SELECT * FROM CTE

  --=====================================================================================
  --Practice--
  ------------------------
  CREATE TABLE [New_Employees]
  ( 
    [id] INT PRIMARY KEY,
	[Name] VARCHAR(100)
  )

  INSERT INTO [New_Employees]([id],[Name])
  VALUES(1,'Anwesha'),
  (2,'Shymal'),
  (3,'Krishna')

  SELECT * FROM [New_Employees]

  --UPDATE WITH CTE--
  ----------------------------------------------
  WITH Practice_CTE 
  AS
  (
   SELECT * FROM [New_Employees]
  )
   UPDATE [New_Employees] SET Name = 'Shyamal' WHERE id = 2




  -- Create the Teacher table
CREATE TABLE [Teacher] (
    [teacher_id] INT PRIMARY KEY,
    [teacher_name] VARCHAR(100)
);

-- Insert values into the Teacher table
INSERT INTO [Teacher] ([teacher_id], [teacher_name]) VALUES
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'Michael Johnson');

SELECT * FROM [Teacher]

-- Create the new_students table
CREATE TABLE [new_students] (
    [student_id] INT PRIMARY KEY,
    [student_name] VARCHAR(100),
    [teacher_id] INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

SELECT * FROM [new_students]
-- Insert values into the new_students table
INSERT INTO [new_students] ([student_id], [student_name], [teacher_id]) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 1),
(4, 'Diana', 3);

  WITH My_CTE
  AS
  (
   SELECT s.teacher_id,teacher_name,Student_id,Student_name FROM [Teacher] AS t
   JOIN [new_students] AS s
   ON t.teacher_id = s.teacher_id

   )
    
	--INSERT INTO My_CTE values(4,'Anirban Roy',5, 'Chandana')
	UPDATE My_CTE set teacher_id=2 WHERE teacher_id=1

	SELECT * FROM [Teacher]
	SELECT * FROM [new_students]

--==============================================================================

USE BikeStores
	
--This example uses the CTE to return the average number of sales orders in 2018 for all sales staffs

WITH New_CTE_sales
AS
(
   SELECT staff_id, COUNT(*) AS order_count 
   FROM [sales].[orders]
   WHERE YEAR(order_date)= 2018
   GROUP BY staff_id
  )

  SELECT AVG(order_count) AS average_orders_by_staff
  FROM New_CTE_sales

--============================================================================================================
  Use [BikeStores]

  ------------------------------------------------------------------------------------------
  --Using multiple SQL Server CTE in a single query
  ------------------------------------------------------------------------------------------
  --The following example uses two CTE cte_category_counts and cte_category_sales 
  --to return the number of the products and
  --sales for each product category.
  --The outer query joins two CTEs using the category_id column.
----------------------------------------------------------------------------------------------------------------------
  WITH cte_category_count(category_id, category_name, product_count)
  AS
  (
	   SELECT c.category_id, c.category_name, COUNT(p.product_id)
	   FROM production.products AS p
	   INNER JOIN production.categories AS c
	   ON c.category_id = p.category_id
	   GROUP BY c.category_id, c.category_name
  ),

  cte_category_sales(category_id, sales)
  AS
	  (
		 SELECT p.category_id, SUM(i.quantity*i.list_price*(1-i.discount)) AS sales
		 FROM sales.order_items AS i
		 INNER JOIN production.products AS p
		 ON p.product_id = i.product_id
		 INNER JOIN sales.orders AS o
		 ON o.order_id = i.order_id
		 WHERE order_status = 4
		 GROUP BY p.category_id
      )

  SELECT c.category_id, c.category_name , c.product_count, s.sales
  FROM cte_category_count AS c
  JOIN cte_category_sales AS s
  ON s.category_id = c.category_id
  ORDER BY c.category_name

  --====================================================================================================
  CREATE TABLE tblDepartment
     ( 
		 DeptId int Primary Key,
		 DeptName nvarchar(20)
     )

 --Insert data into tblDepartment table
 ---------------------------------------------------
 Insert into tblDepartment values (1,'IT')
 Insert into tblDepartment values (2,'Payroll')
 Insert into tblDepartment values (3,'HR')
 Insert into tblDepartment values (4,'Admin')

 SELECT * FROM tblDepartment

 CREATE TABLE tblEmployee
(
	Id int Primary Key,
	Name nvarchar(30),
	Gender nvarchar(10),
	DepartmentId int
)

InsertInsert data into tblEmployee 
---------------------------------------------------
Insert into tblEmployee values (1,'John', 'Male', 3)
Insert into tblEmployee values (2,'Mike', 'Male', 2)
Insert into tblEmployee values (3,'Pam', 'Female', 1)
Insert into tblEmployee values (4,'Todd', 'Male', 4)
Insert into tblEmployee values (5,'Sara', 'Female', 1)
Insert into tblEmployee values (6,'Ben', 'Male', 3)

  
  SELECT * FROM tblDepartment
  SELECT * FROM tblEmployee


  SELECT Name FROM Sysobjects 
  WHERE XTYPE ='U'

  SELECT Name FROM Sysobjects 
  
  --It shows all the user defined objects--
  ---------------------------------------------------
    SELECT * FROM Sysobjects 
  WHERE XTYPE ='U'
  --It shows all the primary keys
  -------------------------------------------------------
  SELECT * FROM Sysobjects 
  WHERE XTYPE ='PK'


  --TABLE VARIABLE--
  ----------------------------------------------------------------
  DECLARE @tblEmployeeCount table (DeptName nvarchar(20), DepartmentId INT, TotalEmployees INT)

  INSERT INTO  @tblEmployeeCount  
  SELECT DeptName, DepartmentId, COUNT(*) AS TotalEmployees 
  FROM tblEmployee 
  JOIN tblDepartment 
  ON tblEmployee.DepartmentId = tblDepartment.DeptId
  GROUP BY DeptName, DepartmentId 


  SELECT DeptName, TotalEmployees
  FROM  @tblEmployeeCount 
  WHERE TotalEmployees>=2

  --------------------------------------------------------------------------------------
  --======================
  --Recursive CTE---
  --======================

  WITH cte_numbers(n, weekday)
  AS 
  (
	  SELECT 0, DATENAME(DW, 0) -- Anchor Member
	  UNION ALL
	  SELECT n+1, DATENAME(DW,n+1) -- Recursive Member
	  FROM cte_numbers
	  WHERE n<6
  )
  SELECT weekday
  FROM cte_numbers

  SELECT @@DATEFIRST 
  ----------------------------------------------------------

     WITH cte_org AS
     (
		 SELECT staff_id, first_name, manager_id
		 FROM sales.staffs
		 WHERE manager_id  IS NULL
		 UNION ALL
		 SELECT e.staff_Id, e.first_name, e.manager_Id
		 FROM sales.staffs e INNER JOIN cte_org AS o
		 ON o.staff_id = e.manager_id
	)

	SELECT * FROM cte_org;

	--=======================================================================

	USE CTE_DB

   Create Table New_tblEmployee
     ( 
		[EmployeeId] int Primary key,
		[Name] nvarchar(20),
		[ManagerId] int
     )


	 -- Create the Job table
	-- drop table [job]
CREATE TABLE [Job] (
    [job_id] INT PRIMARY KEY,
    [job_name] VARCHAR(100)
);

-- Insert values into the Job table
INSERT INTO Job (job_id, job_name) VALUES
(1, 'CEO'),
(2, 'Manager'),
(3, 'Engineer'),
(4, 'Developer'),
(5, 'Analyst'),
(6, 'HR Manager'),
(7, 'Sales Manager'),
(8, 'Accountant'),
(9, 'Marketing Specialist'),
(10, 'Intern');

SELECT * FROM [Job]


-- Create the Employee table
 drop table [Recursive_Employee]
CREATE TABLE [Recursive_Employee] (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Manager_id INT,
    Job_id INT,
    FOREIGN KEY (Manager_id) REFERENCES [Recursive_Employee](Emp_Id),
    FOREIGN KEY (Job_id) REFERENCES Job(job_Id)
);


INSERT INTO  [Recursive_Employee](Emp_Id, Emp_name, Manager_id, Job_id) VALUES
(1, 'John Doe', NULL, 1), 
(2, 'Alice Smith', 1, 2),  
(3, 'Bob Johnson', 2, 3),  
(4, 'Carol Williams',5, 4), 
(5, 'David Brown', 2, 5),   
(6, 'Emily Davis', 7, 6),   
(7, 'Frank Wilson', 3, 7),  
(8, 'Grace Lee', 1, 8);  

SELECT * FROM [Recursive_Employee]

 With RecursiveCTE (Emp_id,  Manager_id, Emp_name,job_name ,[Level]) 
  as
   (
       Select Emp_id,  Manager_id, Emp_name,job_name ,1
       from [Recursive_Employee] AS r
	   join [job] AS j
	   ON j.job_id = r.job_id
	   where Manager_id is null

	   UNION ALL

       Select r.Emp_id,  r.Manager_id, r.Emp_name, j.job_name ,c.[Level] + 1
	   FROM [Recursive_Employee] AS r
	   join RecursiveCTE AS c
	   ON r.Manager_id = c.Emp_id 
	   JOIN [job] as j
	   ON j.job_id = r.job_id 
	  )

--Select EmpCTE.Emp_name as Employee, Isnull(MgrCTE.Emp_name, 'Super Boss') as Manager
--from  RecursiveCTE  AS EmpCTE

SELECT * 
FROM  RecursiveCTE
----------------------------------------------------------------------------------------------

--create a recursive CTE which will generate Bill of Materials for a Laptop, 
--including its components and the quantities required to assemble it.
------------------------------------------------------------------------------------------
--one table is product (product_id primary key) , and product name

--another table is Component_Product(component_product_id, product_id(foreign key) and quantity
--(component_product_id and product id )will be composite primary key
--component_product_id  refer the product_id of product table
--and product_id also refer the product_ID of product table

-- Create the Product table
CREATE TABLE [Product] (
    [Product_Id] INT PRIMARY KEY,
    [Product_Name] VARCHAR(100)
);

-- Insert values into the Product table
INSERT INTO [Product] ([Product_Id], [Product_Name]) VALUES
(1, 'Laptop'),
(2, 'CPU'),
(3, 'RAM'),
(4, 'MotherBoard'),
(5, 'Keyboard'),
(6, 'SSD'),
(7, 'HDD');

-- Create the Component_Product table
CREATE TABLE [Component_Product] (
    Component_Product_id INT,
    Product_id INT,
    Quantity INT,
    PRIMARY KEY (Component_Product_id, Product_id),
    FOREIGN KEY (Component_Product_id) REFERENCES Product(Product_Id),
    FOREIGN KEY (Product_id) REFERENCES Product(Product_Id)
);


-- Insert values into the Component_Product table
INSERT INTO [Component_Product] (Component_Product_id, Product_id, Quantity) VALUES
(1, 1, 10),  
(2, 2, 20),  
(3, 3, 30), 
(4, 4, 40),  
(5, 5, 50), 
(6, 1, 60),  
(6, 4, 70); 

SELECT * FROM [Product]
SELECT * FROM [Component_Product]


	WITH ProductCTE( product_id, product_name, component_product_id, quantity)
	AS
	(
     SELECT c.product_id, product_name, component_product_id, quantity
	 FROM [Product] AS p
	 JOIN [Component_Product] AS c
	 ON p.Product_id= c.Product_id
	--WHERE p.product_id IS NULL

	 UNION ALL

	 SELECT c.product_id, product_name, component_product_id, quantity
     FROM [Product] AS p
	 JOIN [Component_Product] AS c
	 ON p.Product_id= c.Product_id
	 JOIN ProductCTE as pc
	 ON pc.product_id = c.product_id
)

--=======================================================================================
--HANDS-ON ON 16/02/2024--
-----------------------------------------------------------------------------------------
--FIBONACCI SERIES WITH CTE
--Initial Value: n=1, a=0, b=1
--Formula: a=b and b=a+b
--n is number_of_Iteration

WITH Fibonacci_CTE(n, a, b)
AS 
(
SELECT 1, 0,1
UNION ALL 
SELECT n+1,b,a+b
FROM Fibonacci_CTE
WHERE n<10
)
SELECT a AS Fibonacci_Number
FROM Fibonacci_CTE; 


---FACTORIAL USING CTE--

WITH Factorial_CTE(n,Factorial)
AS
( 
  SELECT 1,1
  UNION ALL
  SELECT n+1, (n+1)*Factorial 
  FROM Factorial_CTE
  WHERE n<10
  )
  SELECT Factorial AS Factorial_Result
  FROM Factorial_CTE
  
  --CURSOR--
CREATE DATABASE [Cursor_DB]
USE [Cursor_DB]

--USE [BikeStores]


-- Create the Employee table
CREATE TABLE [Employee] (
   [emp_id] INT PRIMARY KEY,
    [emp_name] VARCHAR(100)
);

-- Insert values into the Employee table
INSERT INTO [Employee] (emp_id, emp_name) VALUES
(1, 'Anwesha Dutta'),
(2, 'Shyamal Dutta'),
(3, 'Krishna Dutta');

SET NOCOUNT ON;
DECLARE @emp_id int ,@emp_name varchar(20), @message varchar(max);
PRINT '-------- EMPLOYEE DETAILS --------';
DECLARE emp_cursor CURSOR FOR
SELECT emp_id,emp_name
FROM Employee order by emp_id;
OPEN emp_cursor
FETCH NEXT FROM emp_cursor INTO @emp_id,@emp_name print 'Employee_ID Employee_Name'
WHILE @@FETCH_STATUS = 0
BEGIN
print ' ' + CAST(@emp_id as varchar(10)) +' '+ cast(@emp_name as varchar(20))
FETCH NEXT FROM emp_cursor INTO @emp_id,@emp_name
END
 CLOSE emp_cursor;
DEALLOCATE emp_cursor;


--============================================================================================================

-- Create the Worker table
CREATE TABLE [Worker] (
    [worker_id] INT PRIMARY KEY,
    [worker_name] VARCHAR(100)
);

-- Insert values into the Worker table
INSERT INTO [Worker] (worker_id, worker_name) VALUES
(1, 'Anwesha'),
(2, 'Sabuj'),
(3, 'Heer');

SET NOCOUNT ON;
DECLARE @worker_id INT , @worker_name VARCHAR(20), @message VARCHAR(MAX) ;
PRINT '--Worker Details--'

DECLARE worker_cursor CURSOR FOR
SELECT worker_id, worker_name
FROM [Worker] 
ORDER BY worker_id
OPEN worker_cursor
FETCH NEXT FROM worker_cursor INTO @worker_id,@worker_name 
PRINT 'Worker_ID Worker_Name'
PRINT ' ' + CAST(@worker_id as varchar(10)) +' '+ cast(@worker_name as varchar(20))--It will return the first row if we write it outside while loop
--WHILE @@FETCH_STATUS = 0
--BEGIN
--print ' ' + CAST(@worker_id as varchar(10)) +' '+ cast(@worker_name as varchar(20))
--FETCH NEXT FROM worker_cursor INTO @worker_id,@worker_name
--END

 CLOSE worker_cursor;
DEALLOCATE worker_cursor;

--==========================================================================================================

-- Create the Old_Table table
CREATE TABLE [Old_Table] (
    [Id] INT PRIMARY KEY,
    [Name] VARCHAR(100),
    [Location] VARCHAR(100)
);

-- Insert values into the Old_Table table
INSERT INTO Old_Table (Id, Name, Location) VALUES
(1, 'John', 'New York'),
(2, 'Alice', 'Los Angeles'),
(3, 'Bob', 'Chicago'),
(4, 'Emma', 'New York'),
(5, 'David', 'Chicago'),
(6, 'Sophia', 'Los Angeles'); 

SELECT * FROM [Old_Table]

-- Create the Location table
--DROP TABLE [Location]
CREATE TABLE [Location] (
    [location_id] INT PRIMARY KEY,
    [location_name] VARCHAR(100)
);

-- Insert values into the Location table
INSERT INTO [Location] VALUES
(1, ''),
(2, ''),
(3, ''),
(4, ''),
(5,''),
(6,'');

SELECT * FROM [Location]

ALTER PROCEDURE usp_Procedure 
AS
BEGIN
     SET NOCOUNT ON;
    DECLARE @Id INT;
	SET @id = 1

	declare @Name VARCHAR(50)
	declare @Location VARCHAR(80)


	--PRINT '--Old_Table Details--'

      DECLARE Practice_cursor CURSOR FOR
        SELECT [Location]
        FROM [Old_Table]
        

        OPEN Practice_cursor
        FETCH NEXT FROM Practice_cursor INTO @Location 
        
                  WHILE @@FETCH_STATUS = 0
                           BEGIN
                                  
								 UPDATE [Location] SET [location_name] =@Location  WHERE Location_id =@id
								 			
								    FETCH NEXT FROM Practice_cursor INTO @Location 
									 SET @id = @id +1
                           END  
						   CLOSE Practice_cursor
                           DEALLOCATE Practice_cursor
						
END

EXEC usp_Procedure 

--Create Two table name Department and Employee Table , Departmetn table have dept_id and dept_name--
--Employee Table have Emp_id, Emp_name and Salary 
--Calculate Total Salary dept wise  
--Have to put the value on a new temporary table
--Using Cursor 
--And whole procedure will be in Store Procedure


-- Create the Department table
CREATE TABLE [Department] (
    [dept_id] INT PRIMARY KEY,
    [dept_name] VARCHAR(100)
);

-- Insert values into the Department table
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'Admin'),
(3, 'System');

SELECT * FROM [Department]


CREATE TABLE [New_Employee] (
    [E_id] INT PRIMARY KEY,
    [E_name] VARCHAR(100),
    [Salary] INT,
    [Dept_id] INT,
    FOREIGN KEY (Dept_id) REFERENCES Department([dept_id])
);


CREATE TABLE #Tmp
(
  [Dept_id] INT ,
  [Dept_name] VARCHAR(50),
  [Salary] INT
  );

SELECT * FROM DBO.#TMP

-- Insert values into the Employee table
INSERT INTO New_Employee (E_id, E_name, Salary, Dept_id) VALUES
(1, 'Anwesha', 10000, 1),
(2, 'Shyamal', 20000, 2),
(3, 'Krishna', 30000, 3),
(4, 'Annapurna', 25000, 1),
(5, 'Bhaskar', 22000, 2),
(6, 'Dilip', 18000, 3),
(7,'Chobi', 14000,1);

SELECT * FROM [New_Employee]

ALTER PROCEDURE My_Procedure 
AS
BEGIN
     SET NOCOUNT ON;

	  DECLARE @Dept_id INT, @Dept_Name VARCHAR(50), @Salary INT

      DECLARE My_cursor CURSOR FOR

        SELECT  d.[Dept_id],d.[Dept_Name], SUM(e.Salary) 
        FROM [Department] AS d
		JOIN [New_Employee] AS e
		ON d.Dept_id = e.dept_id
		GROUP BY d.[Dept_id], d.[Dept_Name]

        OPEN My_cursor

        FETCH NEXT FROM My_cursor INTO @Dept_id ,@Dept_name, @Salary
                  WHILE @@FETCH_STATUS = 0
                           BEGIN    
							 INSERT INTO dbo.#Tmp
							 VALUES(@Dept_id, @Dept_name, @Salary)

							  FETCH NEXT FROM My_cursor INTO @Dept_id, @Dept_name, @Salary 
                           END  

						   CLOSE My_cursor
                           DEALLOCATE My_cursor
						
END

EXEC  My_Procedure 

--======================================================================================================

--USER DEFINED DATA TYPE--
--CREATE A USER DEFINED TABLE TYPE

CREATE DATABASE USER_DEFINED_DATA_TYPE
use USER_DEFINED_DATA_TYPE

CREATE TYPE empTempTabtype AS Table 
(
	ID int identity(1,1),
	name varchar(100) default('ravi'), 
	age int, 
	location VARCHAR(100)
) 


--User Defined Table Types And Table Valued Parameters-- Create the Employee table

--DROP TABLE Employee
CREATE TABLE Employee (
    Emp_id INT PRIMARY KEY,
    EmployeeName VARCHAR(MAX),
    EmpSalary VARCHAR(50),
    StateId VARCHAR(50),
    CityId VARCHAR(50)
);

-- Insert values into the Employee table
INSERT INTO Employee (Emp_id, EmployeeName, EmpSalary, StateId, CityId) VALUES
(1, 'Anwesha Dutta', '50000', 'CA', 'LA'),
(2, 'Shyamal Dutta', '60000', 'NY', 'NYC'),
(3, 'Krishna Dutta', '55000', 'TX', 'Dallas');

SELECT * FROM [Employee]
--DROP TYPE UT_Employee
CREATE TYPE UT_Employee AS TABLE
(
	[Emp_Id] int NOT NULL,
	[EmployeeNam] nvarchar(MAX),
	[EmpSalary] varchar(50),
	[StateId] varchar(50),
	[CityId] varchar(50)
) --DROP PROCEDURE USP_Insert_Employee_InfoDECLARE @Employee_Details UT_Employee;
CREATE PROCEDURE USP_Insert_Employee_Info(@Employee_Details [UT_Employee] READONLY)
AS
BEGIN
INSERT INTO dbo.Employee
(
	Emp_Id,
	EmployeeName,
	EmpSalary,
	StateId,
	CityId
)
SELECT * FROM @Employee_Details
END 

EXEC USP_Insert_Employee_Info

DECLARE @Tab AS [UT_Employee]
INSERT INTO @Tab 
SELECT 4, 'Annapurna Dutta','60000', 'NY', 'NYC'
UNION ALL
SELECT 5, 'Bhaskar Dutta','70000', 'CA', 'LA'
UNION ALL
SELECT 6, 'Dilip Dutta','80000', 'NY', 'NYC'

EXEC USP_Insert_Employee_Info @Tab;

SELECT * FROM [Employee]

--HANDS-ON ON 20/02/2024--
--==================================================================================================
--PRACTICE ON VIEW--
CREATE DATABASE [View_DB]

USE [View_DB]

--View: Simple View and Complex View --
--Simple View is the View which is created using column of a single table
--LIMITATION OF VIEW--
-----------------------


CREATE TABLE Department
 (
	 ID INT PRIMARY KEY,
	 Name VARCHAR(50)
 )
 -- Populate the Department Table with test data
 INSERT INTO Department VALUES(1, 'IT')
 INSERT INTO Department VALUES(2, 'HR')
 INSERT INTO Department VALUES(3, 'Sales')
-- Create Employee Table
CREATE TABLE Employee
(
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
	Gender VARCHAR(50),
	DOB DATETIME,
	DeptID INT
)
 -- Populate the Employee Table with test data
 INSERT INTO Employee VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
 INSERT INTO Employee VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
 INSERT INTO Employee VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
 INSERT INTO Employee VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
 INSERT INTO Employee VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
 INSERT INTO Employee VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)

 --THESE TWO EXAMPLES OF VIEWS ARE SIMPLE OR UPDATABLE VIEW WHERE WE CAN PERFORM ALL DML OPERAION (SELECT,INSERT, UPDATE, DELETE)
 --View With All Columns--
 ---------------------------
CREATE VIEW vwALLEmployees1
AS
SELECT * FROM Employee

SELECT * FROM vwALLEmployees1

--View With Specific Columns--
------------------------------
CREATE VIEW vwAllEmployees2
AS
SELECT ID, Name, Gender, DOB, DeptID
FROM Employee

SELECT * FROM vwAllEmployees2

--Complex View: When we create a view based on more than one table then it is called Complex View 
--And in complex view We may or may not perform DML Operation On Complex View 
--Complex view may not perform DML Operations Correctly

--A view that is created based on a single table will also be considered as a complex view provided if the query contains Distinct.
--Aggregate Function, Group By Clause, having Clause, calculated columns, and set operations. 

--it based on single table but use aggregate functin so it is Complex View
CREATE VIEW vwAllEmployees4
AS
SELECT Gender, Count(*) as TotalEmployee
FROM Employee Group BY Gender

SELECT * FROM vwAllEmployees4


--Create Employee Table
CREATE TABLE New_Employee
(
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
	Gender VARCHAR(50),
	DOB DATETIME,
	Salary DECIMAL(18,2),
	DeptID INT
)
 -- Populate the Employee Table with test data
INSERT INTO New_Employee VALUES
(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 25000, 1),
(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 30000, 2),
(3, 'Anurag', 'Male','1995-04-19 10:53:27.060',40000, 2),
(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 35000, 3),
(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 27000, 1),
(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 33000, 2);
SELECT * FROM New_Employee

--Can we create a view based on other views?
--===============================================
   --Yes, It is possible in SQL Server to create a view based on other views.
   
   --Advantages of View--
  --=================================
 ---Hiding the Complexity of a Complex SQL Query using Views:
CREATE VIEW vwEmployeesByDepartment
AS
SELECT emp.ID, emp.Name, emp.Gender, dept.Name AS DepartmentName
FROM Employee emp INNER JOIN Department dept
ON emp.DeptID = dept.IDSELECT * FROM vwEmployeesByDepartment--Implementing Row Level Security using Views--============================================CREATE VIEW  vwITDepartmentEmployeesASSELECT emp.ID,emp.Name, emp.Gender,d.Name AS Department_NameFROM [Department] AS dINNER JOIN [Employee] AS empON emp.DeptId = d.IDWHERE d.[Name] ='IT'SELECT * FROM vwITDepartmentEmployees--Implementing Column Level Security using Views--=================================================CREATE VIEW vwEmployeesByDept
AS
SELECT emp.ID, emp.Name, emp.Gender, DOB, dept.Name AS DepartmentName
FROM New_Employee emp
INNER JOIN Department dept ON emp.DeptID = dept.IDSELECT * FROM vwEmployeesByDeptSELECT * FROM New_Employee--Presenting the Aggregated data by Hiding Detailed data using Views--====================================================================================CREATE VIEW vwEmployeesCountByDepartment
AS
SELECT dept.Name AS DepartmentName, COUNT(*) AS TotalEmployees
FROM Employee emp 
INNER JOIN Department dept
ON emp.DeptID = dept.ID
GROUP By dept.NameSELECT * FROM vwEmployeesCountByDepartment--- Error: Cannot pass Parameters to a View
--==============================================
CREATE VIEW vwEmployeeDetailsByGender
@Gender varchar(20)
AS
SELECT Id, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE Gender = @Gender--The Table-Valued functions in SQL Server can be used as a replacement for parameterized views.
--===============================================================================================
CREATE FUNCTION fnEmployeeDetailsByGender ( @Gender VARCHAR(20) )
RETURNS Table
AS
RETURN
(
SELECT Id, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE Gender = @Gender
)SELECT * FROM fnEmployeeDetailsByGender('Male')--The ORDER BY clause is invalid in views unless TOP, OFFSET, or FOR XML is also specified.
CREATE VIEW vwEmployeeDetailsSortedByName
AS
SELECT Id, Name, Gender, DOB, Salary, DeptID
FROM Employee
ORDER BY Name--Let’s see how to use TOP Clause to support Order By clause:
ALTER VIEW vwEmployeeDetailsSortedByName
AS
SELECT TOP 100 PERCENT Id, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
ORDER BY NameSELECT * FROM vwEmployeeDetailsSortedByNameSELECT * FROM New_Employee--• Views cannot be created based on temporary tables.
DROP TABLE ##TestTempTable
Create Table ##TestTempTable
(
	[Id] int, 
	[Name] nvarchar(20),
	[Gender] nvarchar(10)
)
Insert into ##TestTempTable ([Id],[Name],[Gender])
values
(101, 'ABC', 'Male'),
(102, 'PQR', 'Female'),
(103, 'XYZ', 'Female');SELECT * FROM ##TestTempTable-- Error: Cannot create a view on Temp Tables
Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable--In SQL Server, if a view is created by using a where condition and
--later on if any modification is performed on that view against the
--where condition still those changes are accepted. Let us understand this with an exampleCREATE VIEW vwITDepartmentEmployees_Details
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE DeptID = 1SELECT * FROM vwITDepartmentEmployees_DetailsINSERT INTO vwITDepartmentEmployees_Details (ID, Name, Gender, DOB, Salary, DeptID) 
VALUES(7, 'Rohit', 'Male','1994-07-24 10:53:27.060', 45000, 2)SELECT ID, Name, Gender, DOB, Salary, DeptID FROM New_Employee---------------------------------------------------------------ALTER VIEW vwITDepartmentEmployees_Details
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE DeptID = 1
WITH CHECK OPTIONINSERT INTO vwITDepartmentEmployees_Details (ID, Name, Gender, DOB, Salary, DeptID) 
VALUES(7, 'Rohima', 'Female','1994-06-20 10:53:27.060', 30000, 2)SELECT id, ctext, text FROM SYSCOMMENTS
WHERE ID = OBJECT_ID('vwITDepartmentEmployees_Details')SP_HELPTEXT vwITDepartmentEmployees_DetailsALTER VIEW vwITDepartmentEmployees_Details
WITH ENCRYPTION
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE DeptID = 1
WITH CHECK OPTIONselect * from vwITDepartmentEmployees_DetailsSP_HELPTEXT vwITDepartmentEmployees_Details--=======================================================================================================ALTER VIEW vwITDepartmentEmployees
WITH SCHEMABINDING
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM dbo.New_Employee
WHERE DeptID = 1
WITH CHECK OPTIONDROP TABLE New_Employee--If required we can use the “WITH ENCRYPTION” and “WITH SCHEMABINDING” options at the same time as shown below.
ALTER VIEW vwITDepartmentEmployees
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM dbo.New_Employee
WHERE DeptID = 1
WITH CHECK OPTIONDROP TABLE New_EmployeeSP_HELPTEXT vwITDepartmentEmployees--Getting rows from employee table by using inline view. The query as follows.
SELECT max(salary) as max_sal
From (select salary from New_Employee) as max_sal

--------------------------------------SQL SERVER NOLOCK -----------------------------------------------------
CREATE DATABASE [NOLOCK_DB]
USE [NOLOCK_DB]

CREATE TABLE LockTestDemo
(
	ID INT IDENTITY (1,1) PRIMARY KEY,
	EmpName NVARCHAR(50),
	EmpAddress NVARCHAR(4000),
	PhoneNumber VARCHAR(50)
)

BEGIN TRANSACTION;
DECLARE @counter INT = 1;
WHILE @counter <= 100000
BEGIN
    INSERT INTO LockTestDemo (EmpName, EmpAddress, PhoneNumber)
    VALUES ('Employee' + CAST(@counter AS NVARCHAR(10)),
            'Address' + CAST(@counter AS NVARCHAR(10)),
            'Phone' + CAST(@counter AS NVARCHAR(10)));
    SET @counter = @counter + 1;
END;
COMMIT TRANSACTION;

SELECT * FROM LockTestDemo

BEGIN TRAN
UPDATE LockTestDemo SET EmpAddress = 'AMM' WHERE ID <100


sp_who2 62
sp_who2 53
sp_who2 54 


use BikeStores

--SELECT customer_id, first_name FROM sales.customers FOR XML AUTO

--PRACTICE ON VIEW WITH CHECK OPTION--
--======================================================================================================================
Use View_DB
CREATE VIEW vwITDepartmentEmployees_New
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE DeptID = 1

select * from [New_Employee]

INSERT INTO vwITDepartmentEmployees_New (ID, Name, Gender, DOB, Salary, DeptId)
VALUES( 8,'Mahesh', 'Male', '1994-07-24 10:53:27.060', 55000,2)

ALTER VIEW vwITDepartmentEmployees_New
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM New_Employee
WHERE DeptID = 1
WITH CHECK OPTION

INSERT INTO vwITDepartmentEmployees_New (ID, Name, Gender, DOB, Salary, DeptID)
VALUES(9, 'Manisha', 'Female','1994-08-10 10:53:27.060', 85000, 2)

SELECT * FROM [New_Employee]

--You can see the text of your view under the text column of the syscomments table as shown below.
--=================================================================================================
SELECT id, ctext, text FROM SYSCOMMENTS
WHERE ID = OBJECT_ID('vwITDepartmentEmployees_New')--SCHEMABINDING----=============================================================================================

--alter table New_Employee 
SELECT * FROM [New_Employee]

ALTER TABLE [New_Employee]
ALTER COLUMN Salary Decimal (10,2)

ALTER VIEW vwITDepartmentEmployees_New
WITH SCHEMABINDING
AS
SELECT ID, Name, Gender, DOB, Salary, DeptID
FROM dbo.New_Employee
WHERE DeptID = 1
WITH CHECK OPTION
-----PRACTICAL OF NOLOCK----
USE BikeStores
BEGIN TRANSACTION
UPDATE sales.customers SET first_name = 'Anwesha' WHERE customer_id = 1
ROLLBACK
SELECT * FROM sales.customers

sp_who 71

----------------------JOB--------------
CREATE DATABASE JOB_DB
use [JOB_DB]


CREATE TABLE [Student]
( 
  [id] int primary key,
  [name] varchar(50),
  [marks] int
  );

  INSERT INTO [Student] 

Select * from [Student]

---QUERY PERFORMANCE IMPROVEMENTS--
---====================================================================
SET STATISTICS IO ON 
SELECT * FROM sales.customers

SET STATISTICS IO ON 
SELECT * FROM sales.orders

CREATE TABLE [Employee_query_improvement](
[EmployeeID] INT NOT NULL,
[Name] VARCHAR(50),
[Code] INT NOT NULL
)

-- Create table
CREATE TABLE [Employee_query_improvement](
    [EmployeeID] INT NOT NULL,
    [Name] VARCHAR(50),
    [Code] INT NOT NULL
);

-- Insert 10 lakh (1 million) records
DECLARE @Counter INT = 1;
WHILE @Counter <= 1000000
BEGIN
    INSERT INTO [Employee_query_improvement] ([EmployeeID], [Name], [Code])
    VALUES (@Counter, 'Employee_' + CAST(@Counter AS VARCHAR), @Counter);
    SET @Counter = @Counter + 1;
END;

SELECT * FROM [Employee_query_improvement]


--================================================================================================

-- Create table
CREATE TABLE Now_Employee (
    EmployeeId INT NOT NULL,
    Name VARCHAR(50),
    Code INT NOT NULL
);

-- Insert 30,000 records
DECLARE @Counter INT = 1;
WHILE @Counter <= 30000
BEGIN
    INSERT INTO Now_Employee (EmployeeId, Name, Code)
    VALUES (@Counter, 'Employee_' + CAST(@Counter AS VARCHAR), @Counter);
    SET @Counter = @Counter + 1;
END;

SELECT Name FROM  Now_Employee


CREATE TABLE [Employee_1](
[EmployeeID] INT NOT NULL,
[Name] VARCHAR(50),
[Code] INT NOT NULL
)
DECLARE @NoOfRows INT, @ID INT;
DECLARE @Name VARCHAR(20)
SET @NoOfRows = 10000;
SET @ID = 1;
WHILE @NoOfRows <= 30000
BEGIN
SET @Name = 'Name - ' + CAST(@ID AS VARCHAR(10))
INSERT INTO Employee_1 VALUES(@ID, @Name, @NoOfRows)
SET @ID = @ID + 1
SET @NoOfRows = @NoOfRows + 1
END;SELECT * FROM Employee_1 ALTER TABLE Employee_1 ADD CONSTRAINT unique_code UNIQUE (Code);  SELECT * FROM Employee_1 WHERE Code = 26640;  --===================================================================================  USE New_DB  CREATE TABLE Customer(
[CustomerID] INT NOT NULL,
[CustomerCode] VARCHAR(20) NOT NULL,
[CustomerName] VARCHAR(50) NOT NULL
)
GO
INSERT INTO Customer VALUES (1, 'CUS_101', 'David')
INSERT INTO Customer VALUES (4, 'CUS_104', 'Taylor')
INSERT INTO Customer VALUES (6, 'CUS_106', 'Smith')
INSERT INTO Customer VALUES (3, 'CUS_103', 'Sara')
INSERT INTO Customer VALUES (5, 'CUS_105', 'Pam')
INSERT INTO Customer VALUES (2, 'CUS_102', 'John')

SELECT * FROM Customer

CREATE UNIQUE NONCLUSTERED INDEX IX_Customer_Code ON Customer(CustomerCode ASC);
SELECT * FROM Customer WHERE CustomerCode = 'CUS_101';

CREATE UNIQUE CLUSTERED INDEX IX_Customer_ID ON Customer(CustomerID ASC);
SELECT * FROM Customer WHERE CustomerCode = 'CUS_101'

 DROP INDEX Customer.IX_Customer_Code
 CREATE UNIQUE NONCLUSTERED INDEX IX_Customer_Code ON Customer(CustomerCode ASC) INCLUDE
(CustomerID, CustomerName);

--DROP INDEX Customer.CustomerID

 CREATE UNIQUE NONCLUSTERED INDEX IX_Customer_Code ON Customer(CustomerCode ASC) INCLUDE
(CustomerID,CustomerName);

SELECT * FROM Customer WHERE CustomerCode = 'Cus_101'

--Now we will drop the clustered index
 --and then we will check

 SELECT * FROM Customer WHERE CustomerCode = 'Cus_101'
 SELECT CustomerName FROM Customer WHERE CustomerCode = 'Cus_101'

 ----==============================================================
 SELECT * FROM SYS.allocation_units

 SELECT
t.NAME AS TableName, p.rows AS RowCounts, SUM(a.total_pages) AS TotalPages,
SUM(a.used_pages) AS UsedPages, (SUM(a.total_pages) - SUM(a.used_pages)) AS UnusedPages
FROM sys.tables t
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE t.NAME = 'Old_Table' AND t.is_ms_shipped = 0 AND i.OBJECT_ID > 255
GROUP BY t.Name, p.Rows
ORDER BY t.Name
--JOB PRACTICE--
--===========================================================================
  CREATE TABLE Customer
  (
	[CustomerID] INT NOT NULL,
	[CustomerCode] VARCHAR(20) NOT NULL,
	[CustomerName] VARCHAR(50) NOT NULL
  )

INSERT INTO Customer VALUES (1, 'CUS_101', 'David')
INSERT INTO Customer VALUES (4, 'CUS_104', 'Taylor')
INSERT INTO Customer VALUES (6, 'CUS_106', 'Smith')
INSERT INTO Customer VALUES (3, 'CUS_103', 'Sara')
INSERT INTO Customer VALUES (5, 'CUS_105', 'Pam')
INSERT INTO Customer VALUES (2, 'CUS_102', 'John')

SELECT * FROM Customer

Insert INTO New_Customer 
select top 1  * from Customer

USE New_DB


CREATE TABLE [New_Customer]
  (
  [CustomerID] INT NOT NULL,
  [CustomerCode] VARCHAR(20) NOT NULL,
  [CustomerName] VARCHAR(50) NOT NULL
)

Select * from [New_Customer]

--SELECT top 1 * FROM [New_Customer]


--DELETE TOP(1) FROM [Customer];

Select * from [Customer]


--Insert into [New_Customer]
--select  top 1 * from customer


 ---PRACTICE ON JOB---
 --=============================================================================================================

 
 CREATE TABLE [Employee]
( 
 [Id] int primary key,
 [name] varchar(100),
 [marks] int
 );

 insert into [Employee]([Id],[name],[marks])
 VALUES(1,'Anwesha', 80),(2,'Shyamal', 100),(3,'Krishna',80);

 select * from [Employee]

 CREATE TABLE [New_Employee]
 ( 
 [Id] int primary key,
 [name] varchar(100),
 [marks] int
 );

 SELECT * FROM [New_Employee]

----BASED ON STUDENT_MANAGEMENT_STYSTEM
----CREATE 6 TABLE
----STUDENT TABLE, COURSE, ENROLLMENT, INSTRUCTOR(TEACHER), GRADE , DEPARTMENT
--====================================================================================----


 