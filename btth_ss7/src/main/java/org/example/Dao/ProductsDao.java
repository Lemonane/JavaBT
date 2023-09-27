package org.example.Dao;

import org.example.Model.Product;

import java.sql.*;
import java.util.Scanner;

public class ProductsDao {
    private final Connection connection;

    public ProductsDao(Connection connection) {
        this.connection = connection;
    }

    public void displayProducts() throws SQLException {
        String storedProc = "{call DisplayProducts()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                System.out.println();
                // Hiển thị thông tin sản phẩm
                System.out.println("Product Id : " + rs.getString("ProductId")
                        + "\n" + "Product name : " + rs.getString("ProductName")
                        + "\n" + "Price : " + rs.getFloat("Price")
                        + "\n" + "CreateDate : " + rs.getDate("CreateDate")
                        + "\n" + "Quantity : " + rs.getInt("Quantity")
                        + "\n" + "View : " + rs.getInt("View")
                        + "\n" + "CatalogId : " + rs.getInt("CatalogId")
                        + "\n" + "Status : " + rs.getBoolean("ProductStatus"));
            }
        }
    }

    public void displayProductsByPrice() throws SQLException {
        String storedProc = "{call DisplayProductsByPrice()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                // Hiển thị thông tin sản phẩm (điều chỉnh nếu cần)
                System.out.println(rs.getString("ProductName") + " - " + rs.getFloat("Price"));
            }
        }
    }

    public void addProduct(Scanner scanner) throws SQLException {
        String storedProc = "{call AddProduct(?,?,?,?,?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            Product product = new Product();
            product.inputData(scanner);
            cs.setString(1, product.getProductId());
            cs.setString(2, product.getProductName());
            cs.setFloat(3, product.getPrice());
            cs.setInt(4, product.getQuantity());
            cs.setInt(5, product.getCatalogId());

            cs.registerOutParameter(6, Types.VARCHAR);

            cs.executeUpdate();

            String message = cs.getString(6);
            System.out.println(message);
        }
    }

    public void updateProduct(Scanner scanner) throws SQLException {
        String storedProc = "{call UpdateProduct(?,?,?,?,?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine(); // xoá các dòng trước
            System.out.println("Nhập id sản phẩm để cập nhật:");
            String inputId = scanner.nextLine();
            cs.setString(1, inputId);

            System.out.println("Nhập tên sản phẩm mới:");
            String inputName = scanner.nextLine();
            cs.setString(2, inputName);
            System.out.println("Nhập giá sản phẩm mới:");
            float inputPrice = scanner.nextFloat();
            cs.setFloat(3, inputPrice);

            System.out.println("Nhập số lượng sản phẩm mới:");
            int inputQuantity = scanner.nextInt();
            cs.setInt(4, inputQuantity);

            System.out.println("Nhập id danh mục sản phẩm mới:");
            int inputCatalogId = scanner.nextInt();
            cs.setInt(5, inputCatalogId);

            cs.registerOutParameter(6, Types.VARCHAR);
            cs.execute();

            String message = cs.getString(6);
            System.out.println(message);
        }
    }

    public void updateProductStatus(Scanner scanner) throws SQLException {
        String storedProc = "{call UpdateProductStatus(?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine(); // clean
            System.out.println("Nhập ID sản phẩm:");
            String productId = scanner.nextLine();
            System.out.println("Nhập trạng thái mới (true/false):");
            boolean status = scanner.nextBoolean();

            cs.setString(1, productId);
            cs.setBoolean(2, status);

            int rowsAffected = cs.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Trạng thái sản phẩm đã được cập nhật thành công.");
            } else {
                System.out.println("Không tồn tại sản phẩm có id: " + productId);
            }
        }
    }

    public void deleteProduct(Scanner scanner) throws SQLException {
        String storedProc = "{call DeleteProduct(?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine();// clean
            System.out.println("Nhập ID sản phẩm để xoá:");
            String productId = scanner.next();

            cs.setString(1, productId);

            int rowsAffected = cs.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Sản phẩm đã được xoá thành công.");
            } else {
                System.out.println("Không tồn tại sản phẩm có id: " + productId);
            }
        }
    }

    public void searchProductByName(Scanner scanner) throws SQLException {
        String storedProc = "{call SearchProductByName(?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine();// clean
            System.out.println("Nhập tên sản phẩm:");
            String productName = scanner.next();
            cs.setString(1, productName);

            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString("ProductName") + " - " + rs.getFloat("Price"));
            }
        }
    }

    public void searchProductByPriceRange(Scanner scanner) throws SQLException {
        String storedProc = "{call SearchProductByPriceRange(?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine();// clean
            System.out.println("Nhập khoảng giá (a b):");
            float priceLow = scanner.nextFloat();
            float priceHigh = scanner.nextFloat();
            cs.setFloat(1, priceLow);
            cs.setFloat(2, priceHigh);

            ResultSet rs = cs.executeQuery();
            while (rs.next()) {
                // Hiển thị thông tin sản phẩm (điều chỉnh nếu cần)
                System.out.println(rs.getString("ProductName") + " - " + rs.getFloat("Price"));
            }
        }
    }

    public void sellProduct(Scanner scanner) throws SQLException {
        String storedProc = "{call SellProduct(?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            scanner.nextLine();// clean
            System.out.println("Nhập ID sản phẩm:");
            String productId = scanner.next();
            System.out.println("Nhập số lượng:");
            int quantity = scanner.nextInt();
            cs.setString(1, productId);
            cs.setInt(2, quantity);

            int rowsAffected = cs.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Sản phẩm đã được bán thành công.");
            } else {
                System.out.println("Không đủ hàng hoặc không tồn tại sản phẩm có id: " + productId);
            }
        }
    }
}
