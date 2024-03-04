
 --ANWESHA DUTTA--
--1.Create two Tables using all the constraints and maintain relationship between them.     

DROP TABLE [HR].[newtbl1]

CREATE TABLE [HR].[newtbl1]
(
[id] INT CONSTRAINT[newtbl1_pk] PRIMARY KEY IDENTITY(1,1),
[name] VARCHAR(20) NOT NULL,
[city] VARCHAR(20) UNIQUE,
[Marks] INT NOT NULL DEFAULT 10,
);

DROP TABLE [HR].[newtbl2]

CREATE TABLE [HR].[newtbl2]
(
[id] INT CONSTRAINT [newtbl2_pk] PRIMARY KEY IDENTITY(1,1),
[name] VARCHAR(20) NOT NULL,
[city] VARCHAR(20) UNIQUE,
[Marks] INT NOT NULL CHECK([Marks]>=10),
[tbl_id] INT FOREIGN KEY([tbl_id]) REFERENCES [HR].[newtbl1]([id])
);


--2.Write a query by using INSERT INTO SELECT and SELECT INTO.
--2nd Answer--

--INSERT INTO 
CREATE TABLE [HR].[#newtemp1]
(
 [id] INT CONSTRAINT[newtemp_pk] PRIMARY KEY IDENTITY(1,1),
 [name] VARCHAR(20),
 [city] VARCHAR(30)
 );

INSERT INTO [HR].[#newtemp1]([name],[city])
VALUES('Anwesha','Bankura'),
      ('Susmita','Digha'),
      ('Pushpa','Murshidabad');
  SELECT * FROM [HR].[#newtemp1]

  --SELECT INTO--

	CREATE TABLE [HR].[new]
	(
		[id] INT CONSTRAINT[new_pk] PRIMARY KEY IDENTITY(1,1),
		[name] VARCHAR(20),
		[city] VARCHAR(30),
	);

			
	INSERT INTO [HR].[new]([name],[city])
	VALUES ('Ahida','Murshidabad'),
	        ('Soma','Sonamukhi'),
			('Sumita','Bankura'),
			('Sangha','Burdwan'),
			('Nishita','Durgapur');


		
  SELECT * 
  INTO [HR].[#temp_product]
  FROM [HR].[new]

  SELECT * FROM [HR].[#temp_product]


--3.Write a query using MERGE INTO statement.                                                                            
--3rd Answer--

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
 
 SELECT * FROM [HR].[nsource]

  CREATE TABLE [HR].[ntargets]
 (
	 [id] INT CONSTRAINT[ntargets_pk] PRIMARY KEY ,
	 [name] VARCHAR(30), 
	 [location] VARCHAR(30)
 );

 INSERT INTO [HR].[ntargets] ([id],[name],[location])
 VALUES (1,'Shyamal','Bishnupur'),
 (2,'Krishna','Bishnupur'),
 (3,'Arjun','Bishnupur'),
 (6,'Subhadra','Bishnupur'),
 (7,'Kunti','Bishnupur');

 SELECT * FROM [HR].[ntargets] 

 MERGE INTO [HR].[ntargets] as t
 USING [HR].[nsource] as s
 ON t.id = s.id
 WHEN MATCHED THEN 
 UPDATE SET t.[id] = s.[id] ,t.[name] = s.[name], t.[location] = s.[location] 
 WHEN NOT MATCHED BY TARGET THEN
 INSERT([id] ,[name],[location]) VALUES (s.[id],s.[name] ,s.[location]) 
 WHEN NOT MATCHED BY SOURCE THEN 
 DELETE;


 SELECT * FROM [HR].[newtarget]

 --4.Write queries using 
 --update and delete statement by using JOINS.                                        
 --4th Answer--

   DROP TABLE [HR].[Student]

	   CREATE TABLE [HR].[Student]
	   (
		   [id] INT CONSTRAINT[students_pk] PRIMARY KEY IDENTITY(1,1),
		   [name] VARCHAR(20),
		   [location] VARCHAR(30),
	   );

	   INSERT INTO[HR].[Student] ([name],[location])
	   VALUES('Anwesha','Bankura'),
	   ('Sudipto','Durgapur'),
	   ('Anindita','Burdwan'),
	   ('Nilanjana','Bankura'),
	   ('Sanjana','Bishnupur');

	   SELECT * FROM [HR].[Student]
	  --UPDATE AND DELETE JOIN --
	 

	   DROP TABLE [HR].[Teacher]

	  CREATE TABLE [HR].[Teachers]
	  (
		  [id] INT CONSTRAINT[t_pk] PRIMARY KEY IDENTITY(1,1),
		  [name] VARCHAR(20),
		  [salary] VARCHAR(20),
		  [Age] INT NOT NULL,
		  [Gender] CHAR(1) ,
		  [location] VARCHAR(20)
	  );

	  INSERT INTO [HR].[Teachers]
	  ([name],[salary],[Age],[Gender],[location])

	  VALUES('Riju',20000, 20,'M','KOLKATA'),
	  ('Mohor',30000, 22,'M','Bishnupur'),
	  ('Krishna',40000,25,'F','Bankura'),
	  ('Babu',10000,26,'M' ,'Murshidabad'),
	  ('Shyamal', 80000,50,'M','Bankura');
	  
	
	  SELECT * FROM [HR].[Teacher]
	  SELECT * FROM [HR].[Student]

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

	  --5.Write a query using CROSS JOIN & SELF JOIN                                                                              
	  --5th Answer--
	--SELF JOIN--
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

	--CROSS JOIN--
	CREATE TABLE [HR].[crossjoin]
	(
		[id] INT CONSTRAINT[crossjoin_pk] PRIMARY KEY IDENTITY(1,1),
		[name] VARCHAR(20),
		[city] VARCHAR(30)
	);

	INSERT INTO [HR].[crossjoin]([name],[city])
	VALUES ('Lalit','Pune'),
	        ('Rahul','Pune'),
			('Bubun','Pune'),
			('Arti','Pune'),
			('Sarita','Pune');

			SELECT * FROM [HR].[crossjoin]

			CREATE TABLE [HR].[crossjoin_two]
			(
			[id] INT CONSTRAINT[crossjoin_two_pk] PRIMARY KEY IDENTITY(1,1),
	        [name] VARCHAR(20),
	        [city] VARCHAR(30),
			);

			
	INSERT INTO [HR].[crossjoin_two]([name],[city])
	VALUES ('Ahida','Murshidabad'),
	        ('Soma','Sonamukhi'),
			('Sumita','Bankura'),
			('Sangha','Burdwan'),
			('Nishita','Durgapur');

	SELECT * FROM [HR].[crossjoin_two]

	SELECT *
	FROM [HR].[crossjoin] AS c
	CROSS JOIN [HR].[crossjoin_two] AS t
	ORDER BY c.[id]

	--6.Find the duplicate records from a table?                                                                                     
	--6th Answer--
	DROP TABLE [HR].[orders]

	CREATE TABLE [HR].[orders]
	(
	 [order_id] INT ,
	 [customer_id] INT ,
	 [employee_id] INT ,
	 [order_date] DATE,
	 [shipper_id] INT 
	 );
	
	INSERT INTO [HR].[orders] ([order_id],[customer_id],[employee_id],[order_date],[shipper_id])
	VALUES(1,25,4,'2024-01-17',3),
	(1,25,5,'2024-01-17',3),
	(2,26,6,'2024-01-18',1),
	(3,27,4,'2024-01-19',2),
	(4,28,4,'2024-01-20',1),
	(4,29,3,'2024-01-20',1),
	(5,29,2,'2024-01-21',3);

	SELECT * FROM [HR].[orders]

  SELECT [order_id], COUNT(order_id)
  FROM [HR].[orders]
  GROUP BY order_id 
  HAVING COUNT(order_id) > 1

  --7.Show Salary to add comma/period. (5000000 -> 5,000,000)                                                   
  --7th Answer--
SELECT FORMAT(5000000,'0,000,000')

--8.Show difference between two dates as DD: HH:MM format
 --8th Answer--
 SELECT datediff(dd,'1999-10-04',getdate())

--9.Write a query to insert data from excel worksheet
	--9th Answer--
	DROP TABLE [HR].[bulk_inserts]

	CREATE TABLE [HR].[bulk_inserts]
	(
	[id] INT CONSTRAINT[inserts_pk] PRIMARY KEY,
	[name] VARCHAR(20) NOT NULL,
	[marks] INT NOT NULL,
	);

	
		   BULK INSERT [HR].[bulk_inserts]
		   FROM 'D:\Anwesha Dutta\bulk_insert.csv' 
		   with (
		   FieldTerminator =',',
		   RowTerminator='\n',
		   FirstRow = 2
		   )

		   SELECT * FROM [HR].[bulk_inserts]

--10.Explain foreign key rules by giving examples.                                                                             
		
		--10 th Answer--

		  --FOREIGN KEY  is a constraint in sql server that is
		  --used to build realtionship between tables
		  --One table can have more than one FOREIGN KEY 
		  --AND FOREIGN KEY accept duplicate values
		  --FOREIGN KEY HAVE TWO DIFFERENT ACTION
		  --THESE ARE ON DELETE AND ON UPDATE

		  --UNDER ON DELETE TEHRE ARE 4 RULES
		 
		  -- ON DELETE NO ACTION 
		  --ON DELETE CASCACADE
		  --ON DELETE SET NULL
		  -- ON DELETE SET DEFAULT

		  --UNDER ON UPDATE TEHRE ARE ALSO 4 RULES
		  -- ON UPDATE NO ACTION 
		  --ON UPDATE CASCACADE
		  --ON UPDATE SET NULL
		  -- ON UPDATE SET DEFAULT

		  DROP TABLE [HR].[newparent]

		 CREATE TABLE [HR].[newparent] 
		 (
		  [id] INT CONSTRAINT[newparent_pk] PRIMARY KEY,
		  [name] VARCHAR(20),
		  [city] VARCHAR(30),
		  );
		  
		  INSERT INTO [HR].[newparent]([id],[name],[city])
		  VALUES(1,'Shyamal','Bankura'),
		  (2,'Durgadas','Bankura'),
		  (3,'Biswajit','Bankura'),
		  (4,'Subhajit','Bankura'),
		  (5,'Sujata','Bankura');

		  SELECT * FROM [HR].[newparent]

		  DROP TABLE [HR].[newchildren]

		  CREATE TABLE [HR].[newchildren] 
		 (
		  [id] INT CONSTRAINT[newchilds_pk] PRIMARY KEY,
		  [name] VARCHAR(20),
		  [city] VARCHAR(30),
		  [parent_id] INT FOREIGN KEY([parent_id]) 
		  REFERENCES [HR].[newparent]([id])
		  ON DELETE  CASCADE
		  
		  );

		  INSERT INTO [HR].[newchildren]([id],[name],[city],[parent_id])
		  VALUES(1,'Anwesha','Bankura',1),
		  (2,'Sayantan','Bankura',2),
		  (3,'Abhik','Bankura',3),
		  (4,'Tukai','Bankura',4),
		  (5,'Shreya','Bankura',5);

	 SELECT * FROM [HR].[newparent]
	 SELECT * FROM [HR].[newchildren]

	 DELETE FROM [HR].[newparent] 
	 WHERE id = 4

	 


	

	

	 
	 
	 
