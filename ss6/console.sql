CREATE DATABASE Trigger_Demo;
CREATE TABLE Product
(
    productId   INT PRIMARY KEY AUTO_INCREMENT,
    productName VARCHAR(50) NOT NULL,
    Price       FLOAT       NOT NULL
);
DELIMITER //

CREATE TRIGGER Tr_Insert_Price_Check
    BEFORE INSERT
    ON Products
    FOR EACH ROW
BEGIN
    DECLARE maxPrice INT;

    SELECT MAX(Price) INTO maxPrice FROM Products;

    IF NEW.Price < maxPrice THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Giá sản phẩm phải lớn hơn hoặc bằng giá sản phẩm cao nhất hiện tại';
    END IF;
END//

DELIMITER ;

-- update
CREATE TRIGGER Tr_Update_Price_Check
    BEFORE UPDATE ON Product
    FOR EACH ROW
BEGIN
    IF NEW.Price >= 1000
    THEN
        UPDATE Product
        SET Price = @Price
        WHERE productId = @productId;
    END IF;
END;