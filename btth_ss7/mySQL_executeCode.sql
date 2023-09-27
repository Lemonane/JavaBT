use jdbc;
CREATE TABLE Categories
(
    CatalogId     INT AUTO_INCREMENT PRIMARY KEY,
    CatalogName   VARCHAR(100) NOT NULL UNIQUE,
    Priority      INT          NOT NULL,
    CatalogStatus BIT DEFAULT 1
);

CREATE TABLE Product
(
    ProductId     VARCHAR(5) PRIMARY KEY,
    ProductName   VARCHAR(100) NOT NULL UNIQUE,
    Price         FLOAT CHECK (Price > 0),
    CreateDate    DATE DEFAULT (CURRENT_DATE),
    Quantity      INT  DEFAULT 0,
    View          INT  DEFAULT 0,
    CatalogId     INT          NOT NULL,
    ProductStatus BIT  DEFAULT 1,
    FOREIGN KEY (CatalogId) REFERENCES Categories (CatalogId)
);

DELIMITER //
-- category
-- 1
create procedure showCategories()
begin
    select * from Categories where CatalogStatus = 1;
end //

-- 2
create procedure showCateOrderByPriorityAsc()
begin
    select * from Categories order by Priority asc ;
end //

-- 3
CREATE PROCEDURE addCategory(IN newCategoryName varchar(100), IN newPriority INT)
begin
    insert into Categories(catalogname, priority) VALUE (newCategoryName, newPriority);
end //

-- 4
create procedure updateCategory(in cateId int, in newCategoryName varchar(100), in newPriority int)
begin
    update Categories
    set CatalogName = newCategoryName,
        Priority    = newPriority
    where CatalogId = cateId;
end //

-- 5
# DELIMITER
//
CREATE PROCEDURE deleteCategory(IN cateId INT, OUT isSuccess BOOLEAN, OUT message VARCHAR(100))
BEGIN
    DECLARE rowsAffected INT;
    DECLARE productCount INT;

    SELECT COUNT(*) INTO productCount FROM Product WHERE CatalogId = cateId;

    IF productCount > 0 THEN
        SET isSuccess = FALSE;
        SET message = 'Có sản phẩm tham chiếu đến danh mục nên không thể xoá !';
    ELSE
        DELETE FROM Categories WHERE CatalogId = cateId;
        SET rowsAffected = ROW_COUNT();

        IF rowsAffected > 0 THEN
            SET isSuccess = TRUE;
        ELSE
            SET isSuccess = FALSE;
            SET message = 'Không tồn tại category có id: ' || cateId;
        END IF;
    END IF;
END //
# DELIMITER ;


-- 6
create procedure findCategoryByName(in categoryName varchar(100))
begin
    select * from Categories where CatalogName = categoryName;
end //

-- 7
create procedure updateCateStatus(in cateId int, in newCatalogStatus bit)
begin
    update Categories set CatalogStatus = newCatalogStatus where CatalogId = cateId;
end //

-- product
-- 1
create procedure DisplayProducts()
begin
    select * from Product;
end //

-- 2
create procedure DisplayProductsByPrice()
begin
    select * from Product order by Price desc;
end //

-- 3
create procedure AddProduct(in new_ProductId varchar(5), in new_ProductName varchar(100), in new_Price float,
                            in new_Quantity int, in new_CatalogId int, out message varchar(100))
begin
    DECLARE v_exists BOOLEAN;

    -- Kiểm tra tồn tại của ProductId
    SET v_exists = (SELECT EXISTS(SELECT 1 FROM Product WHERE ProductId = new_ProductId));
    IF v_exists THEN
        SET message = 'ID sản phẩm đã tồn tại, vui lòng nhập ID khác.';
    ELSE
        -- Kiểm tra tồn tại của ProductName
        SET v_exists = (SELECT EXISTS(SELECT 1 FROM Product WHERE ProductName = new_ProductName));
        IF v_exists THEN
            SET message = 'Tên sản phẩm đã tồn tại, vui lòng nhập tên khác.';
        ELSE
            -- Thêm sản phẩm mới nếu không có ID hoặc tên sản phẩm trùng lặp
            INSERT INTO Product (ProductId, ProductName, Price, Quantity, CatalogId)
            VALUES (new_ProductId, new_ProductName, new_Price, new_Quantity, new_CatalogId);
            SET message = 'Sản phẩm đã được thêm thành công.';
        END IF;
    END IF;
end
//
-- 4
CREATE PROCEDURE UpdateProduct(IN found_ProductId VARCHAR(5), IN new_ProductName VARCHAR(100), IN new_Price FLOAT,
                               IN new_Quantity INT, IN new_CatalogId INT, OUT message VARCHAR(100))
BEGIN
    DECLARE v_exists BOOLEAN;

    -- Kiểm tra tồn tại của ProductName mà không phải là chính sản phẩm đang được cập nhật
    SET v_exists = (SELECT EXISTS(SELECT 1 FROM Product WHERE ProductName = new_ProductName AND ProductId <> found_ProductId));
    IF v_exists THEN
        SET message = 'Tên sản phẩm đã tồn tại, vui lòng nhập tên khác.';
    ELSE
        -- Cập nhật sản phẩm
        UPDATE Product
        SET ProductName = new_ProductName,
            Price       = new_Price,
            Quantity    = new_Quantity,
            CatalogId   = new_CatalogId
        WHERE ProductId = found_ProductId;

        -- Kiểm tra xem có hàng nào được cập nhật không
        IF ROW_COUNT() > 0 THEN
            SET message = 'Sản phẩm đã được cập nhật thành công.';
        ELSE
            SET message = 'Không tồn tại sản phẩm có ID: ' || found_ProductId;
        END IF;
    END IF;
END //
-- 5
create procedure SearchProductByName(in new_ProductName varchar(100))
begin
    select * from Product where ProductName like concat('%', new_ProductName, '%');
end
//

-- 6
create procedure SearchProductByPriceRange(in new_PriceLow float, in new_PriceHigh float)
begin
    select * from Product where Price between new_PriceLow and new_PriceHigh;
end
//

-- 7
create procedure SellProduct(in p_ProductId varchar(5), in p_Quantity int)
begin
    update Product
    set Quantity = Quantity - p_Quantity
    where ProductId = p_ProductId;
end
//
CREATE PROCEDURE DeleteProduct(
    IN p_ProductId VARCHAR(5)
)
BEGIN
    DELETE FROM Product
    WHERE ProductId = p_ProductId;
END //
-- 8
CREATE PROCEDURE UpdateProductStatus(IN p_ProductId VARCHAR(5), IN p_Status BOOLEAN)
BEGIN
    UPDATE Product SET ProductStatus = p_Status WHERE ProductId = p_ProductId;
END //

-- report
-- 1
create procedure ReportNumberOfCategoriesByStatus()
begin
    select CatalogStatus, count(*) as NumberOfCategories
    from Categories
    group by CatalogStatus;
end
//

-- 2
create procedure ReportNumberOfProductsByStatus()
begin
    select ProductStatus, count(*) as NumberOfProducts
    from Product
    group by ProductStatus;
end
//

-- 3
create procedure ReportNumberOfProductsByCategory()
begin
    select c.CatalogName, count(p.ProductId) as NumberOfProducts
    from Categories c
             left join Product p on c.CatalogId = p.CatalogId
    group by c.CatalogId, c.CatalogName;
end
//

DELIMITER ;



