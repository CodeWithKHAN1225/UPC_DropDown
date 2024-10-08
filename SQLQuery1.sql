ALTER PROCEDURE [dbo].[GetProducts]
    @PageNumber INT = null,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;
	IF ( @PageNumber IS NULL
             OR @PageNumber = 0
           )
            BEGIN 
                SET @PageNumber = 1
                SET @PageSize = 10
            END
    -- Calculate the offset
    DECLARE @Offset INT;
    SET @Offset = (@PageNumber - 1) * @PageSize;

    SELECT 
        p.ProductID,
        p.ProductName,
        p.ProductPrice,
        p.ProductDescription,
        c.CategoryID
    FROM 
        Products p
    INNER JOIN 
        Categories c ON p.CategoryID = c.CategoryID
    ORDER BY 
        p.ProductName
    OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY;
END



---------------------------------------------------------------------------------
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY,
    OrderNumber INT NOT NULL,
    UserID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalPrice DECIMAL(18, 2) NOT NULL
);

CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY,
    OrderId INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Optional: Create a sequence for generating OrderNumber
CREATE SEQUENCE dbo.OrderNumber AS INT START WITH 10000 INCREMENT BY 1;

select * from CartItem


ALTER TABLE [dbo].[Products]
ADD [ImageFileName] [nvarchar](max) ;
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN ImageFileName;



select * from Products