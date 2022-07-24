-- Chỉ định dùng csdl
Use AdventureWorks2017
go

-- Câu 1: Tạo và nhập liệu cho csdl trên.
-- Đã thực hiện

-- Câu 2. Viết các câu truy vấn sau
-- a. Cho danh sách các sản phẩm (mã, tên, giá) được mua từ ngày X đến ngày Y
select ProductID, Name, ListPrice
from Production.Product
where DAY(SellStartDate) >= 10 and DAY(SellEndDate) <= 29
go
-- b. Cho danh sách các saleperson làm việc/bán hàng online trong tháng 7/2011.
select * 
from Sales.SalesPerson
where DAY(ModifiedDate) = '7' and YEAR(ModifiedDate) = '2021'
go
-- c. Nâng cao: cho danh sách các thành phần cấu thành “bicycles” (gợi ý: SQL Server Recursive CTE)
-- (Note: Trong CSDL mẫu không có thể loại bicycles nên đã chuyển sang "Bikes")
WITH Bikes (Name)
AS
(
	select P.Name
	from Production.ProductCategory as PC
	inner join Production.ProductSubcategory as PS
	on PC.ProductCategoryID = PS.ProductCategoryID
	inner join Production.Product as P
	on PS.ProductSubcategoryID = P.ProductSubcategoryID
	where PC.Name like N'Bikes'
)
select *
from Bikes
go

-- Câu 3: Viết Functuion

-- a. Cho biết standardCost của 1 sản phẩm cho trước được đặt vào 1 ngày cụ thể
create function standardCost(@Name_Product nvarchar(50), @Date_Created datetime)
returns money
as
begin
	DECLARE @standardCost money;
	select @standardCost = P_PCH.StandardCost
	from Sales.ShoppingCartItem as S_SCI
	inner join Production.Product as P_P
	on S_SCI.ProductID = P_P.ProductID
	inner join Production.ProductCostHistory as P_PCH
	on P_P.ProductID = P_PCH.ProductID
	where P_P.Name like @Name_Product and S_SCI.DateCreated = @Date_Created
	return @standardCost
end
go
-- Thực thi function standardCost
PRINT dbo.standardCost(N'Full-Finger Gloves, M', '2013-11-09 17:54:07.603')
go

-- b. Cho biết số lượng trong kho tại 1 locationID cho trước của 1 sản phẩm cụ thể
create function quantity(@Location_ID smallint, @Name_Product nvarchar(50))
returns int
as
begin
	DECLARE @quantity money;
	select @quantity = PIn.LocationID
	from Production.Product as P
	inner join Production.ProductInventory as PIn
	on P.ProductID = PIn.ProductID
	where PIn.LocationID = @Location_ID and P.Name like @Name_Product

	return @quantity
end
go
-- Thực thi function quantity
PRINT dbo.quantity(50, N'Adjustable Race')