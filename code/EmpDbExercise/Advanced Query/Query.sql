SELECT * FROM tblEm
SELECT * FROM tblDEPT
SELECT * FROM tblSALGRADE

--Inner Join

SELECT tblEm.Ename,tblEm.Job,tblDEPT.Location
FROM tblEm
INNER JOIN tblDEPT
ON tblEm.DeptNo=tblDEPT.DeptNo

SELECT tblEm.Ename,tblEm.Job,tblDEPT.Location
FROM tblEm,tblDEPT
where tblEm.DeptNo=tblDEPT.DeptNo

--Left outer join

SELECT tblEm.Ename,tblEm.Job,tblDEPT.Location
FROM tblEm
LEFT OUTER JOIN tblDEPT
ON tblEm.DeptNo=tblDEPT.DeptNo

SELECT tblEm.Ename,tblEm.Job,tblDEPT.Location
FROM tblEm
LEFT OUTER JOIN tblDEPT
ON tblDEPT.DeptNo=tblEm.DeptNo

--Right outer join
SELECT tblEm.Ename,tblEm.Job,tblDEPT.Location
FROM tblEm
RIGHT OUTER JOIN tblDEPT
ON tblEm.DeptNo=tblDEPT.DeptNo

--Full outer join
SELECT tblEm.Ename,tblEm.Job,tblEm.DeptNo,
tblDept.DeptNo, tblDEPT.Location
FROM tblEm
FULL OUTER JOIN tblDEPT
ON tblEm.DeptNo=tblDEPT.DeptNo

--Cross join

SELECT tblEm.Ename,tblEm.Job,tblEm.DeptNo,
tblDept.DeptNo,tblDEPT.Location
FROM tblEm
CROSS JOIN tblDEPT

--Self join
--Display the association of empName and manager's name 

SELECT worker.EmpNo ,worker.Ename,
Manager.EmpNo as ManagerNo,Manager.Ename as Manager
FROM tblEm worker,tblEm Manager
WHERE worker.Manager=Manager.EmpNo


--Display Employee Name,location,and Department Number

SELECT Ename,Location,tblEm.DeptNo
FROM tblEm ,tblDEPT 
WHERE tblEm.DeptNo=tblDEPT.DeptNo

--Display employee WARD'S name and location

SELECT Ename,Location
FROM tblEm,tblDEPT
WHERE tblEm.DeptNo=tblDEPT.DeptNo
AND Ename='WARD'

--Display the names,department numbers,and office location of all employees.Include in that list dept numbers
--and office locations of those departments that currently have no employees. 

SELECT EName,tblDEPT.DeptNo,Location
FROM tblEm,tblDEPT
WHERE tblEm.DeptNo=tblDEPT.DeptNo

--Display employee name and salary for those in Grade Level 3.

SELECT Ename,Salary
FROM tblEm,tblSALGRADE
WHERE GRADE=3 AND Salary BETWEEN LOSAL AND HISAL

--Sub Queries
--Display the name and job of all employees
-- from the same department as Jones.

SELECT Ename,Job
FROM tblEm
WHERE tblEm.DeptNo=(SELECT DeptNo 
              FROM tblEm
              WHERE Ename='Jones')


--Display the name and DOJ of all employees 
--whose salary is greater than the average 
--employee salary, and who works in a department 
--with any employee named Smith

select AVG(tblEm.Salary) from tblEm 


SELECT Ename,DateOfJoining
FROM tblEm  
WHERE Salary > (SELECT AVG(Salary)
				FROM tblEm)  
AND DeptNo IN (SELECT DeptNo
				FROM tblEm
				WHERE Ename='SMITH') 
				

select ename,dateofjoining
from tblem
where salary > (select avg(tblem.salary) from tblem)
and deptno =(
		select deptno 
		from tblem 
		where ename='Smith' and EmpNo=7369)				       