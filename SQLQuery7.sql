--1
--Create a view that displays student full name, course name if the student has a grade more than 50. 
create view pass as 
(select St_Fname +' '+ St_Lname "Full Name " , crs_Name 
from student s ,Stud_Course sc,Course c
where s.St_Id=sc.st_id 
and sc.Crs_Id=c.Crs_Id
and Grade >50 )

GO

--2
--Create an Encrypted view that displays manager names and the topics they teach. 
Create view MG_T as 
(select Ins_Name ,Top_Name
from Instructor i , Department d ,Course c ,Ins_Course IC ,Topic t
where d.Dept_Id =i.Dept_Id
and i.Ins_Id=ic.Ins_Id
and c.Crs_Id =ic.Crs_Id
and t.Top_Id =c.Top_Id)


GO

--3
--Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
create view ins_sj as 
(select Ins_Name , Dept_Name
from Instructor i, Department d
where i.Dept_Id=d.Dept_Id
and Dept_Name in ('SD' , 'Java'))

GO 

--4 
--Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;

create view V1 as 
select *
from dbo.Student
where St_Address in ('Alex' , 'Cairo ') with check option 

Go 

--trying the prevented condtions 
Update V1 set st_address='tanta'
Where st_address='alex';

--5
--Create a view that will display the project name and the number of employees work on it. “Use Company DB”
create view pj_em as
(Select Pname , count(Essn) " Employess Count "
from Project p , Works_for w
where p.Pnumber=w.Pno 
group by Pname )

go

--11
--Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a newly created table named [store_Archive] 
--Note: Check your database to see the new table and how many rows in it? 
--Try the previous query but without transferring the data?  

CREATE TABLE Sales.store_Archive (
    rowguid UNIQUEIDENTIFIER,
    Name VARCHAR(50),
    SalesPersonID INT,
    Demographics XML
)

INSERT INTO Sales.store_Archive (rowguid, Name, SalesPersonID, Demographics)
SELECT rowguid, Name, SalesPersonID, Demographics
FROM Sales.Store;

SELECT COUNT(*) "Row Count "
FROM Sales.store_Archive;

SELECT * FROM Sales.store_Archive;




