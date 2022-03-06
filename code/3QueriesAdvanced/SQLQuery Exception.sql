USE Northwind
go
BEGIN TRY
    -- Generate a divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
----------------------------------------------
-- throw error
declare @id int =1;
declare @text varchar(10) ='xyz';
BEGIN TRY
	if (@id=1) 
		THROW 999999, 'I will not allow you to insert a duplicate value.', 1;
	INSERT INTO TestTable 
	VALUES (@id,@text);
END TRY
BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() as ErrorState,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as ErrorLine,
		ERROR_MESSAGE() as ErrorMessage; 
END CATCH
select * from testtable
----------------------------------------------
-- Nested Try
BEGIN TRY
	Print 'Try 1';
	BEGIN TRY
		Print 'Try 2';
		-- Generate a divide-by-zero error.
		SELECT 1/0;
	END TRY	
	BEGIN CATCH
		Print 'Catch 2';
		SELECT ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
	Print 'Out side Try 2 catch 2';
    -- Generate a divide-by-zero error.
    SELECT 2/0;
END TRY
BEGIN CATCH
	Print 'Catch 1';
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
Print 'After Try1 catch1';
-----------------------------
-- Try Catch in Transactions
Select ProductName from products where productid=11;

	BEGIN TRANSACTION
	begin try
		delete  from products WHERE productId = 11;
	end try
	begin catch
		SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine,
			ERROR_MESSAGE() as ErrorMessage; 
	    select @@TRANCOUNT;
	    IF @@TRANCOUNT > 0 
	          ROLLBACK TRANSACTION; 
		--ROLLBACK TRANSACTION
	end catch	
	select @@TRANCOUNT;
	IF @@TRANCOUNT > 0 
	  commit TRANSACTION
Select ProductName from products where productid=11
-------------------
