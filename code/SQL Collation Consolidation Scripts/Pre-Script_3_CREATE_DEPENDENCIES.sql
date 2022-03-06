-- Pre-Script 2
-- Script Name: Pre-Script_3_CREATE_DEPENDENCIES.sql
--
-- Description:
--   This script generates the DDL to finalize collation changes.
--   This script must be used in conjunction with the DROP_DEPENDENCIES script.
--   The objects created in the resulting script are those which are dropped
--   from the first script.  The difference is that their orders are reversed
--   to avoide dependency conflicts.
--
-- Usage:
--   1. Connect to the target database on SQL-2000.
--   2. Execute the script.
--   3. Select all of the GENERATE_DDL column and copy to the clipboard.  Paste to
--      a new Query Analyzer window and execute the dynamic SQL.  The output will be in text
--      view instead of a grid view.  Copy and paste the results to a text file and name that
--      file: <db_name>_3_Create_Objects.sql
--
-- Additonal Information:
--   After this has been completed, you should have three migration scripts.  When all 3 migration
--   scripts have been generated, they need to be copied along with the database backup to the
--   SQL'08 instance.

--
--  The general migraton steps are as follows:
--    * Restore the backup.
--    * Restore transaction logs where necessary.
--    * Execute the Drop Objects script.
--    * Execute the Alter Table Alter Columns script.
--    * Execute the Create Objects script.
--    * Migration will then be complete.
--
-- Originally created by: Brian Cidern bcidern (at) gmail (dot) com
-- Downloaded from http://blog.sqlauthority.com

SELECT
	[GENERATE_DDL] = 'USE DBADB'

UNION ALL

SELECT
	[GENERATE_DDL] = 'GO'

-------------------------------------------------------------------------------- INDEXES

UNION ALL

SELECT
	[GENERATE_DDL] = '-- INDEXES --'

UNION ALL

SELECT DISTINCT
	[GENERATE_DDL] = 'EXEC DBADB.dbo.sp_scriptObject ''' + CAST(DB_NAME() AS VarChar(200)) + ''', ''INDEXES'', ''' + OBJECT_NAME(i.[id]) + ''', ''' + i.[name] + ''''
FROM
sysindexes i
	INNER JOIN sysindexkeys ik ON
	(
		i.[id] = ik.[id] AND
		i.indid = ik.indid AND
		i.[name] NOT LIKE '_WA_%' AND
		OBJECT_NAME(i.[id]) <> 'dtproperties' AND
		OBJECTPROPERTY(i.[id], N'IsUserTable') = 1
	)
	INNER JOIN syscolumns c ON
	(
		i.[id] = c.[id] AND
		ik.colid = c.colid
	)
WHERE
	c.collation IS NOT NULL AND
	c.collation <> 'Latin1_General_CI_AS'
	AND OBJECTPROPERTY(i.[id], 'IsUserTable') = 1 AND
	i.[name] NOT IN
	(
		SELECT [name]
		FROM sysobjects o
	)
-------------------------------------------------------------------------------- CHECK CONSTRAINTS

UNION ALL

SELECT
	[GENERATE_DDL] = '-- CHECK CONSTRAINTS --'

UNION ALL

SELECT
	[GENERATE_DDL] = 'EXEC DBADB.dbo.sp_scriptObject ''' + CAST(DB_NAME() AS VarChar(200)) + ''', ''CHECKS'', ''' + OBJECT_NAME(parent_obj) + ''', ''' + [name] + ''''
FROM sysobjects
WHERE xtype=N'C'

-------------------------------------------------------------------------------- UNIQUE CONSTRAINTS

UNION ALL

SELECT
	[GENERATE_DDL] = '-- UNIQUE CONSTRAINTS --'

UNION ALL

SELECT DISTINCT
	[GENERATE_DDL] = 'EXEC [DBADB].[dbo].[sp_scriptObject] ''' + DB_NAME() + ''', ''KEYS'', ''' + OBJECT_NAME(i.[id]) + ''', ''' + OBJECT_NAME(o.[id]) + ''''
FROM syscolumns c
INNER JOIN sysindexkeys ik ON
	(
		c.[id] = ik.[id] AND
		c.colid = ik.colid
	)
INNER JOIN sysindexes i ON
	(
		c.[id] = i.[id] AND
		ik.indid = i.indid AND
		OBJECTPROPERTY(i.[id], 'isusertable') = 1 AND
		OBJECT_NAME(i.[id]) <> 'dtproperties' AND
		i.[name] NOT LIKE '_WA_Sys_%'
	)
INNER JOIN sysobjects o ON
	(
		c.[id] = o.parent_obj AND
		i.[name] = o.[name]
	)
WHERE
	c.collation IS NOT NULL AND
	c.collation <> 'Latin1_General_CI_AS' AND
	o.xtype='UQ'

-------------------------------------------------------------------------------- TABLE FUNCTIONS

UNION ALL

SELECT
	[GENERATE_DDL] = '-- TABLE FUNCTIONS --'

UNION ALL

SELECT
	[GENERATE_DDL] = 'EXEC DBADB.dbo.sp_scriptObject ''' + CAST(DB_NAME() AS VarChar(200)) + ''', ''FUNCTIONS'', ''' + [name] + ''''
FROM sysobjects
WHERE xtype=N'TF'

-------------------------------------------------------------------------------- PRIMARY KEY CONSTRAINTS

UNION ALL

SELECT
	[GENERATE_DDL] = '-- PRIMARY KEY CONSTRAINTS --'

UNION ALL

SELECT DISTINCT
	[GENERATE_DDL] = 'EXEC [DBADB].[dbo].[sp_scriptObject] ''' + DB_NAME() + ''', ''KEYS'', ''' + OBJECT_NAME(i.[id]) + ''', ''' + OBJECT_NAME(o.[id]) + ''''
FROM syscolumns c
INNER JOIN sysindexkeys ik ON
	(
		c.[id] = ik.[id] AND
		c.colid = ik.colid
	)
INNER JOIN sysindexes i ON
	(
		c.[id] = i.[id] AND
		ik.indid = i.indid AND
		OBJECTPROPERTY(i.[id], 'isusertable') = 1 AND
		OBJECT_NAME(i.[id]) <> 'dtproperties' AND
		i.[name] NOT LIKE '_WA_Sys_%'
	)
INNER JOIN sysobjects o ON
	(
		c.[id] = o.parent_obj AND
		i.[name] = o.[name]
	)
WHERE
	c.collation IS NOT NULL AND
	c.collation <> 'Latin1_General_CI_AS' AND
	o.xtype='PK'

-------------------------------------------------------------------------------- FOREIGN KEY CONSTRAINTS

UNION ALL

SELECT
	[GENERATE_DDL] = '-- FOREIGN KEY CONSTRAINTS --'

UNION ALL


SELECT 
	[GENERATE_DDL] = 'EXEC [DBADB].[dbo].[sp_scriptObject] ''' + DB_NAME() + ''', ''KEYS'', ''' + OBJECT_NAME(c.[id]) + ''', ''' + OBJECT_NAME(fk.constid) + ''''
FROM syscolumns c
	INNER JOIN sysforeignkeys fk
	ON (
		c.[id] = fk.fkeyid AND
		c.colid = fk.fkey
	)
WHERE
	OBJECTPROPERTY(c.[id], N'IsUserTable') = 1 AND
	c.collation IS NOT NULL AND
	c.collation <> 'Latin1_General_CI_AS'

