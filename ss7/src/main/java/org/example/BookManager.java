package org.example;

import java.sql.*;
import java.util.Scanner;

public class BookManager {
    private static final String URL = "jdbc:mysql://localhost:3306/jdbc";
    private static final String USER = "root";
    private static final String PASSWORD = "thuong191020";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int choice;
        do {
            System.out.println("++++++++++ Menu ++++++++++");
            System.out.println("* 1.Hiển thị các sách");
            System.out.println("* 2.Thêm mới sách");
            System.out.println("* 3.Cập nhật sách");
            System.out.println("* 4.Xoá sách");
            System.out.println("* 5.Tìm sách theo tên sách");
            System.out.println("* 6.Thống kê sách theo tên tác giả");
            System.out.println("* 7.Xắp xếp sách theo giá tăng dần");
            System.out.println("* 8. Thoát");
            choice = scanner.nextInt();
            switch (choice) {
                case 1:
                    showBooks();
                    break;
                case 2:
                    addBook();
                    break;
                case 3:
                    updateBook();
                    break;
                case 4:
                    deleteBook();
                    break;
                case 5:
                    searchBookByName();
                    break;
                case 6:
                    statisticByAuthor();
                    break;
                case 7:
                    sortBooksByPrice();
                    break;
                case 8:
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice, please try again.");
            }
        } while (choice != 8);
    }

    private static void showBooks() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call ShowBooks()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // In thông tin sách
                System.out.println("ProductId: " + rs.getInt("ProductId"));
                System.out.println("ProductName: " + rs.getString("ProductName"));
                System.out.println("Author: " + rs.getString("Author"));
                System.out.println("Price: " + rs.getInt("Price"));
                System.out.println("-------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void addBook() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Scanner scanner = new Scanner(System.in);
             CallableStatement stmt = connection.prepareCall("{call AddBook(?, ?, ?, ?)}")) {
            Book book = new Book(scanner);
            book.inputData(scanner);
            // Nhập thông tin sách từ người dùng và thiết lập tham số
            stmt.setString(1, book.getBookName());
            stmt.setDouble(2, book.getPrice()); // Giá
            stmt.setString(3, book.getAuthor());
            stmt.setInt(4, book.getCatalogId()); // CatalogId

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void updateBook() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call UpdateBook(?, ?, ?, ?)}")) {

            // Nhập thông tin cần cập nhật từ người dùng và thiết lập tham số
            stmt.setInt(1, 1); // ProductId
            stmt.setString(2, "Tên Sách Mới");
            stmt.setInt(3, 12000); // Giá mới
            stmt.setString(4, "Tác Giả Mới");

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteBook() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call DeleteBook(?)}")) {

            stmt.setInt(1, 1); // ProductId

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void searchBookByName() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call SearchBookByName(?)}")) {

            // Nhập tên sách từ người dùng và thiết lập tham số
            stmt.setString(1, "Tên Sách");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // In thông tin sách tìm được
                System.out.println("ProductId: " + rs.getInt("ProductId"));
                System.out.println("ProductName: " + rs.getString("ProductName"));
                System.out.println("Author: " + rs.getString("Author"));
                System.out.println("Price: " + rs.getInt("Price"));
                System.out.println("-------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void statisticByAuthor() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call StatisticByAuthor()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // In kết quả thống kê
                System.out.println("Author: " + rs.getString("Author"));
                System.out.println("Number of Books: " + rs.getInt("NumberBooks"));
                System.out.println("-------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void sortBooksByPrice() {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             CallableStatement stmt = connection.prepareCall("{call SortBooksByPrice()}")) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // In thông tin sách theo thứ tự giá tăng dần
                System.out.println("ProductId: " + rs.getInt("ProductId"));
                System.out.println("ProductName: " + rs.getString("ProductName"));
                System.out.println("Author: " + rs.getString("Author"));
                System.out.println("Price: " + rs.getInt("Price"));
                System.out.println("-------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
