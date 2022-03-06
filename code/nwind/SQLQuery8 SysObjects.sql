use sample;

exec sp_columns 'emptbl' -- column list
-- select * from sys.spt_columns_odbc_view --requires Dedicated Administrator Connection 
exec  Sp_databases -- list of databases in the server 
exec sp_help 'emptbl'
-- Sp_helptext :  Prints the text of a rule, a default, or an unencrypted stored procedure,
-- user-defined function, trigger, or view
exec sp_helptext 'sys.sp_addlogin'
exec sp_helptext 'sys.sp_columns'
exec Sp_helptrigger 'emptbl'
exec sp_helpindex 'Customers'
exec Sp_tables
-- Ctrl+Alt+A  ==> activity monitor
exec Sp_who
exec Sp_who2
	SELECT 
		DB_NAME(dbid) as DBName, 
		COUNT(dbid) as NumberOfConnections,
		loginame as LoginName
	FROM
		sys.sysprocesses
	WHERE 
		dbid > 0
	GROUP BY 
		dbid, loginame
	;
kill 54;
SELECT * FROM sys.dm_exec_sessions
---
DECLARE @Store_TABLE_Info TABLE  (	Ident int IDENTITY (1,1)
									, Table_Name varchar(256)
									, Column_Name varchar(130)
									, Seed_Value sql_variant
									, increment_value sql_variant
									, Last_value sql_variant
								 )
INSERT INTO		@Store_TABLE_Info
SELECT	'['+SCHEMA_NAME([Schema_id])+'].'+ '['+OBJECT_NAME(ST.[object_id])+']'  [Table_Name]
						,'['+SIC.Name+']' [Column_Name]
						,Seed_Value
						,Increment_Value
						,ISNULL(last_Value,0)last_Value
				FROM	Sys.Tables ST
						JOIN sys.Identity_columns SIC ON ST.[object_id] = SIC.[object_id] 
SELECT COUNT(* ) FROM @Store_TABLE_Info
--
exec sp_lock
select * from  sys.dm_tran_locks -- use instead of sp_lock
select * from sys.dm_exec_sessions -- shows information about all active user connections and internal tasks