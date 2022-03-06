select abs(-3233)

select ceiling(123.35)

select floor(123.35)

select ASCII('@')

select GETDATE()

select CEILING(round(123.333457,3))
select round(123.3334574354353454,2)
select round(163.3334574354353454,-2)

select char(66)

Declare @amt money=254.65
SELECT @amt NoFilter,
FORMAT(@amt, 'C', 'en-us') 'en-us',
FORMAT(@amt, 'C', 'en-in') 'en-in'

Declare  @strName nvarchar(20) = 'Tom and Jerry'
select @strName
select len(@strName)-- no of char
select substring(@strName,5,3)

-- Trim
select len('      Tom')
select LTRIM('      Tom')
select len(LTRIM('      Tom'))
select len(rtrim('  Tom and Jerry  '))
select 'Hi'+ltrim('  Tom and Jerry  ')+ 'Are good friends'
select 'Hi'+rtrim('  Tom and Jerry  ')+ 'Are good friends'

--Date functions
select getdate()
select dateadd(mm,14,getdate())
select DATEDIFF(yy,'10-01-2104',GETDATE())
select DATENAME(Y,getdate())

Select CURRENT_USER
select HOST_NAME()