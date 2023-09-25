CREATE TABLE IF NOT EXISTS Products_1
(
    ProductId     INT AUTO_INCREMENT PRIMARY KEY,
    ProductName   VARCHAR(100) NOT NULL,
    Author        VARCHAR(100),
    Price         INT NOT NULL CHECK (Price > 0),
    CreateDate    DATE DEFAULT (CURDATE()),
    Quantity      INT NULL ,
    View          INT NULL ,
    CatalogId     INT NOT NULL,
    ProductStatus BIT DEFAULT 1 NOT NULL,
    CONSTRAINT UC_Product UNIQUE (ProductName),
    CONSTRAINT FK_Product_Catalog FOREIGN KEY (CatalogId) REFERENCES Categories (CatalogId)
);
DELIMITER //

CREATE PROCEDURE ShowBooks()
BEGIN
    SELECT * FROM Products_1;
END //

CREATE PROCEDURE AddBook(IN p_bookName VARCHAR(100), IN p_price DOUBLE, IN p_author VARCHAR(100), IN p_status BIT, IN p_catalogId INT)
BEGIN
    INSERT INTO Products_1 (ProductName, Price, Author, ProductStatus, CatalogId) VALUES (p_bookName, p_price, p_author, p_status, p_catalogId);
END //


CREATE PROCEDURE UpdateBook(IN p_bookId INT, IN p_bookName VARCHAR(100), IN p_price DOUBLE, IN p_author VARCHAR(100), IN p_status BIT)
BEGIN
    UPDATE Products_1 SET ProductName = p_bookName, Price = p_price, Author = p_author, ProductStatus = p_status WHERE ProductId = p_bookId;
END //

CREATE PROCEDURE DeleteBook(IN p_bookId INT)
BEGIN
    DELETE FROM Products_1 WHERE ProductId = p_bookId;
END //

CREATE PROCEDURE SearchBookByName(IN p_bookName VARCHAR(100))
BEGIN
    SELECT * FROM Products_1 WHERE ProductName LIKE CONCAT('%', p_bookName, '%');
END //

CREATE PROCEDURE StatisticByAuthor()
BEGIN
    SELECT Author, COUNT(*) as NumberBooks FROM Products_1 GROUP BY Author;
END //

CREATE PROCEDURE SortBooksByPrice()
BEGIN
    SELECT * FROM Products_1 ORDER BY Price ASC;
END //

DELIMITER ;