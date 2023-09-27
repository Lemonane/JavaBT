package org.example.Service;

import java.util.Scanner;

public interface CategoriesService {
    // 1
    void displayCategories();

    // 2
    void showCateOrderByPriorityAsc();

    // 3
    void addCategory(Scanner scanner);

    // 4
    void updateCategory(Scanner scanner);

    // 5
    void deleteCategory(Scanner scanner);

    // 6
    void findCategoryByName(Scanner scanner);
    // 7
    void updateStatus(Scanner scanner);
}
