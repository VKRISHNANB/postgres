select e.FirstName , e.BirthDate
from Employees e
-- Employees who are older than Nancy
select e1.FirstName , e1.BirthDate
from Employees e1 where  e1.BirthDate >(
					select e.BirthDate
					from Employees e where e.FirstName ='Nancy'
			)
--
select min (BirthDate) 
From  (select top 3 BirthDate 
			from employees order by BirthDate desc) a; 
select BirthDate 
from employees 
select top 3 BirthDate 
from employees 
select top 3 BirthDate 
from employees order by BirthDate desc
---
select FirstName, BirthDate 
from employees order by BirthDate

select birthdate 
select top 2 birthdate 
order by birthdate 

Select Top 3 Birthdate from Employees order by BirthDate