-- This script is for use ONLY on a SQL 2000 instance, with a DBADB database.
-- This will create a stored procedured called sp_scriptObject and take in 3 paramaters
-- with a 4th optional parameter.
--
-- When called, this script will generate the DDL to create the object specified in the
-- parameters.
--
-- The objects which are supported by this script are:
--   Indexes
--   Checks
--   Table Functions
-- It is important to understand the object hierarchy which DMO (Database Management Objects)
-- uses for referencing objects.
--
-- Parameters:
-- @in_dbname.  This is the name of the database for which the objected is to be scripted from.
--              The *current* database does not matter.  This procedure invokes an external process
--              and then makes an inbound DMO connection.
-- @in_objtype. This is the type of the object.  Currently supported values are: INDEXES, CHECKS or FUNCTIONS
-- @in_objName. This is the name of the object.
-- @in_subname. Some objects are referenced by the table which they're created against.  In these cases, the
--              @in_objname value must be the parent object or table, and the @in_subname would be the object
--              name.  When the table name is not required, then this parameter is optional and should be
--              left at the default value of NULL.  This is why it is important to understand the DMO object
--              hierarchy.
--
-- Originally created by: Brian Cidern bcidern (at) gmail (dot) com
-- Downloaded from http://blog.sqlauthority.com


USE DBADB
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE [id] = OBJECT_ID(N'[dbo].[sp_scriptObject]') AND OBJECTPROPERTY([id], N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_scriptObject]
GO

CREATE PROCEDURE sp_scriptObject(
	@in_dbName SysName,
	@in_objType VarChar(100),
	@in_objName VarChar(100),
	@in_objSubName VarChar(100) = NULL
)
AS
BEGIN

DECLARE
	@rc Int,
	@o_server Int,
	@context VarChar(100),
	@objectIdentifier VarChar(255),
	@buffer VarChar(8000),
	@errSrc varchar(255),
	@errDesc varchar(255)

SELECT @in_objType = LOWER(@in_objType)

SELECT @context = 'Create DMO Object.'
EXEC @rc = sp_OACreate 'SQLDMO.SQLServer', @o_server OUT
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END

SELECT @context = 'Set security mode.'
EXEC @rc = sp_OASetProperty @O_server, 'LoginSecure', 1
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END
 	
SELECT @context = 'Connect.'
EXEC @rc = sp_OAMethod @o_server , 'Connect', NULL, '(local)'
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END
	
SELECT @objectIdentifier = CASE
	WHEN @in_objType = 'indexes'   THEN 'databases("' + @in_dbName + '").tables("' + @in_objName + '").indexes("' + @in_objSubName + '").script'
	WHEN @in_objType = 'checks'    THEN 'databases("' + @in_dbName + '").tables("' + @in_objName + '").checks("' + @in_objSubName + '").script'
	WHEN @in_objType = 'keys'      THEN 'databases("' + @in_dbName + '").tables("' + @in_objName + '").keys("' + @in_objSubName + '").script'
	WHEN @in_objType = 'functions' THEN 'databases("' + @in_dbName + '").userdefinedfunctions("' + @in_objName + '").script'
	END

SELECT @context = 'Load object, dump buffer.'
EXEC @rc = sp_OAMethod @o_server, @objectIdentifier , @buffer OUTPUT
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END

SELECT @context = 'Disconnect from server.'
EXEC @rc = sp_OAMethod @o_server, 'Disconnect'
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END

SELECT @context = 'Cleanup memory.'
EXEC @rc = sp_OADestroy @o_server
IF @rc <> 0
BEGIN
	EXEC sp_OAGetErrorInfo @o_server, @errSrc OUT, @errDesc OUT 
	PRINT 'ERROR: ' + @context
	PRINT 'Source: ' + @errSrc
	PRINT 'Description: ' + @errDesc
	RETURN
END

PRINT 'USE ' + @in_dbName
PRINT 'GO'
PRINT @buffer
PRINT 'GO'
PRINT ''

RETURN
END
