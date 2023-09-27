package org.example;

import org.example.Dao.CategoriesDao;
import org.example.Dao.ProductsDao;
import org.example.Dao.ReportDao;
import org.example.Service.CategoriesService;
import org.example.Service.Impl.CategoriesServiceImpl;
import org.example.Service.Impl.ProductServiceImpl;
import org.example.Service.Impl.ReportServiceImpl;
import org.example.Service.ProductService;
import org.example.Service.ReportService;

import java.sql.*;
import java.util.Scanner;

public class ShopManagementApp {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/jdbc";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "thuong191020";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";


    public static void main(String[] args) {
        try {
            // scanner
            Scanner scanner = new Scanner(System.in);
            Class.forName(DRIVER);
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);) {
                // Data Access Layer
                CategoriesDao categoriesDao = new CategoriesDao(connection);
                ProductsDao productsDao = new ProductsDao(connection);
                ReportDao reportDao = new ReportDao(connection);
                // Business Layer
                CategoriesService categoriesServiceImpl = new CategoriesServiceImpl(categoriesDao);
                ProductService productServiceImpl = new ProductServiceImpl(productsDao);
                ReportService reportServiceImpl = new ReportServiceImpl(reportDao);
                // Display the main menu
                int choice;
                do {
                    System.out.println("*********************SHOP MANAGEMENT******************");
                    System.out.println("1. Quản lý danh mục");
                    System.out.println("2. Quản lý sản phẩm");
                    System.out.println("3. Báo cáo thống kê");
                    System.out.println("4. Thoát");
                    System.out.print("Nhập lựa chọn của bạn: ");
                    choice = scanner.nextInt();

                    switch (choice) {
                        case 1 ->
                            // Category management menu
                                categoryManagementMenu(scanner, categoriesServiceImpl);
                        case 2 ->
                            // Product management menu
                                productManagementMenu(scanner, productServiceImpl);
                        case 3 ->
                            // Report management menu
                                reportManagementMenu(scanner, reportServiceImpl);
                        case 4 -> System.out.println("Tạm biệt!");
                        default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn lại.");
                    }
                } while (choice != 4);

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load the JDBC driver", e);
        }
    }

    private static void categoryManagementMenu(Scanner scanner, CategoriesService categoriesService) throws SQLException {
        int choice;
        do {
            System.out.println("******************CATEGORIES MANAGEMENT*************");
            System.out.println("1. Hiển thị các danh mục");
            System.out.println("2. Hiển thị danh mục sắp xếp theo độ ưu tiên tăng dần");
            System.out.println("3. Thêm mới danh mục");
            System.out.println("4. Cập nhật danh mục");
            System.out.println("5. Xóa danh mục");
            System.out.println("6. Tìm kiếm danh mục theo tên");
            System.out.println("7. Cập nhật trạng thái danh mục");
            System.out.println("8. Thoát");
            System.out.print("Nhập lựa chọn của bạn: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1 ->
                    // Display categories
                        categoriesService.displayCategories();
                case 2 ->
                    // Display categories sorted by priority
                        categoriesService.showCateOrderByPriorityAsc();
                case 3 ->
                    // Add new category
                        categoriesService.addCategory(scanner);
                case 4 ->
                    // Update category
                        categoriesService.updateCategory(scanner);
                case 5 ->
                    // Delete category
                        categoriesService.deleteCategory(scanner);
                case 6 ->
                    // Search category by name
                        categoriesService.findCategoryByName(scanner);
                case 7 ->
                    // Update category status
                        categoriesService.updateStatus(scanner);
                case 8 -> System.out.println("Quay lại menu chính.");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn lại.");
            }
        } while (choice != 8);
    }

    private static void productManagementMenu(Scanner scanner, ProductService productService) throws SQLException {
        int choice;
        do {
            System.out.println("*******************PRODUCT MANAGEMENT***************");
            System.out.println("1. Hiển thị sản phẩm");
            System.out.println("2. Hiển thị sản phẩm theo giá giảm dần");
            System.out.println("3. Thêm mới sản phẩm");
            System.out.println("4. Cập nhật sản phẩm");
            System.out.println("5. Cập nhật trạng thái sản phẩm");
            System.out.println("6. Xóa sản phẩm");
            System.out.println("7. Tìm kiếm sản phẩm theo tên sản phẩm");
            System.out.println("8. Tìm kiếm sản phẩm trong khoảng giá a-b");
            System.out.println("9. Bán sản phẩm");
            System.out.println("10. Thoát");
            System.out.print("Nhập lựa chọn của bạn: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1 ->
                    // Display products
                        productService.displayProducts();
                case 2 ->
                    // Display products sorted by price descending
                        productService.displayProductsByPrice();
                case 3 ->
                    // Add new product
                        productService.addProduct(scanner);
                case 4 ->
                    // Update product
                        productService.updateProduct(scanner);
                case 5 ->
                    // Update product status
                        productService.updateProductStatus(scanner);
                case 6 ->
                    // Delete product
                        productService.deleteProduct(scanner);
                case 7 ->
                    // Search product by name
                        productService.searchProductByName(scanner);
                case 8 ->
                    // Search product by price range
                        productService.searchProductByPriceRange(scanner);
                case 9 ->
                    // Sell product
                        productService.sellProduct(scanner);
                case 10 -> System.out.println("Quay lại menu chính.");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn lại.");
            }
        } while (choice != 10);
    }

    private static void reportManagementMenu(Scanner scanner, ReportService reportService) throws SQLException {
        int choice;
        do {
            System.out.println("**********************REPORT MANAGEMENT**************");
            System.out.println("1. Thống kê số danh mục theo trạng thái danh mục");
            System.out.println("2. Thống kê số lượng sản phẩm theo trạng thái sản phẩm");
            System.out.println("3. Thống kê số lượng sản phẩm theo từng danh mục");
            System.out.println("4. Thoát");
            System.out.print("Nhập lựa chọn của bạn: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1 ->
                    // Report: Number of categories by category status
                        reportService.reportNumberOfCategoriesByCategoryStatus();
                case 2 ->
                    // Report: Number of products by product status
                        reportService.reportNumberOfProductsByProductStatus();
                case 3 ->
                    // Report: Number of products by each category
                        reportService.reportNumberOfProductsByEachCategory();
                case 4 -> System.out.println("Quay lại menu chính.");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn lại.");
            }
        } while (choice != 4);
    }

}
