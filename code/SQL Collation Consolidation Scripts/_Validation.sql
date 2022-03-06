-- This query will return two result sets.
-- The first result set is a list of columns which do not have the correct collation set.
-- This script should be executed after all of the collation change scripts are executed
-- and the first result set should have zero records.
--
-- The second result set lists some high-levels of all the databases.  Check the database
-- that was just changed.  The COLLATION_NAME should be Latin1_General_CI_AS and the
-- COMPATIBILITY_LEVEL should be 100.
--
-- NOTE: THIS SCRIPT IS NOT BACKWARD COMPATIBLE WITH SQL-2000!

SELECT
	[TABLE_NAME] = OBJECT_NAME([id]),
	[COLUMN_NAME] = [name]	
FROM syscolumns
WHERE
	collation <> 'Latin1_General_CI_AS' AND
	collation IS NOT NULL AND
	OBJECTPROPERTY([id], N'IsUserTable')=1

SELECT
	[DATABASE_NAME] = [name],
	[COLLATION_NAME] = [collation_name],
	[COMPATIBILITY_LEVEL] = [compatibility_level],
	[ACCESS_MODE] = user_access_desc,
	[STATE] = state_desc,
	[recovery_model] = recovery_model_desc
FROM sys.databases
WHERE owner_sid<>0x01


