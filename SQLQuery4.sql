--1
--Retrieve number of students who have a value in their age. 
select count(ST_ID)
from Student 
where St_Age is not null ;

--2
--Get all instructors Names without repetition
select distinct Ins_Name
from Instructor ;

--3 (Check)
--Display student with the following Format (use isNull function)
Select St_Id "student Id " , concat(isnull (St_Fname ,''),'',isnull (st_lname,'') )"Student Full Name " ,Dept_name "Department Name "
from Student s ,department d
where s.dept_id =d.dept_id ;

--4 
--Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not
select Ins_Name ,isnull(Dept_Name ,'no department')
from Instructor i left join Department d
on i.Dept_Id =d.Dept_Id ;

--5(Check)
--Display student full name and the name of the course he is taking
--For only courses which have a grade  
select St_Fname , St_Lname ,Crs_Name
from Student s,course c ,Stud_Course sc
where s.St_Id=sc.St_Id
and c.Crs_Id=sc.Crs_Id
and sc.Grade is not null ;

--6
--Display number of courses for each topic name
select top_Name , count(crs_id) "Number of Courses "
from Course c , Topic t
where c.Top_Id=t.Top_Id
group by Top_Name ;

--7
--Display max and min salary for instructors
select MAX (salary) "max" , min (salary) "min"
from Instructor ;

--8
--Display instructors who have salaries less than the average salary of all instructors.
select Ins_Name , Salary
from Instructor
where salary < (select avg(isnull (salary ,0)) from Instructor) ;

--9
--Display the Department name that contains the instructor who receives the minimum salary.
select Dept_Name 
from Department d, Instructor i
where d.Dept_Id=i.Dept_Id
and i.Salary = (select MIN(salary)from Instructor);

--10 
--Select max two salaries in instructor table. 
select top(2)Salary 
from Instructor
Order by Salary desc ;

--11
--Select instructor name and his salary but if there is no salary display instructor bonus keyword.
--“use coalesce Function”
select Ins_Name , Coalesce (convert (varchar(15),Salary ),'Instructor Bouns')
from instructor ;


--12
--Select Average Salary for instructors 
select AVG(isnull(salary,0))
from Instructor;

--13(check )//Self join 
--Select Student first name and the data of his supervisor 
select p.* , s.St_Fname 
from Student s, Student p
where s.St_super=p.St_Id;

--14 (important )
--Write a query to select the highest two salaries in Each Department for instructors who have salaries.
--“using one of Ranking Functions”
SELECT salary, Dept_Id
FROM (
    SELECT salary, Dept_Id,
           DENSE_RANK() OVER (PARTITION BY Dept_Id ORDER BY salary DESC) r
    FROM Instructor
    WHERE salary IS NOT NULL
) t
WHERE r <= 2;

--15 (Important )
--Write a query to select a random  student from each department.  “using one of Ranking Functions

SELECT St_fname , St_lname, Dept_Id
FROM (
    SELECT St_fname , St_lname, Dept_Id,
           ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY NEWID()) AS rn
    FROM Student
) AS ranked_students
WHERE rn = 1;



