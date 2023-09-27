package org.example.Service.Impl;

import org.example.Dao.ProductsDao;
import org.example.Service.ProductService;

import java.sql.SQLException;
import java.util.Scanner;

public class ProductServiceImpl implements ProductService {
    private final ProductsDao productsDao;
    public ProductServiceImpl(ProductsDao productsDao) {
        this.productsDao = productsDao;
    }

    @Override
    public void displayProducts() {
        try {
            productsDao.displayProducts();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void displayProductsByPrice() {
        try {
            productsDao.displayProductsByPrice();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addProduct(Scanner scanner) {
        try {
            productsDao.addProduct(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateProduct(Scanner scanner) {
        try {
            productsDao.updateProduct(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateProductStatus(Scanner scanner) {
        try {
            productsDao.updateProductStatus(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteProduct(Scanner scanner) {
        try {
            productsDao.deleteProduct(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void searchProductByName(Scanner scanner) {
        try {
            productsDao.searchProductByName(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void searchProductByPriceRange(Scanner scanner) {
        try {
            productsDao.searchProductByPriceRange(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void sellProduct(Scanner scanner) {
        try {
            productsDao.sellProduct(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
