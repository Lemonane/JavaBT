package org.example.Dao;

import org.example.Model.Category;

import java.sql.*;
import java.util.Scanner;

public class CategoriesDao {
    private final Connection connection;

    public CategoriesDao(Connection connection) {
        this.connection = connection;
    }

    public void displayCategories() throws SQLException {
        String storedProc = "{call showCategories()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            // Thực thi stored procedure
            boolean hasResults = cs.execute();
            // Xử lý kết quả trả về nếu có
            while (hasResults) {
                try (ResultSet rs = cs.getResultSet()) {
                    while (rs.next()) {
                        // Hiển thị thông tin của từng danh mục
                        System.out.println("CatalogId: " + rs.getInt("CatalogId"));
                        System.out.println("CatalogName: " + rs.getString("CatalogName"));
                        System.out.println("Status: " + rs.getBoolean("CatalogStatus"));
                        System.out.println();
                    }
                }
                hasResults = cs.getMoreResults();
            }
        }
    }

    public void showCateOrderByPriorityAsc() throws SQLException {
        String storedProc = "{call showCateOrderByPriorityAsc()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            boolean hasResults = cs.execute();
            while (hasResults) {
                try (ResultSet rs = cs.getResultSet()) {
                    while (rs.next()) {
                        // Hiển thị thông tin của từng danh mục
                        System.out.println("CatalogId: " + rs.getInt("CatalogId"));
                        System.out.println("CatalogName: " + rs.getString("CatalogName"));
                        System.out.println("Status: " + rs.getBoolean("CatalogStatus"));
                        System.out.println();
                    }
                }
                hasResults = cs.getMoreResults();
            }
        }
    }

    public void addCategory(Scanner scanner) throws SQLException {
        String storedProc = "{call addCategory(?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            // Nhập dữ liệu cho danh mục
            Category category = new Category();
            category.inputData(scanner);

            // Thiết lập tham số cho stored procedure
            cs.setString(1, category.getCatalogName());
            cs.setInt(2, category.getPriority());

            // Thực thi stored procedure
            cs.execute();
        }
    }

    public void updateCategory(Scanner scanner) throws SQLException {
        String storedProc = "{call updateCategory(?,?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            System.out.println("Nhập id category cần update");
            int idUpdate = scanner.nextInt();
            scanner.nextLine();
            System.out.println("Nhập tên mới");
            String newName = scanner.nextLine();
            System.out.println("Nhập độ ưu tiên");
            int newPriority = scanner.nextInt();
            scanner.nextLine();
            cs.setInt(1, idUpdate);
            cs.setString(2, newName);
            cs.setInt(3, newPriority);
            // Thực thi stored procedure
            cs.execute();
        }
    }

    public void deleteCategory(Scanner scanner) throws SQLException {
        String storedProc = "{call deleteCategory(?,?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            System.out.println("Nhập id category để xoá");
            int inputId = scanner.nextInt();
            scanner.nextLine();

            cs.setInt(1, inputId);
            cs.registerOutParameter(2, Types.BOOLEAN);
            cs.registerOutParameter(3, Types.VARCHAR);

            cs.execute();

            String message = cs.getString(3);

            if (message != null) {
                System.out.println(message);
                return;
            }
            boolean isSuccess = cs.getBoolean(2);
            if (isSuccess) {
                System.out.println("Category đã được xoá thành công.");
            }
        }
    }

    public void findCategoryByName(Scanner scanner) throws SQLException {
        String storedProc = "{call findCategoryByName(?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            System.out.println("Nhập tên category : ");
            scanner.nextLine();
            String nameCate = scanner.nextLine();
            cs.setString(1,nameCate);
            try (ResultSet rs = cs.executeQuery()) {
                // Check if ResultSet có bất kì dòng nào k
                if (rs.next()) {
                    do {
                        int id = rs.getInt("CatalogId");
                        String name = rs.getString("CatalogName");
                        int priority = rs.getInt("Priority");
                        boolean status = rs.getBoolean("CatalogStatus");
                        System.out.println("ID: " + id + ", Name: "
                                + name + ", Priority: "
                                + priority + ", CatalogStatus: " + status);
                    } while (rs.next());
                } else {
                    System.out.println("Không tìm thấy category với tên: " + nameCate);
                }
            }
        }
    }
    public void updateStatus(Scanner scanner) throws SQLException {
        String storedProc = "{call updateCateStatus(?,?)}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            // Nhập cateId và newCatalogStatus từ người dùng
            System.out.println("Nhập id của category cần cập nhật trạng thái:");
            int cateId = scanner.nextInt();
            scanner.nextLine();
            System.out.println("Nhập trạng thái mới (1 cho true/active, 0 cho false/inactive):");
            boolean newCatalogStatus = scanner.nextInt() == 1;

            // Đặt tham số cho CallableStatement
            cs.setInt(1, cateId);
            cs.setBoolean(2, newCatalogStatus);

            // Thực thi CallableStatement
            cs.execute();

            // Kiểm tra số dòng bị ảnh hưởng và thông báo kết quả
            int rowsAffected = cs.getUpdateCount();
            if (rowsAffected > 0) {
                System.out.println("Trạng thái của category đã được cập nhật thành công.");
            } else {
                System.out.println("Không tồn tại category có id: " + cateId);
            }
        }
    }
}

