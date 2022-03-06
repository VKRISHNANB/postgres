--You can run following query and check whether it is enabled for any database. 
USE master
GO
SELECT [name], database_id, is_cdc_enabled 
FROM sys.databases      
GO 

--You can run this stored procedure in the context of each database to enable CDC at database level. 
--(The following script will enable CDC in AdventureWorks2012 database. )
USE AdventureWorks2012
GO
EXEC sys.sp_cdc_enable_db
GO

--First run following query to show which tables of database have already been enabled for CDC.
USE AdventureWorks2012
GO
SELECT [name], is_tracked_by_cdc 
FROM sys.tables
GO  

--Following script will enable CDC on HumanResources.Shift table.
USE AdventureWorks2012
GO
EXEC sys.sp_cdc_enable_table
@source_schema = N'HumanResources',
@source_name   = N'Shift',
@role_name     = NULL
GO

--Before we start let�s first SELECT from both tables and see what is in them. 
USE AdventureWorks2012
GO
SELECT *
FROM HumanResources.Shift
GO
USE AdventureWorks2012
GO
SELECT *
FROM cdc.HumanResources_Shift_CT
GO

--Lets run an INSERT operation on the table HumanResources.Shift.
USE AdventureWorks2012
GO
INSERT INTO [HumanResources].[Shift]
       ([Name],[StartTime],[EndTime],[ModifiedDate])
VALUES ('Tracked Shift',GETDATE(), GETDATE(), GETDATE())
GO 

--To illustrate the effects of an UPDATE we will update a newly inserted row. 
USE AdventureWorks2012
GO
UPDATE [HumanResources].[Shift]
SET Name = 'New Name',
      ModifiedDate = GETDATE()
WHERE [Name] = 'Tracked Shift'
GO

--To illustrate the effects of an DELETE we will delete a newly inserted row. 
USE AdventureWorks2012
GO
DELETE
FROM [HumanResources].[Shift]
WHERE [Name] = 'New Name'
GO 

--Before we end let�s SELECT from both tables and see what is in them. 
USE AdventureWorks2012
GO
SELECT *
FROM HumanResources.Shift
GO
USE AdventureWorks2012
GO
SELECT *
FROM cdc.HumanResources_Shift_CT
GO

--Checking details of CDC
USE AdventureWorks2012;
GO
EXEC sys.sp_cdc_help_change_data_capture
GO

--Disabling Change Data Capture on a table
USE AdventureWorks2012;
GO
EXECUTE sys.sp_cdc_disable_table
    @source_schema = N'HumanResources',
    @source_name = N'Shift',
    @capture_instance = N'HumanResources_Shift';
GO

--Disable Change Data Capture Feature on Database
USE AdventureWorks2012
GO
EXEC sys.sp_cdc_disable_db
GO 

