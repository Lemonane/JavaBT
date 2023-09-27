package org.example.Model;

import java.time.LocalDateTime;
import java.util.Scanner;

public class Product {
/**
 *  ProductId     VARCHAR(5) PRIMARY KEY,
 *     ProductName   VARCHAR(100) NOT NULL UNIQUE,
 *     Price         FLOAT CHECK (Price > 0),
 *     CreateDate    DATE DEFAULT (CURRENT_DATE),
 *     Quantity      INT  DEFAULT 0,
 *     View          INT  DEFAULT 0,
 *     CatalogId     INT          NOT NULL,
 *     ProductStatus BIT  DEFAULT 1,
 */
    private String productId;

    private String productName;
    private float price;
    private int quantity;
    private LocalDateTime createDate;
    private int view;
    private int catalogId;
    private boolean ProductStatus;

    public Product() {
    }

    public Product(String productId,
                   String productName,
                   float price,
                   LocalDateTime createDate,
                   int quantity,
                   int view,
                   int catalogId,
                   boolean productStatus) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.createDate = createDate;
        this.quantity = quantity;
        this.view = view;
        this.catalogId = catalogId;
        ProductStatus = productStatus;
    }
    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public boolean isProductStatus() {
        return ProductStatus;
    }

    public void setProductStatus(boolean productStatus) {
        ProductStatus = productStatus;
    }
    public void inputData(Scanner scanner)
    {
        scanner.nextLine();
        System.out.println("Nhập id product");
        productId = scanner.nextLine();
        System.out.println("Nhập tên sản phẩm : ");
        productName = scanner.nextLine();
        System.out.println("Nhập giá sản phẩm :");
        price = scanner.nextFloat();
        System.out.println("Nhập số lượng");
        quantity = scanner.nextInt();
        System.out.println("Nhập id category thuộc về : ");
        catalogId = scanner.nextInt();
    }

}
