--Create Tables
create table Salesman(
salesman_id int primary key identity(1,1),
name varchar(40),
city varchar(40),
commission decimal(18,2)
);

create table customer(
customer_id int primary key identity(1,1),
cust_name nvarchar(50),
city nvarchar(50),
grade int,
salesman_id int FOREIGN KEY REFERENCES Salesman(salesman_id)
);

create table orders(
ord_no int primary key identity(1,1),
purch_amt decimal(18,2),
ord_date date,
customer_id int foreign key references customer(customer_id),
salesman_id int foreign key references Salesman(salesman_id)
);

--Populate tables

insert into Salesman values('test1','ahmedabad',0.15),
('test2','vadodara',0.13),
('test3','rajkot',0.11),
('test4','surat',0.12),
('test5','junagadh',0.14),
('test6','bharuch',0.13);

insert into customer  values('test1_c','ahmedabad',100,1),
('test2_c','ahmedabad',200,1),
('test3_c','surendranagar',200,2),
('test4_C','rajkot',300,2),
('test5_c','surat',300,6),
('test6_c','bhavnagar',100,3),
('test7_c','kutch',200,4),
('test8_C','rajkot',null,5);

insert into orders values(150.5,'2012-10-5',5,2),
(270.65,'2012-09-10',1,5),
(65.26,'2012-10-05',2,1),
(110.5,'2012-08-17',8,3),
(948.5,'2012-09-10',5,2),
(2400.6,'2012-07-27',7,1),
(5760,'2012-09-10',2,1),
(1983.43,'2012-10-10',4,6),
(2480.4,'2012-10-10',8,3),
(250.45,'2012-06-27',7,2),
(75.29,'2012-08-17',3,6),
(3045.6,'2012-04-25',2,1);

--Write a SQL query to find the salesperson and customer who reside in the same city.Return Salesman, cust_name and city.
Select name as salesperson,cust_name,S.city as city from Salesman S inner join customer C on S.salesman_id = C.salesman_id

--Write a SQL query to find those orders where the order amount exists between 500and 2000. Return ord_no, purch_amt, cust_name, city.
Select ord_no, purch_amt,cust_name,C.city as city from orders O inner join customer C on O.customer_id = C.customer_id where purch_amt between 500 and 2000

--Write a SQL query to find the salesperson(s) and the customer(s) he represents.Return Customer Name, city, Salesman, commission
Select name as salesperson,cust_name,S.city as city, S.commission as comission from Salesman S inner join customer C on S.salesman_id = C.salesman_id

--Write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.
Select name as salesperson,cust_name,S.city as city, S.commission as comission from Salesman S inner join customer C on S.salesman_id = C.salesman_id where commission > 0.12

--write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the
--company. Return Customer Name, customer city, Salesman, salesman city, commission
Select name as salesperson,cust_name,S.city as Salesmancity,C.city as Customercity, S.commission as comission from Salesman S inner join customer C on S.salesman_id = C.salesman_id 
where commission > 0.12 and S.city <> C.city

--write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission
Select ord_no, purch_amt,ord_date,C.cust_name,grade,S.name as Salesman,commission from orders O inner join customer C on O.customer_id = C.customer_id 
inner join Salesman S on O.salesman_id = S.salesman_id

--Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned.
Select * from orders O inner join customer C on O.customer_id = C.customer_id 
inner join Salesman S on O.salesman_id = S.salesman_id where S.salesman_id = O.salesman_id and O.salesman_id = C.salesman_id

--write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.
Select C.cust_name, C.city, grade, S.name, S.city from orders O inner join customer C on O.customer_id = C.customer_id inner join Salesman S on O.salesman_id = S.salesman_id order by C.customer_id ASC

--write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.
Select C.cust_name, C.city, grade, S.name, S.city from orders O inner join customer C on O.customer_id = C.customer_id inner join Salesman S on O.salesman_id = S.salesman_id where grade<300 
order by C.customer_id ASC

--Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to
--determine whether any of the existing customers have placed an order or not.
Select C.cust_name, C.city, ord_no, purch_amt from orders O right outer join customer C on O.customer_id = C.customer_id order by ord_date ASC

--Write a SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of
--the existing customers have not placed orders or if they have placed orders through their salesman or by themselves
Select C.cust_name, C.city, name as SalesmanName,commission, ord_no, purch_amt, ord_date from orders O right outer join customer C on O.customer_id = C.customer_id left outer join Salesman S
on S.salesman_id = C.salesman_id

--Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers
Select * from Salesman S left outer join customer C on S.salesman_id = C.salesman_id

--write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.
Select S.name as salesmanName,C.cust_name, C.city, grade, ord_date, ord_no, purch_amt from orders O inner join customer C on O.customer_id = C.customer_id inner join Salesman S on O.salesman_id = S.salesman_id 

--Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customers. The customer may have placed,
--either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
SELECT C.cust_name,C.city,C.grade, S.name AS "Salesman", O.ord_no, O.ord_date, O.purch_amt FROM customer C RIGHT OUTER JOIN salesman S ON S.salesman_id=C.salesman_id 
LEFT OUTER JOIN orders O ON O.customer_id=C.customer_id WHERE O.purch_amt>=2000 AND C.grade IS NOT NULL

--Write a SQL statement to generate a list of all the salesmen who either work for one or more customers or have yet to join any of them. The customer may have placed
--one or more orders at or above order amount 2000, and must have a grade, or he may not have placed any orders to the associated supplier.
SELECT C.cust_name,C.city,C.grade, S.name AS "Salesman", O.ord_no, O.ord_date, O.purch_amt FROM customer C RIGHT OUTER JOIN salesman S ON S.salesman_id=C.salesman_id 
LEFT OUTER JOIN orders O ON O.customer_id=C.customer_id WHERE O.purch_amt>=2000 AND C.grade IS NOT NULL

--Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a
--grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.
SELECT C.cust_name,C.city,O.ord_no,O.ord_date,O.purch_amt AS "Order Amount" FROM customer C FULL OUTER JOIN orders O ON C.customer_id=O.customer_id WHERE C.grade IS NOT NULL;

--Write a SQL query to combine each row of the salesman table with each row of the customer table
Select * from Salesman cross join customer

--Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city
Select * from Salesman S cross join customer C where S.city = C.city

--Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade
Select * from Salesman S cross join customer C where S.city is not null and C.grade is not null

--Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa for those
--salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade
Select * from Salesman S cross join customer C where S.city <> C.city and C.grade is not null