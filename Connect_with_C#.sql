USE BikeStores

select customer_id, first_name 
from sales.customers

Use PracticeDB

create table [student]
(
 [id] int primary key,
 [first_name] varchar(50),
 [last_name] varchar(50)
 );

 select * from [student]

 insert into [student] ([id],[first_name],[last_name])
 values(1,'Anwesha','Dutta'),
       (2, 'Shyamal', 'Dutta'),
	   (3, 'Krishna', 'Dutta');

select * from [Employee]

drop table [Employee]

Create Table [Course] 
 (
   [id] int primary key,
   [name] varchar(50)
 );

 --Drop table [Course]

select * from [Course]

 insert into [Course] ([id],[name])
 values(1,'Sql Server'),
       (2, 'ASP.NET'),
	   (3, 'C#');

create table [Teacher] 
(
   [id] int primary key,
   [name] varchar(50),
   [gender] varchar(50),
   [score] int
   );


   Select *from [Teacher]


ALter PROCEDURE usp_studentDetails(@id int , @message varchar(50) out)
AS
BEGIN
  SELECT id, first_name, last_name FROM student 
  where id = @id;

   if(@@ROWCOUNT=0)
    begin
	   set @message = 'No data available';
	end
END



--=============================================================================================================
select * from worker

create table worker 
(
   [id] int primary key,
   [first_name] varchar(50),
   [last_name] varchar(50)

 );
 insert into worker Values(1,'Anwesha','Dutta'),(2,'Pushpashree','Mondal'),(3,'Ahida','Sultana');

alter procedure usp_WorkerDetails(@id int ,@message varchar(50) out)
as
begin
   select id, first_name, last_name
   from worker
   where id =@id;

 --  if(@@ROWCOUNT=0)
    --begin
	   set @message = 'No data available';
	--end
end

declare @message varchar(50) ;
exec usp_WorkerDetails 1 ,@message out;
print @message;


 
--===================================================================================================================

ALter PROCEDURE usp_studentDetails(@id int ,@first_name varchar(50), @last_name varchar(50), @message varchar(50) out)
AS
BEGIN
  insert into [student] values(@id,@first_name, @last_name)

  
	   set @message = 'Data Inserted Sucessfully from Sql';
	
END

 
 declare @message varchar(50) ;
exec usp_studentDetails 4,'Sanjana','Gupta' ,@message out;
print @message;

select * from [student]


select * from [Order]

alter procedure usp_getOrderDetails(@id int,@message varchar(50) out)
as
begin
   select * from [Order] 
   where id =@id;

   if(@@ROWCOUNT=0)
    begin
	   set @message = 'No data available';
	end
end

declare @message varchar(50) ;
exec usp_getOrderDetails 840 ,@message out;
print @message;

--==============================================================================================================
create table employee_details
 (
   [id] int primary key identity(1,1),
   [first_name] varchar(50),
   [second_name] varchar(50),
  );

  insert into employee_details values ('Anwesha', 'Dutta'),('Shyamal','Dutta'),('Krishna','Dutta');

  select * from employee_details

  alter procedure usp_getemployeeDetails
  (
     @first_name varchar(50),
	 @last_name varchar(50),
	 @id int out,
	 @message varchar(50) out
  )
  as
  begin
        insert  into employee_details  values(@first_name, @last_name)
        select @id = SCOPE_IDENTITY() ;

		if (@@ROWCOUNT =1)
		begin
		
		set @message = Convert(varchar(50),@id)+ ' '+'Inserted Sucessfully';
		end
  end

  declare @id int,  @message varchar(50)
  exec  usp_getemployeeDetails 'Dilip', 'Dutta',  @id out, @message out
  print @message

  select * from employee_details

--============================================================================================================

select * from teacher


alter procedure usp_get_teachers_Details
  (
     @id int,
     @name varchar(50),
	 @gender varchar(10),
	 @score int,
	 @message varchar(100) out
  )
  as
  begin
	if not exists(select id from dbo.teacher where id=@id)
	begin
        insert  into dbo.Teacher values(@id, @name,@gender,@score) ;
		select * from teacher;
		if (@@ROWCOUNT >= 1)
		  begin
		    set @message = 'here is your whole data:';
		  end
		else
		   begin
		    set @message = 'There is some issues';
		   end
	end
  end

  declare @message varchar(50)
  exec  usp_get_teachers_Details 27,'Sundor','Male', 100,  @message out
  print @message

 select * from teacher

 truncate table teacher

 alter table dbo.Teacher add constraint teacher_tbl_pk primary key ([id]) 


 --=============================================================================================

 create table pilot
  (
    [id] int primary key,
	[name] varchar(50),
	[gender] varchar(10),
	[salary] int
);

select * from pilot

insert into pilot values(1,'Anwesha','Female',80000),(2,'Shyamal','Male',100000),(3,'Krishna','Female',80000);

 alter procedure usp_get_pilot_Details
  (
     @id int,
     @name varchar(50),
	 @gender varchar(10),
	 @salary int,
	 @message varchar(100) out
  )
  as
  begin
        insert  into pilot values(@id, @name,@gender,@salary) ;
		select * from pilot;
	if not exists(select id from pilot where id=@id)
	begin
		if (@@ROWCOUNT >= 1)
		  begin
		    set @message = 'here is your whole data:';
		  end
		else
		   begin
		    set @message = 'There is some issues';
		   end
    end;
  end

  declare @message varchar(50)
  exec  usp_get_pilot_Details 8,'Manisha', 'Female',80000,  @message out
  print @message

 select * from pilot


 




   