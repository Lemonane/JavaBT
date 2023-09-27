package org.example.Service.Impl;

import org.example.Dao.CategoriesDao;
import org.example.Service.CategoriesService;

import java.sql.SQLException;
import java.util.Scanner;

public class CategoriesServiceImpl implements CategoriesService {
    private final CategoriesDao categoriesDao;

    public CategoriesServiceImpl(CategoriesDao categoriesDao) {
        this.categoriesDao = categoriesDao;
    }

    @Override
    public void displayCategories() {
        try {
            categoriesDao.displayCategories();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void showCateOrderByPriorityAsc() {
        try {
            categoriesDao.showCateOrderByPriorityAsc();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addCategory(Scanner scanner) {
        try {
            categoriesDao.addCategory(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateCategory(Scanner scanner) {
        try {
            categoriesDao.updateCategory(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteCategory(Scanner scanner) {
        try {
            categoriesDao.deleteCategory(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void findCategoryByName(Scanner scanner) {
        try {
            categoriesDao.findCategoryByName(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateStatus(Scanner scanner) {
        try {
            categoriesDao.updateStatus(scanner);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
