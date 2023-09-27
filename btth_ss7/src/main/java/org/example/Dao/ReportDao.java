package org.example.Dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReportDao {
    private final Connection connection;

    public ReportDao(Connection connection) {
        this.connection = connection;
    }

    public void reportNumberOfCategoriesByCategoryStatus() throws SQLException {
        String storedProc = "{call ReportNumberOfCategoriesByStatus()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            ResultSet rs = cs.executeQuery();
            System.out.println("CatalogStatus | NumberOfCategories");
            while (rs.next()) {
                boolean status = rs.getBoolean("CatalogStatus");
                int count = rs.getInt("NumberOfCategories");
                System.out.println(status + " | " + count);
            }
        }
    }

    public void reportNumberOfProductsByProductStatus() throws SQLException {
        String storedProc = "{call ReportNumberOfProductsByStatus()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            ResultSet rs = cs.executeQuery();
            System.out.println("ProductStatus | NumberOfProducts");
            while (rs.next()) {
                boolean status = rs.getBoolean("ProductStatus");
                int count = rs.getInt("NumberOfProducts");
                System.out.println(status + " | " + count);
            }
        }
    }

    public void reportNumberOfProductsByEachCategory() throws SQLException {
        String storedProc = "{call ReportNumberOfProductsByCategory()}";
        try (CallableStatement cs = connection.prepareCall(storedProc)) {
            ResultSet rs = cs.executeQuery();
            System.out.println("CatalogName | NumberOfProducts");
            while (rs.next()) {
                String catalogName = rs.getString("CatalogName");
                int count = rs.getInt("NumberOfProducts");
                System.out.println(catalogName + " | " + count);
            }
        }
    }
}
