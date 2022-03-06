-------------------------------------------------
-- Implement Database Mirroring
-------------------------------------------------

--    ** SCRIPT FOR PRINCIPAL SERVER **

-- Backup the AdventureWorks2 Database
BACKUP DATABASE AdventureWorks2
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Database.bak'
WITH FORMAT

BACKUP LOG AdventureWorks2
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Log.bak'
WITH FORMAT

-- Perform test updates
UPDATE AdventureWorks2.Production.TransactionHistory
SET	ModifiedDate = '01-01-2006'

SELECT TOP 100 * 
FROM AdventureWorks2.Production.TransactionHistory

SELECT TOP 100 * 
FROM [TOAD\Test].AdventureWorks2.Production.TransactionHistory

-------------------------------------------------
-- Implement Database Mirroring
-------------------------------------------------

--    ** SCRIPT FOR MIRROR SERVER **

--Restore the AdventureWorks2 DB on the mirror server
RESTORE DATABASE AdventureWorks2
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Database.bak'
WITH 
	MOVE 'AdventureWorks_Data' TO 'C:\MSSQL\Data\AdventureWorks_Mirror.mdf',
	MOVE 'AdventureWorks_Log' TO 'C:\MSSQL\Data\AdventureWorks_Mirror.ldf',
	REPLACE,
	NORECOVERY

RESTORE LOG AdventureWorks2
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Log.bak'
WITH NORECOVERY


--------------------------------------------
-- Managing Database Mirroring
--------------------------------------------

-- View mirroring status
SELECT * FROM Sys.Database_Mirroring 

-- Fail-over to the mirror server
ALTER DATABASE AdventureWorks2 SET PARTNER FAILOVER

