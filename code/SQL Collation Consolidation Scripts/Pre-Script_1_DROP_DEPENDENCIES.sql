-- Pre-Script 2
-- Script Name: Pre-Script_1_DROP_DEPENDENCIES.sql
--
-- Description:
--   This script generates dynamic DDL to prepare for collation changes.
--   The dynamic SQL created in this script handles the following collation
--   dependent objects:
--     * CHECK CONSTRAINTS
--     * TABLE FUNCTIONS
--     * INDEXES
--
-- Usage:
--   1. Connect to the target database on SQL-2000.
--   2. Execute the script.
--   3. The column, labled "DROP_OBJECTS': copy this column, by clicking on the header,
--      to select all, right-click and then select copy.  Paste this to a text file and name
--      the file: <db_name>_1_Drop_Objects.sql
--
-- Additonal Information:
--   There are accompanying scripts to generate the DDL to alter the column collations as well
--   as another to generate the CREATE OBJECTS DDL to re-create all the objects dropped.
--   Pre-Script 2 will generate the SQL to alter all the columns which have an incorrect
--   collation definition to the correct value of 'Latin1_General_CI_AS'.  Pre-Script 3 will
--   generate all the DDL to re-create the objects once collation has been changed.
--   When all 3 migration  scripts have been generated, they need to be copied along with
--   the database backup to the SQL'08 instance.
--
--  The general migraton steps are as follows:
--    * Restore the backup.
--    * Restore transaction logs (where necessary)
--    * Execute the Drop Objects script. (#1)
--    * Execute the Alter Table Alter Columns script. (#2)
--    * Execute the Create Objects script. (#3)
--    * Migration will then be complete.
--
-- Originally created by: Brian Cidern bcidern (at) gmail (dot) com
-- Downloaded from http://blog.sqlauthority.com

SELECT
	[DROP_OBJECTS] = 'USE ' + DB_NAME()

UNION ALL

SELECT
	[DROP_OBJECTS] = 'GO'

-------------------------------------------------------------------------------- FOREIGN KEY CONSTRAINTS

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- FOREIGN KEY CONSTRAINTS --'

UNION ALL


SELECT 
	[DROP_OBJECTS] = 'ALTER TABLE [dbo].[' + OBJECT_NAME(c.[id]) + '] DROP CONSTRAINT [' + OBJECT_NAME(fk.constid) + ']'
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

-------------------------------------------------------------------------------- PRIMARY KEY CONSTRAINTS

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- PRIMARY KEY CONSTRAINTS --'

UNION ALL

SELECT DISTINCT
	[DROP_OBJECTS] = 'ALTER TABLE [dbo].[' + OBJECT_NAME(i.[id]) + '] DROP CONSTRAINT [' + OBJECT_NAME(o.[id]) + ']'
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

-------------------------------------------------------------------------------- TABLE FUNCTIONS

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- TABLE FUNCTIONS --'

UNION ALL

SELECT
	[DROP_OBJECTS] = 'IF EXISTS (SELECT * FROM sysobjects WHERE [id] = OBJECT_ID(N''[dbo].[' + [name] + ']'') AND xtype IN (N''FN'', N''IF'', N''TF'')) DROP FUNCTION [dbo].[' + [name] +']'
FROM sysobjects
WHERE xtype=N'TF'

-------------------------------------------------------------------------------- UNIQUE CONSTRAINTS

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- UNIQUE CONSTRAINTS --'

UNION ALL

SELECT DISTINCT
	[DROP_OBJECTS] = 'ALTER TABLE [dbo].[' + OBJECT_NAME(i.[id]) + '] DROP CONSTRAINT [' + OBJECT_NAME(o.[id]) + ']'
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

-------------------------------------------------------------------------------- CHECK CONSTRAINTS

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- CHECK CONSTRAINTS --'

UNION ALL

SELECT
	[DROP_OBJECTS] = 'ALTER TABLE [dbo].[' + OBJECT_NAME(parent_obj) + '] DROP CONSTRAINT [' + [name] + ']'
FROM sysobjects
WHERE xtype=N'C'

-------------------------------------------------------------------------------- INDEXES

UNION ALL

SELECT
	[DROP_OBJECTS] = '-- INDEXES --'

UNION ALL

SELECT DISTINCT
	[DROP_OBJECT] = 'IF EXISTS (SELECT * FROM dbo.sysindexes WHERE [name] = N''' + i.[name] + ''' AND [id] = OBJECT_ID(N''[dbo].[' + OBJECT_NAME(i.[id]) + ']'')) DROP INDEX [dbo].[' + OBJECT_NAME(i.[id]) + '].[' + i.[name] + ']'
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
