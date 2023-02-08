--1. Create a stored procedure in the Northwind database that will calculate the average value of Freight for a specified customer.Then, a business rule will be added that will
--be triggered before every Update and Insert command in the Orders controller,and will use the stored procedure to verify that the Freight does not exceed the average
--freight. If it does, a message will be displayed and the command will be cancelled.

create procedure sp_ValidateFreight
    -- inputted customer
    @CustomerID nvarchar(5),
    -- returned average freight
    @AverageFreight money output
as
begin
   select @AverageFreight = AVG(Freight) 
   from Orders
   where CustomerID = @CustomerID
end
go

Declare @AvgFreight int;
execute sp_ValidateFreight VINET, @AvgFreight output;
Print @AvgFreight

Create trigger tr_VerifyFreightForInsert
on Orders
Instead of insert
as
begin
	Declare @AvgFreightOfOrders money
	Declare @CustID nchar(5)
	Declare @Freight money
	Select @CustId=CustomerID from inserted
	Select @Freight=Freight from inserted
	-- execute stored procedure
	exec sp_ValidateFreight @CustID,
		@AverageFreight = @AvgFreightOfOrders output
	-- check the freight
		if @AvgFreightOfOrders is not null 
			and @AvgFreightOfOrders < @Freight 
		begin
			Raiserror('Invalid data as Freight value exceeds the average freight value',16,1)
			return
		end
end

Create trigger tr_VerifyFreightForUpdate
on Orders
Instead of update
as
begin
	Declare @AvgFreightOfOrders money
	Declare @CustID nchar(5)
	Declare @Freight money
	Select @CustId=CustomerID from inserted
	Select @Freight=Freight from inserted
	-- execute stored procedure
	exec sp_ValidateFreight @CustID,
		@AverageFreight = @AvgFreightOfOrders output
	-- check the freight
		if @AvgFreightOfOrders is not null 
			and @AvgFreightOfOrders < @Freight 
		begin
			Raiserror('Invalid data as Freight value exceeds the average freight value',16,1)
			return
		end
end

Insert into Orders values('VINET',null,null,null,null,null,23,null,null,null,null,null,null);

--2. write a SQL query to Create Stored procedure in the Northwind database to retrieve Employee Sales by Country.
Create procedure sp_EmployeeSalesByCountry
as
Begin
SELECT EmployeeID, ShipCountry, COUNT(OrderID) as [Number of orders] from Orders group by ShipCountry,EmployeeID
End

execute sp_EmployeeSalesByCountry

--3. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales by Year.
Create procedure sp_SalesByYear
as
Begin
SELECT Year(OrderDate) as [Year], COUNT(OrderID) as [Number of orders] from Orders group by Year(OrderDate)
End

execute sp_SalesByYear

--4. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales By Category.
Create procedure sp_SalesByCategory
as
Begin
SELECT CategoryName, COUNT(O.OrderID) as [Number of orders] from Orders O inner join [Order Details] OD on O.OrderID = OD.OrderID inner join
Products P on P.ProductID = OD.ProductID inner join Categories C on P.CategoryID=C.CategoryID group by  CategoryName
End

execute sp_SalesByCategory

--5. write a SQL query to Create Stored procedure in the Northwind database to retrieve Ten Most Expensive Products
Create procedure sp_Top10MostExpensiveProducts
as
Begin
SELECT top 10 ProductName, UnitPrice from Products order by UnitPrice Desc
End

execute sp_Top10MostExpensiveProducts

--6. write a SQL query to Create Stored procedure in the Northwind database to insert Customer Order Details
create procedure sp_InsertIntoOrderDetails
@OrderID int,@ProductID int,@UnitPrice money,@Quantity smallint,@Discount real
as
begin
insert into [Order Details]values(@OrderID,@ProductID,@UnitPrice,@Quantity,@Discount)
end

execute sp_InsertIntoOrderDetails 10627,60,14,12,0

--7. write a SQL query to Create Stored procedure in the Northwind database to update Customer Order Details
create procedure sp_UpdateIntoOrderDetails
@OrderID int,@ProductID int,@UnitPrice money,@Quantity smallint,@Discount real
as
begin
update [Order Details] set UnitPrice=@UnitPrice, Quantity=@Quantity, Discount=@Discount
where OrderID=@OrderID and ProductID=@ProductID
end

execute sp_UpdateIntoOrderDetails 10627,60,13,11,0