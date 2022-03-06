-------------------------------------------------
-- Using the Database Engine Tuning Advisor
-------------------------------------------------

-- Execute sample queries
SELECT * 
FROM HumanResources.vEmployee
WHERE EmployeeID BETWEEN 100 AND 200
ORDER BY FirstName, LastName, JobTitle

SELECT * 
FROM HumanResources.vEmployeeDepartment
WHERE EmployeeID IN (10, 20, 30, 40, 50, 60, 70, 80, 90)
ORDER BY Department, GroupName, JobTitle

SELECT CountryRegionName, COUNT(*) as [Count]
FROM Person.vStateProvinceCountryRegion
GROUP BY CountryRegionName
ORDER BY CountryRegionName

SELECT City, CountryRegionName, COUNT(*) as [Count]
FROM Sales.vIndividualCustomer
GROUP BY City, CountryRegionName
ORDER BY CountryRegionName


--------------------------------------
-- Managing Processes
--------------------------------------

-- View process-related information

SELECT * 
FROM Sys.DM_Exec_Sessions 
WHERE Session_ID > 50
ORDER BY Login_Time

SELECT * 
FROM Sys.DM_Exec_Requests
WHERE Session_ID > 50
ORDER BY Start_Time

SELECT * 
FROM Sys.SysProcesses
ORDER BY CPU DESC

EXEC sp_Who2

-- Get the current process id
SELECT @@SPID as ProcessID

-- View process information
DBCC USEROPTIONS
DBCC INPUTBUFFER(59)
DBCC OUTPUTBUFFER(59)

-- Terminate a process
KILL 59

--------------------------------------
-- Viewing Lock Information
--------------------------------------

-- Create a blocking situation
	-- Start a transaction
	BEGIN TRAN
	UPDATE HumanResources.Employee SET VacationHours = VacationHours + 1
	
	-- End the transaction
	ROLLBACK TRAN

-- View Lock-related information
SELECT * FROM Sys.DM_Exec_Requests

EXEC sp_lock

SELECT DB_NAME(Resource_Database_ID) as DatabaseName, * 
FROM Sys.DM_Tran_Locks
ORDER BY DatabaseName, Resource_Type

-- Find waiting locks
SELECT DB_NAME(Resource_Database_ID) as DatabaseName, * 
FROM Sys.DM_Tran_Locks
WHERE Request_Status = 'Wait'
ORDER BY DatabaseName, Resource_Type

--------------------------------------
-- Managing Deadlocks
--------------------------------------

------	Transaction # 1 ------	
	-- Start a transaction
	BEGIN TRAN

	UPDATE HumanResources.Employee SET VacationHours = VacationHours + 1
	WAITFOR DELAY '00:00:45'
	UPDATE HumanResources.Department SET ModifiedDate = GetDate()

	-- End the transaction
	ROLLBACK TRAN

------	Transaction # 2 ------	
	-- Start a transaction
	BEGIN TRAN

	UPDATE HumanResources.Department SET ModifiedDate = GetDate()
	WAITFOR DELAY '00:00:45'
	UPDATE HumanResources.Employee SET VacationHours = VacationHours + 1

	-- End the transaction
	ROLLBACK TRAN
