
--ADO.NET Assignment1--
--Anwesha Dutta--

--=-============================================================================================================
--Author : Anwesha Dutta
--Date   : 04/03/2024
--Description :To perform insert and fetch data into [New_Student]
--==============================================================================================================
create table [New_Student]
(
  [id] int primary key,
  [name] varchar(100),
  [score] int 
 );

 insert into [New_Student] values(1,'Anwesha', 80),(2,'Shyamal',100),(3,'Krishna',100);
 select * from [New_Student]

 alter procedure usp_insert_data_into_New_Student
 (
    @id int,
	@name varchar(50),
	@score int ,
	@message varchar(100) out
 )
 as
 begin
    begin transaction
       insert into [New_Student] values(@id, @name, @score);
	   if(@@ROWCOUNT >=1)
	  begin
	   set @message = 'Data Inserted Sucessfully from sql server';
   commit transaction;
	   end

	  else
	    begin 
		  rollback transaction;
		end
 end

 declare @message varchar(50)
 exec  usp_insert_data_into_New_Student 4, 'Bandita',70 , @message out
 print @message;

 select * from New_Student

 --==========================================================================================================
 --For Update--
---===========================================================================================================

 alter procedure usp_update_data_into_New_Student
(
    @id int,
    @name varchar(100) = null,
    @score int  = null,
	@message varchar(100) out
)
as
begin
    begin transaction;
	 if @name is not null and @score is not null
    begin
        update [New_Student] set [name] = @name, [score] = @score where [id] = @id;
    end
    else if @name is not null
   begin
        update [New_Student] set [name] = @name  where [id] = @id;
    end
    else if @score is not null
    begin
        update [New_Student] set [score] = @score where [id] = @id;
    end

    if @@ROWCOUNT > 0
    begin
        commit transaction;
        set @message = 'Data updated successfully.';
    end
    else
    begin
        rollback transaction;
        set @message = 'No updates performed.';
    end
end

declare @message varchar(100)
--exec  usp_update_data_into_New_Student 1,'Annapurna',null  ,@message out
--exec  usp_update_data_into_New_Student 2,'Shyamal',100 ,@message out
exec  usp_update_data_into_New_Student 5,'Shyamal',null ,@message out
print @message;

select * from [New_Student]
 --================================================================================================================
 --For Delete--
 --================================================================================================================
 alter procedure usp_delete_data_from_New_Student
 (
    @id int,
	@message varchar(50) out
 )
 as
 begin
    begin transaction
        delete from [New_Student] where id=@id;

	   if(@@ROWCOUNT >=1)
	  begin
	   set @message = 'Data deleted Sucessfully from table';
   commit transaction;
	   end

	  else
	    begin 
		  rollback transaction;
		end
 end

 declare @message varchar(50)
 exec  usp_delete_data_from_New_Student  4  , @message out
 print @message;

 select * from New_Student
 
--=======================================================================================================================
--For Select
--=======================================================================================================================
alter procedure usp_getDetailsOfNew_Student (@id int=null)
as
begin
	   if @id is not null
	   begin
	     select [id],[name],[score] from New_Student where id= @id
	   end

	
	  else
	    begin
	     select [id],[name],[score] from New_Student
		 end
end


exec usp_getDetailsOfNew_Student 2

---------------------------------------------------------------------------------------------------------------------------------

--alter procedure usp_getDetailsOfNew_Student 
--as
--begin
--	  select [id],[name],[score] from New_Student;
--end

--exec usp_getDetailsOfNew_Student
