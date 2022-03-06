-- Pre-Script 3
-- Script Name: Pre-Script_3_CHANGE_COLLATIONS.sql
--
-- Description:
--   This script generates one column to prepare for collation changes.
--   The dynamic SQL created in this script handles the following migration
--   changes:
--     * Sets database compatability level to 100.
--     * Sets database collation to Latin1_General_CI_AS
--     * Changes column collation for columns where collation is defined and
--       is not Latin1_General_CI_AS
--
-- Usage:
--   1. Connect to the target database on SQL-2000.
--   2. Execute the script.
--   3. Copy the results column, by clicking on the header, to select all,
--      right-click and then select copy.  Paste this to a text file and name
--      the file: <db_name>_2_Change_Collations.sql
--
-- Additonal Information:
--   Changing collation, either database or column, cannot always be done directly.
--   Sometimes there are objects which are dependent on the collation.  Therefore,
--   the dependent objects must be dropped before the collation can be changed.
--   After the collation has been changed, the objects can be re-created.
--   This script MUST be used in conjunction with Pre-Script_2_COLLATION_DEPENDENCIES.sql
--   which generates the DDL to drop the dependent object, as well as the DDL to
--   re-create them once collation has been changed.
-- 
--   Pre-Script_0 creates a required stored procedure for DMO.
--   Pre-Script_1 will create DROP OBJECT script.
--   This script will create the DDL to correct the collation for all columns where it is incorrect.
--   Pre-Script_2 will create the DDL to re-create all of the dropped objects.
--   When all 3 migration scripts have been generated, they need to be copied along with
--   the database backup to the SQL'08 instance.
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

BEGIN
DECLARE @collation VarChar(50)
SET @collation = 'Latin1_General_CI_AS'

SELECT [SET_COLLATION] = 'USE ' + DB_NAME()

UNION ALL

SELECT [SET_COLLATION] = 'GO'

UNION ALL

SELECT [SET_COLLATION] = 'ALTER DATABASE ' + DB_NAME() + ' SET COMPATIBILITY_LEVEL=100'

UNION ALL

SELECT [SET_COLLATION] = 'GO'

UNION ALL

SELECT [SET_COLLATION] = 'ALTER DATABASE ' + DB_NAME() + ' COLLATE ' + @collation

UNION ALL

SELECT [SET_COLLATION] = 'GO'

UNION ALL

SELECT [SET_COLLATION] = ('ALTER TABLE [' + TABLE_NAME + '] ALTER COLUMN [' + COLUMN_NAME + '] ' + DATA_TYPE + CASE WHEN DATA_TYPE IN ('text','ntext') THEN '' ELSE '('+CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR(10))+')' END + ' COLLATE ' + @collation + CASE IS_NULLABLE WHEN 'NO' THEN ' NOT NULL' WHEN 'YES' THEN ' NULL' END) COLLATE Latin1_General_CI_AS
FROM INFORMATION_SCHEMA.columns  
WHERE
	TABLE_NAME <> N'dtproperties' AND
	OBJECTPROPERTY(OBJECT_ID(TABLE_NAME), N'IsUserTable') = 1 AND
	COLLATION_NAME <> @collation
END
