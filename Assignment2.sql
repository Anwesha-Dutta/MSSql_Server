
--Anwesha Dutta--

--1st ANSWER--
USE [Students_DB]
DROP TABLE [HR].[Department]

CREATE TABLE [HR].[Department]
(
 [ID] INT CONSTRAINT [department_pk] PRIMARY KEY IDENTITY(1,1),
 [DeptName] VARCHAR(20) NOT NULL,
 [Location] VARCHAR(30) NOT NULL
 );

 INSERT INTO [HR].[Department]([DeptName],[Location])
 VALUES('HR','Kolkata'),
       ( 'IT','Kolkata'),
	   ('Paint', 'Kolkata'),
	   ('Exam','Kolkata');


	   SELECT * FROM [HR].[Department]

 DROP TABLE [HR].[Employee]

 CREATE TABLE [HR].[Employee]
(
 [EmpID] INT CONSTRAINT [Emp_pk] PRIMARY KEY IDENTITY(1,1),
 [EmpName] VARCHAR(20) NOT NULL,
 [DOJ] DATE NOT NULL,
 [JobRole] VARCHAR(20) NOT NULL,
 [Salary] INT NOT NULL,
 [DeptID]  INT CONSTRAINT[fk_Employee] FOREIGN KEY 
 REFERENCES [HR].[Department]([ID])
 );

  INSERT INTO [HR].[Employee]([EmpName],[DOJ],[JobRole],[Salary],[DeptID])
  VALUES('Anwesha','2024-01-17','Software Developer',15000,2),
  ('Susmita','2024-01-17','Software Developer',15000,1),
  ('Pranav','2024-01-17','Software Developer',15000,3),
  ('Subrata','2024-01-17','Software Developer',15000,4),
  ('Rahul','2024-01-17','Software Developer',15000,2);

     SELECT * FROM [HR].[Employee]

 --2 ND ANSWER--


 CREATE TABLE [HR].[target]
 (
 [target_id] INT CONSTRAINT[target_pk] PRIMARY KEY,
 [City] VARCHAR(20),
 [Location] VARCHAR(30)
 );
 
 INSERT INTO [HR].[target] ([target_id],[City],[Location])
 VALUES(1,'MCC','Kolkata'),
        (2,'MCC','Kolkata'),
		(3,'MCC','Kolkata'),
		(4,'MCC','Kolkata');

	SELECT * FROM [HR].[target]

 CREATE TABLE [HR].[source]
 (
 [source_id] INT CONSTRAINT[source_pk] PRIMARY KEY,
 [City] VARCHAR(20),
 [Location] VARCHAR(30)
 );

  INSERT INTO [HR].[source] ([source_id],[City],[Location])
 VALUES(1,'TCS','Kolkata'),
        (2,'TCS','Kolkata'),
		(3,'TCS','Kolkata'),
		(4,'TCS','Kolkata');
 SELECT * FROM [HR].[target]
 SELECT * FROM [HR].[source]

  MERGE  INTO [HR].[target] AS t
 USING [HR].[source] AS s
 ON t.target_id = s.source_id
 WHEN MATCHED THEN
 UPDATE SET t.City = s.City;

 	SELECT * FROM [HR].[target]
	SELECT * FROM [HR].[source]

 -- 3 rd ANSWER
        DROP  TABLE [HR].[newsource]
		DROP  TABLE [HR].[newtarget]

		CREATE TABLE [HR].[newtarget]
		(
		[newtarget_id] INT PRIMARY KEY,
		[percentage] DECIMAL(4,2) NOT NULL DEFAULT 10,
		[City] VARCHAR(20)
		);

		INSERT INTO [HR].[newtarget] ([newtarget_id], [percentage],[City])
		VALUES(1,0.3,'BANKURA'),(2,0.4,'BANKURA'),(3,0.6,'BANKURA'),
		(4,0.5,'BANKURA'),(5,0.8,'BANKURA');

		SELECT * FROM [HR].[newtarget]

		
		CREATE TABLE [HR].[newsource]
		(
		[source_id] INT PRIMARY KEY,
		[City] VARCHAR(20),
		[Location] VARCHAR(30),
		[newtarget_id] INT FOREIGN KEY
		REFERENCES [HR].[newtarget]([newtarget_id])
		)

		INSERT INTO [HR].[newsource]([source_id],[City],[Location],[newtarget_id])
		VALUES(1,'NEW TOWN','KOLKATA',2),
		(2,'NEW TOWN','KOLKATA',3),
		(3,'NEW TOWN','KOLKATA',1),
		(4,'NEW TOWN','KOLKATA',4),
		(5,'NEW TOWN','KOLKATA',5);
		
		SELECT * FROM [HR].[newsource]

		
		UPDATE [HR].[newtarget] 
		SET [City] = s.[City]
		FROM[HR].[newsource] AS s
		JOIN [HR].[newtarget] AS t
		ON t.newtarget_id = s.newtarget_id
		
			SELECT * FROM [HR].[newsource]
			SELECT * FROM [HR].[newtarget]


--DELETE --

DELETE n 
FROM [HR].[newsource] as n
JOIN [HR].[newtarget]  AS s
ON s.newtarget_id = n.newtarget_id
WHERE n.newtarget_id = 2


