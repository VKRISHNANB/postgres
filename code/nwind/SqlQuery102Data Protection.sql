-----------------------------------------------
-- Performing Database Backups
-----------------------------------------------

-- Getting database file information
EXEC sp_HelpDB 'AdventureWorks'
EXEC sp_SpaceUsed
SELECT * FROM Sys.Database_Files

-- Perform a basic backup
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Full.bak'

-- Perform a differential backup
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Differential.bak'
WITH DIFFERENTIAL

-- Perform multiple transaction log backups
BACKUP LOG AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-01.bak'

BACKUP LOG AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-02.bak'

BACKUP LOG AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-03.bak'

BACKUP LOG AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-04.bak'

-----------------------------------------------
-- Other Backup Options
-----------------------------------------------
-- Perform a partial backup
BACKUP DATABASE AdventureWorks
READ_WRITE_FILEGROUPS
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Partial.bak'

-- Perform a copy-only backup
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks-Copy.bak'
WITH COPY_ONLY

-----------------------------------------------
-- Performing Restore Operations
-----------------------------------------------

-- Restoring from a full backup
RESTORE DATABASE AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Full.bak'
WITH 
	MOVE 'AdventureWorks_Data' 
	TO 'C:\MSSQL\Data\AdventureWorks_Copy.mdf',
	MOVE 'AdventureWorks_Log' 
	TO 'C:\MSSQL\Data\AdventureWorks_Copy_Log.ldf',
	NORECOVERY

-- Restore from a differential backup
RESTORE DATABASE AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Differential.bak'
WITH 
	MOVE 'AdventureWorks_Data' TO 'C:\MSSQL\Data\AdventureWorks_Copy.mdf',
	MOVE 'AdventureWorks_Log' TO 'C:\MSSQL\Data\AdventureWorks_Copy_Log.ldf',
	NORECOVERY

-- Restore Transaction Logs
RESTORE LOG AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-01.bak'
WITH NORECOVERY

RESTORE LOG AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-02.bak'
WITH NORECOVERY

RESTORE LOG AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-03.bak'
WITH NORECOVERY

-- Restore final trasaction log and bring database online
RESTORE LOG AdventureWorks_Copy
FROM DISK = 'C:\MSSQL\Backup\AdventureWorks-Log-04.bak'
WITH RECOVERY

-- Perform clean-up
DROP DATABASE AdventureWorks_Copy

-----------------------------------------------
-- Working with Backup Media
-----------------------------------------------

-- Backup to multiple disk files
BACKUP DATABASE AdventureWorks
TO 
	DISK = 'C:\MSSQL\Backup\Test_01.bak',
	DISK = 'C:\MSSQL\Backup\Test_02.bak',
	DISK = 'C:\MSSQL\Backup\Test_03.bak'
WITH 
	FORMAT,
	MEDIANAME = 'Adventure Works Backup',
	MEDIADESCRIPTION = 'Test backup spread accross multiple files'

-- Creating a mirrored backup set
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\MSSQL\Backup\AdventureWorks_Backup_Primary.bak'
MIRROR TO DISK = 'C:\MSSQL\Backup\AdventureWorks_Backup_Mirror.bak'
WITH FORMAT

-- Backup to a network share
BACKUP DATABASE AdventureWorks
TO DISK = '\\TOAD\Backups\NetworkBackup.bak'

-- Backup to a tape device
BACKUP DATABASE AdventureWorks
TO TAPE = '\\.\tape0'

-- Backup to a logical disk device

	-- Create a new backup device
	EXEC sp_AdDumpDevice 
		@DevType='Disk',
		@LogicalName = 'AdventureWorks Backups',
		@PhysicalName = 'C:\MSSQL\Data\AdventureWorks Backup Device.bak'

	-- View information about backup devices
	SELECT * FROM Sys.Backup_Devices

	-- Create the backup
	BACKUP DATABASE AdventureWorks
	TO [AdventureWorks Backups]
	WITH 
		FORMAT,
		MEDIANAME = 'Adventure Works Backup',
		MEDIADESCRIPTION = 'Test backup to a disk device. '

-----------------------------------------------
-- Viewing Backup and Restore Information
-----------------------------------------------

-- Viewing backup file information
RESTORE LABELONLY FROM DISK = 'C:\MSSQL\Backup\Test_01.bak'
RESTORE HEADERONLY FROM DISK = 'C:\MSSQL\Backup\Test_01.bak'
RESTORE FILELISTONLY FROM DISK = 'C:\MSSQL\Backup\Test_01.bak'
RESTORE VERIFYONLY FROM 
	DISK = 'C:\MSSQL\Backup\Test_01.bak',
	DISK = 'C:\MSSQL\Backup\Test_02.bak',
	DISK = 'C:\MSSQL\Backup\Test_03.bak'

-- Viewing restore history details
SELECT * FROM msdb.dbo.RestoreFile
SELECT * FROM msdb.dbo.RestoreHistory

-- Viewing backup-related information
SELECT * FROM msdb.dbo.BackupFile
SELECT * FROM msdb.dbo.BackupMediaFamily
SELECT * FROM msdb.dbo.BackupMediaSet
SELECT * FROM msdb.dbo.BackupSet

------------------------------------------
-- Monitoring Log Shipping
------------------------------------------

-- Using System Stored Procedures
EXEC SP_Help_Log_Shipping_Monitor 

-- Querying System Views
SELECT * FROM msdb.dbo.Log_Shipping_Monitor_History_Detail
SELECT * FROM msdb.dbo.Log_Shipping_Monitor_Primary
SELECT * FROM msdb.dbo.Log_Shipping_Monitor_Secondary
SELECT * FROM msdb.dbo.Log_Shipping_Monitor_Error_Detail

---------------------------------------
-- Creating Database Snapshots
---------------------------------------

-- View information about AdventureWorks2 Database
SELECT * FROM Sys.Database_Files

-- Create a new database snaphost
CREATE DATABASE AdventureWorks2_Snapshot01
ON 
(
	NAME = 'AdventureWorks_Data',
	FILENAME = 'C:\MSSQL\Data\AdventureWorks2_Snapshot01.mdf'
)
AS SNAPSHOT OF AdventureWorks2	

-- Use the new Database Snapshot
USE AdventureWorks2_Snapshot01

-- Execute an update command
SELECT TOP 100 * FROM Production.TransactionHistory

-- Perform an update
UPDATE Production.TransactionHistory
SET	Quantity = Quantity + 1

---------------------------------------
-- Managing Database Snapshots
---------------------------------------

SELECT TOP 100 * 
FROM Production.TransactionHistory
ORDER BY TransactionID

UPDATE Production.TransactionHistory
SET Quantity = 5

-- Reverting to a database snapshot
RESTORE DATABASE AdventureWorks2
FROM DATABASE_SNAPSHOT = 'AdventureWorks2_Snapshot01'

-- Drop a database snapshot
DROP DATABASE AdventureWorks2_Snapshot01

