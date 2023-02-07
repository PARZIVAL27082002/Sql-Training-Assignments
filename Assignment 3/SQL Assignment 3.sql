create table Department(
dept_id int identity(1,1) primary key,
dept_name nvarchar(50) not null,
);

create table Employee(
emp_id int identity(1,1) primary key,
dept_id int foreign key references Department(dept_id),
mngr_id int,
emp_name nvarchar(50),
salary int 
);

insert into Department values('managment'),
('Hr'),('Devlopement'),('Design');

insert into Employee values(1,1,'Test_1',35000),
(2,2,'Test_2',450000),
(1,2,'Test_3',20000),
(2,3,'Test_4',40000),
(3,4,'Test_5',65000),
(2,5,'Test_6',60000),
(1,7,'Test_7',50000),
(3,6,'Test_8',55000);

--1. Write a SQL query to find Employees who have the biggest salary in their Department.
Select * from Employee where salary in(Select max(salary) from Employee group by dept_id)

--2. write a SQL query to find Departments that have less than 3 people in it
Select D.dept_name from Employee E right join Department D on E.dept_id=D.dept_id group by D.dept_name having COUNT(emp_id)<3

--3. write a SQL query to find All Department along with the number of people there.
Select D.dept_name, COUNT(emp_id) from Employee E right join Department D on E.dept_id=D.dept_id group by D.dept_name

--4. write a SQL query to find All Department along with the total salary there
Select D.dept_name, sum(salary) from Employee E right join Department D on E.dept_id=D.dept_id group by D.dept_name