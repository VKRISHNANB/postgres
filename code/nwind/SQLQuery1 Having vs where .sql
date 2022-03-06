select * from employees

select * from employees where region = 'WA'

select * from employees having region = 'WA'
-- Column 'employees.Region' is invalid in the HAVING clause 
-- because it is not contained in either 
-- an aggregate function or the GROUP BY clause.

select count(Orderid),sum(freight) from Orders 
 having Avg(freight) >10

select region,count(TitleOfCourtesy) from employees 
group by region having region = 'WA'
select region,count(TitleOfCourtesy) from employees where region = 'WA'
group by region 

select count(Orderid),customerid,sum(freight) from Orders 
group by customerid having Avg(freight) >10

