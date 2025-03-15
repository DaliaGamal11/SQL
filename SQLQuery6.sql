-- creating db
create database ins_courses

-- creating instructor table 
create table Instructor 
(ID int Identity Primary key , Fname varchar(15) ,lname varchar(15) , salary int , BD varchar(15) , address varchar(50) ,
HireDate varchar(15) , overtime varchar(15) ,
Age as year(getdate())-year(BD) , NetSalary as Salary + overtime )

-- creating course table 
create table Course 
(CID int Identity Primary key ,CName varchar(15) ,Duration varchar(15))

--Teach relation between between instructor and course (Many to many relationship )
create table Teach
(ID int  ,CID int ,constraint pk primary key (ID  , CID ) ,
Constraint fk1 foreign key (ID) references instructor(ID) on delete cascade on update cascade,
Constraint fk2 foreign key (CID) references Course(CID) on delete cascade on update cascade  )

--creating lab table 
create table Lab 
(LID int identity Primary key , Location varchar(15) , Capacity varchar(15), CID int
Constraint fk3 foreign key (CID) references Course(CID) on delete cascade on update cascade)


--Address has only cairo or alex value
Alter table instructor 
add constraint only check ( address in ('Alex ' ,'Cairo' ) )

--All salaries in the range from 1000 to 5000
Alter table instructor
add constraint Rang check ( Salary between 1000 and 5000 )

--Salary has a default value = 3000
Alter table instructor
add constraint df Default 3000 for Salary

--Overtime is unique
Alter table instructor
add constraint uq unique ( overtime )

--Capacity of each lab under 20 seats
Alter table Lab
add constraint seats check (capacity <20 )

--Lab is weak entity (Check )
Alter table Lab
drop column LID --geting constraint name

Alter table Lab
drop constraint PK__Lab__C6555721A401BC5C 

ALTER TABLE Lab
ALTER COLUMN CID INT NOT NULL;

Alter table Lab
add constraint pk4 primary key (CID ,LID )

--Hiredate has a default value= current system data
Alter table instructor
add constraint df2 Default Getdate() for Hiredate

--Duration of each course is unique
Alter table course 
add constraint uq2 unique (Duration )
