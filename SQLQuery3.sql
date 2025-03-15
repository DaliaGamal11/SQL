--1 
--Display (Using Union Function) 
 --The name and the gender of the dependence that's gender is Female and depending on Female Employee. 
 --And the male dependence that depends on Male Employee.

 select Dependent_name , d.sex 
 from Dependent d Join Employee e ON Essn=SSN
 where d.sex='F'
 And e.Sex='F'
 union 
 select Dependent_name , d.sex 
 from Dependent d Join Employee e ON Essn=SSN
 where d.sex='M'
 And e.Sex='M';


 --2
 --For each project, list the project name and the total hours per week (for all employees) spent on that project. 
 select Pname , Sum(Hours)
 from Project  ,Works_for 
 Where Pnumber=Pno
 GROUp BY pname ;

 --3
 --Display the data of the department which has the smallest employee ID over all employees' ID. 
 select Dname ,Dnum ,MGRSSN ,[MGRStart Date]
 from Departments , Employee
 where Dnum=Dno 
 AND SSN=(select min(SSN) from Employee);

 --4
 --For each department, retrieve the department name and the maximum, minimum and average salary of its employees
 select Dname , MAX (Salary) "MAX " ,MIN(Salary) "MIN" , AVG(Salary) "AVR"
 from Departments , Employee
 where Dnum=Dno
 Group by Dname;

 --5 (REcheck )
 --List the full name of all managers who have no dependents. 
SELECT Fname + ' ' + Lname AS "Full Name"
FROM Employee
WHERE SSN NOT IN (SELECT Essn FROM Dependent)

INTERSECT

SELECT Fname + ' ' + Lname AS "Full Name"
FROM Employee e
JOIN Departments d ON e.SSN = d.MGRSSN;


--6
--For each department-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees.

select Dname , Dnum ,count (SSN)
from Departments  ,Employee 
where Dnum =Dno
Group by Dnum ,Dname
Having AVG(salary ) < ( Select AVG (Salary) from Employee );

--7 
--Retrieve a list of employees names and the projects names they are working on ordered 
--by department number and within each department, ordered alphabetically by last name, first name.


select Fname ,Lname , Pname ,Dno
from Employee ,Works_for, Project 
where SSn=ESSn
and Pno=Pnumber
order by Dno ,Lname,Fname;


--8
--Try to get the max 2 salaries using subquery

select max (Salary )
from Employee
union 
select max(Salary)  
from Employee
Where Salary<(select max(salary)from Employee)

--9 
--Get the full name of employees that is similar to any dependent name
select Fname +'  '+ Lname " FUll Name " 
from Employee 

Intersect 

SELECT Dependent_name
FROM Dependent ;
    


--10 
--Display the employee number and name if at least one of them have dependents (use exists keyword).
select SSN , Fname ,lname 
from Employee
where exists (
select ESSN
from Dependent 
where ESSN=SSN);

--11
--In the department table insert new department called "DEPT IT" , with id 100,
--employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'

insert into Departments
values('DEPT IT' ,100 ,112233 ,'1-11-2006');

--12
--Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100),
--and they give you(your SSN =102672) her position (Dept. 20 manager) 
--First try to update her record in the department table
--Update your record to be department 20 manager.
--Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments 
set MGRSSN=968574 
where Dnum=100;

update Departments 
set MGRSSN=102672
where Dnum=20;

update Employee
set Superssn=102672
where SSN=102660;


--13
--Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
--so try to delete his data from your database in case you know that you will be temporarily in his position. 
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works 
--in any projects and handle these cases). 

DELETE FROM Dependent
WHERE ESSN = '223344';

UPDATE Departments
SET MGRSSN = '102672'  
WHERE MGRSSN = '223344';


DELETE FROM Works_for
WHERE ESSN = '223344';

UPDATE Employee
SET Superssn = '102672' 
WHERE Superssn = '223344'

DELETE FROM Employee
WHERE SSN = '223344';



--14
--Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee
set salary=salary*1.3
where SSN IN (
Select ESSN 
from Works_for , Project
where pno=Pnumber 
and pname='Al Rabwah') ;



---practice
select fname ,bdate
from Employee
where year(getdate()) -year(bdate) >=50;





